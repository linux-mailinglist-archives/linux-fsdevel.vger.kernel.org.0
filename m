Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B3A76003A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGXUGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 16:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGXUGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:06:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE310D8;
        Mon, 24 Jul 2023 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2jND/zeI8uHtoArg4aO1euI9OYZphE1L7jOEyyzjSMo=; b=B2mdZ63Yq4tSlNC+K5cMn9zm0x
        L4fEjbhbhrY9zOztCGR22ejmPuFst2NWaADe/MCM2ck1T0P3OCapd4ms+ktd/2seV/PYWUwZJ/GSq
        wuxY1O+XOW2xesnA+0k/uOX2aZJtsuE2WBvWa3W9u6REGQLuryV9AKiGi3JUfOhiu/2n7Ogs48vsq
        EB80Oa5MgI/na4hIrtZEMP68sS50teUBgvjy3KOv7lSOkhcVoQjOW1j57TM8Uy5QjMtrrdJn611IV
        jTedHpc/aqUcqlYKJ+fa0a1CI/Ytfyyfoo4hm9U8kJ6sTuBK8DGR0lOVREwS0GErkkXmM2/PA02bA
        TsSgciWg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1ob-005MFt-1k;
        Mon, 24 Jul 2023 20:05:57 +0000
Date:   Mon, 24 Jul 2023 13:05:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] block: open code __generic_file_write_iter for
 blkdev writes
Message-ID: <ZL7ZpbSnJ/0DyUbu@bombadil.infradead.org>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720140452.63817-4-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:04:49PM +0200, Christoph Hellwig wrote:
> Open code __generic_file_write_iter to remove the indirect call into
> ->direct_IO and to prepare using the iomap based write code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/fops.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index a286bf3325c5d8..eb599a173ef02d 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -533,6 +533,29 @@ static int blkdev_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static ssize_t
> +blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	size_t count = iov_iter_count(from);
> +	ssize_t written;
> +
> +	written = kiocb_invalidate_pages(iocb, count);
> +	if (written) {
> +		if (written == -EBUSY)
> +			return 0;
> +		return written;
> +	}
> +
> +	written = blkdev_direct_IO(iocb, from);
> +	if (written > 0) {
> +		kiocb_invalidate_post_direct_write(iocb, count);
> +		iocb->ki_pos += written;
> +	}

I noted in the last series how this could be negative and then crash:

https://lkml.kernel.org/r/ZG6OTWckNlz+P+mo@bombadil.infradead.org

This can be fixed as follows:

diff --git a/block/fops.c b/block/fops.c
index eb599a173ef0..936ed207b5dc 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -536,9 +536,13 @@ static int blkdev_release(struct inode *inode, struct file *filp)
 static ssize_t
 blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	size_t count = iov_iter_count(from);
 	ssize_t written;
 
+	if (blkdev_dio_unaligned(bdev, iocb->ki_pos, from))
+                return -EINVAL;
+
 	written = kiocb_invalidate_pages(iocb, count);
 	if (written) {
 		if (written == -EBUSY)

With that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
