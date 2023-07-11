Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790D974F8F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 22:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGKUVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGKUVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:21:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B1310D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=00hsB+Y4M5JO8/62NZk9UtoHdoy3ZfWp29zMafKN3zE=; b=drSNAqWzPHXvG1fHPHNBuVN+GS
        Ffnjr1LSBAvoZBCBhghrldztaIaeJrnCs9UysIXC8jIhddNTC6mTs+VQXLfK6sFXZzudBEBkyF4ca
        oBrrvS4zv8HwHtrl26FubsHZQ3pVopbE45Z3gAllE+E1diC+PyLWZjaKzXh++EAI3pj/quaYNLSwk
        u4/LaaLxAJneA8l54d+LOOi+X0V5r50KImF5Xc9y0J9Rj3PQF7NSOhA7nPn3opFkpdW/UfiEaHhUy
        SuFRNs9r7X6fOaqPpreBmXH9I0NK7ogiHqTARuirIAOKmF0CR6zVBR8LgVagTWwmeJAoqDDpU5kqX
        O8SQDxEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJJqr-00G1Q4-AM; Tue, 11 Jul 2023 20:20:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v2 0/9] Avoid the mmap lock for fault-around
Date:   Tue, 11 Jul 2023 21:20:38 +0100
Message-Id: <20230711202047.3818697-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds the ability to handle page faults on parts of files
which are already in the page cache without taking the mmap lock.

I've taken a very gradual approach to pushing the lock down.  I'm not 100%
confident in my ability to grasp all the finer aspects of VMA handling,
so some reviewrs may well feel that I could have combined some of
these patches.  I did try to skip one of these steps and it had a bug,
so I feel justified in proceeding cautiously.

Several people have volunteered to run benchmarks on this, so I haven't.
I have run it through xfstests and it doesn't appear to introduce any
regressions.

This patchset is against next-20230711.  There is a patch from Arjun Roy
in there which has terrible conflicts with this work.  At Eric Dumazet's
suggestion I have started out by reverting it, then doing my patches
and redoing Arjun's patch on top.  It has the benefit of halving the
size of Arjun's patch,  Merging this is going to be a nightmare unless
the networking tree reverts Arjun's patch (the mm tree can't revert
a patch which isn't in the mm tree!).

Arjun's patch did point out that using lock_vma_under_rcu() is currently
very awkward, so that inspired patch 8 which makes it always available.

Arjun Roy (1):
  tcp: Use per-vma locking for receive zerocopy

Matthew Wilcox (Oracle) (8):
  Revert "tcp: Use per-vma locking for receive zerocopy"
  mm: Allow per-VMA locks on file-backed VMAs
  mm: Move FAULT_FLAG_VMA_LOCK check from handle_mm_fault()
  mm: Move FAULT_FLAG_VMA_LOCK check into handle_pte_fault()
  mm: Move FAULT_FLAG_VMA_LOCK check down in handle_pte_fault()
  mm: Move the FAULT_FLAG_VMA_LOCK check down from do_fault()
  mm: Run the fault-around code under the VMA lock
  mm: Remove CONFIG_PER_VMA_LOCK ifdefs

 MAINTAINERS             |  1 -
 arch/arm64/mm/fault.c   |  2 --
 arch/powerpc/mm/fault.c |  4 ----
 arch/riscv/mm/fault.c   |  4 ----
 arch/s390/mm/fault.c    |  2 --
 arch/x86/mm/fault.c     |  4 ----
 include/linux/mm.h      |  6 ++++++
 include/linux/net_mm.h  | 17 -----------------
 include/net/tcp.h       |  1 -
 mm/hugetlb.c            |  6 ++++++
 mm/memory.c             | 35 +++++++++++++++++++++++++----------
 net/ipv4/tcp.c          | 14 +++++---------
 12 files changed, 42 insertions(+), 54 deletions(-)
 delete mode 100644 include/linux/net_mm.h

-- 
2.39.2

