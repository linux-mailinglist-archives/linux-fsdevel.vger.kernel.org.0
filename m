Return-Path: <linux-fsdevel+bounces-10754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF6084DCD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36BD9B26A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663C762CC;
	Thu,  8 Feb 2024 09:23:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063A6BB49;
	Thu,  8 Feb 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384194; cv=none; b=bgBkcWns0VY01dhoJeNvXQqUZTRdFOv6wtlBOxCdxclVpbBtC9BzAp9Rv/kYBFCiSkKkyeDzzt1gTnC4zqwzIcZT+pK3j5DxuxDdw1zt/LXEJ6fv5cnDJqlPSsY8qAyMRMeEVd0Lbqf5DTVVq/wPtE98zYMyBAtlG04XkEKljcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384194; c=relaxed/simple;
	bh=r/VLr9jN9dklOWb2ltJL6vuxoLRUWPZW50wD8+UThOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MB4cZ+4h79T4h0/3i4n4559+Ka57OdyxqTkugR2bTrMPEL65Y7nCAKqFMtgrAB2q+EKEAI8vOGz/suU06cRNWrnaePJLRs7Be4+Q98AfB+pKxRBCftRnKd4Cj9GxOnEcwcS0BnzDnM99R/ZP+YaO9swMrtPl0ikctEMQgUiVY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TVs3F1MYsz4f3kk5;
	Thu,  8 Feb 2024 17:23:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 05B111A016E;
	Thu,  8 Feb 2024 17:23:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQx4ncRl3tGXDQ--.8574S7;
	Thu, 08 Feb 2024 17:23:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] fs/writeback: only calculate dirtied_before when b_io is empty
Date: Fri,  9 Feb 2024 01:20:22 +0800
Message-Id: <20240208172024.23625-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240208172024.23625-1-shikemeng@huaweicloud.com>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQx4ncRl3tGXDQ--.8574S7
X-Coremail-Antispam: 1UD129KBjvJXoW7tFykCr17uFy7tFWxur4kZwb_yoW8GFWrpF
	Zxt3sxKr4jvw4Sgrn7A3W29r1rWw4xGF47A34xZFyIvw13Za42ga4vq348Kw1kJr47Zr9a
	vws8GFWxC348t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7Jw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The dirtied_before is only used when b_io is not empty, so only calculate
when b_io is not empty.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fs-writeback.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b61bf2075931..e8868e814e0a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2118,20 +2118,21 @@ static long wb_writeback(struct bdi_writeback *wb,
 
 		spin_lock(&wb->list_lock);
 
-		/*
-		 * Kupdate and background works are special and we want to
-		 * include all inodes that need writing. Livelock avoidance is
-		 * handled by these works yielding to any other work so we are
-		 * safe.
-		 */
-		if (work->for_kupdate) {
-			dirtied_before = jiffies -
-				msecs_to_jiffies(dirty_expire_interval * 10);
-		} else if (work->for_background)
-			dirtied_before = jiffies;
-
 		trace_writeback_start(wb, work);
 		if (list_empty(&wb->b_io)) {
+			/*
+			 * Kupdate and background works are special and we want to
+			 * include all inodes that need writing. Livelock avoidance is
+			 * handled by these works yielding to any other work so we are
+			 * safe.
+			 */
+			if (work->for_kupdate) {
+				dirtied_before = jiffies -
+					msecs_to_jiffies(dirty_expire_interval *
+							 10);
+			} else if (work->for_background)
+				dirtied_before = jiffies;
+
 			queue_io(wb, work, dirtied_before);
 			queued = true;
 		}
-- 
2.30.0


