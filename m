Return-Path: <linux-fsdevel+bounces-45649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8BA7A4D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270C43BAA83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13124F5B5;
	Thu,  3 Apr 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpwD7OJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DD2505DD;
	Thu,  3 Apr 2025 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689373; cv=none; b=AFoY0BJ/RwWNymQYjwslrJvqln6/K86obaAOOQhp8LqBFZOOs2g7UpeMxqKZp0K39yiz85cxCNX5M5wB4VsTzdP4CKpfKPwwN2PcGCJzUFbykWnniT4vaEgiJLtpY8q4gnNoVbumCgvnmCH+V1xobLZUv/MsSPGq4UTu5uXmTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689373; c=relaxed/simple;
	bh=QvbAwm5Gaz6F+109uenJnQiiApV7n787OOSRTih5yF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c52+iy8GF4y76QgZAGpJFpWK9Bz65sZIzMvBvnWiKGuVWN6PRgXBynrKAfT1ajZV1ghdKjFigxvwH9DFIZvMPf5J9DmjqVraQzz8ALujJWtIIMIwpnlOLljyyllQS6Ll4b4cShR19uXsGsaJzOjGXsIYU7k0mBevdZhfBtrlpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpwD7OJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F59FC4CEE3;
	Thu,  3 Apr 2025 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743689373;
	bh=QvbAwm5Gaz6F+109uenJnQiiApV7n787OOSRTih5yF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IpwD7OJQT5VXBFYeT2NyeLzc5WgRnX/cZiMjKEZtHIqkBo57FipdQ9b5mXuv/DjuG
	 XjnO/Wr4OrPGSMsGBz5nyYu1LfJJCKcPxk164zMX5D12Mi4LxgyHOUmcDl2ou/wIKy
	 4WB0TRSouWlP/5PnwGWIj6Ml8RvwwD9qLyCFUWmp9yUK3eNnLBAtIbsZDROdc5MxXC
	 eJeT7buylxcYzyJqC/oXHnnhbT30xbVAe3NJ94hCbCMReVdPhOX6ifSfVUU6FQAGqD
	 NHLiTxZFO4niIw1RBZUmFq63NN3vMW/xU5g29+ocWRzQnA22VhqMfX/PeeE+mvv82W
	 CXzPrqQul0vYg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 03 Apr 2025 16:09:03 +0200
Subject: [PATCH RFC 3/4] pidfd: improve uapi when task isn't found
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-work-pidfd-fixes-v1-3-a123b6ed6716@kernel.org>
References: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
In-Reply-To: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QvbAwm5Gaz6F+109uenJnQiiApV7n787OOSRTih5yF8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/mzblR+bzRX9LHeJ6X0w62X35nHBM2L0farp3A1mn+
 zB86Hk4r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiIiaMDEcY2OSW9BiznN2+
 VFcqfrW1E9+s09tOXPW0VX3WIJJU+Yrhfy63iVgg29tJl9PK5++2kv0cz65qv/pvWtHp1ZUNaz5
 JMQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We currently report EINVAL whenever a struct pid has no tasked attached
anymore thereby conflating two concepts:

(1) The task has already been reaped.
(2) The caller requested a pidfd for a thread-group leader but the pid
    actually references a struct pid that isn't used as a thread-group
    leader.

This is causing issues for non-threaded workloads as in [1].

This patch tries to allow userspace to distinguish between (1) and (2).
This is racy of course but that shouldn't matter.

Link: https://github.com/systemd/systemd/pull/36982 [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/fork.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 182ec2e9087d..0fe54fcd11b3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2108,10 +2108,35 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	bool thread = flags & PIDFD_THREAD;
+	int err = 0;
 
-	if (!pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID))
-		return -EINVAL;
+	if (!(flags & PIDFD_THREAD)) {
+		/*
+		 * If this is struct pid isn't used as a thread-group
+		 * leader pid but the caller requested to create a
+		 * thread-group leader pidfd then report ENOENT to the
+		 * caller as a hint.
+		 */
+		if (!pid_has_task(pid, PIDTYPE_TGID))
+			err = -ENOENT;
+	}
+
+	/*
+	 * If this wasn't a thread-group leader struct pid or the task
+	 * got reaped in the meantime report -ESRCH to userspace.
+	 *
+	 * This is racy of course. This could've not been a thread-group
+	 * leader struct pid and we set ENOENT above but in the meantime
+	 * the task got reaped. Or there was a multi-threaded-exec by a
+	 * subthread and we were a thread-group leader but now got
+	 * killed. All of that doesn't matter since the task has already
+	 * been reaped that distinction is meaningless to userspace so
+	 * just report ESRCH.
+	 */
+	if (!pid_has_task(pid, PIDTYPE_PID))
+		err = -ESRCH;
+	if (err)
+		return err;
 
 	return __pidfd_prepare(pid, flags, ret);
 }

-- 
2.47.2


