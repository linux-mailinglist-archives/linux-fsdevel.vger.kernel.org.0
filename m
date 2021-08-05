Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72E3E1E07
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhHEVcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 17:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhHEVcS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 17:32:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C852360F42;
        Thu,  5 Aug 2021 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628199114;
        bh=Wyk7Su3mF1TKbpeQGVinnLwDNpQkKT/p9ReSRZ7PDX8=;
        h=Date:From:To:Cc:Subject:From;
        b=qBAPFZuJwLV/XyEe7Wf+nZF+dhFA4d8ap3Dksfsl1z1vkMEL78iNEmGKNUG+I0iUn
         8DGF3Bnb6R06B1t2eY+FiajYhPEa0pl8pTbZfnyPcBPTWmCE9wKjM+b6Lf3XA7bhG0
         4/30STapcd8SVTSd3qkpYmPL8spio7D6coWNjSp8DEgkddphusOYNEPacdG7Z8Jj0q
         ecA1M08xj/63m5ZIigawKRZja1yPlzDaEgzZVYhuyGwa6Q3B8FrjuZadZvYWoT4mKF
         hhloptW7oSCVGs+fKaX1inkRzi8pKxwi6teUb4kL8OrzImWDwm461Aez8BuvxKbQ6w
         xtgBfJLgUQ+FA==
Date:   Thu, 5 Aug 2021 14:31:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] iomap: pass writeback errors to the mapping
Message-ID: <20210805213154.GZ3601443@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Modern-day mapping_set_error has the ability to squash the usual
negative error code into something appropriate for long-term storage in
a struct address_space -- ENOSPC becomes AS_ENOSPC, and everything else
becomes EIO.  iomap squashes /everything/ to EIO, just as XFS did before
that, but this doesn't make sense.

Fix this by making it so that we can pass ENOSPC to userspace when
writeback fails due to space problems.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..b06138c6190b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1016,7 +1016,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
 
 	if (error) {
 		SetPageError(page);
-		mapping_set_error(inode->i_mapping, -EIO);
+		mapping_set_error(inode->i_mapping, error);
 	}
 
 	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
