Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E397A4F5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjIRQkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIRQkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:40:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0D29014;
        Mon, 18 Sep 2023 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6lDiEKrRXMJA2N279PscPh32vANLMIzmwG4EoyHb/zA=; b=g6bZQ93v1MSvnguNfY0FUHoR0K
        8pv1CptENiOT2Yytmv2STYyZJREvnpJj5h6aYkWyLkVGO3FQPBIubZRq4IfowwKiXtbt0gVrVU0W9
        Ai9HzR9WMFNY0mJDxN58Ms8wzSopWIsXootTzUliXYmQGmn4/NwsS6PHJXyWG8egjKqv4SPFdMyv6
        Z/GVvOhBt31uZafKvcHDBeIskPBpHfRFlm6k/cGw7v9uSpbuwd6Qf2b7kL6KFRz7noDdvCv+0WNMf
        33xjEpykrkSBBjdRuMhnEYwv4aZyNGlNH0iNMC3T4lpzEc/9PY4QP7clKe/+5PIfWO1SM2PZunREK
        9A1l+/Ag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiHEb-00C3j6-SN; Mon, 18 Sep 2023 16:36:29 +0000
Date:   Mon, 18 Sep 2023 17:36:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/18] block/buffer_head: introduce
 block_{index_to_sector,sector_to_index}
Message-ID: <ZQh8jXqpHFXQyEDT@casper.infradead.org>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918110510.66470-4-hare@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:04:55PM +0200, Hannes Reinecke wrote:
> @@ -449,6 +450,22 @@ __bread(struct block_device *bdev, sector_t block, unsigned size)
>  
>  bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
>  
> +static inline sector_t block_index_to_sector(pgoff_t index, unsigned int blkbits)
> +{
> +	if (PAGE_SHIFT < blkbits)
> +		return (sector_t)index >> (blkbits - PAGE_SHIFT);
> +	else
> +		return (sector_t)index << (PAGE_SHIFT - blkbits);
> +}

Is this actually more efficient than ...

	loff_t pos = (loff_t)index * PAGE_SIZE;
	return pos >> blkbits;

It feels like we're going to be doing this a lot, so we should find out
what's actually faster.

