Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40ED5AD237
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 14:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbiIEMO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 08:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbiIEMOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:14:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EEC12D10;
        Mon,  5 Sep 2022 05:14:48 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MLnTd5PnRzrSBk;
        Mon,  5 Sep 2022 20:12:53 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 20:14:46 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 5 Sep
 2022 20:14:45 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] kernel/sysctl-test: use SYSCTL_{ZERO/ONE_HUNDRED} instead of i_{zero/one_hundred}
Date:   Mon, 5 Sep 2022 20:48:56 +0800
Message-ID: <20220905124856.2233973-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is better to use SYSCTL_ZERO and SYSCTL_ONE_HUNDRED instead of &i_zero
and &i_one_hundred, and then we can remove these two local variable.

No functional change.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 kernel/sysctl-test.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 664ded05dd7a..6ef887c19c48 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -9,9 +9,6 @@
 #define KUNIT_PROC_READ 0
 #define KUNIT_PROC_WRITE 1
 
-static int i_zero;
-static int i_one_hundred = 100;
-
 /*
  * Test that proc_dointvec will not try to use a NULL .data field even when the
  * length is non-zero.
@@ -29,8 +26,8 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	/*
 	 * proc_dointvec expects a buffer in user space, so we allocate one. We
@@ -79,8 +76,8 @@ static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
 		.maxlen		= 0,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
@@ -122,8 +119,8 @@ static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
@@ -156,8 +153,8 @@ static void sysctl_test_api_dointvec_table_read_but_position_set(
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
@@ -191,8 +188,8 @@ static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	size_t len = 4;
 	loff_t pos = 0;
@@ -222,8 +219,8 @@ static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	size_t len = 5;
 	loff_t pos = 0;
@@ -251,8 +248,8 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	char input[] = "9";
 	size_t len = sizeof(input) - 1;
@@ -281,8 +278,8 @@ static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	char input[] = "-9";
 	size_t len = sizeof(input) - 1;
@@ -313,8 +310,8 @@ static void sysctl_test_api_dointvec_write_single_less_int_min(
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
@@ -351,8 +348,8 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
-- 
2.25.1

