Return-Path: <linux-fsdevel+bounces-10791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1684E65B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3131F21EDD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F495128367;
	Thu,  8 Feb 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5l2wUBA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE255128366
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412153; cv=none; b=ZVpCbNcGIujRTTJLQ9ODTRPtkQzEloE5+bW+7rOWHTqUYgfuVK3Z33JIcsZZQyvZrFejMG5Vv+jU/0S8SHdg70zjj6NinjH1Xdry6B26skkqBVdQ/sk6BZh0hp3D2x17Nea6wzdPOofn5R4NLPZu/46kFbSUjfXzRIgV5zBw0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412153; c=relaxed/simple;
	bh=z4sVwTFvfUBbaTKTYQ2MPGQg5ETLgXT5l+qGKqpbucE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MRZF1xEn79F+DpPUT3JGKZ+fUABspswMVq3ETP9H2v/ktOa9w5gut0N7zunnqQDuExNSGWSr1c4YB5RXe+EluygSKUxSnGoroRWISH8b081VSm0Zf+dnGuCBoVhUKRmwdQylzLMQHaHEEJP88Y3dbFLG6nqztAFrLM+sFwHRET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5l2wUBA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso593645e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412150; x=1708016950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUbi7v8dNpq8pAIEyAzbwU09CubXHQJ0djNDUqSE+5A=;
        b=O5l2wUBA/vIdWzVPG7J5a8wXcyn06qvd7XWEqHO9XWZOiLeeq9cII8KotpATsa2LPp
         CIza7Qs4ztGjTmq0/y2ddoJvgzMhijjpk6v9MoBbuh+9p+F7w6/bybyt7aLyNpaq/ueV
         qfRsZNZ+iUyMI7EFqCe9jKZypETYRIwyXMKu2FLLQ/63B+JzjisOr05SU/oqaDeXtEVv
         48bjv5aZq388F8hpujZUGhUSrvg+pvFxLUHF3xRfUhiFh0SWgPygf6UpAshN/yCU1lWA
         omRh95rQefSokvW6BNxPRwcTp6tHRqSSc6RaJYY7C4zMfZw5jeifCvFLk1JKobItsdUM
         MyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412150; x=1708016950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUbi7v8dNpq8pAIEyAzbwU09CubXHQJ0djNDUqSE+5A=;
        b=r5iNzl1lp9eh19QFHpCqiAq8LbIcCXOwMHGJ7rf/NZQ8o5nnSaePDEOeisXRp0zeaz
         7uaKCAhGTE/BGDwKEj+zQbSzQ+7NAmFdrFJB4+30qHUEbjo76ZtsUSFJCMzIppnI2bgW
         slgZtBBCZR20mibPgwTmsBo+lYU8vH6HJ/JODfRCkZ+Q323yp1GhztV+SlEB2hhCgT3K
         donnoHXGXHFkpCiHWUOIf/2lEE1B7WWNvgy9pHNppoOEmzeJs/9Pj1roVwT8EOX/zR/K
         vPhiy3GUoag+UuCNCJAphds9jGhfSHHPK2XcJPmGQZiIZOu3/DPoutHjSJY8aD0uCNJs
         gBDw==
X-Gm-Message-State: AOJu0YxTxBJv11Ns306oyRS1OeRVduvoYEX3VhO5MIPYDWQV98wqk9Yr
	P/YsswwMuSFy7Rn8k0dbW4Aj167lYL0l3322GlHO2WWGZiIBFw0X
X-Google-Smtp-Source: AGHT+IEw9cCs8PfFxL0PP+/3L8bh68Ie8NATV/xG59t5Dhw+VCX5tcLmutxDaBuE3eKIxH7JuCe2Jg==
X-Received: by 2002:a5d:4d89:0:b0:33b:4e6d:1020 with SMTP id b9-20020a5d4d89000000b0033b4e6d1020mr79203wru.34.1707412149955;
        Thu, 08 Feb 2024 09:09:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSKTrp/dccyMlK/5rAWasruJmLBNHslnQN12mJipyA6s++WRufO7TlwKq0slKF9poUa9Srs85a1VycFU1SntxVWqrL+i9V9lrE+DRBBQ==
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:09:04 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 6/9] fuse: break up fuse_open_common()
Date: Thu,  8 Feb 2024 19:06:00 +0200
Message-Id: <20240208170603.2078871-7-amir73il@gmail.com>
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

fuse_open_common() has a lot of code relevant only for regular files and
O_TRUNC in particular.

Copy the little bit of remaining code into fuse_dir_open() and stop using
this common helper for directory open.

Also split out fuse_dir_finish_open() from fuse_finish_open() before we
add inode io modes to fuse_finish_open().

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/dir.c    | 26 +++++++++++++++++++++++++-
 fs/fuse/file.c   |  9 ++-------
 fs/fuse/fuse_i.h |  2 --
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b8fc3a6b87fe..ff324be72abd 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1628,9 +1628,33 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	return ERR_PTR(err);
 }
 
+static void fuse_dir_finish_open(struct inode *inode, struct file *file)
+{
+	struct fuse_file *ff = file->private_data;
+
+	if (ff->open_flags & FOPEN_STREAM)
+		stream_open(inode, file);
+	else if (ff->open_flags & FOPEN_NONSEEKABLE)
+		nonseekable_open(inode, file);
+}
+
 static int fuse_dir_open(struct inode *inode, struct file *file)
 {
-	return fuse_open_common(inode, file, true);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	int err;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	err = generic_file_open(inode, file);
+	if (err)
+		return err;
+
+	err = fuse_do_open(fm, get_node_id(inode), file, true);
+	if (!err)
+		fuse_dir_finish_open(inode, file);
+
+	return err;
 }
 
 static int fuse_dir_release(struct inode *inode, struct file *file)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0ca471c5d184..84b35bbf22ac 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -227,7 +227,7 @@ static void fuse_truncate_update_attr(struct inode *inode, struct file *file)
 	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 }
 
-int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
+static int fuse_open(struct inode *inode, struct file *file)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_conn *fc = fm->fc;
@@ -256,7 +256,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	if (is_wb_truncate || dax_truncate)
 		fuse_set_nowrite(inode);
 
-	err = fuse_do_open(fm, get_node_id(inode), file, isdir);
+	err = fuse_do_open(fm, get_node_id(inode), file, false);
 	if (!err) {
 		fuse_finish_open(inode, file);
 		if (is_truncate)
@@ -354,11 +354,6 @@ void fuse_release_common(struct file *file, bool isdir)
 			  (fl_owner_t) file, isdir);
 }
 
-static int fuse_open(struct inode *inode, struct file *file)
-{
-	return fuse_open_common(inode, file, false);
-}
-
 static int fuse_release(struct inode *inode, struct file *file)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index daf7036cd692..5fe096820e97 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1034,8 +1034,6 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 /**
  * Send OPEN or OPENDIR request
  */
-int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
-
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);
 void fuse_finish_open(struct inode *inode, struct file *file);
-- 
2.34.1


