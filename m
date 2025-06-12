Return-Path: <linux-fsdevel+bounces-51469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6D8AD71D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D4D17C68A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891EB23CF12;
	Thu, 12 Jun 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOnuUSm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994B2441A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734747; cv=none; b=GEqxFKIq8Zcu3by+dS+BwD/jICtKErTc+vDC1r8jhFGKHbmbc1fPJA6miTROR5cjiSG+gTnDWevvJAVkZaZyrYxJ2FX4kJDm7HdXYBY5WCjyVvgW9vsVZIszKbogru7OaJP5mHuJolJ+8YEPUfhZiSm+Xy5qCUAH8EbeUxxM8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734747; c=relaxed/simple;
	bh=dW8Ti0TuufgKOPQ1D37cohA5L3wamC9EhyFwQXcLXso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqTN+TpcGDFwieG7/mSXvqQ5aOkTnwhCyxSdCIr8WOv6jUH8EaiwrYUkQ++fNSyYjE8HJwMqoSVPUykG4jXOwt8qg7X9Q/svnm6CXQVkduFYK6M55YYFgJ5o+HrG3ehXIF7u3jt0jr2EJJAN64fYUs6YLOZGJwNdW8jrN3HJxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOnuUSm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424A7C4CEEE;
	Thu, 12 Jun 2025 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734746;
	bh=dW8Ti0TuufgKOPQ1D37cohA5L3wamC9EhyFwQXcLXso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hOnuUSm9PORpqx0z8ku1m1J7eXoCBkfbCXNEo6K4Uy4iI8Qviy10g4DVWjxmqCF58
	 xPPJt3o4G7hewrdteoZBiiq+JdSApKtzVNJkaUc6bNBtbCiHAZhfNbh8BpLjhhgGix
	 HX6xg2gXozmay11F76UCYULE3ti954OOg70EF9KnaEdpYS/W6d8r233w9o7IN+wNgF
	 PGZa6tuwh7h4BCiOj6FcPM/8SCNvp+6LEDPjP2cqUsByc+q7PuVRRu1rrZcj4fafLu
	 H3pbZrPKNFvxU4czMU5uTPIRb377X8MYRjHkizThVp7seLPrdMIdXew1GG9XGu4mhj
	 LmAyavTDuB7Ww==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:22 +0200
Subject: [PATCH 08/24] selftests/coredump: make sure invalid paths are
 rejected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-8-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dW8Ti0TuufgKOPQ1D37cohA5L3wamC9EhyFwQXcLXso=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXVXeVJvUs/67Z32gcjCnbFntQ9UKK66UZBzjvdDT
 oqoQaBYRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER6FzL8r10yW48l9enx6sT7
 91RuTdqfc6qkb+eumOSHa6I8G7sOL2ZkeNLwSMf4p9S90GXs1xa84RYLP5Fr3OLifov13cNYIfk
 YNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/stackdump_test.c | 32 ++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index 9a789156f27e..a4ac80bb1003 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -241,16 +241,19 @@ static int create_and_listen_unix_socket(const char *path)
 
 static bool set_core_pattern(const char *pattern)
 {
-	FILE *file;
-	int ret;
+	int fd;
+	ssize_t ret;
 
-	file = fopen("/proc/sys/kernel/core_pattern", "w");
-	if (!file)
+	fd = open("/proc/sys/kernel/core_pattern", O_WRONLY | O_CLOEXEC);
+	if (fd < 0)
 		return false;
 
-	ret = fprintf(file, "%s", pattern);
-	fclose(file);
+	ret = write(fd, pattern, strlen(pattern));
+	close(fd);
+	if (ret < 0)
+		return false;
 
+	fprintf(stderr, "Set core_pattern to '%s' | %zu == %zu\n", pattern, ret, strlen(pattern));
 	return ret == strlen(pattern);
 }
 
@@ -1804,4 +1807,21 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
 
+TEST_F(coredump, socket_invalid_paths)
+{
+	ASSERT_FALSE(set_core_pattern("@ /tmp/coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@/tmp/../coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@../coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@/tmp/coredump.socket/.."));
+	ASSERT_FALSE(set_core_pattern("@.."));
+
+	ASSERT_FALSE(set_core_pattern("@@ /tmp/coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@@/tmp/../coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@@../coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@@/tmp/coredump.socket/.."));
+	ASSERT_FALSE(set_core_pattern("@@.."));
+
+	ASSERT_FALSE(set_core_pattern("@@@/tmp/coredump.socket"));
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


