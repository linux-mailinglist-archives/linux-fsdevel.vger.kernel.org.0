Return-Path: <linux-fsdevel+bounces-34350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE3A9C4A43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B66B2E319
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F11C9DDB;
	Mon, 11 Nov 2024 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Dfkh6fxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82A1CB508
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368941; cv=none; b=araMi7Bzu9Jl1JkUP2r497FfiFKB6MN3L6LBO36GZ5HgYZ8/YDLGBxoLHdfL4ypIv6EFT6QbUS9xUWRXh5GeKXGWwzCHuI/p/3+w310D8ZKEflN7qijuL00XffcHE2OVgW/CSi5meAqYDvy7pe4rGV4OJjUW9pQD20+43s02Vgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368941; c=relaxed/simple;
	bh=QqsnT+PFB0stp1XOLxW6GR03t+Q+Rw9k/OtfDS+hMd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt+mT1g+OoxOV8kW8kjI7EpBtvv0XcUsrMFlQOZHeZeQFdJtNRZPHaAHNHliqweu9wzo6+WwgoeblzUkJp9floowZUBUOxw64reKLtlh7ccrv6O/zaS6pchQF+7fuVAk2KmNj+P+Xn+Kl0x3VBcL49v2uKQ4rIbbkR67LJq5TV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Dfkh6fxG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7242f559a9fso2198134b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368938; x=1731973738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpaeGG8sCxZf4JRh/p7NGjZl2gbHvBRPjf0TUvSvRrE=;
        b=Dfkh6fxGx/uVYKbNvNxD5qGeWmbLclfHCDK9vy3OBrUwLZL2sg8OzxsrvVQN3tncGO
         rjLuKd6yYqW4TDr+a/0SShuTclv1PK3sSpdNs3L/dJ6+lL87HL0J97KXyfqEJ11xtPBA
         phSh6vZnHaIK/dGPOR7k/sDn7xR35h10zXtTleG370oUEy5wiiSkp/x1coBRDl8HoMJd
         JeWc86qXzqDxne+NxbeSvVGWGYV16n4UtbQa9ogJz1kMKlIub2awx+Vo9R2HL6JRFiYM
         cYW6JBuCHn3SYOPcF0A0n/RQVEX4KjYKSjUjlEg8p8WpEP5eJ138+1Cr3lIeMLLAr1pe
         VVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368938; x=1731973738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpaeGG8sCxZf4JRh/p7NGjZl2gbHvBRPjf0TUvSvRrE=;
        b=hFNy0E+pdJ5Ev1A0C7ChlY/8yj28Crm3mWMLXjpJe/if7SnRFtaaBPpjZG0NXyeW5B
         FH3QX48yMpsBe7v7zDjT7Q/HaXmQdKajCdxgxFOzhhxKB3Fu24dTSmlyhAFV4hnZqNNM
         e/OjqCxN1ukKrqhxv6h/dCLJ359hWUA7BcWd6GSsEJLSFDv3J/K20pb373AB8PjlFCQS
         S/0e1KuuKt6Z2sNynBnkPR8KuiQOMD0S9iHb9J9NUbqJb4wYpAIEb6KrNUb/2u3fM3N5
         ZkZWxpwo8/l9SCTBZ1me9TbnHN9EtSPyieijwOpSb3rQ8vCuDk3dyPh7g9i7VeqlqF2U
         2h1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAK6/UzFoD5i9MZlj3W7LhovcSslWkOrQHB60ZgvZGPOLLqrIatYvZF/0bhnIxw4dqtY8S/rVbc8rP4vuL@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWz0K3f39k6ixUI4jjdmOHrMXI27/v7KLnrxGPs+iWW2oLtml
	2xX7oU+2r+B4CG+UAX58C1xxj/+bXXxTdGHwQhTV8Nqs7ZrkJEnCWVeU0/THZ5a98PHQYC2bJSK
	a4yo=
X-Google-Smtp-Source: AGHT+IGZeOeX13AG9u0SljALCGlqZd1HzXcprLCQtKHVA2LyzBnUVzw9lDFogBpMHW34whNWJjJhLg==
X-Received: by 2002:a05:6a00:3a28:b0:71e:7846:8463 with SMTP id d2e1a72fcca58-7241334a3e2mr19790618b3a.19.1731368938117;
        Mon, 11 Nov 2024 15:48:58 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:48:57 -0800 (PST)
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
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/16] fs: add RWF_UNCACHED iocb and FOP_UNCACHED file_operations flag
Date: Mon, 11 Nov 2024 16:37:34 -0700
Message-ID: <20241111234842.2024180-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
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


