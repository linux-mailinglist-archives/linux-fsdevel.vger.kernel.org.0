Return-Path: <linux-fsdevel+bounces-13032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6397F86A4F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85ACBB2C186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21B21EB36;
	Wed, 28 Feb 2024 01:23:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9AF9F7;
	Wed, 28 Feb 2024 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083395; cv=none; b=atP9zetar42mMKs/OhJW7DwWXW9+DaPhrVDYD+d2RSlE6lBxDmeOWmUTsCDP6b7eLmVarIWkJDnuoio63rU46+PC+pGSJJR2kU8m6DTxuGzgo3DsTIs8+0pbjb289aZhRuk7Cgo7rudUoAv7SDBdhNtBwuFceeJe1QdujJRYsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083395; c=relaxed/simple;
	bh=p9MYk0CCIVQD2VoyNlRvo5eEoCALxgQBIh8yNfbihSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnAB72w3mhY/gH8d5Nx9DVM0URqeuOsy2/abyfCIzBLHGqSxLs+62F8/h9UlRAhvaPAYSyXjt7BzrY81qn8EdY8keRH3WLfVBqWnI3R3lTUXvvBAkelkYEtiVBzdP5ZcAYcCW2CJTZRy67ipMnEfXGGLn/thNXh/1Qp2v41ggQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TkxS648Rqz4f3m76;
	Wed, 28 Feb 2024 09:23:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E06021A0DEB;
	Wed, 28 Feb 2024 09:23:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX8gv7it5lqQx6FQ--.57137S4;
	Wed, 28 Feb 2024 09:23:09 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tim.c.chen@linux.intel.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] fs/writeback: bail out if there is no more inodes for IO and queued once
Date: Wed, 28 Feb 2024 17:19:54 +0800
Message-Id: <20240228091958.288260-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDX8gv7it5lqQx6FQ--.57137S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1rArW7Kw4DGr13ur1xKrg_yoW8GrW7pF
	45tryUtrWjv3yxurykCa42qw15Kw4DtFW7XFyxua17trn3XFWj9Fy0gw10yr48J39xuFWI
	vrsYyrW8Jr1Iy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3K9-UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

For case there is no more inodes for IO in io list from last wb_writeback,
We may bail out early even there is inode in dirty list should be written
back. Only bail out when we queued once to avoid missing dirtied inode.

This is from code reading...

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 4e6166e07eaf..6fa623277d75 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2076,6 +2076,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 	struct inode *inode;
 	long progress;
 	struct blk_plug plug;
+	bool queued = false;
 
 	blk_start_plug(&plug);
 	for (;;) {
@@ -2118,8 +2119,10 @@ static long wb_writeback(struct bdi_writeback *wb,
 			dirtied_before = jiffies;
 
 		trace_writeback_start(wb, work);
-		if (list_empty(&wb->b_io))
+		if (list_empty(&wb->b_io)) {
 			queue_io(wb, work, dirtied_before);
+			queued = true;
+		}
 		if (work->sb)
 			progress = writeback_sb_inodes(work->sb, wb, work);
 		else
@@ -2142,7 +2145,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		/*
 		 * No more inodes for IO, bail
 		 */
-		if (list_empty(&wb->b_more_io)) {
+		if (list_empty(&wb->b_more_io) && queued) {
 			spin_unlock(&wb->list_lock);
 			break;
 		}
-- 
2.30.0


