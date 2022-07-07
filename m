Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7208056AE1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 00:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiGGWJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 18:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGGWJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:09:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D171F2C0
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jul 2022 15:09:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id r1so14821837plo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jul 2022 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiKzxxQq+e2peVSgseIuQeYKf8iC8MiiAaC/vEMci1U=;
        b=RN49uaXs7amTDQLs6qAy+di2sdSsChOURTrpBIUf9KdE0R2KO2rUGUZRA/bXnCthZN
         /PMGeaka3SlU/70fn57ECamlKQxTGp4U1TRI0b962fZSUzUvCfIH6ADjIlIxLYATgsfo
         b6AFH96hzw4VKne1ooduLLbmE18pmBV9v6v5VszJWuDS4v5g4S8mG8lBKi8FTiY106SE
         kZSEAulT8N+M+2XwHw0XxkG6dxYkIDs+iD+3FTewKe5K8W+D5jFy3D9vBfGRtL2SlNUe
         HWaJ2TYCw7G+BZjNv39x0q1Pwfzchs+8peU3LbXw3C29xeo7y67gYy5jXWwVdc1Of3gr
         D4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiKzxxQq+e2peVSgseIuQeYKf8iC8MiiAaC/vEMci1U=;
        b=g+p48uQTDzdaQeumIrFnYt90sYhtRXfuMXEikYzTX91pPrwNz9rBhU0dK6Tt//gLN8
         hcRHa4d+EpR6S0iS+N06vLziDS+LcvRbNrnxpoMU9odk3hSvpeWCKHW+xh7yc3VHa2NY
         yWt0kF/DW3vEBhmhQE8r9d9KsPeCXjp8KO7flqsr8NpBHYnFvzadRMs8SNr9rRiOYiOw
         2JB1bR+pjQa+VZcW40Iij0zRu+4bAYj0qiQ86BatN2YUoaS0Io+OXiL3NovcsdKy/gbk
         VnZGDM99WGVEhIFWtcB9W4SoMknJMFXrmdi7pswONnsReVVqz3CAem/mwdMfvFLj+f7w
         2FVg==
X-Gm-Message-State: AJIora+Htrwie8l6Lsu/ywz9QFWkBUBpiMeNwEXPiSEfMXtGR/Q3emBx
        atoBYBW54qkhTWwAPCoZfrZ35PzpCj8mLzn/bwo=
X-Google-Smtp-Source: AGRyM1su2Q9NtDCHaCaKx1bubaW/lXjKHjJn7VoibPxKdaj3KLB5RDOUyLQxSpnq/jW4E/qtyVplXtu7guDpXuVgAQ0=
X-Received: by 2002:a17:903:2405:b0:16a:8010:1e16 with SMTP id
 e5-20020a170903240500b0016a80101e16mr286315plo.87.1657231786005; Thu, 07 Jul
 2022 15:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220707165650.248088-1-rppt@kernel.org> <CAHbLzkqLPi9i3BspCLUe=eZ4huTY2ZnbfD19K_ShsaOC47En_w@mail.gmail.com>
 <YsdITMg5xZiu8Yoh@magnolia>
