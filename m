Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F57057A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 21:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjEPTmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 15:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjEPTmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 15:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540BC76AF;
        Tue, 16 May 2023 12:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD426340C;
        Tue, 16 May 2023 19:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CDFC433D2;
        Tue, 16 May 2023 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266139;
        bh=5lvCP4bPSOrgTZv7kSqqa1Lk3TnQEcnuBUwkjntOlBw=;
        h=From:To:Cc:Subject:Date:From;
        b=sGA1G0BIX4VM0STtkY1VwQj3jrY3tVJHulInpr9gDGJUF3jOd3lNFrcIrzwM8ugtV
         RLRTSLD+ZcLMVVbOOvjSh2l+22yPCuJtPOID4cM1qUW0n06BMh5n9BCV8HYAqiTQDW
         wxN81EThZVxFIn9XWcHduKuVkBLdLH2mJkdJ9WjIPTcxgLhz2rEhP8Nw01l2iPsX20
         V/qDU83w4Pbp9H+7FZPij4usjaOYHce36PuZL/5ZPOpPeT5t7idjpHkPbLE7ZcNKI8
         G6UkDWbj5r97z28djwWHPSVAFXd+cKnmrbiSizfpZTJ/YzEGVu/1ko4r/2jn2wDfNk
         kAkjc2JXeL9ig==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] radix-tree: move declarations to header
Date:   Tue, 16 May 2023 21:41:54 +0200
Message-Id: <20230516194212.548910-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The xarray.c file contains the only call to radix_tree_node_rcu_free(),
and it comes with its own extern declaration for it. This means the
function definition causes a missing-prototype warning:

lib/radix-tree.c:288:6: error: no previous prototype for 'radix_tree_node_rcu_free' [-Werror=missing-prototypes]

Instead, move the declaration for this function to a new header that
can be included by both, and do the same for the radix_tree_node_cachep
variable that has the same underlying problem but does not cause
a warning with gcc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/radix-tree.c | 2 ++
 lib/radix-tree.h | 8 ++++++++
 lib/xarray.c     | 6 ++----
 3 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 lib/radix-tree.h

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 049ba132f7ef..1a31065b2036 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -27,6 +27,8 @@
 #include <linux/string.h>
 #include <linux/xarray.h>
 
+#include "radix-tree.h"
+
 /*
  * Radix tree node cache.
  */
diff --git a/lib/radix-tree.h b/lib/radix-tree.h
new file mode 100644
index 000000000000..40d5c03e2b09
--- /dev/null
+++ b/lib/radix-tree.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* radix-tree helpers that are only shared with xarray */
+
+struct kmem_cache;
+struct rcu_head;
+
+extern struct kmem_cache *radix_tree_node_cachep;
+extern void radix_tree_node_rcu_free(struct rcu_head *head);
diff --git a/lib/xarray.c b/lib/xarray.c
index ea9ce1f0b386..2071a3718f4e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/xarray.h>
 
+#include "radix-tree.h"
+
 /*
  * Coding conventions in this file:
  *
@@ -247,10 +249,6 @@ void *xas_load(struct xa_state *xas)
 }
 EXPORT_SYMBOL_GPL(xas_load);
 
-/* Move the radix tree node cache here */
-extern struct kmem_cache *radix_tree_node_cachep;
-extern void radix_tree_node_rcu_free(struct rcu_head *head);
-
 #define XA_RCU_FREE	((struct xarray *)1)
 
 static void xa_node_free(struct xa_node *node)
-- 
2.39.2

