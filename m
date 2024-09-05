Return-Path: <linux-fsdevel+bounces-28682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7417C96D0FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D921C22885
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ADE194C78;
	Thu,  5 Sep 2024 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMBdS4oJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC3C1940BC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523048; cv=none; b=gdJZpheQOwLZqd5neob8FA3ZbeXQefq7xGJKmkTLhjrv5eq6VfrzXI+Sd/dPAHOlHzporK++SVLvsNLvlkaUUpRmRIEUpvNm3fJljUA8ymLkQwbK2LnevRnoC5W6Hbh7b6k3kFhGhHWdjShkZXMn+5TiDdGazlo1NX8QfW1YLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523048; c=relaxed/simple;
	bh=9LaPebyH3fPMvl0DXSpF9bydw1rDuiO92393crLdD6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enfWhnlZhx5EeOox9kblF98EfIZiP19sCgbqfApNCLpnnVlyLd/SeFr2vnwmLpgSiEH6GoPwcDSNtoFhUKPjGDLlYCFJ7LGJKXpZMr9SngRrZZPyIgZglaQAU82nd5a/WYZGOKYB0UPYydmbAn82axLhAmcDjUmqynXIrkwX2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMBdS4oJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E314C4CEC9;
	Thu,  5 Sep 2024 07:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523047;
	bh=9LaPebyH3fPMvl0DXSpF9bydw1rDuiO92393crLdD6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rMBdS4oJXDrqT8tGREWQUTOIfMJ/VpD19pMK7GmE6v97b4Pb2Y4v9LbtFL42rZbSy
	 4QLWYUCZnCESDH/lYq7gVT5xSfchSm9rP1Ofd5fEPA7M7Wjc9+OPwFMuXcpMa7ljRv
	 GUDOr8RdXdjIa0ysmqgYVYyGSdZxY3Z9pMKAihH1fXR6lcUc95iKW61EhSVTEjOyds
	 gES6UEM4ZLmYRj3x+nBKmtXAjTT6EXs3Z0nP61/sxeR7GFRX+B9EcWB6o2EttWLYgN
	 RNpJMAHt4PanxiTjwkHRzn2t8D/GfFIUrR6crlqou9TzXGGzhaPB6DRa061E56J/dM
	 7Tsat6ATNJ5/g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:49 +0200
Subject: [PATCH v4 06/17] slab: pass struct kmem_cache_args to
 create_cache()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-6-ed45d5380679@kernel.org>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
In-Reply-To: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3238; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9LaPebyH3fPMvl0DXSpF9bydw1rDuiO92393crLdD6M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPFKWG33zVhlwrtNldGc23ao7HF5fPuMy6fDemo3L
 XaX5PbN7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5PMM/zNOmF/zC1hxZfra
 wDv9x4K3Xj5x8ceq6VGXD3d4/53qLBvEyNDsvTPy8Bf1+vmHhXb4LUrTW6rm9nr9y7yK7SaaFuY
 zX3IBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pass struct kmem_cache_args to create_cache() so that we can later
simplify further helpers.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
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


