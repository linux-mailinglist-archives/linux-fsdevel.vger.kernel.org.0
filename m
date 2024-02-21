Return-Path: <linux-fsdevel+bounces-12322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EFC85E7C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70356B252F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CF712CD85;
	Wed, 21 Feb 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6j0BrFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C212C802
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544479; cv=none; b=HIhfGUZFGllMSfM3TXtFhidjMfjZtYlSDqeZCjfrBR6igUOgde8wDp5YP/eZPhVk4RJ1MdzPAkGCILhgjwollGCQVWK5jsc3k+bT+mAjpNtNaVsgujHyAopAm8Gbkn7E8DcHZDrrNPnIufTHlTAbB8Sp7QQZgTMD+r0KXofzkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544479; c=relaxed/simple;
	bh=lJWs+8NUGy1XLba1Ji9bxkypH1bXGGk7YR2c+Vq5GXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cIMRpbcDquEFXEeeidLVG4le0ui01y30s5rKDFOE3N62BU0E5LIcIyajPM/wNDxpBoSOjVm9e2sNhmRI/3g8lzbGBAUwYMfaZU+AU4/cXhLLspmcZW7T8aET5MxGP48pEWOFLTXHZNV71YDXiq+XKIWadGjBZpufBinF9JrA/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q6j0BrFP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so9722016276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544476; x=1709149276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEkUZGmdT8FEHHQk8lZ544d0po9Jm+ENmRP2MkpUgMM=;
        b=q6j0BrFPOR46seaJ1V9936rytUBpeFaUchgcM+2PUrPOiZeB6vIrWp8J6xIl2g9iyU
         GMoVuVl9Nsy75MhMIgGyXqTOVngZt7bADQodUnHKgMjP5KEKd9fguFgZKsEmAUPE2UH+
         ceWKn87JMyd9Yf9y2pHnBlXU/cL/OTATVFK2sBdlFbZ4Z+digcMt88LKigQC9miyRf5o
         xEcYwK+eMhPo/gxWd4Dr5qfekRv+ZkyBJMbTCttu6SOuNTzlEzT/De+IijgGqQmOw2JG
         nzgzMyDSfjW/rqqR3XHFbCykzBhdO5lR2xWSQyHQvB+4y8ZNgHL9KG2XzkMjusCvQJ2+
         n/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544476; x=1709149276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEkUZGmdT8FEHHQk8lZ544d0po9Jm+ENmRP2MkpUgMM=;
        b=XvvCw7oZ+XcT+p9ri7vkq327uz04wo14stFPu8wX1VVpuSFsBkvcRNqe1oUCYi9vnF
         J8tCM6dIijKP060tw/Begmltj4/r4HFj/JLVMNg4TM1tXoVCjVB2sTHN82KHdej9eEBy
         HpAq8zCq4diZWOEz64LeA7N+egYx8xyGP/fPn3tLXcW5RnJgykgvZ9qn8r2qPHIwMcFt
         Vq07pPEO2IPLA3R5YqZ9GODz784ErtriBfbXyV3VQONJ4Cd85AAhHjjPm7OIflrNW/Fb
         xHQiHTnoxPgdX8wfvPC2Iv/kdTY1nuTNROH+DKmzdxXvhpeQxaIfhcHndgaSLqzyeBpM
         USCg==
X-Forwarded-Encrypted: i=1; AJvYcCX0X8Z6a9zRBWNNXWTUAx+f+fqtKWvfAmCfJGqoMbFFGVTHMi+/W0PD+ug/dtm65DefbU6D+kZ4L/sLtyZACgQoeDbePjwGG6yDP43SDg==
X-Gm-Message-State: AOJu0Yy04vXyS4igN5aEQ9mO4nJ7l0Owi/nrNl04d0t9jybN9n4uicAY
	WbUt8/2uM6Oxp1orNDGj8aFOgHiKwdqfBgfOINlTWCYby/tTZxkVLFlWbvEu/MNRoLWW0yYmc2R
	jPw==
X-Google-Smtp-Source: AGHT+IGFqZQMKrIKQYeCMZ0dyCYxCh2jZRWMkTdBUYYdfqnWgxWQSfzS1xjoTphhPvwCFL+Ef45OR+v8sww=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a25:26cf:0:b0:dcc:41ad:fb3b with SMTP id
 m198-20020a2526cf000000b00dcc41adfb3bmr6923ybm.10.1708544476345; Wed, 21 Feb
 2024 11:41:16 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:22 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-10-surenb@google.com>
Subject: [PATCH v4 09/36] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Slab extension objects can't be allocated before slab infrastructure is
initialized. Some caches, like kmem_cache and kmem_cache_node, are created
before slab infrastructure is initialized. Objects from these caches can't
have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
caches and avoid creating extensions for objects allocated from these
slabs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/slab.h | 6 ++++++
 mm/slub.c            | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..58794043ab5b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -28,6 +28,12 @@
  */
 /* DEBUG: Perform (expensive) checks on alloc/free */
 #define SLAB_CONSISTENCY_CHECKS	((slab_flags_t __force)0x00000100U)
+/* Slab created using create_boot_cache */
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define SLAB_NO_OBJ_EXT		((slab_flags_t __force)0x00000200U)
+#else
+#define SLAB_NO_OBJ_EXT		0
+#endif
 /* DEBUG: Red zone objs in a cache */
 #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
 /* DEBUG: Poison objects */
diff --git a/mm/slub.c b/mm/slub.c
index ca803b2949fc..5dc7beda6c0d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5697,7 +5697,8 @@ void __init kmem_cache_init(void)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
+			sizeof(struct kmem_cache_node),
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -5707,7 +5708,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, node) +
 				nr_node_ids * sizeof(struct kmem_cache_node *),
-		       SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.44.0.rc0.258.g7320e95886-goog


