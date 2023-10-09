Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C857BD63B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbjJIJFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 05:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345732AbjJIJEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:04:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F911A
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 02:04:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so3096414b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696842269; x=1697447069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnskIBrvSZEYEyApxx0F6Uk1TEGei79sZvSWDi4Yrxw=;
        b=EOOXF6+WmJ4nbCNN47RG75CZ/Zoa26nQoJa9aAjFw74VVXF5CyxclEVCoOjul1szQo
         np+gYpoXQZsOpcQQIUZgdGXDP2uR+dF2E6VLO98ZgPZd9q86Yx/5fYb3xeGMUOowtl3y
         KPPQRjYTNU1K09PTho+jl+E8mmKrmh7rLqbPofLsU9tpzXSGC//ZOGjou/H8OI8oVA+8
         brRqTiMZjkMsNha0l0O8QQtL0mw44g8PRiCYmybAqwNN3bdY0JkiekSbZfHRGFbb1/n9
         xNHXvAbgft/YEiBjfokkLbNrGtB3nEeydy8utUv6hp7G4n0TfhNEx48tuf+UMN9nRiVZ
         98wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842269; x=1697447069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnskIBrvSZEYEyApxx0F6Uk1TEGei79sZvSWDi4Yrxw=;
        b=lu6l0b/Fv8CPF3Nrd5SR3i4S/8/Fqsfz9jriMasYykIty7hP+rBZyx0NEHL+IyKsp3
         RI0inyKvZqixPtyFqfXnqhHe7y6co2VbIE2BmO3QgTnghUA7VjKt27VOt0kzsdk5Ymed
         DSpsgmneQMft0BybNpPElISLYqeeZWO31VRpIncyBRTWrmpVi/qmq8sk3YoeJirCw7M4
         HTbt/TT/gN+RI+W3jZ1YuwVqOw9+ihQ7upRA7fr+3V8BjDA028ldtS91VhP4xeF/ASAQ
         fEhc+V0OIaRYZh7rDaho9pBGYcWP7TNCXY/wMbxdBbQJJLnxngeqRzTH3U5gRstVxttj
         ZQ1A==
X-Gm-Message-State: AOJu0Yz6bAdKSgAKGeW+HSb9vnXw/GLc9cQuLxhqr8HTlZmJFQbQI7qQ
        V573PhYxISJjr2ZbSv2MnuzKvA==
X-Google-Smtp-Source: AGHT+IET1qb2peUsO8cEnYgLpRkD93NRxlManliBfrRzGPRkgabOCFSqkeE2y8LdqsuC0g9EI5V17w==
X-Received: by 2002:a05:6a21:1a6:b0:16b:afc2:3b69 with SMTP id le38-20020a056a2101a600b0016bafc23b69mr8157702pzb.36.1696842269350;
        Mon, 09 Oct 2023 02:04:29 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm5884847pfb.198.2023.10.09.02.04.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Oct 2023 02:04:29 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 07/10] maple_tree: Skip other tests when BENCH is enabled
Date:   Mon,  9 Oct 2023 17:03:17 +0800
Message-Id: <20231009090320.64565-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 06959165e2f9..27d424fad797 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3572,10 +3572,6 @@ static int __init maple_tree_seed(void)
 
 	pr_info("\nTEST STARTING\n\n");
 
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_root_expand(&tree);
-	mtree_destroy(&tree);
-
 #if defined(BENCH_SLOT_STORE)
 #define BENCH
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
@@ -3633,6 +3629,10 @@ static int __init maple_tree_seed(void)
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
index 12b3390e9591..cb5358674521 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36299,7 +36299,9 @@ void farmer_tests(void)
 
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

