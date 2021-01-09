Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7412EFE7F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 09:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbhAIIBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 03:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbhAIIBF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:01:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5A1223A80;
        Sat,  9 Jan 2021 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610179187;
        bh=JZSK51j63244IWBr+pzm3c0JJcjJt0lF7wGH5+JpZYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMaNkhAealymfact8bgjHAPCxzIqAPBXFz2sk2rT1PY2h8twYdFOtMlzmnN6BF4ng
         vBn5n9MVCN6+YGMYly6jUX/157BCpKFhUOrHAMKE63Ys4a/lQmiIf3NKgjzm8Lpuun
         GhhUVTP98jShQWS32w73aBSq1PuIVE+ARvUs1xwi/JKrV96zeOQQiC0rbT17hOCvz0
         oFpi7M0HHdwIf7EP4ZI3ssh9zSd1Z7SPhjv1wQwVQbuAuMoSP6N7MvPLrVXf9yxtOj
         n/8fZ+K4IEicS8rbCpTXBQ/Xq/aIaTKvFIcSYjNiEnvrJTUrt06aievapr0LGUHts0
         G4I2tZ/qcZCbA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 10/12] gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()
Date:   Fri,  8 Jan 2021 23:59:01 -0800
Message-Id: <20210109075903.208222-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
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

