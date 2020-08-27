Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50272548A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgH0PKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgH0Lt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:49:57 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3851AC061232
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:42 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id w26so1837861edq.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jJaArDC7TxiyWMPiHAEJ9CuiEBqX/dHACXSbOxkT4GQ=;
        b=Sx9t3jLt3fRnRVHI8AjMe0N0Y8tpQBiIeW/iTMoct+JVtMg/eqZ4rgqbZpnF95YgOg
         n65kn+hVVtVFi0kVyu/4dEOXAJ4G/INzK27uZrvVagFNapCeIv8N6I7LhET21HoFLJtC
         0F35yxOshCdncPGF4t7P90hW5b/EgubrWk3ZSrwar711eXJI4oTYk/PaUJ++U1k/DesV
         OMwQt31wHX1ywhRSddXdhAk60LoP09PP4p87vqy0sOaIVWdor/PH/JuzkiBpZi1W1JHO
         2Rk+VyCdbNfqpzTR4agPBOj6cYHuWwKwp3ru+gmgvHY4VOIrRBtYD3Lvc82o3sMPBGiM
         ghfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jJaArDC7TxiyWMPiHAEJ9CuiEBqX/dHACXSbOxkT4GQ=;
        b=lo3rScI9wxGW49f+NSiIuh5//2Nkc5OTuhxtTx5/RrD8Oj2L2V0i8XmBpaIGZMqOl8
         4bAF1XESxP/uUDFu0TbQRt8hCVMbKQaocctW/B7+mWYlAFYUoJNoGd1urE4VldlPlM8B
         pNLQnQ1Xy7FJchod6aJ064QOad9jB7D0+0Lr3/q0nLU9Xv78m7ns/QKr76iDtwJujboE
         iskxPNeYnz3qT/SgtvN+HZHt7pAOXmyusuyr0dPevBZTI+Lkzj9aDHrVdaX+0857qRcm
         IKrpkVlcE4eaM5Ox+C6ssm6zBRLZiRTkkBq06tYQ1maMeK9hE5IVS/l9+FZ5/3Yg7prT
         AfVA==
X-Gm-Message-State: AOAM533bjotVmyExBeIYjTZE1CUH4eHXXAQXHHnLIA5qFLYtpG6OmjAN
        DoPEQr79ckJFAWe9dMddzFJWidVaFA==
X-Google-Smtp-Source: ABdhPJyuC/6TjvHfRUNcOWTk00OeB8q/y6iWl4E7GC1dtm02wUVz+GY64yKhV19RjS+w4cHVnb96XCZ0tA==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:aa7:d6d9:: with SMTP id x25mr12155398edr.265.1598528980099;
 Thu, 27 Aug 2020 04:49:40 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:25 +0200
Message-Id: <20200827114932.3572699-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 0/7] Fix ELF / FDPIC ELF core dumping, and use mmap_lock
 properly in there
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

new in v5:
 - patches 1-3 and 6 are unchanged
 - added patch 4: rework vma_dump_size() into a common helper (Linus)
 - added patch 7: actually do the mmget_still_valid() removal (Linus)
 - for now, let dump_vma_snapshot() take the mmap_lock in write mode
   instead of read mode to avoid the data race with stack expansion

new in v4:
 - simplify patch 4/5 by replacing the heuristic for dumping the first
   pages of ELF mappings with what Linus suggested


At the moment, we have that rather ugly mmget_still_valid() helper to
work around <https://crbug.com/project-zero/1790>: ELF core dumping
doesn't take the mmap_sem while traversing the task's VMAs, and if
anything (like userfaultfd) then remotely messes with the VMA tree,
fireworks ensue. So at the moment we use mmget_still_valid() to bail
out in any writers that might be operating on a remote mm's VMAs.

With this series, I'm trying to get rid of the need for that as
cleanly as possible. ("cleanly" meaning "avoid holding the mmap_lock
across unbounded sleeps".)


Patches 1, 2, 3 and 4 are relatively unrelated cleanups in the core
dumping code.

Patches 5 and 6 implement the main change: Instead of repeatedly
accessing the VMA list with sleeps in between, we snapshot it at the
start with proper locking, and then later we just use our copy of
the VMA list. This ensures that the kernel won't crash, that VMA
metadata in the coredump is consistent even in the presence of
concurrent modifications, and that any virtual addresses that aren't
being concurrently modified have their contents show up in the core
dump properly.

The disadvantage of this approach is that we need a bit more memory
during core dumping for storing metadata about all VMAs.

At the end of the series, patch 7 removes the old workaround for
this issue (mmget_still_valid()).


I have tested:

 - Creating a simple core dump on X86-64 still works.
 - The created coredump on X86-64 opens in GDB and looks plausible.
 - X86-64 core dumps contain the first page for executable mappings at
   offset 0, and don't contain the first page for non-executable file
   mappings or executable mappings at offset !=0.
 - NOMMU 32-bit ARM can still generate plausible-looking core dumps
   through the FDPIC implementation. (I can't test this with GDB because
   GDB is missing some structure definition for nommu ARM, but I've
   poked around in the hexdump and it looked decent.)

Jann Horn (7):
  binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
  coredump: Let dump_emit() bail out on short writes
  coredump: Refactor page range dumping into common helper
  coredump: Rework elf/elf_fdpic vma_dump_size() into common helper
  binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
  mm/gup: Take mmap_lock in get_dump_page()
  mm: Remove the now-unnecessary mmget_still_valid() hack

 drivers/infiniband/core/uverbs_main.c |   3 -
 drivers/vfio/pci/vfio_pci.c           |  38 ++--
 fs/binfmt_elf.c                       | 238 +++-----------------------
 fs/binfmt_elf_fdpic.c                 | 162 +++---------------
 fs/coredump.c                         | 236 +++++++++++++++++++++++--
 fs/proc/task_mmu.c                    |  18 --
 fs/userfaultfd.c                      |  28 +--
 include/linux/coredump.h              |  11 ++
 include/linux/sched/mm.h              |  25 ---
 mm/gup.c                              |  61 +++----
 mm/khugepaged.c                       |   2 +-
 mm/madvise.c                          |  17 --
 mm/mmap.c                             |   5 +-
 13 files changed, 346 insertions(+), 498 deletions(-)


base-commit: 06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
-- 
2.28.0.297.g1956fa8f8d-goog

