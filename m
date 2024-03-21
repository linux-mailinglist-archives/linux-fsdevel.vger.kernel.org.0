Return-Path: <linux-fsdevel+bounces-14990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A925885E0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1387B264E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F610136980;
	Thu, 21 Mar 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLdzFuYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3413667F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039059; cv=none; b=gq6syfKt85Q0CCnSwD6tZXdI0e3BGCvL6SVYS61JZbV2Tl1BsaTWb9GUFdbedp/u5D9hzQNon7N4sv25fBL0CFhn5Hef/ZpuT4NJF65WW1MJtIOjOtoBg8vgUcfeU1C3bT7x8h1VoVjEOaSsKplMw4giMen3clKWR7Wt76ZfoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039059; c=relaxed/simple;
	bh=+Wbn8cbgVpizkhOtX6sgZbjCyWBIalHOvLdju46wytw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wm1kzFBNU0Itts1qIkWRjuugz/eALUPPwAKK5wJ/SGBadkY/m042YrcrEjF17kp/uBZCZCjEkVji/1Brth5JA6o2b6MvjXi1doVr1iadg7dn5Fq0akDmj2Z/UceT1sy8wMR4HDWJm+kCHPpLSfrA1RI3HjBbcfAmKrHMFLEnmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VLdzFuYV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so2286536276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039056; x=1711643856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ90PfNulEINqNY+MaQbbDhVRZQhbHdS/nw/zX5Mh3o=;
        b=VLdzFuYVlDnKvbI2NWinPW4x+pQ3NECzSUAnYPnRknvDrbyQnfTOgwPiyqGY/dZoek
         2cMH9kG8+ayl0dYbdHnip+W5KKhh98W01vb3MQmPNdsYhqBSgBjTHYAB+HlTJkP3YIa0
         dFpV59kt/n8psw5XjUyrsCHQUPlUnOKEV4tMUfzGrBphEMp/0cyiERcOgUO7MsIc9XDi
         fbPo3ZwVLJDAqzo2v54BP54aTT/AzsLMF6uDea/dHXvctQpC/AEu4S8cDYOWO0fqR9Fi
         G/UzVLW06lqao5GKwPKxT+cSjIGI++P3PkrqGKG8jP2W0SiGzU6wXk4L1MCRAYo9/i2n
         NuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039056; x=1711643856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ90PfNulEINqNY+MaQbbDhVRZQhbHdS/nw/zX5Mh3o=;
        b=lgTriHfUlWemEdTenEVU3U6Lui+MypaVdOU/VDzE9tApL/CgiwghbRNimKPF1oqfut
         bq+Ic0JgZ1K2uLErCBs25zebSEl5e4l/18Y72H2fR3TG5qZPR6D4lmrHjTdFzlwh9E49
         Q/g4M1yd4yU0X/Vaqs/IYZrKssyQnWo2iaJr12VrmVx6p+Y7vTlX4S2ttBXIFlgmSgzB
         IMITK8fC5V+rwo0iwCZGeUO5nHwp86+TK3cy7Wyd5NPIEE6h9Zpuur7bfPCbzgjTcZFN
         dkMQm77c5acUIypMFwGmAgyz/3cAbXdrad5TyyL0on9p/tAbB/fD20aOtJJB/UO8zyT6
         Wcsg==
X-Forwarded-Encrypted: i=1; AJvYcCUCT3RMplJSb7FnNCQs/zMcoJx7TiQcQUT9Le7cz/dzPnJ1WR39NONbZBjjV2IOlnEorHbaT+prGgE7+xQpKQCbHdjVZKpKLWHRpzekOQ==
X-Gm-Message-State: AOJu0Yyeuc2l1pvOGo8OtsonD00hYo8HmWfRZ5X3p/JNk9a5RGQfR2Vi
	5NIDc75RhtB22E9opp15z4hKWESeRZfSAWdtxq5tCltaBL19IlpqNuhblYAgVeloWsbI0AM03PN
	bzg==
X-Google-Smtp-Source: AGHT+IGn9vwdodSrX//TEYzDB0YX9rTZ3uTQLDwcOKBoMjo1PHAt30ZDw1z5T1FWhqViEm1/BwfsKtlP0DE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:1144:b0:dcb:abcc:62be with SMTP id
 p4-20020a056902114400b00dcbabcc62bemr5818428ybu.6.1711039055775; Thu, 21 Mar
 2024 09:37:35 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:34 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-13-surenb@google.com>
Subject: [PATCH v6 12/37] lib: prevent module unloading if memory is not freed
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

