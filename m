Return-Path: <linux-fsdevel+bounces-28681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD096D100
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723E4287FBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812419538D;
	Thu,  5 Sep 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/D1P6TD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C39194C6B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523044; cv=none; b=RiOX4MKZizLSVabFTZOgdrCULVXuAbKpv6zEUs7Qo+kyOpDR+3qlzl9qrhF22iLxF+DsqL4aS9HbBTHaByzv/p3mIjpM8gUtv2DSBqPgpt1T1/8QGFBI+klbR3WzRL70EA4cn06JiTuFVnV5jrsFfTV0jhdlY3wzWDsePoWKXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523044; c=relaxed/simple;
	bh=6Lwr5vukmiiT/FN2uceSot6K8Ni/9MrZgxWKfDi+Qrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYP3Z7SYj19Iqi6Zhv/oGR6Ds842cN+a8uarezwxuTq06ZnpHbD2FgdH6qJaktuNJKPiVXlgbYjejqaI0BQWpg+hd/SjUQTSXSXuZ27QbdYwmapZEvj+INR29RyaireNGZQe72Y+4k26CYNBeMhklLE8guIjDfZGzzuS50fgqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/D1P6TD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DEDC4CEC6;
	Thu,  5 Sep 2024 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523043;
	bh=6Lwr5vukmiiT/FN2uceSot6K8Ni/9MrZgxWKfDi+Qrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R/D1P6TD7i3UY0YoNJUwmFJ6UyYHcjDyPANa2Wlb5o90hiQ26zKS5AR/jkc4f4SEy
	 YceSaYFbEZHm/C5PYEd5MAowgwnVp6kdP/beQa/V8vHmLlhdst0Xz1xWgKs0FkuH1+
	 kRbclNIQTlz5eexEo1D/n1agRtf/mXV9cXck0Yzr6cRT+LB+zwIebWhvkBdbQee3Q2
	 SnFAEKpZUub3Ye8AUkfS/JNiKoWP7Vh+Yrrg3dCuoORvb55B+KAXFtGKaXoZYcqaRg
	 GErCg5kgnpSiSOWZql/CqFt4+pB8A7esVmSzAcsfb0+uGVxtIuu6szTo6w26XFuiOx
	 2HsMsH/RvcV9A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:48 +0200
Subject: [PATCH v4 05/17] slab: port kmem_cache_create_usercopy() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-5-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6Lwr5vukmiiT/FN2uceSot6K8Ni/9MrZgxWKfDi+Qrw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPGKsfyzU2iy6oqJdrum/37ZLHLyxDqPwI66x69/G
 dy/cZWns6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BeAmr2b4X3hDN+grt9yT67Il
 Ng1Zx+Lux4SrOv7fxsC34I5BRsWGYEaG9/ZhR62uTH6+RsrF4JPes3+/Ns2q3ugaI+X3Ysf/D67
 XOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port kmem_cache_create_usercopy() to struct kmem_cache_args and remove
the now unused do_kmem_cache_create_usercopy() helper.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab_common.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index da62ed30f95d..16c36a946135 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -351,26 +351,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 }
 EXPORT_SYMBOL(__kmem_cache_create_args);
 
-static struct kmem_cache *
-do_kmem_cache_create_usercopy(const char *name,
-                 unsigned int size, unsigned int freeptr_offset,
-                 unsigned int align, slab_flags_t flags,
-                 unsigned int useroffset, unsigned int usersize,
-                 void (*ctor)(void *))
-{
-	struct kmem_cache_args kmem_args = {
-		.align			= align,
-		.use_freeptr_offset	= freeptr_offset != UINT_MAX,
-		.freeptr_offset		= freeptr_offset,
-		.useroffset		= useroffset,
-		.usersize		= usersize,
-		.ctor			= ctor,
-	};
-
-	return __kmem_cache_create_args(name, size, &kmem_args, flags);
-}
-
-
 /**
  * kmem_cache_create_usercopy - Create a cache with a region suitable
  * for copying to userspace
@@ -405,8 +385,14 @@ kmem_cache_create_usercopy(const char *name, unsigned int size,
 			   unsigned int useroffset, unsigned int usersize,
 			   void (*ctor)(void *))
 {
-	return do_kmem_cache_create_usercopy(name, size, UINT_MAX, align, flags,
-					     useroffset, usersize, ctor);
+	struct kmem_cache_args kmem_args = {
+		.align		= align,
+		.ctor		= ctor,
+		.useroffset	= useroffset,
+		.usersize	= usersize,
+	};
+
+	return __kmem_cache_create_args(name, size, &kmem_args, flags);
 }
 EXPORT_SYMBOL(kmem_cache_create_usercopy);
 

-- 
2.45.2


