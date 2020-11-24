Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860B22C279A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbgKXN3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbgKXN26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC86C0613D6;
        Tue, 24 Nov 2020 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IQo7+3FqwGn+nveEvbMImUHejQ6B6iul3lBAGXRT6S0=; b=Dsx0SI5F7fK6yGFNHizYK2Luqs
        OwGWEA5YdR00VnJlh8sw0Mn6T+j7LB7jv8MhUDWibdIObFF6A/ZF43bZIWLBCgxRKYGFNUkJJ7lCX
        9uBkrERnn2jWXDLuUpDe59yHT0uXNScCDoyaocQmmAzQjXpKlE4KAKPbpyUe8oYhjDaCLacF1DCg9
        9yAbwO/HOM5BkHkFS4np8Nd9Fd6Or5Eb6xBaCRgf0KNMcbJFJUCb3s3f0OWWQOleSUCquZS1yGdOP
        AQYd9fB3rQkdijuOCSdOSZ4uOqYuxhOl5dj8wm8XxGDymP9DbEN9XvguCVt7lDx0KagQxCdhTuk1a
        i/kX79lg==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYN7-0006dU-9l; Tue, 24 Nov 2020 13:28:41 +0000
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
Subject: [PATCH 28/45] block: simplify part_to_disk
Date:   Tue, 24 Nov 2020 14:27:34 +0100
Message-Id: <20201124132751.3747337-29-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that struct hd_struct has a block_device pointer use that to
find the disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/genhd.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index d068e46f9086ae..dcf86a3d4dedc4 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -219,13 +219,9 @@ struct gendisk {
 
 static inline struct gendisk *part_to_disk(struct hd_struct *part)
 {
-	if (likely(part)) {
-		if (part->partno)
-			return dev_to_disk(part_to_dev(part)->parent);
-		else
-			return dev_to_disk(part_to_dev(part));
-	}
-	return NULL;
+	if (unlikely(!part))
+		return NULL;
+	return part->bdev->bd_disk;
 }
 
 static inline int disk_max_parts(struct gendisk *disk)
-- 
2.29.2

