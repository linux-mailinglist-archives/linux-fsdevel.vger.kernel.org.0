Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC23183A92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 21:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCLU0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 16:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgCLU0L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:26:11 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359F62073B;
        Thu, 12 Mar 2020 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584044770;
        bh=PkbHDtvpsvrKg7OoS4kcJh+MYbVvvmOxtsvir5TXVWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGBZ88U3mISWi7mVh5Q8LlqIBW6Mp0rzPG0I1skZVUhAoR8WbH9WaifzXzYjqa5wg
         Ftpan3XO6duRSyz3OsNnTuTON2dn6j8kJr10GvittuvkuSHddothjvC4k0cFiCvD2H
         HgIDdYbV14qN4p5mXM8EeZ0ZQ351s3hSfPrbeZCY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: [PATCH v2 4/4] selftests: kmod: test disabling module autoloading
Date:   Thu, 12 Mar 2020 13:25:52 -0700
Message-Id: <20200312202552.241885-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312202552.241885-1-ebiggers@kernel.org>
References: <20200312202552.241885-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Test that request_module() fails with -ENOENT when
/proc/sys/kernel/modprobe contains (a) a nonexistent path, and (b) an
empty path.

Case (b) is a regression test for the patch "kmod: make request_module()
return an error when autoloading is disabled".

Tested with 'kmod.sh -t 0010 && kmod.sh -t 0011', and also simply with
'kmod.sh' to run all kmod tests.

Note: get_test_count() and get_test_enabled() were broken for test
numbers above 9 due to awk interpreting a field specification like
'$0010' as octal rather than decimal.  So I fixed that too.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tools/testing/selftests/kmod/kmod.sh | 43 +++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 8b944cf042f6c..3702dbcc90a77 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -61,6 +61,8 @@ ALL_TESTS="$ALL_TESTS 0006:10:1"
 ALL_TESTS="$ALL_TESTS 0007:5:1"
 ALL_TESTS="$ALL_TESTS 0008:150:1"
 ALL_TESTS="$ALL_TESTS 0009:150:1"
+ALL_TESTS="$ALL_TESTS 0010:1:1"
+ALL_TESTS="$ALL_TESTS 0011:1:1"
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -149,6 +151,7 @@ function load_req_mod()
 
 test_finish()
 {
+	echo "$MODPROBE" > /proc/sys/kernel/modprobe
 	echo "Test completed"
 }
 
@@ -443,6 +446,30 @@ kmod_test_0009()
 	config_expect_result ${FUNCNAME[0]} SUCCESS
 }
 
+kmod_test_0010()
+{
+	kmod_defaults_driver
+	config_num_threads 1
+	echo "/KMOD_TEST_NONEXISTENT" > /proc/sys/kernel/modprobe
+	config_trigger ${FUNCNAME[0]}
+	config_expect_result ${FUNCNAME[0]} -ENOENT
+	echo "$MODPROBE" > /proc/sys/kernel/modprobe
+}
+
+kmod_test_0011()
+{
+	kmod_defaults_driver
+	config_num_threads 1
+	# This causes the kernel to not even try executing modprobe.  The error
+	# code is still -ENOENT like when modprobe doesn't exist, so we can't
+	# easily test for the exact difference.  But this still is a useful test
+	# since there was a bug where request_module() returned 0 in this case.
+	echo > /proc/sys/kernel/modprobe
+	config_trigger ${FUNCNAME[0]}
+	config_expect_result ${FUNCNAME[0]} -ENOENT
+	echo "$MODPROBE" > /proc/sys/kernel/modprobe
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -460,6 +487,8 @@ list_tests()
 	echo "0007 x $(get_test_count 0007) - multithreaded tests with default setup test request_module() and get_fs_type()"
 	echo "0008 x $(get_test_count 0008) - multithreaded - push kmod_concurrent over max_modprobes for request_module()"
 	echo "0009 x $(get_test_count 0009) - multithreaded - push kmod_concurrent over max_modprobes for get_fs_type()"
+	echo "0010 x $(get_test_count 0010) - test nonexistent modprobe path"
+	echo "0011 x $(get_test_count 0011) - test completely disabling module autoloading"
 }
 
 usage()
@@ -505,18 +534,23 @@ function test_num()
 	fi
 }
 
-function get_test_count()
+function get_test_data()
 {
 	test_num $1
-	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	local field_num=$(echo $1 | sed 's/^0*//')
+	echo $ALL_TESTS | awk '{print $'$field_num'}'
+}
+
+function get_test_count()
+{
+	TEST_DATA=$(get_test_data $1)
 	LAST_TWO=${TEST_DATA#*:*}
 	echo ${LAST_TWO%:*}
 }
 
 function get_test_enabled()
 {
-	test_num $1
-	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	TEST_DATA=$(get_test_data $1)
 	echo ${TEST_DATA#*:*:}
 }
 
@@ -611,6 +645,7 @@ test_reqs
 allow_user_defaults
 load_req_mod
 
+MODPROBE=$(</proc/sys/kernel/modprobe)
 trap "test_finish" EXIT
 
 parse_args $@
-- 
2.25.1

