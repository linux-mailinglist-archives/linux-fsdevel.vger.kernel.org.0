Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF671858E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 03:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgCOCYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 22:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgCOCYO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:14 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F77020871;
        Sat, 14 Mar 2020 21:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584221809;
        bh=ZxxGTjlO7NBT1wg1m3B0rlTJ0Dra1Fpr72IGr/O4DX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4wuNEKXZchKmweKLq4FIo5pf18vP9fJuZTj9v/SsvJ4wuMgkvrbAqR8RTcRjPixQ
         jgNp3xa9zNt7U6vzd427av9gdPoiGeXDiqRo382SQceiCTHBID/UYSCIDFkQ1LoM47
         GMNTwd4u/JpGTzgxBV67nejuG5Ykzy2BQifLvU5k=
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
Subject: [PATCH v3 5/5] selftests: kmod: test disabling module autoloading
Date:   Sat, 14 Mar 2020 14:34:26 -0700
Message-Id: <20200314213426.134866-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200314213426.134866-1-ebiggers@kernel.org>
References: <20200314213426.134866-1-ebiggers@kernel.org>
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

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tools/testing/selftests/kmod/kmod.sh | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 315a43111e046..3702dbcc90a77 100755
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
@@ -616,6 +645,7 @@ test_reqs
 allow_user_defaults
 load_req_mod
 
+MODPROBE=$(</proc/sys/kernel/modprobe)
 trap "test_finish" EXIT
 
 parse_args $@
-- 
2.25.1

