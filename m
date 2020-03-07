Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA217CA9A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 03:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCGCBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 21:01:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52494 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726231AbgCGCBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:01:13 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02720trO015135
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Mar 2020 21:00:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4FE0242045B; Fri,  6 Mar 2020 21:00:54 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Theodore Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] writeback: avoid double-writing the inode on a lazytime expiration
Date:   Fri,  6 Mar 2020 21:00:43 -0500
Message-Id: <20200307020043.60118-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306004555.GB225345@gmail.com>
References: <20200306004555.GB225345@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the case that an inode has dirty timestamp for longer than the
lazytime expiration timeout (or if all such inodes are being flushed
out due to a sync or syncfs system call), we need to inform the file
system that the inode is dirty so that the inode's timestamps can be
copied out to the on-disk data structures.  That's because if the file
system supports lazytime, it will have ignored the dirty_inode(inode,
I_DIRTY_TIME) notification when the timestamp was modified in memory.q

Previously, this was accomplished by calling mark_inode_dirty_sync(),
but that has the unfortunate side effect of also putting the inode the
writeback list, and that's not necessary in this case, since we will
immediately call write_inode() afterwards.

Eric Biggers noticed that this was causing problems for fscrypt after
the key was removed[1].

[1] https://lore.kernel.org/r/20200306004555.GB225345@gmail.com

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/fs-writeback.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 76ac9c7d32ec..32101349ba97 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1504,8 +1504,9 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 
 	spin_unlock(&inode->i_lock);
 
-	if (dirty & I_DIRTY_TIME)
-		mark_inode_dirty_sync(inode);
+	/* This was a lazytime expiration; we need to tell the file system */
+	if (dirty & I_DIRTY_TIME_EXPIRED && inode->i_sb->s_op->dirty_inode)
+		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_TIME_EXPIRED);
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & ~I_DIRTY_PAGES) {
 		int err = write_inode(inode, wbc);
-- 
2.24.1

