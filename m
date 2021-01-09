Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7729C2EFE71
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 09:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhAIIA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 03:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbhAIIAZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:00:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A956023A60;
        Sat,  9 Jan 2021 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610179184;
        bh=UAs5pZYbnHEbB32I8gYpVHYl5ps5DskVBX1/zJ7HEQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoT+M+0x7oiHSACHnRZzbGNiIWW5upkwVfH5++ixOztpM5YOvybegB3g8nXEEicEj
         hl9mqWdNzhULeIjdHYsBv+IIOy70YPKx+OnBYbIlw3VzIfSrtA9C5muhIc968rY8KL
         psdI6/oG5oFnHsmSOi3lhhQEnSxSHHuKFZ2BFmrDsb/dQN8dkJXZjy2zvQwHBiyFzs
         j8DRYBIyioPgHaWnWsWd5nzp8XorZgiGmYdvIabwlvn12r8nXbaYTj/qwxn2S2Hpgd
         PSWWYIA2IDr1UMOe5W3Z1b80Sp9fXxraUFqynwAjlDyfYatd1Rdx8WS8DbSy+rjXRV
         jReLDxw0TkFXw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 03/12] fs: only specify I_DIRTY_TIME when needed in generic_update_time()
Date:   Fri,  8 Jan 2021 23:58:54 -0800
Message-Id: <20210109075903.208222-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

generic_update_time() always passes I_DIRTY_TIME to
__mark_inode_dirty(), which doesn't really make sense because (a)
generic_update_time() might be asked to do only an i_version update, not
also a timestamps update; and (b) I_DIRTY_TIME is only supposed to be
set in i_state if the filesystem has lazytime enabled, so using it
unconditionally in generic_update_time() is inconsistent.

As a result there is a weird edge case where if only an i_version update
was requested (not also a timestamps update) but it is no longer needed
(i.e. inode_maybe_inc_iversion() returns false), then I_DIRTY_TIME will
be set in i_state even if the filesystem isn't mounted with lazytime.

Fix this by only passing I_DIRTY_TIME to __mark_inode_dirty() if the
timestamps were updated and the filesystem has lazytime enabled.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/inode.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6442d97d9a4ab..d0fa43d8e9d5c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1743,24 +1743,26 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 
 int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
-	int iflags = I_DIRTY_TIME;
-	bool dirty = false;
-
-	if (flags & S_ATIME)
-		inode->i_atime = *time;
-	if (flags & S_VERSION)
-		dirty = inode_maybe_inc_iversion(inode, false);
-	if (flags & S_CTIME)
-		inode->i_ctime = *time;
-	if (flags & S_MTIME)
-		inode->i_mtime = *time;
-	if ((flags & (S_ATIME | S_CTIME | S_MTIME)) &&
-	    !(inode->i_sb->s_flags & SB_LAZYTIME))
-		dirty = true;
-
-	if (dirty)
-		iflags |= I_DIRTY_SYNC;
-	__mark_inode_dirty(inode, iflags);
+	int dirty_flags = 0;
+
+	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
+		if (flags & S_ATIME)
+			inode->i_atime = *time;
+		if (flags & S_CTIME)
+			inode->i_ctime = *time;
+		if (flags & S_MTIME)
+			inode->i_mtime = *time;
+
+		if (inode->i_sb->s_flags & SB_LAZYTIME)
+			dirty_flags |= I_DIRTY_TIME;
+		else
+			dirty_flags |= I_DIRTY_SYNC;
+	}
+
+	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
+		dirty_flags |= I_DIRTY_SYNC;
+
+	__mark_inode_dirty(inode, dirty_flags);
 	return 0;
 }
 EXPORT_SYMBOL(generic_update_time);
-- 
2.30.0

