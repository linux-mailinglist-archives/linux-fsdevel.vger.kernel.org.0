Return-Path: <linux-fsdevel+bounces-28391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADBC96A041
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2472AB23B81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE469D31;
	Tue,  3 Sep 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGdsgjSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6151E502
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373350; cv=none; b=PX1ObkJIGsBODRm/cN9CGchD+Cb/Si/MSkA0dJwieVTEHJjBaHjNFXSgEGoWdi0ZBVxPM665Hq7415nkOxFPjDk/b6ij9Y3LUF+GcM02QbLOknpS6QA4ufqAGTuOJ+6PVP3FBAAy9Mpr7rD1uFPEj7AY4gzee4YJ7MrEArVcbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373350; c=relaxed/simple;
	bh=B1znre1e72KpovENRq2WhUqNJBBTL5E5a2ArimpQcWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rss0GLouExX8qAyccf/ao8KanOyENCIO0mtjh0lD2X2snn76LtbJCv8zgoAlvjUNb5gbRrUHnuPm15zRcMYQsIgMru5xnIIFXlfCjqcEdM8s8hZNcjY8/J5/psh/injPaIPbM7Xt/F4Eq11B31YuFk8F81yE0fajR8d07xFhT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGdsgjSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E388C4CEC4;
	Tue,  3 Sep 2024 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373349;
	bh=B1znre1e72KpovENRq2WhUqNJBBTL5E5a2ArimpQcWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hGdsgjShNU2trZTfO0WBjhdzdFWFkHmlXYOn8HDfCT0GXxvKeNgF4wR7j4364QNiY
	 q1wD+/F1glEBVwIUOInyw4qaqmx4U/Oph+rmhif+EMEeXNW9a5ukgf44ThUWBmDYIi
	 s6r+Feb7OUFSWPCiIeWlwCWwlrIDgqGQrCev2KyPGKL2d9Xrh3Kt5i2PDrOFFWYC2p
	 Ps42dhybyCiqsS/P2ys4JCo0fFAdNK5dcBwvyUNllQ2ssvhGcnQjY7A3UMGp33KJlZ
	 14g0pUVTW37Xs8qGyENRNZfTRhVIZwvxc1frcIpy8vVjZFSQas0GJPOpGCeIHFzX4E
	 1f1beu4RpQiyw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:44 +0200
Subject: [PATCH v2 03/15] slab: port kmem_cache_create() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-3-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=820; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B1znre1e72KpovENRq2WhUqNJBBTL5E5a2ArimpQcWQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl57930r5SMjm0K8nn3zub9kt13bs1KNlE6zjn196/
 CGhZP/b9x2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT2aTByPDq+TzWEP84jutP
 EhdmX+j96rHG9Zq3e8irf2+2pCxe53Sd4a/Ev+bF1kurI62YuGbzCcysF7Dsqp1xhqWiMWEC607
 DC5wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port kmem_cache_create() to struct kmem_cache_args.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0f13c045b8d1..ac0832dac01e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -439,8 +439,12 @@ struct kmem_cache *
 kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 		slab_flags_t flags, void (*ctor)(void *))
 {
-	return do_kmem_cache_create_usercopy(name, size, UINT_MAX, align, flags,
-					     0, 0, ctor);
+	struct kmem_cache_args kmem_args = {
+		.align	= align,
+		.ctor	= ctor,
+	};
+
+	return __kmem_cache_create_args(name, size, &kmem_args, flags);
 }
 EXPORT_SYMBOL(kmem_cache_create);
 

-- 
2.45.2


