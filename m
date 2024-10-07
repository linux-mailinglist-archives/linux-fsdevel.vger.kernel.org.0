Return-Path: <linux-fsdevel+bounces-31234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B36993540
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E1C1F243B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27611DDC15;
	Mon,  7 Oct 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aUo3EI4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10F1DDA18
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323043; cv=none; b=Y3Jy7T7Z62NA9GYn5LLXt1zLq2v9W4ylDaC4JBr9uu6uzV2UEGHGCF7IDE7n3vtOz6Tp8fEU+kgXyzYBup/qYqIUiotNqDH9F7+vFifBV2Rpu+ytUfJXc0TqQ1DACLToPWJh1SvT9EQH60f1sWxJLumZDgFyN07/IUuwKI3TpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323043; c=relaxed/simple;
	bh=aPsGVV8Ha88fWWGj7Wjwa2DKgoF9uJ5K6baBRR6lMVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bzv7Rcgjed72rxDxcOGM3Qlq+yueF73Zfjv60h96lIulgQKKd+YpAfIPIQrbR0mgGRADWR8PbHAbx2/FH8n4ucF8iePy2qaIJ4vSsU+JKsyPshmRImI0JSA1T10TWt/Jmxnw4+IMhM4Ty6/LYa+hDJQeYxUp6kcnWkSGFWGFVjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aUo3EI4r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ta1pEMIIHL1YVEt/0IJ1AKn2CUdAEze4AUdeCC7Qtwc=; b=aUo3EI4r0AEUr4epJxPtfBrzTU
	Nv/Ra2pYMSKBKP5+8X85142X74u/z0JQ/ptH6ZcuMsPwvbji3GPmjR/IqsE7gxBt++WzJyjQ1Psez
	OAdNz7+SBW/dyeoTC+J8MtSlE1OkW7skUDiKWOSKHXLJglQXj7K2GJRlI21bqGK4nFJjkaM+kH5ZJ
	YI3UdESPnAn6Tv9HUYau5svGTvmO3xBmladHwYfiecfg+oBBlyc49pkqFdvV0F87+k+ch81bOBAFe
	HLiNMuDdx6vxAtaJX80AQjFfgRSx0MdFFffIxUdNWG1zPDOXGGKGcGUP9LYhNYz3rqyD5C8z3II/y
	29xEt2TA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrm3-00000001f3s-3gpj;
	Mon, 07 Oct 2024 17:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH v3 11/11] expand_files(): simplify calling conventions
Date: Mon,  7 Oct 2024 18:43:58 +0100
Message-ID: <20241007174358.396114-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007174358.396114-1-viro@zeniv.linux.org.uk>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

All callers treat 0 and 1 returned by expand_files() in the same way
now since the call in alloc_fd() had been made conditional.  Just make
it return 0 on success and be done with it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index b63294ed85ec..70cd6d8c6257 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -162,7 +162,7 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
  * Expand the file descriptor table.
  * This function will allocate a new fdtable and both fd array and fdset, of
  * the given size.
- * Return <0 error code on error; 1 on successful completion.
+ * Return <0 error code on error; 0 on successful completion.
  * The files->file_lock should be held on entry, and will be held on exit.
  */
 static int expand_fdtable(struct files_struct *files, unsigned int nr)
@@ -191,15 +191,14 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 		call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
 	/* coupled with smp_rmb() in fd_install() */
 	smp_wmb();
-	return 1;
+	return 0;
 }
 
 /*
  * Expand files.
  * This function will expand the file structures, if the requested size exceeds
  * the current capacity and there is room for expansion.
- * Return <0 error code on error; 0 when nothing done; 1 when files were
- * expanded and execution may have blocked.
+ * Return <0 error code on error; 0 on success.
  * The files->file_lock should be held on entry, and will be held on exit.
  */
 static int expand_files(struct files_struct *files, unsigned int nr)
@@ -207,14 +206,14 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 	__acquires(files->file_lock)
 {
 	struct fdtable *fdt;
-	int expanded = 0;
+	int error;
 
 repeat:
 	fdt = files_fdtable(files);
 
 	/* Do we need to expand? */
 	if (nr < fdt->max_fds)
-		return expanded;
+		return 0;
 
 	/* Can we expand? */
 	if (nr >= sysctl_nr_open)
@@ -222,7 +221,6 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 
 	if (unlikely(files->resize_in_progress)) {
 		spin_unlock(&files->file_lock);
-		expanded = 1;
 		wait_event(files->resize_wait, !files->resize_in_progress);
 		spin_lock(&files->file_lock);
 		goto repeat;
@@ -230,11 +228,11 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 
 	/* All good, so we try */
 	files->resize_in_progress = true;
-	expanded = expand_fdtable(files, nr);
+	error = expand_fdtable(files, nr);
 	files->resize_in_progress = false;
 
 	wake_up_all(&files->resize_wait);
-	return expanded;
+	return error;
 }
 
 static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
@@ -507,12 +505,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 		if (error < 0)
 			goto out;
 
-		/*
-		 * If we needed to expand the fs array we
-		 * might have blocked - try again.
-		 */
-		if (error)
-			goto repeat;
+		goto repeat;
 	}
 
 	if (start <= files->next_fd)
-- 
2.39.5


