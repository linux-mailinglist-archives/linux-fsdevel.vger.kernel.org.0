Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEED79BF94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjIKUyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbjIKJv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F57CEB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf11a7cf9fso7705845ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425867; x=1695030667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa9xv5O6zRN9YujHabqvlTbDnEkmHba3eF7bPn48dFs=;
        b=Qe6d99qr6Vyx4aTHbFTAzdsIHZ8VyoJo8ThjXX14YL1rcVH4WcohA5YxHSPN4iI63f
         m/PRjsNgfWO47bGRFbRPFNn9KTYLx3RmHjphEdO/pLBB4NVFecwl711+tEebhY8ccGe0
         DR6SzXr1dZV3I3psjX8o8hXL8gTGN/damddGK/lQ6GggJCYB7M1BUTjW/+zo1kaqYX61
         W+j0BCPC3W4di1BwjZ1/xwi8RXtQf/1ZdSB/bRVcqE4eSV1buaiMZssr9kG9Irc9nMCk
         mbAzLxoW7/fT0be1MnDX0a2K4oZlFbJmQssV3IfmhVpIRD/ewR8OH7DmKwwpK8TxRJ5Q
         8qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425867; x=1695030667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa9xv5O6zRN9YujHabqvlTbDnEkmHba3eF7bPn48dFs=;
        b=aTWfO6BsG4vJuDAQiHxa2JlQXdO5k7rno5AcrxuCnDA3AWIKaEtI5h7LUWS/WL/cSG
         66jm9iaGh1V/q4WIXf+x0sYE5ir1c1feakxINrDJSaobyCryp1nh2EvvFJHyxXs8ESDO
         K8kY19hzP2bsi4qqXC0BZZl1o+eO73wg0hYeMmwy/wbKX4E3cLaoFqXRE5FvCVRily1E
         QYt9IcR5Vi3L0w/PmnU2zXFmt37n9C6zHCHAzl+NZF9FtwpR11N2PhldWobZNkQjkT/z
         wRN0MeyhRoAcSAvpwFyz6ym1gAIxPqBEDYljiVtjglBpltotCZifJu2VNul+FRnH0Gzx
         yMhA==
X-Gm-Message-State: AOJu0YzZ31NZMLy4/zGcfq9B2i6qQ4UVP1NbyTNOODlcd8WwkOpX/29y
        t7PLFrpyIu5oTOwkX8dc7xOGPw==
X-Google-Smtp-Source: AGHT+IHGQbme9+SUFaGqtXxW3dpwxnbADbFKKzuXkjeBXh8SM/R1CUkQJ1X6e1o6BdROvLlqkFtmJw==
X-Received: by 2002:a17:902:e5c1:b0:1b3:d8ac:8db3 with SMTP id u1-20020a170902e5c100b001b3d8ac8db3mr11070242plf.6.1694425867096;
        Mon, 11 Sep 2023 02:51:07 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:51:06 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 39/45] mm: shrinker: remove old APIs
Date:   Mon, 11 Sep 2023 17:44:38 +0800
Message-Id: <20230911094444.68966-40-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
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

Now no users are using the old APIs, just remove them.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/shrinker.h |   8 ---
 mm/shrinker.c            | 143 ---------------------------------------
 2 files changed, 151 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 3f3fd9974ce5..025c8070dd86 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -103,14 +103,6 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
 void shrinker_register(struct shrinker *shrinker);
 void shrinker_free(struct shrinker *shrinker);
 
-extern int __printf(2, 3) prealloc_shrinker(struct shrinker *shrinker,
-					    const char *fmt, ...);
-extern void register_shrinker_prepared(struct shrinker *shrinker);
-extern int __printf(2, 3) register_shrinker(struct shrinker *shrinker,
-					    const char *fmt, ...);
-extern void unregister_shrinker(struct shrinker *shrinker);
-extern void free_prealloced_shrinker(struct shrinker *shrinker);
-
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
 						  const char *fmt, ...);
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 201211a67827..d75be41b8a5f 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -651,146 +651,3 @@ void shrinker_free(struct shrinker *shrinker)
 	kfree(shrinker);
 }
 EXPORT_SYMBOL_GPL(shrinker_free);
-
-/*
- * Add a shrinker callback to be called from the vm.
- */
-static int __prealloc_shrinker(struct shrinker *shrinker)
-{
-	unsigned int size;
-	int err;
-
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		err = prealloc_memcg_shrinker(shrinker);
-		if (err != -ENOSYS)
-			return err;
-
-		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
-	}
-
-	size = sizeof(*shrinker->nr_deferred);
-	if (shrinker->flags & SHRINKER_NUMA_AWARE)
-		size *= nr_node_ids;
-
-	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
-	if (!shrinker->nr_deferred)
-		return -ENOMEM;
-
-	return 0;
-}
-
-#ifdef CONFIG_SHRINKER_DEBUG
-int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...)
-{
-	va_list ap;
-	int err;
-
-	va_start(ap, fmt);
-	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
-	va_end(ap);
-	if (!shrinker->name)
-		return -ENOMEM;
-
-	err = __prealloc_shrinker(shrinker);
-	if (err) {
-		kfree_const(shrinker->name);
-		shrinker->name = NULL;
-	}
-
-	return err;
-}
-#else
-int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...)
-{
-	return __prealloc_shrinker(shrinker);
-}
-#endif
-
-void free_prealloced_shrinker(struct shrinker *shrinker)
-{
-#ifdef CONFIG_SHRINKER_DEBUG
-	kfree_const(shrinker->name);
-	shrinker->name = NULL;
-#endif
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		down_write(&shrinker_rwsem);
-		unregister_memcg_shrinker(shrinker);
-		up_write(&shrinker_rwsem);
-		return;
-	}
-
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-}
-
-void register_shrinker_prepared(struct shrinker *shrinker)
-{
-	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
-	shrinker->flags |= SHRINKER_REGISTERED;
-	shrinker_debugfs_add(shrinker);
-	up_write(&shrinker_rwsem);
-}
-
-static int __register_shrinker(struct shrinker *shrinker)
-{
-	int err = __prealloc_shrinker(shrinker);
-
-	if (err)
-		return err;
-	register_shrinker_prepared(shrinker);
-	return 0;
-}
-
-#ifdef CONFIG_SHRINKER_DEBUG
-int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
-{
-	va_list ap;
-	int err;
-
-	va_start(ap, fmt);
-	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
-	va_end(ap);
-	if (!shrinker->name)
-		return -ENOMEM;
-
-	err = __register_shrinker(shrinker);
-	if (err) {
-		kfree_const(shrinker->name);
-		shrinker->name = NULL;
-	}
-	return err;
-}
-#else
-int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
-{
-	return __register_shrinker(shrinker);
-}
-#endif
-EXPORT_SYMBOL(register_shrinker);
-
-/*
- * Remove one
- */
-void unregister_shrinker(struct shrinker *shrinker)
-{
-	struct dentry *debugfs_entry;
-	int debugfs_id;
-
-	if (!(shrinker->flags & SHRINKER_REGISTERED))
-		return;
-
-	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
-	shrinker->flags &= ~SHRINKER_REGISTERED;
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
-	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
-	up_write(&shrinker_rwsem);
-
-	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
-
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-}
-EXPORT_SYMBOL(unregister_shrinker);
-- 
2.30.2

