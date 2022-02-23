Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A205E4C0F85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 10:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiBWJt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 04:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiBWJt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:49:27 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8930685973
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 01:48:56 -0800 (PST)
X-QQ-mid: bizesmtp81t1645609725tgacnsug
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 23 Feb 2022 17:48:38 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00C0000000
X-QQ-FEAT: Ut0pB98mtT/Q74JFXA2I0gDDRkD1CRAorAGPSvE5lod+8gsyxhEWXh+uNX4C9
        ORgYrqohjTAp+dCE3NBe96O/4h/raydPtsVJ06qEtYk5drgYr+1FaKnL/syIydFfTKmslpA
        qWdVTZwnFhHBTEUddFxAGPDdGHzfANgV6i+5C4Snr9BFYM5ZM+nW+5OvcqZ5cSF13zNYCuP
        TQLrLsZM6XGBUqBU7gFGAUkka28pV4OotIIFd2D8zSm8bkwlDKbj0iFx1tWXuC7YOcqxhDb
        hglTKU6WL9pdf2AnzjlQEASRd4m2g3h8PM59uj30z+65+JWpDXH8u0MM5Vgp7aJdcKGIZWc
        b8n427Je/MXL2Cu5Fbyl+2nEsSguQ==
X-QQ-GoodBg: 2
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
Subject: [PATCH] fs/proc: Optimize arrays defined by struct ctl_path
Date:   Wed, 23 Feb 2022 17:48:37 +0800
Message-Id: <20220223094837.20337-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
 fs/proc/proc_sysctl.c       | 12 +++++++-----
 fs/verity/signature.c       |  7 ++++---
 include/linux/sysctl.h      |  6 +++---
 kernel/pid_namespace.c      |  5 +++--
 kernel/seccomp.c            |  7 ++++---
 security/apparmor/lsm.c     |  7 ++++---
 security/loadpin/loadpin.c  |  7 ++++---
 security/yama/yama_lsm.c    |  6 +++---
 10 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index 2df115d0e210..f2fe6a4d2388 100644
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
+#define SYSCTL_PATH_SIZE ARRAY_SIZE(sysctl_path)
 
 static int __init csky_alignment_init(void)
 {
-	register_sysctl_paths(sysctl_path, sysctl_table);
+	register_sysctl_paths(sysctl_path, sysctl_table, SYSCTL_PATH_SIZE);
 	return 0;
 }
 
diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
index 1eb7ded6992b..ee073f6b5822 100644
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
+#define NDS32_PATH_SIZE ARRAY_SIZE(nds32_path)
 
 /*
  * Initialize nds32 alignment-correction interface
  */
 static int __init nds32_sysctl_init(void)
 {
-	register_sysctl_paths(nds32_path, nds32_sysctl_table);
+	register_sysctl_paths(nds32_path, nds32_sysctl_table, NDS32_PATH_SIZE);
 	return 0;
 }
 
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7d9cfc730bd4..d6f6d9d5d3f8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1552,20 +1552,21 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
  */
 struct ctl_table_header *__register_sysctl_paths(
 	struct ctl_table_set *set,
-	const struct ctl_path *path, struct ctl_table *table)
+	const struct ctl_path *path, struct ctl_table *table, int table_size)
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
+	for (component = path, i = 0; component->procname && i < table_size; component++, i++) {
 		pos = append_path(new_path, pos, component->procname);
 		if (!pos)
 			goto out;
@@ -1622,10 +1623,11 @@ struct ctl_table_header *__register_sysctl_paths(
  * See __register_sysctl_paths for more details.
  */
 struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
-						struct ctl_table *table)
+						struct ctl_table *table,
+						int table_size)
 {
 	return __register_sysctl_paths(&sysctl_table_root.default_set,
-					path, table);
+					path, table, table_size);
 }
 EXPORT_SYMBOL(register_sysctl_paths);
 
@@ -1642,7 +1644,7 @@ struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
 {
 	static const struct ctl_path null_path[] = { {} };
 
-	return register_sysctl_paths(null_path, table);
+	return register_sysctl_paths(null_path, table, ARRAY_SIZE(null_path));
 }
 EXPORT_SYMBOL(register_sysctl_table);
 
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 143a530a8008..e04be57da6ab 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -92,9 +92,9 @@ static struct ctl_table_header *fsverity_sysctl_header;
 
 static const struct ctl_path fsverity_sysctl_path[] = {
 	{ .procname = "fs", },
-	{ .procname = "verity", },
-	{ }
+	{ .procname = "verity", }
 };
+#define FSVERITY_SYSCTL_PATH_SIZE ARRAY_SIZE(fsverity_sysctl_path)
 
 static struct ctl_table fsverity_sysctl_table[] = {
 	{
@@ -112,7 +112,8 @@ static struct ctl_table fsverity_sysctl_table[] = {
 static int __init fsverity_sysctl_init(void)
 {
 	fsverity_sysctl_header = register_sysctl_paths(fsverity_sysctl_path,
-						       fsverity_sysctl_table);
+						       fsverity_sysctl_table,
+						       FSVERITY_SYSCTL_PATH_SIZE);
 	if (!fsverity_sysctl_header) {
 		pr_err("sysctl registration failed!\n");
 		return -ENOMEM;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6353d6db69b2..781874ed9179 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -220,11 +220,11 @@ struct ctl_table_header *__register_sysctl_table(
 	const char *path, struct ctl_table *table);
 struct ctl_table_header *__register_sysctl_paths(
 	struct ctl_table_set *set,
-	const struct ctl_path *path, struct ctl_table *table);
+	const struct ctl_path *path, struct ctl_table *table, int table_size);
 struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
 struct ctl_table_header *register_sysctl_table(struct ctl_table * table);
 struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
-						struct ctl_table *table);
+						struct ctl_table *table, int table_size);
 
 void unregister_sysctl_table(struct ctl_table_header * table);
 
@@ -271,7 +271,7 @@ static inline struct ctl_table_header *register_sysctl_mount_point(const char *p
 }
 
 static inline struct ctl_table_header *register_sysctl_paths(
-			const struct ctl_path *path, struct ctl_table *table)
+			const struct ctl_path *path, struct ctl_table *table, int table_size)
 {
 	return NULL;
 }
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a46a3723bc66..18a1a3bb37a0 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -294,7 +294,8 @@ static struct ctl_table pid_ns_ctl_table[] = {
 	},
 	{ }
 };
