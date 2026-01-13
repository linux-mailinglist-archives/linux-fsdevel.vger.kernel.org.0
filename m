Return-Path: <linux-fsdevel+bounces-73385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF7D17473
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F001300B9A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D3537FF70;
	Tue, 13 Jan 2026 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="O6TIjVGo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4429AAF8;
	Tue, 13 Jan 2026 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292817; cv=none; b=P4miUI9qwWrYYrNW7rFiGTm1SYh8DT9JWV6rl7We05bN24Ffxq4Dn7jgr86R0T7E7JzQzxN9+NiuuDFNr/1oNSgczV4j2Fnfb23oLHQVotsHpBeDH6tTBVykWFP4EIw2OYrirDAuwUxvtWMzxgVptUGnjbZtNHlKyiCq2C+yRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292817; c=relaxed/simple;
	bh=75Ncf3w2P7c34Pz79cfUZZihvG9f28CGhePPYdD/xk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PpTKgQR5jiLr2KPaZmMTudFvjtZL9nUB8i3sGIgf9xcXgq+QaiyPLQ2/55Z0fMMEQ33N4DwbiSmUrO/ABrMOtrE3+PiLarGboZXIOFfdfbIOOfIJccsD3REOFrM1yC+zsuNEsAtB2CpqWWt4BZtPlcsot7Bn0n9N4YeY2VefDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=O6TIjVGo; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CE
	RUxlJ2Hv3yATM9ATjbmA35RTjNUrDSVC1/ZoZtUXM=; b=O6TIjVGoVCC7IhQ24t
	NUCZkmdVUxliP96XkUpx933IFr/Q0O7DWwWdGRphu/MKR7qpnoazYTiCPrOoGF//
	jcMc+ZvGZOFro5Q1H40Qol80aAsLeXEeupVOY6gbznINBmsP3548muwcOm+ZfLp3
	izejKi3tdSq7wfrkpz5AsxE0k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnd66rAWZpH5eYBg--.55121S2;
	Tue, 13 Jan 2026 16:26:19 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: zhaomengmeng@kylinos.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [vfs/vfs.all PATCH] writeback: use round_jiffies_relative for dirtytime_work
Date: Tue, 13 Jan 2026 16:26:14 +0800
Message-ID: <20260113082614.231580-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnd66rAWZpH5eYBg--.55121S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF45Ar13KF1rJFy5WFWkCrg_yoW8Xr17pF
	Z8JrnxKr45K3y7X3sxAF1qvr1YgwsFgF17Kr1qqa1ayrn0yryjqa4kAr1SqF1xJ3s5Za4S
	yrWvya4xZw4Fk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6xRDUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqwte1WlmAav4YwAA3V

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

The dirtytime_work is a background housekeeping task that flushes dirty
inodes, using round_jiffies_relative() will allow kernel to batch this
work with other aligned system tasks, reducing power consumption.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 fs/fs-writeback.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index ea95f527aace..a32d354152d0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2504,7 +2504,8 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
 	}
 	rcu_read_unlock();
 	if (dirtytime_expire_interval)
-		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+		schedule_delayed_work(&dirtytime_work,
+				      round_jiffies_relative(dirtytime_expire_interval * HZ));
 }
 
 static int dirtytime_interval_handler(const struct ctl_table *table, int write,
@@ -2536,7 +2537,8 @@ static const struct ctl_table vm_fs_writeback_table[] = {
 static int __init start_dirtytime_writeback(void)
 {
 	if (dirtytime_expire_interval)
-		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+		schedule_delayed_work(&dirtytime_work,
+				      round_jiffies_relative(dirtytime_expire_interval * HZ));
 	register_sysctl_init("vm", vm_fs_writeback_table);
 	return 0;
 }
-- 
2.43.0


