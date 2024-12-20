Return-Path: <linux-fsdevel+bounces-37959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E39F95D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D6C1898C2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB721C9F8;
	Fri, 20 Dec 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pc4Oh3rK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E52121C180
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709726; cv=none; b=a0N+1azZIbmJqnMXmvfR8C7vL0cXioL/gabLFAlfz4oSeomxGJP4q0YmoaP2vzahyPFjUTQu8jP4zSqR7itv0dS61IPf3ArF4mTUTVGKs2w09DhBanTVqJSwf5qkzffAiweIbNa0TIwa8bw0mLUNkMBY84R4piPe+MG+wekrTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709726; c=relaxed/simple;
	bh=2SEcDojzAqUnPgfjf8E9nRmr9dou/inG3/DhaNUqq8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2hwHU2yFiEpj/bJP0S/WW2TwXNnNPZU0xCa5nqFx3lZ3ffC7SfXmObrj6mZZoKqW9ZHeWvFWc7S1RrioiVEui29oqxaVwkfrZvaeLd7iP+ShVDwx2iOvNjMocjUOv1gh6dDEez0azSMXKNrwFQzSeuC0Adtzr2iGa6oUK1AnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pc4Oh3rK; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844e61f3902so168710439f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709724; x=1735314524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w74VD3kuQguRINknUSjUP4VNHVLoGClDPYL5LdL0oM=;
        b=pc4Oh3rKs651mSGbJFsxIq7XbGM9DQE81MtSvSAEJpzIAX+GD09TqGFN4OhkXpEjCJ
         de8Afb3cdqyyMI9lAQtd6+O4c154QWEfsLMfmxdymGWhPMzRC2DkWsurRm5H0Mk2SnrP
         lKRyvz6Xj7dl/c4vLRMrRY9iACZVEzmyCQqOUJI7naeRq6IX92GHebPZV9Y6Exis68uW
         VtQdiGFo0NnEi8Fp0XQRrbBPgOuwUpzSlqkfycmGH8DNDkQL1WmoWvOTZsCUX7+t8TBx
         pF+VaWV8VsNbFr2Gb1X2SDUoXc8h2T4jUh1RYHODrzzak4DnlWqjlnuCjPLpXf4kT1z0
         M8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709724; x=1735314524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4w74VD3kuQguRINknUSjUP4VNHVLoGClDPYL5LdL0oM=;
        b=nV2iihMw2JZKj6CuGafqBFXjlu4SXBKWwCRRnvIgIWZyF+/Cph25aZEDzqhuVGpCrV
         x6MJrJQGvEBY2E44br58o3CIS/QmJq0QxkC1Hh2hufbp4v2WE+sae4qVBR3cQC4RmRvI
         a2Ghe0/6vhnjLcK4tzoUhAnMgut3Txfqrmyfbr6SFtgpTd8kWM/OmuDpvH83Zm1EsMi6
         VAge4Lhcu1iWkCfPjhFgaDyiRI6xIOGotJhDeKr9hQwyVa2Vj3vZ1MQPluGPEtkPC3i9
         DYgDaTno8h9C3iTQTCW5xjhLQi0gzzUFpOWLiUj9gY66xGKK2O/TrrfJ1p9Xrk9fJ7yH
         xfHw==
X-Forwarded-Encrypted: i=1; AJvYcCX6FtZsKdu6cXa/5DtjMHmJXZdhI3gzffQT+60wKK4DBbanMc0yRpVJefMIdRQ7Kro8OqKyOfXEUMPlIHUI@vger.kernel.org
X-Gm-Message-State: AOJu0YxCaFWBIbvS1v5sKxEjoBYn4RTSEXQHzca2CEsIKRAY5UQK/YYP
	hPJb0FyOpqMKNT0FsLvNLMmz08tBWZ3iNwyptas8SYW4J8Ng/10Ln8pAfmeXG90=
X-Gm-Gg: ASbGncvD9dlmCxNI1zlMdOoog5u7FqnNrcc3x3c95aIbjUE6X7wN2OuPOLy2ApFNA2e
	oseOKHNJf7GZLIAhyZZ3wLbl29aTZ9mTmeM8VkteWolq97NHPzxhCc8HDnJdopwqSZ52fQi7NqZ
	J4XxZaJrdKmOpkLawq/wCPXQ+3grVQYr3NI83GWFVL3HHEp9FxCV2IUcjPYvLy6taiFJ0vXfZjb
	n1eSDNskWwumwCzHv+x1+ufUDQFImUktWWURZTFkFJSbq/xg/jBoiUnqOKI
X-Google-Smtp-Source: AGHT+IERkjVXfRiBHnc8FlfnVZJTgamzH1zCvDow9NijC4/j/GJhywdFRh297ssQYYJsqQo3rjiWFg==
X-Received: by 2002:a05:6602:60c6:b0:83a:a746:68a6 with SMTP id ca18e2360f4ac-8499e4d888bmr383870539f.5.1734709724489;
        Fri, 20 Dec 2024 07:48:44 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/12] fs: add RWF_DONTCACHE iocb and FOP_DONTCACHE file_operations flag
Date: Fri, 20 Dec 2024 08:47:45 -0700
Message-ID: <20241220154831.1086649-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a file system supports uncached buffered IO, it may set FOP_DONTCACHE
and enable support for RWF_DONTCACHE. If RWF_DONTCACHE is attempted
without the file system supporting it, it'll get errored with -EOPNOTSUPP.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      | 14 +++++++++++++-
 include/uapi/linux/fs.h |  6 +++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..6a838b5479a6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -322,6 +322,7 @@ struct readahead_control;
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
 #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
+#define IOCB_DONTCACHE		(__force int) RWF_DONTCACHE
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -356,7 +357,8 @@ struct readahead_control;
 	{ IOCB_SYNC,		"SYNC" }, \
 	{ IOCB_NOWAIT,		"NOWAIT" }, \
 	{ IOCB_APPEND,		"APPEND" }, \
-	{ IOCB_ATOMIC,		"ATOMIC"}, \
+	{ IOCB_ATOMIC,		"ATOMIC" }, \
+	{ IOCB_DONTCACHE,	"DONTCACHE" }, \
 	{ IOCB_EVENTFD,		"EVENTFD"}, \
 	{ IOCB_DIRECT,		"DIRECT" }, \
 	{ IOCB_WRITE,		"WRITE" }, \
@@ -2127,6 +2129,8 @@ struct file_operations {
 #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
 /* Supports asynchronous lock callbacks */
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
+/* File system supports uncached read/write buffered IO */
+#define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
@@ -3614,6 +3618,14 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
 			return -EOPNOTSUPP;
 	}
+	if (flags & RWF_DONTCACHE) {
+		/* file system must support it */
+		if (!(ki->ki_filp->f_op->fop_flags & FOP_DONTCACHE))
+			return -EOPNOTSUPP;
+		/* DAX mappings not supported */
+		if (IS_DAX(ki->ki_filp->f_mapping->host))
+			return -EOPNOTSUPP;
+	}
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..56a4f93a08f4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -332,9 +332,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* Atomic Write */
 #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
 
+/* buffered IO that drops the cache after reading or writing data */
+#define RWF_DONTCACHE	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
+			 RWF_DONTCACHE)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
-- 
2.45.2


