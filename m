Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA24689D85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 16:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjBCPJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 10:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjBCPIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:08:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65345BAE;
        Fri,  3 Feb 2023 07:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kORmqO/9LhO3glrNFnQu4Hg9yMGINb4dC3Y3cN2SyCY=; b=41bYhxy4j/IlMzxFEoHx+Uxb/Q
        AoA7/uGEehM9h47lmjn1p7wMCxt9YN2chQRTwM9T0U2R33+6P5uw3dFU034X2phyy1FaKZr6D6uZm
        Iyou7KFZCyjd3dhhg9p+jbvkL4Nxb6yurGLVKQNvr7SNXOMsbnNpwH65HvZRyfpPA1+nugxrw2oX8
        3pBDdo50wrWXKZ0GhYhG/bn2vy2Q2l9fNSxBr73HSlVDIWqwtCuv2e6F0W3sVOzyMhe3c85OjeDqi
        nGFDVsH+onY5nUtibJnC/vm3UzB7E89Fvv+DR2t9yt7brPMGQYvg04XXc1+uC6uVfGrrzMou4bMyC
        6VNrGmvQ==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxf1-002b5b-7k; Fri, 03 Feb 2023 15:07:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 16/23] orangefs: use bvec_set_{page,folio} to initialize bvecs
Date:   Fri,  3 Feb 2023 16:06:27 +0100
Message-Id: <20230203150634.3199647-17-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150634.3199647-1-hch@lst.de>
References: <20230203150634.3199647-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the bvec_set_page and bvec_set_folio helpers to initialize bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/orangefs/inode.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4df56089438664..215f6cb3dc4129 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -49,10 +49,8 @@ static int orangefs_writepage_locked(struct page *page,
 	/* Should've been handled in orangefs_invalidate_folio. */
 	WARN_ON(off == len || off + wlen > len);
 
-	bv.bv_page = page;
-	bv.bv_len = wlen;
-	bv.bv_offset = off % PAGE_SIZE;
 	WARN_ON(wlen == 0);
+	bvec_set_page(&bv, page, wlen, off % PAGE_SIZE);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, wlen);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
@@ -102,15 +100,11 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 
 	for (i = 0; i < ow->npages; i++) {
 		set_page_writeback(ow->pages[i]);
-		ow->bv[i].bv_page = ow->pages[i];
-		ow->bv[i].bv_len = min(page_offset(ow->pages[i]) + PAGE_SIZE,
-		    ow->off + ow->len) -
-		    max(ow->off, page_offset(ow->pages[i]));
-		if (i == 0)
-			ow->bv[i].bv_offset = ow->off -
-			    page_offset(ow->pages[i]);
-		else
-			ow->bv[i].bv_offset = 0;
+		bvec_set_page(&ow->bv[i], ow->pages[i],
+			      min(page_offset(ow->pages[i]) + PAGE_SIZE,
+			          ow->off + ow->len) -
+			      max(ow->off, page_offset(ow->pages[i])),
+			      i == 0 ? ow->off - page_offset(ow->pages[i]) : 0);
 	}
 	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->npages, ow->len);
 
@@ -300,9 +294,7 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 		orangefs_launder_folio(folio);
 
 	off = folio_pos(folio);
-	bv.bv_page = &folio->page;
-	bv.bv_len = folio_size(folio);
-	bv.bv_offset = 0;
+	bvec_set_folio(&bv, folio, folio_size(folio), 0);
 	iov_iter_bvec(&iter, ITER_DEST, &bv, 1, folio_size(folio));
 
 	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
-- 
2.39.0

