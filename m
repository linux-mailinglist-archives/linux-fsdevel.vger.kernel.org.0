Return-Path: <linux-fsdevel+bounces-18042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6051B8B5000
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922E51C2100E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBCC14A8D;
	Mon, 29 Apr 2024 03:47:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B5111A5;
	Mon, 29 Apr 2024 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362477; cv=none; b=oOc9Du7fZ+1ODlTZG4h8KrMqOVNiVCsuKr/mt6Nh/IP+/tVp3zkjl98U9bb0K/2yZqr8ocncBzUO2d8+g0pvHQ1bSpHZfW2eiMh+6jWjIgqWfz6TjUxZUqiWU9J9F+3SmyBfe0E0Vn2JWbTDhihyCr5VQNNvHacZGxsQO6HLqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362477; c=relaxed/simple;
	bh=qd3SLc/Z+pj/Ox5jLs5aWxFPtCCMYpNhcs8dBNxf8ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9VbqxXpVvYxgBxuGTHUGjhQtTKUI+PDBJTtVEnzSwo17a6MxSZl/j49tR/QI1kJxW1x7mN5G/4Kb1cm3ULSwJJiwj+HHq5RNG3lSCn5qilmQzOKuPgIToAutmW67sT681ryOvTCVUAc2gh+fgnynNTJmuvv6ekBU6rGytGpdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSTmn38lGz4f3nJf;
	Mon, 29 Apr 2024 11:47:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D4B061A0179;
	Mon, 29 Apr 2024 11:47:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA3UwxgGC9m24__LA--.38879S5;
	Mon, 29 Apr 2024 11:47:46 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] writeback: factor out domain_over_bg_thresh to remove repeated code
Date: Mon, 29 Apr 2024 11:47:31 +0800
Message-Id: <20240429034738.138609-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240429034738.138609-1-shikemeng@huaweicloud.com>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3UwxgGC9m24__LA--.38879S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8CrW8XryxAFykuw1xZrb_yoW8tr4DpF
	4xAw1a9FWUJanrXrnxCFyUur43trZ7t3yUt3srCw1fAw43Cr4UGFy7Ar9YvFy8CFy7Jrya
	vr4ava4fGF10krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out domain_over_bg_thresh from wb_over_bg_thresh to remove
repeated code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e4f181d52035..28a29180fc9f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2137,6 +2137,20 @@ static void wb_bg_dirty_limits(struct dirty_throttle_control *dtc)
 		dtc->wb_dirty = wb_stat(wb, WB_RECLAIMABLE);
 }
 
+static bool domain_over_bg_thresh(struct dirty_throttle_control *dtc)
+{
+	domain_dirty_avail(dtc, true);
+	domain_dirty_limits(dtc);
+	if (dtc->dirty > dtc->bg_thresh)
+		return true;
+
+	wb_bg_dirty_limits(dtc);
+	if (dtc->wb_dirty > dtc->wb_bg_thresh)
+		return true;
+
+	return false;
+}
+
 /**
  * wb_over_bg_thresh - does @wb need to be written back?
  * @wb: bdi_writeback of interest
@@ -2148,31 +2162,14 @@ static void wb_bg_dirty_limits(struct dirty_throttle_control *dtc)
  */
 bool wb_over_bg_thresh(struct bdi_writeback *wb)
 {
-	struct dirty_throttle_control gdtc_stor = { GDTC_INIT(wb) };
-	struct dirty_throttle_control mdtc_stor = { MDTC_INIT(wb, &gdtc_stor) };
-	struct dirty_throttle_control * const gdtc = &gdtc_stor;
-	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
-						     &mdtc_stor : NULL;
-
-	domain_dirty_avail(gdtc, true);
-	domain_dirty_limits(gdtc);
-	if (gdtc->dirty > gdtc->bg_thresh)
-		return true;
+	struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
+	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
 
-	wb_bg_dirty_limits(gdtc);
-	if (gdtc->wb_dirty > gdtc->wb_bg_thresh)
+	if (domain_over_bg_thresh(&gdtc))
 		return true;
 
-	if (mdtc) {
-		domain_dirty_avail(mdtc, true);
-		domain_dirty_limits(mdtc);	/* ditto, ignore writeback */
-		if (mdtc->dirty > mdtc->bg_thresh)
-			return true;
-
-		wb_bg_dirty_limits(mdtc);
-		if (mdtc->wb_dirty > mdtc->wb_bg_thresh)
-			return true;
-	}
+	if (mdtc_valid(&mdtc))
+		return domain_over_bg_thresh(&mdtc);
 
 	return false;
 }
-- 
2.30.0


