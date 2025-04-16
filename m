Return-Path: <linux-fsdevel+bounces-46544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44871A8B34A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 10:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC307444ED4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CB022B8B1;
	Wed, 16 Apr 2025 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa4QvCnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A926AEC
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791558; cv=none; b=ihbHz9LlSS3+wiuZwEGuUfU44Depn5MoEcTNDpa6FYCu+VfAqu7IIC5tEz60/r10AmIXoSVWN8sgScEZJhrpMXxL4vDWE0dgN1MMMV0+cDBBbI2h8+Qjr1sNIkTcIg0BBuTJ6zkNf3Dltf+Wt4RedAGMpT/N2IsUp8CD11a2s4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791558; c=relaxed/simple;
	bh=/nICFzUAb2nXJAQIQ299zKGqBSNp82GAeVnKMURzWHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=taoVAWHP48LcfUM1SFoSCyekOwOXgSOWBOhrwVKHZWkj8mZRn+SOiAYH0TziUgTzXt6ZAk/H0clqKdL1RhCi9FDmlxwoTtMOKydj+V1x2xh0x33wVGknA6nz/Cdrwtgc0YqmohvCLfCU6/QVjhfJ4Kia98XA0iTPtP2/yEeZngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa4QvCnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC1EC4CEE2;
	Wed, 16 Apr 2025 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744791557;
	bh=/nICFzUAb2nXJAQIQ299zKGqBSNp82GAeVnKMURzWHg=;
	h=From:To:Cc:Subject:Date:From;
	b=Oa4QvCnTHpBtgmz7+5F8dWUaXyxkBqbCdU/ZkCJvZlOSjH9/2PXEfe26BwIJxzClg
	 S7/BjQH+30GoNmchN3ncOHOjf7/sqQ20VL60319eHTKzf0jdDvMR8NJNKM6lkjcSOC
	 wP9lbXt6F13YRgAzlluDtXjFarzqga7ao5/cuVGE27QbSUHuScBZnWt9ZwF6UIgRfv
	 OksVslsMGunm8B/CQOE5lbE6dYCWsZYEF7P3bDqH3YQ2Lo9VaJAJ6CKIC1Hll8evI/
	 fojnA2VVzIew/zS7Y7XSO07cILFOmoU2WqYhI5MEjElwKBL8rhQpFPJEm3x0ITaeip
	 J7XM4R+hNBwWg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] mount: add a comment about concurrent changes with statmount()/listmount()
Date: Wed, 16 Apr 2025 10:19:05 +0200
Message-ID: <20250416-zerknirschen-aluminium-14a55639076f@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; i=brauner@kernel.org; h=from:subject:message-id; bh=/nICFzUAb2nXJAQIQ299zKGqBSNp82GAeVnKMURzWHg=; b=kA0DAAoWkcYbwGV43KIByyZiAGf/Z/ujt2YTXbJN+wmGytJGJBXTcDEaH3ISjyd9RXKBQMcoh 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmf/Z/sACgkQkcYbwGV43KK1/AD+OSHV WQlDOFaNoKGdbfnFvxcnm89eQWts+0H/VBp8ihMBAPSSUpvCIQA1qJrtB21a5wmUb0eSX19nYm6 bzmDQ2NME
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Add some comments in there highlighting a few non-obvious assumptions.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d9ca80dcc544..bc23c0e1fb9d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5839,13 +5839,29 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 		return err;
 
 	s->root = root;
-	s->idmap = mnt_idmap(s->mnt);
-	if (s->mask & STATMOUNT_SB_BASIC)
-		statmount_sb_basic(s);
 
+	/*
+	 * Note that mount properties in mnt->mnt_flags, mnt->mnt_idmap
+	 * can change concurrently as we only hold the read-side of the
+	 * namespace semaphore and mount properties may change with only
+	 * the mount lock held.
+	 *
+	 * We could sample the mount lock sequence counter to detect
+	 * those changes and retry. But it's not worth it. Worst that
+	 * happens is that the mnt->mnt_idmap pointer is already changed
+	 * while mnt->mnt_flags isn't or vica versa. So what.
+	 *
+	 * Both mnt->mnt_flags and mnt->mnt_idmap are set and retrieved
+	 * via READ_ONCE()/WRITE_ONCE() and guard against theoretical
+	 * torn read/write. That's all we care about right now.
+	 */
+	s->idmap = mnt_idmap(s->mnt);
 	if (s->mask & STATMOUNT_MNT_BASIC)
 		statmount_mnt_basic(s);
 
+	if (s->mask & STATMOUNT_SB_BASIC)
+		statmount_sb_basic(s);
+
 	if (s->mask & STATMOUNT_PROPAGATE_FROM)
 		statmount_propagate_from(s);
 
@@ -6157,6 +6173,10 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -ENOENT;
 
+	/*
+	 * We only need to guard against mount topology changes as
+	 * listmount() doesn't care about any mount properties.
+	 */
 	scoped_guard(rwsem_read, &namespace_sem)
 		ret = do_listmount(ns, kreq.mnt_id, last_mnt_id, kmnt_ids,
 				   nr_mnt_ids, (flags & LISTMOUNT_REVERSE));
-- 
2.47.2


