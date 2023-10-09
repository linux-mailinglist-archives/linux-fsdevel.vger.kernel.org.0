Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A02C7BD645
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345937AbjJIJF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 05:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbjJIJFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:05:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F1135
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 02:04:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso3869929b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696842276; x=1697447076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v1OZEFv5O146V21vBTm5TeKaYSuxLzybT1UdN8aEPI=;
        b=I0rKt1N8inTZu5TielcQ78yFa9SEsOe2OWu6araY0ZfraOJaaAmedCcPJ8CWWhUcOu
         Ygd9cQxVAbwLZnYO77L+LgGYmKXUlwE+jMyrWzSNhFhoqpkqpIJl0IiZxZvHJJnxWdL8
         ToFaUFJFTYkdhUSVbsduwioY7qIDG6WbV3Fk1wf/A2+oOj2T3+Ac4hgEHx83vAZ7zab7
         X6xM4X5WHfED8xfQPwVijbEKTlH3yxu4fTwO6IDvQ8q7Tb4f86MixB9iYSxftu7ZiwAA
         AxS0PdJ41fSeqy1PHlJoF6VcqupLSIOCkn9FQgXR7AkNldBOfOT2nm6be2kTtb2DnRM7
         WHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842276; x=1697447076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v1OZEFv5O146V21vBTm5TeKaYSuxLzybT1UdN8aEPI=;
        b=DTf5ysqjIjIyydTNxe1047+VqvwXj5jngdJy3+lMWu0pL9g6anajSUWGPnrt/yHreN
         +Cex7y6ID0eG8CLA5kuFYnjdYrKDX9CUo0M3Wht+qsFe6t9NSWcpreXya5jm8ccBT8Jc
         CepJzztrEsfGsm6Q9lbngWkwlcb5zGmQvT+f4yHbGSj7a+0QdyrE2HKC1GiTpXc483q3
         Jey7rSdU37f5Q7arVIse/VPnSmlMgebx9fEOkvYllyocEuDt6QQwWtwiZkDrOP+Bd6sR
         xqcaSfKAVD/nElwmMlqpm13mffHqT3f6DvyAA4T+Q2wW/IIX0x/Z4/LdK8R/9TcBb/wN
         OiFg==
X-Gm-Message-State: AOJu0YxfT8vhYIvvisoNkVoYRY0c/QzG74d8AdeWlHF4rGJoo87ztn9r
        Xlc1/h0Pij9Rs9BpznTPjeQEmg==
X-Google-Smtp-Source: AGHT+IGW3goxheixUnKrkWUN2cRvqCUUmgS+X/SOAABQUeOP6LJPmPjlNnrYOpaxH5nwIYLNUCgF5Q==
X-Received: by 2002:a05:6a00:158c:b0:690:b7a1:ac51 with SMTP id u12-20020a056a00158c00b00690b7a1ac51mr19018763pfk.31.1696842275718;
        Mon, 09 Oct 2023 02:04:35 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm5884847pfb.198.2023.10.09.02.04.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Oct 2023 02:04:35 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 08/10] maple_tree: Update check_forking() and bench_forking()
Date:   Mon,  9 Oct 2023 17:03:18 +0800
Message-Id: <20231009090320.64565-9-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Updated check_forking() and bench_forking() to use __mt_dup() to
duplicate maple tree.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c | 61 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 27d424fad797..bcd07c220a13 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1837,36 +1837,37 @@ static noinline void __init check_forking(struct maple_tree *mt)
 {
 
 	struct maple_tree newmt;
-	int i, nr_entries = 134;
+	int i, nr_entries = 134, ret;
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
-	MA_STATE(newmas, mt, 0, 0);
+	MA_STATE(newmas, &newmt, 0, 0);
+
+	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
 
 	for (i = 0; i <= nr_entries; i++)
 		mtree_store_range(mt, i*10, i*10 + 5,
 				  xa_mk_value(i), GFP_KERNEL);
 
+
 	mt_set_non_kernel(99999);
-	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
-	newmas.tree = &newmt;
-	mas_reset(&newmas);
-	mas_reset(&mas);
 	mas_lock(&newmas);
-	mas.index = 0;
-	mas.last = 0;
-	if (mas_expected_entries(&newmas, nr_entries)) {
+	mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
+
+	ret = __mt_dup(mt, &newmt, GFP_NOWAIT | __GFP_NOWARN);
+	if (ret) {
 		pr_err("OOM!");
 		BUG_ON(1);
 	}
-	rcu_read_lock();
-	mas_for_each(&mas, val, ULONG_MAX) {
-		newmas.index = mas.index;
-		newmas.last = mas.last;
+
+	mas_set(&newmas, 0);
+	mas_for_each(&newmas, val, ULONG_MAX) {
 		mas_store(&newmas, val);
 	}
-	rcu_read_unlock();
-	mas_destroy(&newmas);
+
+	mas_unlock(&mas);
 	mas_unlock(&newmas);
+
+	mas_destroy(&newmas);
 	mt_validate(&newmt);
 	mt_set_non_kernel(0);
 	mtree_destroy(&newmt);
@@ -1974,12 +1975,11 @@ static noinline void __init check_mas_store_gfp(struct maple_tree *mt)
 #if defined(BENCH_FORK)
 static noinline void __init bench_forking(struct maple_tree *mt)
 {
-
 	struct maple_tree newmt;
-	int i, nr_entries = 134, nr_fork = 80000;
+	int i, nr_entries = 134, nr_fork = 80000, ret;
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
-	MA_STATE(newmas, mt, 0, 0);
+	MA_STATE(newmas, &newmt, 0, 0);
 
 	for (i = 0; i <= nr_entries; i++)
 		mtree_store_range(mt, i*10, i*10 + 5,
@@ -1988,25 +1988,24 @@ static noinline void __init bench_forking(struct maple_tree *mt)
 	for (i = 0; i < nr_fork; i++) {
 		mt_set_non_kernel(99999);
 		mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
-		newmas.tree = &newmt;
-		mas_reset(&newmas);
-		mas_reset(&mas);
-		mas.index = 0;
-		mas.last = 0;
-		rcu_read_lock();
+
 		mas_lock(&newmas);
-		if (mas_expected_entries(&newmas, nr_entries)) {
-			printk("OOM!");
+		mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
+		ret = __mt_dup(mt, &newmt, GFP_NOWAIT | __GFP_NOWARN);
+		if (ret) {
+			pr_err("OOM!");
 			BUG_ON(1);
 		}
-		mas_for_each(&mas, val, ULONG_MAX) {
-			newmas.index = mas.index;
-			newmas.last = mas.last;
+
+		mas_set(&newmas, 0);
+		mas_for_each(&newmas, val, ULONG_MAX) {
 			mas_store(&newmas, val);
 		}
-		mas_destroy(&newmas);
+
+		mas_unlock(&mas);
 		mas_unlock(&newmas);
-		rcu_read_unlock();
+
+		mas_destroy(&newmas);
 		mt_validate(&newmt);
 		mt_set_non_kernel(0);
 		mtree_destroy(&newmt);
-- 
2.20.1

