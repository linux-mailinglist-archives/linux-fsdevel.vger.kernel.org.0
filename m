Return-Path: <linux-fsdevel+bounces-28679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6276096D0FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0326FB23DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2AA19409E;
	Thu,  5 Sep 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1yEAPYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99F194089
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523036; cv=none; b=TtSgGp5VupeRX+kOIPy0TkVojVTz5A8lihe9hq6zLV7H0HU6kvUKcm7jgoT0ISt09lzfhU/GIgG7AK+VN51Y5c+cJPC8NvU3OOJkJu+lqjHdWbbd9IPtvjO43RhL9qY5Q57S0O8ZAfPsn49Iw3omwk7voNgXwHfhPFH+T4U+7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523036; c=relaxed/simple;
	bh=GREA3sYaJRn8q3FSMpLjOkkur0kW09aZN/fas4uylbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MrRrIKu1qkTD876aSa7O4Bhx4FZiX92PnQZM+YLcDSKKpeC6JDQ3IKGXR9W5m6Ho8idP73Iy31WN/crtlFF/qQ3wvRMHOPiCAQLPElMe+syHy6Lr6sEJO+7TDvP5qZtzPDgypVhptsVcnK9+wHt71N9Qlj7XJO/fyJAGdYM05uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1yEAPYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624BBC4CEC3;
	Thu,  5 Sep 2024 07:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523035;
	bh=GREA3sYaJRn8q3FSMpLjOkkur0kW09aZN/fas4uylbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n1yEAPYOkhFGaueY8PxQNM4lK424wC4LLcA4VZoAvb5sRDnTnUifIO/WWNvg15+c/
	 96l0X4SE43ZRjAj/nvkbLg0iz5LROt+spWqSPPq2Txpfg7cSNT/Xz2E2WqOpJZdw5D
	 lFRk0NfhYGoH7+UQIyDyVZc9fWNIfgPJaBG7ofLXjCVb0EVzcm7SSJ42nymshXMfe+
	 /D4Wk6cfDKl6Bd4QkWanB6UptwyqN34Wy2BO7glxcb4C0nXfVsAoM6q1Qo8ZLO2pJP
	 ODo9PzM48pFQfM+m3oM7RCNDYwGgXrjv8vh7tPt4xxUrBY34iT/H0MdLerLxsImKvW
	 oa/+9x27JXu5A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:46 +0200
Subject: [PATCH v4 03/17] slab: port kmem_cache_create() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-3-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GREA3sYaJRn8q3FSMpLjOkkur0kW09aZN/fas4uylbs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPHa0lwdyv1ebHdoTLLK7L1hdrPXNizcXFIZcJw/9
 OjNO+2cHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5+oLhv2d7+4ofqTcu5jDm
 sq7rXHiimsc2YkPJs6o1ZgeKwyOC5BkZPlRMu3Ap7vgjqcV1UbX2r95Oyfi5J+0L61L/Hq6MW9z
 9vAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port kmem_cache_create() to struct kmem_cache_args.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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


