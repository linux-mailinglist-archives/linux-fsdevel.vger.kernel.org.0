Return-Path: <linux-fsdevel+bounces-34152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD779C332E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFF8280C04
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF85156C52;
	Sun, 10 Nov 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ITqFiO9j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAEC12F375
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252565; cv=none; b=ru6/groeQ1xrm141Pa/79ON+/CiN56PftJ8Xtl4jtaZfw6GRFFiItYGjuOXsAVWxp1epcQB4DeZb/b5FRs8NWmYPIi0hk8apyrA63jzzVH6UZpio/3SlY0Vy+GAjVbU8a53ZNQdzZriKPbZ+PbAOAIk3yAESUT/1KHCLVFWcE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252565; c=relaxed/simple;
	bh=QqsnT+PFB0stp1XOLxW6GR03t+Q+Rw9k/OtfDS+hMd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjc57iwA7sOyQDU4AugqjIBp8NxLKms9JE6P4Vh4VslYPorfY9TKa6lZHVjMu8IFmzfM4F4vTxyOk43N6u/hoBGeDFzAsy0Y5S6mJHivX5aIdaSRs718mGEH9tIPKt5gFgGpQsNxFIsSUGhrGxpjXCLVG2mT9yb/OJiAjW77ikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ITqFiO9j; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so2733165a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252564; x=1731857364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpaeGG8sCxZf4JRh/p7NGjZl2gbHvBRPjf0TUvSvRrE=;
        b=ITqFiO9jdn5hfePmhO3CDfJ4/Dmi47iutuGrtDiahBPQhv0vuNt8DvJBOLO3Vxbm3j
         csJv0r53dA3Iw5r4Oyz+o8HNT+AnndUKoaQQv8Plso7XHK9X5ztaaObQL/PX9x5+v3AK
         svwxzNw08U3xQl9ftcmwmXj8N0SH1rhpCyajbwU9uOHps8jGHylvxgWT6cEhoORiWMSc
         DfWarKen3KehFQL5V0oQ4lXV4hOKfHYjbrxiU1wH/GwCNC9ZtZ/ylBhYS2sSgy4LlVIA
         7iYkVAJkiGiVf6foE4lxi3B77XWykVOy6Ww0w2X40CY/7+KkhxAXQ/vRX8B39Zjr/M4y
         by3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252564; x=1731857364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpaeGG8sCxZf4JRh/p7NGjZl2gbHvBRPjf0TUvSvRrE=;
        b=N04fRwybkVOTDUAOl42XDoayXNEG51sjKXvZvV4a5Imk3/xn+8usDTLsulEFx22YS8
         v/xVDw2D0AFDE8O1gvBgrKtpPCMSRBse9A5jJ9IPEMhncPb/gQEKVhKQkeyjebe0wzUV
         zTNPxqbyRjy8TJraSR9YhmEsQ/FQ3KW2Gk4+g+0xAu4QfAwJFtxDgLu3HHPBrFewKhls
         /TSnfCAbFyM86uFxbItizmCvyrq7oiq5FYsJByE38oZ+IZ2bu3nLhi/ML7U8cHGUtde1
         66pbpjuGfBII3aBEGv19sv2efd+ei5p0O16W/jcnygMx6bJccyTTGhQANGCyXqvOBlea
         PVlw==
X-Forwarded-Encrypted: i=1; AJvYcCUUYwAVuwOq/Ud+Xfj7vXNGDTZxmas2FIZgnsfFKs+PTwUpQEATBrUzZiqrE/2h48KHRbnOyIqEF5KGcc+w@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAnA4nQtPVeSEgbioBwEVjWw5fmhjslhiGimwhL+XmAISuiZU
	0Z9YvkkfRKSqZ4/mc8+UdXNSxLo6VLdhr0FJN2tjnUVVF+njMLyuKx7QA4FdDLY=
X-Google-Smtp-Source: AGHT+IGs3z/1IuRBhhgcQrQmIVWwPr43n/jctzILt+apLswhddJAGBym568yRqijFSP667Ww7gbDZA==
X-Received: by 2002:a17:90b:1f8e:b0:2e0:d957:1b9d with SMTP id 98e67ed59e1d1-2e9b17163cbmr13877494a91.13.1731252563753;
        Sun, 10 Nov 2024 07:29:23 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/15] fs: add RWF_UNCACHED iocb and FOP_UNCACHED file_operations flag
Date: Sun, 10 Nov 2024 08:27:59 -0700
Message-ID: <20241110152906.1747545-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a file system supports uncached buffered IO, it may set FOP_UNCACHED
and enable RWF_UNCACHED. If RWF_UNCACHED is attempted without the file
system supporting it, it'll get errored with -EOPNOTSUPP.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      | 10 +++++++++-
 include/uapi/linux/fs.h |  6 +++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..5abc53991cd0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -320,6 +320,7 @@ struct readahead_control;
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
 #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
+#define IOCB_UNCACHED		(__force int) RWF_UNCACHED
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -354,7 +355,8 @@ struct readahead_control;
 	{ IOCB_SYNC,		"SYNC" }, \
 	{ IOCB_NOWAIT,		"NOWAIT" }, \
 	{ IOCB_APPEND,		"APPEND" }, \
-	{ IOCB_ATOMIC,		"ATOMIC"}, \
+	{ IOCB_ATOMIC,		"ATOMIC" }, \
+	{ IOCB_UNCACHED,	"UNCACHED" }, \
 	{ IOCB_EVENTFD,		"EVENTFD"}, \
 	{ IOCB_DIRECT,		"DIRECT" }, \
 	{ IOCB_WRITE,		"WRITE" }, \
@@ -2116,6 +2118,8 @@ struct file_operations {
 #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
 /* Treat loff_t as unsigned (e.g., /dev/mem) */
 #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
+/* File system supports uncached read/write buffered IO */
+#define FOP_UNCACHED		((__force fop_flags_t)(1 << 6))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
@@ -3532,6 +3536,10 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
 			return -EOPNOTSUPP;
 	}
+	if (flags & RWF_UNCACHED) {
+		if (!(ki->ki_filp->f_op->fop_flags & FOP_UNCACHED))
+			return -EOPNOTSUPP;
+	}
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..dc77cd8ae1a3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -332,9 +332,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* Atomic Write */
 #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
 
+/* buffered IO that drops the cache after reading or writing data */
+#define RWF_UNCACHED	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
+			 RWF_UNCACHED)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
-- 
2.45.2


