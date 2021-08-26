Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFDD3F8996
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbhHZOBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 10:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242728AbhHZOBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:01:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6138AC061757;
        Thu, 26 Aug 2021 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xsgIFzxQcm7/75yk92P3+DjSD9vC4RZ+TXwp6UhKe3M=; b=PNHWaM6ldrtGq8lNZSRanVORBt
        8Qv4vpsL6DawDYhdSMaSDIixgGGOqnS7vZbaODeQl7TMGtGwfmkhQK5HI/b8S31Dw3kPYcKgRvgfm
        3kXNMDS9ze8QxvKaqXR83qnFLvSC/2mp9Cg7tkoBqcEkL3IjxffpYfabLnIVQdi3CeT/PDwcn9awG
        O05RnaeACziZmFROZbx66xe+Fz9Tu+Wg0eOet7QTTfXCKlWOq7zaaXJmXUSRxpgPAhhIyOzi+kBii
        1sC9Tu3QWvG72aElKbplMkpbz8EB7eBwI74mYZ3p1ANgH6zxVnK3c/joyYjxRxlTwNj+Xs8q1O5RC
        wUptimng==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFt0-00DM9a-1Y; Thu, 26 Aug 2021 13:58:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 3/9] dm: use fs_dax_get_by_bdev instead of dax_get_by_host
Date:   Thu, 26 Aug 2021 15:55:04 +0200
Message-Id: <20210826135510.6293-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826135510.6293-1-hch@lst.de>
References: <20210826135510.6293-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no point in trying to finding the dax device if the DAX flag is
not set on the queue as none of the users of the device mapper exported
block devices could make use of the DAX capability.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/md/dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2c5f9e585211..465714341300 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -650,7 +650,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
 	}
 
 	td->dm_dev.bdev = bdev;
-	td->dm_dev.dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
+	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
 	return 0;
 }
 
-- 
2.30.2

