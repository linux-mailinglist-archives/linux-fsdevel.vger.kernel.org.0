Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E82C276F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbgKXN2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388155AbgKXN2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A71C0613D6;
        Tue, 24 Nov 2020 05:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NU6baGQPMXpwn5pZ9gkDp3IVsd46BLx4N0SPrDXIchU=; b=EOAAPNtRZFDVKupvihhdIus3Uz
        DNcSizR54IlzQ7Yfr89Ztz2DVmH9B56VSYARQNlWEzEsbYaSuBOk0LN/us9lcD3b6z4L57avlUNBE
        X4UKxelEsGPLgoQ09dZONBvDgAZb9jXyd26PP9jeByPVcEQyALdmqCNoTI2Cal6EFAtVUX5nT7Vop
        Nqz1yf0Thq+fRg7FEzTN8nRwmL+HGPwAbN5hTH5oRcYFIFi33RiiVucACgiK9rfIk89I/c8SPq3fT
        xRcT6wCXamprxrUeW4unnNl7FZEsCMl6MwdVBhSFlNLC6OdMvXQXphLXXTwQIzV1e8E6JzrATYINy
        HhUQ1aeQ==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYMh-0006Ww-C9; Tue, 24 Nov 2020 13:28:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 14/45] block: use disk_part_iter_exit in disk_part_iter_next
Date:   Tue, 24 Nov 2020 14:27:20 +0100
Message-Id: <20201124132751.3747337-15-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call disk_part_iter_exit in disk_part_iter_next instead of duplicating
the functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/genhd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 4e039524f92b8f..0bd9c41dd4cb69 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -227,8 +227,7 @@ struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
 	int inc, end;
 
 	/* put the last partition */
-	disk_put_part(piter->part);
-	piter->part = NULL;
+	disk_part_iter_exit(piter);
 
 	/* get part_tbl */
 	rcu_read_lock();
-- 
2.29.2

