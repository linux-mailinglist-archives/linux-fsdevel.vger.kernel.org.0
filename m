Return-Path: <linux-fsdevel+bounces-53883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC73AF86C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C261C46DD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 04:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921451F3B8A;
	Fri,  4 Jul 2025 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KKXWUofm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD071EA7E1
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603110; cv=none; b=X5jBXRalvCkD+6vqOyem/uPNZn1j1FDInMJaA1Y1w4KiOw28AF3rQd3bcXYhrYNt3wkpxU3JBXjmfAsNRBf1s7QW8NVHZht4+ZbrCN/Y4Y5qDMITZYiYWAi/QD6RQyb7T52+tQohWIQ5yQH3pmsguHk+XtQ3P5BDI8DPfk8uxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603110; c=relaxed/simple;
	bh=P29g8rZZboXRk8ouSK4M0UJ97/bsMs6lrpKOTVBcmDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lylNwVn+RCI1MBJ0iyUREX0xDf6BD+do7dIcNyM/9HRQRxT8Wbif5g3s212Ij9pAbdtI/ufqch9ukOsd0vq+LLEDdh1SOEHgYAAV+JcEA95HWGfbtwtAuXTjgglMKWEoDN+m4QkLxaDmBJnrSpc9ag8XenHqyFg+m5s8eeyn59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KKXWUofm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=7hADUCkXq5NrbnjIxa4mxn6QOmd4zXVgv4lcBoyKZcs=; b=KKXWUofm327YPDJmwvp1hN/2xk
	tNpA+fQIfdcTU1xdyN1CHEGnTU4qzcSpVAI0IlFPWXLOL3+OA7aXYLTppEh4kD+WAh1xSpmgVMTyg
	hjC8aksQHxNaJ5SLWYcFFzG5ecfXvmu7jjvmr48qHYrm2DNHXcFLuuhNOHbnkE1oq4z2T2DpIoSxn
	km1XbxsjjRUCHSJFM2xrjXRK1EYQim4krop6o1Thrwbyw5qWUe/bItq18D9vPqxLF2MS+4ZlFNG8c
	shfkftEu9PvnjZzI23LtfthV0dfyR2iIgQpj45XSEn0pBfTkJYkBgIWxCPgtP6XlUs+I7zMQDYr3c
	ZGqya6Qw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXXyy-0000000981i-1kcU;
	Fri, 04 Jul 2025 04:25:04 +0000
Date: Fri, 4 Jul 2025 05:25:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Justin Tee <justintee8345@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/11] lpfc: don't use file->f_path.dentry for comparisons
Message-ID: <20250704042504.GQ1880847@ZenIV>
References: <20250702212917.GK3406663@ZenIV>
 <b3ff59d4-c6c3-4b48-97e3-d32e98c12de7@broadcom.com>
 <CAAmqgVMmgW4PWy289P4a8N0FSZA+cHybNkKbLzFx_qBQtu8ZHA@mail.gmail.com>
 <CABPRKS8+SabBbobxxtY8ZCK7ix_VLVE1do7SpcRQhO3ctTY19Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPRKS8+SabBbobxxtY8ZCK7ix_VLVE1do7SpcRQhO3ctTY19Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jul 03, 2025 at 01:37:53PM -0700, Justin Tee wrote:
> Hi Al,
> 
> I’m good with the use of enum.  For the if and else if blocks, would
> it be possible to help us out and convert those to switch case
> statements?
> 
> For example,
> 
> switch (kind) {
> case writeGuard :
>     cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wgrd_cnt);
>     break;
> case writeApp:
>     cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wapp_cnt);
>     break;
> …
> default:
>     lpfc_printf_log(...);
> }

