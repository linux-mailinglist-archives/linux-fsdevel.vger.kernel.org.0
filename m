Return-Path: <linux-fsdevel+bounces-28677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D203296D0F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F653B2309E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D697C194A60;
	Thu,  5 Sep 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV7TCy+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B8194A48
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523028; cv=none; b=ZoYxbRUbFbIebk+3VgNaMpUCim/AzPf+dRvCbn6ixOzteeUCBt1IJumwnUDDbRJD2wp5bOyxxnabz/S2s9h1OIGg54hRWevn7gdRRqVZEeU8w9US2CO7XCej0ME9YE4te3vAzzB7jsQuB/zLq7q5CHXlKEJ40zA/vbQShXGBMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523028; c=relaxed/simple;
	bh=rY6kC2WiEYeQ/Zth3l+6kLSSBQxvb1BV7zU7+V4xp9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BwDMs3Sff8cIn8ODp+F+5hKruqDrrC2KBwvips8bgK7cZG8EJWJXcdXZe2Zr6UyBU9izIHiTMT/SNlXk/O8eJ2zAFRVayvqaq0BSfGIE6RlbUXmsoQZkFD+mq8bRrIsv1vH6L3fdmuFfOa3044b2NK+MUQKakaTkVDK+eI4JjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV7TCy+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62592C4CEC4;
	Thu,  5 Sep 2024 07:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523027;
	bh=rY6kC2WiEYeQ/Zth3l+6kLSSBQxvb1BV7zU7+V4xp9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PV7TCy+xlc5pai2T6OdADRXzqDCI7RS8Bew/YoEZlFm+l72tOIN19MbKrPF6i5xBM
	 gOSOOQaJQe465NMdIBUFo+hbYDaRhYpDBiPbcDjqtRlv4DoS2DtOzj+tQv6cfdWBNb
	 q0/i6dtuVk/rAoczLEeDpKbjTKcXRRWRLJDQAjn70rnQxzBUnrBpk0NSHVvzdefNjO
	 RB4FHrnCps+DNwlrGxUABHRx3MBhNmetxyiNvz5dkhcGbVTYjn3mTBI+qXz7EvI+WC
	 Y5xY+PYXXi78sd/hs7aUOS4++QZ8sdSPHGUlCFu1/5fer/b2UN8aXI5F+OehXTDhhW
	 fKT+xPJB0wmuQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:44 +0200
Subject: [PATCH v4 01/17] slab:
 s/__kmem_cache_create/do_kmem_cache_create/g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-1-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rY6kC2WiEYeQ/Zth3l+6kLSSBQxvb1BV7zU7+V4xp9g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPEK4X7zku9Z8Eq+IAvWO5pVE032Bs03YHF2aUuIm
 s81MSG5o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKFpxn+yoRdZjFudkjftsb2
 yvpJ/zeGidzekMn8YGWqmMvE35bsexn+mTQ0TNHW08p6kHv/WRij7csO74MdNnfOrmJ8xKLl3sr
 MAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Free up reusing the double-underscore variant for follow-up patches.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
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


