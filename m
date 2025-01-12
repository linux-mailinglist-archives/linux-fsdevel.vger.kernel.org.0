Return-Path: <linux-fsdevel+bounces-38979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF345A0A79F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5013A8A69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10479E1;
	Sun, 12 Jan 2025 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="M79+0sR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3634417B506
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669232; cv=none; b=WorJEoBe1dVMRueIQoVTLNGS/sTCfj8khOdocqwoW75P/9++yIbuQRRATezuukCodCpUW4NRV2gyapeAU+GrozLsbAosYl94mC6od0TNXlWV7wvM8gnOp/wKBR3HdQbnnVbO8+zm6PKncew3YifUsSX5yXAcSxfIKvXT3cr00L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669232; c=relaxed/simple;
	bh=SYN9HBBIJRse/ROGUt2G6TKc+YNONPHt1w3a1MEf0M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edsF6AO45EJQIURJaz61WL8+GY7eW2T90AoJIYTeENlM8GYN6iqbHjb6wwRmUc1iKPjU0rc1lmCV5LqDintAG+EFXnJ+aQrpI8lCP8WyhUKWEZ2TYsmAq+B/PKPArTWq4RuBoSdhWlz3a7dENUpNzTxDauBYjzmgTPCzycrDCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=M79+0sR8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oH1m/NI3vvq4CGKqjgsqtHFRTJ/wBpD3BWuInzE6CSw=; b=M79+0sR8DRjh6o6392XGqesWUw
	3tBgM6+GMlTCS7bgMdQ83mdFnrScxayFXtjsjHZv2baczA4QYtGoIfGjnitqUeUQ/uIse1RGeHDBw
	KuXHfxfmpJGxaYK8RZcvRFk0wg5AfKjzpDUYItoX+3IaZeyWZcBV1zcsK6QMCrpAtnW/mh5PdUPad
	2lO+XkyTDpAPLeY1SIqWSceowPbaJjXU6dI6RaDd1XwL+Kl5AC95PY0sPHb6i1DDblkaF7a6/BVm0
	aMJbYs5Ow24WkKQ1nqQX3MkCAkMnlY1oNTqaoNICBfq+k7dqOnHcfE7nq4LOW2BJ6zAjL7wzmwdDt
	KfL2tqlA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszz-00000000akN-2Oeb;
	Sun, 12 Jan 2025 08:07:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 19/21] octeontx2: don't mess with ->d_parent or ->d_parent->d_name
Date: Sun, 12 Jan 2025 08:07:03 +0000
Message-ID: <20250112080705.141166-19-viro@zeniv.linux.org.uk>
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

[and for fsck sake, don't call variables filp - especially the
ones that are not even struct file *]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 .../marvell/octeontx2/af/rvu_debugfs.c        | 76 ++++++-------------
 1 file changed, 24 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 148144f5b61d..a1f9ec03c2ce 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -917,19 +917,18 @@ static void print_npa_qsize(struct seq_file *m, struct rvu_pfvf *pfvf)
 /* The 'qsize' entry dumps current Aura/Pool context Qsize
  * and each context's current enable/disable status in a bitmap.
  */
