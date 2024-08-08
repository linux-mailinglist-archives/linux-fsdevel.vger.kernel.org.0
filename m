Return-Path: <linux-fsdevel+bounces-25464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00A94C542
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFC11C21F3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F715F40A;
	Thu,  8 Aug 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2we1+z4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F83A15EFBC
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145313; cv=none; b=e+TtoxTC7O/DNe+RCM5an7TUK3VprVFtpvYvaZLjCOnTL0DZMIKOpOx4U5arhl0BIAlTeiVEaZ6W+7lwTkIOMX5w3Ee8c6ZL+JZNjJJgEapTG2Z5i4DLjMuw626/hNQQlcrWtHUyysmiYNaQcOcJr/uTgSY7Uiy7nT2t/HXT8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145313; c=relaxed/simple;
	bh=4MNVpsyfCXtbAesIGplXT094r1e//DqP/WIiy3n6590=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dS2UrE3SyuXuHLNj7aDRTfFLaeMZgLzPttmxfML5NCCJQ+HH2nva8fGEtbD1ABWBY4QMzCIBLdw4CwVlNJWRviZfE7/chV90hSmvNHbFJCDefBbAbdei0CnlUIGT5zgKAClzIdc1DceTNVXHOxz5JuFZh8C0oewCnUgMV/W6/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2we1+z4p; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0bf677e0feso1309861276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145311; x=1723750111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vg7JhZ5Svel94ZByv/XfsZ7gyzFgAjs3SwDkqZ+V3Ck=;
        b=2we1+z4pY6sX0WySI8wotX4SlU3xhM5evV/Oys700n8Hhtk0EbQtDjDwvwuTSpzEZi
         VytvfXcBIDY0Br2ZOgzuwbIF3XuHmY8sP7N6gqEiegj+L/mIQzZx0cL7CXjVpy+5D9OS
         6tp9m1KfJuqtIs3zhL1e41LmR6wkc1+g7PwuRRllKkYtD/hv22sHtADqTdkdXw7TVTnN
         h8034jKOPyovn2tea2po7n7/zQ4y7T9aNqYcXuUlVuA2a4NnToQeAKo2XdM1v+X9hquE
         eP7ib43ufLYoLUlFtHQYCoxfRgICRkvbUNZPfYNuXjdytZfSYLFscYk+9e0bMO+ucv+d
         JQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145311; x=1723750111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg7JhZ5Svel94ZByv/XfsZ7gyzFgAjs3SwDkqZ+V3Ck=;
        b=L5wysPRwkrTmP4Dvl9dilR8ZQl4qAcwEBDhMckll3HbWhMSgwZO1q6YU4ZCHehE9qS
         FgkvfcXWGx8iqBwFXedR5fH+E6XwFeY3xyZWLMOyBm8A5n1+QzduruwgpNh6eYpOqM/h
         Tc+kvEWAn808wmwa02x4as4HE095jri/H9iCyACX97HYvzeIsIJ3lQNzY4IgefAyUJcW
         UOIFug/IrdltQSgth6052Iyj9GtBDKCMZAiFZh5EQF5CyeUj83f446Cu3N+x6bqaImkL
         xQexTTQ4hCQB3V8w1ti2UtC6bL5YxFVoBvV/HSmSPN/4vLDj37+kYKwgu76nIZPXBaaK
         K5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFERhNIntTJQX3jCZeXZSPFmu9nNcQguVIMCO0xnynkSDMsH0gTZavPfRxX3xcthD3N4kgFEMFHkFbh5aq83S3e2vrNnTeLCxzCSn5zA==
X-Gm-Message-State: AOJu0Yxik/uoOM2uD536gXkcDhuCH4rUW2thOOm6yLDxrqO08mNCbmnh
	DpXntPvmFpeOIwQXlXRMJtdhtox8yqpcuFXtLdzos1csLM2PMQuO2n26L5+YilY=
X-Google-Smtp-Source: AGHT+IFFeTx74Ds9CwAg9CiYnTBosAK5oHp1F8D1LB3amJF/JdGVkj9ODxJsKT8POKKxshfGvAs+zQ==
X-Received: by 2002:a05:6902:10c1:b0:e0b:b2a7:d145 with SMTP id 3f1490d57ef6-e0e9dbcc39amr2607498276.55.1723145310633;
        Thu, 08 Aug 2024 12:28:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3784ca5fasm190091385a.0.2024.08.08.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 11/16] fanotify: disable readahead if we have pre-content watches
Date: Thu,  8 Aug 2024 15:27:13 -0400
Message-ID: <fead9acdf32a49c6174dc01f30cf02df642992a5.1723144881.git.josef@toxicpanda.com>
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

With page faults we can trigger readahead on the file, and then
subsequent faults can find these pages and insert them into the file
without emitting an fanotify event.  To avoid this case, disable
readahead if we have pre-content watches on the file.  This way we are
guaranteed to get an event for every range we attempt to access on a
pre-content watched file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/filemap.c   | 12 ++++++++++++
 mm/readahead.c | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index ca8c8d889eef..8b1684b62177 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3122,6 +3122,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't populate our mapping with 0 filled pages that we
+	 * never emitted an event for.
+	 */
+	if (fsnotify_file_has_pre_content_watches(file))
+		return fpin;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
 	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
@@ -3190,6 +3198,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
+	/* See comment in do_sync_mmap_readahead. */
+	if (fsnotify_file_has_pre_content_watches(file))
+		return fpin;
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
diff --git a/mm/readahead.c b/mm/readahead.c
index 817b2a352d78..bc068d9218e3 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/fsnotify.h>
 
 #include "internal.h"
 
@@ -674,6 +675,14 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 {
 	bool do_forced_ra = ractl->file && (ractl->file->f_mode & FMODE_RANDOM);
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't find 0 filled pages in cache that we never emitted
+	 * events for.
+	 */
+	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
@@ -704,6 +713,10 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (!ractl->ra->ra_pages)
 		return;
 
+	/* See the comment in page_cache_sync_ra. */
+	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-- 
2.43.0


