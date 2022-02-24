Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10E04C2D1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 14:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiBXNdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 08:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiBXNdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:33:13 -0500
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEC616DAF6
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 05:32:39 -0800 (PST)
X-QQ-mid: bizesmtp70t1645709553teogwjqm
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 24 Feb 2022 21:32:30 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: ZKIyA7viXp0gWhLqDVbbfYxfkb1rGrN8gS7cOdtlS7mVfvwrf5J+8/rKYvFC7
        C/XTCCvT/2Awyd/hxgYSSFTj/R5yQIMkL3l1RyA43TAJIF2tJMBNBuUdhQ599kCIe5m1noz
        kUjxq2b8nrQ7DkWyQWIlT0qleP7kc1r1cSYDdHen1miSf+NvaRlggGCd+Kcj76Wi4JNQtXE
        OD/CMdjoN465+2nybrK3U+NRd+oCxrEJ8AOka9iCl2ZQYRGFZRMHM7wA0RMv7GMYk3VEpUj
        i9W801lL0B/6+bXVsryCWraTiCKfhuVS2lzwWA2vH+BEFDlPRc3JQSZMmpH6IP7isO/tisW
        RW+2H+fxRLm+R8eBUnHpkjKNUUEekqKxxkEN684X+7BXf5WGJcBmalzqaVaXw==
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
Subject: [PATCH v3 2/2] fs/proc: Optimize arrays defined by struct ctl_path
Date:   Thu, 24 Feb 2022 21:32:17 +0800
Message-Id: <20220224133217.1755-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220224133217.1755-1-tangmeng@uniontech.com>
References: <20220224133217.1755-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, arrays defined by struct ctl_path is terminated
with an empty one. When we actually only register one ctl_path,
we've gone from 8 bytes to 16 bytes.

The optimization has been implemented in the previous patch,
here to remove unnecessary terminate ctl_path with an empty one.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 arch/csky/abiv1/alignment.c | 5 ++---
 arch/nds32/mm/alignment.c   | 5 ++---
 fs/verity/signature.c       | 3 +--
 kernel/pid_namespace.c      | 2 +-
 kernel/seccomp.c            | 3 +--
 security/apparmor/lsm.c     | 3 +--
 security/loadpin/loadpin.c  | 3 +--
 security/yama/yama_lsm.c    | 3 +--
 8 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index 2df115d0e210..5c2936b29d29 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -340,9 +340,8 @@ static struct ctl_table sysctl_table[2] = {
 	{}
 };
 
-static struct ctl_path sysctl_path[2] = {
-	{.procname = "csky"},
-	{}
+static struct ctl_path sysctl_path[1] = {
+	{.procname = "csky"}
 };
 
 static int __init csky_alignment_init(void)
diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
index 1eb7ded6992b..5e79c01b91d6 100644
--- a/arch/nds32/mm/alignment.c
+++ b/arch/nds32/mm/alignment.c
@@ -560,9 +560,8 @@ static struct ctl_table nds32_sysctl_table[2] = {
 	{}
 };
 
-static struct ctl_path nds32_path[2] = {
-	{.procname = "nds32"},
-	{}
+static struct ctl_path nds32_path[1] = {
+	{.procname = "nds32"}
 };
 
 /*
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 143a530a8008..6cdad230c438 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -92,8 +92,7 @@ static struct ctl_table_header *fsverity_sysctl_header;
 
 static const struct ctl_path fsverity_sysctl_path[] = {
 	{ .procname = "fs", },
-	{ .procname = "verity", },
-	{ }
+	{ .procname = "verity", }
 };
 
 static struct ctl_table fsverity_sysctl_table[] = {
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a46a3723bc66..f4f6db65bf81 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -294,7 +294,7 @@ static struct ctl_table pid_ns_ctl_table[] = {
 	},
 	{ }
 };
-static struct ctl_path kern_path[] = { { .procname = "kernel", }, { } };
+static struct ctl_path kern_path[] = { { .procname = "kernel", } };
 #endif	/* CONFIG_CHECKPOINT_RESTORE */
 
 int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index db10e73d06e0..03f88d0b79f1 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2333,8 +2333,7 @@ static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
 
 static struct ctl_path seccomp_sysctl_path[] = {
 	{ .procname = "kernel", },
-	{ .procname = "seccomp", },
-	{ }
+	{ .procname = "seccomp", }
 };
 
 static struct ctl_table seccomp_sysctl_table[] = {
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4f0eecb67dde..e35c3b29742d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1729,8 +1729,7 @@ static int apparmor_dointvec(struct ctl_table *table, int write,
 }
 
 static struct ctl_path apparmor_sysctl_path[] = {
-	{ .procname = "kernel", },
-	{ }
+	{ .procname = "kernel", }
 };
 
 static struct ctl_table apparmor_sysctl_table[] = {
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..0471b177d2e1 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -48,8 +48,7 @@ static DEFINE_SPINLOCK(pinned_root_spinlock);
 
 static struct ctl_path loadpin_sysctl_path[] = {
 	{ .procname = "kernel", },
-	{ .procname = "loadpin", },
-	{ }
+	{ .procname = "loadpin", }
 };
 
 static struct ctl_table loadpin_sysctl_table[] = {
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..b42b61e801b1 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -449,8 +449,7 @@ static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
 static struct ctl_path yama_sysctl_path[] = {
 	{ .procname = "kernel", },
-	{ .procname = "yama", },
-	{ }
+	{ .procname = "yama", }
 };
 
 static struct ctl_table yama_sysctl_table[] = {
-- 
2.20.1



