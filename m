Return-Path: <linux-fsdevel+bounces-46379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E883CA88488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E96716B897
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3361A2918CA;
	Mon, 14 Apr 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdaNTfp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F427A934;
	Mon, 14 Apr 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638916; cv=none; b=LYyUw9sN7np4IN1dBcZ9kYm0qzrIsXvNSfIKXxjCf3a5rA3sawbBUse9dNRvyT98WLAN7qw8z3DN+vsxtF5LNEZlI6XD1eWW93gX3n7LH7v7PNsD+d1fk0PbP++i876K3dOoHjHL9GEj2OdFcFLMobSh1HQE0/0sm1gnRT8prWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638916; c=relaxed/simple;
	bh=m9SucPDBiv57vDJTBiHL8Yu+1iS7jJDF3MNROUK+8qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uPYD6Ag8M8pxdyy5vP+/x6UbYs/Fl+da5aVHVCbTaBBbQN45VBwLVQLmJ+ZSeTIkruGKvfjetso1RlPV5RCBkrP/g777fp6REZ0Wwk7YdbYfzjACo5+kenkV4FND4ePWQk/iXkavovi44HhCRixnA+LY0DoZjfhFQMdGqjJfGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdaNTfp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9C8C4CEE9;
	Mon, 14 Apr 2025 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744638916;
	bh=m9SucPDBiv57vDJTBiHL8Yu+1iS7jJDF3MNROUK+8qQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SdaNTfp8Er4D+Ef6aQpurGQ2VvjvPcRhLY1bMuXFARBdP8Rl7/oXWMkSjeW4b7/fU
	 ZBsq8kAZF9QK3WAZgqzJmnMqMaTXmDkXsLUAQ5iv+m++Jjl8CA5G6WUyH0NFDEfPVe
	 kWBR3C5dpdxH4VIilXR+Ya/J4wpl0AwyawY/xGKwSpI081AQthCqCv3mstuF7enPom
	 x2ioWnfDVogI7yiyT3Qzjz3s3cp4c+Ee9FBoxahsC2U3u53jy/DYm2cdBwD1UxC5lp
	 PCaOk908wCBVzmM2vZaxIhtEsKxcWpPrVhV9SZEUkOPbpl1nfgSNxYUj6OnauUC4Gz
	 zddd7RBjrzbhA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Apr 2025 15:55:05 +0200
Subject: [PATCH v2 1/3] pidfs: move O_RDWR into pidfs_alloc_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-work-coredump-v2-1-685bf231f828@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m9SucPDBiv57vDJTBiHL8Yu+1iS7jJDF3MNROUK+8qQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/Fd7/bb2P99fAX+EfKhOauW6W5oczmi72yavXSV3k8
 yX7kOaNjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn842f4p6T4cPuVP8duyApt
 nS3xVPjA3rWifx1NNn/P/rqQ07U9rYyR4eFUn8VnwjQ4hDZv3OVst97ZhysvR7P9Z/ZH4envnv5
 7wQoA
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


