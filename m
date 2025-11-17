Return-Path: <linux-fsdevel+bounces-68719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FABC63F75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 17B3D23FA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745F932B997;
	Mon, 17 Nov 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tdq5EzmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACF126C02;
	Mon, 17 Nov 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380671; cv=none; b=qRD+f7VH/wC8cGjIXdCeMj4VYC1yFpMth8Bvy5gwcQWhErxvb8WezkRvyjuEmGCQVUgiHFA4WWnwgUpBu2nN/x43Klp6Zuaq0zGjWvMQCkhso2Qx+ZkoGi+iX3JDScj8HccP2mnFrajqNrrOy3gD38FyQKxYCmYlUPsuDztSTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380671; c=relaxed/simple;
	bh=WpfAyrTR6tAa35DZWR0KQ/vrlIgvmEBTTTWux9aoJ8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPvs5smABY40Sbs4IeIiiOU2/FxfW+7VvkVn+/MnD+wNgt2JJP/iJtoyD5mcl0lbNRtGtavimURIpg7KVpSei+k+/7bBFAUt1g7bB7ff/zDJcwF+KhWRExWkEksAFG3cSBomwtYAOf3837HOR0mV2vlpTb4ekFVxu8OEFzth36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tdq5EzmW; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763380656; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=v0wEwbBITgaXOrGzJ60sclrLTHa0QY/zRQTEJSVjsA4=;
	b=Tdq5EzmWsm7vmQzYB67MQrPXXu3ZwdvwrIpnTKB0DSBtrOUPs7GtnijFUB0imnp+1RYHgoSEnxmw+PUnz5ygizQJMVm9xZNQmE18P5Iz9Kjkjq5Iwc7w5tX2A4cojeoT0E3q5Z5PwehshZqGUVPyd4FKPpIw6ejVMhVSiHt318c=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsZmeTQ_1763380651 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 19:57:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH] erofs: correct FSDAX detection
Date: Mon, 17 Nov 2025 19:57:29 +0800
Message-ID: <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
References: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The detection of the primary device is skipped incorrectly
if the multiple or flattened feature is enabled.

It also fixes the FSDAX misdetection for non-block extra blobs.

Fixes: c6993c4cb918 ("erofs: Fallback to normal access if DAX is not supported on extra device")
Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/691af9f6.a70a0220.3124cb.0097.GAE@google.com
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f3f8d8c066e4..cd8ff98c2938 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -174,15 +174,15 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
-			if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
-				erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
-					   dif->path);
-				clear_opt(&sbi->opt, DAX_ALWAYS);
-			}
 		} else if (!S_ISREG(file_inode(file)->i_mode)) {
 			fput(file);
 			return -EINVAL;
 		}
+		if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
+			erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
+				   dif->path);
+			clear_opt(&sbi->opt, DAX_ALWAYS);
+		}
 		dif->file = file;
 	}
 
@@ -215,13 +215,13 @@ static int erofs_scan_devices(struct super_block *sb,
 			  ondisk_extradevs, sbi->devs->extra_devices);
 		return -EINVAL;
 	}
-	if (!ondisk_extradevs) {
-		if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
-			erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
-			clear_opt(&sbi->opt, DAX_ALWAYS);
-		}
-		return 0;
+
+	if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
+		erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
+	if (!ondisk_extradevs)
+		return 0;
 
 	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
 		sbi->devs->flatdev = true;
-- 
2.43.5


