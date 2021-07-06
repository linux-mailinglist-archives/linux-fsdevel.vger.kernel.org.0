Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A753BDB77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhGFQfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 12:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhGFQfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F074EC061574;
        Tue,  6 Jul 2021 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8g1rbS4pTPzctrCvZ4zRcoNhzl4NCCSOb3dD7gmNVm4=; b=AeKal7gC3SV9eUl8DIeb48eZ9b
        +/fvNBYasBBCOjxeewGdUtdzxa4M8Ajc6xJ01jzXCnsdNnlSavPGRnIkkDbqKSb+QIunuD2Uf8mTf
        pCfLJfCbSH7aIWNtPQTwcBOvovlyMoIOScwqgC9oGYFYGRUYWR9HoFom3sS+frBWCmtzjw7FRg0ar
        oHhdTUIK4WXoRsHGddPwGCceitYerrsVtsLTe+4OrRhDfhgb4X4e6R3srC7hoyqEQ9LyUm7sl+m1s
        RYZoSJrLRa5Usyo8X4m8wrjHgOulPh+yjrJjy8x/I+QyTROiB6m1nYgOzY9/hYCvzzWHv31SVsfaI
        qgk9jVZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0nzl-00BZbz-L2; Tue, 06 Jul 2021 16:32:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] iomap: Remove length variable in iomap_seek_hole()
Date:   Tue,  6 Jul 2021 17:31:57 +0100
Message-Id: <20210706163158.2758223-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706163158.2758223-1-willy@infradead.org>
References: <20210706163158.2758223-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's no need to calculate and maintain 'length'.  It's shorter and
simpler code to just calculate size - offset each time around the loop.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reported-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/seek.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 241169b49af8..4f711e1269e0 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -35,23 +35,21 @@ loff_t
 iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
 	loff_t size = i_size_read(inode);
-	loff_t length = size - offset;
 	loff_t ret;
 
 	/* Nothing to be found before or beyond the end of the file. */
 	if (offset < 0 || offset >= size)
 		return -ENXIO;
 
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
-				  &offset, iomap_seek_hole_actor);
+	while (offset < size) {
+		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
+				ops, &offset, iomap_seek_hole_actor);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
 			break;
 
 		offset += ret;
-		length -= ret;
 	}
 
 	return offset;
-- 
2.30.2

