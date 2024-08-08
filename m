Return-Path: <linux-fsdevel+bounces-25456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E694C52F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B021285F3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EF815A862;
	Thu,  8 Aug 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LY6aieM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA8155A26
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145304; cv=none; b=Z41Szs/c4ETGBO4nSudY/Jq/ktGyEIrSRUQDlvsjgqlSYA58MwpMVwx/FbkThzhXasl3FyJwCzL4lsHe2CUppxwjOKyTPjYmZsAVe6Iht1jBe0WQI1InULlDEjYPyTPMZr69D3OyYocBRmQBse4v5xXcf09PV16PdCFK4MSWXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145304; c=relaxed/simple;
	bh=VnNy26VUpNnims6UXBrv9Si64DHRDQUU01RSugTpPdI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFTg5xA0oo/9266lDEjdP9xW8SL5YDHW6Kyjcm4HI9n52xipfoktUy0czvXWIEEvLecCY/NoCbDQw/2VwtT2xoM7iIHV5Xhcd0vkh5jc5g1rBt5Y6V9m8asuqd+q8isTMlCegKe3pdbk5r1LUNETgvEKDT4w2WQFZH55y4glOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LY6aieM2; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b795574f9dso7650646d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145302; x=1723750102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36ugo1TfvovnnnUK9ncR3kaa9VL4nnnXrq63bAYq2UE=;
        b=LY6aieM2h5DXZLs/yTmgyZ3H9TlyjJfNtG12iXwnZNTfTJv4CeClXC/NC2T1LX4JEJ
         t9Mz+XyATvrg5lYuKXe2VuXudcJRM/ztz6pD4qweRJgWnbMKB0txQtJMAX/Yu9uOM/LK
         YqAfuOZCjl3hMAHBVniJr6LZWM8S0Rj60yvtTrlbYAaxyH6ilJR+YcsdEjGvvvvmqHMV
         zcmp7dHgDZ6WAuKqnukK2IVZj/qJk3O6cq7G65nohXn8c5/werhpTj4zpBawkX+yqIkK
         BLzVLPV3mfyjF7iaAgdSvf1tmnbBj5KFeB4uh+Md8houqeK3DU5udlX4RRZ5gVsX/qb7
         5sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145302; x=1723750102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36ugo1TfvovnnnUK9ncR3kaa9VL4nnnXrq63bAYq2UE=;
        b=uKsK/wXvyWwyok5nTwB7A4yob7yw3a8NStpXLjAZBwCR+78bBeP5DRTcqNpUchUCPF
         leHy61qvS0VrVSrGaQn3Cy29rt9OmW2VJW4oB/DeDrmzffqbfcsjpdlHeFv/dnHM5rRK
         FRx0S77mL+jKEctimmiKPd/Q4U+LXIgWllAJ2ssWmRhnGTfa61XWB1rq9EGyjD+/vdEo
         O3jGgiz0V7SGC/73kU5pGhFpNpHRdTNFskNdNwmZ75W28f2dzJ/tISD98jSD0yaTzva3
         CMZog+GSvp0veTAB4rfOhzrEHCxNytqbG4J/VW5xROV9Y/msXzt75ycbUeaj8rqyy4x/
         ayBg==
X-Forwarded-Encrypted: i=1; AJvYcCXSLgQT4q+ttE+HJAWr7YZJPIbgnVIyc/69iONq0pijAtNSHcHE982eIhRRV/+OyU0+uptsrgTu4qXbuYj4TxHOnVtHTuAKieexLdOhcw==
X-Gm-Message-State: AOJu0Yxbm+ftlYWis00eGgeGgGDvbYO+ra5BgED1xt7hnZVBg+4tvckc
	aNhIEbBysyq/yLUjZNcbnoJyKuwrr2d5xLsnQ8/9d3l1I5OO6yABph/mwiYRinw=
X-Google-Smtp-Source: AGHT+IEHt4QHrJ4mSzrw5WD3LjHgxaV0kWINjLNd9fffAZjVvdMOxmyVWHGrqTt/kBpNz8Get2nkdQ==
X-Received: by 2002:a0c:f207:0:b0:6b9:60ad:a9e2 with SMTP id 6a1803df08f44-6bd6bcae45bmr36797866d6.11.1723145301692;
        Thu, 08 Aug 2024 12:28:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c777e01sm69809966d6.1.2024.08.08.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 03/16] fsnotify: generate pre-content permission event on open
Date: Thu,  8 Aug 2024 15:27:05 -0400
Message-ID: <b44f4cc462c7ef6bac3ace31686dc96fac408dd9.1723144881.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723144881.git.josef@toxicpanda.com>
References: <cover.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on open depending on
file open mode.  The pre-content event will be generated in addition to
FS_OPEN_PERM, but without sb_writers held and after file was truncated
in case file was opened with O_CREAT and/or O_TRUNC.

The event will have a range info of (0..0) to provide an opportunity
to fill entire file content on open.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/namei.c               |  9 +++++++++
 include/linux/fsnotify.h | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3a4c40e12f78..c16487e3742d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3735,6 +3735,15 @@ static int do_open(struct nameidata *nd,
 	}
 	if (do_truncate)
 		mnt_drop_write(nd->path.mnt);
+
+	/*
+	 * This permission hook is different than fsnotify_open_perm() hook.
+	 * This is a pre-content hook that is called without sb_writers held
+	 * and after the file was truncated.
+	 */
+	if (!error)
+		error = fsnotify_file_perm(file, MAY_OPEN);
+
 	return error;
 }
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 028ce807805a..a28daf136fea 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -168,6 +168,10 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 		fsnotify_mask = FS_PRE_MODIFY;
 	else if (perm_mask & MAY_READ)
 		fsnotify_mask = FS_PRE_ACCESS;
+	else if (perm_mask & MAY_OPEN && file->f_mode & FMODE_WRITER)
+		fsnotify_mask = FS_PRE_MODIFY;
+	else if (perm_mask & MAY_OPEN)
+		fsnotify_mask = FS_PRE_ACCESS;
 	else
 		return 0;
 
@@ -176,10 +180,14 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 
 /*
  * fsnotify_file_perm - permission hook before file access
+ *
+ * Called from read()/write() with perm_mask MAY_READ/MAY_WRITE.
+ * Called from open() with MAY_OPEN without sb_writers held and after the file
+ * was truncated. Note that this is a different event from fsnotify_open_perm().
  */
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
-	return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
+	return fsnotify_file_area_perm(file, perm_mask, &file->f_pos, 0);
 }
 
 /*
-- 
2.43.0


