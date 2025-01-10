Return-Path: <linux-fsdevel+bounces-38856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0D6A08D6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B963A48F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0B20ADC1;
	Fri, 10 Jan 2025 10:09:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFC20897E;
	Fri, 10 Jan 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503748; cv=none; b=Rh8/G6p3UWcNhx6/NChPq4LaUOIexUe1g4RN14YYW7uHeZARsAYWmZ4oWP3/GuZuS8o2IqcQnXx4zQGc+Y9N5hKoYIJI5sXJFkq3KBv4iOqkrNbnalXtxbM8rC6iOX9bbU/QaLSGdJD34LnK/z9b/PmZIxC2udvq6NK23LO7k3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503748; c=relaxed/simple;
	bh=Re+PJd0upQgRWp7IjD8Fc0/D02buhbxrqEUWGNxoOtA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tPhxoZo5E6jYhn3nZ4efU0Hp5mf71oY4IlDtgMZAIE2sIG3eQwVfx1wopYDCqHfXa9b30UtQLBJJg8sxZkB8/lN4wNNzkCVXQ89l6lNjFeZlzKH2Mz+5jVXjKL/UFSqfM0NELhDk1fzKnnpTvXcawDmdOZ2+UZ8QX+CwjdFmCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id IDS00050;
        Fri, 10 Jan 2025 18:07:50 +0800
Received: from localhost.localdomain (10.94.7.238) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 10 Jan 2025 18:07:49 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <kees@kernel.org>, <joel.granados@kernel.org>, <logang@deltatee.com>,
	<mcgrof@kernel.org>, <yzaikin@google.com>, <gregkh@linuxfoundation.org>,
	<brendan.higgins@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, Charles
 Han <hanchunchao@inspur.com>
Subject: [PATCH] kernel/sysctl-test: Fix potential null dereference in sysctl-test
Date: Fri, 10 Jan 2025 18:07:48 +0800
Message-ID: <20250110100748.63470-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20251101807508cf8ab416532f75e0a7909c57abca0f8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

kunit_kzalloc() may return a NULL pointer, dereferencing it without
NULL check may lead to NULL dereference.
Add a NULL check for buffer.

Fixes: 2cb80dbbbaba ("kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 kernel/sysctl-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 3ac98bb7fb82..8c13bcff0127 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -35,6 +35,7 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 	 */
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	size_t len;
 	loff_t pos;
 
@@ -81,6 +82,7 @@ static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
 	};
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	size_t len;
 	loff_t pos;
 
@@ -124,6 +126,7 @@ static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
 	};
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	/*
 	 * However, now our read/write buffer has zero length.
 	 */
@@ -158,6 +161,7 @@ static void sysctl_test_api_dointvec_table_read_but_position_set(
 	};
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	/*
 	 * We don't care about our buffer length because we start off with a
 	 * non-zero file position.
@@ -194,6 +198,7 @@ static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
 	size_t len = 4;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	char __user *user_buffer = (char __user *)buffer;
 	/* Store 13 in the data field. */
 	*((int *)table.data) = 13;
@@ -225,6 +230,7 @@ static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
 	size_t len = 5;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	char __user *user_buffer = (char __user *)buffer;
 	*((int *)table.data) = -16;
 
@@ -255,6 +261,7 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
 	size_t len = sizeof(input) - 1;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	char __user *user_buffer = (char __user *)buffer;
 
 	memcpy(buffer, input, len);
@@ -285,6 +292,7 @@ static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
 	size_t len = sizeof(input) - 1;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	char __user *user_buffer = (char __user *)buffer;
 
 	memcpy(buffer, input, len);
@@ -316,6 +324,7 @@ static void sysctl_test_api_dointvec_write_single_less_int_min(
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	char __user *user_buffer = (char __user *)buffer;
 	unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
 					     - (INT_MAX + INT_MIN) + 1;
@@ -354,6 +363,7 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 	char __user *user_buffer = (char __user *)buffer;
 	unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
 
-- 
2.45.2


