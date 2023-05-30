Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66D7171B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 01:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjE3X3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 19:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjE3X3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 19:29:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C75102;
        Tue, 30 May 2023 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BSR4qq8aCJWAXG1SGHud/O/d8RMI3POVcQHNCrs2Ev8=; b=p7iuDQk6eHZ9s0VNn/i6O9mIAO
        OGe9d2b6sbQrFGXETIoCpjdPBwJMaPXfQzJj3my9di58/QzCn+Ip9TuIOETbcIY7ityxIqhHxHzHZ
        wx164Nh2q8u7KNdo/b2XPdkA2K+e9RudDIxMw6V7uvoZdJ2u7xd5FE5mGqrv50BmCzzUgKQ6+9sBk
        W8YlvEJCYxhkNNZHfrwIJmZRdqB48bId5uYltfQXknMa8wSuz8Ah9MIFt+zmn3AuRdNSbBPEM5Tpo
        MnEEi1PKsrdaUapQ4iv5cFBXIeRmCPkK3UzA6UDvightLuboqqCM1jYbBRBYqXMkHPvO8gCh58oSn
        RNGR+BtQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q48mB-00FTrk-0r;
        Tue, 30 May 2023 23:29:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, dhowells@redhat.com,
        jarkko@kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, j.granados@samsung.com, brauner@kernel.org
Cc:     ebiederm@xmission.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/2] sysctl: move umh sysctl registration to its own file
Date:   Tue, 30 May 2023 16:29:13 -0700
Message-Id: <20230530232914.3689712-2-mcgrof@kernel.org>
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

Move the umh sysctl registration to its own file, the array is
already there. We do this to remove the clutter out of kernel/sysctl.c
to avoid merge conflicts.

This also lets the sysctls not be built at all now when CONFIG_SYSCTL
is not enabled.

This has a small penalty of 23 bytes but soon we'll be removing
all the empty entries on sysctl arrays so just do this cleanup
now:

./scripts/bloat-o-meter vmlinux.base vmlinux.1
add/remove: 2/0 grow/shrink: 0/1 up/down: 49/-26 (23)
Function                                     old     new   delta
init_umh_sysctls                               -      33     +33
__pfx_init_umh_sysctls                         -      16     +16
sysctl_init_bases                            111      85     -26
Total: Before=21256914, After=21256937, chg +0.00%

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/umh.h |  2 --
 kernel/sysctl.c     |  1 -
 kernel/umh.c        | 11 ++++++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index 5d1f6129b847..daa6a7048c11 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -42,8 +42,6 @@ call_usermodehelper_setup(const char *path, char **argv, char **envp,
 extern int
 call_usermodehelper_exec(struct subprocess_info *info, int wait);
 
-extern struct ctl_table usermodehelper_table[];
-
 enum umh_disable_depth {
 	UMH_ENABLED = 0,
 	UMH_FREEZING,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 241b817c0240..caf4a91522a1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2322,7 +2322,6 @@ static struct ctl_table vm_table[] = {
 int __init sysctl_init_bases(void)
 {
 	register_sysctl_init("kernel", kern_table);
-	register_sysctl_init("kernel/usermodehelper", usermodehelper_table);
 #ifdef CONFIG_KEYS
 	register_sysctl_init("kernel/keys", key_sysctls);
 #endif
diff --git a/kernel/umh.c b/kernel/umh.c
index 60aa9e764a38..41088c5c39fd 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -544,7 +544,8 @@ static int proc_cap_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-struct ctl_table usermodehelper_table[] = {
+#if defined(CONFIG_SYSCTL)
+static struct ctl_table usermodehelper_table[] = {
 	{
 		.procname	= "bset",
 		.data		= &usermodehelper_bset,
@@ -561,3 +562,11 @@ struct ctl_table usermodehelper_table[] = {
 	},
 	{ }
 };
+
+static int __init init_umh_sysctls(void)
+{
+	register_sysctl_init("kernel/usermodehelper", usermodehelper_table);
+	return 0;
+}
+early_initcall(init_umh_sysctls);
+#endif /* CONFIG_SYSCTL */
-- 
2.39.2

