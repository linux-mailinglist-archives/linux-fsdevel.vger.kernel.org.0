Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BABCF35B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfJHHPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:15:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gRQrKC5mxVwcsV8Ag0ojZ5Wot0Hty2qM/bYQoT6QXnE=; b=gGNe43MZBXn+3usBQuiHpbuzcc
        TvbwwhFIBdzHvlNnoOSxWlDGrrTa4ldJTQs37EEp0vogl2R8DVwaoBsrHQqko49fonww5zmJA0B3A
        a2khzq33LuO/GxAuc4ADTkaGChSV5xC6aINNGEThy6XADYRsCnFJxswumqj7Ur2VHqlbJgBYQ5fDH
        C95EsQPzUrmh3XGBYPat0RYNkSMBRtOROcbmAYvChjsD7DK+XpIveBBfVGPGnmPBq1CmGd6E2uDSi
        uvwIIrv9esxkKC3T5FhC1kv/p8vH3hD7JEa1Pag6PNyXMZa+CQpi8uh0/aBy+N48MMDCwQa37gVpG
        Juy6mJQQ==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjis-0006FC-Kg; Tue, 08 Oct 2019 07:15:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 09/20] xfs: also call xfs_file_iomap_end_delalloc for zeroing operations
Date:   Tue,  8 Oct 2019 09:15:16 +0200
Message-Id: <20191008071527.29304-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008071527.29304-1-hch@lst.de>
References: <20191008071527.29304-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no reason not to punch out stale delalloc blocks for zeroing
operations, as they otherwise behave exactly like normal writes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 016adcd7dd66..7031547e25ad 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1138,7 +1138,8 @@ xfs_file_iomap_end(
 	unsigned		flags,
 	struct iomap		*iomap)
 {
-	if ((flags & IOMAP_WRITE) && iomap->type == IOMAP_DELALLOC)
+	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
+	    iomap->type == IOMAP_DELALLOC)
 		return xfs_file_iomap_end_delalloc(XFS_I(inode), offset,
 				length, written, iomap);
 	return 0;
-- 
2.20.1

