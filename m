Return-Path: <linux-fsdevel+bounces-15000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC8B885E4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B8CB275D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E613AA51;
	Thu, 21 Mar 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMKvJqkp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B413A27D
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039080; cv=none; b=uSwhAMmjxOk43Jjr8Ybvyk4E0pFEqOxkJ8S7GwLYywkO7DizoOPzIvDoWzbHMSRczp9zVNiEdIkjdM0AJx38zmhc6xeJ69IgfBXz7oypBnya4FuH8gdYEU4SeQmeDqNspt0FPFHok5mSsnkY8RFfAt/i/awvyTVe4BzPGsxwPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039080; c=relaxed/simple;
	bh=VIDk2cVbRQo+R3GXDZfOMDAjJplBMheLQJqibMpEc1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJJ0hAu+oJkg+YmzRSjx5u+BWEpZzmVsQjmEWsZXj0Vh6W3WnfM9LzmH4nzJB/FlLs8VZq+OOJP7P8Mh+K9b32M3cqseqyn8doo2lOYJ/l1Q/N0Uzx4Y79kAPdehVteR8AwkYTFw4qMRX1Ps4rYCbAvoZ4/bqu1ttNR0BY7hr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mMKvJqkp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cbba6f571so21990207b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039078; x=1711643878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOwNrbZCC43nJVxac3Uw9hAvg9K+bdh2+QxQ9H95ZLk=;
        b=mMKvJqkpx+BxEFkB+ronKenJxDdaREe/2vrpXzy7kUolfgwtphLhl7upFBWXJgOGKD
         ET/wnDXR8VIh7gHqkyCNAINrSbv+KqXm/Aht6yrAToaA+GA0GS74iFyvLLjUIkeIXJfJ
         CM+LsHs2yKxlzZIxAdm0mGbLRdfI0anLSVx133eqXnpLGQ11LMyrY4YsNhbJ8q1Ott53
         /Pe6CJBbvGmDATOjPlROJonKfccUz96JNytry813mTDa7MfRWmZjmYsqd5xf5jhFTudo
         /rYN3XSKkkYN9zOyNLP+i/Undni0XRNtwQ0PQP9JCJHRA4UaklfwKVrCYu3bC1P778Vc
         +Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039078; x=1711643878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOwNrbZCC43nJVxac3Uw9hAvg9K+bdh2+QxQ9H95ZLk=;
        b=XX/n66FIZnkFmYwxgM8p8OSnC0S5LRMY+jlMT7JWfuwBPOcYrhuv9n3X1BYXd6u3iU
         oiC7zVDrDzCfuQc2M67Y3Bu8ZfmPti2Ps0NBajetOOIZFoEHxg22Gzom7nVWiMZ6CeeE
         3SLOz03LtNRUbOBkz0P6KBdvf7fbtV36rLI6lNnlD9qc4OuYCMPhq5Sp5RBh13KzKKh9
         aCwEh01VtdSf7KwAR8mrVqJO3Ucqo3tpUP0nOWfx4sMoVzvkgAZdA+t0COU1j8xp+Aoe
         84ux4K+GKebTWQfq5h3vgreuzYjLDgqUOvCDHIbQNvzJf2idGnB3o8HkiRzAkatK2is7
         PoRg==
X-Forwarded-Encrypted: i=1; AJvYcCX9dElahDyw+8n3WRdtF7NvN8tTTY10Z1Fp0ecrCnQY3hCEXQ4BwPKvd/fBxf0L7SB5s/t9LgR0IzNZeiqjOl6qnBUyYTD9lNnIswqbtw==
X-Gm-Message-State: AOJu0Yw7H66WjiNDTqOCPSpLtQ3KPKjLapeD68d8SsPCaxtMWDPPU3ij
	dqFua9Kmqhp9lnJLtYBFwEiCSmEmyN8lS5Hww2hbc3sAsm6E8V2y5XLALUwXhRBlbYPNzy9iY9/
	Cjw==
X-Google-Smtp-Source: AGHT+IEW+wzJaTFBqhE05AsZZeHucxp+/bXHicD4m92IkMS+am09AVJUNTX8XqOhkKHJop6Lzvm1ThHm3tA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:1004:b0:dc7:5aad:8965 with SMTP id
 w4-20020a056902100400b00dc75aad8965mr5894352ybt.0.1711039077542; Thu, 21 Mar
 2024 09:37:57 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:44 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-23-surenb@google.com>
Subject: [PATCH v6 22/37] lib: add codetag reference into slabobj_ext
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

To store code tag for every slab object, a codetag reference is embedded
into slabobj_ext when CONFIG_MEM_ALLOC_PROFILING=y.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 5 +++++
 lib/Kconfig.debug          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 12afc2647cf0..24a6df30be49 100644
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
index ca2c466056d5..dd44118e7337 100644
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
-- 
2.44.0.291.gc1ea87d7ee-goog


