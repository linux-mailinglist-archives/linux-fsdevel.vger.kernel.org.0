Return-Path: <linux-fsdevel+bounces-22610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF091A41B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE72A1F26828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B6113DDDF;
	Thu, 27 Jun 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVqgsG7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970EA146013;
	Thu, 27 Jun 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484786; cv=none; b=Lwj3yDGWzot1HsWdmoX2i5c1v+s0mbKgj+MrhvEpw7HvDbLIJHdSIYjta7qfqwCBAZ7R+xH3A5lPNky8ribhtuk9BhwVkU2wOKv2dt7sq2b8wem2/OVLO+bDLdI0ScWbIhMu3mkcCVGEpvhvCdW67E2CeXcVWb5jkjz4EJw1C7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484786; c=relaxed/simple;
	bh=OcyLigX7xo9D5P+eRBaP/LBDgusjI3qsn3tSfwigGNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLYEWe8Fh8n+uySqnpi8k0bLm293cKhFvpPyhVDKEWDDLIoxSyA2DofZz01KtQ8Ehc9rSkg6uWXIB2JRLA5eGaGPAJ+vdt1ZoFxxtsirALrFWm4EhZJxakTXjITYDucFCyLPO0TxbGcxw+yl+NPkJ/vF9rpSP9OcmDQVh6NII+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVqgsG7+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42138eadf64so66079605e9.3;
        Thu, 27 Jun 2024 03:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719484783; x=1720089583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBerhuPUPnvHMMtpXidwo0lqOY9yjptwKl42PSVTWQ8=;
        b=TVqgsG7+f4MOdXbM2jJpilX1LmVmwRGVF8zTs5TbM8N/lHAWFtnZf6C5x86sD2yT3D
         CW//CRUk+GMrZXW7Cs0RqkqteoUylGnEg6UJVmRNRPmMAdzjV31jWcWqPtvBBXOWj6cC
         NKkoOU1EKacNHOSkGxSb8xqglSdgcEyfnjjtFFVyxHo7dOxLYPceOBtxpcyZF0cRosiu
         kg7Bja6wq+NsO3eMun7XXCtxtaHHfFf2C87JSdUqcV7eIlN+KSbWDlc7ipSZGGmTOeyH
         3ToiYdPDKNQQdBUbOzO9udjZ1ldfQRN+jJYhpUpsCzNSeoc2/16FXousSN79C7xsow55
         QbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484783; x=1720089583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBerhuPUPnvHMMtpXidwo0lqOY9yjptwKl42PSVTWQ8=;
        b=b75FbVEnfH/bX2huePiro3DZspWA+Ad929O6qmPYhxt7b7BOroR9jHBqgDtNVX5ToU
         x7RNOC19bnFrUQpJs1vAiVrCmAw1jKWlHbAuyL4veNx7XQrSu6u8GjmWdfuZrHhgvMXj
         nKoEPddSyo9pnDxFwn2wI/NQpbJNdrmOV2d0DpREhuwpKvLqS28lVgKv8SrzHlq7m/FD
         qSgKG2yi7tTG29s+na0SWysLbmqW1uenOpo1ZR1lLlcuP7j+hzAIq8Vn5xrvF3TJP8Wu
         772oeiJBne55MUBo6db1ze1rmU3vbqEzFY/K7xTNZXypHv4fjHdsd53dH9cQP+GVoRG+
         hliw==
X-Forwarded-Encrypted: i=1; AJvYcCX56ifqEt34c6AgB1Nzc2ybUUR7/l1sfqAQ0T4ZXYLRQG+CofGrWGNELc7pCCicht0M8nZq8l63NxiG4ZGZ6XHuruWuKE7yVDQHfhVN
X-Gm-Message-State: AOJu0YxTrm7lUgHOpGQILqS3lm0XGgmqyFKfv2MdgX66zM/z+05+20Zf
	uOr9ckPEbQ/fwAIo1yThpS6eMAr9P7a1N7/B/5FdrdwlydfndIZ5
X-Google-Smtp-Source: AGHT+IFLaWGlswrMxHfEGA/17kTRmUCtefJU4lJQNLERDl5+0gdtRbOe050inXgngVsX1KD0xjlNvQ==
X-Received: by 2002:a05:600c:3414:b0:424:a4f1:8c3e with SMTP id 5b1f17b1804b1-424a4f18d79mr45881255e9.34.1719484782675;
        Thu, 27 Jun 2024 03:39:42 -0700 (PDT)
Received: from lucifer.home ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42564bb6caasm19957195e9.33.2024.06.27.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:39:41 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH 2/7] mm: move vma_modify() and helpers to internal header
Date: Thu, 27 Jun 2024 11:39:27 +0100
Message-ID: <2fb403aba2b847bfbc0bcf7e61cb830813b0853a.1719481836.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1719481836.git.lstoakes@gmail.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are core VMA manipulation functions which ultimately invoke VMA
splitting and merging and should not be directly accessed from outside of
mm/ functionality.

We ultimately intend to ultimately move these to a VMA-specific internal
header.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mm.h | 60 ---------------------------------------------
 mm/internal.h      | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5f1075d19600..4d2b5538925b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3285,66 +3285,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name);
-
-/* We are about to modify the VMA's flags. */
-static inline struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
-		  struct vm_area_struct *prev,
-		  struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  unsigned long new_flags)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx,
-			  anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or anon_name. */
-static inline struct vm_area_struct
-*vma_modify_flags_name(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned long new_flags,
-		       struct anon_vma_name *new_name)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
-}
-
-/* We are about to modify the VMA's memory policy. */
-static inline struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
-{
-	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
-			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or uffd context. */
-static inline struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), new_ctx, anon_vma_name(vma));
-}
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/internal.h b/mm/internal.h
index 2ea9a88dcb95..c8177200c943 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1244,6 +1244,67 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta);
 
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name);
+
+/* We are about to modify the VMA's flags. */
+static inline struct vm_area_struct
+*vma_modify_flags(struct vma_iterator *vmi,
+		  struct vm_area_struct *prev,
+		  struct vm_area_struct *vma,
+		  unsigned long start, unsigned long end,
+		  unsigned long new_flags)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx,
+			  anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or anon_name. */
+static inline struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
+}
+
+/* We are about to modify the VMA's memory policy. */
+static inline struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
+			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or uffd context. */
+static inline struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), new_ctx, anon_vma_name(vma));
+}
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
-- 
2.45.1


