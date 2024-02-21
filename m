Return-Path: <linux-fsdevel+bounces-12349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024B85E86F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7F61F245D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3402015AAA6;
	Wed, 21 Feb 2024 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghJGqihq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF91272D3
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544539; cv=none; b=P6ignNsT4fDJ/WClxoJvtx4VV6d3RyYlwbk24ICdUS+VimWlW/IG5oLr7QNRImSgyiK71S+OFmXhk5KwIeYBRAsGyPw3GKgAfWyjHJDaS4JFADeKkmR4HaEBf+ShZwBiaITto5EHFHpLZNw2kWwsNSdJ/nKQxDpg37lgh9u5zeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544539; c=relaxed/simple;
	bh=B81ntc2BK1ghpdKFoojoxaHAaxqN9YS49dmcG4ZqKGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+t5ME6LZISoE8f5l/K/j9EeI1i5BlDGCQ0XP01meU9Plug+bZiKB70X1I9um1G5jcGohogRSZFPoAc0Lp3FsNLpf8nkkuOPZFAAKLu7tzYqXM2nS5uG+vQMpbG2FcAL+PD3TG7Zxhuv/BXhloRg29TJkpi1ZvGgyBq8xcxETGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghJGqihq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so295711276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544537; x=1709149337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHJNBSQgY470Nm1vo9kQv1HWTlhW4/9LqFry/+3J5f0=;
        b=ghJGqihqcveTrqz0Vv1KgUfS81T6xIpcK9trj+ZdkkMLMW2FelijPvnlrXy1YyE6Sr
         4IOXQ5VxXv5BbmADr5DVeu3DBef+/kW4LuMtHp18uLxidS2U0T1raLPMrqPVznQ6N2nf
         YuUNHs0wbEj5vi9iMaM5oA1cM5FoOGo6LrlNpTOEx8t/n2HDv5oFzdn4tsD1H/HjM8di
         fancbZSVHvioSF/nU0OvFR3fifYolcIlHwzSL8TFHXhUSmE6zLPMsIvCm3h9BosXxzBp
         /NkeyAs2mHLEBqryrGRPmhtU3BF8bco6V4ZCZibX3nzSQmbCJkSyIv+5S4lUMhm3NlsI
         qlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544537; x=1709149337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHJNBSQgY470Nm1vo9kQv1HWTlhW4/9LqFry/+3J5f0=;
        b=aKCv2QoIyL2ddQeElBu+FUGZ9yqMENfkZopZOL2SGrGrE+9bqyqSPYX3OcC1t5/DXG
         G415hulC2FYdsIzTMmz9gmhTkV0zQlwq2/DnpLb2EsQHhT5l1+PJGdL7kvxIoW3n3jJ2
         TZNtyw6NYfAJjktbPjdYECWSl9qO5nufxumRAQOwbvnvhpI0WRjn3m4aFPXTDr6viZUt
         lwG2zIys4PNIYCIY8LATxBr8f4I10BR+dJ8qSNoR7cG51h6gNJgOQrkwaU0HGapH6DZA
         EtchNyITaukTGki4lBTwZ0hW4OAD0OpP+/OTvz/HbCh7pRvwuHIW/0nv/HRnvAdGZuR3
         BEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK5XMO38WcO/2haD3JvuapIA2YSHRhZScJX6hDoVgigOL6mAau+RCiY8zkyUjLcSBL6FRy0+QbNi+JKG47JkaVszrzITA1cxrqoM3B4w==
X-Gm-Message-State: AOJu0YzVN438zZ2VPnU0MSFPw42RXwOMRy2VCwD5EeCvvIhS7DfNvSAz
	JkOf9LIdYQ7x3JP89tHrd2Tu/Nz53/+i/PzJpBi3rccEzyrHL2x8edOWcYUIpaWJPEeE/4Xp1pQ
	GkA==
X-Google-Smtp-Source: AGHT+IHkeXMTMo11jEJZVLK3x/LUPbuFY0r5OfLvnPbsUo0+TD2woe9SeAhjFOGiRZt6wf97J57l2VuRNJw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:1008:b0:dc6:e884:2342 with SMTP id
 w8-20020a056902100800b00dc6e8842342mr25280ybt.5.1708544536561; Wed, 21 Feb
 2024 11:42:16 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:49 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-37-surenb@google.com>
