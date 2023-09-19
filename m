Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1E7A5777
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 04:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjISCqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 22:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjISCqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:46:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56CA103
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 19:46:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c45c45efeeso1833195ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695091604; x=1695696404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVaCKafr7rXOhFLTAtlQmk5QekExsnPlB/mflEUNsHY=;
        b=KyMPIhRFlszHdMchGeQtq5dqNsfidbq1/VwDFAmJ//H1NALl3WfMvsc0P70vuQ382r
         7TQiR79EAKa3i8BvQnJwc3lmfju+jEGDN8MF/LLhkCKW0brtHmEstyU80o2Y/mlv8w4y
         TNOXqJzqPmQWH+bVLKHO6xC8yLjVh2NR+/cYER6lKdZWscS7vyG4DRSEpWnsbU8DhxWj
         D+LNCVahCZsfDeBp9gLuY+TpmzGvJyRKC4AMdGiVFaFx3bOUw6JwRS8+IvaT3T0D1Zop
         A2TtwbrH/pky16PpNYgCBDgr5ru/enCIoEwrWzQ8XL2q0Zf38WIZ2cTSghinuvC24SJw
         rpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695091604; x=1695696404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVaCKafr7rXOhFLTAtlQmk5QekExsnPlB/mflEUNsHY=;
        b=dRTk26gY+izhRlEe0YILViDwgLXY3irkkZBAiJzO/09P2RPs2UKB4aoEs6DnA5OmBE
         kWQpQ/grPlb/oECtebQNoWRdVg+EIzROoywAONwDGHNdSXlz+74oL97FMpCxkdZ41y4U
         rATHOYBfclcR/DxPVojjio5DwOA6SrCIRDM8vrxJDcHPIfGZAiLrrskPe7KJ4dXz+K69
         +LSe79J27zPVuq6E1N0rThEFKNWD6NlR737H3qnbDDBjiDPLCpnEnMlSkzKB4mRF0app
         OIRp/OBESAwlYxd1/TPG9Ik2dKwtNwEUY3yXsgkRgJZKqpfrWgmMa1xVpcf6Gf8fGGHG
         Gzfg==
X-Gm-Message-State: AOJu0YyIUzSB+V6iDE2jmPy08oRgU5VVlM8aUoNqY5v2/nuWWliHifN4
        0kmIXSCELHVPIdZlVKYNwI5rLg==
X-Google-Smtp-Source: AGHT+IG5mbJOtnUV7RTj73z+udKG4UFeAJTSFAjJzR+Q8pglWJacUFjOvahYn+5uh9/MdY3h+cfFWA==
X-Received: by 2002:a17:902:e744:b0:1b8:aded:524c with SMTP id p4-20020a170902e74400b001b8aded524cmr12897364plf.1.1695091604093;
        Mon, 18 Sep 2023 19:46:44 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902d18100b001b7f40a8959sm8884198plb.76.2023.09.18.19.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 19:46:43 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: shrinker: some cleanup
Date:   Tue, 19 Sep 2023 10:46:07 +0800
Message-Id: <20230919024607.65463-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-2-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
Hi Andrew, this is a cleanup patch for [PATCH v6 01/45], there will be a
small conflict with [PATCH v6 41/45].

 include/linux/shrinker.h | 14 ++++++++------
 mm/internal.h            | 17 ++++++++++++++---
 mm/shrinker.c            | 20 ++++++++++++--------
 mm/shrinker_debug.c      | 16 ----------------
 4 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 3f3fd9974ce5..f4a5249f00b2 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -88,16 +88,18 @@ struct shrinker {
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
-/* Flags */
-#define SHRINKER_REGISTERED	(1 << 0)
-#define SHRINKER_NUMA_AWARE	(1 << 1)
-#define SHRINKER_MEMCG_AWARE	(1 << 2)
+/* Internal flags */
+#define SHRINKER_REGISTERED	BIT(0)
+#define SHRINKER_ALLOCATED	BIT(1)
+
+/* Flags for users to use */
+#define SHRINKER_NUMA_AWARE	BIT(2)
+#define SHRINKER_MEMCG_AWARE	BIT(3)
 /*
  * It just makes sense when the shrinker is also MEMCG_AWARE for now,
  * non-MEMCG_AWARE shrinker should not have this flag set.
  */
-#define SHRINKER_NONSLAB	(1 << 3)
-#define SHRINKER_ALLOCATED	(1 << 4)
+#define SHRINKER_NONSLAB	BIT(4)
 
 struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
 void shrinker_register(struct shrinker *shrinker);
diff --git a/mm/internal.h b/mm/internal.h
index b9a116dce28e..0f418a11c7a8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1161,10 +1161,21 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
 #ifdef CONFIG_SHRINKER_DEBUG
+static inline int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
+					      const char *fmt, va_list ap)
+{
+	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
+
+	return shrinker->name ? 0 : -ENOMEM;
+}
+
+static inline void shrinker_debugfs_name_free(struct shrinker *shrinker)
+{
+	kfree_const(shrinker->name);
+	shrinker->name = NULL;
+}
+
 extern int shrinker_debugfs_add(struct shrinker *shrinker);
-extern int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
-				       const char *fmt, va_list ap);
-extern void shrinker_debugfs_name_free(struct shrinker *shrinker);
 extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 					      int *debugfs_id);
 extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 201211a67827..d1032a4d5684 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -572,18 +572,23 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...)
 
 	if (flags & SHRINKER_MEMCG_AWARE) {
 		err = prealloc_memcg_shrinker(shrinker);
-		if (err == -ENOSYS)
+		if (err == -ENOSYS) {
+			/* Memcg is not supported, fallback to non-memcg-aware shrinker. */
 			shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
-		else if (err == 0)
-			goto done;
-		else
+			goto non_memcg;
+		}
+
+		if (err)
 			goto err_flags;
+
+		return shrinker;
 	}
 
+non_memcg:
 	/*
 	 * The nr_deferred is available on per memcg level for memcg aware
 	 * shrinkers, so only allocate nr_deferred in the following cases:
-	 *  - non memcg aware shrinkers
+	 *  - non-memcg-aware shrinkers
 	 *  - !CONFIG_MEMCG
 	 *  - memcg is disabled by kernel command line
 	 */
@@ -595,7 +600,6 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...)
 	if (!shrinker->nr_deferred)
 		goto err_flags;
 
-done:
 	return shrinker;
 
 err_flags:
@@ -634,10 +638,10 @@ void shrinker_free(struct shrinker *shrinker)
 		list_del(&shrinker->list);
 		debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
 		shrinker->flags &= ~SHRINKER_REGISTERED;
-	} else {
-		shrinker_debugfs_name_free(shrinker);
 	}
 
+	shrinker_debugfs_name_free(shrinker);
+
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	up_write(&shrinker_rwsem);
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 38452f539f40..24aebe7c24cc 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -193,20 +193,6 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	return 0;
 }
 
-int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const char *fmt,
-				va_list ap)
-{
-	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
-
-	return shrinker->name ? 0 : -ENOMEM;
-}
-
-void shrinker_debugfs_name_free(struct shrinker *shrinker)
-{
-	kfree_const(shrinker->name);
-	shrinker->name = NULL;
-}
-
 int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 {
 	struct dentry *entry;
@@ -255,8 +241,6 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 
 	lockdep_assert_held(&shrinker_rwsem);
 
-	shrinker_debugfs_name_free(shrinker);
-
 	*debugfs_id = entry ? shrinker->debugfs_id : -1;
 	shrinker->debugfs_entry = NULL;
 
-- 
2.30.2

