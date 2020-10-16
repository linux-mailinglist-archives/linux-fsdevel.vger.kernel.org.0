Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C911F2901C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395234AbgJPJWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 05:22:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395230AbgJPJWv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:22:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F9E4AEA2;
        Fri, 16 Oct 2020 09:22:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 71F2A1E133E; Fri, 16 Oct 2020 11:22:48 +0200 (CEST)
Date:   Fri, 16 Oct 2020 11:22:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, amir73il <amir73il@gmail.com>,
        jack <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
Message-ID: <20201016092248.GK7037@quack2.suse.cz>
References: <20201010142355.741645-1-cgxu519@mykernel.net>
 <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201015032501.GO3576660@ZenIV.linux.org.uk>
 <1752a5a7164.e9a05b8943438.8099134270028614634@mykernel.net>
 <20201015045741.GP3576660@ZenIV.linux.org.uk>
 <175303e1d27.105ba43f146287.2025735092350714226@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175303e1d27.105ba43f146287.2025735092350714226@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 16-10-20 15:09:38, Chengguang Xu wrote:
>  ---- 在 星期四, 2020-10-15 12:57:41 Al Viro <viro@zeniv.linux.org.uk> 撰写 ----
>  > On Thu, Oct 15, 2020 at 11:42:51AM +0800, Chengguang Xu wrote:
>  > >  ---- 在 星期四, 2020-10-15 11:25:01 Al Viro <viro@zeniv.linux.org.uk> 撰写 ----
>  > >  > On Sat, Oct 10, 2020 at 10:23:51PM +0800, Chengguang Xu wrote:
>  > >  > > Currently there is no notification api for kernel about modification
>  > >  > > of vfs inode, in some use cases like overlayfs, this kind of notification
>  > >  > > will be very helpful to implement containerized syncfs functionality.
>  > >  > > As the first attempt, we introduce marking inode dirty notification so that
>  > >  > > overlay's inode could mark itself dirty as well and then only sync dirty
>  > >  > > overlay inode while syncfs.
>  > >  > 
>  > >  > Who's responsible for removing the crap from notifier chain?  And how does
>  > >  > that affect the lifetime of inode?
>  > >  
>  > > In this case, overlayfs unregisters call back from the notifier chain of upper inode
>  > > when evicting it's own  inode. It will not affect the lifetime of upper inode because
>  > > overlayfs inode holds a reference of upper inode that means upper inode will not be
>  > > evicted while overlayfs inode is still alive.
>  > 
>  > Let me see if I've got it right:
>  >     * your chain contains 1 (for upper inodes) or 0 (everything else, i.e. the
>  > vast majority of inodes) recepients
>  >     * recepient pins the inode for as long as the recepient exists
>  > 
>  > That looks like a massive overkill, especially since all you are propagating is
>  > dirtying the suckers.  All you really need is one bit in your inode + hash table
>  > indexed by the address of struct inode (well, middle bits thereof, as usual).
>  > With entries embedded into overlayfs-private part of overlayfs inode.  And callback
>  > to be called stored in that entry...
>  > 
> 
> Hi AI, Jack, Amir
> 
> Based on your feedback, I would to change the inode dirty notification
> something like below, is it acceptable? 
> 
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 1492271..48473d9 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2249,6 +2249,14 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  
>         trace_writeback_mark_inode_dirty(inode, flags);
>  
> +       if (inode->state & I_OVL_INUSE) {
> +               struct inode *ovl_inode;
> +
> +               ovl_inode = ilookup5(NULL, (unsigned long)inode, ovl_inode_test, inode);

I don't think this will work - superblock pointer is part of the hash value
inode is hashed with so without proper sb pointer you won't find proper
hash chain.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
