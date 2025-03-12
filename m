Return-Path: <linux-fsdevel+bounces-43774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2ADA5D76E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1617D7A9E9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC471F4297;
	Wed, 12 Mar 2025 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmzTz++K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A621F4C8A
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765148; cv=none; b=rtdiNNaY33IP4tdd+jQbWezt1nIwmabhAavZloRUQ2fmIxVMPvnKVfPvMO0CT04xTeClysNmg+ga7D/Ctlz5wvfERHWWeigMh8Ta97mUmc7GpvekBff0dKXsI/4QHklZHjV68gnCBFsvVRQrja0bxqMxYF8egIwH0xIclJvclgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765148; c=relaxed/simple;
	bh=zAOSInCyLBOqbcogysBcSsstSz+z2TucuDDuXjbGRsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQcDv/7D+7hP27/5xY3YoH6aBwUNsz33t//tm2WqLyVf9WGF6XPqD/KkSUn/ZYgceBQDYw9mY6sqMVjqT22REpnqHtZep1hWr8GjxtxLf0KZFepcP8i89oBGaPOz7Vq2nGMiMJy6ijjeKQavEM3BOxhMEtVhTbpAsuG4KHNEywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmzTz++K; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so356760066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741765145; x=1742369945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUqFl3XX9bFpTA72aldmYe3+NmvunMxDXx44Y7AS5n8=;
        b=fmzTz++Kal60dlexpxcQKMiznL+fUXmKso9VTby5ylgBaigjQEHxUCHfTgpMwIPb7B
         fObj+5emGcTx1iAzDT4vhYEmL02v+G1wcBQeHJg+i7b9Ol4t1+JTWOwGmQuNiNKzexzy
         mMu8mYEj5FSoyFdXridcH+LY015taEqHICfyiiikp59UM1zRkD/VMEmYKy8wkmDFtWxv
         FS5FDhTGe9loqJeZhOEb4EgaEPnlwInVAmqe1QSQsI8JAXHcK2t6BXQjY3L5tKSSId1z
         H11kiV7Aj/DKApDeoxUNVCrOKFBIlp5j1vgSl7UiclQOW4JoB7te/X2yjOxmMe0wYbtd
         8+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741765145; x=1742369945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUqFl3XX9bFpTA72aldmYe3+NmvunMxDXx44Y7AS5n8=;
        b=HSb11pQd/Hu3CnbIVCTUphzXedlhy73kotPw02y8bdlQJk3xbqq3EBKEMPCDAYuUBv
         7Q5pfEvMBHDyJ0YOuBJkzLbmk31eNTxv5pypC4YmAEaSiUQPFWQD1yca9o1KOeNLUIqL
         Z0Uiam8ylc25HFnnT7OcVop3ND4q9tw5aeXPOLhaLsHRYHBigjb9vXy5QpvorCMih2F8
         DBaloOV9IGqey8c/1QnBogELJfa1akZtEEaNpLdiqzc+ffdMBjwnfHJZSNHtpG0VWew/
         3wgGMPGgsMoupKVwLesn0/NlfsG7mDSC6/JiDrkRlSr4FWt3hmQysoIrdksdeXoWNQm0
         kuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzoEeo6DH61EeEElk9i1PEoHNKOz08usHXr7S7RRZxXnVn1zNZZW+mIT0knmSpMF+7VwRETkVlS2GLvSJ9@vger.kernel.org
X-Gm-Message-State: AOJu0YzQB7yHPerd0cQVlrWUKFfCgP4Ic7V+mjpOO8X5xvNwc6+3Kkeu
	DG0qr1H1RCtEMZc1dT8D9Zme4iE4NRXHGdBz3U7LBb/g9B2E8x1m
X-Gm-Gg: ASbGnctPJlbxjNBEMMZm9cWXBMlfHxbMOC8/z0/vIZQTmpyxgtDuGHNAPo2gdYByrTR
	VwG4wKGCfb6s8MRMm3LUd565oGmhY/pKuAIQq1/hrA/Sv/sjB0LAiJ8kgUCCXfbFN1ZIWNArJ8J
	Nyq27bcFhguJcXwWQtEPN58iK/myPImoLf2xDOHIo/wQQabPCSe0Qh2HINvx3UaDTjfomj2dEsY
	Z4fzoNi84fjN6hCBT8ZfdleBVGuLOuvchGJyw/7m1M1Yh8guXfH5Csj2/bpkgUQuWr0ovZErT+3
	L+goeRbvZurULHG7Pl902MlHbAkcO/GmD5uY2l0VeO8UZEUlprppoy6EJEwcTYqPH973IeEFru8
	Zk81WHIpHSq45JH/3Dn8JwS27vMXYnuiG6q/yvrLQX5fvP6W6PWS7
X-Google-Smtp-Source: AGHT+IGeNnqjvCLSgy05Q2rh1+Cj8TCjwW+Z5RGs67UzNrbgnb2wCne6HSLGP5CK8bNoRkReEEClrQ==
X-Received: by 2002:a17:907:928c:b0:ac2:55f2:f939 with SMTP id a640c23a62f3a-ac2b9db301dmr879628166b.6.1741765144918;
        Wed, 12 Mar 2025 00:39:04 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac282c69e89sm624740666b.167.2025.03.12.00.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:39:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 5/6] Revert "mm: don't allow huge faults for files with pre content watches"
Date: Wed, 12 Mar 2025 08:38:51 +0100
Message-Id: <20250312073852.2123409-6-amir73il@gmail.com>
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

This reverts commit 20bf82a898b65c129af76deb96a1b415d3098a28.
---
 mm/memory.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b4d3d4893267c..34e65f6bf0d96 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -76,7 +76,6 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
-#include <linux/fsnotify.h>
 
 #include <trace/events/kmem.h>
 
@@ -5743,17 +5742,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-
 	if (vma_is_anonymous(vma))
 		return do_huge_pmd_anonymous_page(vmf);
-	/*
-	 * Currently we just emit PAGE_SIZE for our fault events, so don't allow
-	 * a huge fault if we have a pre content watch on this file.  This would
-	 * be trivial to support, but there would need to be tests to ensure
-	 * this works properly and those don't exist currently.
-	 */
-	if (unlikely(FMODE_FSNOTIFY_HSM(vma->vm_file->f_mode)))
-		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 	return VM_FAULT_FALLBACK;
@@ -5777,9 +5767,6 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	}
 
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
-		/* See comment in create_huge_pmd. */
-		if (unlikely(FMODE_FSNOTIFY_HSM(vma->vm_file->f_mode)))
-			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
@@ -5802,9 +5789,6 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		return VM_FAULT_FALLBACK;
-	/* See comment in create_huge_pmd. */
-	if (unlikely(FMODE_FSNOTIFY_HSM(vma->vm_file->f_mode)))
-		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -5822,9 +5806,6 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 	if (vma_is_anonymous(vma))
 		goto split;
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
-		/* See comment in create_huge_pmd. */
-		if (unlikely(FMODE_FSNOTIFY_HSM(vma->vm_file->f_mode)))
-			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
-- 
2.34.1


