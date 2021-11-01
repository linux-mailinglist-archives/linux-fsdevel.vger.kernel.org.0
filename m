Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31844420D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 20:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhKAT3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 15:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhKAT3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:29:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED091C061714;
        Mon,  1 Nov 2021 12:26:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z20so68177252edc.13;
        Mon, 01 Nov 2021 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awRFGVO/gEQLPCvLdPa1TvcfMQKVkjzH/TfPshmvxyI=;
        b=obLOf3ccUIEXaH3sAXUGYjRIT2RizjEh57JWWlYoEQ2MDiQg/dK0ScmBgCXmvIR2zj
         OvLBsYIQ7Cb7n39G/MFxKf/nmMpeSswmlwUi0FeufAtgLT8o7WO6cwl7v4yZ0xV3bqEj
         6v+jgXo0JTVGlU8GCfVi9nedqqLpJv7GW7BQyQrTASf1/PPo1lV36mFyyhHRhLFY4PWO
         kMtnA6X8D/vqHDRLyy4zAWCAEV0JYScWYAoEYP5mCcWWE8sXPGf7uLtd6yLTlnyV9qRm
         dj6ZnxuqQH4yKs9vDnG4ZB8N9wTtcy1KxUa7eWv7pVFrEsUa7snwXYjFjrhv1lt6Pexv
         gc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awRFGVO/gEQLPCvLdPa1TvcfMQKVkjzH/TfPshmvxyI=;
        b=oCDooY1cvYpTpFCWGqWZQFYE9j7PKE1eYBXJBNZP7drfe/6ZzDUHQfiHAXuiEmHLca
         kZKLAnZi+9WfYjKr/XVsunXBqBEsHWrnpa8uXvs12YMdifUIp7I1ZV9nD8s/t7ayt1fW
         UQHW7EUxiErMSbM1cSKByvlejSa88YMX0f+LHV61A0KlSgmC2Lyd252IcHaiAupv3J22
         VLux3vt1W6W9Yex6oZECKYsYHkHvU2sT5+X22y8ldbeDfj2UHw5LvQ3Qc8yDqrdErm04
         MOiAKCKNVmfcogXVXv230rQMasifa9OAQS/EEEtb5SmGo0hZ6ZHfbzUZwad3nEB414mi
         ZI9g==
X-Gm-Message-State: AOAM531y3EgnazPjYA/LDjADCyw6M4N+Hc6vUzRNHCnI9TdGfrM0Tr/+
        OrHz/aeFiytB0vsVZ6VF8F8r8HytkDi2Ev0xDuiY180bWBg=
X-Google-Smtp-Source: ABdhPJycTYNHD7i+MZ1fe0HvWpmtzl4F1t05J0MIBxL8wQ86zQGqWVCKOVdJh8IsyRVnbaJIRmfrCZYEY10uDEIwVoI=
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr38815891ejc.555.1635794789559;
 Mon, 01 Nov 2021 12:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <CA+G9fYs__zKSSLKPh4wEPSY5SH8QYkLzgd_3dJpMX72XxTfpdw@mail.gmail.com>
In-Reply-To: <CA+G9fYs__zKSSLKPh4wEPSY5SH8QYkLzgd_3dJpMX72XxTfpdw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 1 Nov 2021 12:26:17 -0700
Message-ID: <CAHbLzkp1G1CFywC_=GJWDLN0hprxH3eayL8xxEMFQbFduwSSOQ@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 1, 2021 at 12:05 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Hi Yang,
>
> On Fri, 1 Oct 2021 at 03:23, Yang Shi <shy828301@gmail.com> wrote:
> >
> > When handling shmem page fault the THP with corrupted subpage could be PMD
> > mapped if certain conditions are satisfied.  But kernel is supposed to
> > send SIGBUS when trying to map hwpoisoned page.
> >
> > There are two paths which may do PMD map: fault around and regular fault.
> >
> > Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> > the thing was even worse in fault around path.  The THP could be PMD mapped as
> > long as the VMA fits regardless what subpage is accessed and corrupted.  After
> > this commit as long as head page is not corrupted the THP could be PMD mapped.
> >
> > In the regular fault path the THP could be PMD mapped as long as the corrupted
> > page is not accessed and the VMA fits.
> >
> > This loophole could be fixed by iterating every subpage to check if any
> > of them is hwpoisoned or not, but it is somewhat costly in page fault path.
> >
> > So introduce a new page flag called HasHWPoisoned on the first tail page.  It
> > indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
> > is found hwpoisoned by memory failure and cleared when the THP is freed or
> > split.
> >
> > Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> > Cc: <stable@vger.kernel.org>
> > Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/page-flags.h | 19 +++++++++++++++++++
> >  mm/filemap.c               | 12 ++++++------
> >  mm/huge_memory.c           |  2 ++
> >  mm/memory-failure.c        |  6 +++++-
> >  mm/memory.c                |  9 +++++++++
> >  mm/page_alloc.c            |  4 +++-
> >  6 files changed, 44 insertions(+), 8 deletions(-)
>
> When CONFIG_MEMORY_FAILURE not set
> we get these build failures.

