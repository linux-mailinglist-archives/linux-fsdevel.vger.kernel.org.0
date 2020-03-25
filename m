Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1162C192854
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 13:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCYM2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 08:28:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgCYM2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bOpFqUPJ9bS+4ZDNHjIcr3PqAyINL9efeQnE7Z928sM=; b=kNWzkfmPTk9pYHmfxP86DPRPIq
        M/Ipv+fQiCkDkwXVpxqu3vzY7CjHK4yUGuRcjtkjXDrmI5QP67iBFuZ7wmzjWBRflzTR4Oc10Y3Tw
        TxZGNoKsEh6OdYFpqm6hndtv7nBc0nbnSt/wF5ed6xS4syPSNC5uKBNw5gu3GTreDVpUkm2vzqIHs
        2+NSFdsEglJWkR3iq/8Z4aBgwd4eOWC15tQTykGwIj32DdexPLlCe17ITG83vlBMg3Y7I0hu0ytef
        96sPrnpgCWNGDBo9diiyYhgbp2R0CAcMwkft9oMIFOoTsjaSOofASaFSKdfAc4+7LfRhpUx2citl6
        pM8QRVRA==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH59C-0003No-4o; Wed, 25 Mar 2020 12:28:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] fs: clean up generic_update_time a bit
Date:   Wed, 25 Mar 2020 13:28:25 +0100
Message-Id: <20200325122825.1086872-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325122825.1086872-1-hch@lst.de>
References: <20200325122825.1086872-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no need both the sync and iflag variables - just use dirty as
the indicator for which flag to pass to __mark_inode_dirty, as there
is no point in passing both flags - __mark_inode_dirty will immediately
clear I_DIRTY_TIME if I_DIRTY_SYNC is set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 96cf26ed4c7b..a7d19b1b15ac 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1662,7 +1662,6 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 
 int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
-	int iflags = I_DIRTY_TIME;
 	bool dirty = false;
 
 	if (flags & S_ATIME)
@@ -1678,9 +1677,7 @@ int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 	     !(inode->i_sb->s_flags & SB_LAZYTIME)))
 		dirty = true;
 
-	if (dirty)
-		iflags |= I_DIRTY_SYNC;
-	__mark_inode_dirty(inode, iflags);
+	__mark_inode_dirty(inode, dirty ? I_DIRTY_SYNC : I_DIRTY_TIME);
 	return 0;
 }
 EXPORT_SYMBOL(generic_update_time);
-- 
2.25.1

