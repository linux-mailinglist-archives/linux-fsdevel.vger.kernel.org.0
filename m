Return-Path: <linux-fsdevel+bounces-53734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4AAF63FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD33188EFB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD9E279794;
	Wed,  2 Jul 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="arqdYsmo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F723C4F1
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491761; cv=none; b=bfA96RXNzIIBZa7I+cHB0qidqDXKXg+xvLP8ewE6KNXuSUDMo2ZrOWQ5jO7QnoXw7vHzGf6XfBuqqya4ehZNlsxiubqJAB8xJDgQZpKAMqNUrfAPeNiKA0QplWBxoEi+JK9naoV/USSzDusbxdx6qg/3WWelCozrUptBxGDFWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491761; c=relaxed/simple;
	bh=CUVJ9p7RWXlF8bO7yuhiDmMubNrx6SVH3EOQ0o4qooA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/Uk8ZFm9xp1iU/LnAV75qwphyNlEQc86Sw3UUTzFd9MCgYhOOZhiep3LdDrxVjAFauEFbbeCXWTECnEWnrzrwTlsMOZHhMBccY/FeSk2q5a69F15SCInMRB2yxQNsfzoerKoXvkCQxBxQnP4o/XhuEcan4id3Scm0s3xn4M454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=arqdYsmo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GxRC08SAeWUu9gRFmWy9i2qPJBGy4B1I2eEi95OTayM=; b=arqdYsmoUXV5UaaeWT0mkFYAXh
	dJ1u46a8YNLlN+23TQ2i65Z8vBekuPCa/tQwuO07Bzkh/hD42fMLr48Sjn+PD602ppqA87wCQhw67
	SAbOgB2zsftZQdp/3ngzQ+w5yRI+XZqCO/h3uFHTvA5mGC83mx0tSmU8ppnlDFhyDd6BnoLj+yer0
	FMkej58uOEoy2uBxxzPE5WvA9NrbBhyVyFGqhnLOAzIqzBaO5RaVweWNQwVBOIciODM1iX37CQroA
	b0xnfZV580gAfmmmH6Ou6Gm/OKq+ZuBLBtuHTah+Lq9s12YND8fEWSDI2fL1Hij7ryCTU5bwoxGlu
	bWkfxPsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX513-0000000EPrT-3b0b;
	Wed, 02 Jul 2025 21:29:18 +0000
Date: Wed, 2 Jul 2025 22:29:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, James Smart <james.smart@broadcom.com>
Subject: [PATCH 11/11] lpfc: don't use file->f_path.dentry for comparisons
Message-ID: <20250702212917.GK3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

If you want a home-grown switch, at least use enum for selector...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 99 ++++++++++++++++----------------
 1 file changed, 51 insertions(+), 48 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 3fd1aa5cc78c..55ff030ca6cd 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2371,36 +2371,48 @@ lpfc_debugfs_dumpHostSlim_open(struct inode *inode, struct file *file)
 	return rc;
 }
 
+enum {
+	writeGuard = 1,
+	writeApp,
+	writeRef,
+	readGuard,
+	readApp,
+	readRef,
+	InjErrLBA,
+	InjErrNPortID,
+	InjErrWWPN,
+};
+
 static ssize_t
 lpfc_debugfs_dif_err_read(struct file *file, char __user *buf,
 	size_t nbytes, loff_t *ppos)
 {
-	struct dentry *dent = file->f_path.dentry;
 	struct lpfc_hba *phba = file->private_data;
+	int kind = debugfs_get_aux_num(file);
 	char cbuf[32];
 	uint64_t tmp = 0;
 	int cnt = 0;
 
-	if (dent == phba->debug_writeGuard)
+	if (kind == writeGuard)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wgrd_cnt);
-	else if (dent == phba->debug_writeApp)
+	else if (kind == writeApp)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wapp_cnt);
-	else if (dent == phba->debug_writeRef)
+	else if (kind == writeRef)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wref_cnt);
-	else if (dent == phba->debug_readGuard)
+	else if (kind == readGuard)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rgrd_cnt);
-	else if (dent == phba->debug_readApp)
+	else if (kind == readApp)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rapp_cnt);
-	else if (dent == phba->debug_readRef)
+	else if (kind == readRef)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rref_cnt);
-	else if (dent == phba->debug_InjErrNPortID)
+	else if (kind == InjErrNPortID)
 		cnt = scnprintf(cbuf, 32, "0x%06x\n",
 				phba->lpfc_injerr_nportid);
