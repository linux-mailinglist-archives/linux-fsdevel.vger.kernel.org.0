Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945EC4C29E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 11:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiBXKxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 05:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBXKxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:53:22 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A46025A309
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 02:52:49 -0800 (PST)
X-QQ-mid: bizesmtp65t1645699962tdppbp8q
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 24 Feb 2022 18:52:36 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000000A0000000
X-QQ-FEAT: 7Gl6eWfU3FdKi7DnbZ3aKHWjBK09CDQUfvDd54bptslqQEG65PXsVM6E3V3jj
        e1l/ULvZpzPgawo7gH9/AQ/jr1erLr4fodONw5y+XN0SWUiug7bvgWZYD9wyHuUrwRDyGpz
        9+lsNGM9Z197Mgvru3A4ekDlmrS49OTDsPvpvy7pYYu0I2YDY+X/3kADqFY6NNmki9EicYT
        vqbAEXy2zCoMgp52xqoChVHSNQn1bxBK7zRkzMQlpEhgC5qUZoESUJMc0z2ywjoYi66opWj
        rGgPn3Ob1rMCTO2B2qzJpkpBUcitmLzAD7yl/flx7jQY5vOx3iO1S5lUgcsHRkkSNyinYwG
        7aHZKWpoTxm66Ap9HVi+FOk8aH96c4NOjPlW7jq
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     guoren@kernel.org, nickhu@andestech.com, green.hu@gmail.com,
        deanbo422@gmail.com, ebiggers@kernel.org, tytso@mit.edu,
        wad@chromium.org, john.johansen@canonical.com, jmorris@namei.org,
        serge@hallyn.com, linux-csky@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v2] fs/proc: Optimize arrays defined by struct ctl_path
Date:   Thu, 24 Feb 2022 18:52:34 +0800
Message-Id: <20220224105234.19379-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, arrays defined by struct ctl_path is terminated
with an empty one. For example, when we actually only register
one ctl_path, we've gone from 8 bytes to 16 bytes.

So, I use ARRAY_SIZE() as a boundary condition to optimize it.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 arch/csky/abiv1/alignment.c |  8 ++++----
 arch/nds32/mm/alignment.c   |  8 ++++----
 fs/proc/proc_sysctl.c       | 10 ++++++----
 fs/verity/signature.c       |  5 +++--
 include/linux/sysctl.h      |  6 +++---
 kernel/pid_namespace.c      |  5 +++--
 kernel/seccomp.c            |  7 ++++---
 security/apparmor/lsm.c     |  5 +++--
 security/loadpin/loadpin.c  |  5 +++--
 security/yama/yama_lsm.c    |  7 ++++---
 10 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index 2df115d0e210..b9290a252d84 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -340,14 +340,14 @@ static struct ctl_table sysctl_table[2] = {
 	{}
 };
 
