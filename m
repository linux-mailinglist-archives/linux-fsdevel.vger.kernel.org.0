Return-Path: <linux-fsdevel+bounces-38228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B05E9FDDF8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EB61881FED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35B13C914;
	Sun, 29 Dec 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EezzIQao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF14DA04
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459949; cv=none; b=en+Vm2A0zODISS5AOvsT9tmTa0lV5fmaKQyA4t6EnGWjEiwjcz3iXzmKDCdVqWRfj61ZbbRfxGOu97RB9gtxCaPKh3DlzIPpZrjlZlkIRfELbGlWgRxdiqt5Vm4cjbuZ3BuhoyDRjuV9ZsNY3xGi/L1+G3Ngpd0ukL1FO5NItEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459949; c=relaxed/simple;
	bh=+Hh6qawfdwtj3F+BCfsEMwUwVpd5BTL3l/t3xnzg+M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rExSoCH0m2gDWRgyf7MAn5/D2X05acCgkE1wRXpnQro+ZoD5AhlxaM4cYFnvjzuhDxRiVWMjmX3AIWGPMbSTjcYpNQ/ndZ2QPTRIJrIlG20QgxLRSx3+oK/pfieHY9TP9bzUDlALcE8WfFXyrBH2/zg5abK+1avzAXK7PhvWeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EezzIQao; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8XyvqjRUh5eIPyAv9SOoRTvDPl1wLZfESg7bvHK0VbU=; b=EezzIQao0cS2Str9SF8zazf5xw
	9BMi/dYmauaKESvVH2qScD7L3AUVqpnJi7jDHXyCVTaTfBj/po+//BAdNs196YK08GnMXMTxPTGvF
	YQOHaMszvE6Xy2xzBWDo9uVACGPbzFTEnXwu/m9kD/wlRBiR2kKj6bw+8rSkaVD8pfgUHMOEiSAyf
	LyZX0CyR+2gbcSTbQZhCwkdyBorEjCfe1b9Fm4JCfEubghrDEAnFo8tqGGScS4yUyJyakSbX7OPzO
	z7KIyGxgVog2ts5c+QnHs2t+pqN6Q4LzTGqLJ3wkUEdztPmA+q20SZbLTTDF01plVOKAuoPbWFUNs
	C27pEPaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPR-0000000DOiy-0fBt;
	Sun, 29 Dec 2024 08:12:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 15/20] qat: don't mess with ->d_name
Date: Sun, 29 Dec 2024 08:12:18 +0000
Message-ID: <20241229081223.3193228-15-viro@zeniv.linux.org.uk>
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


