Return-Path: <linux-fsdevel+bounces-22774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE491C115
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191B01F21829
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9556E1C0DEC;
	Fri, 28 Jun 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWhXfAOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500191C0077;
	Fri, 28 Jun 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585343; cv=none; b=sww2ohFzrMm1eDKIpifA6zJ1fyCSccW9pLRD1/i62BtkmGK3TXh+mtgR4P8VhRACNMB+908MUTzsqdrjDEpwub5Zh0XA3pGyHJYFVt0aqrfP6T6iPUl3J8VAoeFsG2hG9pq/2SSLkUFys7iYnpzINAzADL+2NOvoDx5cleZdsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585343; c=relaxed/simple;
	bh=8F3m9fKSqJJe9qt0jLUm8kyWx0T6msjogjdAw34IZhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucMhIFC0yydX36w/iVKVhuZimXpYYgALT/Jol+XYr6BRYZfYXaAWHgxhoVvMcBqJBgIP2U9IVp0wtxRAvjpeZftZeReABaz9xGGGNTrioV5aeKjmSULkOBoxZlYGafep2/t5nyLlyh0mVT0bwSBDQ2IzXyPfZzjSb/HLki5wAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWhXfAOz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42573d3f7e4so2256145e9.0;
        Fri, 28 Jun 2024 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719585340; x=1720190140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4tIycn76980srpS0Qx+f5aSwAYnJlMpkjRvY7J5k/M=;
        b=aWhXfAOz6SJMUu0+3ucf3hQAoM2zwbhcbCFPHa/9m9uu9VR8bfxb6Q0w6La1RySNcz
         GJc9OIuOb6Z56hCllGptq/qPz+PKski8QKj9OK1c2zhAaLjKi+DVnUHkobHYB5Wi2ThD
         jy1fTot/Kq9Lj2RGVB0K1TdeQ92g4JL2FrlBw6cVpr8WyyXGRT+qYGyXwb0tn07AswTM
         K7zdqgFA0dhc7EzVQNANtfA7N7DHJ6HWlm+lquM6u3JsQxf7q5TuUA4YzYclwVOnYA/s
         h+b7pbnrTGO1x9nYMcsf7KWfjIgmZ7CoDPOBk6FUnfOTLy+XP2ra2S5MqoVY/tXin01J
         nlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585340; x=1720190140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4tIycn76980srpS0Qx+f5aSwAYnJlMpkjRvY7J5k/M=;
        b=pdwLpnkqJ2aWJXqo8waaMJX/8jzkwsDEQexTadIb4+N22oy42l7w+Pk6Qj6sGcA0mU
         +szdLRpxPe8Pv52J4d5YayZ7OgaoX9Ny/5dLV0z51VhoXbjChrJ97WJX7BQ2y0zzhc8V
         nXAysotCy92ASiGxkj8lX1MZS7WsorgMe6WQKD1nyhmpzdqG2om8LgbHz4XjtgzV6pJL
         0mRXgi6mEyrTrvOZbHNymIxLDXPhxwJOLPSfRMku7zxhWCoUjYiJOIFRnMS2R7J2G+GR
         peOoBQEa+ivHgTl4qeebG7kTUtq0d+NiQKHqeWND+Zvl2qNdVZWgxf/zVXMFXnItgYWh
         +bJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhLJQfCbq8FVo1/dokOL4SfIw39rGPNqxm6FT8GLHYegcKX7IGsPrCV3tH4sR39xMTer3EbNhBABx22MNfLPSAKL+9GISvhlYwcBKj
X-Gm-Message-State: AOJu0YyDwadOZsTbFKB5fwvuvqcbrlyqljDdzUsTr/S5B3V2fvPtsYS1
	CQ3EL7m/iamiuDAgdeofnYHn+eL5UBe8vI0neuXzdMmpSfR8oTE8
X-Google-Smtp-Source: AGHT+IFhBGe8jyb5W7chS9Spyqsf3A8ZCwGCMKmUS7z29i0piJQ3aiKvCg0rr0Q6ubvs+Umxr5BHGQ==
X-Received: by 2002:a05:600c:1608:b0:425:6498:3b6c with SMTP id 5b1f17b1804b1-42564983cd8mr40449895e9.26.1719585339378;
        Fri, 28 Jun 2024 07:35:39 -0700 (PDT)
Received: from lucifer.home ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm38985485e9.9.2024.06.28.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:35:38 -0700 (PDT)
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
Subject: [RFC PATCH v2 2/7] mm: move vma_modify() and helpers to internal header
Date: Fri, 28 Jun 2024 15:35:23 +0100
Message-ID: <0e048500da5cfd51647699c244b1575229856bd1.1719584707.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1719584707.git.lstoakes@gmail.com>
References: <cover.1719584707.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are core VMA manipulation functions which invoke VMA splitting and
merging and should not be directly accessed from outside of mm/.

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
index b264a7dabefe..164f03c6bce2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1243,6 +1243,67 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
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


