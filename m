Return-Path: <linux-fsdevel+bounces-3297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08707F2B54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 12:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E7AB21B86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0190482F8;
	Tue, 21 Nov 2023 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBA5qgIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C420482D6;
	Tue, 21 Nov 2023 11:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B96FEC433C8;
	Tue, 21 Nov 2023 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700564549;
	bh=52JkpIJppkZJcZh8UX3QIgjrV5B2xTu1H4YPWo7oRts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CBA5qgIAHx1kluHI3pFbL4dQQXqnEBUT52wmFB62ag5SYxGvQuO2RBsqgUDO5pHqb
	 0I0cbqA2FcAFbObvMcKiuB6fJzC5Ih6n6cNboPkOWwy2ogpouNxp9/iDeQcUtiHDUN
	 npipMLojSH/NR0EY6vCD413lAmnwmRe11Qwk4cuolKp9JMz3/dszMuutFNyChZarRr
	 eVe3/WSBC3oiEtKjTo10hkOFRcjgU89nWxo5+85bWEYQd0lQwGTSVIGTz0t499U4Z7
	 AsWpmyRCW+OxOLMD6xkgDTOQQtM4oF9LxpVv8kxy+mq1ULGoNm+QN/Svb+8lDIFz+p
	 wBCpq3nM8/ZYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE80C61D94;
	Tue, 21 Nov 2023 11:02:29 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 21 Nov 2023 12:02:19 +0100
Subject: [PATCH 2/3] sysctl: Add a selftest for handling empty dirs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20231121-jag-fix_out_of_bounds_insert-v1-2-571e76d51316@samsung.com>
References:
 <20231121-jag-fix_out_of_bounds_insert-v1-0-571e76d51316@samsung.com>
In-Reply-To:
 <20231121-jag-fix_out_of_bounds_insert-v1-0-571e76d51316@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Iurii Zaikin <yzaikin@google.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=bKjIXr0H+JsfSfz8xoXCVF/jy2aS3I1Y63fFXt/C07E=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlXI5D0LZq/oFYRZ4WUYe0Wlyd9gXjLPnh7W7YW
 qMrp4gEAWuJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZVyOQwAKCRC6l81St5ZB
 T4fYC/wJkklJdFj9BvtYlU849BuM7cf7Qh5+ZjpAmMELnTk6sRAvSlANrBRLxx8hBkD+jlfkOr2
 I+sFj78+0dfjdDBlcuKxNgEYp7U2cYRdy4e5OZ7rupNaO4aVF726D0pcA4ayG41RpJF0MX/m2Wk
 I8QqJzwgdLy0HF5JMT8gve19MS57N+KJ364mnaHpNjczMMejIgW+3P+Nm31RFvvPkVv4Z7rG22G
 IDySN/8AOVXH/EOIEx5UAB2MLEGLt4DYpy3JNWJlAfPc1Gd4WcqxAaSsMNoo2IluWUzh3QhHwCF
 wWT2iT1j8m7QNdKd6WuaLsxKN7ULhMuSfcDRJxI8Ml3BQgcZ0AHfQjR5263qAHbKMrNaZoPHaRN
 5W3PC3aHH3eyuPWOlPA1wk+ZQjS7UhuSvK6jH6MaCSi96ch32L0RVrg18zUCWEj+E/nbiFDDIoT
 7YNN3sm5PXfVwyElGz7HPWuwzli4yjK8iiyUD7YROTX5u1wiWPE5cWQdqnsTqgj2atYss=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

Basic test to ensure that empty directories can be registered and that
they in turn can serve as a base dir for other registrations.

Add one test to the sysctl selftest module. It first registers an empty
directory under "empty_add" and then uses that as a base to register
another empty dir.
The sysctl bash script then checks that "empty_add" is present and that
there an empty directory within it.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 lib/test_sysctl.c                        | 29 +++++++++++++++++++++++++++++
 tools/testing/selftests/sysctl/sysctl.sh | 23 +++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 8036aa91a1cb..730908bc1c2b 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -35,6 +35,8 @@ static struct {
 	struct ctl_table_header *test_h_setup_node;
 	struct ctl_table_header *test_h_mnt;
 	struct ctl_table_header *test_h_mnterror;
+	struct ctl_table_header *empty_add;
+	struct ctl_table_header *empty;
 } sysctl_test_headers;
 
 struct test_sysctl_data {
@@ -220,6 +222,25 @@ static int test_sysctl_run_register_mount_point(void)
 	return 0;
 }
 
+static struct ctl_table test_table_empty[] = { };
+
+static int test_sysctl_run_register_empty(void)
+{
+	/* Tets that an empty dir can be created */
+	sysctl_test_headers.empty_add
+		= register_sysctl("debug/test_sysctl/empty_add", test_table_empty);
+	if (!sysctl_test_headers.empty_add)
+		return -ENOMEM;
+
+	/* Test that register on top of an empty dir works */
+	sysctl_test_headers.empty
+		= register_sysctl("debug/test_sysctl/empty_add/empty", test_table_empty);
+	if (!sysctl_test_headers.empty)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int __init test_sysctl_init(void)
 {
 	int err;
@@ -233,6 +254,10 @@ static int __init test_sysctl_init(void)
 		goto out;
 
 	err = test_sysctl_run_register_mount_point();
+	if (err)
+		goto out;
+
+	err = test_sysctl_run_register_empty();
 
 out:
 	return err;
@@ -248,6 +273,10 @@ static void __exit test_sysctl_exit(void)
 		unregister_sysctl_table(sysctl_test_headers.test_h_mnt);
 	if (sysctl_test_headers.test_h_mnterror)
 		unregister_sysctl_table(sysctl_test_headers.test_h_mnterror);
+	if (sysctl_test_headers.empty)
+		unregister_sysctl_table(sysctl_test_headers.empty);
+	if (sysctl_test_headers.empty_add)
+		unregister_sysctl_table(sysctl_test_headers.empty_add);
 }
 
 module_exit(test_sysctl_exit);
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 444b2befda82..e956d2c3b7e9 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -35,6 +35,7 @@ ALL_TESTS="$ALL_TESTS 0007:1:1:boot_int:1"
 ALL_TESTS="$ALL_TESTS 0008:1:1:match_int:1"
 ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error:0"
 ALL_TESTS="$ALL_TESTS 0010:1:1:mnt/mnt_error:0"
+ALL_TESTS="$ALL_TESTS 0011:1:1:empty_add:0"
 
 function allow_user_defaults()
 {
@@ -828,6 +829,27 @@ sysctl_test_0010()
 	return 0
 }
 
+sysctl_test_0011()
+{
+	TARGET="${SYSCTL}/$(get_test_target 0011)"
+	echo -n "Testing empty dir handling in ${TARGET} ... "
+	if [ ! -d ${TARGET} ]; then
+		echo -e "FAIL\nCould not create ${TARGET}" >&2
+		rc=1
+		test_rc
+	fi
+
+	TARGET2="${TARGET}/empty"
+	if [ ! -d ${TARGET2} ]; then
+		echo -e "FAIL\nCould not create ${TARGET2}" >&2
+		rc=1
+		test_rc
+	fi
+
+	echo "OK"
+	return 0
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -846,6 +868,7 @@ list_tests()
 	echo "0008 x $(get_test_count 0008) - tests sysctl macro values match"
 	echo "0009 x $(get_test_count 0009) - tests sysct unregister"
 	echo "0010 x $(get_test_count 0010) - tests sysct mount point"
+	echo "0011 x $(get_test_count 0011) - tests empty directories"
 }
 
 usage()

-- 
2.30.2


