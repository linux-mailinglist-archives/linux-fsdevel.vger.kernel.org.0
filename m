Return-Path: <linux-fsdevel+bounces-76156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKSjDFmZgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:44:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC17D56C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0BAA308C864
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8437E2F0;
	Tue,  3 Feb 2026 06:30:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7035971B;
	Tue,  3 Feb 2026 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100245; cv=none; b=lcUvaeOEXdX2lpRiFKS+YnIpUK7I8AE6Xe87SNpEx9Mh2QizbP5Keiesl/rXr4Htytir8Q3M0zDVk9+kg71CY6Ny7C9NzfZyA2TRxW3TRX6v0ZzeVcLTX/xSp5Li98PQESXoGUo/U9ovNQmeFQ4LQQBpGAK6QGlmA1cHzFr8W78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100245; c=relaxed/simple;
	bh=zo2I6k8/xlGq0PtkAsWQuRfNUucflvH2Yo+nLd/eEMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWhuxiv+lfqOKTCvOvEO6CAkL/8zjiWTUKvX4/Ujj2JrMudtfamGuX/VNWUdHFJAOxrIW7ip+c8NERN8h2N9aeLULAMqeZq4ZmnPqAgr2gfG98ArU/HN0FsyBxyFLJNAbGkPUvBB3xxf6TfX5BxmE1826gOMC82RjvRyBBAUp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8DxvsMRloFpVkUPAA--.49940S3;
	Tue, 03 Feb 2026 14:30:41 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJCxecEMloFp4e4+AA--.24733S2;
	Tue, 03 Feb 2026 14:30:40 +0800 (CST)
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
Subject: [PATCH V2] writeback: Fix wakeup and logging timeouts for !DETECT_HUNG_TASK
Date: Tue,  3 Feb 2026 14:30:23 +0800
Message-ID: <20260203063023.2159073-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxecEMloFp4e4+AA--.24733S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4xur1fCFWrtF47JF15ZFc_yoW8uw1rpF
	WfGF1jyayvy34xKr1kG3ZFgF1Y93ykCr4xWr17WayIvw1fXa95tFW7Kry5tF13JrZxXFyS
	vFWqyrWfJF1jqagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76156-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,linux-fsdevel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:mid,loongson.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CC17D56C4
X-Rspamd-Action: no action

Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
is not enabled:

INFO: The task sync:1342 has been waiting for writeback completion for more than 1 seconds.

The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
is not enabled, then it causes the warning message even if the writeback
lasts for only one second.

So guard the wakeup and logging with "#ifdef CONFIG_DETECT_HUNG_TASK",
so as to eliminate the warning messages.

Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing the writeback of a chunk.")
Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Disable wakeup and logging for !DETECT_HUNG_TASK.

 fs/fs-writeback.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5444fc706ac7..bfe469fff97c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -198,13 +198,15 @@ static void wb_queue_work(struct bdi_writeback *wb,
 
 static bool wb_wait_for_completion_cb(struct wb_completion *done)
 {
+#ifdef CONFIG_DETECT_HUNG_TASK
 	unsigned long waited_secs = (jiffies - done->wait_start) / HZ;
 
-	done->progress_stamp = jiffies;
 	if (waited_secs > sysctl_hung_task_timeout_secs)
 		pr_info("INFO: The task %s:%d has been waiting for writeback "
 			"completion for more than %lu seconds.",
 			current->comm, current->pid, waited_secs);
+#endif
+	done->progress_stamp = jiffies;
 
 	return !atomic_read(&done->cnt);
 }
@@ -2029,11 +2031,13 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		__writeback_single_inode(inode, &wbc);
 
+#ifdef CONFIG_DETECT_HUNG_TASK
 		/* Report progress to inform the hung task detector of the progress. */
 		if (work->done && work->done->progress_stamp &&
 		   (jiffies - work->done->progress_stamp) > HZ *
 		   sysctl_hung_task_timeout_secs / 2)
 			wake_up_all(work->done->waitq);
+#endif
 
 		wbc_detach_inode(&wbc);
 		work->nr_pages -= write_chunk - wbc.nr_to_write;
-- 
2.47.3


