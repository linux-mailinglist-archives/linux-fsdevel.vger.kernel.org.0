Return-Path: <linux-fsdevel+bounces-23187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B6A928380
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 10:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1481281A57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D70145B0F;
	Fri,  5 Jul 2024 08:16:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E414533A;
	Fri,  5 Jul 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167371; cv=none; b=O7m78Y52EMyaOoF/cqbY89nP/mEU5lrCSavcQYg0LsV/jo1urq+HPfJdpFMvvhvFfRsns1eXeWaBBBRYYDJslz9AuKb6VhVopNG5oQtv+vc1CnTzx6BBMN2BERSIeECHohHTlEgWIAcbq3MVU6pDv7sY4nQpQFCDAPG75VGOS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167371; c=relaxed/simple;
	bh=uPcQJaet8uo7JXwMefSOrhwff2O9EQUpwFCRhUEMN6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HosuVaj4zFi899VtbUqk/OvEqiRfSTT5L38v6TP0L8igEIJ3WcmmVGqOeutcPnXn4uNtGlGMZjacbV2IYXfOUQfpbZ5+bFDDZa+jYBDLXrn0t07jjcO5WMgFq4xiXscFTw7TwF0vUe1yFbE6cCn4OgSLESGcC289eM7/rryx3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4658FKPJ089846;
	Fri, 5 Jul 2024 16:15:20 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WFmR03dk1z2KGTdQ;
	Fri,  5 Jul 2024 16:10:20 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 5 Jul 2024 16:15:18 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <linkinjeon@kernel.org>, <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>,
        <dongliang.cui@unisoc.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH] exfat: check disk status during buffer write
Date: Fri, 5 Jul 2024 16:15:14 +0800
Message-ID: <20240705081514.1901580-1-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4658FKPJ089846

We found that when writing a large file through buffer write,
if the disk is inaccessible, exFAT does not return an error
normally, which leads to the writing process not stopping properly.

To easily reproduce this issue, you can follow the steps below:

1. format a device to exFAT and then mount (with a full disk erase)
2. dd if=/dev/zero of=/exfat_mount/test.img bs=1M count=8192
3. eject the device

You may find that the dd process does not stop immediately and may
continue for a long time.

We compared it with the FAT, where FAT would prompt an EIO error and
immediately stop the dd operation.

The root cause of this issue is that when the exfat_inode contains the
ALLOC_NO_FAT_CHAIN flag, exFAT does not need to access the disk to
look up directory entries or the FAT table (whereas FAT would do)
every time data is written. Instead, exFAT simply marks the buffer as
dirty and returns, delegating the writeback operation to the writeback
process.

If the disk cannot be accessed at this time, the error will only be
returned to the writeback process, and the original process will not
receive the error, so it cannot be returned to the user side.

Therefore, we think that when writing files with ALLOC_NO_FAT_CHAIN,
it is necessary to continuously check the status of the disk.

When the disk cannot be accessed normally, an error should be returned
to stop the writing process.

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/exfat/exfat_fs.h | 5 +++++
 fs/exfat/inode.c    | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index ecc5db952deb..c5f5a7a8b672 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -411,6 +411,11 @@ static inline unsigned int exfat_sector_to_cluster(struct exfat_sb_info *sbi,
 		EXFAT_RESERVED_CLUSTERS;
 }
 
+static inline bool exfat_check_disk_error(struct block_device *bdev)
+{
+	return blk_queue_dying(bdev_get_queue(bdev));
+}
+
 static inline bool is_valid_cluster(struct exfat_sb_info *sbi,
 		unsigned int clus)
 {
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index dd894e558c91..efd02c1c83a6 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -147,6 +147,11 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	*clu = last_clu = ei->start_clu;
 
 	if (ei->flags == ALLOC_NO_FAT_CHAIN) {
+		if (exfat_check_disk_error(sb->s_bdev)) {
+			exfat_fs_error(sb, "device inaccessiable!\n");
+			return -EIO;
+		}
+
 		if (clu_offset > 0 && *clu != EXFAT_EOF_CLUSTER) {
 			last_clu += clu_offset - 1;
 
-- 
2.25.1


