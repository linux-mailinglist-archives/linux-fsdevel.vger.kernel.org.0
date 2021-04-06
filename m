Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38C355AB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhDFRsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 13:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhDFRsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:48:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B80C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Apr 2021 10:48:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w28so24049679lfn.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Apr 2021 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOoUOFLQlh9034N4v2oxQm9jcLLVDu90iggICUK0ZwU=;
        b=Xj4N0+f8XD0nqzF0OAFU2U4HQQ/DjDUY32w6YY++lalFjLWRxLVEabRedpQUGzrwVz
         qr6s8T6wNbCAnllM9mSMDgF/j5vJ/z3Mt+U7cumXlq5uFuOTmSNVrJayVfpSunM0MdsM
         MMkQ4zfe7ZXBIyCKak30FfQSnxcti49a0sjbK0fRozzTFgQ/wWA3t/FXfxGMu1HiPuv9
         GrCO/COPrBeNLy67WEFaYAT3S/J6xW4BxND74LUJ1s0tqgPHWzDGW+Bgb/utlu2iGsiE
         wCiIprAwpb05wtwxed/3JLdUNbkLHR/66fUc8+kqC5JRyteVZ+TMO7bKCnn1Y+4xkc92
         z1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOoUOFLQlh9034N4v2oxQm9jcLLVDu90iggICUK0ZwU=;
        b=b0Rv3SAzBfLtGS9S/ra63Q9k1ap2obKZWWt4hFWdf7Ph680WFuURKz2w9kIASYqhqx
         9khwjdZGc7syBg7PiaFR5cuzw+5Ve5j2AbwecssswdrzXZIQlH7AyMuVG65NbfCUcRud
         gn/SvYuPhaZYOtxqr9Qce4WjN5QINNVJMCc0X7fwrc19sGM4nRHyPHUs+mRXOFjlOvPd
         wo4lZjQdyu5MGUcgtZgztd4t00ZLP0k8uykpuqOazpswo9JQfwGf4do2Kroi6K8CDVdc
         yaQwUzee1GH38FNYiIYyYQbg/yraf4flQGMjN1z3EjVH3WlvYdXr3CjLnMf892+cD2W0
         mZmQ==
X-Gm-Message-State: AOAM5320K2to/mHofyV314AcJovDag2cJRqkxFJX3VdEZQkQqLW2eaYp
        imy+s3iYL1Z371ePcHO2uKpue6hsigHphg9LsBRwrw==
X-Google-Smtp-Source: ABdhPJxDqtgpQyqgh72HvpE69l5zhTy4yTOsu9t6se5EOU92Iep9NLmH2O3TqOSCrYWSwyyZdbgKQKDddR6CrshbfB8=
X-Received: by 2002:a05:6512:11c2:: with SMTP id h2mr21959123lfr.94.1617731309356;
 Tue, 06 Apr 2021 10:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210322215823.962758-1-cfijalkovich@google.com>
 <CAL+PeoEpuOMOOL7=TTu7dKhHxO3Yb5CoTiMFeYGskx23bXkXhg@mail.gmail.com> <7CC369CF-66F6-4362-BCA8-0C1CAE350CDF@oracle.com>
In-Reply-To: <7CC369CF-66F6-4362-BCA8-0C1CAE350CDF@oracle.com>
From:   Collin Fijalkovich <cfijalkovich@google.com>
Date:   Tue, 6 Apr 2021 10:48:18 -0700
Message-ID: <CAL+PeoHrnVT5rFWxhShLPxQU_dgOqK24FCdcJ2s18596sS8jqw@mail.gmail.com>
Subject: Re: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on file-backed THPs
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Hugh Dickins <hughd@google.com>,
        Tim Murray <timmurray@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instrumenting filemap_nr_thps_inc() should be sufficient for ensuring
writable file mappings will not be THP-backed.

If filemap_nr_thps_dec() in unaccount_page_cache_page() and
filemap_nr_thps() in do_dentry_open() race, the worst case is an
unnecessary truncation. We could introduce a memory barrier in
unaccount_page_cache_page(), but I'm unsure it would significantly
mitigate the risk of spurious truncations. Barring synchronization
between do_dentry_open() and ongoing page cache operations, there
could be an in-progress delete_from_page_cache_batch() that has not
yet updated accounting for THPs in its targeted range.

-- Collin

