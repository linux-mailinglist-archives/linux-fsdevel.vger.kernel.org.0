Return-Path: <linux-fsdevel+bounces-69059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC08DC6DA14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8267C3A1B66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67BB3358C2;
	Wed, 19 Nov 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="B2bCDg6K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF23358CF;
	Wed, 19 Nov 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543434; cv=none; b=e6rwZjM6zeB5pMiJ9zBocy9xOQ9WgXoNrUKCzyv39JHwqq0RFq0On080EewNR18aauFUmsodRv2DKSEdsXpxzAzrbxeqkRwPD5T1up8T8YMTa5wcEZ3yNFDoIizcD1TRwQ39Dzi77Jt2oGrZ56YkSv4Pmpqp6jkRGE42T84+/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543434; c=relaxed/simple;
	bh=z31FjG8X/w1eafkWHYQVFMlMDVZIuMqR2hyTgueQSBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3qSw/UtPPRmYJRcUlbg4pJu4HTvC/Hm3NMwA4xHB6qCQgwjvgwDmOoTDPcxyCVbQfA+L/nt+7yJ1QYrX9x61IZdq+h224ZzXBakNMDr8cZnC666yn9oyGwjsMhgc1dVIk92eF0s1NdW77mCLE/HYi4kXZS4xoYbGv77ywLBBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=B2bCDg6K; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E83E01D46;
	Wed, 19 Nov 2025 09:07:03 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=B2bCDg6K;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 981082095;
	Wed, 19 Nov 2025 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1763543430;
	bh=P/IOWb5RUWCH+HALw9+9JEBa7PRFGkQmR2BBnE8EoVk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=B2bCDg6KI6gN1gZXTu0IkWsqhydnpM0nVHbESk/jTutP4Y1qYXg+WFrCdDbCVkANX
	 vtaYPc/F83w7hvk4ALxNg8tgLhMouA3EUFoX17ayh82P/DxN10lKsF6nnzMen19oXw
	 a1HkEUUZUkncroNJVo58t1hjJX8aWfxTLKCDTY5k=
Received: from localhost.localdomain (172.30.20.173) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 19 Nov 2025 12:10:29 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<lkp@intel.com>, <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2] fs/ntfs3: check for shutdown in fsync
Date: Wed, 19 Nov 2025 10:10:20 +0100
Message-ID: <20251119091020.5397-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202511191004.GdiCxONs-lkp@intel.com>
References: <202511191004.GdiCxONs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Ensure fsync() returns -EIO when the ntfs3 filesystem is in forced
shutdown, instead of silently succeeding via generic_file_fsync().

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 3b22c7375616..5016bccc2ac5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1440,6 +1440,18 @@ static ssize_t ntfs_file_splice_write(struct pipe_inode_info *pipe,
 	return iter_file_splice_write(pipe, file, ppos, len, flags);
 }
 
+/*
+ * ntfs_file_fsync - file_operations::fsync
+ */
+static int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct inode *inode = file_inode(file);
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	return generic_file_fsync(file, start, end, datasync);
+}
+
 // clang-format off
 const struct inode_operations ntfs_file_inode_operations = {
 	.getattr	= ntfs_getattr,
@@ -1462,7 +1474,7 @@ const struct file_operations ntfs_file_operations = {
 	.splice_write	= ntfs_file_splice_write,
 	.mmap_prepare	= ntfs_file_mmap_prepare,
 	.open		= ntfs_file_open,
-	.fsync		= generic_file_fsync,
+	.fsync		= ntfs_file_fsync,
 	.fallocate	= ntfs_fallocate,
 	.release	= ntfs_file_release,
 };
-- 
2.43.0


