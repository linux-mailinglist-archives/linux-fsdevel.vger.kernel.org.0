Return-Path: <linux-fsdevel+bounces-17377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8568AC5FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C7E281588
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0A4F602;
	Mon, 22 Apr 2024 07:52:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67694D58A;
	Mon, 22 Apr 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772369; cv=none; b=fkpTRI+IK6+N1AtHbcOVXde91qIRKRPT29LhA3ejhNV+nmSeH+B9HqNpSsdJlsqf+YglXaIZ3Yeit/Y54qwf/iPnDiuqIYBfom1NntcuS9BKJ4/kI7KNq1dPW8RHRmkIxNWBaEY5LCjVLEeJMXHx2MqzXGXYHiZnX46nc+ruQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772369; c=relaxed/simple;
	bh=WQ05eBBY4p5S3lvd/kNS8zDpZ4FPaOvykDTMjRgeaeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuAVFA/AHuwddk2kJYDY+auh2CveD939SWxMTRsDj7CzMZP3NYVFdFkspYtQTEXdbCK2b0eaeY7aQExHGLB7wIgxuszYIBVFoR40sFSyEBskNKX8c3oUxOphh2j5uSXJulPrFOdEucYQqgwdko3gPIDFe5YAgobVD+WkekXQk1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNHXg5k5Lz4f3n5g;
	Mon, 22 Apr 2024 15:52:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E12561A016E;
	Mon, 22 Apr 2024 15:52:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCHqg1JFyZmCViLKw--.3978S6;
	Mon, 22 Apr 2024 15:52:44 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz,
	bfoster@redhat.com,
	tj@kernel.org
Cc: dsterba@suse.com,
	mjguzik@gmail.com,
	dhowells@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 4/4] writeback: rename nr_reclaimable to nr_dirty in balance_dirty_pages
Date: Tue, 23 Apr 2024 00:48:08 +0800
Message-Id: <20240422164808.13627-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240422164808.13627-1-shikemeng@huaweicloud.com>
References: <20240422164808.13627-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHqg1JFyZmCViLKw--.3978S6
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxZr1fGF17CrW8WFWkXrb_yoW8Cr15pF
	ZrGw1jkr4xtayavrn3CFWq9rZxtw48tF43JryUCw4SvwsrWF1UKFyI9ry0vF1xAa4fJrWa
	vws0qrykJw1vkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jVUDXUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Commit 8d92890bd6b85 ("mm/writeback: discard NR_UNSTABLE_NFS, use
NR_WRITEBACK instead") removed NR_UNSTABLE_NFS and nr_reclaimable
only contains dirty page now.
Rename nr_reclaimable to nr_dirty properly.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3bb3bed102ef..44df5c899a33 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1694,7 +1694,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
 						     &mdtc_stor : NULL;
 	struct dirty_throttle_control *sdtc;
-	unsigned long nr_reclaimable;	/* = file_dirty */
+	unsigned long nr_dirty;
 	long period;
 	long pause;
 	long max_pause;
@@ -1715,9 +1715,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		unsigned long m_thresh = 0;
 		unsigned long m_bg_thresh = 0;
 
-		nr_reclaimable = global_node_page_state(NR_FILE_DIRTY);
+		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
 		gdtc->avail = global_dirtyable_memory();
-		gdtc->dirty = nr_reclaimable + global_node_page_state(NR_WRITEBACK);
+		gdtc->dirty = nr_dirty + global_node_page_state(NR_WRITEBACK);
 
 		domain_dirty_limits(gdtc);
 
@@ -1768,7 +1768,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		 * In normal mode, we start background writeout at the lower
 		 * background_thresh, to keep the amount of dirty memory low.
 		 */
-		if (!laptop_mode && nr_reclaimable > gdtc->bg_thresh &&
+		if (!laptop_mode && nr_dirty > gdtc->bg_thresh &&
 		    !writeback_in_progress(wb))
 			wb_start_background_writeback(wb);
 
-- 
2.30.0


