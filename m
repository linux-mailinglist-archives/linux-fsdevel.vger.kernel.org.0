Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC62BD7A30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 17:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbfJOPof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 11:44:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387691AbfJOPoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PyfFUuGfa7iOeQdg2tlHNvnJmFmD/Bz+PVXi53q6+CA=; b=qOYNFFkTkILIQ4Rp1K31m+/8Wg
        b8B8wVR8yKYwQs7njFCn1qvo2iyBWc+p6EE/4er6aQ4Sfkf0ihuvYUZB6sGbu9ZGfYs0aFcQZMHC5
        fIEMeGjWW5jeW7542lg3pjtvqnO0lvAfOBkNPlRTCQdHe0eo3TzFCUKu7T08nAJp1xLH7+q2AJNrI
        coK/VcfVkYcHCtW7YHaezXoN6l/g3GHhUWyyIM8/DZBWr1g6xtPVL8TQ1XOjvxLrVZlIDng9fNPzx
        lgQUDZRLKmsmB0UUXX0BYpCH3CZqgWNhT+IyOUZ2+DYLUsOisEDgjsWKFMs0oBt7iL4vTBBJkhAaJ
        iufrPj2Q==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKOzk-0007zX-DB; Tue, 15 Oct 2019 15:44:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] iomap: warn on inline maps in iomap_writepage_map
Date:   Tue, 15 Oct 2019 17:43:43 +0200
Message-Id: <20191015154345.13052-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015154345.13052-1-hch@lst.de>
References: <20191015154345.13052-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

And inline mapping should never mark the page dirty and thus never end up
in writepages.  Add a check for that condition and warn if it happens.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 00af08006cd3..76e72576f307 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1421,6 +1421,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		error = wpc->ops->map_blocks(wpc, inode, file_offset);
 		if (error)
 			break;
+		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
+			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
 		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
-- 
2.20.1

