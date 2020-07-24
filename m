Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9022CBE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXRU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXRU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:20:28 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51850C0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 10:20:28 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id q7so6421359qtq.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HNrBuo2EMN/xS+1Z8hxEE35aMqk1WeTu10gcXmwIBvo=;
        b=Tj7tx6/21Sjulp1orZHEiQcF+uS/wUAbrFLP+/aJO2iZCZa/NCyLfzaqTBv/HyrVVN
         +DWjpCClYWLYJjDT6Psx4G4ad20Zl9jQkYPTtnIwUsTSaV52mgxoffbxBySemvUDl3qA
         NYkz2KFvGkJTi2Ony5brKrozQqvyZYL+v6iDXuw8+cin7Cjy5ueDAca57TKhxQTr1ity
         xfX6TcmwJAi0S7xrEjbS0atfhM22Eb+b0JJf2NaCK1eFyc1Rrc7qFhMfjBUbcrM8eC85
         Are47u/+5XBZeQSQWqjZjg/UQ2maETUBPPFZ21c1r+1dTFm2Gn0LWnNrlqMiWHjGsUCD
         6S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HNrBuo2EMN/xS+1Z8hxEE35aMqk1WeTu10gcXmwIBvo=;
        b=NH5XMFvuxXOw8GgP8Vi/47QhSwpkIu0z9pcwjoT0IfSAJbqJKWkK2HIuENBC/AnyEP
         eqXkzrHegQt8ygn2h1tYbe3+e59K7FvvWqZ7//eg9ft3Ff1VuiVhWYrhjXf78my10aVj
         sA+U4JepLKDQKZs7h6el4VVGb3+82Q/48nQkXn9CKRm0F8jh2/P6qxNqgPl/8MdEUhCq
         /ZrhL7KhfVxt55TtXU4PBoJPn3d9+XCq+KEeSj81AXMowTECivfJZPU+BqLpdU0IOWot
         tyEEQQ9OK46knB1YLl3WW8wu6gHRKbAC+WjHJpkbpRLgkEpipP8b4v0yOqcwqPjOBSdZ
         kU5g==
X-Gm-Message-State: AOAM530akgydx1VXB1A0G4wk1LFNvHN46mVGfCmeYb0dFxWS1q9p1NA+
        /f3IJii7FAcxWP1LgCa/NRD2bQEdJQZH/Ys=
X-Google-Smtp-Source: ABdhPJxnJRCvMFOxTRn8f0uG0TAW3nI8AqOVSkyMw9u32JNVm7tazfuk+rDu4xgtQigoXhr1iXCi3F2uUb82gM0=
X-Received: by 2002:a0c:f788:: with SMTP id s8mr10391772qvn.169.1595611227229;
 Fri, 24 Jul 2020 10:20:27 -0700 (PDT)
Date:   Fri, 24 Jul 2020 13:20:15 -0400
Message-Id: <20200724172016.608742-1-ckennelly@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 0/1] Selecting Load Addresses According to p_align
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chris Kennelly <ckennelly@google.com>
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

Chris Kennelly (1):
  fs/binfmt_elf: Use PT_LOAD p_align values for suitable start address.

 fs/binfmt_elf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

