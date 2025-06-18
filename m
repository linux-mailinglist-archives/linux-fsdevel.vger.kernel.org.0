Return-Path: <linux-fsdevel+bounces-52131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8A7ADF825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078481BC0D3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA17621FF38;
	Wed, 18 Jun 2025 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asO+IZ8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D021FF2E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280065; cv=none; b=V+epuec39IKJd0mU40XUjQLTr8qCHMYxIMtIwSeeSn8oJ1knGNFszLkXZgRxSUcX3bYlirShMU7tYFb5D2yHIebjbQRA2R13hdqIvCwB+gBvu15R5Pps4fumboWsD3/iK2bP1jJhbzsnXUsPnfqDRfVM4cVvwnUXuUrJbeSh178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280065; c=relaxed/simple;
	bh=Vo9JV0UIUMjl0OnfHIT1TOulKdAbz8FHc1cKUQprIG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npl6fc7SeFIQ3QfBAg2HZIAGByjNmsQ34osP+MjcrqTXdYSy41dfAu4WTl8IClBWW6sMOTkt6H+CAm0LyUG3/aFNGw+NBMxnCAJPyKgMTbD84+GtT7rcgX/45S7J2FuVM/0XIffDdzppBl1D63dFzRAhVqJxO0pGLo8LLAULhZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asO+IZ8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFF3C4CEEF;
	Wed, 18 Jun 2025 20:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280064;
	bh=Vo9JV0UIUMjl0OnfHIT1TOulKdAbz8FHc1cKUQprIG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=asO+IZ8yunqX9Rk0/xa/yCDrMmw9x+JzB32Qvo0BuiH72tQiRVcBA17cXdRJ32Sbf
	 hXaJCSBxtSA7Vwsz63mxAZ32fL0Mk82NED68ifnhkQ+IZ0FmlmjNC7nFTPUi10TISa
	 egN0wlz8fjaCEkB+UZSiHWcP0+5s/4iH7byeaYLoMOYfAi10PUFn6kVYqDmKFZWRF4
	 yj936GH885VGnOnr5SWUMGNXIJeCfTsUh3HDgMFVQ2yQ4WPdqyoXDfm5Cv/AOIDJcI
	 4Ur8IeqakK9rVuRx/8CRqJGqTxbDDA0YESRswo8c4s58BeULhUWYbpRSkQtUuBSE7i
	 qiGUveOswvPIg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:48 +0200
Subject: [PATCH v2 14/16] selftests/pidfd: test extended attribute support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-14-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Vo9JV0UIUMjl0OnfHIT1TOulKdAbz8FHc1cKUQprIG0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0d+OHr/i/79Bw4vg2+6Pf0Tzrhi8QxxE8uYM0uyb
 Q2XMmx/3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARxacMf8VenFrOJX854MOh
 8KwPLIfiI74+tLn2LHVh68Hpl4rms3QxMpxfdGW525f+7xri3yp2aQk3qn94UbH+RGqbY1oEu8T
 ytZwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that extended attributes are permanent.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_xattr_test.c | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_xattr_test.c b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
index 00d400ac515b..5cf7bb0e4bf2 100644
--- a/tools/testing/selftests/pidfd/pidfd_xattr_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
@@ -94,4 +94,39 @@ TEST_F(pidfs_xattr, set_get_list_xattr_multiple)
 	}
 }
 
+TEST_F(pidfs_xattr, set_get_list_xattr_persistent)
+{
+	int ret;
+	char buf[32];
+	char list[PATH_MAX] = {};
+
+	ret = fsetxattr(self->child_pidfd, "trusted.persistent", "persistent value", strlen("persistent value"), 0);
+	ASSERT_EQ(ret, 0);
+
+	memset(buf, 0, sizeof(buf));
+	ret = fgetxattr(self->child_pidfd, "trusted.persistent", buf, sizeof(buf));
+	ASSERT_EQ(ret, strlen("persistent value"));
+	ASSERT_EQ(strcmp(buf, "persistent value"), 0);
+
+	ret = flistxattr(self->child_pidfd, list, sizeof(list));
+	ASSERT_GT(ret, 0);
+	ASSERT_EQ(strcmp(list, "trusted.persistent"), 0)
+
+	ASSERT_EQ(close(self->child_pidfd), 0);
+	self->child_pidfd = -EBADF;
+	sleep(2);
+
+	self->child_pidfd = sys_pidfd_open(self->child_pid, 0);
+	ASSERT_GE(self->child_pidfd, 0);
+
+	memset(buf, 0, sizeof(buf));
+	ret = fgetxattr(self->child_pidfd, "trusted.persistent", buf, sizeof(buf));
+	ASSERT_EQ(ret, strlen("persistent value"));
+	ASSERT_EQ(strcmp(buf, "persistent value"), 0);
+
+	ret = flistxattr(self->child_pidfd, list, sizeof(list));
+	ASSERT_GT(ret, 0);
+	ASSERT_EQ(strcmp(list, "trusted.persistent"), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


