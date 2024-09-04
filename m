Return-Path: <linux-fsdevel+bounces-28645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B0B96C881
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869D91F27A3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2891E8B78;
	Wed,  4 Sep 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gS/btsbC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F701E766C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481777; cv=none; b=kI5rBP61D1UzynpEQikXTKeMEviHqOrGMk5Knr50WDMF3RI6gm7eWRpHixKGVVC0eadsY4atIQzWsxeH+QMN6Fi5u3CZepE56XuzcQmyV2+dry2GXUiSzPscR2R5A7t7NaerfQGHuvSv32ugdmIpY+8QstV8YiPs/rP2gcw2694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481777; c=relaxed/simple;
	bh=RuLIdPYLf2U7vdfwd0GY223a6ukGYtQumd4qAvMMF1s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ0ae+/+msNVk1nTf6uTWkjKRKGLirUwiiSD1jzqxTR3qv1rO9ku7biA1WANS2oit72BmbcBV2BjEscwHk3dLhJ5v+BMDtUrVe0lkNT3VBsTay/R8U23DdcZe05tHhxh4J0FweZi+MnPVRBF6JYObZ6MBnaRhOUK46PMS7VyYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gS/btsbC; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a7c25e350so70921276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481775; x=1726086575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ0y3/dQBSJxG2OyPRkhEh3Vj0wjByustgiYia+MZqs=;
        b=gS/btsbCkaVsibWHpBg0kt0qu5RQqWF1TLzBkDq2d0ptRda1D93Q1KoT1oyTy4aMFd
         DOL23tsVJmF+KRkK9I6bf134iCQTXMv3gsbCpAH8HeUdxZXn+l3WuiHESKDFmKCc13MZ
         QI61Wy7lrNJkbd/Rk9Tdd9ZmzZWHMqS83anl5dTSDCk2+zudxpId4Wjjv3GJlJ6C9Ken
         TrLdmkb6RxsCX7E8z0Pi3HFMJnz+ruNcZWaaCcfNpLLU27iRzS6r+S70Y6UtIYFOyGGt
         9XJ2MR53/0SDUm1PCJa3eQbJdSfpX45T09Cye3/l1ZuxayFIO7C5pKuIdCHTcHwHWGZu
         Yl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481775; x=1726086575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ0y3/dQBSJxG2OyPRkhEh3Vj0wjByustgiYia+MZqs=;
        b=flNQN54BZphowQgpO0CquidDYUjog1ro9Vlr34yBrA5DWGbuGnSD+gWfkqnB4GUM5e
         IRDo8UASKxNqSL35AVjQ7f8q9lBsTqHrZvB//f5XI9O6LVS6YPW/dcnGWnKP5nsLjhh4
         tByJJnRbMCx1EHSQfiNTD4WE8jOGHokBLplfAvgEwcl3AW7xwRVI6rBDdqBfYDE95SvG
         CiElsoiM9dYB+uys81jqi+HaVaZvtxlYH1rEN4gbV9ZtKff+zpuMaycoxh2gCXW8lg6Y
         6LMtNZMWDBNCVi04dh8S48IKwhZeCGzdrsNFbEy7Oo5rl1SQagvva6Twt69Qgbq8Vl3a
         idVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3fPFyahQczdhpWpkC1s4a53p5VtpoZUr57Z6ExwmLSomXgWuRD1eQpI9qJ98lrvjQ5BW6RM62Ru5EPtzg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuc2AFXmS2BWCGmjy3/UnzIKqJcTPvc4UsbvZz7cNSj9qTtEQe
	2dK76VrzpDIyAle2ku6DaCenMM7uPlk1ymIcj4U/t2/n2j5sk4q0Pz2NjItcxxY=
X-Google-Smtp-Source: AGHT+IGBp2PIdRLM2XqIHSfjLgeh3BUtPWJbF41aaoGgznmohKpzreGJIvh+qUevQhYUH2lFWA7hgg==
X-Received: by 2002:a05:6902:138d:b0:e0e:8adf:2e80 with SMTP id 3f1490d57ef6-e1a7a1a48abmr20532053276.44.1725481774821;
        Wed, 04 Sep 2024 13:29:34 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201e4720sm1608386d6.51.2024.09.04.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:34 -0700 (PDT)
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
Subject: [PATCH v5 12/18] fanotify: disable readahead if we have pre-content watches
Date: Wed,  4 Sep 2024 16:28:02 -0400
Message-ID: <5ce248ad6e7b551c6d566fd4580795f7a3495352.1725481503.git.josef@toxicpanda.com>
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


