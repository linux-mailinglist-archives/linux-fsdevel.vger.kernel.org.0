Return-Path: <linux-fsdevel+bounces-16328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39D989B2C6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 17:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50E11C217CA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B503B19D;
	Sun,  7 Apr 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS11HWy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970C3A1B7
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Apr 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712505492; cv=none; b=TdlGDJxUl+uHxUGeib4Otcg4NF4xmrYqMKlcCEu9QCNsE26fmwBx8XSdldjvNMPzFS3axFdP/2KvWm47r9cD4GCB2JYdwySCZEnZUgaKxM/W3Q4qdsp8siKuIva/JORBiOCGOpKLKsD2zd95bR4aTJNyNwcotxVXlsaVqdgI/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712505492; c=relaxed/simple;
	bh=2RB7aCpvRNi3CpO0NVu4JmmmtVRk76Wi9Ey3HAwc98E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvutkEwssmavDzD+sKovzpHdrH69Ud47SCQ7H2NCYSQ3FRuKn4PWh2KWzicW0OrUPMDcJXVg/0GSHL3yE5iYJFa5/dfxM6wCFCuKAgorrS2qgXbRkgiz1bpoD33j45uAd5wCZEmNu602iGFtidXcib0rHgyQApBKP0ggP9nlH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS11HWy+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-416422e2acbso3939535e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Apr 2024 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712505489; x=1713110289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoB7qwdRKF7zMGwT3LQb5Uv+Fqh+J1qYEva17V7RWW4=;
        b=IS11HWy+BPQIHQlpbFLBVjilsojiyhN5Nw7hXM797GGZ5+KHLDaImf/7i9OO/lKya2
         O59cW67m6oP0+/un+B78nNZySyycdjbxGvRo0UX03ueECM1YcnxEJBEu2Hwoax5E6mhZ
         nzUxxIoGwv592rb9SUARpSOrulvQH32Uhq2aHUUN5doSmRXJJMiiSd4j3IKTe+JIFRgQ
         j/jQjI4AL6I0vesZhYkn01ZvDyAc7cGcilDbV3dAgmRtxlNvjuwvnZ4dGYCJNMwOHps9
         fg8PXoQtDUyCAz+Q3AiJvDbeneFAJNWun5yspe67dqWUvl79aUd7l47THMO6ony+zHTT
         QgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712505489; x=1713110289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoB7qwdRKF7zMGwT3LQb5Uv+Fqh+J1qYEva17V7RWW4=;
        b=D+Mb5rdMs/dnXsX/UeNYWNUoh3ICTADlmHw1EK/MgFE1JXUvwAO7Brk+7g11sxWXcP
         CBDlzudYyghc6Q7I+IfU9AcK6Q33r54tbuxbNKjwVGd7JWAUhBk4a2bNv7Uj7dD2Hla1
         ZEIZBF32jbaYgV09Tv3tQhVq2yu0D1dvemAmG1f18DyIS2qfEshLxZV6C5Tu1g7BWGUu
         jFi4bf5CH6ElBu/ZYdUAOVyuCuQS9u1/00G3Z25EYXc2SsukBR53MzMLPzyEuNn+amRY
         nKjvD8TTmmXXoXJzoBCKnlwef9DJLtGe4m4EKnKH3iUf26pgWOmzhdeaXYo7kOgqb5UT
         FXlg==
X-Forwarded-Encrypted: i=1; AJvYcCXvzVZg/90RKUpztNAJgbiiu8sak2rGzLp/AW8F89ztPjmGrxAhVlSjjhHuqzSSfkJFRIwnTAXqIqcl9ymlIel+k7/qf/sLeRZ6iosLLA==
X-Gm-Message-State: AOJu0YyP/bzuFYTTrpIxyvEteSFW2i06mkvluxYhtyEbV9fBcRaB0Rf2
	qNXwThlHCNoINoeSKm43KYKQea9obmllxcVvvL5qvDGmxO7bjOJr
