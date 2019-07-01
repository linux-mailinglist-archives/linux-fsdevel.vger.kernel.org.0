Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617245C540
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfGAVzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:55:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAVzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VnJ3l/G3VcEZucPv3SJlnBv3ai6y5dMzvguEQQorKk0=; b=ZJVYlwvv7rW4qBuEtxJKot9IzR
        d1U/BGp884th3kUbc81NF1pWwEz52oZhxCOlIjcQxscjm6jxmJwz7/9A6b+AHVP5N4vG5CJ5ERgrd
        St4akr8qDaQqxmYrx8PgmsnBtFf923xHMvvDNZr+ywYR386DoMwB3bWK/gEn0rAGxrbpibqm706bm
        +PShYs68uEuu8oJUpfw/B8ZKoiMTYNIXKV1bZflNg8tRvZuHGGAKpJMv7WZwz6evxnQi3gecNHu+t
        Qy3UFKugC0S3RO9d9U9p3Qr7qzqzdjelo+JadlW7Te+nVedn4oRYZ1owZgXV7l/VjVoLp4yI32xAp
        LOb41oYw==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4Gb-0001k2-Mq; Mon, 01 Jul 2019 21:55:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 04/15] iomap: warn on inline maps iomap_writepage_map
Date:   Mon,  1 Jul 2019 23:54:28 +0200
Message-Id: <20190701215439.19162-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701215439.19162-1-hch@lst.de>
References: <20190701215439.19162-1-hch@lst.de>
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
---
 fs/iomap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index 0a86aaee961f..ea5b8e7c8903 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -2541,6 +2541,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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

