Return-Path: <linux-fsdevel+bounces-43233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025EDA4FB4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD640188B36B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B42063D8;
	Wed,  5 Mar 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czVwMHlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF22063DA
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169334; cv=none; b=NguLSRrnHAeR1OSohmD5wmRgovsA8ELfF9xKAosLrFeRni1xhqFZiJlcGYVDbvsmOaw7Ozx03IDLEVq3HjI7EtD1YKHFaYg3576QgV4cPp8YjK/IVNqk+1Qp1ta/aYnjdtq4+h50AequC87Sti4iaWCG6P5lL6n+ukHonRu5GP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169334; c=relaxed/simple;
	bh=wwARZbNS6jnmacvDGKl5nDtXqnIvAP/pwPRnxTqY0WE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUZxuxNCJSrkR4vfKLDnVK+x8n9mv6+2A48TPTvdIrDheVKpSmPsXZ18leecoLFNrU4WLQ7Ai1stS5MVbWQNtgV3OhOc7Az+K9mJYc/Lxwr6ObJq7QTdltViVZ2s+S19/6ItG1PVS8KelLD4HsZs87olf7sYe3HJ3BGjLvPpR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czVwMHlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62887C4CEE9;
	Wed,  5 Mar 2025 10:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169334;
	bh=wwARZbNS6jnmacvDGKl5nDtXqnIvAP/pwPRnxTqY0WE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=czVwMHlZumCHlwyJ5jayW1mSDkEu8umYrkmDRSVpYwmKk/QS3Cwpc2xhYVNPP1xw5
	 8B6TrJ+JKSIMK3g+UEtw99uNMDDqHLJMdmPrX0GKh9QSZRFyiRLfI4VQr32eHhbymF
	 NC4HaB40aS+p5Te2cdlwpb2FSaz6xr3gT+r3146JnqQwnjEk42J1rH9brGl8uG76CA
	 2eEZn46i5BMdPqMke9FcQk73QupHZbldpRzoU61MBXieCDVbpEgCNRgxPS14wBmr7m
	 XCrGm8GNo8+DDzlxSKbh7UOqResj/XGyq9vVoK1EQETVYzhQuRbtcF7n9r8jfugYBj
	 99dBGY2RXTdMw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:23 +0100
Subject: [PATCH v3 13/16] selftests/pidfd: add fourth PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-13-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wwARZbNS6jnmacvDGKl5nDtXqnIvAP/pwPRnxTqY0WE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJqx//nJm9ybzvsaO2Rmut2822PAzHJhrYJmjZtET
 jrH/3itjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0VTH8z6heNDlEx89AQVLl
 ruKN0Ev9d5oObl4Q822HgarWxbdR9xj+V7LtTws8uJh9yRqVkIK2zS/Di6Yf8r0WPi++3yfbPcq
 GFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-13-44fdacfaa7b7@kernel.org
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


