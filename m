Return-Path: <linux-fsdevel+bounces-44205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE75A654D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393831896644
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE01D2459E9;
	Mon, 17 Mar 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gmv4leI9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A5241683
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223665; cv=none; b=V5oC7jmseVFno2MufYReJeeCohsJyVZcQaTiXSuCDF8GDV7yfxyBnVPIirDPnoayxivfoSKOZJ/cTmopdZCRDBt32QSLsKwfoVoaWCkO5JjP920EegI3MS1d2gacJSP6Rw/bSoxpMvlXml4LgsO+iwcLZxtBxGVpgy2umDyG0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223665; c=relaxed/simple;
	bh=QmBWPQQJVDx3m4A1a8PlLZA/cLmz00Dm+9yM+uCEonc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WelsJubYU7FKrA/6F+1O4o5pgxqxGl/Hoq6wF39DtP77nJ91oQ54Fb+Be0NGjPOi9N77ZTzt+R8hNzBqKAc6oFegtaiFqI7WOvyfPmtHqW8vl0I+XrhjUWfymdEtPC9ULMQaL9Axec9rTHRB89pnksag/S8Jttnc2G/xbn6CEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gmv4leI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40114C4CEEF;
	Mon, 17 Mar 2025 15:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742223664;
	bh=QmBWPQQJVDx3m4A1a8PlLZA/cLmz00Dm+9yM+uCEonc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gmv4leI9MpED+uotvm4MJHh4F6ACubXiRU9nGegrEY8ewjuJs88G343HBHBgRwGn7
	 QX/PJDj5vvtWWgvmD1cqwzcJE1mYg/kVln0NQ+E4DqR2URdbNm5vcBoCM0+z3BDVOL
	 2sEB7u5twq/zt0LThZiK/swm3jJ5O7+Lkv379iNozYlwiG2NJSPvOGeT71ZZqH7vXg
	 z++NU4/XmGARGKw5xTpVLybIh1wgOxpvrXcr/TqPrmy/slzmhMGWR39xPnqOJZim3E
	 6E1HByTy3+F4HPjw3fItrcViUGy+c+OghkX35i+wYy2HckuFytKbE5MSyE3tJafFFr
	 KyAXRr/0epRtw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Mar 2025 16:00:44 +0100
Subject: [PATCH RFC 2/2] selftests/pidfd: test multi-threaded exec polling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-work-pidfs-thread_group-v1-2-bc9e5ed283e9@kernel.org>
References: <20250317-work-pidfs-thread_group-v1-0-bc9e5ed283e9@kernel.org>
In-Reply-To: <20250317-work-pidfs-thread_group-v1-0-bc9e5ed283e9@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QmBWPQQJVDx3m4A1a8PlLZA/cLmz00Dm+9yM+uCEonc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfsNT6anw/1iKZ92xtms19h0+n9kR3HHHtj3nGv2z+o
 XAeG9Z3HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPhsGdk6JPQOOrzfanRHUfp
 szvT6iYbrpAsz1/g81+66sERk8vVcQz/HY4KLZ7SIDHx4JLDXjrc8T823rn13Oxpy6yUvYdzKtg
 u8QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that during a multi-threaded exec and premature thread-group
leader exit no exit notification is generated.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 09bc4ae7aed5..e9a0aaf63e26 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -428,21 +428,22 @@ TEST_F(pidfd_info, thread_group_exec)
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
 

-- 
2.47.2


