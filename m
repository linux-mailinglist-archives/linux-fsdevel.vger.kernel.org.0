Return-Path: <linux-fsdevel+bounces-15015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F32885EB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687B61C22C06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269A1474C6;
	Thu, 21 Mar 2024 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J87yunjO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079714601C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039113; cv=none; b=RmHhDnpXMwygf0Z9jUyjAg4JTtZfLvmxLNqtLekfqGchfgoGkmRJw3x8fBI/TrPpMUbN4YYqVacbInUiPUIfFIJJsc1eWqi7jNMKKqqdjpKWQ7DVI6ZIBaO/u5e0GoK6ALnCfhF6S45ADeLvwO+vJV9Rb50erHwn7hMzP6UfR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039113; c=relaxed/simple;
	bh=BFhSOgRWZw49w/nNVhmrLSuZba9C6QEOmpxWTod6ib8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zu5JwR1dTuECXMaLSL9ab5hGsd2fvm//T66ANz3BxZHhp34bWQMnABJolxS/iiYm2g0Kn/7u7TSL/Nu//f+DdSHVq0ljxnfAbWvsr6Ls1ZRS0NTG0i6uJ3hC93vSLqvtSj9u76QI3bEI6ElswRENC+OjIvfEiJrELcZO9W1lu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J87yunjO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso1820840276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039110; x=1711643910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMtv/wiplx2DxF9seTFx3IcU+R2+PFSDAr6m0+A1ntI=;
        b=J87yunjO28kD8sQDWsH2+886fzZILIU6T5/WoqTovyLEOlsl/gl2THxMnwuCLHdv1E
         QA9Cjcqi5LSZ1ErCecNbw5YzCKY+clXvW5d7zB8W4PKow2AifOIVrsMUOaAlrdvddNTy
         4kw+FmmiirxK33a8sFrtidXj9Y9fPn1IMmBGPAtNSOnHjFKU3mFmx+QBuUfSbfq/CDUq
         Li5TtuVAadBbejEqH8GZlOJjFBJPC/ah4nBW5Fh1B4H9xQ7/D5KKGl3IhZObpsm5m8Vf
         +I5d0SZ76DKFU024pWR9MUhAZWaHLqglyad/yl3sIDGhPFPUeKhUssBY2PlCaekUYQ3V
         AJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039110; x=1711643910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMtv/wiplx2DxF9seTFx3IcU+R2+PFSDAr6m0+A1ntI=;
        b=VbfkBGKHjdgLhCfEweyhqFoHuWDZUza4ISLpBFL4if841cIs7oOykOIiCwoydPqbmF
         QjDiLeHbFGAL+xIbHhfT80NtwTuV71gVEWN9A0Q65CkeCSHpVL3x0WjQT8hCj6eEVVCP
         vZnonUL3pa6NndVAjV1ny6vTBRNw1U31I0VzLSrJW8+1ciTIeN7YFc5/cWc3IqMeSGeO
         jQ0LcD+I8Lyc90eQ9wSOiUnF7TbdpoDrfsTtBvD6aIGFd4FbzbPxmC0BZebSvPmvShzU
         ZXMAq3jq4WjyjPIYEwbcKisrCApnLJnRNyzjNz7y0TWPPLsVnEVPNaL0ZYab+OVoiobz
         FrAA==
X-Forwarded-Encrypted: i=1; AJvYcCVPWqOrV1OvU+l4XGckslvPn747uv4hhlAbDh7vAXnwQv/1AVqKV/XiP57UfDGBfY4W04PZHIFC/H9l2uJBRJ4V/c+d6eiOVclHBD5zGg==
X-Gm-Message-State: AOJu0YzVIguuupZBA/WZkrZGJ41EqRFdKhVHaKzu9tzfWf2M8u1du5J7
	3QkqRTZg4lZIeXEOv1UQhlvuoYBe86TDJzoALFMgxGbnqlUssDcSl5j9+FyVOsmm7T9jooxgFgH
	v+Q==
X-Google-Smtp-Source: AGHT+IHubMkzttSDdMzbBJ1mYbEtkJMz1sywK2vk2BxZuZG66cHkzs6E2Eyy/Ht6uVFkEMl2Xl2C/1q/RI8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:240e:b0:dc2:5273:53f9 with SMTP id
 dr14-20020a056902240e00b00dc2527353f9mr1211362ybb.1.1711039110014; Thu, 21
 Mar 2024 09:38:30 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:59 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-38-surenb@google.com>
Subject: [PATCH v6 37/37] memprofiling: Documentation
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

From: Kent Overstreet <kent.overstreet@linux.dev>

Provide documentation for memory allocation profiling.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/mm/allocation-profiling.rst | 100 ++++++++++++++++++++++
 Documentation/mm/index.rst                |   1 +
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/mm/allocation-profiling.rst

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
new file mode 100644
index 000000000000..d3b733b41ae6
--- /dev/null
+++ b/Documentation/mm/allocation-profiling.rst
@@ -0,0 +1,100 @@
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
+- CONFIG_MEM_ALLOC_PROFILING
+
+- CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+
+- CONFIG_MEM_ALLOC_PROFILING_DEBUG
+  adds warnings for allocations that weren't accounted because of a
+  missing annotation
+
+Boot parameter:
+  sysctl.vm.mem_profiling=0|1|never
+
+  When set to "never", memory allocation profiling overhead is minimized and it
+  cannot be enabled at runtime (sysctl becomes read-only).
+  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y, default value is "1".
+  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n, default value is "never".
+
+sysctl:
+  /proc/sys/vm/mem_profiling
+
+Runtime info:
+  /proc/allocinfo
+
+Example output::
+
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
+
+===================
+Theory of operation
+===================
+
+Memory allocation profiling builds off of code tagging, which is a library for
+declaring static structs (that typically describe a file and line number in
+some way, hence code tagging) and then finding and operating on them at runtime,
+- i.e. iterating over them to print them in debugfs/procfs.
+
+To add accounting for an allocation call, we replace it with a macro
+invocation, alloc_hooks(), that
+- declares a code tag
+- stashes a pointer to it in task_struct
+- calls the real allocation function
+- and finally, restores the task_struct alloc tag pointer to its previous value.
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
+- switch its allocation call to the _noprof() version, e.g. kmalloc_noprof()
+
+- rename it to foo_noprof()
+
+- define a macro version of foo() like so:
+
+  #define foo(...) alloc_hooks(foo_noprof(__VA_ARGS__))
+
+It's also possible to stash a pointer to an alloc tag in your own data structures.
+
+Do this when you're implementing a generic data structure that does allocations
+"on behalf of" some other code - for example, the rhashtable code. This way,
+instead of seeing a large line in /proc/allocinfo for rhashtable.c, we can
+break it out by rhashtable type.
+
+To do so:
+- Hook your data structure's init function, like any other allocation function.
+
+- Within your init function, use the convenience macro alloc_tag_record() to
+  record alloc tag in your data structure.
+
+- Then, use the following form for your allocations:
+  alloc_hooks_tag(ht->your_saved_tag, kmalloc_noprof(...))
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 31d2ac306438..48b9b559ca7b 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -26,6 +26,7 @@ see the :doc:`admin guide <../admin-guide/mm/index>`.
    page_cache
    shmfs
    oom
+   allocation-profiling
 
 Legacy Documentation
 ====================
-- 
2.44.0.291.gc1ea87d7ee-goog


