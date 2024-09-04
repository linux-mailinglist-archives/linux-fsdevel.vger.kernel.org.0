Return-Path: <linux-fsdevel+bounces-28519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E546796B836
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59758B269CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E6914658C;
	Wed,  4 Sep 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcQXs353"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D57198825
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445335; cv=none; b=d0qKT59TfNIuXL3bIHTOqffqhbUejGhNWcOv1S+phtaRHNXHlK0FgCb9uihvgsM0gqSzDqNtdjw6BaQIWmzxqVHQadLhFmqdNvNfuyBtum5IgYHWe7p5Sz4QFBL/hW+8/qa77jpkCNOx1JGaqo7/AyMdZnITzxBojVjOIH3md2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445335; c=relaxed/simple;
	bh=wlErePvTE8gEuAQI7b5rPaz+icXnXkiXiNHwXkcPVSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPX2B4NUL8ULBrk9FjXupLVwkAJfJak/y3WJVRpNzy/ERduph3EO7gtZcv7XWB0douk78dXV7r5MPyqb1/RBbNDY+ovQIn6iYG0GQ4CCCeFxwBDSPAB5RIvw84IrU4mlOBqmaDbicmQxuEznZDsKRJR4m2dWxqjvfyLBsf1UvMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcQXs353; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84756C4CEC6;
	Wed,  4 Sep 2024 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445335;
	bh=wlErePvTE8gEuAQI7b5rPaz+icXnXkiXiNHwXkcPVSE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RcQXs353asnqMtizb8ucN9fB/kmrdEonJJa4WhFzECgl1zSEYCask+0iHaYbU7A0z
	 +WT8J2sxrWx2DYfPN/Wp0oJO3cpPXzoGsp6g5FhdnDbxO7BgD15iCDZh8iC6F55AX6
	 tfdEmhho3yPQgkUQ8YDVdjVp/rtS5mItx6Tzp19daAiBkCSHovIv67mP8rvt+HVn6u
	 iRosz7EPbnsH157G/WRr7qwowiavGfbdahCmEcloUYfOv6UIpynTERb7ORi/fbyqXc
	 U9GjQr7pb/4Z0r01sVOv/ezRE6PGYyMPqa3bv3wOEPhXC91/lNC6Z+GVtwHG51Fwnc
	 jofw4P+pfNMZw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:11 +0200
Subject: [PATCH v3 06/17] slab: pass struct kmem_cache_args to
 create_cache()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-6-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wlErePvTE8gEuAQI7b5rPaz+icXnXkiXiNHwXkcPVSE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNl1R3mW7FIn46d5Uw7FCL8OX7j68p7IPTOUeZ6nW
 fQ4evzz6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIkQrDPwMljWLOnBfnlr85
 ev34+sX3utvinm91l5RrsfgnVFdw8S3DX5meJ8+41y4wiH14V6ymv6fdjn3j+rfRbbdULWL17pj
 WsgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pass struct kmem_cache_args to create_cache() so that we can later
simplify further helpers.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab_common.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 16c36a946135..9baa61c9c670 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -202,22 +202,22 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 }
 
 static struct kmem_cache *create_cache(const char *name,
-		unsigned int object_size, unsigned int freeptr_offset,
-		unsigned int align, slab_flags_t flags,
-		unsigned int useroffset, unsigned int usersize,
-		void (*ctor)(void *))
+				       unsigned int object_size,
+				       struct kmem_cache_args *args,
+				       slab_flags_t flags)
 {
 	struct kmem_cache *s;
 	int err;
 
-	if (WARN_ON(useroffset + usersize > object_size))
-		useroffset = usersize = 0;
+	if (WARN_ON(args->useroffset + args->usersize > object_size))
+		args->useroffset = args->usersize = 0;
 
 	/* If a custom freelist pointer is requested make sure it's sane. */
 	err = -EINVAL;
-	if (freeptr_offset != UINT_MAX &&
-	    (freeptr_offset >= object_size || !(flags & SLAB_TYPESAFE_BY_RCU) ||
-	     !IS_ALIGNED(freeptr_offset, sizeof(freeptr_t))))
+	if (args->use_freeptr_offset &&
+	    (args->freeptr_offset >= object_size ||
+	     !(flags & SLAB_TYPESAFE_BY_RCU) ||
+	     !IS_ALIGNED(args->freeptr_offset, sizeof(freeptr_t))))
 		goto out;
 
 	err = -ENOMEM;
@@ -227,12 +227,15 @@ static struct kmem_cache *create_cache(const char *name,
 
 	s->name = name;
 	s->size = s->object_size = object_size;
-	s->rcu_freeptr_offset = freeptr_offset;
-	s->align = align;
-	s->ctor = ctor;
+	if (args->use_freeptr_offset)
+		s->rcu_freeptr_offset = args->freeptr_offset;
+	else
+		s->rcu_freeptr_offset = UINT_MAX;
+	s->align = args->align;
+	s->ctor = args->ctor;
 #ifdef CONFIG_HARDENED_USERCOPY
-	s->useroffset = useroffset;
-	s->usersize = usersize;
+	s->useroffset = args->useroffset;
+	s->usersize = args->usersize;
 #endif
 	err = do_kmem_cache_create(s, flags);
 	if (err)
@@ -265,7 +268,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 					    slab_flags_t flags)
 {
 	struct kmem_cache *s = NULL;
-	unsigned int freeptr_offset = UINT_MAX;
 	const char *cache_name;
 	int err;
 
@@ -323,11 +325,8 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		goto out_unlock;
 	}
 
-	if (args->use_freeptr_offset)
-		freeptr_offset = args->freeptr_offset;
-	s = create_cache(cache_name, object_size, freeptr_offset,
-			 calculate_alignment(flags, args->align, object_size),
-			 flags, args->useroffset, args->usersize, args->ctor);
+	args->align = calculate_alignment(flags, args->align, object_size);
+	s = create_cache(cache_name, object_size, args, flags);
 	if (IS_ERR(s)) {
 		err = PTR_ERR(s);
 		kfree_const(cache_name);

-- 
2.45.2


