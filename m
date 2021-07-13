Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2BF3C6F75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhGMLUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235874AbhGMLUE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:20:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2711E6127C;
        Tue, 13 Jul 2021 11:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175034;
        bh=mewN8GwOBsr6em75my5L++YqP9khb50lzPkGB3nHCUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvLVZdSpNQDO0b0LDqiK1ZJf/Hj+hnQQ1/W8YFlEOhHoOyE0pE6FceO+scena5+1i
         0u/WKDD5PHst7U3kCtFkG6QJdeZBBbOD00SWtRbxfXK5cM3qW8lG0HvnKsCNd8vz5E
         icZU01XuDWqeA/zoSr3fwsnGwdas6GOWbCQ0c/JzbdEmQVKytfJUt1th6E10rhife+
         F4TzBKXQqBTuMSpHjyWH4VlwMEw+JRYJDJSX4As4aZqqkzZgE6WHIM5lGhfBHohKaU
         Mt+FZJPAD+civIbn9bE/liQl/vSaBtYYmY/BUu9pPVPXSLepq+JQALYWE3A0i4ewR3
         nc5vHj9aaa6eA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 23/24] btrfs/super: allow idmapped btrfs
Date:   Tue, 13 Jul 2021 13:13:43 +0200
Message-Id: <20210713111344.1149376-24-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; h=from:subject; bh=1Y7u6ks+X4eSZCHhNimeAlM7r25xFG/ef0M9yjEMGzQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY1lNGu6Ks7z7Mjaw9ob7aYeUnt04eXRoya5fFMlH5Zq Haly7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI7kmGvwKWtdKaLC2nF96+n9m3f3 sUv0S+58ZctQxTlrwzRz70rGdkmGtYrr/pxBee9bmz7aOSzt+2dXO8uTxts43FEjM7S94JfAA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Now that we converted btrfs internally to account for idmapped mounts allow the
creation of idmapped mounts on btrfs by setting the FS_ALLOW_IDMAP flag.  We
only need to raise this flag on the btrfs_root_fs_type filesystem since
btrfs_mount_root() is ultimately responsible for allocating the superblock and
is called into from btrfs_mount() associated with btrfs_fs_type.

The conversion of the btrfs inode operations was straightforward. Regarding
btrfs specific ioctls that perform checks based on inode permissions only those
have been allowed that are not filesystem wide operations and hence can be
reasonably charged against a specific mount.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d07b18b2b250..5ba21f6b443c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2381,7 +2381,7 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
 };
 
 MODULE_ALIAS_FS("btrfs");
-- 
2.30.2

