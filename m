Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448CB24C432
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgHTRKD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 13:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbgHTRGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:06:54 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3FDC061345
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2020 10:05:50 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l18so1788447qvq.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2020 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=b7DoUVnpxFkIRzDbY79jsojJy3aTV9fDe4Ip8iAfTxQ=;
        b=G6qFHzRxH8tE+NQgVHe3aJDnjfVKpBi9JzEY++QUvnb6xoP4UL5YFe5sbFhKZ0gi1U
         Pan9TBWTEC7BF+2aZc0mqBv/kQwlsn5r0K3h60LPx01FIqpJljvvKUtcQNEKCuUEIYcf
         xG6AFaCuH19WI0tH9uTxHYIF5N/361YtX5GqJnekKRRACYb8RA6fhIvLnc1P/Yzeqr+H
         nm9sZjaq1e7Q8Ernq2ssLtCOLiUok7gbm5TyYkyMnEZ27b7ZMzkQBlVSI2rs4r58X6mp
         SViazal97l6xDrY5/0ApjBCUDFM/Mc0STSbbb38JOtssSGin/N/gfAXspNajLPcArkNT
         TMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=b7DoUVnpxFkIRzDbY79jsojJy3aTV9fDe4Ip8iAfTxQ=;
        b=ecMD/6thKB5I7yzBfOeapL3myqJx0zvJVZgvHzva8+C6DYWtoL0mylcR/nTd6v0LlT
         e8BnazkDBFZ4EGmzBpVq7H0oeMqglcPLyl/fv31EK0z3eGl+76zWO5hGu186ODASujku
         VqwbOPeR6O/QCrO4ital/1/wQk/tSL8Z/H4XMa2ENB7fkk6SHksvTqo0DkMwCQmX5T2s
         RoXpL3C8FgbbBpAKS1zTwufTMIFLb3dnXbZOWJetsFDDAC7FoQJrQCF3+cNkevp29bGt
         r7THD2xKIVkaeGjicqH4a7YpyQmpbWQ5ZA5qomgKZ71gbrPhrp8CrLQoYSpQTIPRrpwG
         Z6HQ==
X-Gm-Message-State: AOAM532jYXTqLcoj5yWFjq4hp9fndgaQphQpvGrIzD7cLjKNhBbmQdM2
        U/ImHs//0HqWAzuW+36l61nhOfbdkHM0Ia8=
X-Google-Smtp-Source: ABdhPJzQ303gG3zC6FMNRV8/7nehOE6TV+ALYSqyVmfx5TexEd8BHJGo0+ecTS9riPmHAJYwqf3lo4sw1B8I4o0=
X-Received: from ckennelly28.nyc.corp.google.com ([2620:0:1003:1003:3e52:82ff:fe5a:a91a])
 (user=ckennelly job=sendgmr) by 2002:ad4:51c8:: with SMTP id
 p8mr3882955qvq.31.1597943149942; Thu, 20 Aug 2020 10:05:49 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:05:39 -0400
Message-Id: <20200820170541.1132271-1-ckennelly@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v3 0/2] Selecting Load Addresses According to p_align
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

Changes V2 -> V3:
* Minor code tweaks based on off-thread feedback

Changes V1 -> V2:
* Added test

Chris Kennelly (2):
  fs/binfmt_elf: Use PT_LOAD p_align values for suitable start address.
  Add self-test for verifying load alignment.

 fs/binfmt_elf.c                             | 23 +++++++
 tools/testing/selftests/exec/.gitignore     |  1 +
 tools/testing/selftests/exec/Makefile       |  9 ++-
 tools/testing/selftests/exec/load_address.c | 68 +++++++++++++++++++++
 4 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/exec/load_address.c

-- 
2.28.0.297.g1956fa8f8d-goog

