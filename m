Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510633E3FBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhHIGUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhHIGUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:20:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC1EC0613CF;
        Sun,  8 Aug 2021 23:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SpLa8xXiLETp482f8TpSRj3+HkNL4ciTetnk4qLMMXw=; b=mHdHdUrJlcIc6ESaFKdhQAawPn
        xz0iqi09VROOHtse6qm8Y3s/y1xzvMzeLG01UTRYYFxs90MPHtcEQhEBU9ymW9hclbo32Bbrx9ufb
        XTXg/c16sdqFEPriHlsFM1eg9yioXtRTZw5/ETk27QJW7hIMvn0jO+qlk1z/QnLeJyZfx58nXFsIv
        h7aQ4FYAusw9lKK9/dYqyEYFGIdCVsNdn7PcHLkuOjK9cNmwy7/6Hq5BuV7ddsdlyE/2cYYUBnqVC
        nRMNn3P57qbEqJzOetQlVsIrDSl2/nDvVcWonB1Dq4ywampCoQyve8jXHvRSeFq32zZ+rvYLAYt+E
        cP9wzFJw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCycj-00Agjm-EB; Mon, 09 Aug 2021 06:19:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 08/30] iomap: mark the iomap argument to iomap_read_inline_data const
Date:   Mon,  9 Aug 2021 08:12:22 +0200
Message-Id: <20210809061244.1196573-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_read_inline_data never modifies the passed in iomap, so mark
it const.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8a7746433bc719..eda8892b8c5741 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -206,7 +206,7 @@ struct iomap_readpage_ctx {
 };
 
 static int iomap_read_inline_data(struct inode *inode, struct page *page,
-		struct iomap *iomap)
+		const struct iomap *iomap)
 {
 	size_t size = i_size_read(inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
-- 
2.30.2

