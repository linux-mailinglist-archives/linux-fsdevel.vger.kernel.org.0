Return-Path: <linux-fsdevel+bounces-37334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C150B9F1196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B180281DAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790401EE03B;
	Fri, 13 Dec 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="01Hs9enO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074641EBA08
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105376; cv=none; b=mtjc6Js06OFajuQnBL+piNRjfjky7oLVSNLrtT6HnbxPiDGjsZlW7ybCZB/6bWa4JKWycx0f7cTVxN/y96Fg2rwymvumMWlwYZpVBltBNtMsl98WXziJjWhwhQBMk5D+/QM9dScR5gJkOEZE+bw6+XGY38gD+UlnZSpC0x06FyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105376; c=relaxed/simple;
	bh=2SEcDojzAqUnPgfjf8E9nRmr9dou/inG3/DhaNUqq8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyYaLxNdaxPOzo+o+tMQCj+e2soYjfKEBqnNWuDl+Yj14bIeCxmDA04gKrYbk9PkDyW/It/cu6+VbpWIoyfdyR0owgF/inHUXzGPEcrRazrqoO9FE1Oe1JRYty2YdMa4kvx8+m5yUoJ5FYc//4+aUF0nyai8WvuA41gij/728k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=01Hs9enO; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844e9b83aaaso65283739f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105373; x=1734710173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w74VD3kuQguRINknUSjUP4VNHVLoGClDPYL5LdL0oM=;
        b=01Hs9enOnkwKRmuqv8OPi5cm5KXxcKFhJlkctvjFgT6DFRRQIS/rAYbdV/lvyTW3Lw
         sbiSSuGpUO1nmFNR1hLh0BtKs7xfKfvEiwQpiVm7nVqSGJ/hT/5+Plb7PGC/Bt2vI4WY
         QAJWdCaYyEo26sZrPOlYErQq+dlX5WObrlqnCgBy06zFkj/9Bc+Df/BCuPbFkMe2/Yj/
         tF5zSPUbf59oWTKv+YkkQaZ4RSoBu4MFQv2/IPc8VTUa46726BfPG2gwdtYP+YDDWYi4
         DPcJQlGxRyu15Gt2gSwceQ80X6hY6iH355vg8dJhHAmEwxsA7CAsVybF5RLXrMEzEiAj
         DV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105373; x=1734710173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4w74VD3kuQguRINknUSjUP4VNHVLoGClDPYL5LdL0oM=;
        b=LTBzLNSksJ3ECU5lUJdR0uZp7OTOgT3+2WYWfspfWl5jmn+z9Zq8ekjWMNSbbIYYrw
         9LnDeccGskuyI1CFW3IE6IX6gA9FjJiFQFzBJdjnmM/Dq0vinZBBnW0L6/YnMda/W43V
         hhBl/aoKPmxrYaSxiRWm5TUkTU1kXCbg4ouDadMFg5eV0Hshj8KEN7t64UEw0s6RXmQC
         uMmIA8IervVhb8fMAcSO6EMRXzOZnCaIUo9KjMk7XTLxiDxad1F0GmTMlTt+t4N1Ew2q
         h8uOSNTcduK9/TPirxEOiswnt1G76qsZBLIX7o0hnBEFIIinj9Nsx1ogjxl+pHtJ8ceK
         rQhg==
X-Forwarded-Encrypted: i=1; AJvYcCUzlWr1M5kZitp04TMQNjvXg+pNy/X8hncCiVBIFa1cq1IP8ATuf1QvLPt+CL1RuREkgar77QKEZnXdAiIm@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEGxAz+P9EhSz3PUT3cozLrczGKdxoOWwJMdXpdOjubCEGewU
	mo0tdAHyj/qgIQ1/fCDInwdIvof8GsSwb3zR3CiTfFFg4bejpfyTC0LEsmHQjFM=
X-Gm-Gg: ASbGnctmAL1J+li/ODYQehH2TGSrIua4eRuuVJJB7xAig1rsgF/c7xYTpckwUHEsuvv
	4Zz+rNqhWVxRrjpbK60ZGv6zFE5HWv0N+fwd5nrXruL88HXQcNA1WtEhN0E26q233n+BLdU6/Za
	dhVd0x3H5lFcWZtJEIm4/n7FbSFx5m5WXgRT8VeTmNJIUDfyKe6BgiK2opgz1fWE0WEqzluGERo
	TN+C66+VtSKUtL3QCIPM0wmAJiXnPRUVBPF7Okdy6IaEefPuNvFwbP5cizg
X-Google-Smtp-Source: AGHT+IHLruDe6Zg9uYRMCFFj0re5LQoOZLn3MM3DvSbmN1NLcJuI0/2En87svfvn51ITwB5/NqHQ+A==
X-Received: by 2002:a05:6e02:3042:b0:3a7:8720:9e9f with SMTP id e9e14a558f8ab-3aff4619d10mr35119105ab.2.1734105373195;
        Fri, 13 Dec 2024 07:56:13 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:12 -0800 (PST)
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
Subject: [PATCH 07/11] fs: add RWF_DONTCACHE iocb and FOP_DONTCACHE file_operations flag
Date: Fri, 13 Dec 2024 08:55:21 -0700
Message-ID: <20241213155557.105419-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
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


