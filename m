Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8E7A5130
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjIRRpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRRpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:45:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A025DB;
        Mon, 18 Sep 2023 10:45:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 142A221F6C;
        Mon, 18 Sep 2023 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695059137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lyfAqCCmlF3otMbiFR9R3RbrJUOjL2exCf9oXZ5s4Rc=;
        b=CVHS1Y0wDyWCSkqI3wS6NsFgSf5VMvQyK4Ve2p1Fi6YHDbaZftDyrIvF2P9uNE+t43uzSN
        o6PdQtwrxDmmCEuyI8pp+XkwmCdCmxJUndDS97fsLZLSl+b+JisOEweZua/UnocPyKxew2
        orrB4/vgbbEEpKRuH8Ydi/CqLC1fNxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695059137;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lyfAqCCmlF3otMbiFR9R3RbrJUOjL2exCf9oXZ5s4Rc=;
        b=CneCPPrMgVfwHlkgOIwYwbGfkc4L1gKnk2bxYxndIFrXVtT3UWQ8xnpGkPOY0z0DNDmCtz
        37RopdS/8sC5OTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88D281358A;
        Mon, 18 Sep 2023 17:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aKdiGsCMCGUzHgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 18 Sep 2023 17:45:36 +0000
Message-ID: <dba48c42-1b13-4a3a-a2db-fca2adb83287@suse.de>
Date:   Mon, 18 Sep 2023 19:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-3-hare@suse.de> <ZQhNWB8zwD2nBiLJ@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZQhNWB8zwD2nBiLJ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/18/23 15:15, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 01:04:54PM +0200, Hannes Reinecke wrote:
>> @@ -161,7 +161,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>>   	struct folio *folio = args->folio;
>>   	struct inode *inode = folio->mapping->host;
>>   	const unsigned blkbits = inode->i_blkbits;
>> -	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
>> +	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
>>   	const unsigned blocksize = 1 << blkbits;
>>   	struct buffer_head *map_bh = &args->map_bh;
>>   	sector_t block_in_file;
>> @@ -169,7 +169,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>>   	sector_t last_block_in_file;
>>   	sector_t blocks[MAX_BUF_PER_PAGE];
>>   	unsigned page_block;
>> -	unsigned first_hole = blocks_per_page;
>> +	unsigned first_hole = blocks_per_folio;
>>   	struct block_device *bdev = NULL;
>>   	int length;
>>   	int fully_mapped = 1;
> 
> I feel like we need an assertion that blocks_per_folio <=
> MAX_BUF_PER_PAGE.  Otherwise this function runs off the end of the
> 'blocks' array.
> 
> Or (and I tried to do this once before getting bogged down), change this
> function to not need the blocks array.  We need (first_block, length),
> because this function will punt to 'confused' if theree is an on-disk
> discontiguity.
> 
> ie this line needs to change:
> 
> -		if (page_block && blocks[page_block-1] != map_bh->b_blocknr-1)
> +		if (page_block == 0)
> +			first_block = map_bh->b_blocknr;
> +		else if (first_block + page_block != map_bh->b_blocknr)
> 			goto confused;
> 
>> @@ -474,12 +474,12 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
>>   	struct address_space *mapping = folio->mapping;
>>   	struct inode *inode = mapping->host;
>>   	const unsigned blkbits = inode->i_blkbits;
>> -	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
>> +	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
>>   	sector_t last_block;
>>   	sector_t block_in_file;
>>   	sector_t blocks[MAX_BUF_PER_PAGE];
>>   	unsigned page_block;
>> -	unsigned first_unmapped = blocks_per_page;
>> +	unsigned first_unmapped = blocks_per_folio;
>>   	struct block_device *bdev = NULL;
>>   	int boundary = 0;
>>   	sector_t boundary_block = 0;
> 
> Similarly, this function needss an assert.  Or remove blocks[].
> 
Will have a look. Just tried the obvious conversion as I was still 
trying to get the thing to work at that point. So bear with me.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

