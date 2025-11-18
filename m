Return-Path: <linux-fsdevel+bounces-68945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6EEC698B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 14:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5715A3460B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 13:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ED83126D1;
	Tue, 18 Nov 2025 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="XANoA/vB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60511FF7C8;
	Tue, 18 Nov 2025 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763471250; cv=none; b=EKF79fNb88XtVP+/ouYmP0L0YIWJlkq03f1rMwGSJKGCmtPn8Q/EJENv/QCRfAZ6YuhXOWP8TbXpLDmasVOAu9wRWn5wqigjDQ0rPdJWkXzbYlImS3F++0lLkADBBulfIwOUZ01ow5B5H2h3kyBbZeUrtP2GWHuwl/wfh65b83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763471250; c=relaxed/simple;
	bh=DatYjcRZk17Jo3DSj995WerORzqtl3LNW8yhsn2xG3g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a6nSlQjSAUGFq+3lMttIML3K8vFXk98u41UkqPNKJeZ8xaqP61FqqqGmlCTx9WhHg5Lbw5YrZ2WJn01J+BKqtsf/Ntqjta2c7ULu+YV+bhMyplWD0wQUClA5BKgLkZiWJ9VMNbhuNViGGx01VlLEgO+5Q3K2ghAAbvVqa8JPPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=XANoA/vB; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2DDBA1E0F;
	Tue, 18 Nov 2025 13:04:01 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=XANoA/vB;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 217FF222D;
	Tue, 18 Nov 2025 13:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1763471247;
	bh=V3C6uhNId62+ZBzjjt63Re8g3COM95GuoVbA5IfYfR0=;
	h=From:To:CC:Subject:Date;
	b=XANoA/vB2TW4XxHhnAlybL1UBJrlUPdqvBJeycqPp2SXGnoc/qC4rYiUSNfTkKGyT
	 1crrHXj4cDb9UAAE5Cvl0h34t8kFI9rWFBQhITltL60mkuXIXy1u6vKU2ZhEG6ilkP
	 7oSrRmkDNgzjHVKsOEVJnU48dSajXEMHDU940Cvo=
Received: from localhost.localdomain (172.30.20.188) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 18 Nov 2025 16:07:25 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: check for shutdown in fsync
Date: Tue, 18 Nov 2025 14:07:05 +0100
Message-ID: <20251118130705.411336-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Ensure fsync() returns -EIO when the ntfs3 filesystem is in forced
shutdown, instead of silently succeeding via generic_file_fsync().

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 3b22c7375616..5389b2e17cde 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1440,6 +1440,18 @@ static ssize_t ntfs_file_splice_write(struct pipe_inode_info *pipe,
 	return iter_file_splice_write(pipe, file, ppos, len, flags);
 }
 
+/*
+ * ntfs_file_fsync - file_operations::fsync
+ */
+int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
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
@@ -1465,6 +1477,7 @@ const struct file_operations ntfs_file_operations = {
 	.fsync		= generic_file_fsync,
 	.fallocate	= ntfs_fallocate,
 	.release	= ntfs_file_release,
+	.fsync		= ntfs_file_fsync,
 };
 
 #if IS_ENABLED(CONFIG_NTFS_FS)
-- 
2.43.0


