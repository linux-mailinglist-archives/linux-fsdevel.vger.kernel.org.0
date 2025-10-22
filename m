Return-Path: <linux-fsdevel+bounces-65130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C278BFD067
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38FC7354DAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3643C27A92E;
	Wed, 22 Oct 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry4UA73k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985B270551;
	Wed, 22 Oct 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149176; cv=none; b=Npwxyi5ImD7R5+C2KZ9CziAom1mdRABz5KwmjtY4FvE7YBoNDlFYemf1qphbiGKw7yNFbUHTfqVJn71nKCvifvb1gn/hbgTk0A/RllfHGf/QRMO83Trjp/NpeGBg0NtHXrF8MeE03bXstG5qpJHV2dPDspy490Y28sABtaptErs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149176; c=relaxed/simple;
	bh=jSqJBpD/6utq5kB6r0uVAxUcKbpMKsXXqLyZPGG0ICk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qx0+6lGDd9ovnfjZu/uhEwNMixpy/F8L6NynM2C1Iw+fmEx5yTVDbFUJaHEPlORMbOAV8F4IeA0uPVaoNWrQ8jit/LLilW3j3KZtH3hcNTg6wbL73Tyanmb/OAb8SeoQ9UKiF8zJ7PRTDiAz3SfuFBcuzUiwAVmSlM+BMqeXvSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry4UA73k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2FBC4CEE7;
	Wed, 22 Oct 2025 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149175;
	bh=jSqJBpD/6utq5kB6r0uVAxUcKbpMKsXXqLyZPGG0ICk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ry4UA73kSbdXLE+Gf3T5AwqY/95tXQMz1bsUuxLLsSzE8AKeVZYI9+ZnBolHlxOG4
	 2pstUVcm9PhrDImoQrhTz/MjefbJnaINdtLXBJmKNewZSv4x1+8zxPYacy+fMFasiE
	 dXH8F8rgSBEhrgmY4mQvoZIA80KHTmh6nDSvC6uOsWaL3TDLz6DsRY5ZN6KQKKAUEO
	 dMmvLX7gL/U5U1LVN5o5GaT12pMA2hyhkaP9sossuRvwrwg01d5iA7vbK+1zSVKwbt
	 pvjEZLv95Syu2CgiQljIttmcD2zJLeoFzX52NczofEwRv5odcwDAVchwiIhg/FS2SH
	 ssXYBtIesnIGg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:40 +0200
Subject: [PATCH v2 02/63] nsfs: use inode_just_drop()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-2-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHhy/PN2txU3Lkk/LgneGnNT5fbLiv/br81WkP1ew
 5EWHqV6o6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAifv6MDE8UGn305JkE81Yo
 szW3ZfXka8luMamt1FtyTunw/GV/TjD8T45Ylr+lbplOTpfsvljXItUDXfKz3te9UJ4xbZL8jhI
 jdgA=
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


