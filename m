Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1868B7171AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 01:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjE3X3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 19:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjE3X3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 19:29:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D3B2;
        Tue, 30 May 2023 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2DkCxac7yJ7TTpJrbvC4aJ9GEUlIf19GJMG2RCNYbhA=; b=jeHbujSluGut688450mAUhQVVb
        tyqrByE3iKY/irqUq/PHyN/8gduxh2e1lxNVGDev/KOiX/FxEsmiwhsiXnU9Tln7zxOdOQSt6Aeup
        DRltTHZbg0wtsi6wwis/abNrnQPjSPNqg/jyYXnAE25Nyt4LzdQQqTFQSg7E4OD+JZuorF/xQIQIF
        z9NToC59ws913amKocI0bm7nXxKh2UA6Fn296mrCrKj0UcORwXFDgJrxNDXQq6YXephZX7qbke12C
        s+UqI+nv7LhTxOVvSA8tB1MMjyq4FafNY6DmeR4bA/LIr4lQ770MRMwanHUkoC+k+cYesjVIsDWrU
        wF3kb9oA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q48mB-00FTrm-0z;
        Tue, 30 May 2023 23:29:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, dhowells@redhat.com,
        jarkko@kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, j.granados@samsung.com, brauner@kernel.org
Cc:     ebiederm@xmission.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] sysctl: move security keys sysctl registration to its own file
Date:   Tue, 30 May 2023 16:29:14 -0700
Message-Id: <20230530232914.3689712-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230530232914.3689712-1-mcgrof@kernel.org>
References: <20230530232914.3689712-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The security keys sysctls are already declared on its own file,
just move the sysctl registration to its own file to help avoid
merge conflicts on sysctls.c, and help with clearing up sysctl.c
further.

This creates a small penalty of 23 bytes:

./scripts/bloat-o-meter vmlinux.1 vmlinux.2
add/remove: 2/0 grow/shrink: 0/1 up/down: 49/-26 (23)
Function                                     old     new   delta
init_security_keys_sysctls                     -      33     +33
__pfx_init_security_keys_sysctls               -      16     +16
sysctl_init_bases                             85      59     -26
Total: Before=21256937, After=21256960, chg +0.00%

But soon we'll be saving tons of bytes anyway, as we modify the
sysctl registrations to use ARRAY_SIZE and so we get rid of all the
empty array elements so let's just clean this up now.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/key.h    | 3 ---
 kernel/sysctl.c        | 4 ----
 security/keys/sysctl.c | 7 +++++++
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 8dc7f7c3088b..938d7ecfb495 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -490,9 +490,6 @@ do {									\
 	rcu_assign_pointer((KEY)->payload.rcu_data0, (PAYLOAD));	\
 } while (0)
 
-#ifdef CONFIG_SYSCTL
-extern struct ctl_table key_sysctls[];
-#endif
 /*
  * the userspace interface
  */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index caf4a91522a1..48046932d573 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2322,10 +2322,6 @@ static struct ctl_table vm_table[] = {
 int __init sysctl_init_bases(void)
 {
 	register_sysctl_init("kernel", kern_table);
-#ifdef CONFIG_KEYS
-	register_sysctl_init("kernel/keys", key_sysctls);
-#endif
-
 	register_sysctl_init("vm", vm_table);
 
 	return 0;
diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
index b46b651b3c4c..b72b82bb20c6 100644
--- a/security/keys/sysctl.c
+++ b/security/keys/sysctl.c
@@ -68,3 +68,10 @@ struct ctl_table key_sysctls[] = {
 #endif
 	{ }
 };
+
+static int __init init_security_keys_sysctls(void)
+{
+	register_sysctl_init("kernel/keys", key_sysctls);
+	return 0;
+}
+early_initcall(init_security_keys_sysctls);
-- 
2.39.2

