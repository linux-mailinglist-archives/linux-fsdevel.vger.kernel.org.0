Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6040514D241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 22:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgA2VEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 16:04:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30405 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727208AbgA2VEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580331839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=r0KdhIk6vdsvsxafx/5yol6YXj51zDU8/Pl0eKaAZKw=;
        b=hxu7XYE5K8uaO4GEFc7op9xzlmP1B3XdUySN2V/r5K1w0W5c+4Mh/Qj3nVk8WcTOfwmeem
        fXonMdNEpY2TmyjBI94le6W2ZnKO1Eqk0iICxB6s8meQePXpI9bYx8sgPSkYanKrBmyBEv
        Hdnbm9eihvjntwM7Ruf3ORV0CZnrXJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-VxC5R8yBMImShVyDuAXhlQ-1; Wed, 29 Jan 2020 16:03:39 -0500
X-MC-Unique: VxC5R8yBMImShVyDuAXhlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A47F13E8;
        Wed, 29 Jan 2020 21:03:38 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBD6187B09;
        Wed, 29 Jan 2020 21:03:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6DEE42202E9; Wed, 29 Jan 2020 16:03:37 -0500 (EST)
Date:   Wed, 29 Jan 2020 16:03:37 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
Subject: [RFC][PATCH] dax: Do not try to clear poison for partial pages
Message-ID: <20200129210337.GA13630@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am looking into getting rid of dependency on block device in dax
path. One such place is __dax_zero_page_range() which checks if
range being zeroed is aligned to block device logical size, then
it calls bdev_issue_zeroout() instead of doing memset(). Calling
blkdev_issue_zeroout() also clears bad blocks and poison if any
in that range.

This path is used by iomap_zero_range() which in-turn is being
used by filesystems to zero partial filesystem system blocks.
For zeroing full filesystem blocks we seem to be calling
blkdev_issue_zeroout() which clears bad blocks and poison in that
range.

So this code currently only seems to help with partial filesystem
block zeroing. That too only if truncation/hole_punch happens on
device logical block size boundary.

To avoid using blkdev_issue_zeroout() in this path, I proposed another
patch here which adds another dax operation to zero out a rangex and
clear poison.

https://lore.kernel.org/linux-fsdevel/20200123165249.GA7664@redhat.com/

Thinking more about it, it might be an overkill to solve this problem.

How about if we just not clear poison/bad blocks when a partial page
is being zeroed. IOW, users will need to hole_punch whole filesystem
block worth of data which will free that block and it will be zeroed
some other time and clear poison in the process. For partial fs block
truncation/punch_hole, we don't clear poison.

If above interface is acceptable, then we can get rid of code which
tries to call blkdev_issue_zeroout() in iomap_zero_range() path and
we don't have to implement another dax operation.

Looking for some feedback on this.

Vivek
 
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c |   50 +++++++++++++++-----------------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

Index: redhat-linux/fs/dax.c
===================================================================
--- redhat-linux.orig/fs/dax.c	2020-01-29 15:19:18.551902448 -0500
+++ redhat-linux/fs/dax.c	2020-01-29 15:40:56.584824549 -0500
@@ -1044,47 +1044,27 @@ static vm_fault_t dax_load_hole(struct x
 	return ret;
 }
 
-static bool dax_range_is_aligned(struct block_device *bdev,
-				 unsigned int offset, unsigned int length)
-{
-	unsigned short sector_size = bdev_logical_block_size(bdev);
-
-	if (!IS_ALIGNED(offset, sector_size))
-		return false;
-	if (!IS_ALIGNED(length, sector_size))
-		return false;
-
-	return true;
-}
-
 int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
 		unsigned int offset, unsigned int size)
 {
-	if (dax_range_is_aligned(bdev, offset, size)) {
-		sector_t start_sector = sector + (offset >> 9);
-
-		return blkdev_issue_zeroout(bdev, start_sector,
-				size >> 9, GFP_NOFS, 0);
-	} else {
-		pgoff_t pgoff;
-		long rc, id;
-		void *kaddr;
-
-		rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
-		if (rc)
-			return rc;
-
-		id = dax_read_lock();
-		rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
-		if (rc < 0) {
-			dax_read_unlock(id);
-			return rc;
-		}
-		memset(kaddr + offset, 0, size);
-		dax_flush(dax_dev, kaddr + offset, size);
+	pgoff_t pgoff;
+	long rc, id;
+	void *kaddr;
+
+	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+	if (rc)
+		return rc;
+
+	id = dax_read_lock();
+	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	if (rc < 0) {
 		dax_read_unlock(id);
+		return rc;
 	}
+	memset(kaddr + offset, 0, size);
+	dax_flush(dax_dev, kaddr + offset, size);
+	dax_read_unlock(id);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);

