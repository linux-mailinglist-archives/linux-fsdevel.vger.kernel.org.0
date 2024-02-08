Return-Path: <linux-fsdevel+bounces-10794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3804D84E65E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF5B1F2153C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D7128814;
	Thu,  8 Feb 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKaN+mxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42F1272D9
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412167; cv=none; b=rAiVVkzuwghVR+y9xyRwq1Iu0kv7OlNB2ULA1YCRlyW71XiT1OZ0a8XDA+8EuSM6aBRCIt4gxxH2gYsRvnJhTZ5+E9sRwAhB1wez8wKrwyQnxEln5obQ2ak8Kb0GeHoIyfO+8pxdby+Z3El9b6o3K7EJcT1YGeA5V7UcFoVAxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412167; c=relaxed/simple;
	bh=QUKnk3aeLb9Iu+jJWJx+era6l65ExSNSKpQ5BCS0Zdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7F5ko5kQOTR85Y5hpXdcsNuMopfDD0Cjhs7SkT9/q3zuGqqt/SgBjmGit8ISENohb0gcWvhXtFyzes4UupdsNVRFB1hMx427EachpYdPQqwPlLS4EId7rvOCy+fADsDnK/nTWqimhQkUPxuLmKfy9SIhOWVU8k/EUz2xrYGpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKaN+mxt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4103b399487so720885e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412162; x=1708016962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGHcduAU2FCTrg07J81JxO0dr5wVJjkbc9QvOw5ssd0=;
        b=XKaN+mxtsVJLtDkjsxeQewwvcQDSA8BkzojaDINRmLhuUWrXq6Sm9C4QossCYxDp9J
         XAuZ3KWNat8xeBfbODAUY4vWz6ndXVjSBzYjGUMj9HAcPKk8a5hwUNbbY8tNndIZc98o
         PQcEU9iwDT7qzBnKSzBxb7eCOXVP29dU9RzEJweK6YQr7em4jrN8Oku1INUM+LhzZeUC
         vSbwmenynnCuV98hWDEaJvxo4w7y4EZn7OnYjlJ6QHSidrtdoms49GJsNTVoeg0yhtvC
         hx7f52L0/i9vFOssMuM/v+ZsrizdTGro7atqAzc1650aVZ9qbS68qIdcg4ec4ywvDtle
         /psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412162; x=1708016962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGHcduAU2FCTrg07J81JxO0dr5wVJjkbc9QvOw5ssd0=;
        b=t/gJzy5yvs2HwX+403x3m2lWGjonYUifLXdSBuSIjNP8EUmVN3bXmmMazsYESdmkOF
         RAdHvQKq6+ZBNZeuRTYw9bJbzwgsaTUKRVTqOWBiHYBSdzrcZpRCEhXvls1yTfGVQPJa
         lKnGqYFGac9ojKZpl5WnE+4sSThFK4Zxx7NLHu/U2ak12SaxoQZZ75ZuUq7Ni1YBTaQP
         Nh2TVREAjEFePhwtKKzPK//8BJgeoah2Ry3Ui1DjJCJml2JDZcDMHC4mrky/5nn6YYi0
         pn2MdSb22GQ7RNT/KARGaZfcdyOiBNqkGWJnO/X4f4PNdUV6nT5HDGIcLPNwyNyBS0J/
         c8Mg==
X-Gm-Message-State: AOJu0YzVPjlBk2DUzHEuCMVC7rAVDQtqjceMs6xR5+jrF8kERf+QZsAt
	hrJhetWaVcxy/3L43Wm2DEA54HlNMn0au2CsTCIz5Qmn9Q+/sjUFY21wlgmm
X-Google-Smtp-Source: AGHT+IGVQaelpvnWY8GoRHQGj8nd4WDFhvG9odQeRh3YqnurXrVxToYwtC7OoZoxh12U99v9h+8cuw==
X-Received: by 2002:a05:6000:1a88:b0:33b:4439:762e with SMTP id f8-20020a0560001a8800b0033b4439762emr75445wry.53.1707412162481;
        Thu, 08 Feb 2024 09:09:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbQ7M7IIX7D9yVJvFn6ZwETjZwvEjkTA1gMPhtIClGk10CwvhctEcPz6CeUGKE5CR6zLkufC58UPY+LLEXQ3lJFITSsdFRhxhikY/iHWStEgtz4pvSpW6ID19XD0KyIwc=
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:09:19 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
Date: Thu,  8 Feb 2024 19:06:03 +0200
Message-Id: <20240208170603.2078871-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170603.2078871-1-amir73il@gmail.com>
References: <20240208170603.2078871-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of denying caching mode on parallel dio open, deny caching
open only while parallel dio are in-progress and wait for in-progress
parallel dio writes before entering inode caching io mode.

This allows executing parallel dio when inode is not in caching mode
even if shared mmap is allowed, but no mmaps have been performed on
the inode in question.

An mmap on direct_io file now waits for all in-progress parallel dio
writes to complete, so parallel dio writes together with
FUSE_DIRECT_IO_ALLOW_MMAP is enabled by this commit.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c   | 28 ++++++++++++++++++++--------
 fs/fuse/fuse_i.h |  3 +++
 fs/fuse/iomode.c | 45 ++++++++++++++++++++++++++++++++++++---------
 3 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 29e18e5a6f6c..eb226457c4bd 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1335,6 +1335,7 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* server side has to advise that it supports parallel dio writes */
 	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
