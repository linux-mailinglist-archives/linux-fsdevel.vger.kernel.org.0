Return-Path: <linux-fsdevel+bounces-55218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19661B08842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476E84A5FB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1321E289360;
	Thu, 17 Jul 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z/e5YP3n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4K1YHeej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE68266B67;
	Thu, 17 Jul 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742145; cv=none; b=iBEty/9duyxef75jP0FO2UVVjW9BRMAvMumA/g/Mh2hqIQWe2ZIYNP2IkO9wBHqV2a8oDQ2nlSwUYwygbXqVTuBEOVFWZ8zj+cyFFtk1Fs373OyN64IcGChGXUQCYuUAOZFQYGFudo2a0QKVkc1jDNIiwSVg4yPo/CUo+Vd2kPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742145; c=relaxed/simple;
	bh=a/wJSYwyt34G89SNmJ3zmx0DFBABaWN8wJwhGB4qj6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoCMwv5amPD/xHn0/fgcfRw1mz0g5pwlLvtnmR6E7ifFbWw51zQg2O+ye3KFdshR4yJ7G7gqHbfCs24NHHzaJ5KqW9Qz6X+vrc5jQYczStDEZB63h5xB/JjO48jsw3FCrNTcqgsEuraZ9yMjcBZRWcp5upz0QiwfOEUnZB+DKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z/e5YP3n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4K1YHeej; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTyGoXC0dVBZ4irV+U60qFcUCjn8ZNx4ePIDmwa7kkM=;
	b=z/e5YP3n8sdJJ7RJkZzDUhlccH//pj4MtKZGk+xANNmnjfs+vd/s+FBnJXI98BTfum4KCe
	a2SORUf6JbPx6NKcw6ZOfVBpq0w0plfEe++rRrGTh12A6IoNhiitvmk154l70KvBjg9b1u
	1u29HqekVdpVglHpzSO+PfNf+S33kqBPk87IEJ8svBMSll9tnis614+Y5XXu+qMet6V8H+
	M9ryrxknJeK56Ag2ltYAgGyVREw4/b2++GEIWLGeUvQGzjsWwlgnKKYEHku+YKxocP3PeV
	xRKdcYAWVOZl/iGctW1PmDEL+gKBFDI2EXJhDkmx5PUqmUEU0lMla1on5krVJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTyGoXC0dVBZ4irV+U60qFcUCjn8ZNx4ePIDmwa7kkM=;
	b=4K1YHeej61l1AWM6ROFp0S48a+vTZ12cgz/A6VIEwjhsX+AXWqQSFG4Tbnmz7Dx8om7DOk
	49kXanApK5HN15DQ==
Date: Thu, 17 Jul 2025 10:48:10 +0200
Subject: [PATCH v5 08/15] kunit: tool: Don't overwrite test status based on
 subtest counts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-8-442b711cde2e@linutronix.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
In-Reply-To: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=2830;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=a/wJSYwyt34G89SNmJ3zmx0DFBABaWN8wJwhGB4qj6M=;
 b=tXs02f7ND1lQX/On+HUIDoFSH9res3NJSpIasrWk/3xCX1p1/YCA88ILiipewxL8ogZjRAXqs
 GyK9GF5hcoxA0mNtn0zx+aEe753J9xMt29ch1IS66MaLxZyLP3bUVp6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If a subtest itself reports success, but the outer testcase fails,
the whole testcase should be reported as a failure.
However the status is recalculated based on the test counts,
overwriting the outer test result.
Synthesize a failed test in this case to make sure the failure is not
swallowed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py                                  | 3 +++
 tools/testing/kunit/kunit_tool_test.py                               | 1 +
 tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index c176487356e6c94882046b19ea696d750905b8d5..a7a61e627e348db14b953080ec8789994fba955a 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -687,6 +687,9 @@ def bubble_up_test_results(test: Test) -> None:
 	elif test.counts.get_status() == TestStatus.TEST_CRASHED:
 		test.status = TestStatus.TEST_CRASHED
 
+	if status == TestStatus.FAILURE and test.counts.get_status() == TestStatus.SUCCESS:
+		counts.add_status(status)
+
 def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool, printer: Printer) -> Test:
 	"""
 	Finds next test to parse in LineStream, creates new Test object,
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index b74dc05fc2fe5b3ff629172fc7aafeb5c3d29fb3..d5bbcb95ab6abb1a8ee91439d87daaf29d159294 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -172,6 +172,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 		self.assertEqual(result.counts.failed, 2)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[0].status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.subtests[0].subtests[0].status)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].status)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].subtests[0].status)
 
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
index 2e528da39ab5b2be0fca6cf9160c10929fba3c9e..5498dfd0b0db24663e1a1e9bf78c587de6746522 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
@@ -1,5 +1,8 @@
 KTAP version 1
 1..2
+    KTAP version 1
+    1..1
+        ok 1 test 1
 not ok 1 subtest 1
     KTAP version 1
     1..1

-- 
2.50.0


