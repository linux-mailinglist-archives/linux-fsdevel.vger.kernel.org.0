Return-Path: <linux-fsdevel+bounces-43070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0890FA4D900
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B1A166A80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26D1FF1A7;
	Tue,  4 Mar 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up4W/a3X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F31FCFC1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081306; cv=none; b=plkuys8C0CLNExQiB8J8XVhAU2E8+4lVKqnAT3d9V2e/jHgMEIcf3Qg4Ql/bD3Ek3GrZMiUBPmmqw8J4iBynTTjOESW6MJfxvpfY30s8lsB7+5j0LaMbXRWxGim4LDTgJqDwCSMtGctcJhwaTnazpinnAQmvLwyef4z1BZtMB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081306; c=relaxed/simple;
	bh=FhKNsJ55OVok6P5QTIj8iE3Kv7bGxeoGFF0N6sn7W4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WsndNm+3vI8qLW0eniLWIQG87R9SRsjVBoha4o04Px8EKr/n6ytZLSXtEHcARJ/wvMpggJaGnbzy1KXjs3v/S8UmXAxszqjbWAdW/fduy+XUpLzsVk156Awrz1ce8IOiZLpm6gDu0W5Nehz/rFnrZfLfTm55plYZ0SyCpigEexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up4W/a3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAACC4CEE8;
	Tue,  4 Mar 2025 09:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081303;
	bh=FhKNsJ55OVok6P5QTIj8iE3Kv7bGxeoGFF0N6sn7W4I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Up4W/a3XSxTaBPpRfZ2BVVhIv2BGqxg1QATZ7qn0JjaMkDy8VUz+xLVwjdaGdTSvS
	 Hr/nAetqAmTMnS6ae939ke5Oswn+VxNngy1aqIFk8Gw3jZRuBcNx3hvtkAlVzot1fZ
	 iLH4FTQdg/W+lNcuBmuFGVHXqmpB2U2zPUuZHb9vtBD0MHYgS3rZTBRLe1tyaeQRCt
	 647hVxdy3VbY23VZWR22Xogf0iDt1W/9SGmK6I5R5mfnDaAx/t+hHIH+mJr4jWbal7
	 O23Up0qJ6PvCLxWJ0M+baD8iEGuPeHj4ZqqWmdDTfq82lcRFKZfDFY7EQA8UqklowI
	 37cc9OgYwNuyA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:13 +0100
Subject: [PATCH v2 13/15] selftests/pidfd: add fourth PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-13-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FhKNsJ55OVok6P5QTIj8iE3Kv7bGxeoGFF0N6sn7W4I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7V7iZRzza042ZUn7BfqH4lWeflApPvpMeNl8bsVu
 D/EGDk+6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIqxvDP6XJB27Wz9jzPl9b
 YO0u56dxd18L9zNwvmheeZZhb3Re71lGhi4ZrsakXWGh9/QCLyQznlu1fc2NWY+ea72yu1CY9//
 dZQ4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 2917e7a03b31..0d0af4c2a84d 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -177,4 +177,22 @@ TEST_F(pidfd_info, success_exit)
 	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_EXIT));
 }
 
+TEST_F(pidfd_info, success_reaped)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID,
+	};
+
+	/* Process has already been reaped and PIDFD_INFO_EXIT hasn't been set. */
+	ASSERT_NE(ioctl(self->child_pidfd4, PIDFD_GET_INFO, &info), 0);
+	ASSERT_EQ(errno, ESRCH);
+
+	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(self->child_pidfd4, PIDFD_GET_INFO, &info), 0);
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


