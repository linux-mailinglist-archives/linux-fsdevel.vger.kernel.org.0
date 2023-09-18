Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4F7A5127
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjIRRnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjIRRm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:42:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A08FDB;
        Mon, 18 Sep 2023 10:42:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C035820055;
        Mon, 18 Sep 2023 17:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695058972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNsZa0WL17GnrhkewZ07tfJjwqAxFeTYm7cYpg93Ces=;
        b=qxokM7ym0+EL6JDhccPuU6SrSecCd7Hb505+HW/CwZD4uk++CNdzGxjVYepjKPHzVLEYsN
        ZEXx2um/O1S3VztbRYEFfRc26kKEKFex3YYBU2ZBMm9MqzVzLAFKeHBVDXBXQ8LWTHvoSo
        BzjmVlaHQEBFxp8cZM50s+KSIGf+GOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695058972;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNsZa0WL17GnrhkewZ07tfJjwqAxFeTYm7cYpg93Ces=;
        b=wJ386KkxgZDRkOF1C7PLTu6qa2hXmZJ1zuNGtbZnvY2cfxhTz0fKZ/GZ69+V70UoGDzEw5
        bkj3gA92oCfk7lCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A5AE1358A;
        Mon, 18 Sep 2023 17:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eLbWDhyMCGUzHgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 18 Sep 2023 17:42:52 +0000
Message-ID: <4b8014fc-a71b-4e2f-a6a7-a5dc6a120f9e@suse.de>
Date:   Mon, 18 Sep 2023 19:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] block/buffer_head: introduce
 block_{index_to_sector,sector_to_index}
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-4-hare@suse.de> <ZQh8jXqpHFXQyEDT@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZQh8jXqpHFXQyEDT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/18/23 18:36, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 01:04:55PM +0200, Hannes Reinecke wrote:
>> @@ -449,6 +450,22 @@ __bread(struct block_device *bdev, sector_t block, unsigned size)
>>   
>>   bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
>>   
>> +static inline sector_t block_index_to_sector(pgoff_t index, unsigned int blkbits)
>> +{
>> +	if (PAGE_SHIFT < blkbits)
>> +		return (sector_t)index >> (blkbits - PAGE_SHIFT);
>> +	else
>> +		return (sector_t)index << (PAGE_SHIFT - blkbits);
>> +}
> 
> Is this actually more efficient than ...
> 
> 	loff_t pos = (loff_t)index * PAGE_SIZE;
> 	return pos >> blkbits;
> 
> It feels like we're going to be doing this a lot, so we should find out
> what's actually faster.
> 
I fear that's my numerical computation background chiming in again.
One always tries to worry about numerical stability, and increasing a 
number always risks of running into an overflow.
But yeah, I guess your version is simpler, and we can always lean onto 
the compiler folks to have the compiler arrive at the same assembler 
code than my version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

