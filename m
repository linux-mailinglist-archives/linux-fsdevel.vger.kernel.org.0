Return-Path: <linux-fsdevel+bounces-28636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E096C867
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5647E1C24D75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F421537D9;
	Wed,  4 Sep 2024 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fCGQpOzj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EDB14D290
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481761; cv=none; b=tsegI4wuAWVfCuidsi+9vCXtLNLxGqyGmwepjmoHmS5Pqaifvcl5YHHYRRdMHIN1mxkT6OMDdVD7D7uRAc9W4FU23ZWRxjJItNx9ehYZu2xavcridzk7HMczG10ZOPvbDTkG63Dco7+vC0dZsYWxIOH+eHcCAlPiA20+4MGIkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481761; c=relaxed/simple;
	bh=KQKrHptqPFx5UnDyLAwlPOx0/0+4MigGJ4Sd0QKK9Tg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d76V/BdHKvwee99ShDyyia3q8Bev+ltsakjmzlOau7SulYx+gf8Q9pEWr4kfJAmQ978KOPLd8TSO8MboaH9UPXY+YMwS8EQ8xJje7Fjj/8mNhFOlNywuhJXozvbgA95ZP0YZVvKGQOJSXRCz8GTPXrl37m0sxpCbjydfgWm+Q34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fCGQpOzj; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3df0dc53ec1so4229992b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481759; x=1726086559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jN13mVwJhuqjX4PmJ7GJ6BtR6lc23krv9oFHMk0R8ZY=;
        b=fCGQpOzj67BHKa7j5uyX2rMTxrVeys73ZNv9aIAgg73rj5vUzIMqFdhRPR+vRsak8Q
         ZBrO6q4GpKZX33YN3i9/9w3kD+TcCjN8sNhrFhy25aG6O7Ma55B5eoUQ4AKDNKf4xo/R
         duNpQlrU5IqX+posXKdYIRqrsg0YZNCeDXZr6uCvtFuSDuDQ+XvamEfpjk148Ho1/EYY
         UeRpT8N1B+8XOJW/zck9aVuz/qKSRkO09FxhELZZToNlVOIjAO8IPyO2vM31CjT2VXg4
         NIoYE0qnEr7v10XHMPmmi+THB7H0BVUUeVmDKn8WLvm+RXWfGaSGPzdrcYiUBRURQf+K
         pCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481759; x=1726086559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN13mVwJhuqjX4PmJ7GJ6BtR6lc23krv9oFHMk0R8ZY=;
        b=gJ0ekBdv8ChQgogdpnYmKu5t/1A+rOHUON+KPUNdG0ayCkLM4JlSjEDsDIj53wQ0dv
         At+y0NNq631B4u3nRemI9+D9xarM7lnltWKrhMSN9Y4iaySzdEfAkLj/2ICc6eoAj04d
         m0RHN4WB0XMtUGMH4qadarn7Vq/FAqsNoNFrOCoK0rwlbz7Grm59mfK3L+CnYwnoKXw8
         y9FJjrl0JPPMm+yG2/bWYcXWtGaDxNHPWeqwmi+5n5Q7wz2atp0KXBPxlucEHi22D52V
         G39fwFOgIfQ2CDIN9oukYJEASMR/p/eHg5MOu2N7UpZGX3zW8OdX1qmI6zswu0Ql3MmQ
         5Wsw==
X-Forwarded-Encrypted: i=1; AJvYcCVV/Rk7EEPKpcU9gzh3l6nnYT9GAb/Xlu18BPCaXUxfJlHNd1yLWrJuIKIcXxNPllDqME/QrPjrWpVPMiV5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3hUyuIu0tr9dxdR+qT5my8EH7JcEIga39Y0gALtYmxL3N++J
	virOOBUu99kun7yUxKjlphTZ6GS94bGYiQZSbk9YPo7/h85K/QSx0XAEz62WazI=
X-Google-Smtp-Source: AGHT+IG+yDupiC0Kppt9fCxGX8WKPY89paC515rZx6+FiPwoVSHDWV3mC1QVmv+EWb3aMkbVDFXGwg==
X-Received: by 2002:a05:6808:3c46:b0:3e0:70a:3abb with SMTP id 5614622812f47-3e0070a4179mr12332118b6e.11.1725481759225;
        Wed, 04 Sep 2024 13:29:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b3277esm1506081cf.31.2024.09.04.13.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 03/18] fsnotify: generate pre-content permission event on open
Date: Wed,  4 Sep 2024 16:27:53 -0400
Message-ID: <4b235bf62c99f1f1196edc9da4258167314dc3c3.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
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
index 7600a0c045ba..fb3837b8de4c 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -168,6 +168,10 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 		fsnotify_mask = FS_PRE_MODIFY;
 	else if (perm_mask & (MAY_READ | MAY_ACCESS))
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


