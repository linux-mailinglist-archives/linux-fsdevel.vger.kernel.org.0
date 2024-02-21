Return-Path: <linux-fsdevel+bounces-12345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3932B85E853
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF62C283E84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDAF158D74;
	Wed, 21 Feb 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFNUfnDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCC1586FE
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544530; cv=none; b=einurhYUqusVutIDWkvhKktDdZVm4wKdKBfKxnGu3Lalz/PqtaiNw4tyPvFfFZIw5CBX4Gf/tEMJ9D4fwPXAYWVYCyunMJv+b6SlpFhLgK3hfVx0EeRhbU/sqLp9Hj4YEUyMupGwspsHTg38fzALfXUnEF14Phi+avZnIOJl8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544530; c=relaxed/simple;
	bh=B9yREK+2m0y6au8+gNCPG8f4DCiVUoiiRYA7mpLHkiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nfPkNozHF757YQViXVChB/l48+aGIY/F7kTMUSaLrnRhMXN15Zp6tIm2XLvKtp8dR/z0lFyF3kAr1LPqPbAoJz7PKl+g3zHswFVAfEZ1r/MlZwUUfEZL1B4hSLxojARB40Tf6Ju34ditGPbl8izPNXRSlDmHTyNjhLqlV8KeWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFNUfnDJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso10654733276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544527; x=1709149327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/f5EOcne7K32iqTM6gsyOYn4NQeb5Q9RrrPaWIBtzrU=;
        b=dFNUfnDJH+KG0/fNYh/pqeM+xK8g33cEgaWPMmPlwy3w6rU1iWUor3mtYGDMvy0Sdg
         hC75pxuvy2OUYVu8Ek3G7mCPupW8aNgGWeQxvXhWMtwjWqXS35Lk3fctImyFz9aquXlS
         h/1gx1B5Wltw9BE3W0jg1uCTtdFjpt8fUgK5QL/0Kq9zJqI6tvZYfKsoryQJ1RubYlB7
         jB51KeSSnZms5KPjMDV/E3ORyZ8aqXTn1+VgQcbDBU8S01u44YQQTzWLzttvEkOzKm2E
         jLxZDkfutYHRbIK5COCZPoIciexOfgxKQAJX5pILZY+2PIcK1vny/CKh542FOMPInL1M
         p8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544527; x=1709149327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/f5EOcne7K32iqTM6gsyOYn4NQeb5Q9RrrPaWIBtzrU=;
        b=epU1eQvq1mQUlqCnjhYCgiEpFxO/MpZEbmHRkEITS05VjTu7vewMlo7aG24Slo1l5T
         +hsiP9EVP0hWHJwU8i6Gegx8eoTbUbo8xN4pr/PjMZkxmtXOODhRu7z5wsvt7RcEu2Jv
         VTi70C8cV7j0dHUFQzpoZbh17sOKb69WGokNNf0w40DRaaLwTXK7qfV4snAq7wQP3wiH
         CHpHUHIiRanUuZRCA2w+LXXSMjcKnD3SvBfv0xWp972Esv1kChIHz0T8WCCPoBYPmTjO
         3YdZG+w5keL2AJlOUKaeyPE52bU2ajTxJR3m8pO+DDMU/jl48jzO01s4lEu+2C42cqbu
         TZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQsbcsvJ5F2lJQCerJJfxx5xNx8/grV4Y9IfHGpsGHqo1+uYL3xONcaHKoDIhjo5bOfqo5kc+zll3a3hQMjVOHu+AStTBW0p6uNZ9Q+A==
X-Gm-Message-State: AOJu0YxeLyq3ypOY9wPi8FtCclIMKwcW9MBGODkyfKMxCwdsTCUf45pn
	babK3G558cZqi0hy7oO52nUuCiQqiz235CvoCj2nofmleP8BaFroonT+/Ao+onfb2fY1glLrRMC
	fMA==
X-Google-Smtp-Source: AGHT+IGFiWXsCIvnXCn7DCHC4E3aqtfNjiBbLG3wTDrJrg+DapwG+olr3URRZ84R+eZCxmTFvxp+ectvo4c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:134d:b0:dcb:e4a2:1ab1 with SMTP id
 g13-20020a056902134d00b00dcbe4a21ab1mr67096ybu.11.1708544527496; Wed, 21 Feb
 2024 11:42:07 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:45 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-33-surenb@google.com>
Subject: [PATCH v4 32/36] codetag: debug: skip objext checking when it's for
 objext itself
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

objext objects are created with __GFP_NO_OBJ_EXT flag and therefore have
no corresponding objext themselves (otherwise we would get an infinite
recursion). When freeing these objects their codetag will be empty and
when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled this will lead to false
warnings. Introduce CODETAG_EMPTY special codetag value to mark
allocations which intentionally lack codetag to avoid these warnings.
Set objext codetags to CODETAG_EMPTY before freeing to indicate that
the codetag is expected to be empty.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h | 26 ++++++++++++++++++++++++++
 mm/slub.c                 | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 85a24a027403..4a3fc865d878 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -28,6 +28,27 @@ struct alloc_tag {
 	struct alloc_tag_counters __percpu	*counters;
 } __aligned(8);
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+
+#define CODETAG_EMPTY	((void *)1)
+
+static inline bool is_codetag_empty(union codetag_ref *ref)
+{
+	return ref->ct == CODETAG_EMPTY;
+}
+
+static inline void set_codetag_empty(union codetag_ref *ref)
+{
+	if (ref)
+		ref->ct = CODETAG_EMPTY;
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
+static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
 struct codetag_bytes {
@@ -91,6 +112,11 @@ static inline void __alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 	if (!ref || !ref->ct)
 		return;
 
+	if (is_codetag_empty(ref)) {
+		ref->ct = NULL;
+		return;
+	}
+
 	tag = ct_to_alloc_tag(ref->ct);
 
 	this_cpu_sub(tag->counters->bytes, bytes);
diff --git a/mm/slub.c b/mm/slub.c
index 920b24b4140e..3e41d45f9fa4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1883,6 +1883,30 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 
 #ifdef CONFIG_SLAB_OBJ_EXT
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+
+static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
+{
+	struct slabobj_ext *slab_exts;
+	struct slab *obj_exts_slab;
+
+	obj_exts_slab = virt_to_slab(obj_exts);
+	slab_exts = slab_obj_exts(obj_exts_slab);
+	if (slab_exts) {
+		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
+						 obj_exts_slab, obj_exts);
+		/* codetag should be NULL */
+		WARN_ON(slab_exts[offs].ref.ct);
+		set_codetag_empty(&slab_exts[offs].ref);
+	}
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
+static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
 /*
  * The allocated objcg pointers array is not accounted directly.
  * Moreover, it should not come from DMA buffer and is not readily
@@ -1923,6 +1947,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * assign slabobj_exts in parallel. In this case the existing
 		 * objcg vector should be reused.
 		 */
+		mark_objexts_empty(vec);
 		kfree(vec);
 		return 0;
 	}
@@ -1939,6 +1964,14 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	if (!obj_exts)
 		return;
 
+	/*
+	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
+	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
+	 * warning if slab has extensions but the extension of an object is
+	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
+	 * the extension for obj_exts is expected to be NULL.
+	 */
+	mark_objexts_empty(obj_exts);
 	kfree(obj_exts);
 	slab->obj_exts = 0;
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


