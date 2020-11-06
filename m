Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6782A91D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKFI4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:56:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:36220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgKFI4e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:56:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2547ABAE;
        Fri,  6 Nov 2020 08:56:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 937851E1312; Fri,  6 Nov 2020 09:50:23 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:50:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        miklos <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        charliecgxu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH v2 5/8] ovl: mark overlayfs' inode dirty on shared
 writable mmap
Message-ID: <20201106085023.GA25479@quack2.suse.cz>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
 <20201025034117.4918-6-cgxu519@mykernel.net>
 <20201102173052.GF23988@quack2.suse.cz>
 <175931b5387.1349cecf47061.3904278910555065520@mykernel.net>
 <20201105140332.GG32718@quack2.suse.cz>
 <CAOQ4uxiH+1rV9_hkjed2jt7YF0CMJJVa6Fc+kbzeTuMXYAQ8MQ@mail.gmail.com>
 <20201105155434.GI32718@quack2.suse.cz>
 <1759b6e6328.fdde3abc11178.4917086206975298767@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1759b6e6328.fdde3abc11178.4917086206975298767@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 06-11-20 10:41:44, Chengguang Xu wrote:
>  ---- 在 星期四, 2020-11-05 23:54:34 Jan Kara <jack@suse.cz> 撰写 ----
>  > On Thu 05-11-20 16:21:27, Amir Goldstein wrote:
>  > > On Thu, Nov 5, 2020 at 4:03 PM Jan Kara <jack@suse.cz> wrote:
>  > > >
>  > > > On Wed 04-11-20 19:54:03, Chengguang Xu wrote:
>  > > > >  ---- 在 星期二, 2020-11-03 01:30:52 Jan Kara <jack@suse.cz> 撰写 ----
>  > > > >  > On Sun 25-10-20 11:41:14, Chengguang Xu wrote:
>  > > > >  > > Overlayfs cannot be notified when mmapped area gets dirty,
>  > > > >  > > so we need to proactively mark inode dirty in ->mmap operation.
>  > > > >  > >
>  > > > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > > > >  > > ---
>  > > > >  > >  fs/overlayfs/file.c | 4 ++++
>  > > > >  > >  1 file changed, 4 insertions(+)
>  > > > >  > >
>  > > > >  > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>  > > > >  > > index efccb7c1f9bc..cd6fcdfd81a9 100644
>  > > > >  > > --- a/fs/overlayfs/file.c
>  > > > >  > > +++ b/fs/overlayfs/file.c
>  > > > >  > > @@ -486,6 +486,10 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
>  > > > >  > >          /* Drop reference count from new vm_file value */
>  > > > >  > >          fput(realfile);
>  > > > >  > >      } else {
>  > > > >  > > +        if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE) &&
>  > > > >  > > +            vma->vm_flags & (VM_WRITE|VM_MAYWRITE))
>  > > > >  > > +            ovl_mark_inode_dirty(file_inode(file));
>  > > > >  > > +
>  > > > >  >
>  > > > >  > But does this work reliably? I mean once writeback runs, your inode (as
>  > > > >  > well as upper inode) is cleaned. Then a page fault comes so file has dirty
>  > > > >  > pages again and would need flushing but overlayfs inode stays clean? Am I
>  > > > >  > missing something?
>  > > > >  >
>  > > > >
>  > > > > Yeah, this is key point of this approach, in order to  fix the issue I
>  > > > > explicitly set I_DIRTY_SYNC flag in ovl_mark_inode_dirty(), so what i
>  > > > > mean is during writeback we will call into ->write_inode() by this
>  > > > > flag(I_DIRTY_SYNC) and at that place we get chance to check mapping and
>  > > > > re-dirty overlay's inode. The code logic like below in ovl_write_inode().
>  > > > >
>  > > > >     if (mapping_writably_mapped(upper->i_mapping) ||
>  > > > >          mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
>  > > > >                  iflag |= I_DIRTY_PAGES;
>  > > >
>  > > > OK, but suppose the upper mapping is clean at this moment (upper inode has
>  > > > been fully written out for whatever reason, but it is still mapped) so your
>  > > > overlayfs inode becomes clean as well. Then I don't see a mechanism which
>  > > > would make your overlayfs inode dirty again when a write to mmap happens,
>  > > > set_page_dirty() will end up marking upper inode with I_DIRTY_PAGES flag.
>  > > >
>  > > > Note that ovl_mmap() gets called only at mmap(2) syscall time but then
>  > > > pages get faulted in, dirtied, cleaned fully at discretion of the mm
>  > > > / writeback subsystem.
>  > > >
>  > > 
>  > > Perhaps I will add some background.
>  > > 
>  > > What I suggested was to maintain a "suspect list" in addition to
>  > > the dirty ovl inodes.
>  > > 
>  > > ovl inode is added to the suspect list on mmap (writable) and removed
>  > > from the suspect list on release() flush() or on sync_fs() if real inode is no
>  > > longer writably mapped.
>  > > 
>  > > There was another variant where ovl inode is added to suspect list on open
>  > > for write and removed from suspect list on release() flush() or sync_fs()
>  > > if real inode is not inode_is_open_for_write().
>  > > 
>  > > In both cases the list will have inodes whose real is not dirty, but
>  > > in both cases
>  > > the list shouldn't be terribly large to traverse on sync_fs().
>  > > 
>  > > Chengguang tried to implement the idea without an actual list by
>  > > re-dirtying the "suspect" inodes on every write_inode(), but I personally have
>  > > no idea if his idea works.
>  > > 
>  > > I think we can resort to using an actual suspect list if you say that it
>  > > cannot work like this?
>  > 
>  > Yeah, the suspect list (i.e., additional list of inodes to check on sync)
>  > you describe should work fine. 
> 
> I think this solution still has the problem we have met in below thread[1]
> The main problem is the state combination of clean overlayfs' inode && dirty upper inode.

But I think the scheme Amir proposed and I detailed in my previous email
should prevent that state. Because while the inode is mapped, it will be
kept in the dirty list. So which scenario do you think would lead to clean
overlayfs inode and dirty upper inode?

> [1] https://www.spinics.net/lists/linux-unionfs/msg07448.html
> 
>  > Also the "keep suspect inode dirty" idea
>  > of Chengguang could work fine but we'd have to use something like
>  > inode_is_open_for_write() or inode_is_writeably_mapped() (which would need
>  > to be implemented but it should be easy vma_interval_tree_foreach() walk
>  > checking each found VMA for vma->vm_flags & VM_WRITE) for checking whether
>  > inode should be redirtied or not.
>  > 
> 
> I'm curious that isn't  it enough to check  i_mmap_writable by
> mapping_writably_mapped() ?  Am I missing something?

What is i_mmap_writeable? I've grepped the tree and didn't find anything
like that...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
