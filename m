Return-Path: <linux-fsdevel+bounces-21080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4369C8FDD8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 05:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54901F246C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 03:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD7A1E893;
	Thu,  6 Jun 2024 03:37:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723BA29415;
	Thu,  6 Jun 2024 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645020; cv=none; b=oqYv+eJPKCjxzmVDNwC79CfuDmPs/WxN1QfFuBIGs3tENGuXniD3Kt+RAFJ3/3o7HIeoaouJ4YIk4wfaKjDXyLpr6D6UofD0gO+PcXFjHOcObn1updL8qJhrQJxX6BMXyYNcVca1a0X8d4RbJ8qpM2POyNM3Y3HKLMFfq6ULFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645020; c=relaxed/simple;
	bh=rqAjxpHR7KTlsvFbPc+x691e3zDeF99vZooQi2w0+Ss=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=VmOsd0B9E/x5AFQ2XfO31jqNAOlqTQ/oUUjG2Csd0SpEfdnqPKJygStUWScNYz5SjNN68HDRbIluKXv0Ph4iVHFD83RumUyNnA32rVl0REsktnoX4sLfJ/FkCbJ2sDwCsz3EVmCoi+N03mOtH10IbWd8MMBnUShiiWu/tOsgg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vvqkf65WMz4f3lgN;
	Thu,  6 Jun 2024 11:36:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 07B301A016E;
	Thu,  6 Jun 2024 11:36:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgAn6J_VLmFmIDPrOQ--.6770S2;
	Thu, 06 Jun 2024 11:36:53 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] writeback: factor out balance_wb_limits to remove repeated code
Date: Thu,  6 Jun 2024 11:35:47 +0800
Message-Id: <20240606033547.344376-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAn6J_VLmFmIDPrOQ--.6770S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyUKrW7Ww1ktrWxWFW3ZFb_yoW8Cw4kpF
	Z2ya10yr4kJF1Sqa9IyFZrurWaqrsayFWfJ348Gw4ftF4fKr17KFyavry0vF17ArnrGrW5
	Zr4DtF97Gw1rCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6r
	W3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out balance_wb_limits to remove repeated code

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index bf050abd9053..f611272d3c5b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1783,6 +1783,21 @@ static inline void wb_dirty_exceeded(struct dirty_throttle_control *dtc,
 		((dtc->dirty > dtc->thresh) || strictlimit);
 }
 
+/*
+ * The limits fileds dirty_exceeded and pos_ratio won't be updated if wb is
+ * in freerun state. Please don't use these invalid fileds in freerun case.
+ */
+static void balance_wb_limits(struct dirty_throttle_control *dtc,
+			      bool strictlimit)
+{
+	wb_dirty_freerun(dtc, strictlimit);
+	if (dtc->freerun)
+		return;
+
+	wb_dirty_exceeded(dtc, strictlimit);
+	wb_position_ratio(dtc);
+}
+
 /*
  * balance_dirty_pages() must be called by processes which are generating dirty
  * data.  It looks at the number of dirty pages in the machine and will force
@@ -1869,12 +1884,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		 * Calculate global domain's pos_ratio and select the
 		 * global dtc by default.
 		 */
-		wb_dirty_freerun(gdtc, strictlimit);
+		balance_wb_limits(gdtc, strictlimit);
 		if (gdtc->freerun)
 			goto free_running;
-
-		wb_dirty_exceeded(gdtc, strictlimit);
-		wb_position_ratio(gdtc);
 		sdtc = gdtc;
 
 		if (mdtc) {
@@ -1884,12 +1896,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			 * both global and memcg domains.  Choose the one
 			 * w/ lower pos_ratio.
 			 */
-			wb_dirty_freerun(mdtc, strictlimit);
+			balance_wb_limits(mdtc, strictlimit);
 			if (mdtc->freerun)
 				goto free_running;
-
-			wb_dirty_exceeded(mdtc, strictlimit);
-			wb_position_ratio(mdtc);
 			if (mdtc->pos_ratio < gdtc->pos_ratio)
 				sdtc = mdtc;
 		}
-- 
2.30.0


