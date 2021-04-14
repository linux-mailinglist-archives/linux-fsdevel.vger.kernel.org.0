Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C5E35EB81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 05:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhDNDli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 23:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbhDNDli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:41:38 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9798C061574;
        Tue, 13 Apr 2021 20:41:17 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWWOs-005BaA-Or; Wed, 14 Apr 2021 03:41:10 +0000
Date:   Wed, 14 Apr 2021 03:41:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru
Subject: Re: [PATCH RFC 1/6] dcache: sweep cached negative dentries to the
 end of list of siblings
Message-ID: <YHZkVlhchiNB9o18@zeniv-ca.linux.org.uk>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
 <1611235185-1685-2-git-send-email-gautham.ananthakrishna@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611235185-1685-2-git-send-email-gautham.ananthakrishna@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:49:40PM +0530, Gautham Ananthakrishna wrote:

> +static void sweep_negative(struct dentry *dentry)
> +{
> +	struct dentry *parent;
> +
> +	if (!d_is_tail_negative(dentry)) {
> +		parent = lock_parent(dentry);
> +		if (!parent)
> +			return;

Wait a minute.  It's not a good environment for calling lock_parent().
Who said that dentry won't get freed right under it?

Right now callers of __lock_parent() either hold a reference to dentry
*or* are called for a positive dentry, with inode->i_lock held.
You are introducing something very different - 

>  		if (likely(retain_dentry(dentry))) {
> +			if (d_is_negative(dentry))
> +				sweep_negative(dentry);
>  			spin_unlock(&dentry->d_lock);

Here we can be called for a negative dentry with refcount already *NOT*
held by us.  Look:

static inline struct dentry *lock_parent(struct dentry *dentry)
{
        struct dentry *parent = dentry->d_parent;
	if (IS_ROOT(dentry))
		return NULL;
isn't a root

	if (likely(spin_trylock(&parent->d_lock)))
		return parent;

no such luck - someone's already holding parent's ->d_lock

	return __lock_parent(dentry);
and here we have
static struct dentry *__lock_parent(struct dentry *dentry)
{
	struct dentry *parent;
	rcu_read_lock();  

OK, anything we see in its ->d_parent is guaranteed to stay
allocated until we get to matching rcu_read_unlock()

	spin_unlock(&dentry->d_lock);
dropped the spinlock, now it's fair game for d_move(), d_drop(), etc.

again:
	parent = READ_ONCE(dentry->d_parent);
dentry couldn't have been reused, so it's the last value stored there.
Points to still allocated struct dentry instance, so we can...

	spin_lock(&parent->d_lock);
grab its ->d_lock.

	/*
	 * We can't blindly lock dentry until we are sure
	 * that we won't violate the locking order.
	 * Any changes of dentry->d_parent must have
	 * been done with parent->d_lock held, so
	 * spin_lock() above is enough of a barrier
	 * for checking if it's still our child.
	 */
	if (unlikely(parent != dentry->d_parent)) {
		spin_unlock(&parent->d_lock);
		goto again;
	}
Nevermind, it's still equal to our ->d_parent.  So we have
the last valid parent's ->d_lock held

	rcu_read_unlock();
What's to hold dentry allocated now?  IF we held its refcount - no
problem, it can't go away.  If we held its ->d_inode->i_lock - ditto
(it wouldn't get to __dentry_kill() until we drop that, since all
callers do acquire that lock and it couldn't get scheduled for
freeing until it gets through most of __dentry_kill()).

IOW, we are free to grab dentry->d_lock again.
	if (parent != dentry)
		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
	else
		parent = NULL;
	return parent;
}

With your patch, though, you've got a call site where neither condition
is guaranteed.  Current kernel is fine - we are holding ->d_lock there,
and we don't touch dentry after it gets dropped.  Again, it can't get
scheduled for freeing until after we drop ->d_lock, so we are safe.
With that change, however, you've got a hard-to-hit memory corruptor
there...
