Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEA16F6D93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjEDOQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 10:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjEDOQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 10:16:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400118687;
        Thu,  4 May 2023 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Hnl7RKx0Q6XGEhYYTUEZyfjo56ovfMM3HhYaGLUEew=; b=juJfjc0Yf5CWyCFAP2JWhWBuJ+
        RNQBQPJiNd6LgJNn7t9nBYHhSutlYwsNJbdjur9XymvEny7X+wSvNkwxDwT+2VGva/2A6JozpfEG+
        tkUKLUTVx30Gr9jI43sgPNdZJucPICfOWUhUVcF6HhgND8ZsnBPYFR1r4Ksn9HKD6CAyVgDySDubL
        sEnS5tY6vbfV4/Na52UHzcQ8aPBK8tPIrOocU8avbJ62u4J1wO9CBUZ5UO8pnvwIdBs/MbERlT1Ix
        NNZuyBwO2xEiCwIuMrOzg7ILjjn31107foZ2A3EsQywPR7EPCHm5rHYV9xosLa4YE9RRtuTF/UUe7
        PCbgbN1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puZl9-00AfJJ-68; Thu, 04 May 2023 14:16:39 +0000
Date:   Thu, 4 May 2023 15:16:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the block
 device
Message-ID: <ZFO+R0Ud6Yx546Tc@casper.infradead.org>
References: <20230504105624.9789-1-idryomov@gmail.com>
 <20230504135515.GA17048@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504135515.GA17048@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 03:55:15PM +0200, Christoph Hellwig wrote:
> On Thu, May 04, 2023 at 12:56:24PM +0200, Ilya Dryomov wrote:
> > Commit 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue
> > and a sb flag") introduced a regression for the raw block device use
> > case.  Capturing QUEUE_FLAG_STABLE_WRITES flag in set_bdev_super() has
> > the effect of respecting it only when there is a filesystem mounted on
> > top of the block device.  If a filesystem is not mounted, block devices
> > that do integrity checking return sporadic checksum errors.
> 
> With "If a file system is not mounted" you want to say "when accessing
> a block device directly" here, right?  The two are not exclusive..
> 
> > Additionally, this commit made the corresponding sysfs knob writeable
> > for debugging purposes.  However, because QUEUE_FLAG_STABLE_WRITES flag
> > is captured when the filesystem is mounted and isn't consulted after
> > that anywhere outside of swap code, changing it doesn't take immediate
> > effect even though dumping the knob shows the new value.  With no way
> > to dump SB_I_STABLE_WRITES flag, this is needlessly confusing.
> 
> But very much intentional.  s_bdev often is not the only device
> in a file system, and we should never reference if from core
> helpers.
> 
> So I think we should go with something like this:
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index db794399900734..aa36cc2a4530c1 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -3129,7 +3129,11 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
>   */
>  void folio_wait_stable(struct folio *folio)
>  {
> -	if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
> +	struct inode *inode = folio_inode(folio);
> +	struct super_block *sb = inode->i_sb;
> +
> +	if ((sb->s_iflags & SB_I_STABLE_WRITES) ||
> +	    (sb_is_blkdev_sb(sb) && bdev_stable_writes(I_BDEV(inode))))
>  		folio_wait_writeback(folio);
>  }
>  EXPORT_SYMBOL_GPL(folio_wait_stable);

I hate both of these patches ;-)  What we should do is add
AS_STABLE_WRITES, have the appropriate places call
mapping_set_stable_writes() and then folio_wait_stable() becomes

	if (mapping_test_stable_writes(folio->mapping))
		folio_wait_writeback(folio);

and we remove all the dereferences (mapping->host->i_sb->s_iflags, plus
whatever else is going on there)