-	else if (dent == phba->debug_InjErrWWPN) {
+	else if (kind == InjErrWWPN) {
 		memcpy(&tmp, &phba->lpfc_injerr_wwpn, sizeof(struct lpfc_name));
 		tmp = cpu_to_be64(tmp);
 		cnt = scnprintf(cbuf, 32, "0x%016llx\n", tmp);
-	} else if (dent == phba->debug_InjErrLBA) {
+	} else if (kind == InjErrLBA) {
 		if (phba->lpfc_injerr_lba == (sector_t)(-1))
 			cnt = scnprintf(cbuf, 32, "off\n");
 		else
@@ -2417,8 +2429,8 @@ static ssize_t
 lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
 	size_t nbytes, loff_t *ppos)
 {
-	struct dentry *dent = file->f_path.dentry;
 	struct lpfc_hba *phba = file->private_data;
+	int kind = debugfs_get_aux_num(file);
 	char dstbuf[33];
 	uint64_t tmp = 0;
 	int size;
@@ -2428,7 +2440,7 @@ lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
 	if (copy_from_user(dstbuf, buf, size))
 		return -EFAULT;
 
-	if (dent == phba->debug_InjErrLBA) {
+	if (kind == InjErrLBA) {
 		if ((dstbuf[0] == 'o') && (dstbuf[1] == 'f') &&
 		    (dstbuf[2] == 'f'))
 			tmp = (uint64_t)(-1);
@@ -2437,23 +2449,23 @@ lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
 	if ((tmp == 0) && (kstrtoull(dstbuf, 0, &tmp)))
 		return -EINVAL;
 
-	if (dent == phba->debug_writeGuard)
+	if (kind == writeGuard)
 		phba->lpfc_injerr_wgrd_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_writeApp)
+	else if (kind == writeApp)
 		phba->lpfc_injerr_wapp_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_writeRef)
+	else if (kind == writeRef)
 		phba->lpfc_injerr_wref_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_readGuard)
+	else if (kind == readGuard)
 		phba->lpfc_injerr_rgrd_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_readApp)
+	else if (kind == readApp)
 		phba->lpfc_injerr_rapp_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_readRef)
+	else if (kind == readRef)
 		phba->lpfc_injerr_rref_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_InjErrLBA)
+	else if (kind == InjErrLBA)
 		phba->lpfc_injerr_lba = (sector_t)tmp;
-	else if (dent == phba->debug_InjErrNPortID)
+	else if (kind == InjErrNPortID)
 		phba->lpfc_injerr_nportid = (uint32_t)(tmp & Mask_DID);
-	else if (dent == phba->debug_InjErrWWPN) {
+	else if (kind == InjErrWWPN) {
 		tmp = cpu_to_be64(tmp);
 		memcpy(&phba->lpfc_injerr_wwpn, &tmp, sizeof(struct lpfc_name));
 	} else
@@ -6160,60 +6172,51 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			phba->debug_dumpHostSlim = NULL;
 
 		/* Setup DIF Error Injections */
-		snprintf(name, sizeof(name), "InjErrLBA");
 		phba->debug_InjErrLBA =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("InjErrLBA", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, InjErrLBA, &lpfc_debugfs_op_dif_err);
 		phba->lpfc_injerr_lba = LPFC_INJERR_LBA_OFF;
 
-		snprintf(name, sizeof(name), "InjErrNPortID");
 		phba->debug_InjErrNPortID =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("InjErrNPortID", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, InjErrNPortID, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "InjErrWWPN");
 		phba->debug_InjErrWWPN =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("InjErrWWPN", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, InjErrWWPN, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "writeGuardInjErr");
 		phba->debug_writeGuard =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("writeGuardInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, writeGuard, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "writeAppInjErr");
 		phba->debug_writeApp =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("writeAppInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, writeApp, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "writeRefInjErr");
 		phba->debug_writeRef =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("writeRefInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, writeRef, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "readGuardInjErr");
 		phba->debug_readGuard =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("readGuardInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, readGuard, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "readAppInjErr");
 		phba->debug_readApp =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("readAppInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, readApp, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "readRefInjErr");
 		phba->debug_readRef =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("readRefInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, readRef, &lpfc_debugfs_op_dif_err);
 
 		/* Setup slow ring trace */
 		if (lpfc_debugfs_max_slow_ring_trc) {
-- 
2.39.5


