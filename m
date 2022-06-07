Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B375401C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbiFGOt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 10:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343535AbiFGOt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:49:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E9F95DED
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pULUE8VZOPWVJ5irnfCURf5K0pMF23cPp4yeAO+4Jko=; b=LXqz1Zebo2Lv+fGAHxATK0s6OY
        GGVW4YcdE+f7NzYCuLNb5GHr/aWKF4mBMbB1k8cGrH4joaNp4blpK8dE39STdaqMMo0sJDE2MFPdq
        Gj5JMv4AfDqOWhI8vZKu0Wl1usawiBHS11GHsaJuN3L5KglX54f/cbOYb9BOgZ/ajIVGvbVAKlkDq
        wgoGw7/JZsNVrD8QM9vPZSPyKqRIoynU6Qyr9Sqg/R/WxXVaWojHlHLOXstfQG74ZUf4yf8+S3pe1
        oafEVq7zUUWpFmZiG8Z4ECutt6M4Hb8saFGJhjOX3w2h/MXJcvG95kYBs4fuWBnKmxXOo5I1eMuKV
        yKRXQmnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyaWL-00BiYK-6o; Tue, 07 Jun 2022 14:49:25 +0000
Date:   Tue, 7 Jun 2022 15:49:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] btrfs_direct_write(): cleaner way to handle
 generic_write_sync() suppression
Message-ID: <Yp9ldUZMmDmBaPSU@casper.infradead.org>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <Yp7PlaCTJF19m2sG@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7PlaCTJF19m2sG@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:09:57AM +0000, Al Viro wrote:
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e552097c67e0..95de0c771d37 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -353,6 +353,8 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_PARTIAL		(1 << 2)
>  
> +#define IOMAP_DIO_NOSYNC		(1 << 3)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);

You didn't like the little comment I added?

+/*
+ * The caller will sync the write if needed; do not sync it within
+ * iomap_dio_rw.  Overrides IOMAP_DIO_FORCE_WAIT.
+ */

