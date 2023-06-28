Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333FE740F8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjF1LCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 07:02:31 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:49718 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230378AbjF1LCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:02:30 -0400
X-UUID: 4308640215a311ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=89B20YeAg/sOI5tG4Ue+qiZY0x7A1oBUW3Grt3g3ZCU=;
        b=n+IxyXmA/vpGQ/x+aT8zShgmrAKvIwjk05Vapqo6Crr0MHy7Ym6vKwHAcEoYQG1jU78GZ6SAUzLSP5XARymogSX53BaKPu8YjQSpbW6ZaZTL7cztqrtKKAPgnSNxVA/JaWfxv5g+XaM0vPNzU1RNiJBDHvXSiJZyVjYczcZoQDQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:be728f6c-1bf8-4837-aa5f-643e8c048368,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.27,REQID:be728f6c-1bf8-4837-aa5f-643e8c048368,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:01c9525,CLOUDID:6c2d550d-26a8-467f-b838-f99719a9c083,B
        ulkID:230628190225D6R83717,BulkQuantity:1,Recheck:0,SF:17|19|48|29|28,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,
        TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: 4308640215a311ee9cb5633481061a41-20230628
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1725509563; Wed, 28 Jun 2023 19:02:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 19:02:23 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 19:02:22 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <xiaoming.yu@mediatek.com>,
        Haibo Li <haibo.li@mediatek.com>
Subject: [PATCH] mm/filemap.c:fix update prev_pos after one read request done
Date:   Wed, 28 Jun 2023 19:02:20 +0800
Message-ID: <20230628110220.120134-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ra->prev_pos tracks the last visited byte in the previous read request.
It is used to check whether it is sequential read in
ondemand_readahead and thus affects the readahead window.

From commit 06c0444290ce ("mm/filemap.c: generic_file_buffered_read()
now uses find_get_pages_contig"),update logic of prev_pos is changed.
It updates prev_pos after each returns from filemap_get_pages.
But the read request from user may be not fully completed
at this point.
The updated prev_pos impacts the subsequent readahead window.

The real problem is performance drop of fsck_msdos between linux-5.4
and linux-5.15(also linux-6.4).
Comparing to linux-5.4,It spends about 110% time and read 140% pages.
The read pattern of fsck_msdos is not fully sequential.

Simplified read pattern of fsck_msdos likes below:
1.read at page offset 0xa,size 0x1000
2.read at other page offset like 0x20,size 0x1000
3.read at page offset 0xa,size 0x4000
4.read at page offset 0xe,size 0x1000

Here is the read status on linux-6.4:
1.after read at page offset 0xa,size 0x1000
    ->page ofs 0xa go into pagecache
2.after read at page offset 0x20,size 0x1000
    ->page ofs 0x20 go into pagecache
3.read at page offset 0xa,size 0x4000
    ->filemap_get_pages read ofs 0xa from pagecache and returns
    ->prev_pos is updated to 0xb and goto next loop
    ->filemap_get_pages tends to read ofs 0xb,size 0x3000
    ->initial_readahead case in ondemand_readahead since prev_pos is
      the same as request ofs.
    ->read 8 pages while async size is 5 pages
      (PageReadahead flag at page 0xe)
4.read at page offset 0xe,size 0x1000
    ->hit page 0xe with PageReadahead flag set,double the ra_size.
      read 16 pages while async size is 16 pages
Now it reads 24 pages while actually uses 5 pages

on linux-5.4:
1.the same as 6.4
2.the same as 6.4
3.read at page offset 0xa,size 0x4000
    ->read ofs 0xa from pagecache
    ->read ofs 0xb,size 0x3000 using page_cache_sync_readahead
      read 3 pages
    ->prev_pos is updated to 0xd before generic_file_buffered_read
      returns
4.read at page offset 0xe,size 0x1000
    ->initial_readahead case in ondemand_readahead since
      request ofs-prev_pos==1
    ->read 4 pages while async size is 3 pages

Now it reads 7 pages while actually uses 5 pages.

In above demo,the initial_readahead case is triggered by offset
of user request on linux-5.4.
While it may be triggered by update logic of prev_pos on linux-6.4.

To fix the performance drop,update prev_pos after finishing one read
request.

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
---
 mm/filemap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 83dda76d1fc3..16b2054eee71 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2670,6 +2670,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	int i, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
+	loff_t last_pos = ra->prev_pos;
 
 	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
 		return 0;
@@ -2721,8 +2722,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 * When a read accesses the same folio several times, only
 		 * mark it as accessed the first time.
 		 */
-		if (!pos_same_folio(iocb->ki_pos, ra->prev_pos - 1,
-							fbatch.folios[0]))
+		if (!pos_same_folio(iocb->ki_pos, last_pos - 1,
+				    fbatch.folios[0]))
 			folio_mark_accessed(fbatch.folios[0]);
 
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
@@ -2749,7 +2750,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 
 			already_read += copied;
 			iocb->ki_pos += copied;
-			ra->prev_pos = iocb->ki_pos;
+			last_pos = iocb->ki_pos;
 
 			if (copied < bytes) {
 				error = -EFAULT;
@@ -2763,7 +2764,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
-
+	ra->prev_pos = last_pos;
 	return already_read ? already_read : error;
 }
 EXPORT_SYMBOL_GPL(filemap_read);
-- 
2.25.1