@@ -1346,11 +1347,9 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	if (iocb->ki_flags & IOCB_APPEND)
 		return true;
 
-	/* combination opf page access and direct-io difficult, shared
-	 * locks actually introduce a conflict.
-	 */
-	if (get_fuse_conn(inode)->direct_io_allow_mmap)
-		return true;
+	/* shared locks are not allowed with parallel page cache IO */
+	if (test_bit(FUSE_I_CACHE_IO_MODE, &fi->state))
+		return false;
 
 	/* parallel dio beyond eof is at least for now not supported */
 	if (fuse_io_past_eof(iocb, from))
@@ -1370,10 +1369,14 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
 	} else {
 		inode_lock_shared(inode);
 		/*
-		 * Previous check was without inode lock and might have raced,
-		 * check again.
+		 * New parallal dio allowed only if inode is not in caching
+		 * mode and denies new opens in caching mode. This check
+		 * should be performed only after taking shared inode lock.
+		 * Previous past eof check was without inode lock and might
+		 * have raced, so check it again.
 		 */
-		if (fuse_io_past_eof(iocb, from)) {
+		if (fuse_io_past_eof(iocb, from) ||
+		    fuse_file_uncached_io_start(inode) != 0) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			*exclusive = true;
@@ -1386,6 +1389,8 @@ static void fuse_dio_unlock(struct inode *inode, bool exclusive)
 	if (exclusive) {
 		inode_unlock(inode);
 	} else {
+		/* Allow opens in caching mode after last parallel dio end */
+		fuse_file_uncached_io_end(inode);
 		inode_unlock_shared(inode);
 	}
 }
@@ -2521,6 +2526,10 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+	/*
+	 * FOPEN_DIRECT_IO handling is special compared to O_DIRECT,
+	 * as does not allow MAP_SHARED mmap without FUSE_DIRECT_IO_ALLOW_MMAP.
+	 */
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/*
 		 * Can't provide the coherency needed for MAP_SHARED
@@ -2533,6 +2542,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 		/*
 		 * First mmap of direct_io file enters caching inode io mode.
+		 * Also waits for parallel dio writers to go into serial mode
+		 * (exclusive instead of shared lock).
 		 */
 		rc = fuse_file_io_mmap(ff, file_inode(file));
 		if (rc)
@@ -3312,6 +3323,7 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	fi->writectr = 0;
 	fi->iocachectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
+	init_waitqueue_head(&fi->direct_io_waitq);
 	fi->writepages = RB_ROOT;
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5e5465f6a1ac..dede4378c719 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -129,6 +129,9 @@ struct fuse_inode {
 			/* Waitq for writepage completion */
 			wait_queue_head_t page_waitq;
 
+			/* waitq for direct-io completion */
+			wait_queue_head_t direct_io_waitq;
+
 			/* List of writepage requestst (pending or sent) */
 			struct rb_root writepages;
 		};
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 13faae77aec4..acd0833ae873 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -12,18 +12,45 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 
+/*
+ * Return true if need to wait for new opens in caching mode.
+ */
+static inline bool fuse_is_io_cache_wait(struct fuse_inode *fi)
+{
+	return READ_ONCE(fi->iocachectr) < 0;
+}
+
 /*
  * Request an open in caching mode.
+ * Blocks new parallel dio writes and waits for the in-progress parallel dio
+ * writes to complete.
  * Return 0 if in caching mode.
  */
 static int fuse_inode_get_io_cache(struct fuse_inode *fi)
 {
+	int err = 0;
+
 	assert_spin_locked(&fi->lock);
-	if (fi->iocachectr < 0)
-		return -ETXTBSY;
-	if (fi->iocachectr++ == 0)
-		set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
-	return 0;
+	/*
+	 * Setting the bit advises new direct-io writes to use an exclusive
+	 * lock - without it the wait below might be forever.
+	 */
+	set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+	while (!err && fuse_is_io_cache_wait(fi)) {
+		spin_unlock(&fi->lock);
+		err = wait_event_killable(fi->direct_io_waitq,
+					  !fuse_is_io_cache_wait(fi));
+		spin_lock(&fi->lock);
+	}
+	/*
+	 * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
+	 * failed to enter caching mode and no other caching open exists.
+	 */
+	if (!err)
+		fi->iocachectr++;
+	else if (fi->iocachectr <= 0)
+		clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+	return err;
 }
 
 /*
@@ -102,10 +129,13 @@ int fuse_file_uncached_io_start(struct inode *inode)
 void fuse_file_uncached_io_end(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	int uncached_io;
 
 	spin_lock(&fi->lock);
-	fuse_inode_allow_io_cache(fi);
+	uncached_io = fuse_inode_allow_io_cache(fi);
 	spin_unlock(&fi->lock);
+	if (!uncached_io)
+		wake_up(&fi->direct_io_waitq);
 }
 
 /* Open flags to determine regular file io mode */
@@ -155,13 +185,10 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 
 	/*
 	 * First caching file open enters caching inode io mode.
-	 * First parallel dio open denies caching inode io mode.
 	 */
 	err = 0;
 	if (ff->open_flags & FOPEN_CACHE_IO)
 		err = fuse_file_cached_io_start(inode);
-	else if (ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES)
-		err = fuse_file_uncached_io_start(inode);
 	if (err)
 		goto fail;
 
-- 
2.34.1


