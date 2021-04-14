Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8EE35EB2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 05:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhDNDBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 23:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhDNDBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:01:11 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A42C061574;
        Tue, 13 Apr 2021 20:00:50 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWVlo-005BFK-Gg; Wed, 14 Apr 2021 03:00:48 +0000
Date:   Wed, 14 Apr 2021 03:00:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru
Subject: Re: [PATCH RFC 1/6] dcache: sweep cached negative dentries to the
 end of list of siblings
Message-ID: <YHZa4PWnWfUqkARi@zeniv-ca.linux.org.uk>
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
> From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> For disk filesystems result of every negative lookup is cached, content of
> directories is usually cached too. Production of negative dentries isn't
> limited with disk speed. It's really easy to generate millions of them if
> system has enough memory. Negative dentries are linked into siblings list
> along with normal positive dentries. Some operations walks dcache tree but
> looks only for positive dentries: most important is fsnotify/inotify.
> 
> This patch moves negative dentries to the end of list at final dput() and
> marks with flag which tells that all following dentries are negative too.
> Reverse operation is required before instantiating negative dentry.

> +static void sweep_negative(struct dentry *dentry)
> +{
> +	struct dentry *parent;
> +
> +	if (!d_is_tail_negative(dentry)) {
> +		parent = lock_parent(dentry);
> +		if (!parent)
> +			return;
> +
> +		if (!d_count(dentry) && d_is_negative(dentry) &&
> +		    !d_is_tail_negative(dentry)) {
> +			dentry->d_flags |= DCACHE_TAIL_NEGATIVE;
> +			list_move_tail(&dentry->d_child, &parent->d_subdirs);
> +		}
> +
> +		spin_unlock(&parent->d_lock);
> +	}
> +}

Ugh...  So when dput() drives the refcount down to 0 you hit lock_parent()
and only then bother to check if the sucker had been negative in the first
place?

> @@ -1970,6 +2021,8 @@ void d_instantiate(struct dentry *entry, struct inode * inode)
>  {
>  	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
>  	if (inode) {
> +		if (d_is_tail_negative(entry))
> +			recycle_negative(entry);
>  		security_d_instantiate(entry, inode);
>  		spin_lock(&inode->i_lock);
>  		__d_instantiate(entry, inode);

Wait a bloody minute.  What about d_instantiate_new() right next to it?
