Return-Path: <linux-fsdevel+bounces-19415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D759E8C5646
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7547AB21C9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668548593E;
	Tue, 14 May 2024 12:53:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DCA76036;
	Tue, 14 May 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691218; cv=none; b=RJ9Lp9Ig20AAB98iwtyfOgUZP53qEwahCn8ClmgJcmgxx7fNdIgX6YcChGt4/ycQ4tp3V3T7GhlyaBZia8LTqN+HWiiEqE32TXE7DBuausBPUDkSA6Q0xfhjTa+TmyVZ9Um0yslGaYEK5hf4gAwJLqRmXpOYeiki04QRB3L+h8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691218; c=relaxed/simple;
	bh=wDiQuebFDMzMz8P8ysiqfh9HCOK4HJqsKaMu4E6xlZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ej3PR2BnN+UPihoP/vD1uetbjdh1KNzbn9nbihzqB1w+nHLkVILrS0pCD9y0Hcz+m7WtAeuyo7i/QysqQZuCFfuS5+NOp5mGzzCVPpGwDcBaCjeHw7fqI5jMD6HzEY1M+U2vw7gm7jtiOj3gnkXnvlVbGMJw8H34waHhqhThetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vdx9T64Glz4f3n5n;
	Tue, 14 May 2024 20:53:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F2EDC1A0D57;
	Tue, 14 May 2024 20:53:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHzG7EXkNmCyyLMw--.6596S8;
	Tue, 14 May 2024 20:53:27 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] writeback: factor out balance_domain_limits to remove repeated code
Date: Tue, 14 May 2024 20:52:52 +0800
Message-Id: <20240514125254.142203-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240514125254.142203-1-shikemeng@huaweicloud.com>
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHzG7EXkNmCyyLMw--.6596S8
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW5ZFyDKF18Jr4UAFy5urg_yoW8XF47pF
	4Ikayq9r4DJF17XFn3CFW7u3y3KrZ7ta15Kw1FkwsIvr17Kr1qgFy7ury09F17Ar18Jrn8
	AFsFqas7Gw48CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out balance_domain_limits to remove repeated code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 mm/page-writeback.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b9c8db7089ef..97ee5b32b4ef 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1746,6 +1746,14 @@ static void domain_dirty_freerun(struct dirty_throttle_control *dtc,
 	dtc->freerun = dirty <= dirty_freerun_ceiling(thresh, bg_thresh);
 }
 
+static void balance_domain_limits(struct dirty_throttle_control *dtc,
+				  bool strictlimit)
+{
+	domain_dirty_avail(dtc, true);
+	domain_dirty_limits(dtc);
+	domain_dirty_freerun(dtc, strictlimit);
+}
+
 static void wb_dirty_freerun(struct dirty_throttle_control *dtc,
 			     bool strictlimit)
 {
@@ -1802,18 +1810,13 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 
 		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
 
-		domain_dirty_avail(gdtc, true);
-		domain_dirty_limits(gdtc);
-		domain_dirty_freerun(gdtc, strictlimit);
-
+		balance_domain_limits(gdtc, strictlimit);
 		if (mdtc) {
 			/*
 			 * If @wb belongs to !root memcg, repeat the same
 			 * basic calculations for the memcg domain.
 			 */
-			domain_dirty_avail(mdtc, true);
-			domain_dirty_limits(mdtc);
-			domain_dirty_freerun(mdtc, strictlimit);
+			balance_domain_limits(mdtc, strictlimit);
 		}
 
 		/*
-- 
2.30.0


