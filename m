Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2321BB498
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 05:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD1D2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 23:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgD1D2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:28:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D8C03C1A9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:27:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o134so18538980yba.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u+G4hEDBCMfTTINsEe1rRLbmDctcZioKYhqJKU0a/to=;
        b=KS7OZjdt/sKvdslTKy6L/T6sE7YdAFI7rtNbHDh37qyDWlr6BYYTbLkiyvmD0nU0Vg
         PRRFYjaV7UbuK8P97MQGc1kQlBkhSW5m1ljSw8YwuhdjhF7jXweNqaFbkY9Plz6Wl1j4
         osppM2gxoE4Yrgh4n66OgZ3JsEY6l1ff2OMDXWcjzIlhM9kTGJ4VqWohzV1FRAHXNefl
         ZYwNdvb4LAg5HEbG7ldnRs7JPffDElIHozrCI8WkjzJY+A19nzvQ5AN+xrhkWxSSzafL
         O46PyHQSSBOenRmN3cTUjh1IJpeaEsSCOrwDvLioHY9vH6+s/1WzYSsDqeo2yVlPtFEk
         +EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u+G4hEDBCMfTTINsEe1rRLbmDctcZioKYhqJKU0a/to=;
        b=porMXSX6hIVkiXVnWZQ+T/uUXvTwpNmVh+3S5GvLEmLeWH9n80AvoHFfqKQI9HDh/j
         8Mj/JXr4MOxcDFPagg/DCyPGjBkMLpViJVlDrbPu1lOwB6BfU23xGiYHT9SO0Hnh6v+6
         xpCl6RnIHt+CJmd31hy5fsjg1VkXlH6Avx6vf/IGgEFNVFJrm4JSLySa2cEfmCWiB4RG
         jZA7XV7LapqQrmCYaFBXUXieXp+TxmdntE2ywRkoIOM3KZFE48g4S+UmknAuk4CFZUVh
         f9HEuLikbyFnRes6hVwvxihwQslP/Qu2I4Nf5csZgUtQszMqfJ3waf6GMkmZyLMiSpQ6
         Hkbg==
X-Gm-Message-State: AGi0PubSW9lzfQeplHg005FNHLDjON4uMqu/bqQhmmBVOXUPZfDCa6Ps
        50yF48ykrQeQ6zcoIT7p/m57NwnRtg==
X-Google-Smtp-Source: APiQypK6jqWOuNTokUNhG2QCt7A5zcXYd6+OoLGYxMDdl4Pak6sHqzfYvRIQd9LB/iLqowxAAwDHJLlsNA==
X-Received: by 2002:a25:afd0:: with SMTP id d16mr42901934ybj.441.1588044478270;
 Mon, 27 Apr 2020 20:27:58 -0700 (PDT)
Date:   Tue, 28 Apr 2020 05:27:40 +0200
Message-Id: <20200428032745.133556-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
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

Jann Horn (5):
  binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
  coredump: Fix handling of partial writes in dump_emit()
  coredump: Refactor page range dumping into common helper
  binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
  mm/gup: Take mmap_sem in get_dump_page()

 fs/binfmt_elf.c          | 170 ++++++++++++---------------------------
 fs/binfmt_elf_fdpic.c    | 106 +++++++++---------------
 fs/coredump.c            | 102 +++++++++++++++++++++++
 include/linux/coredump.h |  12 +++
 mm/gup.c                 |  69 +++++++++-------
 5 files changed, 243 insertions(+), 216 deletions(-)


base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
prerequisite-patch-id: c0a20b414eebc48fe0a8ca570b05de34c7980396
prerequisite-patch-id: 51973b8db0fa4b114e0c3fd8936b634d9d5061c5
prerequisite-patch-id: 0e1e8de282ca6d458dc6cbdc6b6ec5879edd8a05
prerequisite-patch-id: d5ee749c4d3a22ec80bd0dd88aadf89aeb569db8
prerequisite-patch-id: 46ce14e59e98e212a1eca0aef69c6dcdb62b8242
-- 
2.26.2.303.gf8c07b1a785-goog

