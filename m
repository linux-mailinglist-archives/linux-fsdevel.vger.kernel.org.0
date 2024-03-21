Return-Path: <linux-fsdevel+bounces-14986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F3885DF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5131F24D9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BB31350CA;
	Thu, 21 Mar 2024 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJ2BUltC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9F1350C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039050; cv=none; b=U2kCURrkkm77n5bfUqpUpGBrIIMubcAIQIbjzJuWt/oSbFnNeTHlgz4suBp7M5tFvGoMFDlNHVknhnPGmGO3E5/cPmLxW2mDpTHrvJ+9aGMjhddbMKdHBAGF1Vj2h/o3n6k5QQ7QUtjOOUkVciC5erbfH1IM+/0/bJzRrVwLbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039050; c=relaxed/simple;
	bh=asIGq+p6AxXY7sp0t9UK+2zZ/r825IxMduiccQ5trR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cUI5Jn/do4h5emzta9sqFGfdad2hOZWRtEseqj1/PV4rwr839NeF9oV09+gg4PUP3r0N7hD82lyT6TnpCP26uUy6IIZU0lovr5IFon9wKk7TF1pkkV+m7oJDAOUtisGEUrttyQ8qFYvt4Pm8sqd3TVh4J20nTTDyQjdsaG/iapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJ2BUltC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd041665bso21140077b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039047; x=1711643847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHSiwfbVG9SSjDRWdVOT6ZUhatpmkb8bIc+SfDPMGsQ=;
        b=zJ2BUltCVbrGki07q11jmQ1yfTwvNYYx65fFGH8MsDwEm1Z4p+ojlooUDcZxCvld1v
         xJAj0QfibxpCRtc4xP5ZpUlmftZ3b8TDD69xmFAg46ol33FTHGG6HKeibigW/cCCLb11
         VKXW3KXb1pm4hdEv85MrIcQsRN15Hmr3E/ZKdl/cyIor4XI7ziakLrC2nGo9o0thE+1z
         j/bEkb8kQ9pGyds5Qwf3OE8Q/1zgypiMLTkIPFWp4Wnifyytxfk+aNntJVWKx1fczrIq
         YMVGyI7IMhCGXiqFkamoMGS49qmmGMVn+BxkWRQ35qXzGySt694exclTLQuJA3P7vWMj
         i66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039047; x=1711643847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHSiwfbVG9SSjDRWdVOT6ZUhatpmkb8bIc+SfDPMGsQ=;
        b=vRWpldCB8IptHHIFvLufgqSbNOesXqsxiO9lIZ9LcebotzMQN/feMqa+V+v3nWfZjy
         LwElMQNnbPAXQNZ0mmbq1qeY8Mpi/MpmPX/+U+pBMdRonz+vfva9OBeINVEsVPwPBjh3
         4cqV6+GFLDpHLfxddUroPIxIFzlJeQDS4+yWhlZeu2THIlDsqB5+CxdomEzy21VUviaB
         m9lzx4P+ib0IvKu79sG7b0WXHY+BrznfCX5opdj3CHo3r0Dfj4fqtIT8hRFwZBlKY1pr
         ifpa5Osyf5i51S/hTopc1633iJtSmyfWucpfZAiA+oq/w+hL8epFTOxSETk05yTLFDN5
         gtxw==
X-Forwarded-Encrypted: i=1; AJvYcCU9OOrbIhN5xit7gORxfBTjU34eMzS0705xvSHQjWGqLt0DuCE6zOiTo8vftwzc1jz8JiXffiSDGgNrYFXbq7sOopT/CV+T6DyaRcF0Eg==
X-Gm-Message-State: AOJu0YzTfmWk8R51YrQshNhXBYkXv+9arVe8FaTEBeFrGbDS9cLYu6uR
	wrxovSAgaMrRkbYKk8EFWsONMQ1dUDhmnFdL10OWNwYSkSfSA/h0XFp+IMKn49qlbEER0lElAD7
	UJw==
X-Google-Smtp-Source: AGHT+IHTxPHB7kx8Th/drFBQT8IBucAuzxxJkHgWcz7qLRX4uELPgEbRqEPHfHLIjKXlEPHR4aaEf+Jx60k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:690c:d0b:b0:610:e0de:1387 with SMTP id
 cn11-20020a05690c0d0b00b00610e0de1387mr2235869ywb.2.1711039047349; Thu, 21
 Mar 2024 09:37:27 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:30 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-9-surenb@google.com>
Subject: [PATCH v6 08/37] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
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
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
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
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 10 ++++++++++
 mm/slub.c            |  5 +++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index e53cbfa18325..68ff754b85a4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -56,6 +56,9 @@ enum _slab_flag_bits {
 #endif
 	_SLAB_OBJECT_POISON,
 	_SLAB_CMPXCHG_DOUBLE,
+#ifdef CONFIG_SLAB_OBJ_EXT
+	_SLAB_NO_OBJ_EXT,
+#endif
 	_SLAB_FLAGS_LAST_BIT
 };
 
@@ -202,6 +205,13 @@ enum _slab_flag_bits {
 #endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
+/* Slab created using create_boot_cache */
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define SLAB_NO_OBJ_EXT		__SLAB_FLAG_BIT(_SLAB_NO_OBJ_EXT)
+#else
+#define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slub.c b/mm/slub.c
index 2cb53642a091..666dcc3b8a26 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5693,7 +5693,8 @@ void __init kmem_cache_init(void)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
+			sizeof(struct kmem_cache_node),
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -5703,7 +5704,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, node) +
 				nr_node_ids * sizeof(struct kmem_cache_node *),
-		       SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.44.0.291.gc1ea87d7ee-goog


