Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0B875BEC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGUGY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 02:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGUGY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:24:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F556CE;
        Thu, 20 Jul 2023 23:24:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D3CB6732D; Fri, 21 Jul 2023 08:24:23 +0200 (CEST)
Date:   Fri, 21 Jul 2023 08:24:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] fs: add CONFIG_BUFFER_HEAD
Message-ID: <20230721062423.GA20845@lst.de>
References: <20230720140452.63817-1-hch@lst.de> <20230720140452.63817-7-hch@lst.de> <ZLlId9+kXl5Tb7wj@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLlId9+kXl5Tb7wj@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 03:45:11PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 20, 2023 at 04:04:52PM +0200, Christoph Hellwig wrote:
> > @@ -400,7 +391,8 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >  	iomap->type = IOMAP_MAPPED;
> >  	iomap->addr = iomap->offset;
> >  	iomap->length = isize - iomap->offset;
> > -	iomap->flags |= IOMAP_F_BUFFER_HEAD;
> > +	if (IS_ENABLED(CONFIG_BUFFER_HEAD))
> > +		iomap->flags |= IOMAP_F_BUFFER_HEAD;
> 
> Wouldn't it be simpler to do ...
> 
> +#ifdef CONFIG_BUFFER_HEAD
>  #define IOMAP_F_BUFFER_HEAD     (1U << 4)
> +#else
> +#define IOMAP_F_BUFFER_HEAD	0
> +#endif
> 
> in include/linux/iomap.h ?

> ... because this function then goes away.

I guess we could do that.  It is less intrusive, but I have to say I find
flags that get defined away to 0 fairly confusing for the reader.
