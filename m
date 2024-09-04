Return-Path: <linux-fsdevel+bounces-28517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF4B96B834
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439D51F2152B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394561CF5DE;
	Wed,  4 Sep 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr54x1ND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6A1CCB24
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445327; cv=none; b=VgMOrcQiLcPKd+4Qnuxnh2u+BAFSjemnkA9+TKhkDE/QTgE+D5+kBGm2NvJmndGknEb70u9MdtnWoNN5rRiRC3+FNUn1XQBonMheFj5ofG9lzzZN0zVodkLBtjh23p7Jqo6VQMvbbpkUgtXzpeUEqAzv8J7yAGeyDOqJetsfpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445327; c=relaxed/simple;
	bh=PzF+2+t3y9QvUaK7XGtoJxZCJ/C5QzrTNKeCBjRAdK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAKyo5D/WUDxSHgheW+y6oNVfPgHsA6259u+Ec8Z57Zjmv0QFlBob6xgCcTvaRmv7sKzjP/nmBGKjvW0O6o/jQwbAbrDcHxzkXCCAt/C/df2UpoBlf83yoy2IP0NCP2+ZkQm34WsunT37ls3mFbG7tKkZu0KJuCiZRF8KhUqi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr54x1ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B2FC4CECA;
	Wed,  4 Sep 2024 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445327;
	bh=PzF+2+t3y9QvUaK7XGtoJxZCJ/C5QzrTNKeCBjRAdK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fr54x1ND6hGLkeb2A+9fO433Az2ZzEZSs5uo+FsIlP5Rw2c5k2FFT8CkidVw9waS0
	 w7VCYJqFVwFep3ul/BzzO5m1crxq1AiiijoEUK9ir5la6ndOW8jydEEDMNalFx4fbJ
	 5tm+i+5GCM2/3bMDIFNMRNQSQdRbw8OL5axjA3I2mXDhjNrNVQdUkCrOboSZx0Mg5I
	 FokxkNFZmpuxIUo5vu27G5LISDln8afLXkDB809xn+aw5LfGyV6VVIRiml77B9FxWq
	 T0gOE7uAzLjDGMpykeHfbEWYNRdoq7cO+fPIT4gfPh5JBnTMu6uNXWErgihqRQcbVE
	 bxzsSnzCnTYfA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:09 +0200
Subject: [PATCH v3 04/17] slab: port kmem_cache_create_rcu() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-4-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PzF+2+t3y9QvUaK7XGtoJxZCJ/C5QzrTNKeCBjRAdK8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNm1Se/tBhcrk60f62veG7IUPfrovW+R6MMvMkZr7
 xkn+f3+2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRresZGVZfuV3EN+lIY7Zv
 nejLMMEIbQedvUoXnpmtd1omvz0y/B0jw6e5HyJSY5waTD/eWWn7ce3MCg/f1Q6nuDpd735I06x
 +zQ0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port kmem_cache_create_rcu() to struct kmem_cache_args.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ac0832dac01e..da62ed30f95d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -481,9 +481,13 @@ struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
 					 unsigned int freeptr_offset,
 					 slab_flags_t flags)
 {
-	return do_kmem_cache_create_usercopy(name, size, freeptr_offset, 0,
-					     flags | SLAB_TYPESAFE_BY_RCU, 0, 0,
-					     NULL);
+	struct kmem_cache_args kmem_args = {
+		.freeptr_offset		= freeptr_offset,
+		.use_freeptr_offset	= true,
+	};
+
+	return __kmem_cache_create_args(name, size, &kmem_args,
+					flags | SLAB_TYPESAFE_BY_RCU);
 }
 EXPORT_SYMBOL(kmem_cache_create_rcu);
 

-- 
2.45.2


