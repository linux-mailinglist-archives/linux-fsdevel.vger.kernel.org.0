Return-Path: <linux-fsdevel+bounces-13033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D922D86A4F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26379B2C25A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE21F945;
	Wed, 28 Feb 2024 01:23:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4326FBED;
	Wed, 28 Feb 2024 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083395; cv=none; b=ATPrBcSJO/IskJgntrhEI86rsIddrXQ6w4b8l4dBe5oXBm8QKTJzER39bpRNcIttDzRReZz6iv1Wh0QeVOV2sLX49joR60t48j/m+AQ1YPPd3ZgEvH3bkW2gumRBj4f8VyEY/HREAsV+UmzfLg2+EBRSrTpcy0thvuGrUOeEGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083395; c=relaxed/simple;
	bh=wobu9kkXF6/BimHszN+V9hX7lzwqQsw+Tts6H4/vFXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiJ6e1Vc76rJ/2BumVQHSej3xnSr0OJcmXAZPBjvSInfNKGAsuXPygAzcTKQW6Ky8FxCQaqqskog8wSnfTB4Txa13xxzjS9RQ/eXB3N05k9LdIsgbj2KBnsPx4Q3VPxqIiVMit/EhkBSvvlqydIe2ALOHLf91D4jXzAdEkY3rrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TkxSC1QSLz4f3kK0;
	Wed, 28 Feb 2024 09:23:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 89F3B1A056D;
	Wed, 28 Feb 2024 09:23:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX8gv7it5lqQx6FQ--.57137S6;
	Wed, 28 Feb 2024 09:23:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tim.c.chen@linux.intel.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] fs/writeback: only calculate dirtied_before when b_io is empty
Date: Wed, 28 Feb 2024 17:19:56 +0800
Message-Id: <20240228091958.288260-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240228091958.288260-1-shikemeng@huaweicloud.com>
References: <20240228091958.288260-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX8gv7it5lqQx6FQ--.57137S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3uF17Kw17ZF45XFWUJwb_yoW8GFWrpF
	Zxt34Skr4jva1Sgrn7A3W29r1Fgw48GF47A3yxZFyfZw13Za42ga4Dt348Kw1kJr47Xr9a
	vws5GFWxC340yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The dirtied_before is only used when b_io is not empty, so only calculate
when b_io is not empty.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fs-writeback.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1c3134817865..c98684e9e6ba 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2105,20 +2105,21 @@ static long wb_writeback(struct bdi_writeback *wb,
 
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
+			 * Kupdate and background works are special and we want
+			 * to include all inodes that need writing. Livelock
+			 * avoidance is handled by these works yielding to any
+			 * other work so we are safe.
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


