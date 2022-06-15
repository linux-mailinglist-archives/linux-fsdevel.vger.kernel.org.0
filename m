Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDE254C281
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiFOHNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiFOHNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:13:00 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F394167FE;
        Wed, 15 Jun 2022 00:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655277178;
  x=1686813178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=31d2aqWVAyXdsRipazb3IE8Miw4X3sTPNxD+NrkvWJg=;
  b=T3SM+us4KBfFZF8wHxq3ItbUEesvPgex9M59UgfTu9Ss9j6MS3UAnVe1
   UW3oFwozScXA8ikSOubNQK41vc2rpW2N1v98FiI13WRbM4sdwZVUuPJlC
   GyCcG2DO2/6ridk8RJY8025PfTg0WDJ/od/QpEv0p8b7j8igojtp7StES
   VinE5XkEOvRvuIcglRptPM8ycWLi4iBYBIWMb8QGTJaf79fiV1jDrV0kt
   OJvVpaeEnt2jTkFznUVd4FKCSr5VJzKUxqjxd0VlXUmh6ZrRZseXNRlze
   ImFWHv/n6pM60Fvb1klpYTnC2PLlJNXLTzzIMV5NzCqknkoDCasLrgjsa
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <akpm@linux-foundation.org>
CC:     <kernel@axis.com>, <linux-mm@kvack.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] mm/smaps: add Pss_Dirty
Date:   Wed, 15 Jun 2022 09:12:52 +0200
Message-ID: <20220615071252.1153408-1-vincent.whitchurch@axis.com>
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
possible to determine how much of the Pss is from dirty pages and how
much is from clean pages.  This information can be useful for measuring
memory usage for the purpose of optimisation, since clean pages can
usually be discarded by the kernel immediately while dirty pages cannot.

The smaps routines in the kernel already have access to this data, so
add a Pss_Dirty to show it to userspace.  Pss_Clean is not added since
it can be calculated from Pss and Pss_Dirty.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 fs/proc/task_mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2d04e3470d4c..696bb546ea06 100644
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
@@ -820,6 +822,7 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 		SEQ_PUT_DEC(" kB\nPss_Shmem:      ",
 			mss->pss_shmem >> PSS_SHIFT);
 	}
+	SEQ_PUT_DEC(" kB\nPss_Dirty:      ", mss->pss_dirty >> PSS_SHIFT);
 	SEQ_PUT_DEC(" kB\nShared_Clean:   ", mss->shared_clean);
 	SEQ_PUT_DEC(" kB\nShared_Dirty:   ", mss->shared_dirty);
 	SEQ_PUT_DEC(" kB\nPrivate_Clean:  ", mss->private_clean);
-- 
2.34.1

