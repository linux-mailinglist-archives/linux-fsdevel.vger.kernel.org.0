Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C817A4D16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjIRPqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjIRPqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:46:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE322D40;
        Mon, 18 Sep 2023 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DKGFCFUpAK0noAIxjiDksGMSY4ineXUuIBcj1O7WrJg=; b=fOSMF/uZUGHhxFtL4fe4Si103O
        q+lYrDl9HQghpxZNev2mRSnMyNz99/MQe/fk0jQWrZPf4BGP7GJTwyk1TKLhH7DYrFfwfCMEAw19Z
        M/1P1OivkJGczpn1yvhDqbhVslG1onQuH1opW5rTsbIFJczhbnAfcJznDZin0aceLL8K/BF5+haBl
        InkJdz6bJjA6I8TUFmnhh1bcR/800pejH5Hu95Ctx1eSfTyUzD6povg66jnz3jR/i5OoQ32sNY5nW
        5VJPq4mvER+EjHTPhywKFiBL4jL7kKeMhqBu3owsvNL36PPRf0Pk/25SEgS0GXo0hP869AS2h/SR7
        BZNMvYHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiE5g-00BCbj-2d; Mon, 18 Sep 2023 13:15:04 +0000
Date:   Mon, 18 Sep 2023 14:15:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/18] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Message-ID: <ZQhNWB8zwD2nBiLJ@casper.infradead.org>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918110510.66470-3-hare@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:04:54PM +0200, Hannes Reinecke wrote:
> @@ -161,7 +161,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  	struct folio *folio = args->folio;
>  	struct inode *inode = folio->mapping->host;
>  	const unsigned blkbits = inode->i_blkbits;
> -	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
> +	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
>  	const unsigned blocksize = 1 << blkbits;
>  	struct buffer_head *map_bh = &args->map_bh;
>  	sector_t block_in_file;
> @@ -169,7 +169,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  	sector_t last_block_in_file;
>  	sector_t blocks[MAX_BUF_PER_PAGE];
>  	unsigned page_block;
> -	unsigned first_hole = blocks_per_page;
> +	unsigned first_hole = blocks_per_folio;
>  	struct block_device *bdev = NULL;
>  	int length;
>  	int fully_mapped = 1;

I feel like we need an assertion that blocks_per_folio <=
MAX_BUF_PER_PAGE.  Otherwise this function runs off the end of the
'blocks' array.

Or (and I tried to do this once before getting bogged down), change this
function to not need the blocks array.  We need (first_block, length),
because this function will punt to 'confused' if theree is an on-disk
discontiguity.

ie this line needs to change:

-		if (page_block && blocks[page_block-1] != map_bh->b_blocknr-1)
+		if (page_block == 0)
+			first_block = map_bh->b_blocknr;
+		else if (first_block + page_block != map_bh->b_blocknr)
			goto confused;

> @@ -474,12 +474,12 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
>  	struct address_space *mapping = folio->mapping;
>  	struct inode *inode = mapping->host;
>  	const unsigned blkbits = inode->i_blkbits;
> -	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
> +	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
>  	sector_t last_block;
>  	sector_t block_in_file;
>  	sector_t blocks[MAX_BUF_PER_PAGE];
>  	unsigned page_block;
> -	unsigned first_unmapped = blocks_per_page;
> +	unsigned first_unmapped = blocks_per_folio;
>  	struct block_device *bdev = NULL;
>  	int boundary = 0;
>  	sector_t boundary_block = 0;

Similarly, this function needss an assert.  Or remove blocks[].

