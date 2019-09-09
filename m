Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0857CADEF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfIIS2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:28:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gGnxwHEkKmU3nZb6jslCTcVoCflOHLwGWJm5yNVFVAM=; b=k3TD321ZlIl3HAcRZhXy+ionW
        PuI50dHpesFITp2Ss1G6a4BtSH6LvsF5Z/ls+uRh8YnzS+4MdbGgDgmfO7RWuq0hwHS4CT9+QLuDj
        NoR8gqH20KyAHfJEiPIzzohs+TzZ9I9MtRFC8awCmGhPRfFL7USofUt672LASM2Zr7+K4z121rI/R
        gFGkmLTSSRhRKMU/IEgWvuaFjALHd+2zXW25e7ZKAKKbADJ4BWPmpBkWtX653U/JVLEt4yMc+oikf
        JTnwnSQgU8+eohSMDFGyEaZ19KIHLvHT7nZmiWE97tirZ/tsRP75g/oS3jeMkhR2ZQ0xjB2X+yVtV
        EpOd4FWDQ==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7OOd-00029p-J9; Mon, 09 Sep 2019 18:28:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/19] xfs: improve the IOMAP_NOWAIT check for COW inodes
Date:   Mon,  9 Sep 2019 20:27:22 +0200
Message-Id: <20190909182722.16783-20-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909182722.16783-1-hch@lst.de>
References: <20190909182722.16783-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only bail out once we know that a COW allocation is actually required,
similar to how we handle normal data fork allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index e4e79aa5b695..9e1b4b94acac 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -693,15 +693,8 @@ xfs_ilock_for_iomap(
 	 * COW writes may allocate delalloc space or convert unwritten COW
 	 * extents, so we need to make sure to take the lock exclusively here.
 	 */
-	if (xfs_is_cow_inode(ip) && is_write) {
-		/*
-		 * FIXME: It could still overwrite on unshared extents and not
-		 * need allocation.
-		 */
-		if (flags & IOMAP_NOWAIT)
-			return -EAGAIN;
+	if (xfs_is_cow_inode(ip) && is_write)
 		mode = XFS_ILOCK_EXCL;
-	}
 
 	/*
 	 * Extents not yet cached requires exclusive access, don't block.  This
@@ -760,12 +753,6 @@ xfs_direct_write_iomap_begin(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
-	/*
-	 * Lock the inode in the manner required for the specified operation and
-	 * check for as many conditions that would result in blocking as
-	 * possible. This removes most of the non-blocking checks from the
-	 * mapping code below.
-	 */
 	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
 	if (error)
 		return error;
@@ -775,11 +762,11 @@ xfs_direct_write_iomap_begin(
 	if (error)
 		goto out_unlock;
 
-	/*
-	 * Break shared extents if necessary. Checks for non-blocking IO have
-	 * been done up front, so we don't need to do them here.
-	 */
 	if (imap_needs_cow(ip, &imap, flags, nimaps)) {
+		error = -EAGAIN;
+		if (flags & IOMAP_NOWAIT)
+			goto out_unlock;
+
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
 				&lockmode, flags & IOMAP_DIRECT);
-- 
2.20.1

