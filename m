Return-Path: <linux-fsdevel+bounces-11211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A26852060
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172B2287AC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB9C57865;
	Mon, 12 Feb 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMWy+lzK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B656470
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774019; cv=none; b=BycCpMMd/eRxSV2eKzJn+tu7RUtnidZATk7XGbPtDBMejCS0iXe/zE/GU1JPU9jf1PfUYW/VeNV2g/qEC8jtvVsh8aMeHVMHLRztTCK3gT2/JR84L+qD0qS8E6LOBzDyacBPk7jyZNQ7sNdJUz2Cjyp6NCnf8FMRTUWpjjx/uRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774019; c=relaxed/simple;
	bh=/ObVYElsMTOqZ264N892FMXju4ko1jf53Il+HTJwMLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bf5sw0KbHwkRjuBtOILfgYP8oVd7+smwBePsOPPiR4Xrw2WKcIHhUlKUuUd3qbeJ2fo4oNwaqlQcqnGHeTXTn1qtg6Wxw/kuUGrwNlRILvheqc4bAjYBulu9sr29w+gkpuvdjI4M7/ZHAKEOmG5FsQp4lwbf8QM9tmyRu2htl3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMWy+lzK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5efe82b835fso84268407b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774016; x=1708378816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFf/g8Eh9xc1yf0azF3fMp/AEmHqfeMm/yqsFpU3vIo=;
        b=pMWy+lzK7SReRl6zpXUVm4yB/mPCcmkrRLo3N/MCtABvymylfNkbvcaHKwdsZIcV8r
         RHZMh77/x+aO5Vh75KmDL0tbF+Hjx528tSEJPo2SKToKpLfnvl1gE9Cey2J4cB+fnbV3
         QmxGqr7HQgSDkKYyVrJwQV3l9+U22Amu94aI5wqdGN8gx2CUUKDxCW1xdby7MDSwLJ/a
         0Kzx2CPxb7TRTa+UFqxANct51yc9F2Zg1dSANpqCRDwxPtJqKX8AxbF7IesiUCLzlFvv
         XZhcNt8Ly1JHN1Z7LLKj61PIiJ3FpXIpxOixOFgZf+bQFNRvmuNvkwKL/tO+KFZGWYer
         IxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774016; x=1708378816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFf/g8Eh9xc1yf0azF3fMp/AEmHqfeMm/yqsFpU3vIo=;
        b=lR7l5BrcYRZnktOfXC+F5ee8tABiHgFmQnWB79RwW99/GhDZOFCmwXpT7HWSU7oaJa
         89X+Hq0O0qeRr5LfKEiTVl8J1VnUEaE5QEGdU3AhM8hTICS8kNMOKmKONcJLvTWG2umL
         dekq80HDReet4M5EbA5Vxla+h0l90Wc5TqwbNhYNArhu8WhhI8sU185aeAl01xxa+8T9
         j15wfzAx4xcmIIjgexPYOMffG+qlv1jS1K6Mx/sVbGgdYIoIxAQN5gztBs4MYVTysmQ2
         zGSYiKTzz66+v22h47fxhCFKObnwysCZftl72rPvQYDgRNTY8zwvUNJKcofOug29kfo2
         f2EA==
X-Forwarded-Encrypted: i=1; AJvYcCWWECh1F31epzIqM1BVrl9LPn3rBrMF7Jbx3or7+YMuDewgVfJ1KxA8GmeDhhxzl7crXCZfDEvlZB4uzUhjSh5Cg5sGdGs99jCXaUV2AA==
X-Gm-Message-State: AOJu0YzuUPz8XlCx6r2+QVrRMBD0QxgKurQm1tjU+kt6CJ1lUrldG01h
	5fFhzWLW3CFElpC9hwaepwimSKjHav7gkpAEcZ1vUWmpfWlilQnrsrbjSpxWB7NWzDeLTb4TE54
	NvQ==
X-Google-Smtp-Source: AGHT+IEjOAHzMTDk3G6Mkq9BQfM87/zY/tGgKD9M86mlp2G5yR63uKFbjyK/9+Jhrb/BiK/AnGAds8f8uig=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a25:8391:0:b0:dc2:1cd6:346e with SMTP id
 t17-20020a258391000000b00dc21cd6346emr2029085ybk.8.1707774016324; Mon, 12 Feb
 2024 13:40:16 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:06 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-21-surenb@google.com>
Subject: [PATCH v3 20/35] lib: add codetag reference into slabobj_ext
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

To store code tag for every slab object, a codetag reference is embedded
into slabobj_ext when CONFIG_MEM_ALLOC_PROFILING=y.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/memcontrol.h | 5 +++++
 lib/Kconfig.debug          | 1 +
 mm/slab.h                  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f3584e98b640..2b010316016c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1653,7 +1653,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
  * if MEMCG_DATA_OBJEXTS is set.
  */
 struct slabobj_ext {
+#ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *objcg;
+#endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	union codetag_ref ref;
+#endif
 } __aligned(8);
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7bbdb0ddb011..9ecfcdb54417 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -979,6 +979,7 @@ config MEM_ALLOC_PROFILING
 	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
 	select PAGE_EXTENSION
+	select SLAB_OBJ_EXT
 	help
 	  Track allocation source code and record total allocation size
 	  initiated at that code location. The mechanism can be used to track
diff --git a/mm/slab.h b/mm/slab.h
index 77cf7474fe46..224a4b2305fb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -569,6 +569,10 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 static inline bool need_slab_obj_ext(void)
 {
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	if (mem_alloc_profiling_enabled())
+		return true;
+#endif
 	/*
 	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
 	 * inside memcg_slab_post_alloc_hook. No other users for now.
-- 
2.43.0.687.g38aa6559b0-goog


