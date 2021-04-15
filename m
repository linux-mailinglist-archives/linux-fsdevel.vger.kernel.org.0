Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0736106C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhDOQvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOQvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:51:20 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA569C061574;
        Thu, 15 Apr 2021 09:50:57 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX5Ci-005Y53-1S; Thu, 15 Apr 2021 16:50:56 +0000
Date:   Thu, 15 Apr 2021 16:50:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru
Subject: Re: [PATCH RFC 1/6] dcache: sweep cached negative dentries to the
 end of list of siblings
Message-ID: <YHhu8PvSOkwkUqW7@zeniv-ca.linux.org.uk>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
 <1611235185-1685-2-git-send-email-gautham.ananthakrishna@oracle.com>
 <YHZa4PWnWfUqkARi@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHZa4PWnWfUqkARi@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 03:00:48AM +0000, Al Viro wrote:

> Ugh...  So when dput() drives the refcount down to 0 you hit lock_parent()
> and only then bother to check if the sucker had been negative in the first
                                              ^^^^^^^^^^^^^^^^^
                                              had zero refcount, of course.
> place?

> > @@ -1970,6 +2021,8 @@ void d_instantiate(struct dentry *entry, struct inode * inode)
> >  {
> >  	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
> >  	if (inode) {
> > +		if (d_is_tail_negative(entry))
> > +			recycle_negative(entry);
> >  		security_d_instantiate(entry, inode);
> >  		spin_lock(&inode->i_lock);
> >  		__d_instantiate(entry, inode);
> 
> Wait a bloody minute.  What about d_instantiate_new() right next to it?

Another fun question: where's the proof that __d_add(dentry, non_NULL_inode)
won't happen to dentry marked tail-negative?  From a quick grep I see at
least one such place - on success cifs_do_create() does
        d_drop(direntry);
	d_add(direntry, newinode);
and it would bloody well evade what you are doing in d_instantiate().
Same seems to be true for nfs_link()...
