Return-Path: <linux-fsdevel+bounces-45647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE253A7A4CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068E117741C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0038424EF9C;
	Thu,  3 Apr 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOUGLWj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C724EF7B;
	Thu,  3 Apr 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689369; cv=none; b=KRBOfekoGQ429fPE9mQUW4vCQEi1x2elOMTaMwbYDRf/mGTzCadUxpJZQOGFV+ONktcSvaoXkmKfSiRk9lP3sOm5WRxVdvLqhNUe1BDGiC+IGrcV/Ek0k26hCgWnsdNYTDhWAVAl9OvuJCz/3vmvHapwCvdg2k+GOk8ez8v5L6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689369; c=relaxed/simple;
	bh=ZzuxcT1XLOPfDbGYVrNXdQHSopuVtW+vn8bRWuQfVV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j19FdaYbpD0cpJrZB77gMpzVztFNxQpjq20Z8vv9ThQMsEnkRLxg7LDAxBBDSy+BGddFtla4dn5ZbW1X1Hazhz7lGTnOt/v+NCkYjmAo6HDCNWurO+yLDtmq/Gc7KSL2o8Qdq8+gwEO+tmSgazJcygRDXRlETIe8bjE+vC5XY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOUGLWj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1058C4CEE7;
	Thu,  3 Apr 2025 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743689368;
	bh=ZzuxcT1XLOPfDbGYVrNXdQHSopuVtW+vn8bRWuQfVV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WOUGLWj8a0j65A8qo40tEyTE03xemv3Gt1dfSjGByZ6PYe/Sujyb2kY25M9ALoHSi
	 vZaA8VsDVA8LKoCtCzfHI/532+p0Rbm5MZtZsaDEIq2uW+bEHDDHEIivK1g+q6cmqI
	 XyFc/3/sfCbcIg6Yfyz11SF1c0EG7CF++6N5pBbKoap+hnYj4wigEs+K5otcfnfIcu
	 1nbSBWJj3Z2UehWP13bmaxphTTHQdvEKyMKX/GVutgb4qYkDqs8iX+w+GfCQImfiJG
	 0bz+R0vj5JLKh9SQRbCUiLjdXAmQxa2o9v8dI7xKIenQN51JwVvSzPFM41pL7h+d0v
	 We04Qia7sa+SA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 03 Apr 2025 16:09:01 +0200
Subject: [PATCH RFC 1/4] selftests/pidfd: adapt to recent changes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-work-pidfd-fixes-v1-1-a123b6ed6716@kernel.org>
References: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
In-Reply-To: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZzuxcT1XLOPfDbGYVrNXdQHSopuVtW+vn8bRWuQfVV8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/mzYlM4k7IH75o+0x6RbMCXe1BXLS9/g+sj+U0xm04
 55Cvty/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkoVDD8937657KArn7emrJD
 O3RWdOupTpz77+tppeTvTZ5sJ986HmdkeLbZI71buXSuwHeX9pQPAXL3F5m9Up06XXCfzKRv2tY
 KDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Adapt to changes in commit 9133607de37a ("exit: fix the usage of
delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()").

Even if the thread-group leader exited early and succesfully it's exit
status will only be reported once the whole thread-group has exited and
it will share the exit code of the thread-group. So if the thread-group
was SIGKILLed the thread-group leader will also be reported as having
been SIGKILLed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 1758a1b0457b..accfd6bdc539 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -362,9 +362,9 @@ TEST_F(pidfd_info, thread_group)
 	ASSERT_EQ(ioctl(pidfd_leader, PIDFD_GET_INFO, &info), 0);
 	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
-	/* The thread-group leader exited successfully. Only the specific thread was SIGKILLed. */
-	ASSERT_TRUE(WIFEXITED(info.exit_code));
-	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
+	/* Even though the thread-group exited successfully it will still report the group exit code. */
+	ASSERT_TRUE(WIFSIGNALED(info.exit_code));
+	ASSERT_EQ(WTERMSIG(info.exit_code), SIGKILL);
 
 	/*
 	 * Retrieve exit information for the thread-group leader via the
@@ -375,9 +375,9 @@ TEST_F(pidfd_info, thread_group)
 	ASSERT_FALSE(!!(info2.mask & PIDFD_INFO_CREDS));
 	ASSERT_TRUE(!!(info2.mask & PIDFD_INFO_EXIT));
 
-	/* The thread-group leader exited successfully. Only the specific thread was SIGKILLed. */
-	ASSERT_TRUE(WIFEXITED(info2.exit_code));
-	ASSERT_EQ(WEXITSTATUS(info2.exit_code), 0);
+	/* Even though the thread-group exited successfully it will still report the group exit code. */
+	ASSERT_TRUE(WIFSIGNALED(info2.exit_code));
+	ASSERT_EQ(WTERMSIG(info2.exit_code), SIGKILL);
 
 	/* Retrieve exit information for the thread. */
 	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;

-- 
2.47.2


