Return-Path: <linux-fsdevel+bounces-50630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC73ACE1F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092B7188BD0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675DA1DDC0F;
	Wed,  4 Jun 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j37/eaGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F451624D5
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053367; cv=none; b=BCGpJkHs5BKLCzKvka2kviEfMs9BtggTGEwT3mItSzoGzY7KD3WIzC8Y1HXZwHAcU4PlHRmtscyoR6XaH03yQJCl89YtLKiAsmmMee41kFZjdoQQu1RA7COhI4Mn/ncWxGBg0FUmW7S5vGxN/qLW9efIxTEGpvqyZmzdt0AJH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053367; c=relaxed/simple;
	bh=f+yyF4bpSdpCsSyeUmXvoMRSHUd+GLY3egdeZi9jsOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWf9V2ZT+sWamNbyPWHCzYnoDGR5dT+ZWTYkdu/GqgoYwpxed3yB2GXrrQLijVHo2oado5tiTYrbVSPeIKr8trxY9LT7XOwLwzzcnTtcW9nvpCN049FgD+Hqzu6OAQeHWMwjK2n3/zofM7mPe4RPxsV7qrDLFx3sjnqLiQA+2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j37/eaGx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d6ade159so35680325e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749053364; x=1749658164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6VOOGw3tvwhFzf2D8a/LUUWaF0Jcdxsxw3dkYcvyYg=;
        b=j37/eaGxzXkZ007d+e75JkR5LBG90KZaHg9NrZhBUAMQH/f8rcolRh7Mnx60LBVyCc
         8MF6MH62ah6LgqTEU8r/o6Tuen+JHKFfPRaiF6z8BvSzwe7VIdRNSUmuTPQj3L1kjx8M
         AOz2vlJF/wN+66rsaBTcCafpfhp7ddz8JUl4Tf9pqvSiAGiHiiYtYD2FNBBiAyaOh/8V
         EJACEqC9mUp739zXEtMNTXzwNipVg1V4621temvRGWs0vpEOYw3fQIHIXEofA82uMUhj
         +MbOXxI9zxotpdJo3fh7+I0xU25CKZEzktADJnww/+HhfXs3RkWs2xbambNsBd/29jj/
         X8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749053364; x=1749658164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6VOOGw3tvwhFzf2D8a/LUUWaF0Jcdxsxw3dkYcvyYg=;
        b=WYQuf/DnjPGiomMIqrx5M/+FwRsgarzwtRhB4UiurhcyMFYGUoUR9bH8F0s9VAKxYW
         BfhtzG1iAHj+ytxuuMKZyc3Ny/wvKWB8q7ScuXRx2HCMunKPCuk+inuKA13vxUcGKlJ8
         2OpdY0GApYnftyG1vEvBCFOrrk2HvHWTddBsfZ2r+B6nt+91gI6dU5lCt6MVzdNBut/d
         j0WPo4ZS14gGvlJLp76YDuaRk81NEzXTEFrHkDfLKDQa79p4TtoFHyMVNsuB+No3xsYg
         /gYDyg/3xmHPLKkHyCyLzEGZir3O+lxRbitDjGd0qjLHFV2HxECVPwmAo4SkDUAj52jJ
         0BKA==
X-Forwarded-Encrypted: i=1; AJvYcCVIg69RYx666TxRx4K7XqDQpcQWCIOKEE9kdvLxTD6GsYr4b3bK8fd9tyY0cjJXn3zr1TGkXKC55fM/NJRu@vger.kernel.org
X-Gm-Message-State: AOJu0YwymkK/Ljtz0g7qxb/neYTO6GtL4b8Nb9g2450Vejduob0wZfMc
	OoP3NdihAfdcyeeu/yWSYVLIS9YhCy3JJJPvMVJ62csV6Oyz8G9zwvZO
X-Gm-Gg: ASbGncsdz11Ass6zkzExwKomrpE6fvBWEoojVl9H5qRGLDtQ3ufeV/nkaR4DkCZvwyU
	xeS7bwvjybMxraU7Y/xuzd8OkxAHe7DMEg2Hn/lejiY4ecTPU5JkziNiLzkdUfY5A+rQCVIquLa
	NqIUZKRcV6wcceec2+vdcLSxkQFrS52IvGGFpb3wkg9DNiXZf5Tnt4OkVcux+fqWs/Vp86BoZES
	kb1ZSF9tXITTFNZ6BUXzTLdW5mC94xHk3KvFVfIBwpRJPOur4wOE+nVnO3IEeSsAdylXwLFRMUP
	wbTfHzXOrtezagnS0htREOG/15U/gyJ9OA98KZdznBsuMTyskjRAKbzdtBMsWQwGP1i5BIbJjKP
	dlPGw7iv4BPuqgNLU6lBPhqiw911iHok9eI44pJNfHkW3RBW+