In-Reply-To: <YsdITMg5xZiu8Yoh@magnolia>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 7 Jul 2022 15:09:32 -0700
Message-ID: <CAHbLzkpnkcFg5hOf49V=gFSvTWsWUe_M8-69knDpvSSdua+x4w@mail.gmail.com>
Subject: Re: [PATCH v2] secretmem: fix unhandled fault in truncate
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 7, 2022 at 1:55 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Jul 07, 2022 at 10:48:00AM -0700, Yang Shi wrote:
> > On Thu, Jul 7, 2022 at 9:57 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > syzkaller reports the following issue:
> > >
> > > BUG: unable to handle page fault for address: ffff888021f7e005
> > > PGD 11401067 P4D 11401067 PUD 11402067 PMD 21f7d063 PTE 800fffffde081060
> > > Oops: 0002 [#1] PREEMPT SMP KASAN
> > > CPU: 0 PID: 3761 Comm: syz-executor281 Not tainted 5.19.0-rc4-syzkaller-00014-g941e3e791269 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:64
> > > Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
> > > RSP: 0018:ffffc9000329fa90 EFLAGS: 00010202
> > > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000ffb
> > > RDX: 0000000000000ffb RSI: 0000000000000000 RDI: ffff888021f7e005
> > > RBP: ffffea000087df80 R08: 0000000000000001 R09: ffff888021f7e005
> > > R10: ffffed10043efdff R11: 0000000000000000 R12: 0000000000000005
> > > R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000ffb
> > > FS:  00007fb29d8b2700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: ffff888021f7e005 CR3: 0000000026e7b000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  zero_user_segments include/linux/highmem.h:272 [inline]
> > >  folio_zero_range include/linux/highmem.h:428 [inline]
> > >  truncate_inode_partial_folio+0x76a/0xdf0 mm/truncate.c:237
> > >  truncate_inode_pages_range+0x83b/0x1530 mm/truncate.c:381
> > >  truncate_inode_pages mm/truncate.c:452 [inline]
> > >  truncate_pagecache+0x63/0x90 mm/truncate.c:753
> > >  simple_setattr+0xed/0x110 fs/libfs.c:535
> > >  secretmem_setattr+0xae/0xf0 mm/secretmem.c:170
> > >  notify_change+0xb8c/0x12b0 fs/attr.c:424
> > >  do_truncate+0x13c/0x200 fs/open.c:65
> > >  do_sys_ftruncate+0x536/0x730 fs/open.c:193
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > RIP: 0033:0x7fb29d900899
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007fb29d8b2318 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> > > RAX: ffffffffffffffda RBX: 00007fb29d988408 RCX: 00007fb29d900899
> > > RDX: 00007fb29d900899 RSI: 0000000000000005 RDI: 0000000000000003
> > > RBP: 00007fb29d988400 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb29d98840c
> > > R13: 00007ffca01a23bf R14: 00007fb29d8b2400 R15: 0000000000022000
> > >  </TASK>
> > > Modules linked in:
> > > CR2: ffff888021f7e005
> > > ---[ end trace 0000000000000000 ]---
> > >
> > > Eric Biggers suggested that this happens when
> > > secretmem_setattr()->simple_setattr() races with secretmem_fault() so
> > > that a page that is faulted in by secretmem_fault() (and thus removed
> > > from the direct map) is zeroed by inode truncation right afterwards.
> > >
> > > Since do_truncate() takes inode_lock(), adding inode_lock_shared() to
> > > secretmem_fault() prevents the race.
> >
> > Should invalidate_lock be used to serialize between page fault and truncate?
>
> I would have thought so, given Documentation/filesystems/locking.rst:
>
> "->fault() is called when a previously not present pte is about to be
> faulted in. The filesystem must find and return the page associated with
> the passed in "pgoff" in the vm_fault structure. If it is possible that
> the page may be truncated and/or invalidated, then the filesystem must
> lock invalidate_lock, then ensure the page is not already truncated
> (invalidate_lock will block subsequent truncate), and then return with
> VM_FAULT_LOCKED, and the page locked. The VM will unlock the page."
>
> IIRC page faults aren't supposed to take i_rwsem because the fault could
> be in response to someone mmaping a file into memory and then write()ing
> to the same file using the mmapped region.  The write() takes
> inode_lock and faults on the buffer, so the fault cannot take inode_lock
> again.

Do you mean writing from one part of the file to the other part of the
file so the "from" buffer used by copy_from_user() is part of the
mmaped region?

Another possible deadlock issue by using inode_lock in page faults is
mmap_lock is acquired before inode_lock, but write may acquire
inode_lock before mmap_lock, it is a AB-BA lock pattern, but it should
not cause real deadlock since mmap_lock is not exclusive for page
faults. But such pattern should be avoided IMHO.

>
> That said... I don't think memfd_secret files /can/ be written to?  Hard
> to say, since I can't find a manpage describing what that syscall does.
>
> --D
>
> >
> > >
> > > Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
> > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >
> > > v2: use inode_lock_shared() rather than add a new rw_sem to secretmem
> > >
> > > Axel, I didn't add your Reviewed-by because v2 is quite different.
> > >
> > >  mm/secretmem.c | 21 ++++++++++++++++-----
> > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > > index 206ed6b40c1d..a4fabf705e4f 100644
> > > --- a/mm/secretmem.c
> > > +++ b/mm/secretmem.c
> > > @@ -55,22 +55,28 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > >         gfp_t gfp = vmf->gfp_mask;
> > >         unsigned long addr;
> > >         struct page *page;
> > > +       vm_fault_t ret;
> > >         int err;
> > >
> > >         if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > >                 return vmf_error(-EINVAL);
> > >
> > > +       inode_lock_shared(inode);
> > > +
> > >  retry:
> > >         page = find_lock_page(mapping, offset);
> > >         if (!page) {
> > >                 page = alloc_page(gfp | __GFP_ZERO);
> > > -               if (!page)
> > > -                       return VM_FAULT_OOM;
> > > +               if (!page) {
> > > +                       ret = VM_FAULT_OOM;
> > > +                       goto out;
> > > +               }
> > >
> > >                 err = set_direct_map_invalid_noflush(page);
> > >                 if (err) {
> > >                         put_page(page);
> > > -                       return vmf_error(err);
> > > +                       ret = vmf_error(err);
> > > +                       goto out;
> > >                 }
> > >
> > >                 __SetPageUptodate(page);
> > > @@ -86,7 +92,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > >                         if (err == -EEXIST)
> > >                                 goto retry;
> > >
> > > -                       return vmf_error(err);
> > > +                       ret = vmf_error(err);
> > > +                       goto out;
> > >                 }
> > >
> > >                 addr = (unsigned long)page_address(page);
> > > @@ -94,7 +101,11 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > >         }
> > >
> > >         vmf->page = page;
> > > -       return VM_FAULT_LOCKED;
> > > +       ret = VM_FAULT_LOCKED;
> > > +
> > > +out:
> > > +       inode_unlock_shared(inode);
> > > +       return ret;
> > >  }
> > >
> > >  static const struct vm_operations_struct secretmem_vm_ops = {
> > >
> > > base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
> > > --
> > > 2.34.1
> > >
> > >
