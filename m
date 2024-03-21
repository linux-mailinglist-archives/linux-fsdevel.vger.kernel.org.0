Return-Path: <linux-fsdevel+bounces-15013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A4D885EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611241F21D93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA977145FEA;
	Thu, 21 Mar 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKEQf18s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161B145355
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039109; cv=none; b=J0QH47Z9tfaEQ40kx4vYjvOBaVWcLAF6lhr5WPhoYJX57BrGJCmlUoIw5CJ/6fwTdOpuEFFd7dxh3cpXpL0cq9p4/DtDWRwNyuewPREWU2yDNt0kGt16rzBJKQx9JIVf7NsdaxD576L49gZ/5Kw3hXK3y24/tkAignNeEFHny8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039109; c=relaxed/simple;
	bh=sKwHi2LesOQPsFcrmgNHdumjnazCwW7EMM/H1mtcM7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rup2m8QpEbVUGAnsIclI6t3wOjXCqpNHZ7bUylkbUEOt/7wIzhIwMfGxqUpM6lCDYe5I/IDyw4W7l/ceaUKjSFpyiOxoVMw/BBc+RPCWLkAoPN0z7o3qs6SKJq5UPa/hbqI/l1f9hjZWKBrcU86AJhTK6zCWwqOzfPrNovAqRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RKEQf18s; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a605154d0so14626717b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039106; x=1711643906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5LdsTMnIqabj8ROFrnDTgTazgUa7GmHleuFcbzHgo8=;
        b=RKEQf18sOawxKDynqV0HzgZqXxMSLoYL/EDoKGmAORGZavFcTdbWvHCCAJOfUu4+Ql
         DFBl7t4DUrbbiMH8P5j8DXpaEbaiQox1YDMioSuSkVjvtveIu/8ODLLK+7p+Kg40b7ft
         vIhlwPfhsdJxQVKpgeDL8gQxsL4LO0pKTkhLCSuxTbAnXU9iZr+HNk9qfK1uAms805Z3
         ht7zkgAzU3DS0cuQpFxV/Ly4aU59wPl2/7OgNooRsQzlr+5giOgotTwRayPv2URgCfSk
         y4VAvAeIDy/EVkgj1gWbqGCVYb4SnP8vxCUyQ3XZqdfNKjjda5WjgsJsy7OE+vXf9dyF
         PMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039106; x=1711643906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5LdsTMnIqabj8ROFrnDTgTazgUa7GmHleuFcbzHgo8=;
        b=MUtV9qC1JR+oJcHDp/ijcDKssU3mRAdCS5Vv8s94UI6dw5n1ykYJV5BXtHifxU/Upb
         1hpYxu20id4AjnQsQAuNyKi0S1bEPJPNs6IpmSTeN77AdHFKTVL+ijEek8EM3QZJjdCx
         zQITR0k/3qe5G5PAnFrIF6TPj7uKlPsCptIiOFYrpmMJoGyFGegmHDAqbL/FPoHYrqnN
         xw65uACNgmuUwvqbDU8zUavZyP8RJWe6ZPJIR0sUntqmsls3dh8TpP3Pu4t3sVyzxrQs
         qAG+xZOkaprGpPBk5+KQTMWd9XrQkIyN2K19uWo5dGxMf1BFNtbpsFoSQrkiTFxUCQEX
         3HVw==
X-Forwarded-Encrypted: i=1; AJvYcCX/kilHkmvTAf3+9oMkt3xy/+HaeSddjMbMgsvx4zo9zqL9klwN0UDnvuBW+2fLI0Hs4uhNbQH5tlCE3lLdj4Fsmx7tCSOcaDLZi8RbdA==
X-Gm-Message-State: AOJu0Yy5Za4/xMvG8HbrcTgGgxrgv91mLR0IahpZ7aNxTGcOGa39qtRN
	zH8zJg3NsIiSt1Vfa8skF/e0uy+2S/soKH04h3DgYjZHi7+bmhdXXEsYahK9kmB+dHWbhvI8XAx
	NSw==
