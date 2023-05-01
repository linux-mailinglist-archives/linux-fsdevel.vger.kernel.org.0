Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1456F34CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjEARDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjEARCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:02:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0105C4220
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:57:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55a3146ed47so15573137b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960197; x=1685552197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mzPQystPbLbDwPdw2fPo41K7qknlkieEKK3sweddW8=;
        b=48U8jHG63mdA66+jSc2MsTTE/SQi8BR+RKY6JNGvzt9XyZfx935vfOLln6IV1D1nZA
         TDOiQ/WUR049cZ5YJ1Q2SXSzODz7LrWrQUYaviS+GqGgkaK3yK5eLgyzf9e3cLjtYX0E
         QEA8ptoQ0G50fmCmay29a1/AGKziq1anSqyI04k35PIYMGlvV6wz4iKeKGJ75o0JVkmO
         ON7F5nilmKInR+kNfyJ2/HvMFyxBUo4zG20TTbLKq7fKcUY3NShJQ1fHpbVtH1cQdhj8
         PGEM3ZzK108E7+nu3T246tg/tKyPHMfi0CFtYYsesaQA8cqlaVTRPDBW+c2GnGCMueBG
         1wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960197; x=1685552197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mzPQystPbLbDwPdw2fPo41K7qknlkieEKK3sweddW8=;
        b=C3AkI0l2P+vsvxBxYxvn2NlUJfJHjnDE/3VNkm+M6zoO2o2owr52005gN95jGqu2Kq
         0MUg8NpaMFNCXQ8I4NlEVRbmFb7sZ7p954q5gw2BnSUpU+mAiRKXVnefnG4k1idGQfv9
         qvviAXEkvH66qgYwaA70ZTjse4Or1Lz7och91ojkoq7Saw5B0vAQ1yr0SarPLWwYMRWZ
         yPNTwvxNjq58AK0NCP0/Ia8GJNbFV3zCnb+2I8l7NAdJYxe6UJkWj4bUIsTOxinOxvF5
         4HdBTnU663QSWc/wVF1m9Jxv4HVFi+rmDEv/B9f0/UyLuXuCnPMW9f1lYHvErO8I8nuE
         wUpw==
X-Gm-Message-State: AC+VfDz9s2wG4sVr66yVwX0DoSfQBqhTyzfGmjmZyrV3LLvPXbgus5S9
        zEITAOHaBGtpV0dPKBgQsK94BAJgfbM=
X-Google-Smtp-Source: ACHHUZ4jj2W0kDCYmm99zoZd05S+xWh4GtcVfBuyUeKMJ0WYF9RUn/+Qut27GKgsUVS6rbo/+wwQvYcbMjY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a81:e902:0:b0:541:61aa:9e60 with SMTP id
 d2-20020a81e902000000b0054161aa9e60mr9069879ywm.6.1682960197340; Mon, 01 May
 2023 09:56:37 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:49 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-40-surenb@google.com>
Subject: [PATCH 39/40] codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark
 failed slab_ext allocations
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
 mm/slab_common.c           | 27 +++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c7f21b15b540..3eb8975c1462 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -356,8 +356,10 @@ enum page_memcg_data_flags {
 #endif /* CONFIG_MEMCG */
 
 enum objext_flags {
+	/* slabobj_ext vector failed to allocate */
+	OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
 	/* the next bit after the last actual flag */
-	__NR_OBJEXTS_FLAGS  = __FIRST_OBJEXT_FLAG,
+	__NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
 };
 
 #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 89265f825c43..5b7e096b70a5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -217,21 +217,44 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 {
 	unsigned int objects = objs_per_slab(s, slab);
 	unsigned long obj_exts;
-	void *vec;
+	struct slabobj_ext *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/* Prevent recursive extension vector allocation */
 	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
-	if (!vec)
+	if (!vec) {
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+		if (new_slab) {
+			/* Mark vectors which failed to allocate */
+			slab->obj_exts = OBJEXTS_ALLOC_FAIL;
+#ifdef CONFIG_MEMCG
+			slab->obj_exts |= MEMCG_DATA_OBJEXTS;
+#endif
+		}
+#endif
 		return -ENOMEM;
+	}
 
 	obj_exts = (unsigned long)vec;
 #ifdef CONFIG_MEMCG
 	obj_exts |= MEMCG_DATA_OBJEXTS;
 #endif
 	if (new_slab) {
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+		/*
+		 * If vector previously failed to allocate then we have live
+		 * objects with no tag reference. Mark all references in this
+		 * vector as empty to avoid warnings later on.
+		 */
+		if (slab->obj_exts & OBJEXTS_ALLOC_FAIL) {
+			unsigned int i;
+
+			for (i = 0; i < objects; i++)
+				set_codetag_empty(&vec[i].ref);
+		}
+#endif
 		/*
 		 * If the slab is brand new and nobody can yet access its
 		 * obj_exts, no synchronization is required and obj_exts can
-- 
2.40.1.495.gc816e09b53d-goog