Skip freeing module's data section if there are non-zero allocation tags
because otherwise, once these allocations are freed, the access to their
code tag would cause UAF.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/codetag.h |  6 +++---
 kernel/module/main.c    | 27 +++++++++++++++++++--------
 lib/codetag.c           | 11 ++++++++---
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index c44f5b83f24d..bfd0ba5c4185 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -35,7 +35,7 @@ struct codetag_type_desc {
 	size_t tag_size;
 	void (*module_load)(struct codetag_type *cttype,
 			    struct codetag_module *cmod);
-	void (*module_unload)(struct codetag_type *cttype,
+	bool (*module_unload)(struct codetag_type *cttype,
 			      struct codetag_module *cmod);
 };
 
@@ -71,10 +71,10 @@ codetag_register_type(const struct codetag_type_desc *desc);
 
 #if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
 void codetag_load_module(struct module *mod);
-void codetag_unload_module(struct module *mod);
+bool codetag_unload_module(struct module *mod);
 #else
 static inline void codetag_load_module(struct module *mod) {}
-static inline void codetag_unload_module(struct module *mod) {}
+static inline bool codetag_unload_module(struct module *mod) { return true; }
 #endif
 
 #endif /* _LINUX_CODETAG_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index ffa6b3e9cb43..2d25eebc549d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1211,15 +1211,19 @@ static void *module_memory_alloc(unsigned int size, enum mod_mem_type type)
 	return module_alloc(size);
 }
 
-static void module_memory_free(void *ptr, enum mod_mem_type type)
+static void module_memory_free(void *ptr, enum mod_mem_type type,
+			       bool unload_codetags)
 {
+	if (!unload_codetags && mod_mem_type_is_core_data(type))
+		return;
+
 	if (mod_mem_use_vmalloc(type))
 		vfree(ptr);
 	else
 		module_memfree(ptr);
 }
 
-static void free_mod_mem(struct module *mod)
+static void free_mod_mem(struct module *mod, bool unload_codetags)
 {
 	for_each_mod_mem_type(type) {
 		struct module_memory *mod_mem = &mod->mem[type];
@@ -1230,20 +1234,27 @@ static void free_mod_mem(struct module *mod)
 		/* Free lock-classes; relies on the preceding sync_rcu(). */
 		lockdep_free_key_range(mod_mem->base, mod_mem->size);
 		if (mod_mem->size)
-			module_memory_free(mod_mem->base, type);
+			module_memory_free(mod_mem->base, type,
+					   unload_codetags);
 	}
 
 	/* MOD_DATA hosts mod, so free it at last */
 	lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
-	module_memory_free(mod->mem[MOD_DATA].base, MOD_DATA);
+	module_memory_free(mod->mem[MOD_DATA].base, MOD_DATA, unload_codetags);
 }
 
 /* Free a module, remove from lists, etc. */
 static void free_module(struct module *mod)
 {
+	bool unload_codetags;
+
 	trace_module_free(mod);
 
-	codetag_unload_module(mod);
+	unload_codetags = codetag_unload_module(mod);
+	if (!unload_codetags)
+		pr_warn("%s: memory allocation(s) from the module still alive, cannot unload cleanly\n",
+			mod->name);
+
 	mod_sysfs_teardown(mod);
 
 	/*
@@ -1285,7 +1296,7 @@ static void free_module(struct module *mod)
 	kfree(mod->args);
 	percpu_modfree(mod);
 
-	free_mod_mem(mod);
+	free_mod_mem(mod, unload_codetags);
 }
 
 void *__symbol_get(const char *symbol)
@@ -2298,7 +2309,7 @@ static int move_module(struct module *mod, struct load_info *info)
 	return 0;
 out_enomem:
 	for (t--; t >= 0; t--)
-		module_memory_free(mod->mem[t].base, t);
+		module_memory_free(mod->mem[t].base, t, true);
 	return ret;
 }
 
@@ -2428,7 +2439,7 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 	percpu_modfree(mod);
 	module_arch_freeing_init(mod);
 
-	free_mod_mem(mod);
+	free_mod_mem(mod, true);
 }
 
 int __weak module_finalize(const Elf_Ehdr *hdr,
diff --git a/lib/codetag.c b/lib/codetag.c
index 54d2828eba25..408062f722ce 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/seq_buf.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 
 struct codetag_type {
 	struct list_head link;
@@ -206,12 +207,13 @@ void codetag_load_module(struct module *mod)
 	mutex_unlock(&codetag_lock);
 }
 
-void codetag_unload_module(struct module *mod)
+bool codetag_unload_module(struct module *mod)
 {
 	struct codetag_type *cttype;
+	bool unload_ok = true;
 
 	if (!mod)
-		return;
+		return true;
 
 	mutex_lock(&codetag_lock);
 	list_for_each_entry(cttype, &codetag_types, link) {
@@ -228,7 +230,8 @@ void codetag_unload_module(struct module *mod)
 		}
 		if (found) {
 			if (cttype->desc.module_unload)
-				cttype->desc.module_unload(cttype, cmod);
+				if (!cttype->desc.module_unload(cttype, cmod))
+					unload_ok = false;
 
 			cttype->count -= range_size(cttype, &cmod->range);
 			idr_remove(&cttype->mod_idr, mod_id);
@@ -237,6 +240,8 @@ void codetag_unload_module(struct module *mod)
 		up_write(&cttype->mod_lock);
 	}
 	mutex_unlock(&codetag_lock);
+
+	return unload_ok;
 }
 
 #else /* CONFIG_MODULES */
-- 
2.44.0.291.gc1ea87d7ee-goog


