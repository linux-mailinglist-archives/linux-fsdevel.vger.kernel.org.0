Return-Path: <linux-fsdevel+bounces-38225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F649FDDF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582781617FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4EC13A3EC;
	Sun, 29 Dec 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g7ahmSSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4C45009
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459948; cv=none; b=uLkFuozuEacDRf7v47kgAZcUCRuO7bXLZnW9XPiZchlzFg0v9bbYyf1yRuzvsDtC9PVRC9ozTV9yYH3Mjk8zh3MV0IyyLPkTd10m4SVDhNuU9rPvNdAGYQuMIBE9vVTerCdPToixRZWUHh27ZjvxqUUmw97UVDVpqz3zaL8v+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459948; c=relaxed/simple;
	bh=Zr19tx+m1fqXn0rQ1g9CLPxEYbUq1oi093yWjJpgtD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CokamjVySK7NlwN4uf1blOfGHgM9EqYVPLR/0V7SPobOysf5Y+e8yd9io+LKEWJXsDsxX9SWDXl/xvnSymeU8XFF7rMjBzQ1Pt7ZYFxewylCmf7xZPU1IouUps5JZCmhdFWO6jwbFmNnXHr18Z3N7McJ90BeIIHxJjcOTxUmjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=g7ahmSSa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bLLDP4eyU+WrzrCn2d1DT89PfNog3nTXET8q0BzYYDc=; b=g7ahmSSaD9dQ6uLVLA87HMsGlB
	HqK3ZFV43xu4r1WO9id8Q36DgsMLDSvnq+SLpnEhL99YVDQv2N2JhcotzUPJIkZT1Hsp8t0aoYFFO
	VCEUms7juTKI0MIZ3ffLaNp6eOd8jPRIuRyWy9SwYr4vYx23QECeNDPUYFTVV3/6hEXIwMGSzI52u
	Qw8LKQiG6JzU7dCEoRuK+Cqcj47pWh/CNQ+XhJgCTi1ohIjtXSIw31qu4ik3iMGnmaGFP74qpYTuA
	693a2Cq7lsA21luRjSIgnpzAAFHX/f7JxLFjEp3CwDAdFgesl7XM51sT9AiMXhSyW8hSBQIo6wc1w
	t61RbZLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPQ-0000000DOia-2d1b;
	Sun, 29 Dec 2024 08:12:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 11/20] mediatek: stop messing with ->d_iname
Date: Sun, 29 Dec 2024 08:12:14 +0000
Message-ID: <20241229081223.3193228-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

