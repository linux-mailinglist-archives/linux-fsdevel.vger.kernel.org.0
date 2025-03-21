Return-Path: <linux-fsdevel+bounces-44711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B2CA6BB10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C89619C2530
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4556C22B595;
	Fri, 21 Mar 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPXH0fGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890FB2248AA;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561291; cv=none; b=JRbi2YStJZJrZWEkvO86RH57OX5Dfq7a5BoetDdx0zGj9jOo26QyJPPNJsbFJjBQVWZrzj4HnMTGtH0GS1+H5gPSDXLCwDKtgd04LtFYzaksPYGFxAenj8z8D0/4XY7hMowvfiKK83szRLH7UmBh2A8MAfR4Ko9T+f0dxUolfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561291; c=relaxed/simple;
	bh=ulWpz4Aai0sdDwCgU5sVlfrcZ/wicABXdjo+xHGDW0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjIMICnB1oe/qkgZ25ePrfA4O1VIPawXKbvZEAP/NTRPpLusbyVqHfgNZHr5i9XIPjFJteCSh44b69clfmvxy/I2RQ2AhZ+2sUWdW9RhmnEonFZxB0uzE9vqHaNbhoiNNh4D4mKmy8PhTLZmGKzWHgiu+rNJlwqLC79VYcqTVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPXH0fGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14797C4CEEA;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742561291;
	bh=ulWpz4Aai0sdDwCgU5sVlfrcZ/wicABXdjo+xHGDW0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PPXH0fGFNJRrKIcRrvXzNIdyjAy+uDKaqmJePzwjOPvI0RpSXdrd0fD2RAeDUQ0nX
	 ZkpgrfisYy7DX3HIgRVnQKOP4OiNy5AAeDuQ/M2SYNeLrvyyR7PRUoMkLzBFnS+y72
	 l9t+MnH/gLDrPN6gPfIa6SXT4p3E8ysIryuM1RbTXHbO3y+hzsRnCgLjfp+NBVxv7z
	 yGAJrtAi2JHyYb82KHNwSyUOLNoUDJSM/JksYTE9V1gG9WWAmZI3Dm2M2kyCwXIIMR
	 LMtOdjBwGOEh4SVJQ7jaDO5XZkSUI7FRUOYZ0eh/n640zeoNwjyIh5Jh8F5JElqnrU
	 BeuM57IHIg/iA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F08C36002;
	Fri, 21 Mar 2025 12:48:10 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 21 Mar 2025 13:47:24 +0100
Subject: [PATCH 1/4] sysctl: move u8 register test to lib/test_sysctl.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-jag-test_extra_val-v1-1-a01b3b17dc66@kernel.org>
References: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
In-Reply-To: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6197;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ulWpz4Aai0sdDwCgU5sVlfrcZ/wicABXdjo+xHGDW0Q=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfdYAeU3Wbm3ojUm2x3JxVF90KSyxlJec4Bk
 VpCsM2UJnu5D4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn3WAHAAoJELqXzVK3
 lkFPiTQL+gL5vXJ4CNm6vVjLXeVPTKZmkqHccUg2DOlTDHbwEw1fGCwMBkrIxAxsmwTMBve4XbL
 O81M0V7eJJzKICmKoozJqGidacgfYe3FzF1RzcP/4meWgpKUQaBxd7PCpgQE/BVAwfASjssiCA2
 iRj+r6cac3b0WWbaUhh1M9oAM5HIFLrIy0RQuquADP5Ggr3Ff2kxoA3FD8Ho98+8/hSzJf5DaeR
 cxqiMmm7kc1yhznqsxrU8vQdx0iN1FiZKByoyOvSU/lOkcv46Xy6dh+XesaNciAye/gO+84wl5i
 iJWwR4NfXtWulPyUmqSaJcNXQ+HR0HJTOc6Omp6tYT4axJJn/JqR9ip0+VFtUaQJiXa2JizLsfC
 7Wpuy3etqcW93xn27nXfd1Iwbyh4j9S6zBsoeb0SQPwhMiNKc3rsvGMSgHIVD4bWelSZh4+XP00
 5+ZikEWHBfyifCg0YJ8Zs2+nzbtGJpWOhIXRdVzlux1YS1KFuXu+ATh72qzC3hvikn7ZSEWBT26
 ls=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

