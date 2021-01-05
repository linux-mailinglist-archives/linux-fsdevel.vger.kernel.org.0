Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDFF2EA1C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 01:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbhAEAzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 19:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbhAEAzs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:55:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 879B722582;
        Tue,  5 Jan 2021 00:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808107;
        bh=moPvKfHUYW5Xbk7fp9PqSrbSDfWUFwePDygO+DUtRFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=odLOb9jW7zdbgQ19pnxfQeV0LZCahNWh2pJHvvskuGhaoTAJINjva3sXgUpuQUx4C
         9Q4jVEGDvC4JAbMDOb0ntyBgGZGYCD7D5RQ+uTFsyV3drMND3coDDlh3n+eJeaDR4P
         hil5l822YPp+3ttvEctfsdcoutR9fY1zMzcy5DOf6/m5irfC1tIlgTw7cCQNZnYr2n
         osSXWG3OuD+6/7zLbzpZ0kcTNtAhXkxI9E8LYaVMNzhVDRqwBsPc/DbKgZ8L/a763U
         fTbNyD1NhYvp7LInib3/VaOfA36sk0VY6JASj7UsjCeOh2iBGsxYCeMQqSIOQuqYJT
         QcZ5iZypbSAwA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/13] fs: only specify I_DIRTY_TIME when needed in generic_update_time()
Date:   Mon,  4 Jan 2021 16:54:42 -0800
Message-Id: <20210105005452.92521-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105005452.92521-1-ebiggers@kernel.org>
References: <20210105005452.92521-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

generic_update_time() always passes I_DIRTY_TIME to
__mark_inode_dirty(), which doesn't really make sense because (a)
generic_update_time() might be asked to do only an i_version update, not
also a timestamps update; and (b) I_DIRTY_TIME is only supposed to be
set in i_state if the filesystem has lazytime enabled, so using it
unconditionally in generic_update_time() is inconsistent.

As a result there is a weird edge case where if only an i_version update
was requested (not also a timestamps update) but it is no longer needed
(i.e. inode_maybe_inc_iversion() returns false), then I_DIRTY_TIME will
be set in i_state even if the filesystem isn't mounted with lazytime.

Fix this by only passing I_DIRTY_TIME to __mark_inode_dirty() if the
timestamps were updated and the filesystem has lazytime enabled.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/inode.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6442d97d9a4ab..d0fa43d8e9d5c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1743,24 +1743,26 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 
 int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
-	int iflags = I_DIRTY_TIME;
-	bool dirty = false;
-
-	if (flags & S_ATIME)
-		inode->i_atime = *time;
-	if (flags & S_VERSION)
-		dirty = inode_maybe_inc_iversion(inode, false);
-	if (flags & S_CTIME)
-		inode->i_ctime = *time;
-	if (flags & S_MTIME)
-		inode->i_mtime = *time;
-	if ((flags & (S_ATIME | S_CTIME | S_MTIME)) &&
-	    !(inode->i_sb->s_flags & SB_LAZYTIME))
-		dirty = true;
-
-	if (dirty)
-		iflags |= I_DIRTY_SYNC;
-	__mark_inode_dirty(inode, iflags);
+	int dirty_flags = 0;
+
+	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
+		if (flags & S_ATIME)
+			inode->i_atime = *time;
+		if (flags & S_CTIME)
+			inode->i_ctime = *time;
+		if (flags & S_MTIME)
+			inode->i_mtime = *time;
+
+		if (inode->i_sb->s_flags & SB_LAZYTIME)
+			dirty_flags |= I_DIRTY_TIME;
+		else
+			dirty_flags |= I_DIRTY_SYNC;
+	}
+
+	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
+		dirty_flags |= I_DIRTY_SYNC;
+
+	__mark_inode_dirty(inode, dirty_flags);
 	return 0;
 }
 EXPORT_SYMBOL(generic_update_time);
-- 
2.30.0

