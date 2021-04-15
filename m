Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5264F361015
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhDOQZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhDOQZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:25:33 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A877C061574;
        Thu, 15 Apr 2021 09:25:10 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX4nh-005Xmq-I8; Thu, 15 Apr 2021 16:25:05 +0000
Date:   Thu, 15 Apr 2021 16:25:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru
Subject: Re: [PATCH RFC 1/6] dcache: sweep cached negative dentries to the
 end of list of siblings
Message-ID: <YHho4TKjqYNmMy6W@zeniv-ca.linux.org.uk>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
 <1611235185-1685-2-git-send-email-gautham.ananthakrishna@oracle.com>
 <YHZkVlhchiNB9o18@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHZkVlhchiNB9o18@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 03:41:10AM +0000, Al Viro wrote:

> > +	if (!d_is_tail_negative(dentry)) {
> > +		parent = lock_parent(dentry);
> > +		if (!parent)
> > +			return;
> 
> Wait a minute.  It's not a good environment for calling lock_parent().
> Who said that dentry won't get freed right under it?

[snip]

FWIW, in that state (dentry->d_lock held) we have
	* stable ->d_flags
	* stable ->d_count
	* stable ->d_inode
IOW, we can bloody well check ->d_count *before* bothering with lock_parent().
It does not get rid of the problems with lifetimes, though.  We could
do something along the lines of

	rcu_read_lock()
	if retain_dentry()
		parent = NULL
		if that dentry might need to be moved in list
			parent = lock_parent()
			// if reached __dentry_kill(), d_count() will be -128,
			// so the check below will exclude those
			if that dentry does need to be moved
				move it to the end of list
		unlock dentry and parent (if any)
		rcu_read_unlock()
		return
here, but your other uses of lock_parent() also need attention.  And
recursive call of dput() in trim_negative() (#6/6) is really asking
for trouble.
