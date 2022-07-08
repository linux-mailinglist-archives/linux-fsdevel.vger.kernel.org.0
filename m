Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6556B47E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 10:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiGHI3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 04:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiGHI3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:29:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B033C76944
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 01:29:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71B5FB82558
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 08:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D91C341CA;
        Fri,  8 Jul 2022 08:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657268952;
        bh=3+lvg4yLRgKw0Av0KSsScOBtHId0AgBC8aS9mfOg6io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGkxqLWDM8MkbcVDWcZ8aYLEUbCFG4AIIr2KogDDfkwFpRUSa2/hHoYR61c9BrSGA
         Ldm5sJuQdg6JNeV0jsUIKevPJd1tomDhTREE5XUABv49xHHczWpJC04m5d8oserQzk
         3zDBaiJ06FyPH+tJa5JB92+vqyxPPaojAGiCdU2PQQgqCq15NjXNZBYj540mZ2oAu6
         L2juqbgGNgcSViV5R3dkCu2+TSgOa0IEkgXzWHQWxcPdnKt85g76ZQaoxHuhwpZYtP
         zNPqDaK75UPQ//QSdInfN4Zht5EabF9XWrdai65dHk7iSF7J7+ib4Q2Yrp0EVhg5DX
         42ngGb+GIHtVQ==
Date:   Fri, 8 Jul 2022 11:28:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] secretmem: fix unhandled fault in truncate
Message-ID: <Ysfqxg9Ury1NX27N@kernel.org>
References: <20220707165650.248088-1-rppt@kernel.org>
 <CAHbLzkqLPi9i3BspCLUe=eZ4huTY2ZnbfD19K_ShsaOC47En_w@mail.gmail.com>
 <YsdITMg5xZiu8Yoh@magnolia>
 <CAHbLzkpnkcFg5hOf49V=gFSvTWsWUe_M8-69knDpvSSdua+x4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpnkcFg5hOf49V=gFSvTWsWUe_M8-69knDpvSSdua+x4w@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:09:32PM -0700, Yang Shi wrote:
> On Thu, Jul 7, 2022 at 1:55 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Jul 07, 2022 at 10:48:00AM -0700, Yang Shi wrote:
> > > On Thu, Jul 7, 2022 at 9:57 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > Eric Biggers suggested that this happens when
> > > > secretmem_setattr()->simple_setattr() races with secretmem_fault() so
> > > > that a page that is faulted in by secretmem_fault() (and thus removed
> > > > from the direct map) is zeroed by inode truncation right afterwards.
> > > >
> > > > Since do_truncate() takes inode_lock(), adding inode_lock_shared() to
> > > > secretmem_fault() prevents the race.
> > >
> > > Should invalidate_lock be used to serialize between page fault and truncate?
> >
> > I would have thought so, given Documentation/filesystems/locking.rst:
> >
> > "->fault() is called when a previously not present pte is about to be
> > faulted in. The filesystem must find and return the page associated with
> > the passed in "pgoff" in the vm_fault structure. If it is possible that
> > the page may be truncated and/or invalidated, then the filesystem must
> > lock invalidate_lock, then ensure the page is not already truncated
> > (invalidate_lock will block subsequent truncate), and then return with
> > VM_FAULT_LOCKED, and the page locked. The VM will unlock the page."
> >
> > IIRC page faults aren't supposed to take i_rwsem because the fault could
> > be in response to someone mmaping a file into memory and then write()ing
> > to the same file using the mmapped region.  The write() takes
> > inode_lock and faults on the buffer, so the fault cannot take inode_lock
> > again.
> 
> Do you mean writing from one part of the file to the other part of the
> file so the "from" buffer used by copy_from_user() is part of the
> mmaped region?
> 
> Another possible deadlock issue by using inode_lock in page faults is
> mmap_lock is acquired before inode_lock, but write may acquire
> inode_lock before mmap_lock, it is a AB-BA lock pattern, but it should
> not cause real deadlock since mmap_lock is not exclusive for page
> faults. But such pattern should be avoided IMHO.
>
> > That said... I don't think memfd_secret files /can/ be written to?

memfd_secret files cannot be written to, they can only be mmap()ed.
Synchronization is only required between
do_truncate()->...->simple_setatt() and secretmem->fault() and I don't see
how that can deadlock.

I'm not an fs expert though, so if you think that invalidate_lock() is
safer, I don't mind s/inode_lock/invalidate_lock/ in the patch.

> > Hard to say, since I can't find a manpage describing what that syscall
> > does.

Right, I don't see it's published :-/

There is a groff version:
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/memfd_secret.2

> > --D
> >
> > >
> > > >
> > > > Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
> > > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > ---
> > > >
> > > > v2: use inode_lock_shared() rather than add a new rw_sem to secretmem
> > > >
> > > > Axel, I didn't add your Reviewed-by because v2 is quite different.
> > > >
> > > >  mm/secretmem.c | 21 ++++++++++++++++-----
> > > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > > > index 206ed6b40c1d..a4fabf705e4f 100644
> > > > --- a/mm/secretmem.c
> > > > +++ b/mm/secretmem.c
> > > > @@ -55,22 +55,28 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > > >         gfp_t gfp = vmf->gfp_mask;
> > > >         unsigned long addr;
> > > >         struct page *page;
> > > > +       vm_fault_t ret;
> > > >         int err;
> > > >
> > > >         if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > > >                 return vmf_error(-EINVAL);
> > > >
> > > > +       inode_lock_shared(inode);
> > > > +
> > > >  retry:
> > > >         page = find_lock_page(mapping, offset);
> > > >         if (!page) {
> > > >                 page = alloc_page(gfp | __GFP_ZERO);
> > > > -               if (!page)
> > > > -                       return VM_FAULT_OOM;
> > > > +               if (!page) {
> > > > +                       ret = VM_FAULT_OOM;
> > > > +                       goto out;
> > > > +               }
> > > >
> > > >                 err = set_direct_map_invalid_noflush(page);
> > > >                 if (err) {
> > > >                         put_page(page);
> > > > -                       return vmf_error(err);
> > > > +                       ret = vmf_error(err);
> > > > +                       goto out;
> > > >                 }
> > > >
> > > >                 __SetPageUptodate(page);
> > > > @@ -86,7 +92,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > > >                         if (err == -EEXIST)
> > > >                                 goto retry;
> > > >
> > > > -                       return vmf_error(err);
> > > > +                       ret = vmf_error(err);
> > > > +                       goto out;
> > > >                 }
> > > >
> > > >                 addr = (unsigned long)page_address(page);
> > > > @@ -94,7 +101,11 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > > >         }
> > > >
> > > >         vmf->page = page;
> > > > -       return VM_FAULT_LOCKED;
> > > > +       ret = VM_FAULT_LOCKED;
> > > > +
> > > > +out:
> > > > +       inode_unlock_shared(inode);
> > > > +       return ret;
> > > >  }
> > > >
> > > >  static const struct vm_operations_struct secretmem_vm_ops = {
> > > >
> > > > base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
> > > > --
> > > > 2.34.1
> > > >
> > > >

-- 
Sincerely yours,
Mike.