X-Google-Smtp-Source: AGHT+IFdJAXkYyzBATfN4oS3WcnPrTcZyvJdaDrvzGkPgF4D7tElT5O+7qkK1kLVlm6ZXDAB/iJCEA==
X-Received: by 2002:a05:600c:4e43:b0:450:d568:909b with SMTP id 5b1f17b1804b1-451f0a7309cmr35937925e9.14.1749053363937;
        Wed, 04 Jun 2025 09:09:23 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a1678sm22304306f8f.99.2025.06.04.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:09:23 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] fanotify: allow O_PATH flag in event_f_flags
Date: Wed,  4 Jun 2025 18:09:17 +0200
Message-Id: <20250604160918.2170961-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604160918.2170961-1-amir73il@gmail.com>
References: <20250604160918.2170961-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many of the use cases for fanotify events only use the event->fd
to resolve the path of the event target object.

Using O_PATH for this purpose is more efficient and prevents
exposing a readable fd of the object if that is not required.

To be able to distinguish a user opened O_PATH fd, from fanotify
provided O_PATH event->fd, do not explicitly set FMODE_NONOTIFY
on open of all O_PATH fds, do not override FMODE_NONOTIFY when setting
FMODE_PATH in do_dentry_open() and check explicitly for FMODE_PATH in
fsnotify_file() to suppress FAN_CLOSE events on close of O_PATH fds.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c |  2 +-
 fs/open.c                          |  4 ++--
 include/linux/fs.h                 | 10 ++++++----
 include/linux/fsnotify.h           |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9d7b3a610b4a..fd2906a8a15e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -105,7 +105,7 @@ static void __init fanotify_sysctls_init(void)
 #define	FANOTIFY_INIT_ALL_EVENT_F_BITS				( \
 		O_ACCMODE	| O_APPEND	| O_NONBLOCK	| \
 		__O_SYNC	| O_DSYNC	| O_CLOEXEC     | \
-		O_LARGEFILE	| O_NOATIME	)
+		O_LARGEFILE	| O_NOATIME	| O_PATH)
 
 extern const struct fsnotify_ops fanotify_fsnotify_ops;
 
diff --git a/fs/open.c b/fs/open.c
index 7828234a7caa..4664240f4c5e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -913,8 +913,8 @@ static int do_dentry_open(struct file *f,
 	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH | FMODE_OPENED;
-		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
+		f->f_mode = FMODE_PATH | FMODE_OPENED |
+			    FMODE_FSNOTIFY(f->f_mode);
 		f->f_op = &empty_fops;
 		return 0;
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index aad2fb940a45..098456235cb5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -210,14 +210,16 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_FSNOTIFY_MASK \
 	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
 
+#define FMODE_FSNOTIFY(mode) \
+	(mode & FMODE_FSNOTIFY_MASK)
 #define FMODE_FSNOTIFY_NONE(mode) \
-	((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
+	(FMODE_FSNOTIFY(mode) == FMODE_NONOTIFY)
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
 #define FMODE_FSNOTIFY_PERM(mode) \
-	((mode & FMODE_FSNOTIFY_MASK) == 0 || \
-	 (mode & FMODE_FSNOTIFY_MASK) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))
+	(FMODE_FSNOTIFY(mode) == 0 || \
+	 FMODE_FSNOTIFY(mode) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))
 #define FMODE_FSNOTIFY_HSM(mode) \
-	((mode & FMODE_FSNOTIFY_MASK) == 0)
+	(FMODE_FSNOTIFY(mode) == 0)
 #else
 #define FMODE_FSNOTIFY_PERM(mode)	0
 #define FMODE_FSNOTIFY_HSM(mode)	0
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 454d8e466958..175149167642 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -121,7 +121,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 	 * FMODE_PATH fds (involves open & close events) as they are just
 	 * handle creation / destruction events and not "real" file events.
 	 */
-	if (FMODE_FSNOTIFY_NONE(file->f_mode))
+	if (FMODE_FSNOTIFY_NONE(file->f_mode) || (file->f_mode & FMODE_PATH))
 		return 0;
 
 	return fsnotify_path(&file->f_path, mask);
-- 
2.34.1


