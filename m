Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB8DB52F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395150AbfJQR5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 13:57:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394797AbfJQR5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Lveu2b/3PvukfmV9kCWYR6WLjRarWs0ASDrcIDPvYdY=; b=Gky3tV9LY2NLX/LaH7kfv4PIg/
        qn+Qvm7X9ybIAcvokaloMb0K57vXT/ZTdoJypKvVxK40D8CXjh4kEqqqsHWCcAEWzwoydslnr5OvM
        SAI+1v7seXYb9ppUvsRHAwjxs9oOklhxSip4uCdlL7JLMcRZA5Tj46SDXRXi0dlbFu3lSHmygVm47
        FmawoT2KEXEjmogOqbTh3PEztq87KEnjGduIV7BSRr+JFBkcrpd4GUG3/kaG7H2ILk6Iiy2f+KItU
        pJn3EExAve0OSpYHhwM5FiLTDEUeQV7ifL9mMyAfedvP/fSU6edtCkd9uDsDboBBE8rL+DhRwxSKI
        3Bs+o96Q==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLA1K-0001XK-DD; Thu, 17 Oct 2019 17:57:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] iomap: pass a struct page to iomap_finish_page_writeback
Date:   Thu, 17 Oct 2019 19:56:24 +0200
Message-Id: <20191017175624.30305-15-hch@lst.de>
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

No need to pass the full bio_vec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bb96499c352f..755b75424a97 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1110,13 +1110,13 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
 static void
-iomap_finish_page_writeback(struct inode *inode, struct bio_vec *bvec,
+iomap_finish_page_writeback(struct inode *inode, struct page *page,
 		int error)
 {
-	struct iomap_page *iop = to_iomap_page(bvec->bv_page);
+	struct iomap_page *iop = to_iomap_page(page);
 
 	if (error) {
-		SetPageError(bvec->bv_page);
+		SetPageError(page);
 		mapping_set_error(inode->i_mapping, -EIO);
 	}
 
@@ -1124,7 +1124,7 @@ iomap_finish_page_writeback(struct inode *inode, struct bio_vec *bvec,
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
 
 	if (!iop || atomic_dec_and_test(&iop->write_count))
-		end_page_writeback(bvec->bv_page);
+		end_page_writeback(page);
 }
 
 /*
@@ -1156,7 +1156,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 		/* walk each page on bio, ending page IO on them */
 		bio_for_each_segment_all(bv, bio, iter_all)
-			iomap_finish_page_writeback(inode, bv, error);
+			iomap_finish_page_writeback(inode, bv->bv_page, error);
 		bio_put(bio);
 	}
 
-- 
2.20.1

