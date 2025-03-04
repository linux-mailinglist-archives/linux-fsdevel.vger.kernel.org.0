Return-Path: <linux-fsdevel+bounces-43069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA4A4D901
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3B4167004
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44A1FF1A8;
	Tue,  4 Mar 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvjfiLuP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83931FC11A
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081306; cv=none; b=T+CpaE/7P9zXaR0jmc+HI1C1Mld6VG1cdEyjp27vNwnxAJKH6zzDFQ+IZ59T+UebmS9jfKFEqPWQfVCIZXsb0H2vajsuw8nhWcXA5H32wQRExpvJ0OWPOGdRL+AXCzBEMCPE0DTJXeQ0Dkx10RKUThkXYj4nFu08Upv9F3tl8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081306; c=relaxed/simple;
	bh=09EI8zIEUUfNNhCutUmrWMQ1gF9fbyxFdOpSnbEaNr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qreeDfH/yCtrqErH2i+svL3W8MVH+BMjKc1Sz4taHp4dY+xMvVw+dvfCr55DXNOwtGgXNr5PgVUeVH2dSctOzhJnD3ppfgbz9UDd0xVZ/XewaAU5IM7HyNbBDfootSKdPIrw/Z1nIzmd2OcIGgoVi0GZfwRpHebvj4d/+gtgUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvjfiLuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DBFC4CEE5;
	Tue,  4 Mar 2025 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081305;
	bh=09EI8zIEUUfNNhCutUmrWMQ1gF9fbyxFdOpSnbEaNr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EvjfiLuPprxlbC0eaW/7x/b2b6XTpOdbZXQ6Nz9Ik3Cpe/Ld90BJQTIi2Gj8hmuel
	 ugAL3kVL3rXUilszhanGwiNF2wyEXAw6070TBilwp9lIHFF2VBxSXq0XT70yiolDmK
	 OixA/m0h2OHK2UPDRK4V6z0r2es9U+3r14wWSb8Q1mI53A8+NjZJ9wZwN6lkjIK9hv
	 3zaoKv9iDANYpVqGHvGPrybBcTRA/UFRPoj9oSiVl/EF+uvdqUPVbQX9uS6aVfgfpj
	 reJMn4oFoCegZmvclNvtMIOeUlasYJrca41fTs9IixuJUHEovpJEGnvutidaXObFge
	 eo+/Sv9HQDjbg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:14 +0100
Subject: [PATCH v2 14/15] selftests/pidfd: add fifth PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-14-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=brauner@kernel.org;
 h=from:subject:message-id; bh=09EI8zIEUUfNNhCutUmrWMQ1gF9fbyxFdOpSnbEaNr0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7X76DmbJ2dXP9sRbtQ9faqE/9LJD91/B5a1lS4Xt
 ysyuVE1o6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi6i8Z/keKqm01S+v9m7HY
 aUXAPR3u/Z1zBRNu3T0yteusRNekjOMM/90VZq1idD64iPFj5Ta99ddfvlmW8HGCenhnt5Tg/Rs
 idfwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 0d0af4c2a84d..16e4be2364df 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -195,4 +195,27 @@ TEST_F(pidfd_info, success_reaped)
 	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
 }
 
+TEST_F(pidfd_info, success_reaped_poll)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT,
+	};
+	struct pollfd fds = {};
+	int nevents;
+
+	fds.events = POLLIN;
+	fds.fd = self->child_pidfd2;
+
+	nevents = poll(&fds, 1, -1);
+	ASSERT_EQ(nevents, 1);
+	ASSERT_TRUE(!!(fds.revents & POLLIN));
+	ASSERT_TRUE(!!(fds.revents & POLLHUP));
+
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


