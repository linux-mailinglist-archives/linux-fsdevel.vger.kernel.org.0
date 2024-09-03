Return-Path: <linux-fsdevel+bounces-28392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3AE96A042
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48737285820
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59913CFA6;
	Tue,  3 Sep 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVJqXNnq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F11E502
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373352; cv=none; b=tAi1mOf8qnYNduXjUoxXer0LQcUVx3HGVGlOMrOBlVhMN3Unvsht4JfIUCfJaV7lNCgGFuyl13ScM6jMw6uIBUakLkrZAsZwfbdTrmO1ZTZB7vlbrWvxgB2FaESW3cGPd8y5gmwU+eIzeIzCFGrKz8Ds+VrAzSUxNM8J5qyhPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373352; c=relaxed/simple;
	bh=Kd1uMp+HUkedeShv2sPdOAndToo750mFLJVW3GciVU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CeKct2dDiTkUDA+rR8qrfXxzsIE5Ztpog+NM6OulwBZozjgIn80lunW6Pha4fSOGuNYeke5xopCtIQzpaTE2BRz/ACcd7JmsB97jTBTQFeDBoPdCAillW/UwRDTdjv8nPhaH7XJRaSwiIkc00X18E0ZTRX2ZEpPay7WCZ4UffaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVJqXNnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AA4C4CECB;
	Tue,  3 Sep 2024 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373352;
	bh=Kd1uMp+HUkedeShv2sPdOAndToo750mFLJVW3GciVU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pVJqXNnqYjpyuPF/kKeJ/msDo8LDirhJKxcVzSVn7jGoOyLMZ2EXXghasprE9pufQ
	 nsM1+pfcpmCTfnI+Xk7jru584AUPl7jVdYtUCniXFOdwNzUUsY50ZS2tt62vETfhET
	 zeEFzy9W1AshaSijXs20r8yLrPteIML1dTi9/GnZqons/TcQC6DryLuUPzDwBaJurq
	 vqeEXvHKGC8YbzAqMK7hE/s+NQn91v8Kygf3A1/ZmWC3qwmFV6pQLZ6JJu+RVC4LmW
	 0kM1crsub4Y2/rH2WNdJgsRU9kKgMaKkPrkY0zIWAeIcQowvDzdck8rCkTDRGPf93d
	 IyAJNVW5/3KdQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:45 +0200
Subject: [PATCH v2 04/15] slab: port kmem_cache_create_rcu() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-4-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Kd1uMp+HUkedeShv2sPdOAndToo750mFLJVW3GciVU8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl5793k/QulzHebby06KKRblnnhx44rZyyUXdmuem3
 lNztXqVO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZincLIMPWl3gRFHUOh9u86
 PqpMrrd2+//g/HxW5YVgcmtiMqPCU4b/0Wlrlt+fzrDsf16A6JusAplFhXIGM8y+v59xpv+cqPY
 9HgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port kmem_cache_create_rcu() to struct kmem_cache_args.

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


