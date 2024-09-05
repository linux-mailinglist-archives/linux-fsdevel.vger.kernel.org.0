Return-Path: <linux-fsdevel+bounces-28686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388796D107
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3A31F25B4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AF41946B5;
	Thu,  5 Sep 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYwRNlCa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F061940BC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523063; cv=none; b=hc4hvP9wB1zNV6p4fijp649cKqCaM2GDVvAcu22CxyBmP8t/sqerQtp7yqgLqGpsYRv0UPM/VR0wQ/yc0miO99MVtpC55HsrN/XLibTQ2O43OUQ/Zv5RAzYT+cGJjZN+EHCjUjLvqlQ8spNL7I/UTvZVuUmnPLFUvMAlnKam8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523063; c=relaxed/simple;
	bh=R+pPpbtSd7TpTn7/geWedM/ETd5BwUD/V+znBniHb4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O124tdf6MlRgOdzr/9NKlH2+sFC3+0J+YqSiOAcJ8XT0reQT58j7mOhS1agmb6DKNqbr7CrIksA9F7ZdZxa6DPdy7KNT8ZyPCNuyuR/HKgiuKWcMy0VNBDGBZcQpIQ8eYWmG3OnK6UrIpb1rHuW8Ajoajo6H0m9wOGxhXLoKLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYwRNlCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3E7C4CEC9;
	Thu,  5 Sep 2024 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523063;
	bh=R+pPpbtSd7TpTn7/geWedM/ETd5BwUD/V+znBniHb4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KYwRNlCarPHqMLpahTJxt9QurLzF3yW5roIRbxWkYPvzJJeQxMBhK7l4eQPQ+zUht
	 M35sBmieTcbswH4nzib0mhw8RkFBbOqAVbwmmHU/OoHbSo+qB5RbqoTlg5LgtpiJe2
	 ZxpUT6My1K+7df/sHXZRyMCZD2v3O1xaGGVp+MqlJnCgWYQ/wIJGJMqKmACLK3cJ+u
	 G4sRZDQEHpyvN7XmyRv1T/t4BPteuRlJefS4jEDwUV2FT73yONODrCuVq7wpcJM1ys
	 YdyCNYyN9RhyV2tdcMgFXEMBTQ52q883ZbY4PYRf8JCyL/s/t7Lrf31llAmmhfYMSL
	 dBWL4YbTmXV/w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:53 +0200
Subject: [PATCH v4 10/17] slab: port KMEM_CACHE() to struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-10-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=brauner@kernel.org;
 h=from:subject:message-id; bh=R+pPpbtSd7TpTn7/geWedM/ETd5BwUD/V+znBniHb4Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPEOPOFxrsVP6W3YHb7n2U915Ges537TFGG2fOPb8
 1fEzcPNOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSac/wP3tipJtDqcTMiBy3
 Uz/2yU1fupp34Z1bnKeOmxTYdm70vsPIMF3joN7yQj2NZT5p5Yv6JDZw2WS0GUv95Lu0YtZkqcX
 izAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make KMEM_CACHE() use struct kmem_cache_args.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 79d8c8bca4a4..97117a2fcf34 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -283,9 +283,11 @@ int kmem_cache_shrink(struct kmem_cache *s);
  * f.e. add ____cacheline_aligned_in_smp to the struct declaration
  * then the objects will be properly aligned in SMP configurations.
  */
-#define KMEM_CACHE(__struct, __flags)					\
-		kmem_cache_create(#__struct, sizeof(struct __struct),	\
-			__alignof__(struct __struct), (__flags), NULL)
+#define KMEM_CACHE(__struct, __flags)                                   \
+	__kmem_cache_create_args(#__struct, sizeof(struct __struct),    \
+			&(struct kmem_cache_args) {			\
+				.align	= __alignof__(struct __struct), \
+			}, (__flags))
 
 /*
  * To whitelist a single field for copying to/from usercopy, use this

-- 
2.45.2


