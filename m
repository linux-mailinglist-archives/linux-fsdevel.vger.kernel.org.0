Return-Path: <linux-fsdevel+bounces-28646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3B96C884
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B24B1F27C50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5AE1E7662;
	Wed,  4 Sep 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rFGXlMrQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764301E8B72
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481779; cv=none; b=kitsTwmJV9/kldltmruCuyFYRxsEqUhCPL/QzFLurn/e432hgdVlOWyZb0qhM7k9/hi5doTwJdy3nGqjfWlQ4mvKsM2WQh1cq+aqwrGNmMyhLFt70h8tFOZM9h30EHZTEYu//dtNDVJA3zzJ7SYBgeu+ogoPAEanV2HCQ1j0Hao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481779; c=relaxed/simple;
	bh=Q3VYbwM4CKv9HZE1IBds6JfYLVoY9EDuZvS5XcFcfQs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxmbvDoI7GhxTH10ETFcA+eMyXDtyL/9+u0I2Jq9/5eZ8XWdJPhGFMHht22pX/jHOfGPCFLEJbNuXt9p/T9FhYHto5LHtZ7xKAzMeQq5zO8YqIHwhFlUIBG7h5wbaZEOP+bhdL2xKBUA1jwaW+6hxp8UjO/IxHV4OhT2J96gtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rFGXlMrQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45685a3b1d8so11019451cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481776; x=1726086576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDO1PsR4jqBoDIDFjuXXy+JZDMdVbZ460dPfM2iRCeI=;
        b=rFGXlMrQlBl1XNlaEGF8dAN0WgYjbKKa2fUYRnD88abRpM7IISbC2CwttOfeqWimbN
         8OctDG2LYr2ldzfkxiaV7ZR06BtkKqgca68/+gTItZqXZU82yBO5XNSCEz+WXfLPPgHa
         vzIbuoWagyRvIQ/DUW0QqlHiTuyQRmgKMp2KW3SpL+7+L3FhZs7bCOQYRptyiqN+AVvp
         BE4jWYPDXAyrPYnclkAJoTiO0UqI5D7uiAOiwm5BPBa1WKf+1flXgkAbElD+mhOBZo/a
         kIZKYVjYU8Y24/UNO2dTNknoLkJWv/XiJlbZ4gGIC77DHU9GdXjQ/K5jazKQsDgDE3e3
         YGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481776; x=1726086576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDO1PsR4jqBoDIDFjuXXy+JZDMdVbZ460dPfM2iRCeI=;
        b=FtW4r1hyVv5ogd13wp7VOfoMmfaKVgkUcUayJ53x54KybMjadrJT+iNfSept81CRN0
         ac2cG4rqVi0qSJVxUJhfmTUQWKdIx/a4TEuKChheUNb4gCwI4JKdJnF+fA438zz2nwtJ
         71eTe4no1gInUGqNZbX+XOx6iC8tb/uW4z9wRoB+uBHKo0WowQfGxrRj6wM6H6jxhwzT
         1hOUk0qG4W07WlWMPabXMLA3rsHPES8wk4RKidwizpQyKR8HJ/XjxbGJ9M/W/9JJygGn
         pdf7dr5xrHsj7EgGO88Xrqd149yBop9gjpFDZrHnpWSauc7VikIerodv0wxJyrdpDuaY
         0JSw==
X-Forwarded-Encrypted: i=1; AJvYcCVlcUd2PTT/0N4DyRX1USvT088ZsZqqPJQptFqDczMYcrXescrwxEYxsIpQaeapPHCQAQ8z/IAMhBQe7Z+C@vger.kernel.org
X-Gm-Message-State: AOJu0Yze55fSL6DekJUS7MUHhiXii607DLGzHsEhwZ1jIaS7B9mRx4DB
	kHgPgFZxYWW4lPzfofGmDrw2fyjiP/vON65rmz8ufEQ1i4AwQuJ3ce1vqEX378E=
X-Google-Smtp-Source: AGHT+IFq1hdENBAe17o88j4Kfx5nRP4kOzH63jEqqDXfFeqQM7cpPGSq1qeT7V7dadPcUVEqgl24EQ==
X-Received: by 2002:a05:622a:1311:b0:447:f8b1:aeb9 with SMTP id d75a77b69052e-457f8bc54b2mr57102421cf.16.1725481776515;
        Wed, 04 Sep 2024 13:29:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4cacdsm1493041cf.42.2024.09.04.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:35 -0700 (PDT)
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
Subject: [PATCH v5 13/18] mm: don't allow huge faults for files with pre content watches
Date: Wed,  4 Sep 2024 16:28:03 -0400
Message-ID: <80e7221d9679032c2d5affc317957114e5d77657.1725481503.git.josef@toxicpanda.com>
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


