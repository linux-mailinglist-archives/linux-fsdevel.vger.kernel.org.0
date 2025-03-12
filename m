Return-Path: <linux-fsdevel+bounces-43775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7196A5D76F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3255D3A7295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699861F5434;
	Wed, 12 Mar 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anIAlXby"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE81F4E21
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765149; cv=none; b=AMFawA2Ff4OTNfy3LQXqPPQZT5L5f0u5yvF1oEGXnGmRcsJGVF1LI2w9NLlWKuehU8BLbtOlyRjES+2x8O4MtvH5urlCWfO/BQZP/et+t/sBlb9OZiP00cHdgqK92YW2lAFp/G0oaPg7cH77QninVldvLQ7m6twBGG1WUkw2xAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765149; c=relaxed/simple;
	bh=zHU7fAgz/yVAdx3Q6xDKr89jH5p39xq3rCZX+uvm+cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEG+MInS5YLiPHqTk4PvEv6XRJdmlfN+p4f+JD7gmIm/zJ4lKs9zvNLf3tDd1WByy7BKtnHdEeQlLiMo6dX2sE1h0aNzzhaCh2EAtXCr6+b2yxvxdus19fp6Arn4lwLxai6KCc2mZgipC/hObGFZ6L3QTVd5jJETYC0EMh2CuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anIAlXby; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac25d2b2354so817318766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741765146; x=1742369946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7890Dj6SEHW6oTKLK8hnc7mlH58BUSTgNL5LwMLSow=;
        b=anIAlXbyNHD7SjVS9gOAgYiBmb7GE+TI1nfBQDGebj6KH1wtFbax2zHD/XQTCPgqBc
         BpkXUJb4/XyRUauf3As/VStu8yIYbLLowxiwix6FKcgg4BYB0ZB5HVdVxDtv995kF3xB
         kPmH/B0hkkkISwwNC8XH+gdYnxVIoNHa3Wd9ric/1XU6C5KJTSFFG3BoaThZJaHBHWm5
         RLzvqtwH3FK9keWfbsIaq0WZJzzlfrlX8+RCJwtdaqB3GpN11HwKt05NOgnOSXK9qQ5P
         pwzr6fZhiuFo68YBYXrF4PtAEsmSgh1K7gI5JEbTfYIDQzS6jfpjWJP6A46t1d+gaNdO
         FMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741765146; x=1742369946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7890Dj6SEHW6oTKLK8hnc7mlH58BUSTgNL5LwMLSow=;
        b=MZ8kjJHdrxF/O2rSbqQm4gAvZqCbbMHrN3WmbxEi7dAOejaQVDessDK8XqeQlNjJrn
         lort34o74hkfFIBa5pn2vwxjRpeGTwe0xVmnIlya1l1JgshufL+r1Rh11fRhtC6iMM4R
         IWCFnJOtyhhLMbp4U7dmp34sSDpau2DGHDu00qpxSuyxveBXd4cBvvmaTycD0f2T88Gp
         XHc3QPOxf7+5zTNfiIiOEOQy1e71Ep2TukuCeULgJpMD7hSdcwGR66D97/QhMtrCZfVn
         RnUF2T6peZQBcNQ+IzgXQjkHJ4hCUHSwgnxfdEMhm1K79vUZk2tjUUAS3B2UerUDKqYH
         3Nfw==
X-Forwarded-Encrypted: i=1; AJvYcCWamONVoM21QdrQFXrXFUk1nImmWHIxB0Gxc7cNIo2Dfuwu8fSR8sO3AxsMVhvCh5Fm1Y4yDhJrQTJexII1@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBxpdf/rXd2TJrE/gBgyb8oryeSAccxmTYYLtQFRKS9Y3iJxH
	THI/WILGsXIiZOJ4qHWgnd/onIkSnqFf+cNgmWctHjd4tISjVNQKqtqwZRt1
X-Gm-Gg: ASbGnctAMa2S7KHbdPQqMfTfX3MBWtaA7cUG5wtrfFYiThpbQyZ2KMJWYiGdTk5ESdA
	13eURG1W1tABQnb33qGsr4pORkNtshzq7xB08C2Sh8iNfopkr8LMe3YpEqqXPQGaeoUOAsMOUp0
	RNzC1RR/R9NUdUEcgFJBJdfP3Dx4AYACK2vhN20i17nChDLp0PVxcXq81vElVGUUgSP7mISmn+0
	Md2Ero4jzrOUsix2M1nF1ELEHRLJJ8aWseEYBUuvi9aaxKlr1fYValYnCAyXLL6L1jIwkiH5jk1
	+awh2/PO5LsQ2T94uL65vDYmV61336hHoLtACTVFBWayiJceuiM7/m3f2aozZcwt7vcXTLPadUG
	rYHgnKPixHE6lSA8cAL8WF7gPyUe9YCf9AK0OK8cffXXaSWuDW7sS
X-Google-Smtp-Source: AGHT+IHdqC7suRRIt7P3EK7j/TKHrFsdOONf20iVncLxc2zLzjV52BDsdm8685ygJo/rxh4xGgRcHQ==
X-Received: by 2002:a17:906:f59c:b0:abf:63fa:43d4 with SMTP id a640c23a62f3a-ac252fa2069mr2680043666b.44.1741765145974;
        Wed, 12 Mar 2025 00:39:05 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac282c69e89sm624740666b.167.2025.03.12.00.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:39:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 6/6] Revert "fanotify: disable readahead if we have pre-content watches"
Date: Wed, 12 Mar 2025 08:38:52 +0100
Message-Id: <20250312073852.2123409-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312073852.2123409-1-amir73il@gmail.com>
References: <20250312073852.2123409-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit fac84846a28c0950d4433118b3dffd44306df62d.
---
 mm/filemap.c   | 12 ------------
 mm/readahead.c | 14 --------------
 2 files changed, 26 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ff5fcdd961364..6d616bb9001eb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3197,14 +3197,6 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
 
-	/*
-	 * If we have pre-content watches we need to disable readahead to make
-	 * sure that we don't populate our mapping with 0 filled pages that we
-	 * never emitted an event for.
-	 */
-	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
-		return fpin;
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
 	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
@@ -3273,10 +3265,6 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
-	/* See comment in do_sync_mmap_readahead. */
-	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
-		return fpin;
-
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
diff --git a/mm/readahead.c b/mm/readahead.c
index 220155a5c9646..6a4e96b69702b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,7 +128,6 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
-#include <linux/fsnotify.h>
 
 #include "internal.h"
 
@@ -558,15 +557,6 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	unsigned long max_pages, contig_count;
 	pgoff_t prev_index, miss;
 
-	/*
-	 * If we have pre-content watches we need to disable readahead to make
-	 * sure that we don't find 0 filled pages in cache that we never emitted
-	 * events for. Filesystems supporting HSM must make sure to not call
-	 * this function with ractl->file unset for files handled by HSM.
-	 */
-	if (ractl->file && unlikely(FMODE_FSNOTIFY_HSM(ractl->file->f_mode)))
-		return;
-
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
@@ -645,10 +635,6 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (!ra->ra_pages)
 		return;
 
-	/* See the comment in page_cache_sync_ra. */
-	if (ractl->file && unlikely(FMODE_FSNOTIFY_HSM(ractl->file->f_mode)))
-		return;
-
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-- 
2.34.1


