Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D4E7A510D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjIRRe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIRRe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:34:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936CBFB;
        Mon, 18 Sep 2023 10:34:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 36FB221F4F;
        Mon, 18 Sep 2023 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695058460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STqzbirky7s4xIFxGt0ZFcoAbGbIBdRaWCKAcOYdde8=;
        b=Cq7FpSXi++zxK8J8P9Ser1h1kXlSk5vWmIXvvDgrl8uHdJXe9fe7D4Sl0ByoItBNJLXbKA
        vsO7LcTaNdL0RXxL/ovXoqDel9wTYbhAQ+LIAkoSftJm78wOphXEWCSK3fgUVjB/C+iAK/
        7COpNLML3EbjWnqMpcTc7v3WyosSKcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695058460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STqzbirky7s4xIFxGt0ZFcoAbGbIBdRaWCKAcOYdde8=;
        b=0i8H2c4AjvUuX+0wzaqIF56ox41EHErzOi3Bh5B8KkHme4bEiIPBLDf1sGj3H4pihB10xI
        lHH2yg6Rk5DIPuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A99201358A;
        Mon, 18 Sep 2023 17:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hHo0JhuKCGXTGgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 18 Sep 2023 17:34:19 +0000
Message-ID: <1409c8de-f591-42e5-b638-353bb43d39b5@suse.de>
Date:   Mon, 18 Sep 2023 19:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] mm/filemap: allocate folios with mapping order
 preference
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-8-hare@suse.de> <ZQhTmF9VkShSequJ@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZQhTmF9VkShSequJ@casper.infradead.org>
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

On 9/18/23 15:41, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 01:04:59PM +0200, Hannes Reinecke wrote:
>> +++ b/mm/filemap.c
>> @@ -507,9 +507,14 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
>>   	pgoff_t end = end_byte >> PAGE_SHIFT;
>>   	struct folio_batch fbatch;
>>   	unsigned nr_folios;
>> +	unsigned int order = mapping_min_folio_order(mapping);
>>   
>>   	folio_batch_init(&fbatch);
>>   
>> +	if (order) {
>> +		index = ALIGN_DOWN(index, 1 << order);
>> +		end = ALIGN_DOWN(end, 1 << order);
>> +	}
>>   	while (index <= end) {
>>   		unsigned i;
>>   
> 
> I don't understand why this function needs to change at all.
> filemap_get_folios_tag() should return any folios which overlap
> (index, end).  And aligning 'end' _down_ certainly sets off alarm bells
> for me.  We surely would need to align _up_.  Except i don't think we
> need to do anything to this function.
> 
Because 'end' is the _last_ valid index, not the index at which the 
iteration stops (cf 'index <= end') here. And as the index remains in 4k 
units we need to align both, index and end, to the nearest folio.

>> @@ -2482,7 +2487,8 @@ static int filemap_create_folio(struct file *file,
>>   	struct folio *folio;
>>   	int error;
>>   
>> -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
>> +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
>> +				    mapping_min_folio_order(mapping));
>>   	if (!folio)
>>   		return -ENOMEM;
>>   
> 
> Surely we need to align 'index' here?
> 
Surely.

>> @@ -2542,9 +2548,16 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>>   	pgoff_t last_index;
>>   	struct folio *folio;
>>   	int err = 0;
>> +	unsigned int order = mapping_min_folio_order(mapping);
>>   
>>   	/* "last_index" is the index of the page beyond the end of the read */
>>   	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
>> +	if (order) {
>> +		/* Align with folio order */
>> +		WARN_ON(index % 1 << order);
>> +		index = ALIGN_DOWN(index, 1 << order);
>> +		last_index = ALIGN(last_index, 1 << order);
>> +	}
> 
> Not sure I see the point of this.  filemap_get_read_batch() returns any
> folio which contains 'index'.
> 
Does it? Cool. Then of course we don't need to align the index here.

>>   retry:
>>   	if (fatal_signal_pending(current))
>>   		return -EINTR;
>> @@ -2561,7 +2574,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>>   		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>>   			return -EAGAIN;
>>   		err = filemap_create_folio(filp, mapping,
>> -				iocb->ki_pos >> PAGE_SHIFT, fbatch);
>> +				index, fbatch);
> 
> ... ah, you align index here.  I wonder if we wouldn't be better passing
> iocb->ki_pos to filemap_create_folio() to emphasise that the caller
> can't assume anything about the alignment/size of the folio.
> 
I can check if that makes a difference.

>> @@ -3676,7 +3689,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>>   repeat:
>>   	folio = filemap_get_folio(mapping, index);
>>   	if (IS_ERR(folio)) {
>> -		folio = filemap_alloc_folio(gfp, 0);
>> +		folio = filemap_alloc_folio(gfp,
>> +				mapping_min_folio_order(mapping));
>>   		if (!folio)
>>   			return ERR_PTR(-ENOMEM);
>>   		err = filemap_add_folio(mapping, folio, index, gfp);
> 
> This needs to align index.

Why, but of course. Will check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