X-Google-Smtp-Source: AGHT+IHcdcDq5+VHUFf2WWlMxzMO+//nklguhi2MOjraFbT9V29sxxC0Or3cfCWp5X/LcbCc/1WTryTy5Uo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a0d:cc41:0:b0:610:dc1b:8e57 with SMTP id
 o62-20020a0dcc41000000b00610dc1b8e57mr863711ywd.3.1711039105858; Thu, 21 Mar
 2024 09:38:25 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:57 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-36-surenb@google.com>
Subject: [PATCH v6 35/37] codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark
 failed slab_ext allocations
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

If slabobj_ext vector allocation for a slab object fails and later on it
succeeds for another object in the same slab, the slabobj_ext for the
original object will be NULL and will be flagged in case when
CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
Mark failed slabobj_ext vector allocations using a new objext_flags flag
stored in the lower bits of slab->obj_exts. When new allocation succeeds
it marks all tag references in the same slabobj_ext vector as empty to
avoid warnings implemented by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/memcontrol.h |  4 +++-
 mm/slub.c                  | 46 ++++++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 24a6df30be49..8f332b4ae84c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -366,8 +366,10 @@ enum page_memcg_data_flags {
 #endif /* CONFIG_MEMCG */
 
 enum objext_flags {
+	/* slabobj_ext vector failed to allocate */
+	OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
 	/* the next bit after the last actual flag */
-	__NR_OBJEXTS_FLAGS  = __FIRST_OBJEXT_FLAG,
+	__NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
 };
 
 #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
diff --git a/mm/slub.c b/mm/slub.c
index de8171603269..7b68a3451eb9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1891,9 +1891,33 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	}
 }
 
+static inline void mark_failed_objexts_alloc(struct slab *slab)
+{
+	slab->obj_exts = OBJEXTS_ALLOC_FAIL;
+}
+
+static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
+			struct slabobj_ext *vec, unsigned int objects)
+{
+	/*
+	 * If vector previously failed to allocate then we have live
+	 * objects with no tag reference. Mark all references in this
+	 * vector as empty to avoid warnings later on.
+	 */
+	if (obj_exts & OBJEXTS_ALLOC_FAIL) {
+		unsigned int i;
+
+		for (i = 0; i < objects; i++)
+			set_codetag_empty(&vec[i].ref);
+	}
+}
+
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
+static inline void mark_failed_objexts_alloc(struct slab *slab) {}
+static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
+			struct slabobj_ext *vec, unsigned int objects) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
@@ -1909,29 +1933,37 @@ static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			       gfp_t gfp, bool new_slab)
 {
 	unsigned int objects = objs_per_slab(s, slab);
-	unsigned long obj_exts;
-	void *vec;
+	unsigned long new_exts;
+	unsigned long old_exts;
+	struct slabobj_ext *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/* Prevent recursive extension vector allocation */
 	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
-	if (!vec)
+	if (!vec) {
+		/* Mark vectors which failed to allocate */
+		if (new_slab)
+			mark_failed_objexts_alloc(slab);
+
 		return -ENOMEM;
+	}
 
-	obj_exts = (unsigned long)vec;
+	new_exts = (unsigned long)vec;
 #ifdef CONFIG_MEMCG
-	obj_exts |= MEMCG_DATA_OBJEXTS;
+	new_exts |= MEMCG_DATA_OBJEXTS;
 #endif
+	old_exts = slab->obj_exts;
+	handle_failed_objexts_alloc(old_exts, vec, objects);
 	if (new_slab) {
 		/*
 		 * If the slab is brand new and nobody can yet access its
 		 * obj_exts, no synchronization is required and obj_exts can
 		 * be simply assigned.
 		 */
-		slab->obj_exts = obj_exts;
-	} else if (cmpxchg(&slab->obj_exts, 0, obj_exts)) {
+		slab->obj_exts = new_exts;
+	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
 		/*
 		 * If the slab is already in use, somebody can allocate and
 		 * assign slabobj_exts in parallel. In this case the existing
-- 
2.44.0.291.gc1ea87d7ee-goog