-static struct ctl_path sysctl_path[2] = {
-	{.procname = "csky"},
-	{}
+static struct ctl_path sysctl_path[1] = {
+	{.procname = "csky"}
 };
+#define SYSCTL_PATH_NUM ARRAY_SIZE(sysctl_path)
 
 static int __init csky_alignment_init(void)
 {
-	register_sysctl_paths(sysctl_path, sysctl_table);
+	register_sysctl_paths(sysctl_path, SYSCTL_PATH_NUM, sysctl_table);
 	return 0;
 }
 
diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
index 1eb7ded6992b..7145a006fc92 100644
--- a/arch/nds32/mm/alignment.c
+++ b/arch/nds32/mm/alignment.c
@@ -560,17 +560,17 @@ static struct ctl_table nds32_sysctl_table[2] = {
 	{}
 };
 
-static struct ctl_path nds32_path[2] = {
-	{.procname = "nds32"},
-	{}
+static struct ctl_path nds32_path[1] = {
+	{.procname = "nds32"}
 };
+#define NDS32_PATH_NUM ARRAY_SIZE(nds32_path)
 
 /*
  * Initialize nds32 alignment-correction interface
  */
 static int __init nds32_sysctl_init(void)
 {
-	register_sysctl_paths(nds32_path, nds32_sysctl_table);
+	register_sysctl_paths(nds32_path, NDS32_PATH_NUM, nds32_sysctl_table);
 	return 0;
 }
 
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9ecd5c87e8dd..7774dc159e60 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1601,20 +1601,21 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
  */
 struct ctl_table_header *__register_sysctl_paths(
 	struct ctl_table_set *set,
-	const struct ctl_path *path, struct ctl_table *table)
+	const struct ctl_path *path, int ctl_path_num, struct ctl_table *table)
 {
 	struct ctl_table *ctl_table_arg = table;
 	int nr_subheaders = count_subheaders(table);
 	struct ctl_table_header *header = NULL, **subheaders, **subheader;
 	const struct ctl_path *component;
 	char *new_path, *pos;
+	int i;
 
 	pos = new_path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!new_path)
 		return NULL;
 
 	pos[0] = '\0';
-	for (component = path; component->procname; component++) {
+	for (component = path, i = 0; component->procname && i < ctl_path_num; component++, i++) {
 		pos = append_path(new_path, pos, component->procname);
 		if (!pos)
 			goto out;
@@ -1671,10 +1672,11 @@ struct ctl_table_header *__register_sysctl_paths(
  * See __register_sysctl_paths for more details.
  */
 struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
+						int ctl_path_num,
 						struct ctl_table *table)
 {
 	return __register_sysctl_paths(&sysctl_table_root.default_set,
-					path, table);
+					path, ctl_path_num, table);
 }
 EXPORT_SYMBOL(register_sysctl_paths);
 
@@ -1691,7 +1693,7 @@ struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
 {
 	static const struct ctl_path null_path[] = { {} };
 
-	return register_sysctl_paths(null_path, table);
+	return register_sysctl_paths(null_path, ARRAY_SIZE(null_path), table);
 }
 EXPORT_SYMBOL(register_sysctl_table);
 
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 143a530a8008..e243e8c1cc38 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -92,9 +92,9 @@ static struct ctl_table_header *fsverity_sysctl_header;
 
 static const struct ctl_path fsverity_sysctl_path[] = {
 	{ .procname = "fs", },
-	{ .procname = "verity", },
-	{ }
+	{ .procname = "verity", }
 };
+#define FSVERITY_SYSCTL_PATH_NUM ARRAY_SIZE(fsverity_sysctl_path)
 
 static struct ctl_table fsverity_sysctl_table[] = {
 	{
@@ -112,6 +112,7 @@ static struct ctl_table fsverity_sysctl_table[] = {
 static int __init fsverity_sysctl_init(void)
 {
 	fsverity_sysctl_header = register_sysctl_paths(fsverity_sysctl_path,
+						       FSVERITY_SYSCTL_PATH_NUM,
 						       fsverity_sysctl_table);
 	if (!fsverity_sysctl_header) {
 		pr_err("sysctl registration failed!\n");
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 889c995d8a08..f4e3ccf2dbd3 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -221,11 +221,11 @@ struct ctl_table_header *__register_sysctl_table(
 	const char *path, struct ctl_table *table);
 struct ctl_table_header *__register_sysctl_paths(
 	struct ctl_table_set *set,
-	const struct ctl_path *path, struct ctl_table *table);
+	const struct ctl_path *path, int ctl_path_num, struct ctl_table *table);
 struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
 struct ctl_table_header *register_sysctl_table(struct ctl_table * table);
 struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
-						struct ctl_table *table);
+						int ctl_path_num, struct ctl_table *table);
 
 void unregister_sysctl_table(struct ctl_table_header * table);
 
@@ -272,7 +272,7 @@ static inline struct ctl_table_header *register_sysctl_mount_point(const char *p
 }
 
 static inline struct ctl_table_header *register_sysctl_paths(
-			const struct ctl_path *path, struct ctl_table *table)
+			const struct ctl_path *path, int ctl_path_num, struct ctl_table *table)
 {
 	return NULL;
 }
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a46a3723bc66..ad9be671333b 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -294,7 +294,8 @@ static struct ctl_table pid_ns_ctl_table[] = {
 	},
 	{ }
 };
-static struct ctl_path kern_path[] = { { .procname = "kernel", }, { } };
+static struct ctl_path kern_path[] = { { .procname = "kernel", } };
+#define KERN_PATH_NUM ARRAY_SIZE(kern_path)
 #endif	/* CONFIG_CHECKPOINT_RESTORE */
 
 int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
@@ -453,7 +454,7 @@ static __init int pid_namespaces_init(void)
 	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	register_sysctl_paths(kern_path, pid_ns_ctl_table);
+	register_sysctl_paths(kern_path, KERN_PATH_NUM, pid_ns_ctl_table);
 #endif
 	return 0;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index db10e73d06e0..9488d6831cf5 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2333,9 +2333,9 @@ static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
 
 static struct ctl_path seccomp_sysctl_path[] = {
 	{ .procname = "kernel", },
-	{ .procname = "seccomp", },
-	{ }
+	{ .procname = "seccomp", }
 };
+#define SECCOMP_SYSCTL_PATH_NUM ARRAY_SIZE(seccomp_sysctl_path)
 
 static struct ctl_table seccomp_sysctl_table[] = {
 	{
@@ -2357,7 +2357,8 @@ static int __init seccomp_sysctl_init(void)
 {
 	struct ctl_table_header *hdr;
 
-	hdr = register_sysctl_paths(seccomp_sysctl_path, seccomp_sysctl_table);
+	hdr = register_sysctl_paths(seccomp_sysctl_path, SECCOMP_SYSCTL_PATH_NUM,
+				    seccomp_sysctl_table);
 	if (!hdr)
 		pr_warn("sysctl registration failed\n");
 	else
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4f0eecb67dde..b8cfe202db65 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1729,9 +1729,9 @@ static int apparmor_dointvec(struct ctl_table *table, int write,
 }
 
 static struct ctl_path apparmor_sysctl_path[] = {
-	{ .procname = "kernel", },
-	{ }
+	{ .procname = "kernel", }
 };
+#define APPARMOR_SYSCTL_PATH_NUM ARRAY_SIZE(apparmor_sysctl_path)
 
 static struct ctl_table apparmor_sysctl_table[] = {
 	{
@@ -1747,6 +1747,7 @@ static struct ctl_table apparmor_sysctl_table[] = {
 static int __init apparmor_init_sysctl(void)
 {
 	return register_sysctl_paths(apparmor_sysctl_path,
+				     APPARMOR_SYSCTL_PATH_NUM,
 				     apparmor_sysctl_table) ? 0 : -ENOMEM;
 }
 #else
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..7728f061f8c0 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -48,9 +48,9 @@ static DEFINE_SPINLOCK(pinned_root_spinlock);
 
 static struct ctl_path loadpin_sysctl_path[] = {
 	{ .procname = "kernel", },
-	{ .procname = "loadpin", },
-	{ }
+	{ .procname = "loadpin", }
 };
+#define LOADPIN_SYSCTL_PATH_NUM ARRAY_SIZE(loadpin_sysctl_path)
 
 static struct ctl_table loadpin_sysctl_table[] = {
 	{
@@ -91,6 +91,7 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
 
 	if (!ro) {
 		if (!register_sysctl_paths(loadpin_sysctl_path,
+					   LOADPIN_SYSCTL_PATH_NUM,
 					   loadpin_sysctl_table))
 			pr_notice("sysctl registration failed!\n");
 		else
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..d2460b963fd9 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -449,9 +449,9 @@ static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
 static struct ctl_path yama_sysctl_path[] = {
 	{ .procname = "kernel", },
-	{ .procname = "yama", },
-	{ }
+	{ .procname = "yama", }
 };
+#define YAMA_SYSCTL_PATH_NUM ARRAY_SIZE(yama_sysctl_path)
 
 static struct ctl_table yama_sysctl_table[] = {
 	{
@@ -467,7 +467,8 @@ static struct ctl_table yama_sysctl_table[] = {
 };
 static void __init yama_init_sysctl(void)
 {
-	if (!register_sysctl_paths(yama_sysctl_path, yama_sysctl_table))
+	if (!register_sysctl_paths(yama_sysctl_path, YAMA_SYSCTL_PATH_NUM,
+				   yama_sysctl_table))
 		panic("Yama: sysctl registration failed.\n");
 }
 #else
-- 
2.20.1