X-Google-Smtp-Source: AGHT+IHbdvcwNSsVDKLzs7rsg6sfHAXNjeTOJP2qNYpzXLBKcna8K8Vlw2TtvOuPUjP6w8dV0v8TKg==
X-Received: by 2002:a05:600c:1c9c:b0:416:6a35:d96c with SMTP id k28-20020a05600c1c9c00b004166a35d96cmr518222wms.20.1712505488337;
        Sun, 07 Apr 2024 08:58:08 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b0041645193a55sm4600171wms.21.2024.04.07.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 08:58:08 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] fuse: prepare for long lived reference on backing file
Date: Sun,  7 Apr 2024 18:57:58 +0300
Message-Id: <20240407155758.575216-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407155758.575216-1-amir73il@gmail.com>
References: <20240407155758.575216-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently backing file is associated to fuse inode on the first
passthrough open of the inode and detached on last passthourgh close.

In preparation for attaching a backing file on lookup, allow attaching
a long lived (single) reference on fuse inode backing file that will be
dropped on fuse inode evict.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c   |  2 +-
 fs/fuse/fuse_i.h |  5 ++++-
 fs/fuse/inode.c  |  6 ++++++
 fs/fuse/iomode.c | 14 +++++++++++---
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index fcf20b304093..347bae2b287f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1377,7 +1377,7 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
 		 * have raced, so check it again.
 		 */
 		if (fuse_io_past_eof(iocb, from) ||
-		    fuse_inode_uncached_io_start(fi, NULL) != 0) {
+		    fuse_inode_uncached_io_start(fi, NULL, false) != 0) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			*exclusive = true;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..2f340fd05e8a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -209,6 +209,8 @@ enum {
 	FUSE_I_BTIME,
 	/* Wants or already has page cache IO */
 	FUSE_I_CACHE_IO_MODE,
+	/* Long lived backing file */
+	FUSE_I_BACKING,
 };
 
 struct fuse_conn;
@@ -1396,7 +1398,8 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 /* iomode.c */
 int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
 int fuse_inode_uncached_io_start(struct fuse_inode *fi,
-				 struct fuse_backing *fb);
+				 struct fuse_backing *fb,
+				 bool keep_fb);
 void fuse_inode_uncached_io_end(struct fuse_inode *fi);
 
 int fuse_file_io_open(struct file *file, struct inode *inode);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..989a84f6a825 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -175,6 +175,12 @@ static void fuse_evict_inode(struct inode *inode)
 		}
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
+		/* fuse inode may have a long lived reference to backing file */
+		if (fuse_inode_backing(fi)) {
+			WARN_ON(!test_bit(FUSE_I_BACKING, &fi->state));
+			fuse_inode_uncached_io_end(fi);
+		}
+
 		WARN_ON(fi->iocachectr != 0);
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index f9e30c4540af..b1ff43668800 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -80,8 +80,14 @@ static void fuse_file_cached_io_release(struct fuse_file *ff,
 	spin_unlock(&fi->lock);
 }
 
-/* Start strictly uncached io mode where cache access is not allowed */
-int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
+/*
+ * Start strictly uncached io mode where cache access is not allowed.
+ *
+ * With @keep_fb true, the backing file reference is expected to be dropped
+ * on inode evict.
+ */
+int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb,
+				 bool keep_fb)
 {
 	struct fuse_backing *oldfb;
 	int err = 0;
@@ -103,6 +109,8 @@ int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
 	if (fb && !oldfb) {
 		oldfb = fuse_inode_backing_set(fi, fb);
 		WARN_ON_ONCE(oldfb != NULL);
+		if (keep_fb)
+			set_bit(FUSE_I_BACKING, &fi->state);
 	} else {
 		fuse_backing_put(fb);
 	}
@@ -119,7 +127,7 @@ static int fuse_file_uncached_io_open(struct inode *inode,
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	int err;
 
-	err = fuse_inode_uncached_io_start(fi, fb);
+	err = fuse_inode_uncached_io_start(fi, fb, false);
 	if (err)
 		return err;
 
-- 
2.34.1


