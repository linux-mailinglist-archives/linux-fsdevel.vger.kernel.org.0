Return-Path: <linux-fsdevel+bounces-11225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED28520B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0172D28A027
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8E05FB8E;
	Mon, 12 Feb 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9tRS26q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273F5F578
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774049; cv=none; b=ph7AIyib5Ksj9mxaf30ZthKDugSLJGFtSPrs+hYaNq6oEKJjL4hCUvQi2A9/s4PBnNTXUwNen5vgbPCnCWP1SaOae632qGkfN3bqGxGrLH2xYdxmr56hCMab4ajNkFz8ee8ZviEd1yTfAtzOPo4SRjn/aglVezCRG+3pgFwXym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774049; c=relaxed/simple;
	bh=rFxOazRmJvXVDMBFp+0gxbyGbXjSs9OXcenRjz5zrp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dRE+MWvMxw8M9r6bSU9XCPwxaf+VWkYp5B5EVtCiD9QrTRhHYXg/8k9Ns3hOE0/ATNILNzv1S8hH/y77svRe7wVA/Nh+B3JsHEl1d7C7wBVnP3CAPhFh0QqJVhMiFdADk+PJ4uqClDb8BX+es68UAvqVxGx1upmqRezTWRMzTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9tRS26q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604ad18981eso84791057b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774046; x=1708378846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjVDAYkVgDU7fuXLh0MJZ7V+qIVlVtuXoydpki6LzsY=;
        b=O9tRS26qal1HZMYF7ammvgw/ywiDw8AWm6PPmTg7HW+iCa8bKyQFxuy6KXdWeUcYzy
         bKFqD79XbbclStxC6/b433r+dYqlqMq6QXHUhC1xqYNIVxywCa9BQt/t3/zx/W4qZgEH
         stLvOkNtGbOW6aMLoPW3omgezI5IpAtafmuz7IqHUeups2ywSisXDVTBGJmxeR8klh/L
         b6L85WxEkPy38PiADRrcjJRNXPQG3RE8JWRpCClI41FQefQW2i9NaGaZIUHiGKh6lMyE
         ytjf5peUUN3WV46bH7MdREZA3cCjp/R7BWpRlcSOcD8dhSzRI9LqsX46wylLx1upKa95
         x/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774046; x=1708378846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjVDAYkVgDU7fuXLh0MJZ7V+qIVlVtuXoydpki6LzsY=;
        b=cLU+9/sIsF9JMpxChB4fTvkuKClux9ZyvASsax2z5aYrUiCA9wjEKRaOt7ZviEulmr
         6z6P/bpa6A80Xw7MGaY1GFnxbiJ72yUqJS+JhhqE2+pXYPucvYuO3tQSJ1+x+WBUHNPR
         MLXMarq2tg6Hq1dP1/EHg+KsXSGL0+E8QErcqE2rFdfpfD2kl1kbZpNHVbPevtXiTkZz
         QghESiQuhAa+GN1wg9olQPBaZRbw3+kGD7OuHKBWUNvqDSkVIXNCfulmpbjCGFBGW3Mx
         Nl9AFFtGm6KK1iCD+ZG4C50FPpUT1VU3JTk3+0bd73rsNMa2cTKAEdHRzhswVgA6rV3F
         Gn1g==
X-Forwarded-Encrypted: i=1; AJvYcCXT3yqs1D/zp7beqCxsuYZtRsA2Z06DmNnKDq20Tt6L5TtErnDjONj9ES2VTmozPSx78LSOZtAouKMeRgY+6q1uuqIEe0egcwxlXG5Njw==
X-Gm-Message-State: AOJu0YzBTPOp1ua3sx+Lx2l/v43OGG405AfS90aj2h2FLh0BpLFinbRv
	fRCvJsLzeaQltCBTHMjmy964iyKV0bfr7rB7zJsmUg8dtkR4gCCTJV0t1drBS/L3MU7XpMJnaqv
	cpw==
X-Google-Smtp-Source: AGHT+IESoh+UWKTP+1hXTVbYaUvPuidDpjnUl+NYldJf9cgWEgRiy1LGQkGWPWQFR+H7vya0ViMEzA6ILJE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:150d:b0:dc6:d678:371d with SMTP id
 q13-20020a056902150d00b00dc6d678371dmr2278885ybu.3.1707774046204; Mon, 12 Feb
 2024 13:40:46 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:20 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-35-surenb@google.com>
Subject: [PATCH v3 34/35] codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark
 failed slab_ext allocations
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
 mm/slab.h                  | 25 +++++++++++++++++++++++++
 mm/slab_common.c           | 22 +++++++++++++++-------
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2b010316016c..f95241ca9052 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -365,8 +365,10 @@ enum page_memcg_data_flags {
 #endif /* CONFIG_MEMCG */
 
 enum objext_flags {
+	/* slabobj_ext vector failed to allocate */
+	OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
 	/* the next bit after the last actual flag */
-	__NR_OBJEXTS_FLAGS  = __FIRST_OBJEXT_FLAG,
+	__NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
 };
 
 #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
diff --git a/mm/slab.h b/mm/slab.h
index cf332a839bf4..7bb3900f83ef 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -586,9 +586,34 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
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
+
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
+static inline void mark_failed_objexts_alloc(struct slab *slab) {}
+static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
+			struct slabobj_ext *vec, unsigned int objects) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index d5f75d04ced2..489c7a8ba8f1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -214,29 +214,37 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
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
2.43.0.687.g38aa6559b0-goog


