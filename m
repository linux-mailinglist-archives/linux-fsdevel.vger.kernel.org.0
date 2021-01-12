Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091892F3999
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406624AbhALTFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406212AbhALTF3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:05:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE1EC23133;
        Tue, 12 Jan 2021 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478252;
        bh=APAXDrWezK5HVIGjbIEklXvxKBuY3jOk4QoaXXPyPsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JR7BV63iI5jgPGhz2qNN+JPf5iJrmkunJig27hVsc1kwuLgvJdp4+dgOLu6cMvvFO
         wshU9koqNENnrej7mbVBZMChiirLpyecMJObe1DnzKBfexuGtnuguZvDktJL8nMorp
         3Sfggo5INVs5GQnRsFgVkXpxicS2m+h2jXSKPnhDis9/BdX5y6cgjYGm1/lILslham
         V+ttL7qFmRKTyq2biIaIvwRwfY7r5PzzJm7X5gYGfvDbHmztq4ICemQaQKQc3682FE
         p7HGwU8nrWCMKTeDXAG3DDd6sOXLq4KJpsxJQSV5BOy+L8cD8w5hKGz4Xi7pbNmAym
         s6nuriYCc1LWA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 10/11] gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()
Date:   Tue, 12 Jan 2021 11:02:52 -0800
Message-Id: <20210112190253.64307-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112190253.64307-1-ebiggers@kernel.org>
References: <20210112190253.64307-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The I_DIRTY_TIME flag is primary used within the VFS, and there's no
reason for ->fsync() implementations to do anything with it.  This is
because when !datasync, the VFS will expire dirty timestamps before
calling ->fsync().  (See vfs_fsync_range().)  This turns I_DIRTY_TIME
into I_DIRTY_SYNC.

Therefore, change gfs2_fsync() to not check for I_DIRTY_TIME.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/gfs2/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b39b339feddc9..7fe2497755a37 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -749,7 +749,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	int sync_state = inode->i_state & I_DIRTY_ALL;
+	int sync_state = inode->i_state & I_DIRTY;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	int ret = 0, ret1 = 0;
 
@@ -762,7 +762,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 	if (!gfs2_is_jdata(ip))
 		sync_state &= ~I_DIRTY_PAGES;
 	if (datasync)
-		sync_state &= ~(I_DIRTY_SYNC | I_DIRTY_TIME);
+		sync_state &= ~I_DIRTY_SYNC;
 
 	if (sync_state) {
 		ret = sync_inode_metadata(inode, 1);
-- 
2.30.0

