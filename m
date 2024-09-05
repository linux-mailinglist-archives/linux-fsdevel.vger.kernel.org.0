Return-Path: <linux-fsdevel+bounces-28693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A048296D10F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD62884D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178D192D8F;
	Thu,  5 Sep 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/cii1Y9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7D193422
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523091; cv=none; b=cELPeyIlcFEqZ+PeQN7X7Joqm2L8cdsDXH1aS/Tf8wD5PJJ10sL/ZqQP6xG77ZAHs70HVyMwAFTXo6vK8OssqO6DFDNMEuXJXwX5BueGJIhLyw0Hh0FgdR/bTQ8olPYrstn1rCXGe9QAcXYp3WADCzNbSmuQ8fkQ8lBhP53B84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523091; c=relaxed/simple;
	bh=EjTjGH3N7I+He4i3zTdEnIsNUEnQ9qSuzD1HUDVnA88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTfwcAzmZzirQrp8DmjkmsL9KlvxMzqOAzFBv4N+O7J1jubsKJxO84Cgw/kLdyKjDjdqjkaWAbSlD8n2/fW48rt86iByPBZbabTkDAkvOwBQR6YjVALjybzmfwzS+TJ0puyJ0WFAUZ5U47zq+/Zk2LjYw4ESY0M2W5kY5Wn0yRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/cii1Y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6815AC4CEC3;
	Thu,  5 Sep 2024 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523090;
	bh=EjTjGH3N7I+He4i3zTdEnIsNUEnQ9qSuzD1HUDVnA88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n/cii1Y9UaMO6oLLzq+PA4Vy0/MwZIQeJ9yLODD3MvOMqqhPRxWm1x7GIX25GI/qp
	 G690aWfdS5p10x5FCW5PqvhbTqhZefA0icmgivaU150EthEStFU1AgYtFd3GeaOJQy
	 U4EScFhr20WPqHmcHBwGz1opcb326Vs6aCqxqTaMdv5qaB+uU16A1bpHtGHEOJoNG8
	 cG/Y6jAnwZWHfrKLMKWP4gsjwHZdhNZHV1UgcQkVza8kALbZknFpAhxn9Vbp65HgHn
	 YDHbbJ5pm08OwI8mAypTWkqRLG7PQy+k8l1qGm1E1kBRtOq1owOgJziQNM69rdMVQo
	 PdkjcvlwIrOyg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:57:00 +0200
Subject: [PATCH v4 17/17] io_uring: port to struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-17-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EjTjGH3N7I+He4i3zTdEnIsNUEnQ9qSuzD1HUDVnA88=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPHhj1L7r/Bk2qwz7j/NNA3ZPkds8Gb9+f4l61uHu
 nD93VXpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPxOc/wV4Cf57l0b/FcH1+T
 VFkn/6fcDXo3btpERvZv8f637gjjBob/SW8yPtZ1fvr0p+QH91+O+GOvnQR7eBceb745USDVSoK
 VDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port req_cachep to struct kmem_cache_args.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 io_uring/io_uring.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3942db160f18..d9d721d1424e 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3638,6 +3638,11 @@ SYSCALL_DEFINE2(io_uring_setup, u32, entries,
 
 static int __init io_uring_init(void)
 {
+	struct kmem_cache_args kmem_args = {
+		.useroffset = offsetof(struct io_kiocb, cmd.data),
+		.usersize = sizeof_field(struct io_kiocb, cmd.data),
+	};
+
 #define __BUILD_BUG_VERIFY_OFFSET_SIZE(stype, eoffset, esize, ename) do { \
 	BUILD_BUG_ON(offsetof(stype, ename) != eoffset); \
 	BUILD_BUG_ON(sizeof_field(stype, ename) != esize); \
@@ -3722,12 +3727,9 @@ static int __init io_uring_init(void)
 	 * range, and HARDENED_USERCOPY will complain if we haven't
 	 * correctly annotated this range.
 	 */
-	req_cachep = kmem_cache_create_usercopy("io_kiocb",
-				sizeof(struct io_kiocb), 0,
-				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
-				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU,
-				offsetof(struct io_kiocb, cmd.data),
-				sizeof_field(struct io_kiocb, cmd.data), NULL);
+	req_cachep = kmem_cache_create("io_kiocb", sizeof(struct io_kiocb), &kmem_args,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT |
+				SLAB_TYPESAFE_BY_RCU);
 	io_buf_cachep = KMEM_CACHE(io_buffer,
 					  SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 

-- 
2.45.2


