Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9223B2EFE8C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 09:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAIIBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 03:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbhAIIBF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:01:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0A6F23A69;
        Sat,  9 Jan 2021 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610179185;
        bh=X2D2mMHSYMvciNt0NX060b8SxOuVP637kMoRfSYm4hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFPYCSfxi6jt7dh452fvYOjRNnSMUXbz8Ldbrx5SGN7CEn0FfKd6trsAFH6tQSifw
         d4qlNTLmPT8GouFL9FJAYI88pWWf957LV4l3E7E/hWtduFI7b0oTBCWRLrW2IK8Q/Q
         FCYrgwqc99DymUEG7oKhjTY57v7R2vM5tY1REgj3cw1WSXDCdzFbBYrH25abQC2FwA
         7Mj8WPo7PUw+i9I5wWi8QgDUN4e8vo+4PfdL9xmT961l8/fnOWLqQe4ByRF8EhrvtX
         Ky/Db8yaRBXa3dDYRcex1xKhkKHxqEKY8OZ2hYIq64kX+WMXc00H9D9r6FOOuQHccH
         SvjeFv8022L2A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 06/12] fs: pass only I_DIRTY_INODE flags to ->dirty_inode
Date:   Fri,  8 Jan 2021 23:58:57 -0800
Message-Id: <20210109075903.208222-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
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