On Mon, Apr 5, 2021 at 7:05 PM William Kucharski
<william.kucharski@oracle.com> wrote:
>
>
> I saw a similar change a few years ago with my prototype:
>
> https://lore.kernel.org/linux-mm/5BB682E1-DD52-4AA9-83E9-DEF091E0C709@oracle.com/
>
> the key being a very nice drop in iTLB-load-misses, so it looks like your code is
> having the right effect.
>
> What about the call to filemap_nr_thps_dec() in unaccount_page_cache_page() - does
> that need an smp_mb() as well?
>
> -- Bill
>
> > On Apr 5, 2021, at 6:15 PM, Collin Fijalkovich <cfijalkovich@google.com> wrote:
> >
> > v2 has been uploaded with performance testing results:
> > https://lore.kernel.org/patchwork/patch/1408266/
> >
> >
> >
> > On Mon, Mar 22, 2021 at 2:59 PM Collin Fijalkovich
> > <cfijalkovich@google.com> wrote:
> >>
> >> Transparent huge pages are supported for read-only non-shmem filesystems,
> >> but are only used for vmas with VM_DENYWRITE. This condition ensures that
> >> file THPs are protected from writes while an application is running
> >> (ETXTBSY).  Any existing file THPs are then dropped from the page cache
> >> when a file is opened for write in do_dentry_open(). Since sys_mmap
> >> ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
> >> produced by execve().
> >>
> >> Systems that make heavy use of shared libraries (e.g. Android) are unable
> >> to apply VM_DENYWRITE through the dynamic linker, preventing them from
> >> benefiting from the resultant reduced contention on the TLB.
> >>
> >> This patch reduces the constraint on file THPs allowing use with any
> >> executable mapping from a file not opened for write (see
> >> inode_is_open_for_write()). It also introduces additional conditions to
> >> ensure that files opened for write will never be backed by file THPs.
> >>
> >> Restricting the use of THPs to executable mappings eliminates the risk that
> >> a read-only file later opened for write would encounter significant
> >> latencies due to page cache truncation.
> >>
> >> The ld linker flag '-z max-page-size=(hugepage size)' can be used to
> >> produce executables with the necessary layout. The dynamic linker must
> >> map these file's segments at a hugepage size aligned vma for the mapping to
> >> be backed with THPs.
> >>
> >> Signed-off-by: Collin Fijalkovich <cfijalkovich@google.com>
> >> ---
> >> fs/open.c       | 13 +++++++++++--
> >> mm/khugepaged.c | 16 +++++++++++++++-
> >> 2 files changed, 26 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/open.c b/fs/open.c
> >> index e53af13b5835..f76e960d10ea 100644
> >> --- a/fs/open.c
> >> +++ b/fs/open.c
> >> @@ -852,8 +852,17 @@ static int do_dentry_open(struct file *f,
> >>         * XXX: Huge page cache doesn't support writing yet. Drop all page
> >>         * cache for this file before processing writes.
> >>         */
> >> -       if ((f->f_mode & FMODE_WRITE) && filemap_nr_thps(inode->i_mapping))
> >> -               truncate_pagecache(inode, 0);
> >> +       if (f->f_mode & FMODE_WRITE) {
> >> +               /*
> >> +                * Paired with smp_mb() in collapse_file() to ensure nr_thps
> >> +                * is up to date and the update to i_writecount by
> >> +                * get_write_access() is visible. Ensures subsequent insertion
> >> +                * of THPs into the page cache will fail.
> >> +                */
> >> +               smp_mb();
> >> +               if (filemap_nr_thps(inode->i_mapping))
> >> +                       truncate_pagecache(inode, 0);
> >> +       }
> >>
> >>        return 0;
> >>
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index a7d6cb912b05..4c7cc877d5e3 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -459,7 +459,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
> >>
> >>        /* Read-only file mappings need to be aligned for THP to work. */
> >>        if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> >> -           (vm_flags & VM_DENYWRITE)) {
> >> +           !inode_is_open_for_write(vma->vm_file->f_inode) &&
> >> +           (vm_flags & VM_EXEC)) {
> >>                return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> >>                                HPAGE_PMD_NR);
> >>        }
> >> @@ -1872,6 +1873,19 @@ static void collapse_file(struct mm_struct *mm,
> >>        else {
> >>                __mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
> >>                filemap_nr_thps_inc(mapping);
> >> +               /*
> >> +                * Paired with smp_mb() in do_dentry_open() to ensure
> >> +                * i_writecount is up to date and the update to nr_thps is
> >> +                * visible. Ensures the page cache will be truncated if the
> >> +                * file is opened writable.
> >> +                */
> >> +               smp_mb();
> >> +               if (inode_is_open_for_write(mapping->host)) {
> >> +                       result = SCAN_FAIL;
> >> +                       __mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr);
> >> +                       filemap_nr_thps_dec(mapping);
> >> +                       goto xa_locked;
> >> +               }
> >>        }
> >>
> >>        if (nr_none) {
> >> --
> >> 2.31.0.rc2.261.g7f71774620-goog
> >>
> >
>
