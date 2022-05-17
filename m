Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9867352A5A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiEQPHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 11:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349657AbiEQPHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 11:07:39 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE513B566
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 08:07:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:c0f6:7ccf:c217:5f21])
        by albert.telenet-ops.be with bizsmtp
        id Xr7a270090nFbBY06r7aqB; Tue, 17 May 2022 17:07:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nqynN-000huY-Qg; Tue, 17 May 2022 17:07:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nqynN-004NOP-CH; Tue, 17 May 2022 17:07:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sysctl: Merge adjacent CONFIG_TREE_RCU blocks
Date:   Tue, 17 May 2022 17:07:31 +0200
Message-Id: <a6931221b532ae7a5cf0eb229ace58acee4f0c1a.1652799977.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two adjacent sysctl entries protected by the same
CONFIG_TREE_RCU config symbol.  Merge them into a single block to
improve readability.

Use the more common "#ifdef" form while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/sysctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 82bcf5e3009fa377..597069da18148f42 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2227,7 +2227,7 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-#if defined(CONFIG_TREE_RCU)
+#ifdef CONFIG_TREE_RCU
 	{
 		.procname	= "panic_on_rcu_stall",
 		.data		= &sysctl_panic_on_rcu_stall,
@@ -2237,8 +2237,6 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-#endif
-#if defined(CONFIG_TREE_RCU)
 	{
 		.procname	= "max_rcu_stall_to_panic",
 		.data		= &sysctl_max_rcu_stall_to_panic,
-- 
2.25.1

