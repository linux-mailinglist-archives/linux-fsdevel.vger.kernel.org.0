Return-Path: <linux-fsdevel+bounces-65941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22145C15FF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 17:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC501A64666
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2421834A3DB;
	Tue, 28 Oct 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ohRcecGH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756103491F2;
	Tue, 28 Oct 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670329; cv=none; b=jldoeuVLMkKtXZp147el/qONeVtquKdZ9lSp49MjKdCwWReNDSMkkBS3Lsx+LmxAr7RjkgEvt/+f+9zwWehPPTgz1L8SUbnMCy+6RbbjcyA0ornOKkJuCmDJXehEormEHh69rpcafPuNXeGQtGFqs03Rp96sXfcm09lBlJUDWws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670329; c=relaxed/simple;
	bh=jlBuMGWRoR2TJZKSAC8WMNlOEOmkPaRyfX3TAoYdsgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F6vq6vQITmV/owMD2ijsEZfvR699yX7jYo3qpZqL7mHz96sQFgcttXe7hRlC/BA8JTctLtkn95wy2xy4PAV8yhxyh2BvDTykHfR6EfkunK7naVMw60g3yFMt0p/WajaeduLmFg5fW34Jhlf3RYBuBJFYp8w0UYixQSS1cGBda0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ohRcecGH; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1163B1D1D;
	Tue, 28 Oct 2025 16:48:43 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=ohRcecGH;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 331FB2200;
	Tue, 28 Oct 2025 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1761670299;
	bh=05H5iJFYGjZKWLPSBvstN7AnrR6mucl2vSpX6vNw0pk=;
	h=From:To:CC:Subject:Date;
	b=ohRcecGH3VvsKF98SanrTM3+vY3xdU4qP6B3RfdvQEYI7ugnvUAiKXHTq49JZsh7A
	 EHew6r7e8s1Ge8rZhM30HpG5bEfWbPDFoEDSl//uCHxIMUynB8WAT45L15fajd4+g+
	 vSQM5Fu83+g550ikHNF25oxHqCnIkSSnrEY+zY0g=
Received: from localhost.localdomain (192.168.211.84) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 28 Oct 2025 19:51:38 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH RFC] fs/ntfs3: disable readahead for compressed files
Date: Tue, 28 Oct 2025 17:51:31 +0100
Message-ID: <20251028165131.9187-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Reading large compressed files is extremely slow when readahead is enabled.
For example, reading a 4 GB XPRESS-4K compressed file (compression ratio
≈ 4:1) takes about 230 minutes with readahead enabled, but only around 3
minutes when readahead is disabled.

The issue was first observed in January 2025 and is reproducible with large
compressed NTFS files. Disabling readahead for compressed files avoids this
performance regression, although this may not be the ideal long-term fix.

This patch is submitted as an RFC to gather feedback on whether disabling
readahead is an acceptable solution or if a more targeted fix should be
implemented.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index a9ba37758944..7471a4bbb438 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -325,9 +325,14 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 		return -EOPNOTSUPP;
 	}
 
-	if (is_compressed(ni) && rw) {
-		ntfs_inode_warn(inode, "mmap(write) compressed not supported");
-		return -EOPNOTSUPP;
+	if (is_compressed(ni)) {
+		if (rw) {
+			ntfs_inode_warn(inode,
+					"mmap(write) compressed not supported");
+			return -EOPNOTSUPP;
+		}
+		/* Turn off readahead for compressed files. */
+		file->f_ra.ra_pages = 0;
 	}
 
 	if (rw) {
@@ -884,9 +889,14 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (err)
 		return err;
 
-	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
-		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
-		return -EOPNOTSUPP;
+	if (is_compressed(ni)) {
+		if (iocb->ki_flags & IOCB_DIRECT) {
+			ntfs_inode_warn(
+				inode, "direct i/o + compressed not supported");
+			return -EOPNOTSUPP;
+		}
+		/* Turn off readahead for compressed files. */
+		file->f_ra.ra_pages = 0;
 	}
 
 	return generic_file_read_iter(iocb, iter);
@@ -906,6 +916,11 @@ static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
 	if (err)
 		return err;
 
+	if (is_compressed(ntfs_i(inode))) {
+		/* Turn off readahead for compressed files. */
+		in->f_ra.ra_pages = 0;
+	}
+
 	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 
-- 
2.43.0


