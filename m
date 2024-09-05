Return-Path: <linux-fsdevel+bounces-28687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C04B96D108
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F231F25B5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87D1946C9;
	Thu,  5 Sep 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV4vVsui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496441946B8
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523067; cv=none; b=C8W1+W+GFjL4UnLtn69i36yvcVwbPyxTqtZwTdxRw0w6ehyrf/NYrXcCkjyJdgqVC6yb4tDcOqpym5S/RfmkZxHsaEbEKlnKAjDRQH1U0oRB/yDSTcODfPvDuDwuz3/jvCW/WR3GZhWL5AIS5KIGC2KixbgEeNQ2T4C2jh5h7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523067; c=relaxed/simple;
	bh=TRtSxtRqOM5QvqM+zpubd3lGKKoppNfgu7eGyWI4SSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sc7Q+MPFvK1Sw8hJSKk/8eQAMxYe64T/cI4Ga4RZ63b2zjsEYYlzTVKvXNHEtx2iLwnKhb3wjYzKz6mgttoGTE5kgTQPKI8OpKAusr6eA9LugYN6bgSd1R3oxyXwT/qkI81MqSEG5KSbBvm8bmeNNUcEjO3qDZoSqrd1ofxCc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV4vVsui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D250C4CECB;
	Thu,  5 Sep 2024 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523067;
	bh=TRtSxtRqOM5QvqM+zpubd3lGKKoppNfgu7eGyWI4SSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IV4vVsuiF90rCnPrP9+D3fjrKdB7nkiU71sfUPuDqDHt7Nt84djcBwn0SvpdezNkT
	 s8NRunt/BRsUKMWxfeqJdGZ5sAM/JrbGl0ilv7KFyPEyhaUi5sd5nRZ4cPW+cQJq73
	 JJkYqO2Mtk26MOvw28Lmx3oy5lZvOmIoJXIiEMF5tqIBS/DTl7f9F7xs6Z3We7/Upo
	 D5loFUNGZEKdB5hKGPQnbYAUUhJXpd09ZCRWVf29oPY3USCLy09Cxm/mcjcHrbJ1fB
	 O5KIxLW1Q0Djvh+7P7Aqw1aef+KotOa5TUewsPpw/5bgrWZoF0vpC5ZDwaPZXB/kG1
	 GYM2dMWIdk11Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:54 +0200
Subject: [PATCH v4 11/17] slab: port KMEM_CACHE_USERCOPY() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-11-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TRtSxtRqOM5QvqM+zpubd3lGKKoppNfgu7eGyWI4SSc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPF+IvJk4uvP0VEreI5OXvLo5XUJHsXH71v3RZ+fs
 yVSb5OmSEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE/PkYGV59mvLjgeraKQv/
 f/+7OO7NgfUHju9nC2DMN3MzPGZndGIew/+UV9sDP31frXnR7BW7xOSZJduq1dj8zRNWWcZGH/6
 fY8kPAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make KMEM_CACHE_USERCOPY() use struct kmem_cache_args.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 97117a2fcf34..cb264dded324 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -293,12 +293,13 @@ int kmem_cache_shrink(struct kmem_cache *s);
  * To whitelist a single field for copying to/from usercopy, use this
  * macro instead for KMEM_CACHE() above.
  */
-#define KMEM_CACHE_USERCOPY(__struct, __flags, __field)			\
-		kmem_cache_create_usercopy(#__struct,			\
-			sizeof(struct __struct),			\
-			__alignof__(struct __struct), (__flags),	\
-			offsetof(struct __struct, __field),		\
-			sizeof_field(struct __struct, __field), NULL)
+#define KMEM_CACHE_USERCOPY(__struct, __flags, __field)						\
+	__kmem_cache_create_args(#__struct, sizeof(struct __struct),				\
+			&(struct kmem_cache_args) {						\
+				.align		= __alignof__(struct __struct),			\
+				.useroffset	= offsetof(struct __struct, __field),		\
+				.usersize	= sizeof_field(struct __struct, __field),	\
+			}, (__flags))
 
 /*
  * Common kmalloc functions provided by all allocators

-- 
2.45.2


