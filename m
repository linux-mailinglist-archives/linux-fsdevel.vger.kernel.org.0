Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB54738F4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjFUSzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjFUSzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:55:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2EF1BF0;
        Wed, 21 Jun 2023 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=te1f4OlSd0by5DtHSxut7Jhlx4s9DNKePG9AsBNJq8M=; b=bZMeVWRMoDwIOxuEF6gFvQAIjU
        PWhQToljFSQzlZ17LHqM++OXP3QJ6k28+C8zOmR+OZlvedtWjLxOv+GIufZuPteeby2Oakpb1yHLm
        hKbUsI4Ez0W91olbGBpDUuB4UIQ7H22QDcO84jY1CAnkY9AjwA7o2CNCJkBkvs91ZWvGKClvgqHZe
        ixW8cpJXjlyDV5w31OMECJEzrWgWnxHq01VL9sEE/d9snDoGQ3wM4K2dK6WDdb8Ufjx33q3uZJ2et
        JWPjHcMxIN0dFPwA98Emd7ifjy9BBFNVONBMi0rO0FLKYK0wNv2TjnxDWCsgK9byBuUbVDcZKsqQx
        yMNmjFGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qC2zJ-00Eu2y-Su; Wed, 21 Jun 2023 18:55:29 +0000
Date:   Wed, 21 Jun 2023 19:55:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] For DIO writes with no mapped pages for inode, skip
 deferring completion.
Message-ID: <ZJNHoWGqkVEVStXz@casper.infradead.org>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
 <20230621174114.1320834-2-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621174114.1320834-2-bongiojp@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:29:20AM -0700, Jeremy Bongio wrote:
> +++ b/fs/iomap/direct-io.c
> @@ -168,7 +168,9 @@ void iomap_dio_bio_end_io(struct bio *bio)
>  			struct task_struct *waiter = dio->submit.waiter;
>  			WRITE_ONCE(dio->submit.waiter, NULL);
>  			blk_wake_io_task(waiter);
> -		} else if (dio->flags & IOMAP_DIO_WRITE) {
> +		} else if (dio->flags & IOMAP_DIO_WRITE &&
> +			(!dio->iocb->ki_filp->f_inode ||
> +			    dio->iocb->ki_filp->f_inode->i_mapping->nrpages))) {

I don't think it's possible for file->f_inode to be NULL here, is it?
At any rate, that amount of indirection is just nasty.  How about this?

+++ b/fs/iomap/direct-io.c
@@ -161,15 +161,19 @@ void iomap_dio_bio_end_io(struct bio *bio)
                        struct task_struct *waiter = dio->submit.waiter;
                        WRITE_ONCE(dio->submit.waiter, NULL);
                        blk_wake_io_task(waiter);
-               } else if (dio->flags & IOMAP_DIO_WRITE) {
+               } else {
                        struct inode *inode = file_inode(dio->iocb->ki_filp);

                        WRITE_ONCE(dio->iocb->private, NULL);
-                       INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
-                       queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
-               } else {
-                       WRITE_ONCE(dio->iocb->private, NULL);
-                       iomap_dio_complete_work(&dio->aio.work);
+                       if (dio->flags & IOMAP_DIO_WRITE &&
+                           (inode->i_mapping->nrpages > 0) {
+                               INIT_WORK(&dio->aio.work,
+                                               iomap_dio_complete_work);
+                               queue_work(inode->i_sb->s_dio_done_wq,
+                                               &dio->aio.work);
+                       } else {
+                               iomap_dio_complete_work(&dio->aio.work);
+                       }
                }
        }

