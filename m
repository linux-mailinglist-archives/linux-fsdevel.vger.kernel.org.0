Return-Path: <linux-fsdevel+bounces-55217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041AAB08841
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15621A61145
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F5288CBD;
	Thu, 17 Jul 2025 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c4InLabs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ddBrI2MT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFF1D7984;
	Thu, 17 Jul 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742145; cv=none; b=n6GYna89k3t9YzElwNva/No5YgrR1ytr4FwwY70DNPfzgDaO5/5/JR1WdbuyEW10GBTpVtlFZb80JiLduKNkp3b3qRpfF/uDwmK1iT+zo1hYONBAi2EI6bSNyWtprYQv90FogZ9YU1aQKLuzAlkYDH7qbHTDplgYa5M+82JWls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742145; c=relaxed/simple;
	bh=yVjZBovVFYRelPKtg1fQMKDDpGxbxaYJbTiXbrwq7Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFyZCUnASBft5A/EY8p8FBn+qVik9Fi/NIdg5D4nFXoywC63IEZjY9XIG5YkGJ0cDB8V/TtsZD5Lfla8IAnyZbVQhaXgucUxlK2apAUxS5A8JiPWfXQaAQVCST39TCLT7YgK9Pyfz5KsCYS+sp06+49Q4PM5vHf4CkJ4++d5L6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c4InLabs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ddBrI2MT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28EngJ2RMDboH1kPF4R/YHxhFvguWtCe6+9usWrMNYU=;
	b=c4InLabsGxInUfJEVc4VHN+M7m9gY7FaVq4Fh87mEtQeVsGS7aGcVw2ftFFcKW7J26QtV5
	hDXIK95Ot9w5B2rQxkIOiYwLuMgRNlFbB4EmiB+LBeU4Px9dNLsNmXXxEKsYkn3Ny/7g/7
	Dq5fIk6EIxiHUkTcWTN7al+Dd7zZeNkqSxAFFXXrtwPCwbH6DoqGphJebGJXOcsqo2a2Ze
	K7EYYttIQnUMPv2q6CVmYxbYS/96TPEHXbBY9p03Ngq2W/06oIlYrRD3dq6/twUF99qo3v
	2c0ZTBOYO1th581QFz2mXoHZ55KTwlqTb7n/W+/uCSk/rNH4rkWr2ldCz3zJnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28EngJ2RMDboH1kPF4R/YHxhFvguWtCe6+9usWrMNYU=;
	b=ddBrI2MT61kbAKq9OFyxCJ9PR3IsugoRkN2Y0EuYU4DRHe3S4fOgCdN+H2GdaeBRbmaACo
	onKl+M/WN/9jDmAg==
Date: Thu, 17 Jul 2025 10:48:09 +0200
Subject: [PATCH v5 07/15] kunit: tool: Add test for nested test result
 reporting
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-7-442b711cde2e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=2264;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yVjZBovVFYRelPKtg1fQMKDDpGxbxaYJbTiXbrwq7Ao=;
 b=4Rrhad+4zQdJ2WFKLGxo3krskqwms12O3XlbFK00zw7rCvDGjBSyqv5SNZW3aB1Xu4ynOqiRl
 xpmXlFDkWVhAaEiQgCJwSMO3zlaMRuGoxR6q/z+TdQfJMmqfa8aXr4J
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently there is a lack of tests validating the result reporting from
nested tests. Add one, it will also be used to validate upcoming changes
to the nested test parsing.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_tool_test.py                         | 10 ++++++++++
 .../kunit/test_data/test_is_test_passed-failure-nested.log     |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bbba921e0eacb18663abfcabb2bccf330d8666f5..b74dc05fc2fe5b3ff629172fc7aafeb5c3d29fb3 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -165,6 +165,16 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
+	def test_parse_failed_nested_tests_log(self):
+		nested_log = test_data_path('test_is_test_passed-failure-nested.log')
+		with open(nested_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
+		self.assertEqual(result.counts.failed, 2)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[0].status)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].status)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].subtests[0].status)
+
 	def test_no_header(self):
 		empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
 		with open(empty_log) as file:
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
new file mode 100644
index 0000000000000000000000000000000000000000..2e528da39ab5b2be0fca6cf9160c10929fba3c9e
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
@@ -0,0 +1,7 @@
+KTAP version 1
+1..2
+not ok 1 subtest 1
+    KTAP version 1
+    1..1
+        not ok 1 subsubtest 1
+not ok 2 subtest 2

-- 
2.50.0


