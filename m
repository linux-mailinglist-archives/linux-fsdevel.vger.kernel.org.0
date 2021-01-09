Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB5E2EFE76
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 09:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAIIA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 03:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbhAIIAZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:00:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 039A823A63;
        Sat,  9 Jan 2021 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610179185;
        bh=/5CziqsFBf55uwSNubqu4qN4xKuBe9W+HNnHEDG6YgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyyBQ5JaPqg7f6gAr0U6h5XPq4Yu0YdR9z02SEkW8Bhy+RlGqWR4BmIpWnzVs7de+
         wTl/w1EWyIe7Nc22bIFOXpgui7MJ9XplFddYt9QgHD84Wv0iTSenQ2f6l/F3728nyT
         MHuxxqUG7jNI5tjO1JaGj4GiRjMTdTfqO0NQj5SEojNg7Rf9uvfJoVtY1zXAXK1KuR
         UgRhWZiuaTsaNlOxMPKFXBcrGoYqCT3pWaxFQZBn14I2afW7TW/1ZF9na/pUewmINZ
         s5xO7jsfntWdMkTCOCf5siZ5Jt5VoGfglrrYC3f17ywLAORHqzTJful8Uejer2w0wy
         fdUJhCzLAPOUQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 04/12] fat: only specify I_DIRTY_TIME when needed in fat_update_time()
Date:   Fri,  8 Jan 2021 23:58:55 -0800
Message-Id: <20210109075903.208222-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

As was done for generic_update_time(), only pass I_DIRTY_TIME to
__mark_inode_dirty() when the inode's timestamps were actually updated
and lazytime is enabled.  This avoids a weird edge case where
I_DIRTY_TIME could be set in i_state when lazytime isn't enabled.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fat/misc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index f1b2a1fc2a6a4..18a50a46b57f8 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -329,22 +329,23 @@ EXPORT_SYMBOL_GPL(fat_truncate_time);
 
 int fat_update_time(struct inode *inode, struct timespec64 *now, int flags)
 {
-	int iflags = I_DIRTY_TIME;
-	bool dirty = false;
+	int dirty_flags = 0;
 
 	if (inode->i_ino == MSDOS_ROOT_INO)
 		return 0;
 
-	fat_truncate_time(inode, now, flags);
-	if (flags & S_VERSION)
-		dirty = inode_maybe_inc_iversion(inode, false);
-	if ((flags & (S_ATIME | S_CTIME | S_MTIME)) &&
-	    !(inode->i_sb->s_flags & SB_LAZYTIME))
-		dirty = true;
+	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
+		fat_truncate_time(inode, now, flags);
+		if (inode->i_sb->s_flags & SB_LAZYTIME)
+			dirty_flags |= I_DIRTY_TIME;
+		else
+			dirty_flags |= I_DIRTY_SYNC;
+	}
+
+	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
+		dirty_flags |= I_DIRTY_SYNC;
 
-	if (dirty)
-		iflags |= I_DIRTY_SYNC;
-	__mark_inode_dirty(inode, iflags);
+	__mark_inode_dirty(inode, dirty_flags);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fat_update_time);
-- 
2.30.0

