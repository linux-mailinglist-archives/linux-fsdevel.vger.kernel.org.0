Return-Path: <linux-fsdevel+bounces-12340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 644A085E837
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6538D1C22C0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62415696E;
	Wed, 21 Feb 2024 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTwaQUJF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90C1552F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544519; cv=none; b=YF4mG0gktWStxyYrtw8MnxAEmBcpjmrPWdG9Qd+7nfi4aMmtVRQMt8FcMHg7ADxuk0mtGFoMQQ5WlHgVlkSf1z8JufDEx6p8LikRXgs3Dx1lg65BJBWRpXeJrOaCf1CSXBoLVUv9gu2H8v0kdyaObMwwyary2A2NMF+RNFPqKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544519; c=relaxed/simple;
	bh=hd1J5dkAabTUxt5fufnQhMf7QryotHszZx321BkoNL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qPI0hqFQvbrC5cFs2YDDona9aONno1Wi1iBOfbX5NeJNy17Lh4mbhRafmnOhINmCGublAfDmgTLHYkB/WXfMiB8mVs/yjHMQnyOPM3UQ7GjPs51G8v8RKvSgTi0DIzAG3enMXG7z0WQu7kDYdkF9deQ7PxtkOV21QQg0OFnnun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTwaQUJF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603c0e020a6so58057787b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544516; x=1709149316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHb4H3aBf7zVkxjSohmSP0JQMXLGrYpxjhF/b1cUoKA=;
        b=pTwaQUJFAzAUKb5/1R5xQMk7vJAr7nzsz6OyTLJri8dYIW9YxFfU9lTEy6SNJHxfGk
         0PECkdkYRpr9KCOibfTb0nugM71jy5diVCXwaqXdi8ZYrXakTPU3a2DHMoCWEQKP57VA
         9YpB0OZ9M/bXO/rkXb7h8g/yHGIXxT9tBMfI/6HDC2vmj6vB+rDWjMh7TEv+0Kf+uYgR
         rl9VXKAkWpAkfB0b0YNKNO+OBJHXkY87ESq5lSXhysw6+0l/NnAOGeis+mYTSfUGx23N
         FJULvCPoMfz1Di8hAyDVvnl1ktKUKwXW03jvaRrPSegErAuVXrrVxD4JPbFfgxhLVXT5
         vlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544516; x=1709149316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHb4H3aBf7zVkxjSohmSP0JQMXLGrYpxjhF/b1cUoKA=;
        b=fgcTNrYGMwl13i1GIghsvwTy5GhcXnJ8RB7tWm2qmuLB/yKd5ANS93SPXfYrWY92R5
         SOobGDllgzji/xdRB7Py6Ows/aQesbAr7SAdekB71xes+4Wc36QWL2odGJ1V4N4oMwUR
         GwT1rk8UZhX0m3zGbs9rWm/rAi8tm9UdUl/SgrkSw5MCnV1Pr0MY3GYv1oXgt47VD05v
         Y1wZl+0XQaT9qtwUDhqk1Gq28jXJIUxSmH6DbLkQxCvelgCJ7QfbOEEKBSp2pRr0l/Hf
         p593icQRZtIDc4WXCcGHVlD1tB3Rt6RvPdd2le+MlBSVJf8yN9ztl5p7k7bP9E1g/mnY
         DraA==
X-Forwarded-Encrypted: i=1; AJvYcCXMsH3NaPTYW2akDQI+nPCYfcTCkazT6LB0CNmxXWZXYyfzRwNmuYhcFFunV9bcENuX4hadIYN61ndAAQxot2tR+SdvpB94xwBID446cg==
X-Gm-Message-State: AOJu0YwMZK3r24cx7Ks8WjOf7el96r5034TJ+qqt+3qL8wrqC8XT9ZBO
	WZlhJHCfJlB1Vdi83zEZnIMgtXtx31I8VCyUb1mGiaKz8paDRevpye08st6iNu0cdxaT1CAhkn3
	brQ==
X-Google-Smtp-Source: AGHT+IFiyKMub1eGZLzZF9NObSWfIJfU8Z6wUZOBIvD/PODcgJqUEzoNtVZWO2NPbtCUhIy8HmGJP9rxfPQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a0d:d5d7:0:b0:607:9bfd:d0bc with SMTP id
 x206-20020a0dd5d7000000b006079bfdd0bcmr3270706ywd.7.1708544515839; Wed, 21
 Feb 2024 11:41:55 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:40 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-28-surenb@google.com>
Subject: [PATCH v4 27/36] mm: percpu: Add codetag reference into pcpuobj_ext
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

From: Kent Overstreet <kent.overstreet@linux.dev>

To store codetag for every per-cpu allocation, a codetag reference is
embedded into pcpuobj_ext when CONFIG_MEM_ALLOC_PROFILING=y. Hooks to
use the newly introduced codetag are added.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/percpu-internal.h | 11 +++++++++--
 mm/percpu.c          | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index e62d582f4bf3..7e42f0ca3b7b 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -36,9 +36,12 @@ struct pcpuobj_ext {
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup	*cgroup;
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	union codetag_ref	tag;
+#endif
 };
 
-#ifdef CONFIG_MEMCG_KMEM
+#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MEM_ALLOC_PROFILING)
 #define NEED_PCPUOBJ_EXT
 #endif
 
@@ -86,7 +89,11 @@ struct pcpu_chunk {
 
 static inline bool need_pcpuobj_ext(void)
 {
-	return !mem_cgroup_kmem_disabled();
+	if (IS_ENABLED(CONFIG_MEM_ALLOC_PROFILING))
+		return true;
+	if (!mem_cgroup_kmem_disabled())
+		return true;
+	return false;
 }
 
 extern spinlock_t pcpu_lock;
diff --git a/mm/percpu.c b/mm/percpu.c
index 2e5edaad9cc3..578531ea1f43 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1699,6 +1699,32 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
+				      size_t size)
+{
+	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
+		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
+			      current->alloc_tag, size);
+	}
+}
+
+static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
+{
+	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
+		alloc_tag_sub_noalloc(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag, size);
+}
+#else
+static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
+				      size_t size)
+{
+}
+
+static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
+{
+}
+#endif
+
 /**
  * pcpu_alloc - the percpu allocator
  * @size: size of area to allocate in bytes
-- 
2.44.0.rc0.258.g7320e95886-goog


