Return-Path: <linux-fsdevel+bounces-28393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E4296A043
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E5EB23C01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6CF77107;
	Tue,  3 Sep 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnwsuY/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7A1E502
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373354; cv=none; b=E7uAYxXuGRRP03iBkoKK/7bFdNjaQjue4t2uvcHa3fYQLgBNCrICQDVfikZttKqwCVFKcBWeZH+kXyaPh9ES+n/JkCOdKVX96Byn7w1MboUn5FLc/0vuUK4wbrWeVUnTEXZ0RlqfgAGTZiAvskrwqvHlnBM2IVZQ9dO97LX2wl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373354; c=relaxed/simple;
	bh=qZgCti9Uoopmu2of9/KPoTLyubqgNTKqAU6SyDZvCz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKpbapQ1m3QvTTD71KY8vDDED034nUq0NyrkwaXnplhZSu5k/+T4w/3iXxKD5/IB6GJYC6LoOl9Mv9y5gcTzSYZHpicJimrDYdhfCqlz86WC8G7PHAmDo5hwSdZkHVDLK6YGblsVYIsgPn8f6o7W2JX6ztBYqkymREM7opjF7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnwsuY/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D591C4CECA;
	Tue,  3 Sep 2024 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373354;
	bh=qZgCti9Uoopmu2of9/KPoTLyubqgNTKqAU6SyDZvCz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lnwsuY/Dm0ZSsZkzBUqNed0O6oKMY249pFL4KNk8UDjxunv1NStiWR9awREnGzVT3
	 KBca6yWLYFHtQw02kRp1g6S93mGZZkvCh5SMf91cFE7Mul25Dqh4HgLh5x7QqOwd+a
	 IASO+TMGu/s62B+KpNVrBsap/j/xFtqNvZeb+reXcuH6Akbp9Civ9Iho/TgGCsQpCA
	 aS9Sl+/mzHzSVEnoGfBPXOvJcKIw76woMywoZxaL0W32AZxRLrz0Pnc7TYIap5nl7y
	 A8+0eYI0Q8g9DM/vln56yslETXQgU1VF6SjvAlSG5UkpgA16SsQBPb+vrEyZK6c+6g
	 lX57Vb026CJPA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:46 +0200
Subject: [PATCH v2 05/15] slab: port kmem_cache_create_usercopy() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-5-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qZgCti9Uoopmu2of9/KPoTLyubqgNTKqAU6SyDZvCz4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl55dWRq+dU34k3mzC1vupey0rti+eO9s/2fNCoxHp
 X382RXfdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykKpPhr7Qby4t/pje7HY9u
 d25SzA3LY3tX8d15WbGbx7uqade+TGJkeHz0ycy1v7eviJaabRm/Ruw2154d1/h0nodxKkyfx73
 3DRcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pprt kmem_cache_create_usercopy() to struct kmem_cache_args and remove
the now unused do_kmem_cache_create_usercopy() helper.

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


