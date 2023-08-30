Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3936578DB14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjH3Si2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbjH3M6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:58:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69E185
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc63ef9959so41955195ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693400266; x=1694005066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nBO87JODOc2vxfEDdYbEmz2onn6zs2zxUKCCOpJdk0=;
        b=ZrmpUQzKwPGg4ygFxX3/Sd2+3b7Vd3uIX43oPFzWowCcl8lQXHkDPyQ5MNNs9T2YgJ
         /TZE6L4kvi8wF8DOsbcfDENR/8yx76nsIUbdA1gtbC+LPgaADGUa2F+/M/V+ffta8BfE
         Hg+RPW6+dih/PTd9oIrKn9e9LuAGIKCGOAPzmRMBkMN9HC8hq7d+DW8jhn/Yh1NkOKYR
         yptavTQhuM7k0tqhR2Lb8YCALxsCo4KiXKdVk0s52iNLpB3GQeswP6oS0YjqP1Pq42Sr
         vyMLCjQuYnkU208i0gqNzhw9hNN5s2qBc2qJqwN3aJ9Gz6qZW+O/mjLDmb+6nvhKjtd2
         K7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400266; x=1694005066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nBO87JODOc2vxfEDdYbEmz2onn6zs2zxUKCCOpJdk0=;
        b=RWwFsYuits65rgcKxM7AfyJxQpWQMjTsyrnI4HEOMFMNj9KKwBZgGZb3un3S3+qIIa
         Km/k0wtk5s0pOLX0iX7nl3P7VOL2RtQl3KzrDHeNtB6NDrU1L4nwUuzSD95ppFjI+Vcw
         c4K2wCJXAqS7xynWrICd2a8o30mGGdQuiaoF60dDDmYQfhSOs0wyhuZA1tWu8J6ORckh
         DReQ7dkM/mcABJ8z8NGHz4qpEvx0EtG4aQqOCnT8stCJsAstYPqaopRmS4dBhQiG0d0z
         aKXi0WBNge3pgSNRcTWRQdJLV7fqQqFTzEY+RmNo6ZLh7U3h1/+8eiBJ5oljqg88bfsM
         pl3Q==
X-Gm-Message-State: AOJu0YxuY+IIKUYO/gBerczM3pQLAs2LKNcWKP1x9glJdEF0/DMuNSuV
        NFx6bAP9wdyoBByEySNKrfceew==
X-Google-Smtp-Source: AGHT+IGx3EmrDiZTTIfJpOeK4JOagyqHaEyqo+fM7q0DuUUO076LoLX7sVQJgZT4uYkTB/BqJlAAiQ==
X-Received: by 2002:a17:903:268a:b0:1b8:7e53:704 with SMTP id jf10-20020a170903268a00b001b87e530704mr1893310plb.27.1693400265985;
        Wed, 30 Aug 2023 05:57:45 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b001bbd8cf6b57sm11023265plb.230.2023.08.30.05.57.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Aug 2023 05:57:45 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 4/6] maple_tree: Skip other tests when BENCH is enabled
Date:   Wed, 30 Aug 2023 20:56:52 +0800
Message-Id: <20230830125654.21257-5-zhangpeng.00@bytedance.com>
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

Skip other tests when BENCH is enabled so that performance can be
measured in user space.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c            | 8 ++++----
 tools/testing/radix-tree/maple.c | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 0674aebd4423..0ec0c6a7c0b5 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3514,10 +3514,6 @@ static int __init maple_tree_seed(void)
 
 	pr_info("\nTEST STARTING\n\n");
 
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_root_expand(&tree);
-	mtree_destroy(&tree);
-
 #if defined(BENCH_SLOT_STORE)
 #define BENCH
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
@@ -3575,6 +3571,10 @@ static int __init maple_tree_seed(void)
 	goto skip;
 #endif
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_root_expand(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
 	mtree_destroy(&tree);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 38455916331e..57f153b8bf4b 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36282,7 +36282,9 @@ void farmer_tests(void)
 
 void maple_tree_tests(void)
 {
+#if !defined(BENCH)
 	farmer_tests();
+#endif
 	maple_tree_seed();
 	maple_tree_harvest();
 }
-- 
2.20.1

