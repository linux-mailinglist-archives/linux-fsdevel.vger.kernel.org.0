Return-Path: <linux-fsdevel+bounces-11198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95DD852010
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBBA285802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB2524C2;
	Mon, 12 Feb 2024 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfAX/e2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27AC4D58A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773990; cv=none; b=YCYttdUbZQd+246sbpEO5tfcRXB/kZpswqy7cr+dhiO77xIFwoRTKjc8+9xjPClZ1uqWkMrIMl2dCPRm6NC+AINigbn3YqCPM3kY49KF4XwRpiEsR5Zv2r8bRKS2YuS2gAcF+grWsjzR6iefM0CkVQxJBrtXDJOU7n/XFu15xcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773990; c=relaxed/simple;
	bh=YHyqeuHvUrbxaU4ktRueMrpYAdLsayJ8KqWKnRsL9Bc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UrRpcj/Y/WB6LuKj6qdk1lLo/RabpMEbEOKwJc4RKEdllHb/+g1iu2xYyRkH64kjuVdq5Dd3VtZySgV/dl8vfN52knGOnb8CaGvG8pctWzAZkxqpoXDNtoDRCKJHC6lHe/keZtl0mlG/qBqVgIDOZttI1q1SXMBcgHQohbqRKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfAX/e2z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso75950727b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773988; x=1708378788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPRNF15NS/yHs+nflQ9JCJcKpeGLPrq2C4Bm4JvXiOY=;
        b=rfAX/e2zkk9fIvt2hoH4yXWF6tTbvbza1R8p4oM8EOcsV3jn4jN4UCdShzqkT5uw+3
         PCjXcf9A8+A8UEb0ve9Wprj0OsKYmMaUA0R8RRLIdaspuJ8Or0G3AoOLUJ/KqtNR1H/v
         oNh0jvzvUia0jxJ/kyINC3uowMwB3AJL7VHmK/5iFmzom9Tr0rLFuZ/gZn70srYiocfl
         Lq7tfzsx4Epu2BCUIq4eEaAZ8YXdwUUaAbE7lfdcGcUEskVYy4/zD+7gWzJYi9nEJoCQ
         3+2aM+zgZgMEpbPsfPcwyMR0NH2iaENAcatbFpUzZSR2xRShrUJ0ZOrBDZ+oVFq+NlZT
         Qg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773988; x=1708378788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPRNF15NS/yHs+nflQ9JCJcKpeGLPrq2C4Bm4JvXiOY=;
        b=mD9dAlBTT2adrtpbtnj94zqB+jDSt8lr+X9eGBCMgfWe1gvpI75yyhKRVSx05XXBtR
         tjTJGsHGa9BKIEUJTDxoNTf1L1jWWCF2IzO/KABejNJ/d+qWBnltLiR74my4yCBVxqKF
         vpfxJRXpO786BEAzecA59zXptQAzkQXuNBmkKmXgU9pALUaTTA/zVpjk8fPdtIu/BvV3
         wZG1hbsWtape3a6WM6fE2HZdfp5Lle8+DQiT1hMZydhNo3W4x9Ou1LqJY6Tw7kB7IwU2
         uV0aGMg+cXh3qL9lJH8N0eruN2I17e2SsFOpHcFoGldK8QYMYcMlgGjCQZd81l9Jj0mM
         3SEg==
X-Forwarded-Encrypted: i=1; AJvYcCVEVYMp2wUKVybeTYgcJQ9/As0S7cSfIjNIoK09jIofMWqvQBc5EZ7DqLfLEqjsZcCS+5PUOHXxAVjWhNiimjqk+M6ZpKDRKccNYMYMtg==
X-Gm-Message-State: AOJu0YzTY3Xwu/uUYl9VI4q9o5V/YlOhN4fCL/b5j/UpuJsbIR1wHb01
	yPKbpmY+DSva0tTTv5lnbLGJCFiT1uO2VYWqWBqv7kMQpgDiYhFBpb3bWIdCeFQd6Sot7qpT5YM
	efA==
X-Google-Smtp-Source: AGHT+IFIMBcV3x/W8fhRczbwea2w1q1gcT3ETfM1GWq+zDEkeIxrI9ytOpFdbEX8EDgRr+EtsMkcZCh6eRk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a25:53c3:0:b0:dcb:c4d3:6e07 with SMTP id
 h186-20020a2553c3000000b00dcbc4d36e07mr382686ybb.5.1707773987608; Mon, 12 Feb
 2024 13:39:47 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:53 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-8-surenb@google.com>
Subject: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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
---
 include/linux/slab.h | 7 +++++++
 mm/slub.c            | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..3ac2fc830f0f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -164,6 +164,13 @@
 #endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+/* Slab created using create_boot_cache */
+#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)
+#else
+#define SLAB_NO_OBJ_EXT         0
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slub.c b/mm/slub.c
index 1eb1050814aa..9fd96238ed39 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5650,7 +5650,8 @@ void __init kmem_cache_init(void)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
+			sizeof(struct kmem_cache_node),
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -5660,7 +5661,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, node) +
 				nr_node_ids * sizeof(struct kmem_cache_node *),
-		       SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.43.0.687.g38aa6559b0-goog