Sure, but I'd rather do that as a followup.  Speaking of other fun followups
in the same area: no point storing most of those dentries; debugfs_remove()
takes the entire subtree out, no need to remove them one-by-one and that
was the only use they were left...  Something along the lines of
diff below:

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index fe4fb67eb50c..230f0377c1db 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -744,12 +744,6 @@ struct lpfc_vport {
 	struct lpfc_vmid_priority_info vmid_priority;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	struct dentry *debug_disc_trc;
-	struct dentry *debug_nodelist;
-	struct dentry *debug_nvmestat;
-	struct dentry *debug_scsistat;
-	struct dentry *debug_ioktime;
-	struct dentry *debug_hdwqstat;
 	struct dentry *vport_debugfs_root;
 	struct lpfc_debugfs_trc *disc_trc;
 	atomic_t disc_trc_cnt;
@@ -1349,29 +1343,8 @@ struct lpfc_hba {
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	struct dentry *hba_debugfs_root;
 	atomic_t debugfs_vport_count;
-	struct dentry *debug_multixri_pools;
-	struct dentry *debug_hbqinfo;
-	struct dentry *debug_dumpHostSlim;
-	struct dentry *debug_dumpHBASlim;
-	struct dentry *debug_InjErrLBA;  /* LBA to inject errors at */
-	struct dentry *debug_InjErrNPortID;  /* NPortID to inject errors at */
-	struct dentry *debug_InjErrWWPN;  /* WWPN to inject errors at */
-	struct dentry *debug_writeGuard; /* inject write guard_tag errors */
-	struct dentry *debug_writeApp;   /* inject write app_tag errors */
-	struct dentry *debug_writeRef;   /* inject write ref_tag errors */
-	struct dentry *debug_readGuard;  /* inject read guard_tag errors */
-	struct dentry *debug_readApp;    /* inject read app_tag errors */
-	struct dentry *debug_readRef;    /* inject read ref_tag errors */
-
-	struct dentry *debug_nvmeio_trc;
+
 	struct lpfc_debugfs_nvmeio_trc *nvmeio_trc;
-	struct dentry *debug_hdwqinfo;
-#ifdef LPFC_HDWQ_LOCK_STAT
-	struct dentry *debug_lockstat;
-#endif
-	struct dentry *debug_cgn_buffer;
-	struct dentry *debug_rx_monitor;
-	struct dentry *debug_ras_log;
 	atomic_t nvmeio_trc_cnt;
 	uint32_t nvmeio_trc_size;
 	uint32_t nvmeio_trc_output_idx;
@@ -1388,7 +1361,6 @@ struct lpfc_hba {
 	sector_t lpfc_injerr_lba;
 #define LPFC_INJERR_LBA_OFF	(sector_t)(-1)
 
-	struct dentry *debug_slow_ring_trc;
 	struct lpfc_debugfs_trc *slow_ring_trc;
 	atomic_t slow_ring_trc_cnt;
 	/* iDiag debugfs sub-directory */
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 55ff030ca6cd..51f74a0735dc 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -6055,6 +6055,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 	char name[64];
 	uint32_t num, i;
 	bool pport_setup = false;
+	struct dentry *dentry;
 
 	if (!lpfc_debugfs_enable)
 		return;
@@ -6077,25 +6078,23 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		atomic_set(&phba->debugfs_vport_count, 0);
 
 		/* Multi-XRI pools */
-		snprintf(name, sizeof(name), "multixripools");
-		phba->debug_multixri_pools =
-			debugfs_create_file(name, S_IFREG | 0644,
+		dentry =
+			debugfs_create_file("multixripools", S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba,
 					    &lpfc_debugfs_op_multixripools);
-		if (IS_ERR(phba->debug_multixri_pools)) {
+		if (IS_ERR(dentry)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "0527 Cannot create debugfs multixripools\n");
 			goto debug_failed;
 		}
 
 		/* Congestion Info Buffer */
-		scnprintf(name, sizeof(name), "cgn_buffer");
-		phba->debug_cgn_buffer =
-			debugfs_create_file(name, S_IFREG | 0644,
+		dentry =
+			debugfs_create_file("cgn_buffer", S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_cgn_buffer_op);
-		if (IS_ERR(phba->debug_cgn_buffer)) {
+		if (IS_ERR(dentry)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6527 Cannot create debugfs "
 					 "cgn_buffer\n");
@@ -6103,12 +6102,11 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		}
 
 		/* RX Monitor */
-		scnprintf(name, sizeof(name), "rx_monitor");
-		phba->debug_rx_monitor =
-			debugfs_create_file(name, S_IFREG | 0644,
+		dentry =
+			debugfs_create_file("rx_monitor", S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_rx_monitor_op);
-		if (IS_ERR(phba->debug_rx_monitor)) {
+		if (IS_ERR(dentry)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6528 Cannot create debugfs "
 					 "rx_monitor\n");
@@ -6116,12 +6114,11 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		}
 
 		/* RAS log */
-		snprintf(name, sizeof(name), "ras_log");
-		phba->debug_ras_log =
-			debugfs_create_file(name, 0644,
+		dentry =
+			debugfs_create_file("ras_log", 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_ras_log);
-		if (IS_ERR(phba->debug_ras_log)) {
+		if (IS_ERR(dentry)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6148 Cannot create debugfs"
 					 " ras_log\n");
@@ -6129,92 +6126,74 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		}
 
 		/* Setup hbqinfo */
-		snprintf(name, sizeof(name), "hbqinfo");
-		phba->debug_hbqinfo =
-			debugfs_create_file(name, S_IFREG | 0644,
-					    phba->hba_debugfs_root,
-					    phba, &lpfc_debugfs_op_hbqinfo);
+		debugfs_create_file("hbqinfo", S_IFREG | 0644,
+				    phba->hba_debugfs_root,
+				    phba, &lpfc_debugfs_op_hbqinfo);
 
 #ifdef LPFC_HDWQ_LOCK_STAT
 		/* Setup lockstat */
-		snprintf(name, sizeof(name), "lockstat");
-		phba->debug_lockstat =
-			debugfs_create_file(name, S_IFREG | 0644,
+		dentry =
+			debugfs_create_file("lockstat", S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_op_lockstat);
-		if (IS_ERR(phba->debug_lockstat)) {
+		if (IS_ERR(dentry)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "4610 Can't create debugfs lockstat\n");
 			goto debug_failed;
 		}
 #endif
 
-		/* Setup dumpHBASlim */
 		if (phba->sli_rev < LPFC_SLI_REV4) {
-			snprintf(name, sizeof(name), "dumpHBASlim");
-			phba->debug_dumpHBASlim =
-				debugfs_create_file(name,
+			/* Setup dumpHBASlim */
+			debugfs_create_file("dumpHBASlim",
 					S_IFREG|S_IRUGO|S_IWUSR,
 					phba->hba_debugfs_root,
 					phba, &lpfc_debugfs_op_dumpHBASlim);
-		} else
-			phba->debug_dumpHBASlim = NULL;
+		}
 
-		/* Setup dumpHostSlim */
 		if (phba->sli_rev < LPFC_SLI_REV4) {
-			snprintf(name, sizeof(name), "dumpHostSlim");
-			phba->debug_dumpHostSlim =
-				debugfs_create_file(name,
+			/* Setup dumpHostSlim */
+			debugfs_create_file("dumpHostSlim",
 					S_IFREG|S_IRUGO|S_IWUSR,
 					phba->hba_debugfs_root,
 					phba, &lpfc_debugfs_op_dumpHostSlim);
-		} else
-			phba->debug_dumpHostSlim = NULL;
+		}
 
 		/* Setup DIF Error Injections */
-		phba->debug_InjErrLBA =
-			debugfs_create_file_aux_num("InjErrLBA", 0644,
+		debugfs_create_file_aux_num("InjErrLBA", 0644,
 			phba->hba_debugfs_root,
 			phba, InjErrLBA, &lpfc_debugfs_op_dif_err);
 		phba->lpfc_injerr_lba = LPFC_INJERR_LBA_OFF;
 
-		phba->debug_InjErrNPortID =
-			debugfs_create_file_aux_num("InjErrNPortID", 0644,
+		debugfs_create_file_aux_num("InjErrNPortID", 0644,
 			phba->hba_debugfs_root,
 			phba, InjErrNPortID, &lpfc_debugfs_op_dif_err);
 
-		phba->debug_InjErrWWPN =
-			debugfs_create_file_aux_num("InjErrWWPN", 0644,
+		debugfs_create_file_aux_num("InjErrWWPN", 0644,
 			phba->hba_debugfs_root,
 			phba, InjErrWWPN, &lpfc_debugfs_op_dif_err);
 
-		phba->debug_writeGuard =
-			debugfs_create_file_aux_num("writeGuardInjErr", 0644,
+		debugfs_create_file_aux_num("writeGuardInjErr", 0644,
 			phba->hba_debugfs_root,
 			phba, writeGuard, &lpfc_debugfs_op_dif_err);
 
-		phba->debug_writeApp =
-			debugfs_create_file_aux_num("writeAppInjErr", 0644,
+		debugfs_create_file_aux_num("writeAppInjErr", 0644,
 			phba->hba_debugfs_root,
 			phba, writeApp, &lpfc_debugfs_op_dif_err);
 
-		phba->debug_writeRef =
-			debugfs_create_file_aux_num("writeRefInjErr", 0644,
+		debugfs_create_file_aux_num("writeRefInjErr", 0644,
 			phba->hba_debugfs_root,
 			phba, writeRef, &lpfc_debugfs_op_dif_err);
 
-		phba->debug_readGuard =
-			debugfs_create_file_aux_num("readGuardInjErr", 0644,
+		debugfs_create_file_aux_num("readGuardInjErr", 0644,
 			phba->hba_debugfs_root,
 			phba, readGuard, &lpfc_debugfs_op_dif_err);
 
-		phba->debug_readApp =
-			debugfs_create_file_aux_num("readAppInjErr", 0644,
+		debugfs_create_file_aux_num("readAppInjErr", 0644,
 			phba->hba_debugfs_root,
 			phba, readApp, &lpfc_debugfs_op_dif_err);
 
-		phba->debug_readRef =
-			debugfs_create_file_aux_num("readRefInjErr", 0644,
+		debugfs_create_file_aux_num("readRefInjErr", 0644,
 			phba->hba_debugfs_root,
 			phba, readRef, &lpfc_debugfs_op_dif_err);
 
@@ -6235,9 +6214,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			}
 		}
 
-		snprintf(name, sizeof(name), "slow_ring_trace");
-		phba->debug_slow_ring_trc =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+		debugfs_create_file("slow_ring_trace", S_IFREG|S_IRUGO|S_IWUSR,
 				 phba->hba_debugfs_root,
 				 phba, &lpfc_debugfs_op_slow_ring_trc);
 		if (!phba->slow_ring_trc) {
@@ -6254,9 +6231,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			atomic_set(&phba->slow_ring_trc_cnt, 0);
 		}
 
-		snprintf(name, sizeof(name), "nvmeio_trc");
-		phba->debug_nvmeio_trc =
-			debugfs_create_file(name, 0644,
+		debugfs_create_file("nvmeio_trc", 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_op_nvmeio_trc);
 
@@ -6337,48 +6312,38 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 	}
 	atomic_set(&vport->disc_trc_cnt, 0);
 
-	snprintf(name, sizeof(name), "discovery_trace");
-	vport->debug_disc_trc =
-		debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+	debugfs_create_file("discovery_trace", S_IFREG|S_IRUGO|S_IWUSR,
 				 vport->vport_debugfs_root,
 				 vport, &lpfc_debugfs_op_disc_trc);
-	snprintf(name, sizeof(name), "nodelist");
-	vport->debug_nodelist =
-		debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+	debugfs_create_file("nodelist", S_IFREG|S_IRUGO|S_IWUSR,
 				 vport->vport_debugfs_root,
 				 vport, &lpfc_debugfs_op_nodelist);
 
-	snprintf(name, sizeof(name), "nvmestat");
-	vport->debug_nvmestat =
-		debugfs_create_file(name, 0644,
+	debugfs_create_file("nvmestat", 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_nvmestat);
 
-	snprintf(name, sizeof(name), "scsistat");
-	vport->debug_scsistat =
-		debugfs_create_file(name, 0644,
+	dentry =
+		debugfs_create_file("scsistat", 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_scsistat);
-	if (IS_ERR(vport->debug_scsistat)) {
+	if (IS_ERR(dentry)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "4611 Cannot create debugfs scsistat\n");
 		goto debug_failed;
 	}
 
-	snprintf(name, sizeof(name), "ioktime");
-	vport->debug_ioktime =
-		debugfs_create_file(name, 0644,
+	dentry =
+		debugfs_create_file("ioktime", 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_ioktime);
-	if (IS_ERR(vport->debug_ioktime)) {
+	if (IS_ERR(dentry)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "0815 Cannot create debugfs ioktime\n");
 		goto debug_failed;
 	}
 
-	snprintf(name, sizeof(name), "hdwqstat");
-	vport->debug_hdwqstat =
-		debugfs_create_file(name, 0644,
+	debugfs_create_file("hdwqstat", 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_hdwqstat);
 
@@ -6499,24 +6464,6 @@ lpfc_debugfs_terminate(struct lpfc_vport *vport)
 	kfree(vport->disc_trc);
 	vport->disc_trc = NULL;
 
-	debugfs_remove(vport->debug_disc_trc); /* discovery_trace */
-	vport->debug_disc_trc = NULL;
-
-	debugfs_remove(vport->debug_nodelist); /* nodelist */
-	vport->debug_nodelist = NULL;
-
-	debugfs_remove(vport->debug_nvmestat); /* nvmestat */
-	vport->debug_nvmestat = NULL;
-
-	debugfs_remove(vport->debug_scsistat); /* scsistat */
-	vport->debug_scsistat = NULL;
-
-	debugfs_remove(vport->debug_ioktime); /* ioktime */
-	vport->debug_ioktime = NULL;
-
-	debugfs_remove(vport->debug_hdwqstat); /* hdwqstat */
-	vport->debug_hdwqstat = NULL;
-
 	if (vport->vport_debugfs_root) {
 		debugfs_remove(vport->vport_debugfs_root); /* vportX */
 		vport->vport_debugfs_root = NULL;
@@ -6525,68 +6472,9 @@ lpfc_debugfs_terminate(struct lpfc_vport *vport)
 
 	if (atomic_read(&phba->debugfs_vport_count) == 0) {
 
-		debugfs_remove(phba->debug_multixri_pools); /* multixripools*/
-		phba->debug_multixri_pools = NULL;
-
-		debugfs_remove(phba->debug_hbqinfo); /* hbqinfo */
-		phba->debug_hbqinfo = NULL;
-
-		debugfs_remove(phba->debug_cgn_buffer);
-		phba->debug_cgn_buffer = NULL;
-
-		debugfs_remove(phba->debug_rx_monitor);
-		phba->debug_rx_monitor = NULL;
-
-		debugfs_remove(phba->debug_ras_log);
-		phba->debug_ras_log = NULL;
-
-#ifdef LPFC_HDWQ_LOCK_STAT
-		debugfs_remove(phba->debug_lockstat); /* lockstat */
-		phba->debug_lockstat = NULL;
-#endif
-		debugfs_remove(phba->debug_dumpHBASlim); /* HBASlim */
-		phba->debug_dumpHBASlim = NULL;
-
-		debugfs_remove(phba->debug_dumpHostSlim); /* HostSlim */
-		phba->debug_dumpHostSlim = NULL;
-
-		debugfs_remove(phba->debug_InjErrLBA); /* InjErrLBA */
-		phba->debug_InjErrLBA = NULL;
-
-		debugfs_remove(phba->debug_InjErrNPortID);
-		phba->debug_InjErrNPortID = NULL;
-
-		debugfs_remove(phba->debug_InjErrWWPN); /* InjErrWWPN */
-		phba->debug_InjErrWWPN = NULL;
-
-		debugfs_remove(phba->debug_writeGuard); /* writeGuard */
-		phba->debug_writeGuard = NULL;
-
-		debugfs_remove(phba->debug_writeApp); /* writeApp */
-		phba->debug_writeApp = NULL;
-
-		debugfs_remove(phba->debug_writeRef); /* writeRef */
-		phba->debug_writeRef = NULL;
-
-		debugfs_remove(phba->debug_readGuard); /* readGuard */
-		phba->debug_readGuard = NULL;
-
-		debugfs_remove(phba->debug_readApp); /* readApp */
-		phba->debug_readApp = NULL;
-
-		debugfs_remove(phba->debug_readRef); /* readRef */
-		phba->debug_readRef = NULL;
-
 		kfree(phba->slow_ring_trc);
 		phba->slow_ring_trc = NULL;
 
-		/* slow_ring_trace */
-		debugfs_remove(phba->debug_slow_ring_trc);
-		phba->debug_slow_ring_trc = NULL;
-
-		debugfs_remove(phba->debug_nvmeio_trc);
-		phba->debug_nvmeio_trc = NULL;
-
 		kfree(phba->nvmeio_trc);
 		phba->nvmeio_trc = NULL;
 
@@ -6594,40 +6482,14 @@ lpfc_debugfs_terminate(struct lpfc_vport *vport)
 		 * iDiag release
 		 */
 		if (phba->sli_rev == LPFC_SLI_REV4) {
-			/* iDiag extAcc */
-			debugfs_remove(phba->idiag_ext_acc);
 			phba->idiag_ext_acc = NULL;
-
-			/* iDiag mbxAcc */
-			debugfs_remove(phba->idiag_mbx_acc);
 			phba->idiag_mbx_acc = NULL;
-
-			/* iDiag ctlAcc */
-			debugfs_remove(phba->idiag_ctl_acc);
 			phba->idiag_ctl_acc = NULL;
-
-			/* iDiag drbAcc */
-			debugfs_remove(phba->idiag_drb_acc);
 			phba->idiag_drb_acc = NULL;
-
-			/* iDiag queAcc */
-			debugfs_remove(phba->idiag_que_acc);
 			phba->idiag_que_acc = NULL;
-
-			/* iDiag queInfo */
-			debugfs_remove(phba->idiag_que_info);
 			phba->idiag_que_info = NULL;
-
-			/* iDiag barAcc */
-			debugfs_remove(phba->idiag_bar_acc);
 			phba->idiag_bar_acc = NULL;
-
-			/* iDiag pciCfg */
-			debugfs_remove(phba->idiag_pci_cfg);
 			phba->idiag_pci_cfg = NULL;
-
-			/* Finally remove the iDiag debugfs root */
-			debugfs_remove(phba->idiag_root);
 			phba->idiag_root = NULL;
 		}
 

