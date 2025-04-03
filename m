Return-Path: <linux-fsdevel+bounces-45650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2CA7A4B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769967A4AD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3229250BF2;
	Thu,  3 Apr 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frt0k7Yg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE7250BFA;
	Thu,  3 Apr 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689376; cv=none; b=qFhg9otyEsbZlVenVuLNRlBpcS2wx8fVLoBN5gRTIj1Z10XyFlSIuKeblP/qvSrXHn3HSpOdvywsgRiaepLgs1WzesDYftbGQdy/kzITsmU0NzsqRnbQcGrUViBh5+m9rzbHPZo9e4+oU3zKerlVLHcE2vEHymY8/T9QMD6KUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689376; c=relaxed/simple;
	bh=53J++gz+TCTYRmafMVzYi//xpml2Oz7uWzyQxKxRxJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4L0Un7gzYbUDyL5jXd4U7hHFnR8nckHIwFArL829LxJJpHgNiR1D8ZhRTRCCXtTG3yOWZ5iZEJG6/yJGZiv3+TkbdSUpdsAy8l55kwBLIiMQxlJYyaP1y15pnjoGt/aUKVT4uQchOwvLIHjL4xmhbSJ4CEG8GxkUpYQpTsiM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frt0k7Yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA545C4CEE7;
	Thu,  3 Apr 2025 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743689375;
	bh=53J++gz+TCTYRmafMVzYi//xpml2Oz7uWzyQxKxRxJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=frt0k7YgIGe91bFv8s4Me3sKaKdIRZayJRHNcQINy6q6p/Oxz5TZYAbXEoUCMM5Fn
	 spsFfP9zETgVY6VYSC4eOCeZ2x5FjuFNMrYADtYvLMBV6Xl1ZFU69/ZEL7SzqkACY0
	 bzQ37gZ93AfTrz1wP9Oo3g2DZGRCrmb7afPCEYbfCjXneFHXUxDu5sstIk56CBRSF2
	 +FKrKEOiOGjujcXYh+pxeKLaeJIUCOdv33TAGtejluCTpcuM3SR0/Jyrv50nEKUlWT
	 a1v/E1G7A2QVeND4c9nz/GzNaq8XVaj31b7tv0J17xWGazacvSmkr+VTfQJSIn/byA
	 R6mqAO43zDYYA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 03 Apr 2025 16:09:04 +0200
Subject: [PATCH RFC 4/4] selftest/pidfd: add test for thread-group leader
 pidfd open for thread
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-work-pidfd-fixes-v1-4-a123b6ed6716@kernel.org>
References: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
In-Reply-To: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=brauner@kernel.org;
 h=from:subject:message-id; bh=53J++gz+TCTYRmafMVzYi//xpml2Oz7uWzyQxKxRxJA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/mzYl8ti8+3dP9BZ6LSq99O/ttW2dF1M/8v+YXjxVw
 4ArxeP45o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJSDcwMhw9KDxZ5ZDNi3nT
 rJx00sPOu6osMIzLe9A/mXPWTLOAw9cZ/inc28N3Z/f5/9en3kixfPJ4ITdLoJy+s87licVn2v+
 ULWMCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Verify that we report ENOENT when userspace tries to create a
thread-group leader pidfd for a thread pidfd that isn't a thread-group
leader.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index accfd6bdc539..a0eb6e81eaa2 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -299,6 +299,7 @@ TEST_F(pidfd_info, thread_group)
 	/* Opening a thread as a thread-group leader must fail. */
 	pidfd_thread = sys_pidfd_open(pid_thread, 0);
 	ASSERT_LT(pidfd_thread, 0);
+	ASSERT_EQ(errno, ENOENT);
 
 	/* Opening a thread as a PIDFD_THREAD must succeed. */
 	pidfd_thread = sys_pidfd_open(pid_thread, PIDFD_THREAD);

-- 
2.47.2


