Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA843683D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 17:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhDVPnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 11:43:01 -0400
Received: from smtp-42af.mail.infomaniak.ch ([84.16.66.175]:57685 "EHLO
        smtp-42af.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237927AbhDVPmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:42:31 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FR1qx36njzMqyJS;
        Thu, 22 Apr 2021 17:41:49 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4FR1qx0Kbdzlh8TK;
        Thu, 22 Apr 2021 17:41:49 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v34 13/13] landlock: Enable user space to infer supported features
Date:   Thu, 22 Apr 2021 17:41:23 +0200
Message-Id: <20210422154123.13086-14-mic@digikod.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422154123.13086-1-mic@digikod.net>
References: <20210422154123.13086-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Add a new flag LANDLOCK_CREATE_RULESET_VERSION to
landlock_create_ruleset(2).  This enables to retreive a Landlock ABI
version that is useful to efficiently follow a best-effort security
approach.  Indeed, it would be a missed opportunity to abort the whole
sandbox building, because some features are unavailable, instead of
protecting users as much as possible with the subset of features
provided by the running kernel.

This new flag enables user space to identify the minimum set of Landlock
features supported by the running kernel without relying on a filesystem
interface (e.g. /proc/version, which might be inaccessible) nor testing
multiple syscall argument combinations (i.e. syscall bisection).  New
Landlock features will be documented and tied to a minimum version
number (greater than 1).  The current version will be incremented for
each new kernel release supporting new Landlock features.  User space
libraries can leverage this information to seamlessly restrict processes
as much as possible while being compatible with newer APIs.

This is a much more lighter approach than the previous
landlock_get_features(2): the complexity is pushed to user space
libraries.  This flag meets similar needs as securityfs versions:
selinux/policyvers, apparmor/features/*/version* and tomoyo/version.

Supporting this flag now will be convenient for backward compatibility.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210422154123.13086-14-mic@digikod.net
---
 include/uapi/linux/landlock.h                |  8 ++++
 security/landlock/syscalls.c                 | 17 +++++--
 tools/testing/selftests/landlock/base_test.c | 47 ++++++++++++++++++++
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index ba946a1e40b2..b3d952067f59 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -27,6 +27,14 @@ struct landlock_ruleset_attr {
 	__u64 handled_access_fs;
 };
 
+/*
+ * sys_landlock_create_ruleset() flags:
+ *
+ * - %LANDLOCK_CREATE_RULESET_VERSION: Get the highest supported Landlock ABI
+ *   version.
+ */
+#define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
+
 /**
  * enum landlock_rule_type - Landlock rule type
  *
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 93620ad7593b..32396962f04d 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -128,6 +128,8 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
+#define LANDLOCK_ABI_VERSION	1
+
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
  *
@@ -135,15 +137,19 @@ static const struct file_operations ruleset_fops = {
  *        the new ruleset.
  * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
  *        backward and forward compatibility).
- * @flags: Must be 0.
+ * @flags: Supported value: %LANDLOCK_CREATE_RULESET_VERSION.
  *
  * This system call enables to create a new Landlock ruleset, and returns the
  * related file descriptor on success.
  *
+ * If @flags is %LANDLOCK_CREATE_RULESET_VERSION and @attr is NULL and @size is
+ * 0, then the returned value is the highest supported Landlock ABI version
+ * (starting at 1).
+ *
  * Possible returned errors are:
  *
  * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - EINVAL: @flags is not 0, or unknown access, or too small @size;
+ * - EINVAL: unknown @flags, or unknown access, or too small @size;
  * - E2BIG or EFAULT: @attr or @size inconsistencies;
  * - ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
  */
@@ -161,9 +167,12 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if (!landlock_initialized)
 		return -EOPNOTSUPP;
 
-	/* No flag for now. */
-	if (flags)
+	if (flags) {
+		if ((flags == LANDLOCK_CREATE_RULESET_VERSION)
+				&& !attr && !size)
+			return LANDLOCK_ABI_VERSION;
 		return -EINVAL;
+	}
 
 	/* Copies raw user space buffer. */
 	err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 262c3c8d953a..ca40abe9daa8 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -63,6 +63,53 @@ TEST(inconsistent_attr) {
 	free(buf);
 }
 
+TEST(abi_version) {
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	ASSERT_EQ(1, landlock_create_ruleset(NULL, 0,
+				LANDLOCK_CREATE_RULESET_VERSION));
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
+				LANDLOCK_CREATE_RULESET_VERSION));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
+				LANDLOCK_CREATE_RULESET_VERSION));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+				sizeof(ruleset_attr),
+				LANDLOCK_CREATE_RULESET_VERSION));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
+				LANDLOCK_CREATE_RULESET_VERSION | 1 << 31));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST(inval_create_ruleset_flags) {
+	const int last_flag = LANDLOCK_CREATE_RULESET_VERSION;
+	const int invalid_flag = last_flag << 1;
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0, invalid_flag));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0, invalid_flag));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
+				invalid_flag));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+				sizeof(ruleset_attr), invalid_flag));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 TEST(empty_path_beneath_attr) {
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
-- 
2.31.1

