Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEB2234B31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbgGaShu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbgGaSht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:37:49 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54932C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v18so15830616qvi.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xWSYjHc+nNdSzqwJCR0Bklwg1NIcyWlbe0Z3kPyxnWY=;
        b=UHl+j2V9dhsDIpXllhTd7jR0aoK7gz3zEDu2e8D2wo87p2jNh2PEv05B77btBa2WHg
         t4q9x8YrBGZ9mWVt2w/JAycC+YM363ctKxR6EZAiLJ1H2iARbDjGX7llw1Nc+VeYE9es
         yLcU/z3RRBx0nUqSGNv5//jg5qgnMt5Wu8m3R/7GIOqQxw0kKjBTswm1QjKpSO78MsPD
         3QPrOmOcbwtKQa5BO4IsGOI0g/U7+2GEkC1glS9jR40LCLfy1gPodeZY8yYY8H+aPQMA
         RSRRVYFCS/Ib7J0kJ1dmF/hxt8HVvPuyhMZglgFrgZH3/I5FkvLkG/kOCu9yAgBrbpJl
         xHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xWSYjHc+nNdSzqwJCR0Bklwg1NIcyWlbe0Z3kPyxnWY=;
        b=KS3FbknfrVmw9DsUhn3MqYw2Wo3wGgIPSG7SDrXfpW5yoWJNYn2b2PNJ5DazSQYpVg
         dbKm76yH2jrSlKeolTf3mvcn/YbI7O5V3c5f9145VuliTlv+4EXbbHUqZyuhR6QFFDNQ
         j9du3bA3A8NFu7V/xNeyCxI8Qvk0IFAwLH5yXKG8bsw5+eQIiBakQpl92U3ek4RogvHP
         6uiV6fySx8cz/bW5RGZm1y98VM2X1Y+Pjl5uSOHClqiXxnxzwEL+Ys2dckeDMaofAKMx
         hOT3BDZpvi6ydDtVdxOY2Y5jGXy6Oj7QdKfPZDZdomgYk2ITIjV7X85zrwGJ2mwBFuok
         eA4Q==
X-Gm-Message-State: AOAM533t92GmfzyCaTZrHK0Da66NP2hEznfOrT8bPY4JQiBJ5YYI1/dk
        sMe1DCcbBKfIOT92UDA53xJuIQ4htAIz9hM=
X-Google-Smtp-Source: ABdhPJwXJL3gk9kvQMJJpLmkcSGCU6nZqceKkw9xlltDxuzwPaAHb7crDooksHey6e2zSNoOpkyE2MgqTt+x1Wk=
X-Received: by 2002:a0c:d44e:: with SMTP id r14mr5459448qvh.105.1596220668284;
 Fri, 31 Jul 2020 11:37:48 -0700 (PDT)
Date:   Fri, 31 Jul 2020 14:37:42 -0400
Message-Id: <20200731183745.1669355-1-ckennelly@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 0/2 v2] Selecting Load Addresses According to p_align
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current ELF loading mechancism provides page-aligned mappings.  This
can lead to the program being loaded in a way unsuitable for
file-backed, transparent huge pages when handling PIE executables.

While specifying -z,max-page-size=0x200000 to the linker will generate
suitably aligned segments for huge pages on x86_64, the executable needs
to be loaded at a suitably aligned address as well.  This alignment
requires the binary's cooperation, as distinct segments need to be
appropriately paddded to be eligible for THP.

For binaries built with increased alignment, this limits the number of
bits usable for ASLR, but provides some randomization over using fixed
load addresses/non-PIE binaries.

Changes V1 -> V2:
* Added test

Chris Kennelly (2):
  fs/binfmt_elf: Use PT_LOAD p_align values for suitable start address.
  Add self-test for verifying load alignment.

 fs/binfmt_elf.c                             | 24 ++++++++
 tools/testing/selftests/exec/.gitignore     |  1 +
 tools/testing/selftests/exec/Makefile       |  9 ++-
 tools/testing/selftests/exec/load_address.c | 68 +++++++++++++++++++++
 4 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/exec/load_address.c

-- 
2.28.0.163.g6104cc2f0b6-goog

