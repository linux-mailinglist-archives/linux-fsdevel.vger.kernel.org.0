Return-Path: <linux-fsdevel+bounces-44304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517B6A67055
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A5C188C3DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C688207E11;
	Tue, 18 Mar 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6xMtYb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708E207E0E
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291555; cv=none; b=rs+gaCnv7bq4sLVCEM49yU4U2iyL4pOERnCA5TyWFyOU19mNTO/yqDPs2UFTD2xtkYkmpDWt/wUV5mwcSFqiecIN2wRsC85T2DrXuej+XLPVwoK136j4ezAxF9LrGBCQidjUEJfvv/3sknIPIufGBIt9z2vk36ro7dylkq6iGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291555; c=relaxed/simple;
	bh=BjKAgkh2rS0T3SwX180fJnUH9jZJlezJNFeTeIdoUpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THr5JSjD/NdEpAtX2kdU7/LX5kFlHyc3rcddd7zeAWzbYNkeu4X35i59abjAQrk7T+HxrR4V99p1LqbTG08qjq4p3rEId1636UbGo2ZeqHObhu4EO1fypkjSc7n0Msrimx7cHPX9rDGu3QeQYogkenpQ8/DjYDnR8N2pwXa9w24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6xMtYb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2D1C4CEE9;
	Tue, 18 Mar 2025 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742291554;
	bh=BjKAgkh2rS0T3SwX180fJnUH9jZJlezJNFeTeIdoUpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J6xMtYb2772TbyU2G3dBbfaNXbS/2m8c2++kKrEDSdi5o48MchLtqWCX27dIsBwA2
	 4v3JqlP67TO8eKo9TCU6iy3EuV9cAUgDSUBhKmdmODmCOytUSJRLvlhgovILWHCN3m
	 DMvgXfxJDQVa5YRkNlda3dVYsOFD/+NQJ3zNNZ6sVUw5EJL5QNtdVtAGNm5/Z1C/kW
	 yDIVhTu9HWMwsFGY5+p2eZ9dLkByEdKo9qCjXHG0162oGqnCLYucelmcecMdXT5Xpa
	 q199fKi32x61xw0MyYHjsIO/+aVpVQa3MZ2/XQ0PB8kv0ghPup1SnSJc/q+1/pzQkB
	 mLak3ORzNzWlQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Mar 2025 10:52:17 +0100
Subject: [PATCH RFC v2 2/3] selftests/pidfd: first test for multi-threaded
 exec polling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-work-pidfs-thread_group-v2-2-2677898ffa2e@kernel.org>
References: <20250318-work-pidfs-thread_group-v2-0-2677898ffa2e@kernel.org>
In-Reply-To: <20250318-work-pidfs-thread_group-v2-0-2677898ffa2e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BjKAgkh2rS0T3SwX180fJnUH9jZJlezJNFeTeIdoUpM=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGfZQlqhc0ncoaqwjhsCrqZm8fw3kzwxMgMYWw/avuw2wvvfX
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmfZQloACgkQkcYbwGV43KJJpwD/caZt
 uHLd+7FZirbtMFkGsWMJNNdPY3mZTjbmFRJwNuUA/AnLFtli84DqhlmhBFXNzp1fmtdCRQ2olDh
 9OKcSvlgN
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that during a multi-threaded exec and premature thread-group
leader exit no exit notification is generated.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 47 +++++++++++++++++++------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 09bc4ae7aed5..f06b8e2f969a 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -428,26 +428,37 @@ TEST_F(pidfd_info, thread_group_exec)
 	ASSERT_GE(pidfd_leader_thread, 0);
 
 	/*
-	 * We can poll and wait for the old thread-group leader to exit
-	 * using a thread-specific pidfd.
+	 * We can't poll and wait for the old thread-group leader to exit
+	 * using a thread-specific pidfd. The thread-group leader exited
+	 * prematurely and notification is delayed until all subthreads
+	 * have exited.
 	 *
-	 * This only works until the thread has execed. When the thread
-	 * has execed it will have taken over the old thread-group
-	 * leaders struct pid. Calling poll after the thread execed will
-	 * thus block again because a new thread-group has started (Yes,
-	 * it's fscked.).
+	 * When the thread has execed it will taken over the old
+	 * thread-group leaders struct pid. Calling poll after the
+	 * thread execed will thus block again because a new
+	 * thread-group has started.
 	 */
 	fds.events = POLLIN;
 	fds.fd = pidfd_leader_thread;
-	nevents = poll(&fds, 1, -1);
-	ASSERT_EQ(nevents, 1);
-	/* The thread-group leader has exited. */
-	ASSERT_TRUE(!!(fds.revents & POLLIN));
+	nevents = poll(&fds, 1, 2000 /* wait 2 seconds */);
+	ASSERT_EQ(nevents, 0);
+	/* The thread-group leader has exited but there's still a live subthread. */
+	ASSERT_FALSE(!!(fds.revents & POLLIN));
 	/* The thread-group leader hasn't been reaped. */
 	ASSERT_FALSE(!!(fds.revents & POLLHUP));
 
 	/* Now that we've opened a thread-specific pidfd the thread can exec. */
 	ASSERT_EQ(write_nointr(ipc_sockets[0], &pid_thread, sizeof(pid_thread)), sizeof(pid_thread));
+
+	fds.events = POLLIN;
+	fds.fd = pidfd_leader_thread;
+	nevents = poll(&fds, 1, 2000 /* wait 2 seconds */);
+	ASSERT_EQ(nevents, 0);
+	/* The thread-group leader has exited but there's still a live subthread. */
+	ASSERT_FALSE(!!(fds.revents & POLLIN));
+	/* The thread-group leader hasn't been reaped. */
+	ASSERT_FALSE(!!(fds.revents & POLLHUP));
+
 	EXPECT_EQ(close(ipc_sockets[0]), 0);
 
 	/* Wait until the kernel has SIGKILLed the thread. */
@@ -482,6 +493,20 @@ TEST_F(pidfd_info, thread_group_exec)
 
 	/* Take down the thread-group leader. */
 	EXPECT_EQ(sys_pidfd_send_signal(pidfd_leader, SIGKILL, NULL, 0), 0);
+
+	/*
+	 * Afte the exec we're dealing with an empty thread-group so now
+	 * we must see an exit notification on the thread-specific pidfd
+	 * for the thread-group leader as there's no subthread that can
+	 * revive the struct pid.
+	 */
+	fds.events = POLLIN;
+	fds.fd = pidfd_leader_thread;
+	nevents = poll(&fds, 1, -1);
+	ASSERT_EQ(nevents, 1);
+	ASSERT_TRUE(!!(fds.revents & POLLIN));
+	ASSERT_FALSE(!!(fds.revents & POLLHUP));
+
 	EXPECT_EQ(sys_waitid(P_PIDFD, pidfd_leader, NULL, WEXITED), 0);
 
 	/* Retrieve exit information for the thread-group leader. */

-- 
2.47.2


