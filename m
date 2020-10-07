Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B6285842
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 07:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgJGFub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGFua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 01:50:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F5C061755;
        Tue,  6 Oct 2020 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=apKScFZIhdc8xLC/lbMea+vyyRRH35uOF3Of5HT7aUI=; b=SIC1f6u7xCCm22MEDA4x+aTgRG
        7+csrADbTzVzGWG++sYvK9JfPnZjetjafAhZWfyArVgwuNnwzh2Et4kI6QLK897s1KLAjPy+Adn7h
        ZAM/WVoWb9nM8mNR3hedNczWO2wv7LpyZQjkco47umK3mWIiWlaoPEb3U/N9mNt+bbzPp92mPvyRJ
        220qKQKIhbVu4qO4dWlrEilHOrAF0Oyr7QEv1xaggRxRFxMHAmU1gNG7qAdgLpMnObHw0yRPrEJMt
        W84bNLDcYiQ//IQT6U3Yyo38Gfv/4QGmiHhjSiFat1VcjvFtYMTWNXAP+lsGVlf9lsP/A9Yupsf8h
        ICCLaD+Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ2LI-0004VU-Ml; Wed, 07 Oct 2020 05:50:24 +0000
Date:   Wed, 7 Oct 2020 06:50:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: make maximum zone append size configurable
Message-ID: <20201007055024.GB16556@infradead.org>
References: <8fe2e364c4dac89e3ecd1234fab24a690d389038.1601993564.git.johannes.thumshirn@wdc.com>
 <CY4PR04MB375140F36014D95A7AA439A8E70D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375140F36014D95A7AA439A8E70D0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 7dda709f3ccb..78817d7acb66 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -246,6 +246,11 @@ queue_max_sectors_store(struct request_queue *q, const char
> *page, size_t count)
>         spin_lock_irq(&q->queue_lock);
>         q->limits.max_sectors = max_sectors_kb << 1;
>         q->backing_dev_info->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
> +
> +       q->limits.max_zone_append_sectors =
> +               min(q->limits.max_sectors,
> +                   q->limits.max_hw_zone_append_sectors);
> +
>         spin_unlock_irq(&q->queue_lock);
> 
>         return ret;

Yes, this looks pretty sensible.  I'm not even sure we need the field,
just do the min where we build the bio instead of introducing another
field that needs to be maintained.
