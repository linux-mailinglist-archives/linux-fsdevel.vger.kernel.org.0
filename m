Return-Path: <linux-fsdevel+bounces-34809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283A39C8E24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21451F22F2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090C819993E;
	Thu, 14 Nov 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z2HqEI9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870F18E372
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598094; cv=none; b=I/Feiew8rUn8oEdSyeOTMUdXhHfXUph7aT6YIok0NygLicH+llLdD7WUn6X/JN5F2l4abVyyIrmbryI3OItvUG5ycaHcC8aXHn5pin18uEAHWOrTtq+eLqskV1uxhT7NsJoPzK1z6hO3VsPIq15TaiQHntcfb2gu+Joqum73Yig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598094; c=relaxed/simple;
	bh=gGKnnveMfZPAg4SgJ2FOiR86boymhVofVZdPadUM3k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THKASm2H00E3G0Og/BKvhtY6oskRX4nPTZiCyC0vTt6lNMZ2AqzvNtWaFh4dfIbLF5w/7MDZoeKLvdF1ls9Y+fXscNxarA9l51hgWceOCiSSXefxTptcG5N1UZ3lqc0QUZ4tConxxaL4dBZelGEQ7PmyMSZc096b6tz0R+ufj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z2HqEI9Q; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ec4a40e95bso321473eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598091; x=1732202891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyRvRhMBG1NsG1pjAu7RsorwHLATahyjt2W9R5OMw+k=;
        b=z2HqEI9QexiHndBsoUg/10+CpOQf0QjWppiL2AbY+qCvjAF2sEkPM+BxOECc8uUJYP
         ITB5KEBOakM51jI3hhi+wgtuKCBLO8unSpeLemgdjYbeP9omGt4OXmThSfGFTNzmff+m
         ySlzVp+v6Cuo65VBbCrNUN7HtWHIZlKpXuHVlrVuSfxmCIZNlztbNMklhaKpOBb49BcK
         gN8LuzXTsLq82DfHYF3q9nj7SKsBIWYEQk69vqjf1l3tF1khWXVCeNPHEOa6PYU+zwDD
         uUxT8igok79gqdh0Cjd3rwD8PzXyWGy8D0KOBKjUrMW7GQcn79aTvGRPJBZ+JJ2pxQn5
         plhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598091; x=1732202891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyRvRhMBG1NsG1pjAu7RsorwHLATahyjt2W9R5OMw+k=;
        b=AkpjgvWDkHFfPb/FpflILGlfIZHg094ABm37AHx90819uLm3iIoJZ2AFS6TdtwMYan
         nWcWparsXkOxuhQAK1FY5tcRuHUCMJciC8B7dGbUUosniOomn8N5aCI3BT1+0oQ11+qP
         JyanMFI+X7AiP/akbMkqXQR63Be+Ftr/B3Ta+N+zlTr8RB55RaRLWlvWD9rCGvgH8G5v
         Rh2ghqhVN9imNAUGpLTi0bn8mM7iP+js1SwPs3QDgFJZvxp4zdOJ/chWvkzKkiuR5dk+
         rIIsrlcvygP1Em1wsgfi/F4VZRteR16A1IbAvs//scqPLsi/f9SWy8TPofUzRtuaGnP2
         m7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU2hDM/KExBg6uKFz6YZeQDct6ne6P5Uh6puhZD+zhBicCJ65xVPpDNF/HXuWcTJDiJR58WUjJ2uNIhYUHD@vger.kernel.org
X-Gm-Message-State: AOJu0YzYE3KBFNfDXt18kharW4Yb71jgXEGiZmyCQ/SghH1tNlrLaR52
	FHoBTt3ZwKBuqjaycD5Ln4iRphL45/WWBcbCfU7Z/kZulMmYvP2dAGhSy3Lq8M4=
X-Google-Smtp-Source: AGHT+IHQ/GenKedH6rwQd+su0Ph/MRWIuzytWarVEOsqT+imV9hIASvSe13ZVKnr0H0iVbl20zcXwQ==
X-Received: by 2002:a05:6820:4d06:b0:5ba:ec8b:44b5 with SMTP id 006d021491bc7-5ee57c4397bmr19027877eaf.3.1731598091501;
        Thu, 14 Nov 2024 07:28:11 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/17] fs: add RWF_UNCACHED iocb and FOP_UNCACHED file_operations flag
Date: Thu, 14 Nov 2024 08:25:11 -0700
Message-ID: <20241114152743.2381672-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
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
 include/linux/fs.h      | 14 +++++++++++++-
 include/uapi/linux/fs.h |  6 +++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..45510d0b8de0 100644
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
@@ -3532,6 +3536,14 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
 			return -EOPNOTSUPP;
 	}
+	if (flags & RWF_UNCACHED) {
+		/* file system must support it */
+		if (!(ki->ki_filp->f_op->fop_flags & FOP_UNCACHED))
+			return -EOPNOTSUPP;
+		/* DAX mappings not supported */
+		if (IS_DAX(ki->ki_filp->f_mapping->host))
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


