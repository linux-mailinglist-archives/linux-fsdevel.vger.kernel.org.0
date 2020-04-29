Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A24A1BEA36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 23:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgD2VuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726775AbgD2VuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:50:11 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BDEC035494
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 14:50:10 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id x7so4198302qkb.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P4HtBjpSOsceKegug2sEdVIRavAA18N3gAKqWZxS3Rg=;
        b=TI7o13vZ0R4PIgdk5y6o23r6CG8YctneHrjonN+9jVFDJ8a0023jr599F8e7C/pCP1
         fL3VdXGkXbALChJNJ6t9m+IF3Wovo/x9/xrYX0g4YfMrgsQSVwwi23O/IaVGqNkQQ6h3
         x+0qrgSjRfFwRKbeWgXwjoMlqjH1lm4wAM3CELbCKXTiLq/swJ34pmCu23AMfL5Yjkgy
         2lr+IyuwfEsMfRYCu6HHrOrTyeTAAHhb+KjzIA+Iji3q7RLl2di8U0GeoekM5FEejqLO
         huXbxPxwrw4zSseLeMFqvnk/V1Q6Vuoaodwe0RRKcnawzra8PObdhok75bmLDdUPrs8e
         Ubdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P4HtBjpSOsceKegug2sEdVIRavAA18N3gAKqWZxS3Rg=;
        b=UhfJcQthhTuKTwqiA+0YbjjIZ6RFzXyGB7/3NVlDPc3dueV+FtZ4v7Rvidbxg8jHgE
         waRdHt4rvv3u5Z3aliAMM3bYXQHupt/aeYdOnL2gsbkcrx4VC9TwvkMAp/XTEJ+RcX4p
         Aqb+99yhrUvN2SfnyBk+OFSXVVd/BFf10iJZRHH73i5OQTxkET4hTUXjPFjdlnPC8F8X
         QwYllBdoYlILpL6vfUsz2exWUxiL3eRMuJYjDFy2ar0jAcsBv6vGLDNCraeSQbHWWT2w
         6xl53+BlLRWrPm9YRt2K87HMI/nQYWwaEWg7HXZ/QrFXwXVCx7mdD/Zv5Q/DhSoZ6XkN
         tVgw==
X-Gm-Message-State: AGi0Pua+FCGNBvzbz+QLh0egzZP4ELTeQn9eDHBdSKJ2N1tF/TXAnDuP
        3gzb4UtFceldBdkXrUZFQhm+6Zj03g==
X-Google-Smtp-Source: APiQypKMctOewJ3jBsbKHfX9HPIgYNkTG/naYrVaiwmZ+zyaqG0pLqe4doZmeqtJnRlWlz10BcfPBfAjMw==
X-Received: by 2002:a0c:ba83:: with SMTP id x3mr36580637qvf.83.1588197009264;
 Wed, 29 Apr 2020 14:50:09 -0700 (PDT)
Date:   Wed, 29 Apr 2020 23:49:49 +0200
Message-Id: <20200429214954.44866-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At the moment, we have that rather ugly mmget_still_valid() helper to
work around <https://crbug.com/project-zero/1790>: ELF core dumping
doesn't take the mmap_sem while traversing the task's VMAs, and if
anything (like userfaultfd) then remotely messes with the VMA tree,
fireworks ensue. So at the moment we use mmget_still_valid() to bail
out in any writers that might be operating on a remote mm's VMAs.

With this series, I'm trying to get rid of the need for that as
cleanly as possible.
In particular, I want to avoid holding the mmap_sem across unbounded
sleeps.


Patches 1, 2 and 3 are relatively unrelated cleanups in the core
dumping code.

Patches 4 and 5 implement the main change: Instead of repeatedly
accessing the VMA list with sleeps in between, we snapshot it at the
start with proper locking, and then later we just use our copy of
the VMA list. This ensures that the kernel won't crash, that VMA
metadata in the coredump is consistent even in the presence of
concurrent modifications, and that any virtual addresses that aren't
being concurrently modified have their contents show up in the core
dump properly.

The disadvantage of this approach is that we need a bit more memory
during core dumping for storing metadata about all VMAs.

After this series has landed, we should be able to rip out
mmget_still_valid().


Testing done so far:

 - Creating a simple core dump on X86-64 still works.
 - The created coredump on X86-64 opens in GDB, and both the stack and the
   exectutable look vaguely plausible.
 - 32-bit ARM compiles with FDPIC support, both with MMU and !MMU config.

I'm CCing some folks from the architectures that use FDPIC in case
anyone wants to give this a spin.


This series is based on
<https://lore.kernel.org/linux-fsdevel/20200427200626.1622060-1-hch@lst.de/>
(Christoph Hellwig's "remove set_fs calls from the coredump code v4").


changed in v2:
 - replace "Fix handling of partial writes in dump_emit()" with
   "Let dump_emit() bail out on short writes" (Linus)
 - get rid of the useless complicated cache flushing in
   "Take mmap_sem in get_dump_page()" (Linus)

Jann Horn (5):
  binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
  coredump: Let dump_emit() bail out on short writes
  coredump: Refactor page range dumping into common helper
  binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
  mm/gup: Take mmap_sem in get_dump_page()

 fs/binfmt_elf.c          | 170 ++++++++++++---------------------------
 fs/binfmt_elf_fdpic.c    | 106 +++++++++---------------
 fs/coredump.c            | 123 +++++++++++++++++++++++++---
 include/linux/coredump.h |  12 +++
 mm/gup.c                 |  60 +++++++-------
 5 files changed, 245 insertions(+), 226 deletions(-)


base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
prerequisite-patch-id: c0a20b414eebc48fe0a8ca570b05de34c7980396
prerequisite-patch-id: 51973b8db0fa4b114e0c3fd8936b634d9d5061c5
prerequisite-patch-id: 0e1e8de282ca6d458dc6cbdc6b6ec5879edd8a05
prerequisite-patch-id: d5ee749c4d3a22ec80bd0dd88aadf89aeb569db8
prerequisite-patch-id: 46ce14e59e98e212a1eca0aef69c6dcdb62b8242
-- 
2.26.2.526.g744177e7f7-goog

