Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF2C2E0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfJAHQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 03:16:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732829AbfJAHQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F1Xg/3Bstl/oXGREMdfRTRgkyVyVzAnBeGlW0zeMdeU=; b=DwSd/0TPYkqmxarbKknwj8A42c
        OOXfBr2lEt6dYv/NAA/kvpvJ5zxYAtpZ29cmdHP5QBEi3rhwlQPIk89bxkICZgBKXt22VYClfL3PB
        VuUPzc2vlbVv9fx5rpV9YFY+ErPybzEY7dz6QL2zQLjZwUY9JZuw3diQb5kMGLHuvpI5Dp/iSG0vI
        WoZNnozoqbF7EAOhMLaGGxLYubLRdGi9SyqSQJiqTvMuhaOeaVhjQERz3StrfIJwJS4A+4h4YRfZI
        milyJH8pgcjfJ8DX3fe1xA+rXiXclZBB7ygtV1ieALmX8iGfAeCj2x6qE56cSakp2cw/EeYen0tCm
        MJ27k6fg==;
Received: from [2001:4bb8:18c:4d4a:b9e5:f9f0:a515:3f0a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFCOU-0001Ph-8Z; Tue, 01 Oct 2019 07:16:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] iomap: warn on inline maps in iomap_writepage_map
Date:   Tue,  1 Oct 2019 09:11:44 +0200
Message-Id: <20191001071152.24403-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001071152.24403-1-hch@lst.de>
References: <20191001071152.24403-1-hch@lst.de>
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
index 3444f968e739..61f067b3261b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1409,6 +1409,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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

