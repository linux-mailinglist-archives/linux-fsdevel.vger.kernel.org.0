Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD2E78DAD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbjH3ShQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244327AbjH3M6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:58:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E76194
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0bae4da38so6247045ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693400272; x=1694005072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=likGmWzdcl79JyC0G273JC8fCg1Z1MuweBHmHeu5k34=;
        b=Ff+7Y1SRwwlAHeDnqTlv4FjDGlid7oBt2NqKoj7YgCeRiMZLdZWmnHVF0a0MEgrhzm
         z18CNFlUF+D3HMsi8f9EpufmKyPcapSQaR96OfPKapuDvtRM0Xkz8wPxr80S251EiksE
         WlIZp2NNwIphwQHxJ5etCxp2/LlkA8CFpULltM4XvXkaMcXXaeoUfw21dtRB0MtYpuq6
         p7DNcA8gXF8do43AWiK989vsfyT04mfqrknCXr8c9Dt23gSZ7GPTnTYJIr9j1OpIu4Vo
         2+7oR9NlMezOmbnP2nfC2JOmYC6uMr3CMfHygP9Gv1jL0RtykQTJ+aWG14A30wdXWzWl
         0IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400272; x=1694005072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=likGmWzdcl79JyC0G273JC8fCg1Z1MuweBHmHeu5k34=;
        b=BtYqBHCPqSEayrdKMBuTUjXeRFnEH7f2VcgbC7S92Eg58xqdrB6LkZy5qAZ68AVmon
         ZH7FcceOS/dK1xMQHYhj9wySnqWkpujZr6drh7ghZZUt+8Orfsjejfg4OVl9Vns8rJHX
         bf6ubXwP02q67xfgvQcIa8c2uqsa7bw2HQdBwRLI+0Bf/tMFvndif/2kgvqqWgYbH2wk
         HVMvYxpH7h2vdjJD+A5EKlgHjJpW8eN/xn5OEgpqtNI7PGbiombaQq8i4bRITY+j2dQT
         Uuim/PWzhJxQrIK7VPypipba0V7ZfjZVWiQt5dwgmQ58OBELBO9TzGFI79L0N4WLIXeX
         ql0g==
X-Gm-Message-State: AOJu0YwLCPaXnRDcnUvTF0hKzFcfeFg4brBy/kwlrl1t6KcZ7NvpxfJK
        DO+L5X9au6Dm9XVf894oBK4NGA==
X-Google-Smtp-Source: AGHT+IHEZW1hekFijghmb4eDJa5CJeFIwOgrvu16t1pBzdglsm2NfGWuHdAFed9GN5ly19C8PHDQDQ==
X-Received: by 2002:a17:903:228f:b0:1bc:4415:3c1 with SMTP id b15-20020a170903228f00b001bc441503c1mr8693507plh.7.1693400272035;
        Wed, 30 Aug 2023 05:57:52 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b001bbd8cf6b57sm11023265plb.230.2023.08.30.05.57.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Aug 2023 05:57:51 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 5/6] maple_tree: Update check_forking() and bench_forking()
Date:   Wed, 30 Aug 2023 20:56:53 +0800
Message-Id: <20230830125654.21257-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Updated check_forking() and bench_forking() to use __mt_dup() to
duplicate maple tree. Also increased the number of VMAs, because the
new way is faster.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c | 61 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 0ec0c6a7c0b5..72fba7cce148 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1837,36 +1837,37 @@ static noinline void __init check_forking(struct maple_tree *mt)
 {
 
 	struct maple_tree newmt;
-	int i, nr_entries = 134;
+	int i, nr_entries = 300, ret;
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
+	mas_lock(&mas);
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
+	int i, nr_entries = 300, nr_fork = 80000, ret;
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
+		mas_lock(&mas);
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

