Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B8727E68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 13:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjFHLH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjFHLGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:06:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B203AA2;
        Thu,  8 Jun 2023 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cT8NDVtiIsZNzV7dqaCyqaAv6UgEz/7VfiIdR+IkQQM=; b=kiJFIQ1nAL+TXJv9FL1MxdQxRn
        MjE37b6TUrn3o2T+X8RTjzxc9dFoJwc13B1cxCTfAgHHieEEThz+nOulB+CXAbbC1Y0y85FoWFx1G
        VraKXIbJAMCy3hW0e3Z3ki4QwJEvq9BK9L16/RF4/o2PenRIOj00eETs5fBt1PFSS9iM3+erOXzTk
        Zaq0wNsryRPVn+c0ll3/+zPoyHsu/DIq1VB+b/aXjSerkeOYW0iTLL8nU8Au3EkY8EtDDZIBLMWmS
        WhjQhMLxjLCE3gWrcxXeubo/4FAPO6sinlscv6PM4NW47r2uUyAy4fyteW4jDGY1V2cNPUKALpg8d
        C5CDVyMw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7DRI-0092xn-1H;
        Thu, 08 Jun 2023 11:04:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 29/30] block: store the holder in file->private_data
Date:   Thu,  8 Jun 2023 13:02:57 +0200
Message-Id: <20230608110258.189493-30-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Store the file struct used as the holder in file->private_data as an
indicator that this file descriptor was opened exclusively to  remove
the last use of FMODE_EXCL.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0d714d050a462c..9871bd6052b416 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -478,7 +478,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
 		mode |= BLK_OPEN_READ;
 	if (file->f_mode & FMODE_WRITE)
 		mode |= BLK_OPEN_WRITE;
-	if (file->f_mode & FMODE_EXCL)
+	if (file->private_data)
 		mode |= BLK_OPEN_EXCL;
 	if (file->f_flags & O_NDELAY)
 		mode |= BLK_OPEN_NDELAY;
@@ -507,12 +507,15 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	filp->f_flags |= O_LARGEFILE;
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
+	/*
+	 * Use the file private data to store the holder for exclusive openes.
+	 * file_to_blk_mode relies on it being present to set BLK_OPEN_EXCL.
+	 */
 	if (filp->f_flags & O_EXCL)
-		filp->f_mode |= FMODE_EXCL;
+		filp->private_data = filp;
 
 	bdev = blkdev_get_by_dev(inode->i_rdev, file_to_blk_mode(filp),
-				 (filp->f_mode & FMODE_EXCL) ? filp : NULL,
-				 NULL);
+				 filp->private_data, NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
@@ -523,8 +526,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 
 static int blkdev_release(struct inode *inode, struct file *filp)
 {
-	blkdev_put(I_BDEV(filp->f_mapping->host),
-		   (filp->f_mode & FMODE_EXCL) ? filp : NULL);
+	blkdev_put(I_BDEV(filp->f_mapping->host), filp->private_data);
 	return 0;
 }
 
-- 
2.39.2