use debgufs_{create_file,get}_aux_num() instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 40 ++++++++---------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 3f7095ec5978..a496fbe3352b 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -381,17 +381,12 @@ static const char *const u3_phy_files[] = {
 static int u2_phy_params_show(struct seq_file *sf, void *unused)
 {
 	struct mtk_phy_instance *inst = sf->private;
-	const char *fname = file_dentry(sf->file)->d_iname;
 	struct u2phy_banks *u2_banks = &inst->u2_banks;
 	void __iomem *com = u2_banks->com;
 	u32 max = 0;
 	u32 tmp = 0;
 	u32 val = 0;
-	int ret;
-
-	ret = match_string(u2_phy_files, ARRAY_SIZE(u2_phy_files), fname);
-	if (ret < 0)
-		return ret;
+	int ret = debugfs_get_aux_num(sf->file);
 
 	switch (ret) {
 	case U2P_EYE_VRT:
@@ -438,7 +433,7 @@ static int u2_phy_params_show(struct seq_file *sf, void *unused)
 		break;
 	}
 
-	seq_printf(sf, "%s : %d [0, %d]\n", fname, val, max);
+	seq_printf(sf, "%s : %d [0, %d]\n", u2_phy_files[ret], val, max);
 
 	return 0;
 }
@@ -451,23 +446,18 @@ static int u2_phy_params_open(struct inode *inode, struct file *file)
 static ssize_t u2_phy_params_write(struct file *file, const char __user *ubuf,
 				   size_t count, loff_t *ppos)
 {
-	const char *fname = file_dentry(file)->d_iname;
 	struct seq_file *sf = file->private_data;
 	struct mtk_phy_instance *inst = sf->private;
 	struct u2phy_banks *u2_banks = &inst->u2_banks;
 	void __iomem *com = u2_banks->com;
 	ssize_t rc;
 	u32 val;
-	int ret;
+	int ret = debugfs_get_aux_num(file);
 
 	rc = kstrtouint_from_user(ubuf, USER_BUF_LEN(count), 0, &val);
 	if (rc)
 		return rc;
 
-	ret = match_string(u2_phy_files, ARRAY_SIZE(u2_phy_files), fname);
-	if (ret < 0)
-		return (ssize_t)ret;
-
 	switch (ret) {
 	case U2P_EYE_VRT:
 		mtk_phy_update_field(com + U3P_USBPHYACR1, PA1_RG_VRT_SEL, val);
@@ -516,23 +506,18 @@ static void u2_phy_dbgfs_files_create(struct mtk_phy_instance *inst)
 	int i;
 
 	for (i = 0; i < count; i++)
-		debugfs_create_file(u2_phy_files[i], 0644, inst->phy->debugfs,
-				    inst, &u2_phy_fops);
+		debugfs_create_file_aux_num(u2_phy_files[i], 0644, inst->phy->debugfs,
+				    inst, i,  &u2_phy_fops);
 }
 
 static int u3_phy_params_show(struct seq_file *sf, void *unused)
 {
 	struct mtk_phy_instance *inst = sf->private;
-	const char *fname = file_dentry(sf->file)->d_iname;
 	struct u3phy_banks *u3_banks = &inst->u3_banks;
 	u32 val = 0;
 	u32 max = 0;
 	u32 tmp;
-	int ret;
-
-	ret = match_string(u3_phy_files, ARRAY_SIZE(u3_phy_files), fname);
-	if (ret < 0)
-		return ret;
+	int ret = debugfs_get_aux_num(sf->file);
 
 	switch (ret) {
 	case U3P_EFUSE_EN:
@@ -564,7 +549,7 @@ static int u3_phy_params_show(struct seq_file *sf, void *unused)
 		break;
 	}
 
-	seq_printf(sf, "%s : %d [0, %d]\n", fname, val, max);
+	seq_printf(sf, "%s : %d [0, %d]\n", u3_phy_files[ret], val, max);
 
 	return 0;
 }
@@ -577,23 +562,18 @@ static int u3_phy_params_open(struct inode *inode, struct file *file)
 static ssize_t u3_phy_params_write(struct file *file, const char __user *ubuf,
 				   size_t count, loff_t *ppos)
 {
-	const char *fname = file_dentry(file)->d_iname;
 	struct seq_file *sf = file->private_data;
 	struct mtk_phy_instance *inst = sf->private;
 	struct u3phy_banks *u3_banks = &inst->u3_banks;
 	void __iomem *phyd = u3_banks->phyd;
 	ssize_t rc;
 	u32 val;
-	int ret;
+	int ret = debugfs_get_aux_num(sf->file);
 
 	rc = kstrtouint_from_user(ubuf, USER_BUF_LEN(count), 0, &val);
 	if (rc)
 		return rc;
 
-	ret = match_string(u3_phy_files, ARRAY_SIZE(u3_phy_files), fname);
-	if (ret < 0)
-		return (ssize_t)ret;
-
 	switch (ret) {
 	case U3P_EFUSE_EN:
 		mtk_phy_update_field(phyd + U3P_U3_PHYD_RSV,
@@ -636,8 +616,8 @@ static void u3_phy_dbgfs_files_create(struct mtk_phy_instance *inst)
 	int i;
 
 	for (i = 0; i < count; i++)
-		debugfs_create_file(u3_phy_files[i], 0644, inst->phy->debugfs,
-				    inst, &u3_phy_fops);
+		debugfs_create_file_aux_num(u3_phy_files[i], 0644, inst->phy->debugfs,
+				    inst, i, &u3_phy_fops);
 }
 
 static int phy_type_show(struct seq_file *sf, void *unused)
-- 
2.39.5