Thanks for catching this. It is because Willy's page folio series
changed the definition of PAGEFLAG_FALSE macro. But patch was new in
5.15-rc7, so his series doesn't cover this.

The below patch should be able to fix it:

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d8623d6e1141..981341a3c3c4 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -803,8 +803,8 @@ PAGEFLAG_FALSE(DoubleMap, double_map)
 PAGEFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
        TESTSCFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
 #else
-PAGEFLAG_FALSE(HasHWPoisoned)
-       TESTSCFLAG_FALSE(HasHWPoisoned)
+PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
+       TESTSCFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
 #endif

 /*

I will prepare a formal patch for 5.16.

>
> Regression found on x86_64 and i386 gcc-11 builds
> Following build warnings / errors reported on Linux mainline master.
>
> metadata:
>     git_describe: v5.15-559-g19901165d90f
>     git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>     git_short_log: 19901165d90f (\"Merge tag
> 'for-5.16/inode-sync-2021-10-29' of git://git.kernel.dk/linux-block\")
>     target_arch: x86_64
>     toolchain: gcc-11
>
>
> In file included from include/linux/mmzone.h:22,
>                  from include/linux/gfp.h:6,
>                  from include/linux/slab.h:15,
>                  from include/linux/crypto.h:20,
>                  from arch/x86/kernel/asm-offsets.c:9:
> include/linux/page-flags.h:806:29: error: macro "PAGEFLAG_FALSE"
> requires 2 arguments, but only 1 given
>   806 | PAGEFLAG_FALSE(HasHWPoisoned)
>       |                             ^
> include/linux/page-flags.h:411: note: macro "PAGEFLAG_FALSE" defined here
>   411 | #define PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname,
> lname)   \
>       |
> include/linux/page-flags.h:807:39: error: macro "TESTSCFLAG_FALSE"
> requires 2 arguments, but only 1 given
>   807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
>       |                                       ^
> include/linux/page-flags.h:414: note: macro "TESTSCFLAG_FALSE" defined here
>   414 | #define TESTSCFLAG_FALSE(uname, lname)
>          \
>       |
> include/linux/page-flags.h:806:1: error: unknown type name 'PAGEFLAG_FALSE'
>   806 | PAGEFLAG_FALSE(HasHWPoisoned)
>       | ^~~~~~~~~~~~~~
> include/linux/page-flags.h:807:25: error: expected ';' before 'static'
>   807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
>       |                         ^
>       |                         ;
> ......
>   815 | static inline bool is_page_hwpoison(struct page *page)
>       | ~~~~~~
> make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> build link:
> -----------
> https://builds.tuxbuild.com/20KPBpXK6K0bKSIKAIKfwlBq7O4/build.log
>
> build config:
> -------------
> https://builds.tuxbuild.com/20KPBpXK6K0bKSIKAIKfwlBq7O4/config
>
> # To install tuxmake on your system globally
> # sudo pip3 install -U tuxmake
>
> tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-11
> --kconfig defconfig --kconfig-add
> https://builds.tuxbuild.com/20KPBpXK6K0bKSIKAIKfwlBq7O4/config
>
> link:
> https://builds.tuxbuild.com/20KPBpXK6K0bKSIKAIKfwlBq7O4/tuxmake_reproducer.sh
>
> --
> Linaro LKFT
> https://lkft.linaro.org
