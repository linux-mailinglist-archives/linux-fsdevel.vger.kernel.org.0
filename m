Return-Path: <linux-fsdevel+bounces-38970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E1A0A796
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051E57A3DF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D4193094;
	Sun, 12 Jan 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uQYDrY5u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12BA17335C
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=sRUZTXsX7b5CezUrOKHsZyMp6ZRGdO5i/f/g0MIiPTCTx5ygX+0+HOhre5WVMJthufmXYL6Pgzmk3sHs2y+yNm7zP3IztpvINX5IpizSyD7IIgXMxft8HaGreWcNk0ugUnKEdvbbXZCh4XRorkrCxGNDIQ8MOAlslOnlJ7dSj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=+Hh6qawfdwtj3F+BCfsEMwUwVpd5BTL3l/t3xnzg+M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvFgOi+CnAbJ0YTRzOuZ62XVsHtBaogYwHipbFtm5qtgW+72jot1S1rbwJ52Jax9rAgLyOGgfvB99OXg41PS92hgKyk3YzSxlMOHDu91uVrsSleA737wSxRnoZf2gWtpIIMnFM/vhoF2g6KIl0FLd3Kfhc9fOEiGAXCdP0s4ZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uQYDrY5u; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8XyvqjRUh5eIPyAv9SOoRTvDPl1wLZfESg7bvHK0VbU=; b=uQYDrY5uG0/MSB6OEvZVqHfXBD
	OKuK16wQnUKu2A4ttBwZVVEbrn29gb4AIoM7xk/AawfuIMvIPd7jrYz2yzZSjViYCUhaobxfCB9QW
	XDX/Mhkr6DFQGpYvor2KyH2bQ/hkV1gVuP1WI52seJ0j/nl2V4BWomeKttf7tb/Brjt0/NsLGEaAv
	MWb+5mhQGA2s5FG/oVkKQQP8Uzehx1cV6yrbmvenAQ/p8modIqdJg3QcI2BWJAw/0a5GpGpG7+uLX
	0HiNySxnk5/JU/yFYDYNHYl3mzctJu+1lM6p6Ra0+xqljibwgJ7p+6Vy+378rpHA5zL19yQPlrGv+
	WhWLCyHg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszz-00000000ak4-0gI7;
	Sun, 12 Jan 2025 08:07:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 15/21] qat: don't mess with ->d_name
Date: Sun, 12 Jan 2025 08:06:59 +0000
Message-ID: <20250112080705.141166-15-viro@zeniv.linux.org.uk>
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

use debugfs_{create_file,get}_aux_num() instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 .../intel/qat/qat_common/adf_tl_debugfs.c     | 36 +++----------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
index c8241f5a0a26..f20ae7e35a0d 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
@@ -473,22 +473,6 @@ static ssize_t tl_control_write(struct file *file, const char __user *userbuf,
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(tl_control);
 
-static int get_rp_index_from_file(const struct file *f, u8 *rp_id, u8 rp_num)
-{
-	char alpha;
-	u8 index;
-	int ret;
-
-	ret = sscanf(f->f_path.dentry->d_name.name, ADF_TL_RP_REGS_FNAME, &alpha);
-	if (ret != 1)
-		return -EINVAL;
-
-	index = ADF_TL_DBG_RP_INDEX_ALPHA(alpha);
-	*rp_id = index;
-
-	return 0;
-}
-
 static int adf_tl_dbg_change_rp_index(struct adf_accel_dev *accel_dev,
 				      unsigned int new_rp_num,
 				      unsigned int rp_regs_index)
@@ -611,18 +595,11 @@ static int tl_rp_data_show(struct seq_file *s, void *unused)
 {
 	struct adf_accel_dev *accel_dev = s->private;
 	u8 rp_regs_index;
-	u8 max_rp;
-	int ret;
 
 	if (!accel_dev)
 		return -EINVAL;
 
-	max_rp = GET_TL_DATA(accel_dev).max_rp;
-	ret = get_rp_index_from_file(s->file, &rp_regs_index, max_rp);
-	if (ret) {
-		dev_dbg(&GET_DEV(accel_dev), "invalid RP data file name\n");
-		return ret;
-	}
+	rp_regs_index = debugfs_get_aux_num(s->file);
 
 	return tl_print_rp_data(accel_dev, s, rp_regs_index);
 }
@@ -635,7 +612,6 @@ static ssize_t tl_rp_data_write(struct file *file, const char __user *userbuf,
 	struct adf_telemetry *telemetry;
 	unsigned int new_rp_num;
 	u8 rp_regs_index;
-	u8 max_rp;
 	int ret;
 
 	accel_dev = seq_f->private;
@@ -643,15 +619,10 @@ static ssize_t tl_rp_data_write(struct file *file, const char __user *userbuf,
 		return -EINVAL;
 
 	telemetry = accel_dev->telemetry;
-	max_rp = GET_TL_DATA(accel_dev).max_rp;
 
 	mutex_lock(&telemetry->wr_lock);
 
-	ret = get_rp_index_from_file(file, &rp_regs_index, max_rp);
-	if (ret) {
-		dev_dbg(&GET_DEV(accel_dev), "invalid RP data file name\n");
-		goto unlock_and_exit;
-	}
+	rp_regs_index = debugfs_get_aux_num(file);
 
 	ret = kstrtou32_from_user(userbuf, count, 10, &new_rp_num);
 	if (ret)
@@ -689,7 +660,8 @@ void adf_tl_dbgfs_add(struct adf_accel_dev *accel_dev)
 	for (i = 0; i < max_rp; i++) {
 		snprintf(name, sizeof(name), ADF_TL_RP_REGS_FNAME,
 			 ADF_TL_DBG_RP_ALPHA_INDEX(i));
-		debugfs_create_file(name, 0644, dir, accel_dev, &tl_rp_data_fops);
+		debugfs_create_file_aux_num(name, 0644, dir, accel_dev, i,
+					    &tl_rp_data_fops);
 	}
 }
 
-- 
2.39.5


