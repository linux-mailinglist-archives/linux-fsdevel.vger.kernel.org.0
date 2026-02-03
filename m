Return-Path: <linux-fsdevel+bounces-76176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AcHASrEgWnZJgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:47:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CCFD70F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9913152982
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF5394465;
	Tue,  3 Feb 2026 09:40:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB639525C;
	Tue,  3 Feb 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111643; cv=none; b=GaTXxZQJcjcJs9mPGLIk0tzcuC8WqPRxvmljwpoekEEoECZ2craS+VVJcZ3qiVB8Fv+piJXpR+BOanSWvNN9GBCjMnQtjvyjBt6Pk9bvX716LRsEb76HkDBpxWH97JUzbaDRyZqlRKkyDMTInXRUmI+0LCS/u2y1WyzQKjGd53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111643; c=relaxed/simple;
	bh=fi2zIziiiMfPuCFFCVLn3/jmCEGQIeLj3zxopoPQsAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdHYq1iRUYoLDsjQdsx93Jjcd2hvu+zHVVFtA9K4wjnzBUBhPJGpXnObnpXAdCneTFvIjUhto8g9EWm1J8g3v2lKSCnOZLnUC0fq9McxYh8XNaRaO88Vg3a/c5FBaHjGkIItLnNSbzjRmvARUUO9vtWid77TPl8+0cNEtNoEyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8DxusKPwoFpEFEPAA--.49206S3;
	Tue, 03 Feb 2026 17:40:31 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJBx58CHwoFpPAY_AA--.22892S2;
	Tue, 03 Feb 2026 17:40:30 +0800 (CST)
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
Subject: [PATCH V3] writeback: Fix wakeup and logging timeouts for !DETECT_HUNG_TASK
Date: Tue,  3 Feb 2026 17:40:14 +0800
Message-ID: <20260203094014.2273240-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx58CHwoFpPAY_AA--.22892S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw1UGFyrJFyfAFWxurWrCrX_yoW5WryrpF
	Wrtwn0ya1vya43Kr1ku3ZrWFyFk3ykCrZ7WwnrGFW0vwn5XFZ5tFW7K34UtF13JFZ3ZFyS
	vFWvyrWxGF1jqagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_UUUUU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76176-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,linux-fsdevel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:mid,loongson.cn:email]
X-Rspamd-Queue-Id: 50CCFD70F9
X-Rspamd-Action: no action

Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
is not enabled:

INFO: The task sync:1342 has been waiting for writeback completion for more than 1 seconds.

The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
is not enabled, then it causes the warning message even if the writeback
lasts for only one second.

Guard the wakeup and logging with "#ifdef CONFIG_DETECT_HUNG_TASK" can
eliminate the warning messages. But on the other hand, it is possible
that sysctl_hung_task_timeout_secs be also 0 when DETECT_HUNG_TASK is
enabled. So let's just check the value of sysctl_hung_task_timeout_secs
to decide whether do wakeup and logging.

Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing the writeback of a chunk.")
Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Disable wakeup and logging for !DETECT_HUNG_TASK.
V3: Also handle the case for DETECT_HUNG_TASK if sysctl_hung_task_timeout_secs is 0.

 fs/fs-writeback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5444fc706ac7..79b02ac66ac6 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -198,10 +198,11 @@ static void wb_queue_work(struct bdi_writeback *wb,
 
 static bool wb_wait_for_completion_cb(struct wb_completion *done)
 {
+	unsigned long timeout = sysctl_hung_task_timeout_secs;
 	unsigned long waited_secs = (jiffies - done->wait_start) / HZ;
 
 	done->progress_stamp = jiffies;
-	if (waited_secs > sysctl_hung_task_timeout_secs)
+	if (timeout && (waited_secs > timeout))
 		pr_info("INFO: The task %s:%d has been waiting for writeback "
 			"completion for more than %lu seconds.",
 			current->comm, current->pid, waited_secs);
@@ -1944,6 +1945,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		.range_end		= LLONG_MAX,
 	};
 	unsigned long start_time = jiffies;
+	unsigned long timeout = sysctl_hung_task_timeout_secs;
 	long write_chunk;
 	long total_wrote = 0;  /* count both pages and inodes */
 	unsigned long dirtied_before = jiffies;
@@ -2030,9 +2032,8 @@ static long writeback_sb_inodes(struct super_block *sb,
 		__writeback_single_inode(inode, &wbc);
 
 		/* Report progress to inform the hung task detector of the progress. */
-		if (work->done && work->done->progress_stamp &&
-		   (jiffies - work->done->progress_stamp) > HZ *
-		   sysctl_hung_task_timeout_secs / 2)
+		if (work->done && work->done->progress_stamp && timeout &&
+		   (jiffies - work->done->progress_stamp) > HZ * timeout / 2)
 			wake_up_all(work->done->waitq);
 
 		wbc_detach_inode(&wbc);
-- 
2.47.3


