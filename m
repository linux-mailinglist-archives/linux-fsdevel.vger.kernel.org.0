Return-Path: <linux-fsdevel+bounces-55220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0903B08846
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88C34A58F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726BD289E0E;
	Thu, 17 Jul 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Og6qufiN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YeWwTP1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FA283144;
	Thu, 17 Jul 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742145; cv=none; b=NaJx16AASByx/NkgzD+Vb++g7R8na7ESDRLfrVm1EHrEfWrvfhtuTQiZjBwvzXHUNz73313Prs3g9VdDVvZANXPXmrC6lsFOvOEnOPI7ahBxnMx/AhrU2dpgO7hLu87EtMB4PAy1s7TlvnowQBR8FxPZtjjvCTyNyH8BvZqe29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742145; c=relaxed/simple;
	bh=nqksscqfXqyzTU4syNyfSYS0rZFgGTiiZdVYjcMKiOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOcKDTtN5j8PV9eHzJ7uWf7aDZ4YLfwpLYfxmwqZY1hBTagHHLmorFSHtJ5FFfxuyndUexWFnEMQhJ+TwJFM502DDE7EVTfmjQpglspfVmYinccIfCDKzzXu/KPGRCpjXCimW9icbSRwXt5Vj/piJ4cN6yOcESMs0vl2VxyN5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Og6qufiN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YeWwTP1h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGd8ubbWunkfJYLzTiQIqN4TppaArb7LyPstVl7gkvQ=;
	b=Og6qufiNQGQTQ57NkCHKoAAm7powCJgw7/RWO2qGF/jlRkLSrtw6iDwzo1vFuCIIijprke
	q0p5sJrXCLfKMmRDpYJDkQe/vCAAvfE/2Jiw/pf2g5NComZY0tnnhoXAJruDo246m0vcje
	XYQrXubbI9mIqvGpNrqCEENSMoAfFuO1iZ24o9GRVesA75TnCHM7J8r8bBazzX3G92ApYy
	bYrT1owphkLuKVLDI0OMlkrhXyTpNjPBieMANT95fRTsEI+k5e1lL/V1WSWgkg43WLlWDX
	M5OeZGEcM++g/Q+/F7AJ2/ZjtBejS5aSB0jLRDENJKPkOWiyonO3OsYeD1lOHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGd8ubbWunkfJYLzTiQIqN4TppaArb7LyPstVl7gkvQ=;
	b=YeWwTP1h32iVhGidFWcm+PUWWjNidVPw2Cr1BbPavgIbdVuqStheDJKKB3UdfkblaqVOh8
	v9i3kGjHnBZUNHCw==
Date: Thu, 17 Jul 2025 10:48:11 +0200
Subject: [PATCH v5 09/15] kunit: tool: Parse skipped tests from kselftest.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-9-442b711cde2e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=2829;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=nqksscqfXqyzTU4syNyfSYS0rZFgGTiiZdVYjcMKiOU=;
 b=Zq1mrbjSt+Zlq8ZjnVSL9Jo84/acvktNqayzm+LN1XPYXkxZ3xwwYilhJUXi7lj0rBygEeyvS
 W75qBTLoW7+CefyuYY2haaSY20fRRc00PlYkDHUKhWcMuAA+xgTM75/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Skipped tests reported by kselftest.h use a different format than KTAP,
there is no explicit test name. Normally the test name is part of the
free-form string after the SKIP keyword:

	ok 3 # SKIP test: some reason

Extend the parser to handle those correctly. Use the free-form string as
test name instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py                             | 8 +++++---
 tools/testing/kunit/test_data/test_is_test_passed-kselftest.log | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index a7a61e627e348db14b953080ec8789994fba955a..5338489dcbe48c01912c5e8f02a481d6860a5d15 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -352,9 +352,9 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
-TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
+TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+) ?(- )?([^#]*)( # .*)?$')
 
-TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
+TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+) ?(- )?(.*) # SKIP ?(.*)$')
 
 def peek_test_name_match(lines: LineStream, test: Test) -> bool:
 	"""
@@ -379,6 +379,8 @@ def peek_test_name_match(lines: LineStream, test: Test) -> bool:
 	if not match:
 		return False
 	name = match.group(4)
+	if not name:
+		return False
 	return name == test.name
 
 def parse_test_result(lines: LineStream, test: Test,
@@ -416,7 +418,7 @@ def parse_test_result(lines: LineStream, test: Test,
 
 	# Set name of test object
 	if skip_match:
-		test.name = skip_match.group(4)
+		test.name = skip_match.group(4) or skip_match.group(5)
 	else:
 		test.name = match.group(4)
 
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
index 65d3f27feaf22a3f47ed831c4c24f6f11c625a92..30d9ef18bcec177067288d5242771236f29b7d56 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
@@ -1,5 +1,5 @@
 TAP version 13
-1..2
+1..3
 # selftests: membarrier: membarrier_test_single_thread
 # TAP version 13
 # 1..2
@@ -12,3 +12,4 @@ ok 1 selftests: membarrier: membarrier_test_single_thread
 # ok 1 sys_membarrier available
 # ok 2 sys membarrier invalid command test: command = -1, flags = 0, errno = 22. Failed as expected
 ok 2 selftests: membarrier: membarrier_test_multi_thread
+ok 3 # SKIP selftests: membarrier: membarrier_test_multi_thread

-- 
2.50.0


