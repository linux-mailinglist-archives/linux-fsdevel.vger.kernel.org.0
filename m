Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86272F3980
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392944AbhALTEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhALTEs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:04:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A30A123125;
        Tue, 12 Jan 2021 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478247;
        bh=2zDd8BfdFool91CsRL57ooUyDd51zEYVDkcohfb0i98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyitZ8hBP0U+ToSMWz7boPwVLfMfjtDFlxlv2EzZ+c8F6ZxLxNFypkpW8/7U0g59/
         0pO+J4Uz6AnzRXAaBIaQ/MSNzwKNSgA9SENgPVZNxRDQRHgxGge/5KUoAlkuH9ww9o
         vmxrp0HNdcJBlBnNqZEHS1z8ggfNUizcysCN7wEX4e8pmP/mJmaMC+74F2H5rdBotx
         rJHsBUfMKXTR+N73BEMbQBdKA4MOAlxilYjf3e0lnEnosPBVj+bX0CPO4vt3D5o8J0
         m/X4oz0q+nfLW3kHRZSk2pUuv0T9HXtwereu1vzMvHeqN7s2NxTRdSGM1asQIjK4Nm
         X1QfrcRJw27dA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 02/11] fs: correctly document the inode dirty flags
Date:   Tue, 12 Jan 2021 11:02:44 -0800
Message-Id: <20210112190253.64307-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112190253.64307-1-ebiggers@kernel.org>
References: <20210112190253.64307-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The documentation for I_DIRTY_SYNC and I_DIRTY_DATASYNC is a bit
misleading, and I_DIRTY_TIME isn't documented at all.  Fix this.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
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

