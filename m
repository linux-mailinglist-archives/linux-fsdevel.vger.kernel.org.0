Return-Path: <linux-fsdevel+bounces-28394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D6096A044
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197D01C22FCA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20E413D245;
	Tue,  3 Sep 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU3gT6w0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A39626CB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373357; cv=none; b=O5Tx4ya9zhz88Wmulhh/0Qr17paWDjuO/meqd3/qj0JY9vC6ZA2pisexaW4j9d+kLOBm5lKf89dj1ubkDk7/aUrJWoLidHqmqPAURZBd1NC0P1esAp1wMjZia0aD6VRVkiunIbye6gv/xA4l9GPrjUbeQAtivMY2XPwk3VzezFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373357; c=relaxed/simple;
	bh=Kwi+I1VrtzNjFT2qOG43GSdAkcM45KGq+XLRDdRsBW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phG79IvGbLQX9/ksKVg6C9tnVPddGJNy5dO2wau0/dIxc78bzCzbfN0S5STA6A9CZRr4xA1Y8ErDxRBcT2UYmTrWKBoTV3ZW+befaAYDZFSoAVFsE2IPUhmoyFSveBfyv00j9rlDP/X1UIBSAZrLKW+cmpZRw0yhAIEGzXmXr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU3gT6w0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A06C4CEC9;
	Tue,  3 Sep 2024 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373356;
	bh=Kwi+I1VrtzNjFT2qOG43GSdAkcM45KGq+XLRDdRsBW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HU3gT6w0kxMRCh5cjqQ6GVZT9zHNO+tW5OEaJBvo0wqjvITuNxXJnWE0javyOTqvr
	 FQwWfOYB3XwW8uiTGL2BRtw0FoBY4nIFYHGzhueA7CW6+ZyWob9/v19WpyvgykMF4F
	 0P5Y++52gJVpGcEw0uSSOQl7l/1cihjlemmOLneEIhFzMqJeYJJTjt7Sh9wrB3qQZL
	 zetPgbUDZvBTIRqtEdsoFD8Ulima2cMJVWDVNxfp/B1qF2Xnx2SVhJALGh05CPWFwm
	 6zvELTznDpr/2y7c4+PII7Y1eE8bujIG2SPWHhcRfP6+MLYRrjAPDYDXSFPKDYKOUF
	 OXufpqNfUg41g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:47 +0200
Subject: [PATCH v2 06/15] slab: pass struct kmem_cache_args to
 create_cache()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-6-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3048; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Kwi+I1VrtzNjFT2qOG43GSdAkcM45KGq+XLRDdRsBW4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl54t6HCjduvW5zuL87Xma60vmixz2EVi+v1EUzOu/
 KIdp1n2dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkdTcjw1bOm71eDxO4vzrM
 tfp8IvronE09clPakure3Xb5PMPU4hQjw+M3m9gORTG+O3BeYtH19PclB7bZnHnHsN+5Xm53kE4
 CIzsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pass struct kmem_cache_args to create_cache() so that we can later
simplify further helpers.

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


