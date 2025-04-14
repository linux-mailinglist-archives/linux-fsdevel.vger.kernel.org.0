Return-Path: <linux-fsdevel+bounces-46380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842CA8844C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F927A334B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6B292925;
	Mon, 14 Apr 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn8fTQvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C8292908;
	Mon, 14 Apr 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638920; cv=none; b=EeujgIuuut51OicCrL/ejeGJnFs52mXrqVP/jU+SjJrWaIQJpe+C8Zmnvr4LGpgZaugxcZLq6BK+YbICDP/99f6pm+v44/QqkaVL24X6a0B1K6OkCrCdCspzvSqgT7kCTGVCKsl6NC/zwMwXBsM7un1wC+YXX0NiQV0yEibCiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638920; c=relaxed/simple;
	bh=t853+Rl8SnkvdNKiDLYL23jkVep5KqIlNkpAgl3fzGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEMP1vCxwC9DClpQBg2hk3Q1MEHnZI2Pyg4ffRpMQeuGI1a3V+hAeV3kwmLN+m+gunWCWHbKR7dWtLmdE/zI6jAwL0RPSg6gWGn2VHQd0CnVnCxdoMch4oUWGXe/pgQE7ACVRUX2UFTg7r1cnGoKEF7l2ihMaXu+qGpDCytWtr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn8fTQvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F21C4CEE9;
	Mon, 14 Apr 2025 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744638918;
	bh=t853+Rl8SnkvdNKiDLYL23jkVep5KqIlNkpAgl3fzGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qn8fTQvTceVOiAVrTp02akclWqABBbFlZG9y9krwl5yJA2CzuJTRBoGJWhSZm1ZU6
	 tVsCVIXmYHJuy6VTgm03hEGdjgZVjHcxeIj+3hFiCYDUPz70hMOOz/hG4LdRy2sCuZ
	 488LALPwrkDjxdh1pDhilLnCgzFCrc+tICU3f8CM9w7ITcEO7V6h0XYCsP7BXmyoI6
	 7swZ1TPQAOB4+xLmfqx7cBxzvqHDbAW5c+7OGUpNvMuQbfufZcdeK3+GyrnKp1Hj2/
	 c0/lCR6HSgWWnKUkJ0Kx+icwRZ5czq5IPLGnmaig86km+KlhHxhBM2JXeRK4L+xqOs
	 w+zxd9cIqt/lA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Apr 2025 15:55:06 +0200
Subject: [PATCH v2 2/3] coredump: fix error handling for replace_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-work-coredump-v2-2-685bf231f828@kernel.org>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
In-Reply-To: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t853+Rl8SnkvdNKiDLYL23jkVep5KqIlNkpAgl3fzGU=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGf9E7+h7dWzk8nkJJD8Sy5bkQqcEy5DCwK/zVRzQSbmGksBN
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmf9E78ACgkQkcYbwGV43KLTTQD/WIKd
 o7GNrheZQO8PFRMgTmSbF4eBndkxBDE12uSr6jABAMuhkPvXRsQhZZe5J1kRYWgsmeG+bWwTE+a
 qMW91rvAG
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The replace_fd() helper returns the file descriptor number on success
and a negative error code on failure. The current error handling in
umh_pipe_setup() only works because the file descriptor that is replaced
is zero but that's pretty volatile. Explicitly check for a negative
error code.

Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index c33c177a701b..9da592aa8f16 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -507,7 +507,9 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct file *files[2];
 	struct coredump_params *cp = (struct coredump_params *)info->data;
-	int err = create_pipe_files(files, 0);
+	int err;
+
+	err = create_pipe_files(files, 0);
 	if (err)
 		return err;
 
@@ -515,10 +517,13 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 
 	err = replace_fd(0, files[0], 0);
 	fput(files[0]);
+	if (err < 0)
+		return err;
+
 	/* and disallow core files too */
 	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
 
-	return err;
+	return 0;
 }
 
 void do_coredump(const kernel_siginfo_t *siginfo)

-- 
2.47.2


