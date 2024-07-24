Return-Path: <linux-fsdevel+bounces-24196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95B93B16A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 15:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06121C20A09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B3A158D6F;
	Wed, 24 Jul 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlqryrKP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047CA157A59
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826974; cv=none; b=ij3FXrrZPqTLXQgY7Fhs7Zxx7Tkx/a5noP6lwAALj0EJpErKungb82gYBFHqrGUcOh3RrAx8vs5gTzGCQ3X0mZwrdE5m9VTQT2Rdblw8kBfwrJhshswc/kqywJ1fyqly1g+nDOdtkVb4q/e3gxUPGBs5KUJWgZe3E3a2DoSVtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826974; c=relaxed/simple;
	bh=g8ZLzfmQSWkJjjqaQK685NC71Sd+8iNOeRGNnwffJDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwBe1fxviFupiVwVaWTZ2h0x951DMeT8p0VmDAySE1pMqLc1uJb6LbcAFkwwHjGwaL0ujcvSmT0QqnyUkn7ULO1EKyAJdG0qNsFXLzwIBu6ADZL529oMjmBx9my0nIe64823KHXBJee8vKcRfhv7N2tW9+aLfWZBB07a5eT4SCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlqryrKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD418C32782;
	Wed, 24 Jul 2024 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721826973;
	bh=g8ZLzfmQSWkJjjqaQK685NC71Sd+8iNOeRGNnwffJDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VlqryrKPDFYuv5KNr+iaKmXOupzWR0WI0yzcLGD4bWuEF6ZP7ga9ziDRxVubrjcwc
	 pRrbDtox02FwRfnazyOL4zt2/7ks9OIQ1R0+SJsBp5XKifxZDuxdBpzufblLs8bUoo
	 UvOnSm9ssYKARMIP5YjhDhWNY5Mh3xFFhimOxzShYHrsNyk/V7LnE/LAoTqAfZsic6
	 aJ3fUp21kev2zPYicVCdDP0ZUxzMCDdCJRrdONSzr1y4tYMdMtGprLdr1z/xIr9CBe
	 aLGZLJbsbfvmWu6CXhNE/N0/RQOVVMHVeSgqc3qtnozuEch40z1ixdHDIqacs2XbBM
	 07heC7p0IgYIg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 24 Jul 2024 15:15:36 +0200
Subject: [PATCH RFC 2/2] selftests: add F_CREATED tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-work-fcntl-v1-2-e8153a2f1991@kernel.org>
References: <20240724-work-fcntl-v1-0-e8153a2f1991@kernel.org>
In-Reply-To: <20240724-work-fcntl-v1-0-e8153a2f1991@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g8ZLzfmQSWkJjjqaQK685NC71Sd+8iNOeRGNnwffJDU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQt+DdtcwHX650aJ9PezZl0+Pax1AzHOY3l6W/k9hvtU
 w//PCFsY0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEbF8z/GSsOfs+IXVSoOUV
 pZJdipJf7vDctq3+dvHY5db903lnPNnJ8D/i8ZolR4Q8vjx4vkGYiXG/mN2q75r8Ifv3RtRuTGW
 OEOECAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add simple selftests for fcntl(fd, F_CREATED, 0).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/core/close_range_test.c | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 991c473e3859..3cd50246ab64 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -26,6 +26,10 @@
 #define F_DUPFD_QUERY (F_LINUX_SPECIFIC_BASE + 3)
 #endif
 
+#ifndef F_CREATED
+#define F_CREATED (F_LINUX_SPECIFIC_BASE + 4)
+#endif
+
 static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 				  unsigned int flags)
 {
@@ -589,4 +593,39 @@ TEST(close_range_cloexec_unshare_syzbot)
 	EXPECT_EQ(close(fd3), 0);
 }
 
+TEST(fcntl_created)
+{
+	for (int i = 0; i < 101; i++) {
+		int fd;
+		char path[PATH_MAX];
+
+		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return,
+					   "Skipping test since /dev/null does not exist");
+		}
+
+		/* We didn't create "/dev/null". */
+		EXPECT_EQ(fcntl(fd, F_CREATED, 0), 0);
+		close(fd);
+
+		sprintf(path, "aaaa_%d", i);
+		fd = open(path, O_CREAT | O_RDONLY | O_CLOEXEC, 0600);
+		ASSERT_GE(fd, 0);
+
+		/* We created "aaaa_%d". */
+		EXPECT_EQ(fcntl(fd, F_CREATED, 0), 1);
+		close(fd);
+
+		fd = open(path, O_RDONLY | O_CLOEXEC);
+		ASSERT_GE(fd, 0);
+
+		/* We're opening it again, so no positive creation check. */
+		EXPECT_EQ(fcntl(fd, F_CREATED, 0), 0);
+		close(fd);
+		unlink(path);
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.43.0


