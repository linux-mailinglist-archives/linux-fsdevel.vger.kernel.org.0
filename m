Return-Path: <linux-fsdevel+bounces-25465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F094C545
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E1C285833
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E915666D;
	Thu,  8 Aug 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="f8azxr/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C215ECFD
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145314; cv=none; b=eJu2ScofT92HQswKxdVf3d06tTUJGuivJ755vstWSY/1v0lJNwZadTYhqISXnmgL1ssJVqZ3qExzR4i6x42gHX6NJwzjtaWMQJm7Hk0DhN5Q79Y23eD5pBhEUH+4k7fnObwKSJa1aLK9pv6mqAAIy4Ye3Q4xj8XoNJ7AtsJY9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145314; c=relaxed/simple;
	bh=SRLbOqJ8zAl5qD12oNCtm7iiNr2HczkPZnZesiep1gI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESzuapz/g0JKpJZJgxUKadfXw+mN2R/TuXRCUu/+dTH7+llYfg1gxxug9dVw/u5L/x2IqCzXBbQ64UDZY6b04UXpT0eEVXPZnJgX2ZafdoM4L3xVasZz4hA9c07Uapo7574L8ZfGHmto0AMJZDHTWQrVekPXUyK7qoc2Nd+z4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=f8azxr/1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b7af49e815so7867696d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145312; x=1723750112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZ0oLpoVqilzi+VChanZFK4WtdGvxjCPwQLhvVUYV3Q=;
        b=f8azxr/13vGJspiin4z3X62CCrN8u+PfWvvu8j5ETd/tbAHMcZxzgqMAsS+jkqYCHD
         Hds6Lj6IIQHPfBlW09CPtfF+PknQeNQSSp4U+NaVe8hn3yZPOVcqcwXyK9o1PUaiXShs
         s20nZOeRBLvUD3OQD6CYyEH5v6EdtTk2wJRMx28BWGtr395/zSxP5pcfQOizfO3uPK84
         UocQJvifAaWTCvvtUiBLT9owoGR3ThKc0mf9zPe9imKse9KIyfXqnyu75a1Gvqi7Ft4l
         rGy8iAH+6yjXFWitwKLeWkQvvxI0BIHrO0xXVMHRzmoKz3uMS/xKadbIyvge25Opmg4B
         KKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145312; x=1723750112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ0oLpoVqilzi+VChanZFK4WtdGvxjCPwQLhvVUYV3Q=;
        b=AF5MFRSo0GIjUCw1AXVZVIzk0gjXw3HJr8jjekXs1LXermtSp87EcKONSuIqX5xkOs
         4t3WISUDlScr1Y+JTO9mtpr88Lmqc/pDd9Y4EXhPNfqWNOe/oLA7ugOnK4uJv5ZceC1s
         1S0jiaohkfhsLW9tgUL8lpdKQaUc4eM+CEvwDF9HQyZ7KqLXNPvTLVHDbX02q+u3CvY4
         rzXUUfn9mK1B5t6s7VrNCwwzG7C7VJIdI+gEgojfawqgwI8cXwOCRIvuusZ4uVtZRYF3
         fho/nPxiP/MEehH64MGlRIzVlu2cc3qqLkJKN6i1HCydErIOn7QvEJKvU5873wydZ6UU
         3x3g==
X-Forwarded-Encrypted: i=1; AJvYcCXl6JfZMEPDl5kyFfW+m677BjVBuT9d6ztcfsfpIc0y2ZJ3x/nfRldxk5cI3MQWIH972zuTmHwJVwC7gwJJsSkhaCOPKKHu4POmgEL0Bw==
X-Gm-Message-State: AOJu0YxWwSlH7ZvVibfzd3XmL8uhGLuIjiHWEep5WXP+Uj6hBcSj3oK4
	DI5/Ow2Qs8uJ/you4RP6blrZLbl/0VqVVLX3U6y63kBtrvCo59nztbu/eqsY+O43OnZszEKOtyz
	i
X-Google-Smtp-Source: AGHT+IFCnvBLMQYwV4xdiQDtXkQ4ye2f9PGHfgns1lK+Hj5Gxr/FET7hfoWmkMYm+Nx3ymsaFXyQDA==
X-Received: by 2002:a05:6214:5687:b0:6bb:b1b7:a690 with SMTP id 6a1803df08f44-6bd6bce1ea6mr31418406d6.22.1723145311777;
        Thu, 08 Aug 2024 12:28:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c839ee1sm69475856d6.89.2024.08.08.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 12/16] mm: don't allow huge faults for files with pre content watches
Date: Thu,  8 Aug 2024 15:27:14 -0400
Message-ID: <8b4c1abeff52322da354a4df2881ec13b7493fdd.1723144881.git.josef@toxicpanda.com>
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

There's nothing stopping us from supporting this, we could simply pass
the order into the helper and emit the proper length.  However currently
there's no tests to validate this works properly, so disable it until
there's a desire to support this along with the appropriate tests.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/memory.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index d10e616d7389..3010bcc5e4f9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -78,6 +78,7 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/fsnotify.h>
 
 #include <trace/events/kmem.h>
 
@@ -5252,8 +5253,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	if (vma_is_anonymous(vma))
 		return do_huge_pmd_anonymous_page(vmf);
+	/*
+	 * Currently we just emit PAGE_SIZE for our fault events, so don't allow
+	 * a huge fault if we have a pre content watch on this file.  This would
+	 * be trivial to support, but there would need to be tests to ensure
+	 * this works properly and those don't exist currently.
+	 */
+	if (file && fsnotify_file_has_pre_content_watches(file))
+		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 	return VM_FAULT_FALLBACK;
@@ -5263,6 +5273,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	vm_fault_t ret;
 
@@ -5277,6 +5288,9 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	}
 
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		/* See comment in create_huge_pmd. */
+		if (file && fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
@@ -5296,9 +5310,13 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		return VM_FAULT_FALLBACK;
+	/* See comment in create_huge_pmd. */
+	if (file && fsnotify_file_has_pre_content_watches(file))
+		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -5310,12 +5328,16 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	vm_fault_t ret;
 
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		goto split;
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		/* See comment in create_huge_pmd. */
+		if (file && fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
-- 
2.43.0


