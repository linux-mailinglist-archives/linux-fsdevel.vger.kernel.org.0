Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2930442079
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhKATIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhKATIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:08:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F9AC061714
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Nov 2021 12:05:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g14so5620258edz.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6V7Gw56j1fbOP3L/JmtSKoHD83KSTcHq7sV63glnuM=;
        b=V9CryaeGoSXaoWNsE+V00jDIPAmNV1syxOy51AzEYZDOm2hSiu8r86+/rVypbmV17c
         DIA2RfuwhJjEzuEEH0EdhVwygq0RtJRbjnQ0papVbpbz3wtQ/iQu2f/ZPqrDzZ1KOJKa
         JRNRsMnlO2JHvR4YOgQQgGsP8sitiDOXQLRdwwn4INumJS44SX3W2Hbrajw6JadDFiuM
         fHVXYeobtqBPr988Xt53NYAeGAPjtJwOUPtHVuu0/GLCd2vK7JWW73mhzNliL3Tyo3gx
         izH3YL9RFKHzPb3JeWJcTSScj2W7a3QHPA1ZH9PJiwaKzXEIlrv63jqDfNLmyJrr9eU/
         fGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6V7Gw56j1fbOP3L/JmtSKoHD83KSTcHq7sV63glnuM=;
        b=s3HWF1o+ZtLucYia/COQVLgZKJaZ9sYpZKBz3yIqy5Gm6d+5CsrPbJhQrVBnd4ABCH
         IJapHS2zDMkrRqx4wI41t/HRSq+87LxV6Gy0RrYPFpRsoFnRLSUy73QUC+EgX88vN3sg
         N+LIJSdoJnExH/Ewwfw4c1ZUZpsvhceepE1utpXPzLYHZDc+GMxmL3+11RrBBLN7/ctT
         8FwlDCH/h0hJOilsHjkROlzodnPgG8nYRsyWCz5B3h/cIz0keHm+oj5ltIcIXTphCgrf
         qs6387dKCdiOPMu37CulDuPo8wIepE3w/z3WIl2ZxX8iZiSkXg0Qv93sXX2gugW933KC
         OCoA==
X-Gm-Message-State: AOAM530GyYwe0mrM2RMWQJfrUvEu5zvAS1JZH3ZLSKB5I12nP3n9XEKX
        NS9WNtgeJTyiVQ2RG0citU4NIXNFNmG3sEZN5eSCoQ==
X-Google-Smtp-Source: ABdhPJwm9tqfzMwKrynpgXZqW17xbGvx5x4ZefxF1ARwrFkZgkhlyGDPME39ifBybz9u/RIFdwDlKH/D7dG3hxwvT38=
X-Received: by 2002:a17:907:76b0:: with SMTP id jw16mr15259982ejc.169.1635793545753;
 Mon, 01 Nov 2021 12:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
In-Reply-To: <20210930215311.240774-3-shy828301@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Nov 2021 00:35:34 +0530
Message-ID: <CA+G9fYs__zKSSLKPh4wEPSY5SH8QYkLzgd_3dJpMX72XxTfpdw@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Yang,

On Fri, 1 Oct 2021 at 03:23, Yang Shi <shy828301@gmail.com> wrote:
>
> When handling shmem page fault the THP with corrupted subpage could be PMD
> mapped if certain conditions are satisfied.  But kernel is supposed to
> send SIGBUS when trying to map hwpoisoned page.
>
> There are two paths which may do PMD map: fault around and regular fault.
>
> Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> the thing was even worse in fault around path.  The THP could be PMD mapped as
> long as the VMA fits regardless what subpage is accessed and corrupted.  After
> this commit as long as head page is not corrupted the THP could be PMD mapped.
>
> In the regular fault path the THP could be PMD mapped as long as the corrupted
> page is not accessed and the VMA fits.
>
> This loophole could be fixed by iterating every subpage to check if any
> of them is hwpoisoned or not, but it is somewhat costly in page fault path.
>
> So introduce a new page flag called HasHWPoisoned on the first tail page.  It
> indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
> is found hwpoisoned by memory failure and cleared when the THP is freed or
> split.
>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/page-flags.h | 19 +++++++++++++++++++
>  mm/filemap.c               | 12 ++++++------
>  mm/huge_memory.c           |  2 ++
>  mm/memory-failure.c        |  6 +++++-
>  mm/memory.c                |  9 +++++++++
>  mm/page_alloc.c            |  4 +++-
>  6 files changed, 44 insertions(+), 8 deletions(-)

When CONFIG_MEMORY_FAILURE not set
we get these build failures.

Regression found on x86_64 and i386 gcc-11 builds
Following build warnings / errors reported on Linux mainline master.

metadata:
    git_describe: v5.15-559-g19901165d90f
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    git_short_log: 19901165d90f (\"Merge tag
'for-5.16/inode-sync-2021-10-29' of git://git.kernel.dk/linux-block\")
    target_arch: x86_64
    toolchain: gcc-11


In file included from include/linux/mmzone.h:22,
                 from include/linux/gfp.h:6,
                 from include/linux/slab.h:15,
                 from include/linux/crypto.h:20,
                 from arch/x86/kernel/asm-offsets.c:9:
include/linux/page-flags.h:806:29: error: macro "PAGEFLAG_FALSE"
requires 2 arguments, but only 1 given
  806 | PAGEFLAG_FALSE(HasHWPoisoned)
      |                             ^
include/linux/page-flags.h:411: note: macro "PAGEFLAG_FALSE" defined here
  411 | #define PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname,
lname)   \
      |
include/linux/page-flags.h:807:39: error: macro "TESTSCFLAG_FALSE"
requires 2 arguments, but only 1 given
  807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
      |                                       ^
include/linux/page-flags.h:414: note: macro "TESTSCFLAG_FALSE" defined here
  414 | #define TESTSCFLAG_FALSE(uname, lname)
         \
      |
include/linux/page-flags.h:806:1: error: unknown type name 'PAGEFLAG_FALSE'
  806 | PAGEFLAG_FALSE(HasHWPoisoned)
      | ^~~~~~~~~~~~~~
include/linux/page-flags.h:807:25: error: expected ';' before 'static'
  807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
      |                         ^
      |                         ;
......
  815 | static inline bool is_page_hwpoison(struct page *page)
      | ~~~~~~
make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link:
-----------
https://builds.tuxbuild.com/20KPBpXK6K0bKSIKAIKfwlBq7O4/build.log

build config:
-------------
https://builds.tuxbuild.com/20KPBpXK6K0bKSIKAIKfwlBq7O4/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake

tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-11
--kconfig defconfig --kconfig-add
https://builds.tuxbuild.com/20KPBpXK6K0bKSIKAIKfwlBq7O4/config

link:
https://builds.tuxbuild.com/20KPBpXK6K0bKSIKAIKfwlBq7O4/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
