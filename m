Return-Path: <linux-fsdevel+bounces-38971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF348A0A797
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE127A3F5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593EA194141;
	Sun, 12 Jan 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DxjUf0Ak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015416EBE8
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=tryqqN1vLY3G4BjN3deeNcQjYrlDdSrOg9F/lG+JUdePdEMMpJdSbVcEz5kVkyRrTrES6NCxagv6UtZOadnRFFYtKGsfPzEHX1jYagdUsdEyFb9tTVv2vU29oCArlNHbZCv0x8y/Otx00wyS+5LyGGtXPrWo0oGr+ID+8PGUgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=Zr19tx+m1fqXn0rQ1g9CLPxEYbUq1oi093yWjJpgtD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVIsAS/hcIkIgOVT9K5hzZKLcEMF/scI13rMpf2ov5bUj5YGfZgYz29cUXl2GgxBtF/iFcDJ/r8GFkTt07j9CLSEeZl4gJ9GT/3cYd+rF6NF+uAVEwfcxnwuDyYvJWtKDGmxWoanOj9ujv7i0uqpkhuY7JGo0vlj86/akLeEbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DxjUf0Ak; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bLLDP4eyU+WrzrCn2d1DT89PfNog3nTXET8q0BzYYDc=; b=DxjUf0Akyhn6iBm7gaLPjh7wg+
	ku1l38D79x2yym2X/i9FbOB73tKKQMG7NGsb01Ly3jG6Z1Z/OfSMrhGFEt0KS4iAYVycN7O/ztJ6l
	AfVyMp2P+IRVu/EU9thOV3PEXd9uWrBEpYEij0kknXDhzf8fPJVMMPrCMf3HsfHmlDjM119gWOKdq
	6NBZ2drqWx5X2vsC3Dw4a3Wx13qe9zQW/gmUkYlqvbqgD8g5et7hQ9G0OZp9O/5+Y8NXnGSmuWpGP
	fWqaYv/RgNvdfh4dUNo5It6PuIDQrqP73HIbfX+UPIAOIr9eHKaIcNVvnoKCYfzyVXOQszyw/1i4W
	LOf359/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszy-00000000aji-2xa5;
	Sun, 12 Jan 2025 08:07:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 11/21] mediatek: stop messing with ->d_iname
Date: Sun, 12 Jan 2025 08:06:55 +0000
Message-ID: <20250112080705.141166-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
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


