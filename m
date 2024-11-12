Return-Path: <linux-fsdevel+bounces-34509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B959C5FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C99F1F2514C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5C9219E55;
	Tue, 12 Nov 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1Uqoyvlc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC5219CA1
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434213; cv=none; b=opldbgpnjuLfMONn298Un8OH1Ik7YO3oyWLJhyzIgEUe/TPdybnYe7k/p+DA+1dOyvode4v1mvIFOryCv7zQ5YMw3vUq1YsB9z7aySfNY/dBqtekhSpevQWqj6ofeJgnyoLk+U8zQUqCSqvpc4OTv0viQA3xOf4cOhmtbvpx+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434213; c=relaxed/simple;
	bh=t7nvLm79BnbL0G55pVnNTkmA0duqgzyrwuSpS5La8ko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJELHoSZ/jryoy4mYChCNKDdVqpiggOq/6nQtxMldaQL2FaXoO7wrZLd9wI3FdDDlYd8roytxTPv4Q/wlCBNyZLPS4XXtIVVL/maA7hMqfoYHxS3PTxfJ5CgdwyA9Erc5ssQ5thip5Zs4yVPp0dZAgdMUJrZlu9Jx4F/7mCPTtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1Uqoyvlc; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so5973723276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434210; x=1732039010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtBO4W7ojcvMiQeJDBijogkryb22CThmLCgaVfO4L7E=;
        b=1UqoyvlcmSbNjfa83E/BLYP3/wBFxyI7s6orl5X38TpFHJ/IwLnJrrnChZW1qtnioU
         NWv9+ekSBoMewwqUgaWni6y3f0YMAozpymF64o4ydIfe3H4uVzlYGsz+6cGq+MSaplh4
         jkOH1KgCivF3DPiOF7ZFtcAR+UPv7MgmEk06GiRnfdfcH7V3lJXlqkchkPjXcTvlcfex
         dbekYoGl3TPy4lJgStAPCVC9FX52TAq+h4QvCwzHGxchJ3ZMtqFfTP2cF2mTVbp1h+tT
         kqoWojj+bGglyaxTMJFhd547qjMBwun+Zq2RuudlsAnfKgzXH3i55WZHW6bKb2mfvY9E
         ZQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434210; x=1732039010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtBO4W7ojcvMiQeJDBijogkryb22CThmLCgaVfO4L7E=;
        b=KQ/aNY7hCkM8etRb8Z2J7pAI4/cBRzs1Cxh8nASo+lrPGuW3axxqxUJ0ZdGC/6HZxk
         rcjsn/0ucc+ZW0tOJjhc7lWHMHUdgzDYJ/cYFbFq5Ef0CHAyFTZb8RctBmU4BKdrEuzZ
         VkxphqMsWjEWcpqOaXXUtHVoBV+GZDyBydx8gY0hfhr65rjEaYL9G8DKKU2L2Gk9c5YR
         2FaMC/S0RvRX+4OK2HwLOYEPQjjHxokzhS3dyL3NvoBOOH1xqhysE7Y423eH8lXCdN3J
         KrigqnEAeSlwmZYL29DlQ+1O2qwQbgt5+fmeGw++hNGdwbQzrZAPBWaQQUOf4eCn0Jec
         7F7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGJHnIS+JV9h1A+OMZigUPHm/gJeVVH/92t/UOzl6a0vYlriNDIiinWFuWnFKXQIMRURvZs+qCsbZotu32@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOJZn66Mjlm4TuivnFKU5pevpuqQ/lhdp9qAZ69k+3fMDHetO
	c0iGKTz3tw2t0vlfoHz+U8ENthI7m6b7J4fQxnPrqwBbRgFJkeyl9KYPcFqFNQ8=
X-Google-Smtp-Source: AGHT+IEKuDZzW/fvP8psHkg5hrvM/70eBZxELM8jsrhGXCGLQnsHGSpuUuvJ02++phM7o+afQ4JSUQ==
X-Received: by 2002:a05:6902:20c4:b0:e33:25e2:4b1e with SMTP id 3f1490d57ef6-e337f86d626mr14917803276.19.1731434210511;
        Tue, 12 Nov 2024 09:56:50 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba835sm2880031276.47.2024.11.12.09.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:49 -0800 (PST)
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
Subject: [PATCH v7 14/18] mm: don't allow huge faults for files with pre content watches
Date: Tue, 12 Nov 2024 12:55:29 -0500
Message-ID: <532dfc336dc1b09e5604dee4f08b70577089b76a.1731433903.git.josef@toxicpanda.com>
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

There's nothing stopping us from supporting this, we could simply pass
the order into the helper and emit the proper length.  However currently
there's no tests to validate this works properly, so disable it until
there's a desire to support this along with the appropriate tests.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/memory.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index bdf77a3ec47b..dc16a0b171e3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -78,6 +78,7 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/fsnotify.h>
 
 #include <trace/events/kmem.h>
 
@@ -5637,8 +5638,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
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
@@ -5648,6 +5658,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	vm_fault_t ret;
 
@@ -5662,6 +5673,9 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	}
 
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		/* See comment in create_huge_pmd. */
+		if (file && fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
@@ -5681,9 +5695,13 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
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
@@ -5695,12 +5713,16 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
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