Subject: [PATCH v4 36/36] memprofiling: Documentation
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

Provide documentation for memory allocation profiling.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/mm/allocation-profiling.rst | 86 +++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/mm/allocation-profiling.rst

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
new file mode 100644
index 000000000000..2bcbd9e51fe4
--- /dev/null
+++ b/Documentation/mm/allocation-profiling.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+MEMORY ALLOCATION PROFILING
+===========================
+
+Low overhead (suitable for production) accounting of all memory allocations,
+tracked by file and line number.
+
+Usage:
+kconfig options:
+ - CONFIG_MEM_ALLOC_PROFILING
+ - CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+ - CONFIG_MEM_ALLOC_PROFILING_DEBUG
+   adds warnings for allocations that weren't accounted because of a
+   missing annotation
+
+Boot parameter:
+  sysctl.vm.mem_profiling=1
+
+sysctl:
+  /proc/sys/vm/mem_profiling
+
+Runtime info:
+  /proc/allocinfo
+
+Example output:
+  root@moria-kvm:~# sort -g /proc/allocinfo|tail|numfmt --to=iec
+        2.8M    22648 fs/kernfs/dir.c:615 func:__kernfs_new_node
+        3.8M      953 mm/memory.c:4214 func:alloc_anon_folio
+        4.0M     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] func:ctagmod_start
+        4.1M        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct_alloc_hashtable
+        6.0M     1532 mm/filemap.c:1919 func:__filemap_get_folio
+        8.8M     2785 kernel/fork.c:307 func:alloc_thread_stack_node
+         13M      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
+         14M     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
+         15M     3656 mm/readahead.c:247 func:page_cache_ra_unbounded
+         55M     4887 mm/slub.c:2259 func:alloc_slab_page
+        122M    31168 mm/page_ext.c:270 func:alloc_page_ext
+===================
+Theory of operation
+===================
+
+Memory allocation profiling builds off of code tagging, which is a library for
+declaring static structs (that typcially describe a file and line number in
+some way, hence code tagging) and then finding and operating on them at runtime
+- i.e. iterating over them to print them in debugfs/procfs.
+
+To add accounting for an allocation call, we replace it with a macro
+invocation, alloc_hooks(), that
+ - declares a code tag
+ - stashes a pointer to it in task_struct
+ - calls the real allocation function
+ - and finally, restores the task_struct alloc tag pointer to its previous value.
+
+This allows for alloc_hooks() calls to be nested, with the most recent one
+taking effect. This is important for allocations internal to the mm/ code that
+do not properly belong to the outer allocation context and should be counted
+separately: for example, slab object extension vectors, or when the slab
+allocates pages from the page allocator.
+
+Thus, proper usage requires determining which function in an allocation call
+stack should be tagged. There are many helper functions that essentially wrap
+e.g. kmalloc() and do a little more work, then are called in multiple places;
+we'll generally want the accounting to happen in the callers of these helpers,
+not in the helpers themselves.
+
+To fix up a given helper, for example foo(), do the following:
+ - switch its allocation call to the _noprof() version, e.g. kmalloc_noprof()
+ - rename it to foo_noprof()
+ - define a macro version of foo() like so:
+   #define foo(...) alloc_hooks(foo_noprof(__VA_ARGS__))
+
+It's also possible to stash a pointer to an alloc tag in your own data structures.
+
+Do this when you're implementing a generic data structure that does allocations
+"on behalf of" some other code - for example, the rhashtable code. This way,
+instead of seeing a large line in /proc/allocinfo for rhashtable.c, we can
+break it out by rhashtable type.
+
+To do so:
+ - Hook your data structure's init function, like any other allocation function
+ - Within your init function, use the convenience macro alloc_tag_record() to
+   record alloc tag in your data structure.
+ - Then, use the following form for your allocations:
+   alloc_hooks_tag(ht->your_saved_tag, kmalloc_noprof(...))
-- 
2.44.0.rc0.258.g7320e95886-goog


