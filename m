Return-Path: <linux-fsdevel+bounces-46347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AADA87C79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 11:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D01166604
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C89B268FDE;
	Mon, 14 Apr 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc8ckTZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741826869D;
	Mon, 14 Apr 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624440; cv=none; b=NfPIYfRgMotQeHG9jQMiW1QTodz37dJbhP0RcvsRW8Qcsx76yNraLYWYKG7g1g5Hz8nvRwDcsq5npOUfkyRQE9okxM1ufp1Q40UoXTqgVkuv6wM+fhnlIJNe3Rz41IiijYt+00IVvwq7+ZyV/xqR91wmYBCWkJTeawZks4IUgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624440; c=relaxed/simple;
	bh=m9SucPDBiv57vDJTBiHL8Yu+1iS7jJDF3MNROUK+8qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgcZ+LIfjYv8pU3urQ0IpolqL43LS9MJOs3KFmOxh/Bbbo3TTmrHS0nEIItWBWsWvy/7pfIAByt+J65eRhFsv9KzBCSNQPVmwYvLCK5SlxOFUNuJHFErE3Udzn9wRaSPmava2hl48AKU6QbOrkt9LJYNy0BVqAY9eGJy00Ybfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fc8ckTZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B5C4CEEB;
	Mon, 14 Apr 2025 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744624439;
	bh=m9SucPDBiv57vDJTBiHL8Yu+1iS7jJDF3MNROUK+8qQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fc8ckTZ/SfzFNkOryUV5xlexdLBpVcIYXA2pp9lFG0A7uKvit1zRy0dfLuohd+6ZN
	 /2fl76carqTlfHKuxwxy821zHZMY3p7Zbq1EqSH2W1ar4baYUay8QaEYMzhYak6NqX
	 Lg5S62x/FqfGDbi+vrMhA4gPR6Tzh5/GepYxezks6L9FJl1G0AVK5GHKA1XkvUoGx1
	 LDziGqR32d/EoEHBS1nJLHdomwVIb1qgqTBWnbKxTA6P6w0H+ScnptbcyMeEUnj34y
	 6Z2nq9agBaWAX8c+rJ3JVaKbb/dJtFzThHrRFXoCiCS7wDnX26Thkj86UPKkeQGyJ4
	 PceUbox4hgv4g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Apr 2025 11:53:36 +0200
Subject: [PATCH 1/3] pidfs: move O_RDWR into pidfs_alloc_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-work-coredump-v1-1-6caebc807ff4@kernel.org>
References: <20250414-work-coredump-v1-0-6caebc807ff4@kernel.org>
In-Reply-To: <20250414-work-coredump-v1-0-6caebc807ff4@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m9SucPDBiv57vDJTBiHL8Yu+1iS7jJDF3MNROUK+8qQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/uW3ctC82gn9fJDf7KxfjFr2t/6qzDP++9Gh/5hTG+
 T/xndjDjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8tWFkaFqscaZ3b8J0Wc3Z
 ER5aDzeYZxZE/lr5+MH6068cfyzlkGT4xSS5n3uTY+O2ZuNJ3hEfHLe4V2krlb+OTPjePGfGNsM
 CHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since all pidfds must be O_RDWR currently enfore that directly in the
file allocation function itself instead of letting callers specify it.

Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c    | 1 +
 kernel/fork.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index d64a4cbeb0da..50e69a9e104a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -888,6 +888,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 		return ERR_PTR(-ESRCH);
 
 	flags &= ~PIDFD_CLONE;
+	flags |= O_RDWR;
 	pidfd_file = dentry_open(&path, flags, current_cred());
 	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
 	if (!IS_ERR(pidfd_file))
diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd8998b..d184e51196a2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2071,7 +2071,7 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 	if (pidfd < 0)
 		return pidfd;
 
-	pidfd_file = pidfs_alloc_file(pid, flags | O_RDWR);
+	pidfd_file = pidfs_alloc_file(pid, flags);
 	if (IS_ERR(pidfd_file))
 		return PTR_ERR(pidfd_file);
 

-- 
2.47.2


