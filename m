Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318CD2F3991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406575AbhALTF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406212AbhALTF2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:05:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B797230F9;
        Tue, 12 Jan 2021 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478249;
        bh=Zs1h5JfMmZOeqAwdOYUH+AziTqKfcFLZqcUS4NYWVDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cm00WACIoNMlTYL0uJSNnHvNdLoQ/ExfQkhIm4IyRnI8Gkzr97lIAe5g6goqw5qN0
         cFHtPNEBXpDjjIG3ZuJAINbeFIoOUSGDgFvwWs8SsgWdYcdTwxyh1jZZEbDvMGTR4F
         CCOEuBkUzU9p2J4MWW8m+8nT41oSeAXFbUORKfQIev6Nhk7Ud2VSdrq+DaP1PpHxrd
         7+DWRCmwpZ8wyIOTh/73J/6MYNpQuUX6NrHhksoznNkr+PAAwPwMj+ttPARWpY4u6U
         S6lvjbzFA+tJVd9KHBxMZM3p2D1TrH91q2z4cIng/8ZVUQPEhaZt9K+6cq877CKdkR
         n78IDCLrJB4FQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 06/11] fs: pass only I_DIRTY_INODE flags to ->dirty_inode
Date:   Tue, 12 Jan 2021 11:02:48 -0800
Message-Id: <20210112190253.64307-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112190253.64307-1-ebiggers@kernel.org>
References: <20210112190253.64307-1-ebiggers@kernel.org>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
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
index b7616bbd55336..2e6064012f7d3 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2259,7 +2259,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		trace_writeback_dirty_inode_start(inode, flags);
 
 		if (sb->s_op->dirty_inode)
-			sb->s_op->dirty_inode(inode, flags);
+			sb->s_op->dirty_inode(inode, flags & I_DIRTY_INODE);
 
 		trace_writeback_dirty_inode(inode, flags);
 
-- 
2.30.0

