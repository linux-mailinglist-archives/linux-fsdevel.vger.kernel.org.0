Return-Path: <linux-fsdevel+bounces-43067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EEEA4D930
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC54F3AE28A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED371FCF44;
	Tue,  4 Mar 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpaWyRtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA41F8BCB
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081300; cv=none; b=q2VgMvtJ+3fCAvFyPJ2h75RaDdPTQneMCtwRLArLWCO3u+/5g1hO/uN7+n2LOAQpKHE2temDzQJFEOCAS4XqJECS+Cx12TobgBR8E5XBbb/mQUePqgPu+W66nQ2YsQdtKxpkTqVngFpa6deFgbxEjMPHrDE7TmHTJHbj4G2PP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081300; c=relaxed/simple;
	bh=UGeeT2+jg9AmN+yurFJkqAxGf9SX4b826fWEeFpnTxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbL40DOulqFEG+SGX3tOPkpYqdkVhGLlrhynSdJeGYx9iL5ZK7E65EDcYZPvlfXpvzA8pYg/1AmIQjzyXUMHdt76e/MUknTdHJp3zZ4pm0DvIXGgGK5DLfA2H3BTskTeDYqtcpkUl3gbAdSxc9CBXw8pQzScrK9USCBDJtVUfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpaWyRtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2354C4CEEA;
	Tue,  4 Mar 2025 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081299;
	bh=UGeeT2+jg9AmN+yurFJkqAxGf9SX4b826fWEeFpnTxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hpaWyRtFBn0RgekdpN9tGowxSYZ72BVvdNE7LJY8IEBx5zYiaRWWegDVZ8KLKizzl
	 xAKKlfQUvh6giiWIDPin9hRBwZeNrCVKexrFgLLaSDwvWFWDpzZJC9Rz+UxofA6CsW
	 b1VozmzOR6tQ7cTNBO7IV8SlnNlwbrxPRngo+J2I5rnaLMGVAmqJoozH8PvWHrcSv+
	 helenOYTUkj0nsz0r/UKUcI+PbgTUO+TBZp6fESN9QVkZ9fSYMxqSToGWcbaLhuIjd
	 Gaz5m5dWRPXCCMASBvCiPLKsJN43na1U1jq+TCjWux6vyPLbM5befznKLuQr0NmjoR
	 DB+RrQ+BfKIIg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:11 +0100
Subject: [PATCH v2 11/15] selftests/pidfd: add second PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-11-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UGeeT2+jg9AmN+yurFJkqAxGf9SX4b826fWEeFpnTxE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7X77k5pu7LCGfllr8utvzr9yz9VX2osrvh1omTrb
 QWTyiNTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiYs7IcERo359atXDJ14fN
 vyaGnrlQq6KVX8hwr7t4g5BTTnOGMsP/eqEH217+vGInX8KSGvan8O++uF+fb8Y/X3x9zoKba6X
 DGAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index cc1d3d5eba59..2a5742a2a55f 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -143,4 +143,22 @@ TEST_F(pidfd_info, sigkill_exit)
 	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_EXIT));
 }
 
+TEST_F(pidfd_info, sigkill_reaped)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID,
+	};
+
+	/* Process has already been reaped and PIDFD_INFO_EXIT hasn't been set. */
+	ASSERT_NE(ioctl(self->child_pidfd2, PIDFD_GET_INFO, &info), 0);
+	ASSERT_EQ(errno, ESRCH);
+
+	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(self->child_pidfd2, PIDFD_GET_INFO, &info), 0);
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_TRUE(WIFSIGNALED(info.exit_code));
+	ASSERT_EQ(WTERMSIG(info.exit_code), SIGKILL);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


