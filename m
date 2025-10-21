Return-Path: <linux-fsdevel+bounces-64853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22397BF6205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC85A464EE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B183328F5;
	Tue, 21 Oct 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnhNCayn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBA32ED40;
	Tue, 21 Oct 2025 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047039; cv=none; b=I2FPnOXXDjsFLLdy5uD1Cjwans1UnnoCthaHvv2OzFNnPc1uitqactF6gxmwzmB45n53KkHp5Ct5f7ZB65FAmla6lKZO9zde8Q5mHzoqfsPtTRYzOOs1J212gIAa72LGGTwJ9CpZLwnCjuMBXwmmjVLWtkzK/G2UuHMQXlDYVL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047039; c=relaxed/simple;
	bh=jSqJBpD/6utq5kB6r0uVAxUcKbpMKsXXqLyZPGG0ICk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCHksQ4OalDKUfpTyiS1eBJc9U4eMEb7J5uvY7CAA3xF/mx+WzFqMgg2gcn9K2MbviDTtdErNSc2d/LD5PWItDjlGf2kWlX/gfibOvglPD2t+qmcVQ5CCtr4akP0EUCpcTmXoqimAIn68NPYlEWoFHNcil2yPOz2H0r+YAkjla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnhNCayn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377D4C4CEF1;
	Tue, 21 Oct 2025 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047039;
	bh=jSqJBpD/6utq5kB6r0uVAxUcKbpMKsXXqLyZPGG0ICk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gnhNCaynkM0wMfth/IMqriE+JgndxI+bTqUyj+wXWaqobttsBP32n1bOTm7T6UR7O
	 PN9BUSUaCZZ60BWOQv/+qMuoUU6rILKgOZx8SRTf5o7mTZ4LhQr/4mbk3/BmR7aRth
	 LCYOTa8bt9TOP2gTYSh7KHYkUkYOF5mAa2k8xRHJUdqKizvyfmeZj5c88hZ7d+Rk/X
	 MldoAI/4/FIkLlrnzYs19iouUA5nf95oslSHHEhTGsKBtlqr6M9//LgmyyH+UaamP6
	 0SS1+O/rMehuZk2WUDmQT2W+jJQWf3+lMaNzlpFtoT7tfHi4I+8Q96Ti2DaJLCLIhP
	 gMcp/sDMFxMuA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:08 +0200
Subject: [PATCH RFC DRAFT 02/50] nsfs: use inode_just_drop()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-2-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3zzlsf+uqnpzEsJ7MEcDGpT1u65H7z1S6yw+yz+O
 Sblb1P5OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTAG6yDSPD+ws3DSyXFBqvnLwk
 zOmO5UWlgnc3tB4etQlSkX/y6G++O8N/x3XG5+fNUw7pfqGk5rznMDvnuuV3Gww/15mX8TkfT73
 LAwA=
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


