Return-Path: <linux-fsdevel+bounces-75989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIVcCm/GfWmBTgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 10:07:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE8FC1513
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E7DC3002F70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A842301717;
	Sat, 31 Jan 2026 09:07:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB31D6AA;
	Sat, 31 Jan 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769850470; cv=none; b=XpjAKqih8x1PZ3DFxlqFFjHpUCBnM9QEPOPBXUbpMma65ZlVYk7S2i3C9Ng7gCZ4Lr/kXR12Lre0eUlMygVDGuoy6q1uzw9QRrtQBj308wtPsgc8P9UulM5cChFVOEHWZvaDEb2D6/ZOrh4RLhFZrJPqylH12bAsu3wkH72JuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769850470; c=relaxed/simple;
	bh=k1AxCCxQBDmSPUrVHgD4nSVRmZy3ktErnEd7JaKD2l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0jiPBDrsQ0Maljo6+op6C+PsRIVsCx95Y2BF4fpcpFOTgJ2B/OXUvK8X4L/VszzXweKHl0Npaa6T/KQoA7jO+6JeYFLRn9cDXJyQ6udCDNr11EKuy3l4tEp3N60BcE1gzf0QL2Vfim8SaGpHLUcPsBTQLn2jSE1uBY0hCLOZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8BxXcNZxn1pDYUOAA--.47712S3;
	Sat, 31 Jan 2026 17:07:37 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJCxdcBVxn1pLrE7AA--.14238S2;
	Sat, 31 Jan 2026 17:07:37 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Julian Sun <sunjunchao@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] writeback: Fix wakeup and logging timeouts for !DETECT_HUNG_TASK
Date: Sat, 31 Jan 2026 17:07:24 +0800
Message-ID: <20260131090724.4128443-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdcBVxn1pLrE7AA--.14238S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw1UGFyrJFyfCrW7AF4kKrX_yoW5Gw45pF
	Wakw1YyFWvya4xKr95A3W7WF18K3yvyrWxWrnrtFWjvr1fXFZ8tFy7K34rtF13ArZxZFyS
	vFZ8ArWfWF1jqagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75989-lists,linux-fsdevel=lfdr.de];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2BE8FC1513
X-Rspamd-Action: no action

Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
is not enabled:

INFO: The task sync:1342 has been waiting for writeback completion for more than 1 seconds.

The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
is not enabled, then it causes the warning message even if the writeback
lasts for only one second.

I believe the wakeup and logging is also useful for !DETECT_HUNG_TASK,
so I don't want to disable them completely. As DEFAULT_HUNG_TASK_TIMEOUT
is 120 seconds, so for the !DETECT_HUNG_TASK case let's use 120 seconds
instead of sysctl_hung_task_timeout_secs.

Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing the writeback of a chunk.")
Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 fs/fs-writeback.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5444fc706ac7..847e46f0e019 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -198,10 +198,15 @@ static void wb_queue_work(struct bdi_writeback *wb,
 
 static bool wb_wait_for_completion_cb(struct wb_completion *done)
 {
+#ifndef CONFIG_DETECT_HUNG_TASK
+	unsigned long hung_secs = 120;
+#else
+	unsigned long hung_secs = sysctl_hung_task_timeout_secs;
+#endif
 	unsigned long waited_secs = (jiffies - done->wait_start) / HZ;
 
 	done->progress_stamp = jiffies;
-	if (waited_secs > sysctl_hung_task_timeout_secs)
+	if (waited_secs > hung_secs)
 		pr_info("INFO: The task %s:%d has been waiting for writeback "
 			"completion for more than %lu seconds.",
 			current->comm, current->pid, waited_secs);
@@ -1947,6 +1952,11 @@ static long writeback_sb_inodes(struct super_block *sb,
 	long write_chunk;
 	long total_wrote = 0;  /* count both pages and inodes */
 	unsigned long dirtied_before = jiffies;
+#ifndef CONFIG_DETECT_HUNG_TASK
+	unsigned long hung_secs = 120;
+#else
+	unsigned long hung_secs = sysctl_hung_task_timeout_secs;
+#endif
 
 	if (work->for_kupdate)
 		dirtied_before = jiffies -
@@ -2031,8 +2041,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 
 		/* Report progress to inform the hung task detector of the progress. */
 		if (work->done && work->done->progress_stamp &&
-		   (jiffies - work->done->progress_stamp) > HZ *
-		   sysctl_hung_task_timeout_secs / 2)
+		   (jiffies - work->done->progress_stamp) > HZ * hung_secs / 2)
 			wake_up_all(work->done->waitq);
 
 		wbc_detach_inode(&wbc);
-- 
2.47.3


