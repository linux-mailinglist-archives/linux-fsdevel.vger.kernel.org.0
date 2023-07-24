Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FD875FF67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGXSyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGXSye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217CEE55
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2zzyOQ/ELoedvwtKEVTyBAp/APkj84uTCSU6QcCalhU=; b=vZT/Y4MRkSR2RWKBXfsnQJA9eJ
        L58r4l8glD5QAZyt8P99Pd+9h6TZHk1p3STq52FhfkuvDHTAY56TxbnU0iNvbtrY46ajoLfYr8+9Y
        Xab08FxxN9u96Oy9O2EqCQBhhR8IqAXPAKcKwVITdLpuQyJeCl6hba5/5Gtlaz067Neul3z5HnTsj
        8JJXJB7btmdCN2D2HxK2UhW07sJqLYq3nQqmbtMcMmbbYCIgdpGpkWeMPQoZxtFQzkow5VuH1PymB
        U6tWF0TV1UFZMZhi6ccwHiMJsPddRyE8c1l3x/Hmu6MWCqvJLyhWXGr1aTdNXgqvuZE1s0VJSwtE6
        f4FbI8LA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0h9-004iQz-VH; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v3 00/10] Handle most file-backed faults under the VMA lock
Date:   Mon, 24 Jul 2023 19:54:00 +0100
Message-Id: <20230724185410.1124082-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds the ability to handle page faults on parts of files
which are already in the page cache without taking the mmap lock.

Several people have volunteered to run benchmarks on this, so I haven't.
I am running it through xfstests and it hasn't appear to introduce any
regressions so far.

This patchset is against next-20230724.

v3:
 - Remove the reversion and reapplication of Arjun Roy's patch;
   "Remove CONFIG_PER_VMA_LOCK ifdefs" is brought to the front, and
   Arjun's patch is instead fixed.
 - Add the missing pte_unmap() pointed out by Jann Horn
 - Do not call ->huge_fault under the VMA lock, also pointed out by Jann
 - Add the last two patches that handle faults on existing PTEs
 - Add R-b from Suren (for the patches that remained intact)
 - Better wording in commit messages

Matthew Wilcox (Oracle) (10):
  mm: Remove CONFIG_PER_VMA_LOCK ifdefs
  mm: Allow per-VMA locks on file-backed VMAs
  mm: Move FAULT_FLAG_VMA_LOCK check from handle_mm_fault()
  mm: Handle PUD faults under the VMA lock
  mm: Handle some PMD faults under the VMA lock
  mm: Move FAULT_FLAG_VMA_LOCK check down in handle_pte_fault()
  mm: Move FAULT_FLAG_VMA_LOCK check down from do_fault()
  mm: Run the fault-around code under the VMA lock
  mm: Handle swap and NUMA PTE faults under the VMA lock
  mm: Handle faults that merely update the accessed bit under the VMA
    lock

 MAINTAINERS             |  1 -
 arch/arm64/mm/fault.c   |  2 -
 arch/powerpc/mm/fault.c |  4 --
 arch/riscv/mm/fault.c   |  4 --
 arch/s390/mm/fault.c    |  2 -
 arch/x86/mm/fault.c     |  4 --
 include/linux/mm.h      |  6 +++
 include/linux/net_mm.h  | 17 --------
 include/net/tcp.h       |  1 -
 mm/hugetlb.c            |  6 +++
 mm/memory.c             | 97 +++++++++++++++++++++++++++++------------
 net/ipv4/tcp.c          | 11 ++---
 12 files changed, 86 insertions(+), 69 deletions(-)
 delete mode 100644 include/linux/net_mm.h

-- 
2.39.2