-static struct ctl_path kern_path[] = { { .procname = "kernel", }, { } };
+static struct ctl_path kern_path[] = { { .procname = "kernel", } };
+#define KERN_PATH_SIZE ARRAY_SIZE(kern_path)
 #endif	/* CONFIG_CHECKPOINT_RESTORE */
 
 int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
@@ -453,7 +454,7 @@ static __init int pid_namespaces_init(void)
 	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	register_sysctl_paths(kern_path, pid_ns_ctl_table);
+	register_sysctl_paths(kern_path, pid_ns_ctl_table, KERN_PATH_SIZE);
 #endif
 	return 0;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index db10e73d06e0..d4759cdb0335 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2333,9 +2333,9 @@ static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
 
 static struct ctl_path seccomp_sysctl_path[] = {
 	{ .procname = "kernel", },
-	{ .procname = "seccomp", },
-	{ }
+	{ .procname = "seccomp", }
 };
+#define SECCOMP_SYSCTL_PATH_SIZE ARRAY_SIZE(seccomp_sysctl_path)
 
 static struct ctl_table seccomp_sysctl_table[] = {
 	{
@@ -2357,7 +2357,8 @@ static int __init seccomp_sysctl_init(void)
 {
 	struct ctl_table_header *hdr;
 
-	hdr = register_sysctl_paths(seccomp_sysctl_path, seccomp_sysctl_table);
+	hdr = register_sysctl_paths(seccomp_sysctl_path, seccomp_sysctl_table,
+				    SECCOMP_SYSCTL_PATH_SIZE);
 	if (!hdr)
 		pr_warn("sysctl registration failed\n");
 	else
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4f0eecb67dde..09a0461db6b1 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1729,9 +1729,9 @@ static int apparmor_dointvec(struct ctl_table *table, int write,
 }
 
 static struct ctl_path apparmor_sysctl_path[] = {
-	{ .procname = "kernel", },
-	{ }
+	{ .procname = "kernel", }
 };
+#define APPARMOR_SYSCTL_PATH_SIZE ARRAY_SIZE(apparmor_sysctl_path)
 
 static struct ctl_table apparmor_sysctl_table[] = {
 	{
@@ -1747,7 +1747,8 @@ static struct ctl_table apparmor_sysctl_table[] = {
 static int __init apparmor_init_sysctl(void)
 {
 	return register_sysctl_paths(apparmor_sysctl_path,
-				     apparmor_sysctl_table) ? 0 : -ENOMEM;
+				     apparmor_sysctl_table,
+				     APPARMOR_SYSCTL_PATH_SIZE) ? 0 : -ENOMEM;
 }
 #else
 static inline int apparmor_init_sysctl(void)
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..45e0b8952a1d 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -48,9 +48,9 @@ static DEFINE_SPINLOCK(pinned_root_spinlock);
 
 static struct ctl_path loadpin_sysctl_path[] = {
 	{ .procname = "kernel", },
-	{ .procname = "loadpin", },
-	{ }
+	{ .procname = "loadpin", }
 };
+#define LOADPIN_SYSCTL_PATH_SIZE ARRAY_SIZE(loadpin_sysctl_path)
 
 static struct ctl_table loadpin_sysctl_table[] = {
 	{
@@ -91,7 +91,8 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
 
 	if (!ro) {
 		if (!register_sysctl_paths(loadpin_sysctl_path,
-					   loadpin_sysctl_table))
+					   loadpin_sysctl_table,
+					   LOADPIN_SYSCTL_PATH_SIZE))
 			pr_notice("sysctl registration failed!\n");
 		else
 			pr_info("enforcement can be disabled.\n");
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..c4472d17b46d 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -449,9 +449,9 @@ static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
 static struct ctl_path yama_sysctl_path[] = {
 	{ .procname = "kernel", },
-	{ .procname = "yama", },
-	{ }
+	{ .procname = "yama", }
 };
+#define YAMA_SYSCTL_PATH_SIZE ARRAY_SIZE(yama_sysctl_path)
 
 static struct ctl_table yama_sysctl_table[] = {
 	{
@@ -467,7 +467,7 @@ static struct ctl_table yama_sysctl_table[] = {
 };
 static void __init yama_init_sysctl(void)
 {
-	if (!register_sysctl_paths(yama_sysctl_path, yama_sysctl_table))
+	if (!register_sysctl_paths(yama_sysctl_path, yama_sysctl_table, YAMA_SYSCTL_PATH_SIZE))
 		panic("Yama: sysctl registration failed.\n");
 }
 #else
-- 
2.20.1



