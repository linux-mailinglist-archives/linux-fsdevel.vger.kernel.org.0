Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7326F346C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjEAQ76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjEAQ7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:59:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242AC26B0
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:56:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b922aa3725fso5385669276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960160; x=1685552160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JQAU/dBFDp2j3prOKpx9pu61B2aRzHMn5ijo1mj0wk=;
        b=Nr4QXyj/etzJlAh8i4e3XnDFrHrok+4KAhChzrGdGYpNpzqnTzNz+b7TDzIFPvjVWJ
         9m6bX+drGU9A6fH4AYp0HUvbrb0fCoSPBmCg7BeIb7knPz8EfEfG9cPbzcBJ5VX+RXOe
         xKxhA1OiVlh84AEwzHBh+cMUHvzUPF37NpWH9RACZgYBnn9nhrwQ+ZtD6LOD5aF3vQAg
         h9QGbAMavYpJls9fxf3kDm4J6+Qn0mT0BuRWWAvY6omxOHY3anv02SbqbukFuexGdvmI
         uLtak6s/1IGom0RtuY8qFrrhQXG4Ym0F7I61Qiqk5+0EJAXYPW/dDKZJd/GArGchifG6
         ytrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960160; x=1685552160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JQAU/dBFDp2j3prOKpx9pu61B2aRzHMn5ijo1mj0wk=;
        b=dW471ReACAC2mcWx2xaz91Egrb7goDJVrevXUgzWEZsROwzQLJqjnYvUvUA2J98cjz
         tu0f0aomBAxX6iddIIhePOi/z/R7z6pHoQXz/FW+i4S7EMsVxl9yyg+guPz3dlDg1U8h
         bUq5HZjZUXTyQeHoX3Gt8Tp/1M0r9WU69qUi1tnV65477vBdxxdfne10Vo/FCJL5bAgK
         nZOlB0sBLRwtWzV/+8ArWi3jIUhK1BITYdvRhP/pj+kF+I+YQyda17nCQEeOkW1cPG+h
         ejYpLuUWRBikWU3Ru5XmEDTpzY3BHz840Eba2qSwL28YvUawHzu1MYm6X/WqR6Y4dLnq
         WaTQ==
X-Gm-Message-State: AC+VfDxGBkNdO2dq0KdtBP8v1T2L8UtI5Z/jA/ccWIZfxsSMo+ttRtjP
        eyh/Osyh+x/rWjZSXzG6HN4A8hVqF8A=
X-Google-Smtp-Source: ACHHUZ5flxShenE/t9NPL/moLDuNx9TkwM/Lf/8wW54V2Eq3VJ/wRhfgfjc0frmw2aZZoQxo3iYMAN5xHBU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:2484:0:b0:b95:e649:34b6 with SMTP id
 k126-20020a252484000000b00b95e64934b6mr8454589ybk.1.1682960160542; Mon, 01
 May 2023 09:56:00 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:33 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-24-surenb@google.com>
Subject: [PATCH 23/40] lib: add codetag reference into slabobj_ext
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
index 5e2da63c525f..c7f21b15b540 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1626,7 +1626,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
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
index d3aa5ee0bf0d..4157c2251b07 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -968,6 +968,7 @@ config MEM_ALLOC_PROFILING
 	select CODE_TAGGING
 	select LAZY_PERCPU_COUNTER
 	select PAGE_EXTENSION
+	select SLAB_OBJ_EXT
 	help
 	  Track allocation source code and record total allocation size
 	  initiated at that code location. The mechanism can be used to track
diff --git a/mm/slab.h b/mm/slab.h
index bec202bdcfb8..f953e7c81e98 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -418,6 +418,10 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
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
2.40.1.495.gc816e09b53d-goog