-static int rvu_dbg_qsize_display(struct seq_file *filp, void *unsused,
+static int rvu_dbg_qsize_display(struct seq_file *s, void *unsused,
 				 int blktype)
 {
-	void (*print_qsize)(struct seq_file *filp,
+	void (*print_qsize)(struct seq_file *s,
 			    struct rvu_pfvf *pfvf) = NULL;
-	struct dentry *current_dir;
 	struct rvu_pfvf *pfvf;
 	struct rvu *rvu;
 	int qsize_id;
 	u16 pcifunc;
 	int blkaddr;
 
-	rvu = filp->private;
+	rvu = s->private;
 	switch (blktype) {
 	case BLKTYPE_NPA:
 		qsize_id = rvu->rvu_dbg.npa_qsize_id;
@@ -945,32 +944,28 @@ static int rvu_dbg_qsize_display(struct seq_file *filp, void *unsused,
 		return -EINVAL;
 	}
 
-	if (blktype == BLKTYPE_NPA) {
+	if (blktype == BLKTYPE_NPA)
 		blkaddr = BLKADDR_NPA;
-	} else {
-		current_dir = filp->file->f_path.dentry->d_parent;
-		blkaddr = (!strcmp(current_dir->d_name.name, "nix1") ?
-				   BLKADDR_NIX1 : BLKADDR_NIX0);
-	}
+	else
+		blkaddr = debugfs_get_aux_num(s->file);
 
 	if (!rvu_dbg_is_valid_lf(rvu, blkaddr, qsize_id, &pcifunc))
 		return -EINVAL;
 
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
-	print_qsize(filp, pfvf);
+	print_qsize(s, pfvf);
 
 	return 0;
 }
 
-static ssize_t rvu_dbg_qsize_write(struct file *filp,
+static ssize_t rvu_dbg_qsize_write(struct file *file,
 				   const char __user *buffer, size_t count,
 				   loff_t *ppos, int blktype)
 {
 	char *blk_string = (blktype == BLKTYPE_NPA) ? "npa" : "nix";
-	struct seq_file *seqfile = filp->private_data;
+	struct seq_file *seqfile = file->private_data;
 	char *cmd_buf, *cmd_buf_tmp, *subtoken;
 	struct rvu *rvu = seqfile->private;
-	struct dentry *current_dir;
 	int blkaddr;
 	u16 pcifunc;
 	int ret, lf;
@@ -996,13 +991,10 @@ static ssize_t rvu_dbg_qsize_write(struct file *filp,
 		goto qsize_write_done;
 	}
 
-	if (blktype == BLKTYPE_NPA) {
+	if (blktype == BLKTYPE_NPA)
 		blkaddr = BLKADDR_NPA;
-	} else {
-		current_dir = filp->f_path.dentry->d_parent;
-		blkaddr = (!strcmp(current_dir->d_name.name, "nix1") ?
-				   BLKADDR_NIX1 : BLKADDR_NIX0);
-	}
+	else
+		blkaddr = debugfs_get_aux_num(file);
 
 	if (!rvu_dbg_is_valid_lf(rvu, blkaddr, lf, &pcifunc)) {
 		ret = -EINVAL;
@@ -2704,8 +2696,8 @@ static void rvu_dbg_nix_init(struct rvu *rvu, int blkaddr)
 			    &rvu_dbg_nix_ndc_tx_hits_miss_fops);
 	debugfs_create_file("ndc_rx_hits_miss", 0600, rvu->rvu_dbg.nix, nix_hw,
 			    &rvu_dbg_nix_ndc_rx_hits_miss_fops);
-	debugfs_create_file("qsize", 0600, rvu->rvu_dbg.nix, rvu,
-			    &rvu_dbg_nix_qsize_fops);
+	debugfs_create_file_aux_num("qsize", 0600, rvu->rvu_dbg.nix, rvu,
+			    blkaddr, &rvu_dbg_nix_qsize_fops);
 	debugfs_create_file("ingress_policer_ctx", 0600, rvu->rvu_dbg.nix, nix_hw,
 			    &rvu_dbg_nix_band_prof_ctx_fops);
 	debugfs_create_file("ingress_policer_rsrc", 0600, rvu->rvu_dbg.nix, nix_hw,
@@ -2854,28 +2846,14 @@ static int cgx_print_stats(struct seq_file *s, int lmac_id)
 	return err;
 }
 
-static int rvu_dbg_derive_lmacid(struct seq_file *filp, int *lmac_id)
+static int rvu_dbg_derive_lmacid(struct seq_file *s)
 {
-	struct dentry *current_dir;
-	char *buf;
-
-	current_dir = filp->file->f_path.dentry->d_parent;
-	buf = strrchr(current_dir->d_name.name, 'c');
-	if (!buf)
-		return -EINVAL;
-
-	return kstrtoint(buf + 1, 10, lmac_id);
+	return debugfs_get_aux_num(s->file);
 }
 
-static int rvu_dbg_cgx_stat_display(struct seq_file *filp, void *unused)
+static int rvu_dbg_cgx_stat_display(struct seq_file *s, void *unused)
 {
-	int lmac_id, err;
-
-	err = rvu_dbg_derive_lmacid(filp, &lmac_id);
-	if (!err)
-		return cgx_print_stats(filp, lmac_id);
-
-	return err;
+	return cgx_print_stats(s, rvu_dbg_derive_lmacid(s));
 }
 
 RVU_DEBUG_SEQ_FOPS(cgx_stat, cgx_stat_display, NULL);
@@ -2933,15 +2911,9 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 	return 0;
 }
 
-static int rvu_dbg_cgx_dmac_flt_display(struct seq_file *filp, void *unused)
+static int rvu_dbg_cgx_dmac_flt_display(struct seq_file *s, void *unused)
 {
-	int err, lmac_id;
-
-	err = rvu_dbg_derive_lmacid(filp, &lmac_id);
-	if (!err)
-		return cgx_print_dmac_flt(filp, lmac_id);
-
-	return err;
+	return cgx_print_dmac_flt(s, rvu_dbg_derive_lmacid(s));
 }
 
 RVU_DEBUG_SEQ_FOPS(cgx_dmac_flt, cgx_dmac_flt_display, NULL);
@@ -2980,10 +2952,10 @@ static void rvu_dbg_cgx_init(struct rvu *rvu)
 			rvu->rvu_dbg.lmac =
 				debugfs_create_dir(dname, rvu->rvu_dbg.cgx);
 
-			debugfs_create_file("stats", 0600, rvu->rvu_dbg.lmac,
-					    cgx, &rvu_dbg_cgx_stat_fops);
-			debugfs_create_file("mac_filter", 0600,
-					    rvu->rvu_dbg.lmac, cgx,
+			debugfs_create_file_aux_num("stats", 0600, rvu->rvu_dbg.lmac,
+					    cgx, lmac_id, &rvu_dbg_cgx_stat_fops);
+			debugfs_create_file_aux_num("mac_filter", 0600,
+					    rvu->rvu_dbg.lmac, cgx, lmac_id,
 					    &rvu_dbg_cgx_dmac_flt_fops);
 		}
 	}
-- 
2.39.5


