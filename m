Return-Path: <linux-fsdevel+bounces-28516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F4896B833
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD60D1F216B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397701CF5D7;
	Wed,  4 Sep 2024 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATXYzaED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE614658C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445323; cv=none; b=mC1NsCZIyvdhO3G6qvu+n+XFJ1yGjyRvganju8kxxEtwTe2U/qZUTwM79b/q/49SnJp03dnUfxnd2035sLUJ2zfKrcS35gLsA3LQMn1PCgXolPPtop5UTaA7up5KC6dWY1PIpGUgfgMlPI/F8/xqffc8EX0YBazEUAV4sAhy2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445323; c=relaxed/simple;
	bh=0yvBsmIzvOyKMPTmQD/+Lg+Nh4nfzS75mqd2tBAiPek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilJM/764SObyL8kqUzlLDSMsmVgG3x+dv9QscZF0oMU/DUwsfMaeL3LoOMpm0xpKgL4ytDpC0bQTIP9Z63FFKqSPErV8hi0vlPYHmJGMPosCUivifgxJQuLXVaHE56UyTD9ZSTc08+pOKoRk5oKqZ8NAWzc1Kt7JGVXNgAcYhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATXYzaED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE8DC4CEC6;
	Wed,  4 Sep 2024 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445323;
	bh=0yvBsmIzvOyKMPTmQD/+Lg+Nh4nfzS75mqd2tBAiPek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ATXYzaEDvpyqO1cHVGL9BkKUYRZSfC3s2XK116B4f+XLDx3OR0OqXp7vJQk46lpOB
	 o0+rzieBKLa9Ck3jreS4t1TXQ2/X2f2ZJiWgyRJbWBepXzXY3p+72PP1P4A3enMKTp
	 YJRpuc78eW/3QcKhW5wPqjj4YnoFgpSAk2Io02F/kROX5bxT+VVUVojSV6CVAKX4Pu
	 vytuhD1n/pj06Tld94xW8mBjHjSWEJuQeg790cjshKRbKdFqcY2fp1zrjgPLDERZ+a
	 JuJN7gsBnG4CbYClaIaCTeKJjJthJTBWZcboXJvlqzjvLiKUz4QcaE3SIbQ5x/xzlp
	 WU6mG6l3Yp7Pg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:08 +0200
Subject: [PATCH v3 03/17] slab: port kmem_cache_create() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-3-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0yvBsmIzvOyKMPTmQD/+Lg+Nh4nfzS75mqd2tBAiPek=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNnJbu88Z6+bms7x+X9qq2pO9d8V69rFpSOosqRs4
 dV4zTlNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5HMfw38X95L1Xu9QYhQ+t
 eJ13zN/OOL72oUYV06oQzmyNjE57dkaGuc/0N6ZdNHR3KmN4suviqSP+rQ0ru98LPu7ZYKId783
 KAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port kmem_cache_create() to struct kmem_cache_args.

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


