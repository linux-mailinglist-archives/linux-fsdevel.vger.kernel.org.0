Return-Path: <linux-fsdevel+bounces-28514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC57696B831
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BA61C2036F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F9C1CF5DE;
	Wed,  4 Sep 2024 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVRvFeeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7472198825
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445315; cv=none; b=L5DyyJFHqoOhrJbpDmh31rMxuIIvQ0oOdMGriP0eT9nLEU7kgIQcjm6qnISbI+KoqOd4iFmNpCx6WSF/8hnjDd/+dCcy621+kILhJB1XH8BNSpWE3t6KjHM2hxw7ckTu1WeUIotaUPsAqQIHZ0MVCwWG+Qzxwyzwr4aFQ+ehMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445315; c=relaxed/simple;
	bh=aZEAASsBiFk/RgRLba541LPDxJ17oriKgsD3TIAIOy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/sqVIE+2bjtMF7MlPBiIRly2J/3+3m2/4/TK0j9SFZn3O8JpqVzIWR8+WOWoYuOCM/bIQtiOCTJDCOvU29A/bJ/Y+qKJSUk0XKwqsfrQU+cdzcY8MuSA1moHtLuQ4N5rMX+NBC3IpRLBL7oXBjOok6+TtY/HV4D16D9yLqKxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVRvFeeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CC5C4CEC2;
	Wed,  4 Sep 2024 10:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445315;
	bh=aZEAASsBiFk/RgRLba541LPDxJ17oriKgsD3TIAIOy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pVRvFeeIXH04mtBi0pL304wNLzScNm6KRBcMNa+Kk3rJjFcQUjqct+CJhwG66KIy5
	 MzkAx0bUoO3qqI85wSK+22x/YC0YPxsIIS4OrO7zFh5MgezfDiawCwkChw8Mn57Orf
	 aOmdR4bdcn2J0YD/lY6MIbAP76giGif1VTmMlO65s77Z25UQ3eMrUb6jE8Z0SL1H1l
	 Oc9LHKBhX5vamFvnc/buanj7jLBG4pMRdENbAkzyWqWkeYy7kLrjmiDvc90WqZpeGB
	 a5XITsPViOqtbzhFKuIOgNpN7kfd1fvQhpIcYhQigq7u81tCFyq281BXUhqi8zMhoU
	 MkMdBVI9gWAQg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:06 +0200
Subject: [PATCH v3 01/17] slab:
 s/__kmem_cache_create/do_kmem_cache_create/g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-1-05db2179a8c2@kernel.org>
References: <20240904-work-kmem_cache_args-v3-0-05db2179a8c2@kernel.org>
In-Reply-To: <20240904-work-kmem_cache_args-v3-0-05db2179a8c2@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aZEAASsBiFk/RgRLba541LPDxJ17oriKgsD3TIAIOy8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNm5xyytO7rTxql9L3d59dyG0jNp6epyKrNMn79vu
 jrrKGNWRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES6Whj+e89ZwziJweJX1ePQ
 /xlPfa8++PKG5Sfj1j8JW+PFfyYIrWNkuPyp5eJFc4m2ZcpXXhxkPDL3fYi/R09dzyxzxQZ+7eR
 gDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Free up reusing the double-underscore variant for follow-up patches.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab.h        | 2 +-
 mm/slab_common.c | 4 ++--
 mm/slub.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index a6051385186e..684bb48c4f39 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -424,7 +424,7 @@ kmalloc_slab(size_t size, kmem_buckets *b, gfp_t flags, unsigned long caller)
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
-int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
+int do_kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 
 void __init kmem_cache_init(void);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 95db3702f8d6..91e0e36e4379 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -234,7 +234,7 @@ static struct kmem_cache *create_cache(const char *name,
 	s->useroffset = useroffset;
 	s->usersize = usersize;
 #endif
-	err = __kmem_cache_create(s, flags);
+	err = do_kmem_cache_create(s, flags);
 	if (err)
 		goto out_free_cache;
 
@@ -778,7 +778,7 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 	s->usersize = usersize;
 #endif
 
-	err = __kmem_cache_create(s, flags);
+	err = do_kmem_cache_create(s, flags);
 
 	if (err)
 		panic("Creation of kmalloc slab %s size=%u failed. Reason %d\n",
diff --git a/mm/slub.c b/mm/slub.c
index 9aa5da1e8e27..23d9d783ff26 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5902,7 +5902,7 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 	return s;
 }
 
-int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
+int do_kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 {
 	int err;
 

-- 
2.45.2


