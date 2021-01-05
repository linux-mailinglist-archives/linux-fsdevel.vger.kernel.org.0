Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6E72EA1DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 01:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbhAEA4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 19:56:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbhAEA42 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:56:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF6622597;
        Tue,  5 Jan 2021 00:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808108;
        bh=B3Emt5qB2uZqLRLG8UPggA6U0YAB7if9iFbujwsgEtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcKIh2C2h0ZA6sQb9/5a4jo57dRI1gFr+nnAqwgx0WF8ercDa72h65pmp3xBQqNBt
         PHdc/BfTzNbg7N5rZeIB9wH3sIQt4rojBNfOipI5vFrpqNzSfwmMPCzOZiynTibMWT
         qPKTGX4EoB+fcFap1ApNiflAALtI5jlR1T1xYXF641p4Y4LgIfGrKHNzxIosVL4Qea
         qClPYIhNsF1iP4jslUeXVTHZRs9fr/WxbvUUQFFk9SgDxNUY8DTlclSx1yF8hb6Xv0
         0Mw3amjUyNtTKRKf4WKFbEb42i4la9OwlyYXq9Nb72cJ8HkRCxiVbw/yEKwtW9g8NZ
         6n45MNQyj4grg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/13] fs: pass only I_DIRTY_INODE flags to ->dirty_inode
Date:   Mon,  4 Jan 2021 16:54:45 -0800
Message-Id: <20210105005452.92521-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105005452.92521-1-ebiggers@kernel.org>
References: <20210105005452.92521-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

->dirty_inode is now only called when I_DIRTY_INODE (I_DIRTY_SYNC and/or
I_DIRTY_DATASYNC) is set.  However it may still be passed other dirty
flags at the same time, provided that these other flags happened to be
passed to __mark_inode_dirty() at the same time as I_DIRTY_INODE.

This doesn't make sense because there is no reason for filesystems to
care about these extra flags.  Nor are filesystems notified about all
updates to these other flags.

Therefore, mask the flags before passing them to ->dirty_inode.

Also properly document ->dirty_inode in vfs.rst.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/vfs.rst | 5 ++++-
 fs/fs-writeback.c                 | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ca52c82e5bb54..287b80948a40b 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -270,7 +270,10 @@ or bottom half).
 	->alloc_inode.
 
 ``dirty_inode``
-	this method is called by the VFS to mark an inode dirty.
+	this method is called by the VFS when an inode is marked dirty.
+	This is specifically for the inode itself being marked dirty,
+	not its data.  If the update needs to be persisted by fdatasync(),
+	then I_DIRTY_DATASYNC will be set in the flags argument.
 
 ``write_inode``
 	this method is called when the VFS needs to write an inode to
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e3347fd6eb13a..f20daf4f5e19b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2268,7 +2268,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		trace_writeback_dirty_inode_start(inode, flags);
 
 		if (sb->s_op->dirty_inode)
-			sb->s_op->dirty_inode(inode, flags);
+			sb->s_op->dirty_inode(inode, flags & I_DIRTY_INODE);
 
 		trace_writeback_dirty_inode(inode, flags);
 
-- 
2.30.0

