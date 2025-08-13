Return-Path: <linux-fsdevel+bounces-57616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C7B23E86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB176E5642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 02:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6FC2701C5;
	Wed, 13 Aug 2025 02:50:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19D1FAC4D;
	Wed, 13 Aug 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053443; cv=none; b=Nl9qdr4unwvvKbD+eLGBlGja1FC46ysHNvOEn0aIk2HNh8wlg9KKEQVtA6dyqrG5RF/kclZrbezQRKqam16IiWBFZ46VW08qE+ukmN0pl7lvRWcLvNrwcQxyMNNHuOfjW1Kj08+LlU7xAus7xt1ubIGbViG6TeKC2Lx4mpRoFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053443; c=relaxed/simple;
	bh=65xTXBS7eGQ2OVVFDS+gtYw/5G72uYv1DJdogCLu8CU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Apd1R9/HKVEiJbRJA7I5bbIc10klDNKi7xSaxeopNBRX2U2+4YmKBiZo4HolZD1mnxM6RxYZYtUPvSCvCBny+zFEDPca/QmFXHwhL0keNQQZG2t7qnf/KmRvYR1OvWv2LsYtQeggtLxS+8fWhnrwSCFOj9LHv/snuKRkoqc84nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1tCf5RH1zKHMmM;
	Wed, 13 Aug 2025 10:50:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 039291A0E9C;
	Wed, 13 Aug 2025 10:50:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxB2_ZtofKcBDg--.14943S4;
	Wed, 13 Aug 2025 10:50:37 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	brauner@kernel.org,
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH xfsprogs v2] xfs_io: add FALLOC_FL_WRITE_ZEROES support
Date: Wed, 13 Aug 2025 10:42:50 +0800
Message-Id: <20250813024250.2504126-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxB2_ZtofKcBDg--.14943S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur17Jw1kCF1rXw15JF15twb_yoW5Xr1Up3
	9rXF1UKa45Xry7WayfGws7WFn8Wws2kr1fJr4xWr1UZ3W5AFyxKFn8G3Z5X3s7WFWxCa1U
	JFnIqFy5G3WSy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTR_OzsDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES support to the
fallocate utility by introducing a new 'fwzero' command in the xfs_io
tool.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v1->v2:
 - Minor description modification to align with the kernel.

 io/prealloc.c     | 36 ++++++++++++++++++++++++++++++++++++
 man/man8/xfs_io.8 |  6 ++++++
 2 files changed, 42 insertions(+)

diff --git a/io/prealloc.c b/io/prealloc.c
index 8e968c9f..9a64bf53 100644
--- a/io/prealloc.c
+++ b/io/prealloc.c
@@ -30,6 +30,10 @@
 #define FALLOC_FL_UNSHARE_RANGE 0x40
 #endif
 
+#ifndef FALLOC_FL_WRITE_ZEROES
+#define FALLOC_FL_WRITE_ZEROES 0x80
+#endif
+
 static cmdinfo_t allocsp_cmd;
 static cmdinfo_t freesp_cmd;
 static cmdinfo_t resvsp_cmd;
@@ -41,6 +45,7 @@ static cmdinfo_t fcollapse_cmd;
 static cmdinfo_t finsert_cmd;
 static cmdinfo_t fzero_cmd;
 static cmdinfo_t funshare_cmd;
+static cmdinfo_t fwzero_cmd;
 
 static int
 offset_length(
@@ -377,6 +382,27 @@ funshare_f(
 	return 0;
 }
 
+static int
+fwzero_f(
+	int		argc,
+	char		**argv)
+{
+	xfs_flock64_t	segment;
+	int		mode = FALLOC_FL_WRITE_ZEROES;
+
+	if (!offset_length(argv[1], argv[2], &segment)) {
+		exitcode = 1;
+		return 0;
+	}
+
+	if (fallocate(file->fd, mode, segment.l_start, segment.l_len)) {
+		perror("fallocate");
+		exitcode = 1;
+		return 0;
+	}
+	return 0;
+}
+
 void
 prealloc_init(void)
 {
@@ -489,4 +515,14 @@ prealloc_init(void)
 	funshare_cmd.oneline =
 	_("unshares shared blocks within the range");
 	add_command(&funshare_cmd);
+
+	fwzero_cmd.name = "fwzero";
+	fwzero_cmd.cfunc = fwzero_f;
+	fwzero_cmd.argmin = 2;
+	fwzero_cmd.argmax = 2;
+	fwzero_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
+	fwzero_cmd.args = _("off len");
+	fwzero_cmd.oneline =
+	_("zeroes space and eliminates holes by allocating and submitting write zeroes");
+	add_command(&fwzero_cmd);
 }
diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
index b0dcfdb7..0a673322 100644
--- a/man/man8/xfs_io.8
+++ b/man/man8/xfs_io.8
@@ -550,6 +550,12 @@ With the
 .B -k
 option, use the FALLOC_FL_KEEP_SIZE flag as well.
 .TP
+.BI fwzero " offset length"
+Call fallocate with FALLOC_FL_WRITE_ZEROES flag as described in the
+.BR fallocate (2)
+manual page to allocate and zero blocks within the range by submitting write
+zeroes.
+.TP
 .BI zero " offset length"
 Call xfsctl with
 .B XFS_IOC_ZERO_RANGE
-- 
2.39.2