If the test added in commit b5ffbd139688 ("sysctl: move the extra1/2
boundary check of u8 to sysctl_check_table_array") is run as a module, a
lingering reference to the module is left behind, and a 'sysctl -a'
leads to a panic.

To reproduce
    CONFIG_KUNIT=y
    CONFIG_SYSCTL_KUNIT_TEST=m

Then run these commands:
    modprobe sysctl-test
    rmmod sysctl-test
    sysctl -a

The panic varies but generally looks something like this:

    BUG: unable to handle page fault for address: ffffa4571c0c7db4
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 100000067 P4D 100000067 PUD 100351067 PMD 114f5e067 PTE 0
    Oops: Oops: 0000 [#1] SMP NOPTI
    ... ... ...
    RIP: 0010:proc_sys_readdir+0x166/0x2c0
    ... ... ...
    Call Trace:
     <TASK>
     iterate_dir+0x6e/0x140
     __se_sys_getdents+0x6e/0x100
     do_syscall_64+0x70/0x150
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

Move the test to lib/test_sysctl.c where the registration reference is
handled on module exit

'Fixes: b5ffbd139688 ("sysctl: move the extra1/2 boundary check of u8 to
sysctl_check_table_array")'

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl-test.c | 49 --------------------------------------
 lib/test_sysctl.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index eb2842bd055771ee8a72040f96260bdb0e754ad5..92f94ea28957f48893b0d0d947d73001428fecc7 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -367,54 +367,6 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
 
-/*
- * Test that registering an invalid extra value is not allowed.
- */
-static void sysctl_test_register_sysctl_sz_invalid_extra_value(
-		struct kunit *test)
-{
-	unsigned char data = 0;
-	const struct ctl_table table_foo[] = {
-		{
-			.procname	= "foo",
-			.data		= &data,
-			.maxlen		= sizeof(u8),
-			.mode		= 0644,
-			.proc_handler	= proc_dou8vec_minmax,
-			.extra1		= SYSCTL_FOUR,
-			.extra2		= SYSCTL_ONE_THOUSAND,
-		},
-	};
-
-	const struct ctl_table table_bar[] = {
-		{
-			.procname	= "bar",
-			.data		= &data,
-			.maxlen		= sizeof(u8),
-			.mode		= 0644,
-			.proc_handler	= proc_dou8vec_minmax,
-			.extra1		= SYSCTL_NEG_ONE,
-			.extra2		= SYSCTL_ONE_HUNDRED,
-		},
-	};
-
-	const struct ctl_table table_qux[] = {
-		{
-			.procname	= "qux",
-			.data		= &data,
-			.maxlen		= sizeof(u8),
-			.mode		= 0644,
-			.proc_handler	= proc_dou8vec_minmax,
-			.extra1		= SYSCTL_ZERO,
-			.extra2		= SYSCTL_TWO_HUNDRED,
-		},
-	};
-
-	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
-	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
-	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
-}
-
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -426,7 +378,6 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
-	KUNIT_CASE(sysctl_test_register_sysctl_sz_invalid_extra_value),
 	{}
 };
 
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 4249e0cc8aaff79d7da03aff81b3f9990e9eaac1..54a22e4b134677e022af05df3c75268e7a4a79e7 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -37,6 +37,7 @@ static struct {
 	struct ctl_table_header *test_h_mnterror;
 	struct ctl_table_header *empty_add;
 	struct ctl_table_header *empty;
+	struct ctl_table_header *test_u8;
 } sysctl_test_headers;
 
 struct test_sysctl_data {
@@ -239,6 +240,65 @@ static int test_sysctl_run_register_empty(void)
 	return 0;
 }
 
+static const struct ctl_table table_u8_over[] = {
+	{
+		.procname	= "u8_over",
+		.data		= &test_data.uint_0001,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_FOUR,
+		.extra2		= SYSCTL_ONE_THOUSAND,
+	},
+};
+
+static const struct ctl_table table_u8_under[] = {
+	{
+		.procname	= "u8_under",
+		.data		= &test_data.uint_0001,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_NEG_ONE,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
+};
+
+static const struct ctl_table table_u8_valid[] = {
+	{
+		.procname	= "u8_valid",
+		.data		= &test_data.uint_0001,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO_HUNDRED,
+	},
+};
+
+static int test_sysctl_register_u8_extra(void)
+{
+	/* should fail because it's over */
+	sysctl_test_headers.test_u8
+		= register_sysctl("debug/test_sysctl", table_u8_over);
+	if (sysctl_test_headers.test_u8)
+		return -ENOMEM;
+
+	/* should fail because it's under */
+	sysctl_test_headers.test_u8
+		= register_sysctl("debug/test_sysctl", table_u8_under);
+	if (sysctl_test_headers.test_u8)
+		return -ENOMEM;
+
+	/* should not fail because it's valid */
+	sysctl_test_headers.test_u8
+		= register_sysctl("debug/test_sysctl", table_u8_valid);
+	if (!sysctl_test_headers.test_u8)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int __init test_sysctl_init(void)
 {
 	int err;
@@ -256,6 +316,10 @@ static int __init test_sysctl_init(void)
 		goto out;
 
 	err = test_sysctl_run_register_empty();
+	if (err)
+		goto out;
+
+	err = test_sysctl_register_u8_extra();
 
 out:
 	return err;
@@ -275,6 +339,8 @@ static void __exit test_sysctl_exit(void)
 		unregister_sysctl_table(sysctl_test_headers.empty);
 	if (sysctl_test_headers.empty_add)
 		unregister_sysctl_table(sysctl_test_headers.empty_add);
+	if (sysctl_test_headers.test_u8)
+		unregister_sysctl_table(sysctl_test_headers.test_u8);
 }
 
 module_exit(test_sysctl_exit);

-- 
2.47.2



