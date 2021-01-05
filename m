Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9802EA1CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 01:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbhAEAz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 19:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbhAEAzr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:55:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37BF822581;
        Tue,  5 Jan 2021 00:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808107;
        bh=U6WXkB7J0EGF6Jkf3SnygA2+eyxb+PWLweu7YzuZvME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyhUiJG0iohmox3eBnb7ZvT/64QABTWCcVVqOf7ITvkMkTEu5lVVYROPs+dqoIlXT
         zqSWl59Y/qHHWnHAE8hsbsYLzXsH1PlviZyQC0MXq4sigqVueOoEtg/Tu2li2W4DvI
         vaLfjaL7HhSuNcnkr5JxLQO87QlhauH+YahAlEvbyvDwKIrQxeC0PHzjOaTzRxWe1P
         3ASeMv1WQw19wbl9QxIYNLfbMYmxGIPMOTaTvEksLr4kSQvaNX27M1MfODnuaK1UGR
         QbpO1XUUKTHaP+uXuHYUb3S4XrF9OKR3QVJs1LGEj/FUHrv+3AViUp+fy1YBWDtCQn
         xoj2rU1YRXk6g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/13] gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()
Date:   Mon,  4 Jan 2021 16:54:41 -0800
Message-Id: <20210105005452.92521-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105005452.92521-1-ebiggers@kernel.org>
References: <20210105005452.92521-1-ebiggers@kernel.org>
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

