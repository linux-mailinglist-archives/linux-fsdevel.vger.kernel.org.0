Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF467D796
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 22:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjAZVU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 16:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjAZVUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:20:25 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A776F236;
        Thu, 26 Jan 2023 13:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OyMmbQjqQ8dAXFMxu0rk+Siiwa3pnnY+UeL2D5uyoDk=; b=ngqDh7zz2+gwZaoFoM2ETEvBEG
        AUmO2E356GQZ/0HvsfY/9EkTvdaXiqt6tdD7JDKZGAChHxG4gmU+uBSU3YEHo49OsQcp2Q2EgcWmi
        FgzmAg0C0qBNJwAOn4SGS8HVL/Lzh4goJTiA0+/JZRKJ6IMFrYn6ies65fWz0ItYl3wM6wdq0ZBct
        zJ2QufnJP000c2bpGoeq6cQbMtLsJIPXHE6L+1KfGjL7rjnQe+faaiH54C9aH9vCEAwZE4m38XnEO
        0L8/OlqOUNUBc1ss7AU6W9anGvaMH0mtgSDkY6fpdUhr7voFWAPB4JayKT4tPJiUhJg8a9vU+zEFX
        49ZBww+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pL9fQ-004Jnu-2E;
        Thu, 26 Jan 2023 21:20:20 +0000
Date:   Thu, 26 Jan 2023 21:20:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: build the legacy direct I/O code conditionally
Message-ID: <Y9LulMOE1BnUMP2l@ZenIV>
References: <20230125065839.191256-1-hch@lst.de>
 <20230125065839.191256-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125065839.191256-3-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:58:39AM +0100, Christoph Hellwig wrote:
> Add a new LEGACY_DIRECT_IO config symbol that is only selected by the
> file systems that still use the legacy blockdev_direct_IO code, so that
> kernels without support for those file systems don't need to build the
> code.

Looks sane...  FWIW, I've got this in the misc pile; doesn't seem to
conflict anything in your series, thankfully...

commit 193010cdc86da0126c58f58bbeacfcb5a15e6cee
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Jan 19 19:22:22 2023 -0500

    __blockdev_direct_IO(): get rid of submit_io callback
    
    always NULL...
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 03d381377ae1..c2736da875cc 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -86,7 +86,6 @@ struct dio_submit {
 	sector_t final_block_in_request;/* doesn't change */
 	int boundary;			/* prev block is at a boundary */
 	get_block_t *get_block;		/* block mapping function */
-	dio_submit_t *submit_io;	/* IO submition function */
 
 	loff_t logical_offset_in_bio;	/* current first logical block in bio */
 	sector_t final_block_in_bio;	/* current final block in bio + 1 */
@@ -431,10 +430,7 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 
 	dio->bio_disk = bio->bi_bdev->bd_disk;
 
-	if (sdio->submit_io)
-		sdio->submit_io(bio, dio->inode, sdio->logical_offset_in_bio);
-	else
-		submit_bio(bio);
+	submit_bio(bio);
 
 	sdio->bio = NULL;
 	sdio->boundary = 0;
@@ -1122,7 +1118,7 @@ static inline int drop_refcount(struct dio *dio)
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		struct block_device *bdev, struct iov_iter *iter,
 		get_block_t get_block, dio_iodone_t end_io,
-		dio_submit_t submit_io, int flags)
+		int flags)
 {
 	unsigned i_blkbits = READ_ONCE(inode->i_blkbits);
 	unsigned blkbits = i_blkbits;
@@ -1239,7 +1235,6 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 	sdio.get_block = get_block;
 	dio->end_io = end_io;
-	sdio.submit_io = submit_io;
 	sdio.final_block_in_bio = -1;
 	sdio.next_block_for_io = -1;
 
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 1d65f6ef00ca..50448ba5fda8 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2448,7 +2448,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
 				    iter, get_block,
-				    ocfs2_dio_end_io, NULL, 0);
+				    ocfs2_dio_end_io, 0);
 }
 
 const struct address_space_operations ocfs2_aops = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..544b29a96fb0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3205,7 +3205,7 @@ enum {
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			     struct block_device *bdev, struct iov_iter *iter,
 			     get_block_t get_block,
-			     dio_iodone_t end_io, dio_submit_t submit_io,
+			     dio_iodone_t end_io,
 			     int flags);
 
 static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
@@ -3214,7 +3214,7 @@ static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
 					 get_block_t get_block)
 {
 	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
-			get_block, NULL, NULL, DIO_LOCKING | DIO_SKIP_HOLES);
+			get_block, NULL, DIO_LOCKING | DIO_SKIP_HOLES);
 }
 #endif
 
