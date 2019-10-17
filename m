Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF00DB531
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441195AbfJQR5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 13:57:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441175AbfJQR5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EHnzXlsMN0msZ+wyMdG2M/WDx59W2fryIi7yaC47l/4=; b=IaML3xtcIJaSHlcdd8WizZ10t0
        5ya9OPm/vgTsylorycXl5B52uV2DT4L8DyGPur+GUJVCBlngOCH22LvGUwxP2mlUpel/4fUOexI61
        bGM0nMaVhBmCLiuaXmldyI9ZRdatGIXneZK+oivVUwsztUMJ0DI0bXv6c5jriJiXC/cDGDN+SzAbj
        CbRj+XNyElRpiKoqp5ghqICSY2VXgHkj3gRxNRUfR0w/upXMtyMG5482fGe4S1rXGWwuug43knMxL
        i6FNJIkPaCsVk/fP4VcyzZlmG7r93y/Ob4pOpNF9zIXWja+QG7sw4aiVcNtwNMvrdB0L1fi9b8jjs
        rcvQowwg==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLA1C-0001JA-Cb; Thu, 17 Oct 2019 17:56:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 11/14] iomap: warn on inline maps in iomap_writepage_map
Date:   Thu, 17 Oct 2019 19:56:21 +0200
Message-Id: <20191017175624.30305-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017175624.30305-1-hch@lst.de>
References: <20191017175624.30305-1-hch@lst.de>
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
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a8db706d59cb..7b83a7ba2edb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1415,6 +1415,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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

