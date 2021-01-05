Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C592EA1E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 01:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbhAEA4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 19:56:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbhAEA42 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:56:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD664225AA;
        Tue,  5 Jan 2021 00:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808109;
        bh=H1ms59/bip1WURh53Z2hT3TghGoA+Y1uZAJZTjqPVbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jT5YHwMUgMCR7wlwaRdowKZM9R6gvPc5q8QsYcKqluLVv9qzVzb5ZLYpj+8BJinTA
         1tYt5wwFZVp0RDAxpBlc63HhVpNF5Rk3zgXbvdiFBSWfIpLrDX8Mmfq1MVoz9YClb1
         9Gr2aATxyaLdxZqNOHjdmFblPWbRTyzC/RA158eyh4sD8Aa3guZw/r8EudMGbINKUJ
         w+1wvYWfRCLiPz4E7Qnid8lt7OG7jDwfbEzObQJGnso821wgCnsJYkDVJxNx555AOD
         74UKgJtYKhCO2Xw93w+7ZABhUKMlAxqRerT5DGy3IKUeXa5hwHmJYWfpjPMb/kOHAy
         7Gqk1iDUurBeg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/13] fs: correctly document the inode dirty flags
Date:   Mon,  4 Jan 2021 16:54:46 -0800
Message-Id: <20210105005452.92521-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105005452.92521-1-ebiggers@kernel.org>
References: <20210105005452.92521-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The documentation for I_DIRTY_SYNC and I_DIRTY_DATASYNC is a bit
misleading, and I_DIRTY_TIME isn't documented at all.  Fix this.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fs.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c176..45a0303b2aeb6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2084,8 +2084,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 /*
  * Inode state bits.  Protected by inode->i_lock
  *
- * Three bits determine the dirty state of the inode, I_DIRTY_SYNC,
- * I_DIRTY_DATASYNC and I_DIRTY_PAGES.
+ * Four bits determine the dirty state of the inode: I_DIRTY_SYNC,
+ * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
  *
  * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
  * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
@@ -2094,12 +2094,20 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
  *
  * I_DIRTY_SYNC		Inode is dirty, but doesn't have to be written on
- *			fdatasync().  i_atime is the usual cause.
- * I_DIRTY_DATASYNC	Data-related inode changes pending. We keep track of
+ *			fdatasync() (unless I_DIRTY_DATASYNC is also set).
+ *			Timestamp updates are the usual cause.
+ * I_DIRTY_DATASYNC	Data-related inode changes pending.  We keep track of
  *			these changes separately from I_DIRTY_SYNC so that we
  *			don't have to write inode on fdatasync() when only
- *			mtime has changed in it.
+ *			e.g. the timestamps have changed.
  * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
+ * I_DIRTY_TIME		The inode itself only has dirty timestamps, and the
+ *			lazytime mount option is enabled.  We keep track of this
+ *			separately from I_DIRTY_SYNC in order to implement
+ *			lazytime.  This gets cleared if I_DIRTY_INODE
+ *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set.  I.e.
+ *			either I_DIRTY_TIME *or* I_DIRTY_INODE can be set in
+ *			i_state, but not both.  I_DIRTY_PAGES may still be set.
  * I_NEW		Serves as both a mutex and completion notification.
  *			New inodes set I_NEW.  If two processes both create
  *			the same inode, one of them will release its inode and
-- 
2.30.0

