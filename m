Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9B7CD32A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2019 17:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJFPsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 11:48:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfJFPsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 11:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I3cUiR6B2JnhWezciWT7dEv+8m8IojdDmdN/jSnvrYA=; b=Er1bxxlSVjLJEtcQCSOHe6u166
        996zPPGjOkkbPWFglNxogk2Oay2CBkpiE8wDliHRkOOzuHHpaT0lbgX0EOsRd85jxsC9mjRpntmqT
        c9qOu9C/otvtHVZ5mKZGWGWjc6mRyHyT4r5voQbyON0qJXqKWpzyTf0zdst/2zF0A2hvGLKkbtVdm
        rcDGsxHQrHu8aJeGRuh7t9EGizxUWNMS/8YY1RLY5lmtojQIILUkUfmQ/LA1DLXLEl0iqoF99VkxL
        QHt5XJpBrAYlB66Vwv5BO7r9hfwA8+bABDWOgtQAUN7pRxz9Jnkpgw61006DDT+vYVGJ4jF7SFpiN
        RyskH3OA==;
Received: from [2001:4bb8:18c:4d4a:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iH8lq-0008S0-Ad; Sun, 06 Oct 2019 15:48:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] iomap: warn on inline maps in iomap_writepage_map
Date:   Sun,  6 Oct 2019 17:46:00 +0200
Message-Id: <20191006154608.24738-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191006154608.24738-1-hch@lst.de>
References: <20191006154608.24738-1-hch@lst.de>
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
index 7f19c8ab3592..23cc308f971d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1402,6 +1402,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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

