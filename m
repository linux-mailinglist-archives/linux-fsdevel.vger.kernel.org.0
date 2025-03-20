Return-Path: <linux-fsdevel+bounces-44575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E4A6A727
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AE9189BCA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EC2221704;
	Thu, 20 Mar 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3MR5Ibh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF91DFE00
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477061; cv=none; b=gz3ib44q91SZYwDU2HmdmucLhoqKolLfS8TbwbqFZX4PDHZYvorVYOn3BRkGL14hzpUpJ3cXyc4fj0nb9bgJ9wnWADU8iuFfFw8dICLV1pkam65cFdv7evndSjGpfbTecb6bxmJF1j8Zv5hSBkA8xl15bi4Yn0M9XG4lPfkt4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477061; c=relaxed/simple;
	bh=nbqWaPaXqyDnB0HDQ1wL/80R9Ma05kzOsoIHnfmrKKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQClOhYt8EPdCyVSafhwyDxdy9CYpczGAu4tXpKhRxbxf7w+af3FkalT1bDNcPbef+167O40uu2yMs/FTZVjoZch8NNz9Q/YpiQKADHxF8sdwy98pGdLxVDV30j7OBj/9qyVaEIT/u8PtLF3oMyNeWESOy2ZQ/FyjoJNbavsdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3MR5Ibh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00CDC4CEDD;
	Thu, 20 Mar 2025 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742477061;
	bh=nbqWaPaXqyDnB0HDQ1wL/80R9Ma05kzOsoIHnfmrKKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f3MR5Ibhd2l+kn1XAlXC9u4BxOCgL9hW/IoqJfqcKvrWbPIIOXsrUZAXif+lfzMML
	 UCi919NexzlKHrEB7t95V/71lXEZGVLoaaPDbWhcNpjbhannJuYN7xCzAmQdq2s6mI
	 OubaWPAuBGmTwqMYXKAmgHKxlmv0961JUGayCMK11BC/UY1tN6px2Ortpw2qGkuId9
	 3OR0Ui0qCVRAhCgWexPN2xmQEVPxyz4aFoI4RWWz58LAo4cksG7ImWivOmVf7+gjAd
	 akI0lhEn3cuSzcC3EEWVeNFKnJhG1yNsx9RKDdob3le5S6LGZ5+WdweHq5MQeNYkNk
	 OY8o2PzFq62yA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Mar 2025 14:24:09 +0100
Subject: [PATCH v4 2/4] selftests/pidfd: first test for multi-threaded exec
 polling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-work-pidfs-thread_group-v4-2-da678ce805bf@kernel.org>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
In-Reply-To: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nbqWaPaXqyDnB0HDQ1wL/80R9Ma05kzOsoIHnfmrKKY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfEfsnP/9yvGZfauZsZQuhA0Uy1k+/6HY1efx4KWvDx
 13/r0O7o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLHQxn+17KppTiVxkhtt97x
 2OHJP8u3z/7d+/hS/ebBGAYd/w6rKYwMV5kEteLqpTMSQmo/Gq10zTfxm6E35cj+ns6AEp9H+3f
 xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add first test for premature thread-group leader exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 38 ++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 09bc4ae7aed5..28a28ae4686a 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -236,7 +236,7 @@ static void *pidfd_info_pause_thread(void *arg)
 
 TEST_F(pidfd_info, thread_group)
 {
-	pid_t pid_leader, pid_thread;
+	pid_t pid_leader, pid_poller, pid_thread;
 	pthread_t thread;
 	int nevents, pidfd_leader, pidfd_thread, pidfd_leader_thread, ret;
 	int ipc_sockets[2];
@@ -262,6 +262,35 @@ TEST_F(pidfd_info, thread_group)
 		syscall(__NR_exit, EXIT_SUCCESS);
 	}
 
+	/*
+	 * Opening a PIDFD_THREAD aka thread-specific pidfd based on a
+	 * thread-group leader must succeed.
+	 */
+	pidfd_leader_thread = sys_pidfd_open(pid_leader, PIDFD_THREAD);
+	ASSERT_GE(pidfd_leader_thread, 0);
+
+	pid_poller = fork();
+	ASSERT_GE(pid_poller, 0);
+	if (pid_poller == 0) {
+		/*
+		 * We can't poll and wait for the old thread-group
+		 * leader to exit using a thread-specific pidfd. The
+		 * thread-group leader exited prematurely and
+		 * notification is delayed until all subthreads have
+		 * exited.
+		 */
+		fds.events = POLLIN;
+		fds.fd = pidfd_leader_thread;
+		nevents = poll(&fds, 1, 10000 /* wait 5 seconds */);
+		if (nevents != 0)
+			_exit(EXIT_FAILURE);
+		if (fds.revents & POLLIN)
+			_exit(EXIT_FAILURE);
+		if (fds.revents & POLLHUP)
+			_exit(EXIT_FAILURE);
+		_exit(EXIT_SUCCESS);
+	}
+
 	/* Retrieve the tid of the thread. */
 	EXPECT_EQ(close(ipc_sockets[1]), 0);
 	ASSERT_EQ(read_nointr(ipc_sockets[0], &pid_thread, sizeof(pid_thread)), sizeof(pid_thread));
@@ -275,12 +304,7 @@ TEST_F(pidfd_info, thread_group)
 	pidfd_thread = sys_pidfd_open(pid_thread, PIDFD_THREAD);
 	ASSERT_GE(pidfd_thread, 0);
 
-	/*
-	 * Opening a PIDFD_THREAD aka thread-specific pidfd based on a
-	 * thread-group leader must succeed.
-	 */
-	pidfd_leader_thread = sys_pidfd_open(pid_leader, PIDFD_THREAD);
-	ASSERT_GE(pidfd_leader_thread, 0);
+	ASSERT_EQ(wait_for_pid(pid_poller), 0);
 
 	/*
 	 * Note that pidfd_leader is a thread-group pidfd, so polling on it

-- 
2.47.2


