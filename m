Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139B05C535
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfGAVy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:54:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAVy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X6GvDNoOI41Z/n5Dn2AGSAr79qTeDuuYOQabvdZfOaM=; b=GJmAfgUEJNgOwVxnfN9F4kraDv
        BgohI5ASMow3m8QiYej1hL2u+WzGGUcwkV8UvIw7plddSI+oBwi18S8qr6hdmo5C28h6Vz4WWXS7S
        PYco5UnMklFDZu3fArI1YX7NRvc/lmyXAb6jK2S8YjFVz4L/y++JByebO7UWr3lXIC/8jVFmxcLU4
        01PKuKM2Jgk+4NmuwUHUUm8n17nzOZ2HeVSxfJnlrb042tQxtLWITkQjWMNIkYbBI+jtJ/toYi7wm
        9P7kKIFTxfa+Q0TXPhPaoCzSOw0bsayjJszn82xZ2z6h20brdN4terodyv+6wSF397wIBo/Kh2uK6
        aLcI8RBw==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4GE-0000Vm-MP; Mon, 01 Jul 2019 21:54:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 01/15] FOLD: iomap: make the discard_page method optional
Date:   Mon,  1 Jul 2019 23:54:25 +0200
Message-Id: <20190701215439.19162-2-hch@lst.de>
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

For file system that do not support delayed allocations there is
nothing to discard here, so don't require them to implement the
method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 72ba3962acf3..ebfff663b2a9 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -2545,7 +2545,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 */
 	if (unlikely(error)) {
 		if (!count) {
-			wpc->ops->discard_page(page);
+			if (wpc->ops->discard_page)
+				wpc->ops->discard_page(page);
 			ClearPageUptodate(page);
 			unlock_page(page);
 			goto done;
-- 
2.20.1

