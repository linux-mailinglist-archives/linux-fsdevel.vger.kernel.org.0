Return-Path: <linux-fsdevel+bounces-65890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A04C139B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FFD5855CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9082A2E2EE4;
	Tue, 28 Oct 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVf0g1Aj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33992E2665;
	Tue, 28 Oct 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641206; cv=none; b=jVazlyrRWXvzq5aO7J+Xg5nooDrE/C0mpOLRxsJFGwiHHSISPT3EolfFA/s+1RMyfzvEd5yPZ3vX3kVioIxqVbq72teiXGjbcEtowDHc/yc1n2sYkMMQzSvt2QlJUAjQ0k1M6GRV+jsnLoFTKZdlStq5z23HpWByqxyegW0NBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641206; c=relaxed/simple;
	bh=hhfR84YF5lZTjazsMeCF8Xrlqvbl2cEysbsmUtLrx3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uyFCk6P2rM//GcYB6BQ7NwglX4GgGXtrP9IWbsdC9LuM+0gqpD1LSWdd/8qnAIiXm9IjlWoiVr7xwMY7mHsAKJRIt6uxv1MpVfK+9bfYa2V7+SaRc+u7HjPq/v777tnk4kY8r7kmxM0zmncPqHepMNKp3XLzWsKd6RMG5aQCMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVf0g1Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A32C4CEE7;
	Tue, 28 Oct 2025 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641205;
	bh=hhfR84YF5lZTjazsMeCF8Xrlqvbl2cEysbsmUtLrx3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DVf0g1Aj/lcgvXRH2S7/oytpHkW7+MGxwzeyVWxBsxjqwSoCVXIzWKJb9ucnugVaq
	 kKUzsW7p8nU1ps6B0oahs3dwXiCxAu0clV3UUoFH7rnOfMWF0XRhCqeu76C+9/0xGO
	 RpAMZLqXUs2FiB+dJ3uunvRgu7jlJLn34gjV25hldv4UyU8rh65us5Xerf5j8kazbH
	 LQwxWrofsolk+buB4n7JGPHaH7OsXvPF85ykmYfqDlKDLLOIbUroqUV2GKzpZ1Pcwp
	 trGxHdvX8YGs6zo0zqVzBQB8EChyKspxNWipiqreuFx/kcCKw0ZWRRhpl/QGWKvZcm
	 iksQJO/Xvdk7g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:55 +0100
Subject: [PATCH 10/22] selftests/pidfd: add first supported_mask test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-10-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=2041; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hhfR84YF5lZTjazsMeCF8Xrlqvbl2cEysbsmUtLrx3s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB36EHeqVnl/94z2lA6Js/8Pdb6YlS5abc5zOXEn8
 yM32+dlHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRfsjIMHnVG+tDWWxdD2qC
 eVQad+ydYnb8ls/ETTYyX82eLWw8uISRYUd7zc4qnt2vTq0/1ML1lWOn5+MXBQduNJ3lXr3y3R7
 OLA4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Verify that when PIDFD_INFO_SUPPORTED_MASK is requested, the kernel
returns the supported_mask field indicating which flags the kernel
supports.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index a0eb6e81eaa2..b31a0597fbae 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -690,4 +690,45 @@ TEST_F(pidfd_info, thread_group_exec_thread)
 	EXPECT_EQ(close(pidfd_thread), 0);
 }
 
+/*
+ * Test: PIDFD_INFO_SUPPORTED_MASK field
+ *
+ * Verify that when PIDFD_INFO_SUPPORTED_MASK is requested, the kernel
+ * returns the supported_mask field indicating which flags the kernel supports.
+ */
+TEST(supported_mask_field)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_SUPPORTED_MASK,
+	};
+	int pidfd;
+	pid_t pid;
+
+	pid = create_child(&pidfd, 0);
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		pause();
+
+	/* Request supported_mask field */
+	ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
+
+	/* Verify PIDFD_INFO_SUPPORTED_MASK is set in the reply */
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_SUPPORTED_MASK));
+
+	/* Verify supported_mask contains expected flags */
+	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_PID));
+	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_CGROUPID));
+	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_EXIT));
+	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP));
+	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_SUPPORTED_MASK));
+	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP_SIGNAL));
+
+	/* Clean up */
+	sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	sys_waitid(P_PIDFD, pidfd, NULL, WEXITED);
+	close(pidfd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


