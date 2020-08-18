Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC62247E4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 08:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgHRGMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 02:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHRGMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:12:48 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF00C061389
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:47 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id v11so7419592edr.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eFG3+ZU04dg7j/n8RQMsX5KJHQEOve2F0DGeAT5bRdQ=;
        b=lyPvpxTAYkmA1z+nQG0Kuj8CGkbqhbEixqfs7MpHSSXUBLVcJi6NLxh/KEhmQL5EH7
         5LSouC2V3yBab61eAHZyRvORAUg5Be9pSM+3L3iUKRgDm6Mht1H4yvISTZ0Ww03gpvdg
         pnVXfrkIqkKKPA6Kdb1H+YIfNpae2jXeKun5A+WYPF6E9AF4vTnFoEs9MtZZqYuyqUoG
         /O9iGZrtwqIJ4vBGeVgVfTjOsU2HyLOMVEYbXkMZdWfbUSDhXrtKg1BKoyYesGENNP4o
         h9VEoWGepxLcXumVisMg6kou8lmk28WgL62sHFtT2pC/3sWTKoXMY3O1d5+rjCTOUoAb
         /vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eFG3+ZU04dg7j/n8RQMsX5KJHQEOve2F0DGeAT5bRdQ=;
        b=ZVPeoa0aYfXXixo4jUAusJ/TpUl9jyOs40QSXvZotiWPaaGfLK0aYhTugn+tVqS24N
         o5Mw/RtQIErMDYpPNjOMcRAl6Vm8Unkj8o8XjwIRvoFTBIMRAMc18kN85Wgv30fifAg7
         NIRO1xMxfVEFms5ZOuJfbCY0XFjhH0MiI90Q8Hl2uiJqP4FIwyFrAlheMzKmopWbnMzE
         fe7t1vuCVrjgoRtFS4MbeEpFIuBfKslior0kndfXcdAp//Aob3SUsABDO98DSYpaQ3eh
         NuGL7LO3bVrE7h+9dUbA5aWDEYSpAhCHTItWILDrj7xJ9Rwm5t81ahHqqL71pb16tpWW
         j1MA==
X-Gm-Message-State: AOAM531jyT3T0YX2BRvtZuUJEGTsuKmjot6uP9qF9rh1LA4gCZFb6JOM
        Rr8d7YPuUEIvxphn+fJ/4/PrJQWs9w==
X-Google-Smtp-Source: ABdhPJx/znTRf5ONMvee2ts2374fyNiuRaF1EBB88UBg4JiH+0EZjiz4EMZMQwRCBdDWPBloMOlMMnRJdw==
X-Received: by 2002:a05:6402:1ca6:: with SMTP id cz6mr17981292edb.310.1597731166134;
 Mon, 17 Aug 2020 23:12:46 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:12:34 +0200
Message-Id: <20200818061239.29091-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_lock
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

At the moment, we have that rather ugly mmget_still_valid() helper to
work around <https://crbug.com/project-zero/1790>: ELF core dumping
doesn't take the mmap_sem while traversing the task's VMAs, and if
anything (like userfaultfd) then remotely messes with the VMA tree,
fireworks ensue. So at the moment we use mmget_still_valid() to bail
out in any writers that might be operating on a remote mm's VMAs.

With this series, I'm trying to get rid of the need for that as
cleanly as possible. ("cleanly" meaning "avoid holding the mmap_lock
across unbounded sleeps".)


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


I have tested:

 - Creating a simple core dump on X86-64 still works.
 - The created coredump on X86-64 opens in GDB and looks plausible.
 - NOMMU 32-bit ARM can still generate plausible-looking core dumps
   through the FDPIC implementation. (I can't test this with GDB because
   GDB is missing some structure definition for nommu ARM, but I've
   poked around in the hexdump and it looked decent.)

Jann Horn (5):
  binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
  coredump: Let dump_emit() bail out on short writes
  coredump: Refactor page range dumping into common helper
  binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
  mm/gup: Take mmap_lock in get_dump_page()

 fs/binfmt_elf.c          | 184 ++++++++++++++-------------------------
 fs/binfmt_elf_fdpic.c    | 106 +++++++++-------------
 fs/coredump.c            | 125 +++++++++++++++++++++++---
 include/linux/coredump.h |  11 +++
 mm/gup.c                 |  61 +++++++------
 5 files changed, 265 insertions(+), 222 deletions(-)


base-commit: 06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
-- 
2.28.0.220.ged08abb693-goog

