Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89E92A8052
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 15:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgKEODe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 09:03:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:44876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730822AbgKEODe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:03:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DE01AAF1;
        Thu,  5 Nov 2020 14:03:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0C66A1E130F; Thu,  5 Nov 2020 15:03:32 +0100 (CET)
Date:   Thu, 5 Nov 2020 15:03:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        amir73il <amir73il@gmail.com>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        charliecgxu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH v2 5/8] ovl: mark overlayfs' inode dirty on shared
 writable mmap
Message-ID: <20201105140332.GG32718@quack2.suse.cz>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
 <20201025034117.4918-6-cgxu519@mykernel.net>
 <20201102173052.GF23988@quack2.suse.cz>
 <175931b5387.1349cecf47061.3904278910555065520@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175931b5387.1349cecf47061.3904278910555065520@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-11-20 19:54:03, Chengguang Xu wrote:
>  ---- 在 星期二, 2020-11-03 01:30:52 Jan Kara <jack@suse.cz> 撰写 ----
>  > On Sun 25-10-20 11:41:14, Chengguang Xu wrote:
>  > > Overlayfs cannot be notified when mmapped area gets dirty,
>  > > so we need to proactively mark inode dirty in ->mmap operation.
>  > > 
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > > ---
>  > >  fs/overlayfs/file.c | 4 ++++
>  > >  1 file changed, 4 insertions(+)
>  > > 
>  > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>  > > index efccb7c1f9bc..cd6fcdfd81a9 100644
>  > > --- a/fs/overlayfs/file.c
>  > > +++ b/fs/overlayfs/file.c
>  > > @@ -486,6 +486,10 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
>  > >          /* Drop reference count from new vm_file value */
>  > >          fput(realfile);
>  > >      } else {
>  > > +        if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE) &&
>  > > +            vma->vm_flags & (VM_WRITE|VM_MAYWRITE))
>  > > +            ovl_mark_inode_dirty(file_inode(file));
>  > > +
>  > 
>  > But does this work reliably? I mean once writeback runs, your inode (as
>  > well as upper inode) is cleaned. Then a page fault comes so file has dirty
>  > pages again and would need flushing but overlayfs inode stays clean? Am I
>  > missing something?
>  > 
> 
> Yeah, this is key point of this approach, in order to  fix the issue I
> explicitly set I_DIRTY_SYNC flag in ovl_mark_inode_dirty(), so what i
> mean is during writeback we will call into ->write_inode() by this
> flag(I_DIRTY_SYNC) and at that place we get chance to check mapping and
> re-dirty overlay's inode. The code logic like below in ovl_write_inode().
> 
>     if (mapping_writably_mapped(upper->i_mapping) ||
>          mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
>                  iflag |= I_DIRTY_PAGES; 

OK, but suppose the upper mapping is clean at this moment (upper inode has
been fully written out for whatever reason, but it is still mapped) so your
overlayfs inode becomes clean as well. Then I don't see a mechanism which
would make your overlayfs inode dirty again when a write to mmap happens,
set_page_dirty() will end up marking upper inode with I_DIRTY_PAGES flag.

Note that ovl_mmap() gets called only at mmap(2) syscall time but then
pages get faulted in, dirtied, cleaned fully at discretion of the mm
/ writeback subsystem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
