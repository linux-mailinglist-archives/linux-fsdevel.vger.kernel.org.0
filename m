Return-Path: <linux-fsdevel+bounces-52118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C2ADF815
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4792F3B0202
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DCA21C19E;
	Wed, 18 Jun 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz5ATQ4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939071B78F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280031; cv=none; b=H/DDGtGiNPAbHVdERJyqyXrJfKRUG2foW8n2CdghMqZ0xoOcuE9ye7uHcibuO+gJoRC6TTrdrUzqK2hfnGrE3APbIEfyakI36hFnEyPNBiWHCiDADMveAKdXhcwlgOZoxC576+SvZQwzLWwuV94uqibFO9wwOB6zDrhHKuPiKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280031; c=relaxed/simple;
	bh=rYd+MHZwVZIFLvMiQYDajUViJjSxzeUH6BBrlU/diZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QG9dXOLzDmXnmAL8/tsN02ZiZor1blF7w27ZRXNltxrq4QBxTqGUle6Pqd1zIOKVWlhjfj7w8CEH8fgW7dWVN2DAMQjSDEQj6Wng/A4n3nYUiijA5/NwKH6O8JsseBcjLJBDkTAXkPgdJKfT7oU5EOXMBKmBqdPSN3VIujbO8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz5ATQ4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F01C4CEED;
	Wed, 18 Jun 2025 20:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280031;
	bh=rYd+MHZwVZIFLvMiQYDajUViJjSxzeUH6BBrlU/diZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jz5ATQ4X6TtidqlCO9+r7fGm5rMWsyvIU6WNOE0Iap1w741gelP/PIpZwtCHH8wgc
	 4GXmpfLr1gleODZNAn/ViFhyilQB2BEiOIFIsiFM/CZRot0UnPxPuyb9x11C6m3JK5
	 g1FIFpjoGSngoV27WkjqXJNIY9fAn6FrW1ky2y4Do4hTVASNuzX9Ok2A0vQZLUvevL
	 3of++Wr2bp7eP6fkYcTKU7hZTJVkg84X18RwiSX8fJZTEJDAaaArSNp1RbC8GttUGs
	 XNXZfWGJGKPYRskdMuHhOI77KzDERKnHXve5OeZ7ZG0PN0rACqhM/cisILBJo2FNyX
	 nSM3jP1BNhWKg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:35 +0200
Subject: [PATCH v2 01/16] pidfs: raise SB_I_NODEV and SB_I_NOEXEC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-1-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rYd+MHZwVZIFLvMiQYDajUViJjSxzeUH6BBrlU/diZ4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0cYf1lZ8X65f8tk5pi9m2Rm7HgZuEhy0gVBM+a9R
 za6PVLf2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR49aMDIs5Nn9ZvPPqY+cS
 u31bo/SqgxKZrO7d617Lc6FjqVxwuREjw6x5VxumejoFrylP+2ghPM/8u80DxcXlE4r53X9McHP
 bzQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Similar to commit 1ed95281c0c7 ("anon_inode: raise SB_I_NODEV and SB_I_NOEXEC"):
it shouldn't be possible to execute pidfds via
execveat(fd_anon_inode, "", NULL, NULL, AT_EMPTY_PATH)
so raise SB_I_NOEXEC so that no one gets any creative ideas.

Also raise SB_I_NODEV as we don't expect or support any devices on pidfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c1f0a067be40..ff2560b34ed1 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -891,6 +891,8 @@ static int pidfs_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
 	ctx->ops = &pidfs_sops;
 	ctx->eops = &pidfs_export_operations;
 	ctx->dops = &pidfs_dentry_operations;

-- 
2.47.2


