Return-Path: <linux-fsdevel+bounces-44337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6470A678D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 17:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C677ABF38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BD211A05;
	Tue, 18 Mar 2025 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="p2QKQyvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ACA210192
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314507; cv=none; b=dKpvcZSQjRDYbSSitU98SUQQOfGIIh5ZeWqgNA6F5B+A+WDXIICP+cjkDILc/iDKgEb2Ov4XPbEqs/M08eh/abuCjEDJOe8qO/j/OQ3ifmcUmuKrrcIvReQInsSyiEa7ohLWfvy9rtmxjKQlr34hpWiDlZs/nVTQeDjYQ0HbjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314507; c=relaxed/simple;
	bh=JramzYHdSNAyf0Ec/g98QrnULlYBLgYBzLIqY1+7+dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/Qhh6F319Tarhn1Nc4b+bLks6+Qj5mZBRjD8HIhgg1sneJIOX4QYqhhOTwqTx2TY+NW86jSw0O2o0G9K9/4aBmM6RVtpDb2yruZB342uzgCU6sVLRXr11i3MwZvYBgfyoN+bKRZSzsYfhxP2/dx9Q6qU+HxOACfMdQ+EFxB98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=p2QKQyvQ; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH3x27TxzFdJ;
	Tue, 18 Mar 2025 17:14:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314493;
	bh=9cZBCLq5rNBgIcmj1nLXU6tFH2oHnkmYD6bn/RhTn9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2QKQyvQPjHMq7ABiLFXRlq4+q88+Eam09x063+Q7Xf6MdUH8rkYlPyQK6CAfKKeq
	 y8elgc9pNPLNBEChAnXUhIqXefiDjUTfoLRur4PBHBQRSbnya85UpFwfmkeknMJ9Aj
	 ITJ8zed6D2vjcJ43KVUkQOAZWdnOSljj37f7l3aY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH3w4SQBzX7q;
	Tue, 18 Mar 2025 17:14:52 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/8] landlock: Add the errata interface
Date: Tue, 18 Mar 2025 17:14:37 +0100
Message-ID: <20250318161443.279194-3-mic@digikod.net>
In-Reply-To: <20250318161443.279194-1-mic@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Some fixes may require user space to check if they are applied on the
running kernel before using a specific feature.  For instance, this
applies when a restriction was previously too restrictive and is now
getting relaxed (e.g. for compatibility reasons).  However, non-visible
changes for legitimate use (e.g. security fixes) do not require an
erratum.

Because fixes are backported down to a specific Landlock ABI, we need a
way to avoid cherry-pick conflicts.  The solution is to only update a
file related to the lower ABI impacted by this issue.  All the ABI files
are then used to create a bitmask of fixes.

The new errata interface is similar to the one used to get the supported
Landlock ABI version, but it returns a bitmask instead because the order
of fixes may not match the order of versions, and not all fixes may
apply to all versions.

The actual errata will come with dedicated commits.  The description is
not actually used in the code but serves as documentation.

Create the landlock_abi_version symbol and use its value to check errata
consistency.

Update test_base's create_ruleset_checks_ordering tests and add errata
tests.

This commit is backportable down to the first version of Landlock.

Fixes: 3532b0b4352c ("landlock: Enable user space to infer supported features")
Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250318161443.279194-3-mic@digikod.net
---

