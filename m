Return-Path: <linux-fsdevel+bounces-66215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98461C1A2D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA161889F05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9842C343D8E;
	Wed, 29 Oct 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxgy3DIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9F33C503;
	Wed, 29 Oct 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740448; cv=none; b=s4vMfz5CANBQeqYiXBQHXUI908XUD6Cv1ZjvkTCGVbrIf5Pnea8boPZWoyvxmerTywYhvjoSGTcnbfrYmPx4QJSqdU8FLlfvIehX1YLu7Y5S35I5gnr7EzuUdhuFUBZqB34RufR2MUYiGAZVRwiIdc4/xSveuISJMIoBxCTAagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740448; c=relaxed/simple;
	bh=jSqJBpD/6utq5kB6r0uVAxUcKbpMKsXXqLyZPGG0ICk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZXYtHL0Ocdd2jGgpMH1Cd9FtMj/AuMK/pO8rsikl5X0LwWPOmKv3/0nnBxMlmpOzTCmnapc5yHDoWL326SW0nUrGT8IrhGM3Pf8LiFVhl3shDvpeheG8jzK73M8J+plTXrfRe9iCZDRO4eGLRf/Xr6shYwRHVQL6hXME+12158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxgy3DIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B312C4CEFD;
	Wed, 29 Oct 2025 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740447;
	bh=jSqJBpD/6utq5kB6r0uVAxUcKbpMKsXXqLyZPGG0ICk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qxgy3DIHqEwU4kquMlAwvKrC7PGGakpDD+e55kpDEdYHj1FBSQavXnYHK1KQ8Gviy
	 4GcNeqkSlso0Frx75ImXwblmzisT3iH/9jtMK+aCGZb5WJt/MWFl+Ehqb0HJvw01dM
	 YqO1M9G+vqSZrmwLuv79YrlJiivM03rhH7paXIsbu2r/bYzTV+Looq+1buC433Q99b
	 ldStNN3NaFVaHICj+tisPo7jat1SK5OpTijM/Z9guyksNw584BzGTcpUqioaiAHP4E
	 5CypqmkTTlUmOzhU7nIXAfpx2+AbimYrIMIuFbeeyv5WyyOq+/OOnwQTRIBPczGnzi
	 4RjCUNUoMyCeg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:15 +0100
Subject: [PATCH v4 02/72] nsfs: use inode_just_drop()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-2-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jSqJBpD/6utq5kB6r0uVAxUcKbpMKsXXqLyZPGG0ICk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfXcWZKpdvatI8dx39R3dosmVEcUzp7+fpqZ8bIE6
 9SlloZTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCL8jwz2SB9Ybk2nsf1cyV
 bi9p5bgz8+Oyr+4BslsL182/r7D8kQkjwyvXKxsOOa9l9fnQUemy85no9S23VzBvkDnZaH3s5BU
 JTl4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently nsfs uses the default inode_generic_drop() fallback which
drops the inode when it's unlinked or when it's unhashed. Since nsfs
never hashes inodes that always amounts to dropping the inode.

But that's just annoying to have to reason through every time we look at
this code. Switch to inode_just_drop() which always drops the inode
explicitly. This also aligns the behavior with pidfs which does the
same.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 648dc59bef7f..4e77eba0c8fc 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -408,6 +408,7 @@ static const struct super_operations nsfs_ops = {
 	.statfs = simple_statfs,
 	.evict_inode = nsfs_evict,
 	.show_path = nsfs_show_path,
+	.drop_inode = inode_just_drop,
 };
 
 static int nsfs_init_inode(struct inode *inode, void *data)

-- 
2.47.3


