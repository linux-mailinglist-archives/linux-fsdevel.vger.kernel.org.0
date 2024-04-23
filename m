Return-Path: <linux-fsdevel+bounces-17456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100548ADC69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 05:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B91D1C21A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA6208A7;
	Tue, 23 Apr 2024 03:46:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EB1C2BD;
	Tue, 23 Apr 2024 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844012; cv=none; b=LbN/3qezQm08J6r+YR/0avuvqgkHRDeEW/w/9bSDN5pUaqEcXfJVvEfDzt7GIs8/PK6uimcmbBMP6vvzI1oNG15vRQDvpvaHKxH/WDqosq15Cb5LJuYAj4CCvPe+/F3OLZRtlTZPtu9wUoEEOMv5yq5I/EAAzSnjH67YdehMpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844012; c=relaxed/simple;
	bh=WQ05eBBY4p5S3lvd/kNS8zDpZ4FPaOvykDTMjRgeaeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3gWwbGxCHkdnoApGTeHGyKm37Yl5yPhxCnRTDlFYf/HekGPj+pKcLjcKBnXWSHChT3LA3DrYBI0ZR6ESIkHuu4EMb/aTWplCnqPuv0hoyaMB2kQpmKrFaAOBLz0APiMq4O6FNR3r8+Gpip+Al6lcCJhhvBD6eEqdjY4lzdrTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNp2W1RqRz4f3kpS;
	Tue, 23 Apr 2024 11:46:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 06BF01A0179;
	Tue, 23 Apr 2024 11:46:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgA3Ww4kLydmKkDYKw--.11241S7;
	Tue, 23 Apr 2024 11:46:47 +0800 (CST)
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
Subject: [PATCH v5 5/5] writeback: rename nr_reclaimable to nr_dirty in balance_dirty_pages
Date: Tue, 23 Apr 2024 11:46:43 +0800
Message-Id: <20240423034643.141219-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240423034643.141219-1-shikemeng@huaweicloud.com>
References: <20240423034643.141219-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3Ww4kLydmKkDYKw--.11241S7
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxZr1fGF17CrW8WFWkXrb_yoW8Cr15pF
	ZrGw1jkr4xtayavrn3CFWq9rZxtw48tF43JryUCw4SvwsrWF1UKFyI9ry0vF1xAa4fJrWa
	vws0qrykJw1vkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
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


