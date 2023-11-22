Return-Path: <linux-fsdevel+bounces-3409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA777F462A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD95B20A74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CAD51015;
	Wed, 22 Nov 2023 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/agwaQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA2D47
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b27b498c3so13587875e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656048; x=1701260848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YqYnqtgg0v4qcgRyM2GYXl73FKqYQtzvzFbJ67fKZA=;
        b=c/agwaQ/YeSEDYLj7UxuzdX/NwDDC4YIeWIby67J1zal9YVtw5LgGB4sGXdQnsEr20
         4ddPrUTMrtqgD6FGXufU+4bMkEn2zycgVqasO0Q7r+PRo/PFt7OLzAaeikmSbGOYBMNZ
         N2NHqS4qDmpwt9KApv1upw/kxETj33+qaY+oaVAKh7/rvBdXpQeg1OB2l4gWoxux/PrN
         Rvrw6i7+F7Q5wnmVVU2EMuoLCe9k5D6u/zSYeVKKb5VMDrTAZqkDjYTRhwrJhQZJA1DS
         BOsAG6CJGGGW+SD3uh0XbEKW3IPdhN94WlITpYBue5AqMkI0ARjWoZwuP4o+3UQDb9jV
         Q52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656048; x=1701260848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YqYnqtgg0v4qcgRyM2GYXl73FKqYQtzvzFbJ67fKZA=;
        b=nnBxVq8RLfszVJkg+Ln+xtgMiB/fMoagB/BU343SHc0NZIbs4F9oU/JM2jDrq9mTBf
         uXmI9VT8PJNw9ROzWnMAa7UjLtH1rlda2VtXDgMLPeDcX0j0Sz4HHMWF1bV14YoltzTF
         cY7jFiVJc8vn5N+dFTlHrT9itv5Q+vMRAqRCWJUDXr83VOmHRBmwMygU95HaEP+wd9Eq
         Ki6SdmTSKeNheOdeo1At1Xv3U5O+UTHNk+deNw46CCJbfWrw4zd9DeHoYO8zGg/NFS/X
         FBecYcn7ydNRCTGQzkbX243TWWtHvj//dz75fPkL5prmvDd4pA3ArDEbj81Ck89au0m/
         BxGA==
X-Gm-Message-State: AOJu0YymaHPecr4yUFfHzsHALba2lTIHI1iHY74g4k6ucuef2OCj+H5k
	exisxTPRh6Cywx7WjV1D0no=
X-Google-Smtp-Source: AGHT+IFjIkTqr+sLIrgww3vciBlDnH6hbIe3q2TjSZFjtewPjYVtv8hFtgHdSFVsAz+x1cFgeDts6A==
X-Received: by 2002:a05:600c:4695:b0:40b:3056:7420 with SMTP id p21-20020a05600c469500b0040b30567420mr1213550wmo.39.1700656047638;
        Wed, 22 Nov 2023 04:27:27 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:27 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/16] splice: remove permission hook from iter_file_splice_write()
Date: Wed, 22 Nov 2023 14:27:04 +0200
Message-Id: <20231122122715.2561213-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the callers of ->splice_write(), (e.g. do_splice_direct() and
do_splice()) already check rw_verify_area() for the entire range
and perform all the other checks that are in vfs_write_iter().

Create a helper do_iter_writev(), that performs the write without the
checks and use it in iter_file_splice_write() to avoid the redundant
rw_verify_area() checks.

This is needed for fanotify "pre content" events.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/internal.h   |  8 +++++++-
 fs/read_write.c | 11 +++++++++++
 fs/splice.c     |  9 ++++++---
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..c114b85e27a7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -298,7 +298,13 @@ static inline ssize_t do_get_acl(struct mnt_idmap *idmap,
 }
 #endif
 
-ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
+/*
+ * fs/read_write.c
+ */
+ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from,
+			    loff_t *pos);
+ssize_t do_iter_writev(struct file *file, struct iov_iter *iter, loff_t *ppos,
+		       rwf_t flags);
 
 /*
  * fs/attr.c
diff --git a/fs/read_write.c b/fs/read_write.c
index 4771701c896b..313f7eaaa9a7 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -739,6 +739,17 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	return ret;
 }
 
+/*
+ * Low-level helpers don't perform rw sanity checks.
+ * The caller is responsible for that.
+ */
+ssize_t do_iter_writev(struct file *filp, struct iov_iter *iter, loff_t *ppos,
+		       rwf_t flags)
+{
+	return do_iter_readv_writev(filp, iter, ppos, WRITE, flags);
+}
+
+
 /* Do it by hand, with file-ops */
 static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 		loff_t *ppos, int type, rwf_t flags)
diff --git a/fs/splice.c b/fs/splice.c
index d4fdd44c0b32..decbace5d812 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -673,10 +673,13 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		.u.file = out,
 	};
 	int nbufs = pipe->max_usage;
-	struct bio_vec *array = kcalloc(nbufs, sizeof(struct bio_vec),
-					GFP_KERNEL);
+	struct bio_vec *array;
 	ssize_t ret;
 
+	if (!out->f_op->write_iter)
+		return -EINVAL;
+
+	array = kcalloc(nbufs, sizeof(struct bio_vec), GFP_KERNEL);
 	if (unlikely(!array))
 		return -ENOMEM;
 
@@ -733,7 +736,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		}
 
 		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
-		ret = vfs_iter_write(out, &from, &sd.pos, 0);
+		ret = do_iter_writev(out, &from, &sd.pos, 0);
 		if (ret <= 0)
 			break;
 
-- 
2.34.1


