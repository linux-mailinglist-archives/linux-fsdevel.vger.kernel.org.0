Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0503551240
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiFTIND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 04:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiFTIND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:13:03 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5618625C;
        Mon, 20 Jun 2022 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655712780;
  x=1687248780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gZFTepVCVuUiqVxMVdZ46Oj4Iz+xt4uwly/OdoZth3I=;
  b=ejM5C1dTXUQXl0PyF0zSPtptwseGwwUEExKTkagu51codOB5xGEuGiLP
   rNac9fNUKlX3AUMHvYk84+2LnaTvtrnkbenkYwwghzNW4FK/klfaYqYZp
   tphOQ4x+w2WSd3Kuh6W07BHhiRzLHMQjzJFpV+TfPwc3YgBU0kN0SPVZi
   bYxBElXDIfGxb+NHvXsUerwS9bGcJ4laYShEL83hjdrgkYweyBte6V0Kd
   SPhzSVj6WeQzC79VI5Uh6yfkMmbR5WqK/1dXEYrzT4251Z04vYI4stGjS
   RzvUvIILVJukpqNh95TAJeGS948CshA8b9B3wsPsROMuRDrcBqh1tR6By
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
CC:     <kernel@axis.com>, <linux-mm@kvack.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2] mm/smaps: add Pss_Dirty
Date:   Mon, 20 Jun 2022 10:12:50 +0200
Message-ID: <20220620081251.2928103-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pss is the sum of the sizes of clean and dirty private pages, and the
proportional sizes of clean and dirty shared pages:

 Private = Private_Dirty + Private_Clean
 Shared_Proportional = Shared_Dirty_Proportional + Shared_Clean_Proportional
 Pss = Private + Shared_Proportional

The Shared*Proportional fields are not present in smaps, so it is not
always possible to determine how much of the Pss is from dirty pages and
how much is from clean pages.  This information can be useful for
measuring memory usage for the purpose of optimisation, since clean
pages can usually be discarded by the kernel immediately while dirty
pages cannot.

The smaps routines in the kernel already have access to this data, so
add a Pss_Dirty to show it to userspace.  Pss_Clean is not added since
it can be calculated from Pss and Pss_Dirty.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 Documentation/ABI/testing/procfs-smaps_rollup | 1 +
 Documentation/filesystems/proc.rst            | 5 ++++-
 fs/proc/task_mmu.c                            | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/procfs-smaps_rollup b/Documentation/ABI/testing/procfs-smaps_rollup
index a4e31c465194..b446a7154a1b 100644
--- a/Documentation/ABI/testing/procfs-smaps_rollup
+++ b/Documentation/ABI/testing/procfs-smaps_rollup
@@ -22,6 +22,7 @@ Description:
 			MMUPageSize:           4 kB
 			Rss:		     884 kB
 			Pss:		     385 kB
+			Pss_Dirty:	      68 kB
 			Pss_Anon:	     301 kB
 			Pss_File:	      80 kB
 			Pss_Shmem:	       4 kB
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1bc91fb8c321..f7dce062548f 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -448,6 +448,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
     MMUPageSize:           4 kB
     Rss:                 892 kB
     Pss:                 374 kB
+    Pss_Dirty:             0 kB
     Shared_Clean:        892 kB
     Shared_Dirty:          0 kB
     Private_Clean:         0 kB
@@ -479,7 +480,9 @@ dirty shared and private pages in the mapping.
 The "proportional set size" (PSS) of a process is the count of pages it has
 in memory, where each page is divided by the number of processes sharing it.
 So if a process has 1000 pages all to itself, and 1000 shared with one other
-process, its PSS will be 1500.
+process, its PSS will be 1500.  "Pss_Dirty" is the portion of PSS which
+consists of dirty pages.  ("Pss_Clean" is not included, but it can be
+calculated by subtracting "Pss_Dirty" from "Pss".)
 
 Note that even a page which is part of a MAP_SHARED mapping, but has only
 a single pte mapped, i.e.  is currently used by only one process, is accounted
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2d04e3470d4c..751c19d5bfdd 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -406,6 +406,7 @@ struct mem_size_stats {
 	u64 pss_anon;
 	u64 pss_file;
 	u64 pss_shmem;
+	u64 pss_dirty;
 	u64 pss_locked;
 	u64 swap_pss;
 };
@@ -427,6 +428,7 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
 		mss->pss_locked += pss;
 
 	if (dirty || PageDirty(page)) {
+		mss->pss_dirty += pss;
 		if (private)
 			mss->private_dirty += size;
 		else
@@ -808,6 +810,7 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 {
 	SEQ_PUT_DEC("Rss:            ", mss->resident);
 	SEQ_PUT_DEC(" kB\nPss:            ", mss->pss >> PSS_SHIFT);
+	SEQ_PUT_DEC(" kB\nPss_Dirty:      ", mss->pss_dirty >> PSS_SHIFT);
 	if (rollup_mode) {
 		/*
 		 * These are meaningful only for smaps_rollup, otherwise two of
-- 
2.34.1