Changes since v1:
- New patch.
---
 include/uapi/linux/landlock.h                |  2 +
 security/landlock/errata.h                   | 87 ++++++++++++++++++++
 security/landlock/setup.c                    | 30 +++++++
 security/landlock/setup.h                    |  3 +
 security/landlock/syscalls.c                 | 22 ++++-
 tools/testing/selftests/landlock/base_test.c | 38 ++++++++-
 6 files changed, 177 insertions(+), 5 deletions(-)
 create mode 100644 security/landlock/errata.h

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index e1d2c27533b4..8806a132d7b8 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -57,9 +57,11 @@ struct landlock_ruleset_attr {
  *
  * - %LANDLOCK_CREATE_RULESET_VERSION: Get the highest supported Landlock ABI
  *   version.
+ * - %LANDLOCK_CREATE_RULESET_ERRATA: Get a bitmask of fixed issues.
  */
 /* clang-format off */
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
+#define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/errata.h b/security/landlock/errata.h
new file mode 100644
index 000000000000..f26b28b9873d
--- /dev/null
+++ b/security/landlock/errata.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Errata information
+ *
+ * Copyright © 2025 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_ERRATA_H
+#define _SECURITY_LANDLOCK_ERRATA_H
+
+#include <linux/init.h>
+
+struct landlock_erratum {
+	const int abi;
+	const u8 number;
+};
+
+/* clang-format off */
+#define LANDLOCK_ERRATUM(NUMBER) \
+	{ \
+		.abi = LANDLOCK_ERRATA_ABI, \
+		.number = NUMBER, \
+	},
+/* clang-format on */
+
+/*
+ * Some fixes may require user space to check if they are applied on the running
+ * kernel before using a specific feature.  For instance, this applies when a
+ * restriction was previously too restrictive and is now getting relaxed (for
+ * compatibility or semantic reasons).  However, non-visible changes for
+ * legitimate use (e.g. security fixes) do not require an erratum.
+ */
+static const struct landlock_erratum landlock_errata_init[] __initconst = {
+
+/*
+ * Only Sparse may not implement __has_include.  If a compiler does not
+ * implement __has_include, a warning will be printed at boot time (see
+ * setup.c).
+ */
+#ifdef __has_include
+
+#define LANDLOCK_ERRATA_ABI 1
+#if __has_include("errata/abi-1.h")
+#include "errata/abi-1.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 2
+#if __has_include("errata/abi-2.h")
+#include "errata/abi-2.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 3
+#if __has_include("errata/abi-3.h")
+#include "errata/abi-3.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 4
+#if __has_include("errata/abi-4.h")
+#include "errata/abi-4.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+/*
+ * For each new erratum, we need to include all the ABI files up to the impacted
+ * ABI to make all potential future intermediate errata easy to backport.
+ *
+ * If such change involves more than one ABI addition, then it must be in a
+ * dedicated commit with the same Fixes tag as used for the actual fix.
+ *
+ * Each commit creating a new security/landlock/errata/abi-*.h file must have a
+ * Depends-on tag to reference the commit that previously added the line to
+ * include this new file, except if the original Fixes tag is enough.
+ *
+ * Each erratum must be documented in its related ABI file, and a dedicated
+ * commit must update Documentation/userspace-api/landlock.rst to include this
+ * erratum.  This commit will not be backported.
+ */
+
+#endif
+
+	{}
+};
+
+#endif /* _SECURITY_LANDLOCK_ERRATA_H */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index c71832a8e369..0c85ea27e409 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -6,12 +6,14 @@
  * Copyright © 2018-2020 ANSSI
  */
 
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
 #include "common.h"
 #include "cred.h"
+#include "errata.h"
 #include "fs.h"
 #include "net.h"
 #include "setup.h"
@@ -31,8 +33,36 @@ struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+int landlock_errata __ro_after_init;
+
+static void __init compute_errata(void)
+{
+	size_t i;
+
+#ifndef __has_include
+	/*
+	 * This is a safeguard to make sure the compiler implements
+	 * __has_include (see errata.h).
+	 */
+	WARN_ON_ONCE(1);
+	return;
+#endif
+
+	for (i = 0; landlock_errata_init[i].number; i++) {
+		const int prev_errata = landlock_errata;
+
+		if (WARN_ON_ONCE(landlock_errata_init[i].abi >
+				 landlock_abi_version))
+			continue;
+
+		landlock_errata |= BIT(landlock_errata_init[i].number - 1);
+		WARN_ON_ONCE(prev_errata == landlock_errata);
+	}
+}
+
 static int __init landlock_init(void)
 {
+	compute_errata();
 	landlock_add_cred_hooks();
 	landlock_add_task_hooks();
 	landlock_add_fs_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index c4252d46d49d..fca307c35fee 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -11,7 +11,10 @@
 
 #include <linux/lsm_hooks.h>
 
+extern const int landlock_abi_version;
+
 extern bool landlock_initialized;
+extern int landlock_errata;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
 extern const struct lsm_id landlock_lsmid;
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index a9760d252fc2..cf9e0483e542 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -160,7 +160,9 @@ static const struct file_operations ruleset_fops = {
  *        the new ruleset.
  * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
  *        backward and forward compatibility).
- * @flags: Supported value: %LANDLOCK_CREATE_RULESET_VERSION.
+ * @flags: Supported value:
+ *         - %LANDLOCK_CREATE_RULESET_VERSION
+ *         - %LANDLOCK_CREATE_RULESET_ERRATA
  *
  * This system call enables to create a new Landlock ruleset, and returns the
  * related file descriptor on success.
@@ -169,6 +171,10 @@ static const struct file_operations ruleset_fops = {
  * 0, then the returned value is the highest supported Landlock ABI version
  * (starting at 1).
  *
+ * If @flags is %LANDLOCK_CREATE_RULESET_ERRATA and @attr is NULL and @size is
+ * 0, then the returned value is a bitmask of fixed issues for the current
+ * Landlock ABI version.
+ *
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
@@ -192,9 +198,15 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 		return -EOPNOTSUPP;
 
 	if (flags) {
-		if ((flags == LANDLOCK_CREATE_RULESET_VERSION) && !attr &&
-		    !size)
-			return LANDLOCK_ABI_VERSION;
+		if (attr || size)
+			return -EINVAL;
+
+		if (flags == LANDLOCK_CREATE_RULESET_VERSION)
+			return landlock_abi_version;
+
+		if (flags == LANDLOCK_CREATE_RULESET_ERRATA)
+			return landlock_errata;
+
 		return -EINVAL;
 	}
 
@@ -235,6 +247,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	return ruleset_fd;
 }
 
+const int landlock_abi_version = LANDLOCK_ABI_VERSION;
+
 /*
  * Returns an owned ruleset from a FD. It is thus needed to call
  * landlock_put_ruleset() on the return value.
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 1bc16fde2e8a..c0abadd0bbbe 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -98,10 +98,46 @@ TEST(abi_version)
 	ASSERT_EQ(EINVAL, errno);
 }
 
+TEST(errata)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	int errata;
+
+	errata = landlock_create_ruleset(NULL, 0,
+					 LANDLOCK_CREATE_RULESET_ERRATA);
+	/* The errata bitmask will not be backported to tests. */
+	ASSERT_LE(0, errata);
+	TH_LOG("errata: 0x%x", errata);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
+					      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
+					      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1,
+		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
+					  LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(
+			      NULL, 0,
+			      LANDLOCK_CREATE_RULESET_VERSION |
+				      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
+					      LANDLOCK_CREATE_RULESET_ERRATA |
+						      1 << 31));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 /* Tests ordering of syscall argument checks. */
 TEST(create_ruleset_checks_ordering)
 {
-	const int last_flag = LANDLOCK_CREATE_RULESET_VERSION;
+	const int last_flag = LANDLOCK_CREATE_RULESET_ERRATA;
 	const int invalid_flag = last_flag << 1;
 	int ruleset_fd;
 	const struct landlock_ruleset_attr ruleset_attr = {
-- 
2.48.1


