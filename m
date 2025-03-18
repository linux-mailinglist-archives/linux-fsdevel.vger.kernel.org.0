Return-Path: <linux-fsdevel+bounces-44261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFED9A66BBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309A318946C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689971F180C;
	Tue, 18 Mar 2025 07:31:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C028F3;
	Tue, 18 Mar 2025 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283106; cv=none; b=FMKo4XDum+88met3smlUyNC9KkmsijMURgZHyba9bvBQ+rp5YBKHo2Y4wANiCsSE2N+eDHz1kwtdwXdNt26QnHVFrgjxSMGNav+BGClcigOKHFsLG/0/liXGvFp3aEVxrY4mtnRX2I6v9GYwc7uBUrxP0+H6egXwj1lqdQRLmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283106; c=relaxed/simple;
	bh=Sk1a5Oy8HLiP2ms3VTLUQbUCiRdGdpnjUvo7jpbYXJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgs/AEt2OEClASJpk2WsSyWVKoyALzaL4o7lWZVlqxX7yMs2xf/htgLAFSnHFLWw/goabB8frd1o0SLiRMlbo4DrBZ79c2stCNRmHvVj7YhufWFAMUCHFPEeO4Iaf/OHvKRLGLVcwISzfztM5p8ZcHzy1Cs6EhqsWuU8mSUa0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZH3Rm4ZJ0z4f3khW;
	Tue, 18 Mar 2025 15:31:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 387571A1ABC;
	Tue, 18 Mar 2025 15:31:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2BTIdln3gNYGw--.59040S4;
	Tue, 18 Mar 2025 15:31:38 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH xfsprogs] xfs_io: add FALLOC_FL_WRITE_ZEROES support
Date: Tue, 18 Mar 2025 15:23:18 +0800
Message-ID: <20250318072318.3502037-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2BTIdln3gNYGw--.59040S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw17Zr4DCr4kGrW5uw1kuFg_yoW5Jr18p3
	srXF15Ka45Xry7WFWfGws7Wrn8Xw4fKF1fJr4xWw1jv3W5AFyxKF1DG3ZYv3s7WFW8Ga18
	JFnIgFy5G3WSyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRRBT5DUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The Linux kernel is planning to support FALLOC_FL_WRITE_ZEROES in
fallocate(2). Add FALLOC_FL_ZERO_RANGE support to fallocate utility by
introducing a new 'fwzero' command to xfs_io.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 io/prealloc.c     | 36 ++++++++++++++++++++++++++++++++++++
 man/man8/xfs_io.8 |  5 +++++
 2 files changed, 41 insertions(+)

diff --git a/io/prealloc.c b/io/prealloc.c
index 8e968c9f..9d126229 100644
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
+	_("zeroes space and eliminates holes by allocating and writing zeroes");
+	add_command(&fwzero_cmd);
 }
diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
index 59d5ddc5..718f018c 100644
--- a/man/man8/xfs_io.8
+++ b/man/man8/xfs_io.8
@@ -538,6 +538,11 @@ With the
 .B -k
 option, use the FALLOC_FL_KEEP_SIZE flag as well.
 .TP
+.BI fwzero " offset length"
+Call fallocate with FALLOC_FL_WRITE_ZEROES flag as described in the
+.BR fallocate (2)
+manual page to allocate and zero blocks within the range by writing zeroes.
+.TP
 .BI zero " offset length"
 Call xfsctl with
 .B XFS_IOC_ZERO_RANGE
-- 
2.46.1


