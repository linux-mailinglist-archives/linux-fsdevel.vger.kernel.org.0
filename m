Return-Path: <linux-fsdevel+bounces-34507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01749C61D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD291BC60B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C42194BD;
	Tue, 12 Nov 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="X7M9bpLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91020219C82
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434211; cv=none; b=nSaLxWEKBGVyBSq+bDW4Hq3wT0UOsos3T3ZzJV6tptehtbZ+dQ3x00nqhODHxg6v0kUleZ1R+ViC/K/jGjbI1KK/6AWnhXUN1OY08TWPkvL3n5py5yK/JoEuBGcaWwEaPvJol9EJpI9jWjE4NF3pP03rmuil6raSK4TMUwRWw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434211; c=relaxed/simple;
	bh=nEHBpFohXdPFfKZTP2r5oPAoCPK79vU6B8kkFKUWAqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5AYJ0jJ82DqWvL6fvXLEU2UMLREFahcpl1/i1lCPWH0uK593A2XvKenAe6gw1Nn9vPdB6fYBESwnYBwgU7mXEGHDLoLlR+BgSQLO7n+xvz8zmcshDkJfn+p+wvKFVGDcjXHfiX2VIYSUMn1wjlXw02zryfWOyDbE8MnXNSpXY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=X7M9bpLw; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e35bf59cf6so43927b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434209; x=1732039009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKrH1r2LzuvlRLkIW99g50GCI+7PqnnQMlTA3Xoxniw=;
        b=X7M9bpLwKlcHfwdwZ9XMGaLTxSfeBZAH2ImNoUK8oJ230t/fVhMM6yJlzjG+DMyOfa
         77xXDbM82n52tE/mqdwX965sJ1zgJs+MKWsRHnGlWPeEOksFRkA9barSVvr9x4QLtAwh
         ur6gOFEsK2Zyiyn4Ef9KWlnHhSOhW2MZijD2QGPk6bFIiGibR9HZ1HKRz4OLBP8QTrUv
         5Qa+OVWc3RJUKKMTirKiXgNfNFcB2Ol5PXChLH1AHGSSB4pdKlvR8Z94392x7x2Kyx9q
         ZdZSIzW2NGamKBoj6BjLzFtp2+EoGDv8Zne/9X9RGt++pIjuVJH/f1GNUma5yDzc3/iU
         oVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434209; x=1732039009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKrH1r2LzuvlRLkIW99g50GCI+7PqnnQMlTA3Xoxniw=;
        b=MpgDtoiN1/kAlxkfSwR1c3lq25rBqySmDGkU0vCLO5EKtIEyxK0yg6x0mJH2yGsN5g
         tjzWIcLzxYfyubBjGphH3m0al4M1Ie9WeBh/PGiX03DcitUnq+AkN1B2amX50x7lnX0B
         RPRI/sg8L0gcnwZ/WQwdVFd0ZtQELLSIeY7DX3e6J3au+wxkMarTZb86G3GO38JUkeVM
         SDCbhE3q7SFbtw355zAyO/fa9/v02KsZInYZsQl2nXZ+Cliwx2kPYVMYRYq04zHqF6Vg
         0whVartYc77hJTu+8Tbc7Y6dKq/vjRrW8IbVmCPiXQ2lUUl9ineCeIVl747fXOT+VjVN
         Nxpg==
X-Forwarded-Encrypted: i=1; AJvYcCWYJ5bNxNOgXWuf5iwvUqewDDdtAD5gKVbgAL1HqOvnkh0BfsBRGDfQBxFwa4I9fEf/zxCeqAiQKuMC71So@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Dz/nKcxzo6ZJjR0D1WWYMcVIonr8xMeyCVEO1/8oU22WOte2
	zB1g8JnRWU+UzXiE+KgI3V7v5ulj+PjAin41YaTLD5P8+7TJh1kFWYCru9aIJK274HBoeqqQuIH
	v
X-Google-Smtp-Source: AGHT+IFJc2RNjc1G/OBWSTi5fyS4IghkV6OUbtpYdZWmaUR5D0i4/YYlt6JaXitbsIbc6IfGCQnj9g==
X-Received: by 2002:a05:690c:3510:b0:6e3:c92c:1d57 with SMTP id 00721157ae682-6eadc0a271emr140258467b3.2.1731434208685;
        Tue, 12 Nov 2024 09:56:48 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb65a75sm26238187b3.97.2024.11.12.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:48 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v7 13/18] fanotify: disable readahead if we have pre-content watches
Date: Tue, 12 Nov 2024 12:55:28 -0500
Message-ID: <23edd657a315f2e5ed648f8dba6d34898b4af85b.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/filemap.c   | 12 ++++++++++++
 mm/readahead.c | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 196779e8e396..68ea596f6905 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3151,6 +3151,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
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
@@ -3219,6 +3227,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
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
index 9a807727d809..277c2061fc82 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/fsnotify.h>
 
 #include "internal.h"
 
@@ -544,6 +545,14 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	unsigned long max_pages, contig_count;
 	pgoff_t prev_index, miss;
 
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
@@ -622,6 +631,10 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (!ra->ra_pages)
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


