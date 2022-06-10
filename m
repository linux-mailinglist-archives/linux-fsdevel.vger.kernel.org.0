Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B75546CB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350268AbiFJStB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 14:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346510AbiFJSs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:48:59 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428F140E6D;
        Fri, 10 Jun 2022 11:48:57 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id hf10so19980652qtb.7;
        Fri, 10 Jun 2022 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dsVz6sG+QhEZcNwTGOArZ/kX+5MgCaSwZcV401gNIGU=;
        b=forey2c9tKFYXq7+kCogDAeaGLIWGBnkKKbMYYobPEeDX3BS5XdCWV1hZZgzGNpC4+
         xsq2zslzZxpH9T+BoUnxmMcb1k83y+SgSJsHm6TqjL4gLQxT/2CeLZt8Gz9Fxa0W2TiN
         TivTbubpJKebbJqSx8Eo3/9cPscaLMwtH/pHcMjORe8n3CL1P3PNBDKxr30amK7O9F91
         MLTBYARLa0gG/j2CaS6t1lvKV8xTvi9ujz81bcP+60F10KQWjgcZxP9r+qBxasnqkhH4
         IowChp6yN21zTOFhg3D3hriwEeoZlZ5TjwkVicqLvgUdCJkeIkeG3OPb2YZD6L3+QC/g
         5nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dsVz6sG+QhEZcNwTGOArZ/kX+5MgCaSwZcV401gNIGU=;
        b=eeDDkPuXp7yO/2heCqDyaGY0DfRBWIV4e6/Fkm/ZqLhr0U6CVDl87gs3oO24ALQ19j
         zmxKyUJAReehGBo49ngE6/peWRIADMV+p1bhbq+z9brHGUSFjh8bO8Zw3m5glUPWsfnu
         Wz1/UxD8lHWBRWEPQNkUMQ8VuOMYRhq2FLusELwg2/xERz2P+rPdf8Px/tyAezJUEh8O
         TzJPEQNmTNK2rqQOQ059AADO0wG4l2O5m1A3lOrLt8I0qJDBSQkSazzQeTSUGwWpYp9W
         EOayv6Kbo03a3kOjTSHbj96NSulnbcUQh0NjQLuzelC1WhkkH23WjoVBZww/EsHjbP5S
         b9uQ==
X-Gm-Message-State: AOAM533V+7m+mr9VoWuZvtP4J6E8+v9a61oEcBp3NLXe5MHgY1/FjJjW
        Bv3x/xTd3HEY2M7S19Q8ow==
X-Google-Smtp-Source: ABdhPJz6CSbXPIgAGNDAvAP3516sdviaGWfTyK404V3gkg/DvjOeZ7c5k3v/IEZFuvU9BBdyimVzqw==
X-Received: by 2002:ac8:5e13:0:b0:304:b452:9ec8 with SMTP id h19-20020ac85e13000000b00304b4529ec8mr37967680qtx.356.1654886936265;
        Fri, 10 Jun 2022 11:48:56 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id ew5-20020a05622a514500b0030503a897b1sm6020938qtb.42.2022.06.10.11.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 11:48:55 -0700 (PDT)
Message-ID: <115fe76f-f5f2-338b-c4a6-d900ec151abe@gmail.com>
Date:   Fri, 10 Jun 2022 14:48:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, akpm@linux-foundation.org,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <YpkB1+PwIZ3AKUqg@casper.infradead.org>
 <c49af4f7-5005-7cf1-8b58-a398294472ab@huawei.com>
 <YqNWY46ZRoK6Cwbu@casper.infradead.org>
 <YqNW8cYn9gM7Txg6@casper.infradead.org>
 <c5f97e2f-8a48-2906-91a2-1d84629b3641@gmail.com>
 <YqOOsHecZUWlHEn/@casper.infradead.org>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <YqOOsHecZUWlHEn/@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/22 14:34, Matthew Wilcox wrote:
> On Fri, Jun 10, 2022 at 01:47:02PM -0400, Kent Overstreet wrote:
>> I think this is the fix we want - I think Yu basically had the right idea
>> and had the off by one fix, this should be clearer though:
>>
>> Yu, can you confirm the fix?
>>
>> -- >8 --
>> Subject: [PATCH] filemap: Fix off by one error when marking folios accessed
>>
>> In filemap_read() we mark pages accessed as we read them - but we don't
>> want to do so redundantly, if the previous read already did so.
>>
>> But there was an off by one error: we want to check if the current page
>> was the same as the last page we read from, but the last page we read
>> from was (ra->prev_pos - 1) >> PAGE_SHIFT.
>>
>> Reported-by: Yu Kuai <yukuai3@huawei.com>
>> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 9daeaab360..8d5c8043cb 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2704,7 +2704,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct
>> iov_iter *iter,
>>                   * mark it as accessed the first time.
>>                   */
>>                  if (iocb->ki_pos >> PAGE_SHIFT !=
>> -                   ra->prev_pos >> PAGE_SHIFT)
>> +                   (ra->prev_pos - 1) >> PAGE_SHIFT)
>>                          folio_mark_accessed(fbatch.folios[0]);
>>
>>                  for (i = 0; i < folio_batch_count(&fbatch); i++) {
>>
> 
> This is going to mark the folio as accessed multiple times if it's
> a multi-page folio.  How about this one?

I like that one - you can add my Reviewed-by

> 
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5f227b5420d7..a30587f2e598 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2599,6 +2599,13 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
>   	return err;
>   }
>   
> +static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
> +{
> +	unsigned int shift = folio_shift(folio);
> +
> +	return (pos1 >> shift == pos2 >> shift);
> +}
> +
>   /**
>    * filemap_read - Read data from the page cache.
>    * @iocb: The iocb to read.
> @@ -2670,11 +2677,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>   		writably_mapped = mapping_writably_mapped(mapping);
>   
>   		/*
> -		 * When a sequential read accesses a page several times, only
> +		 * When a read accesses the same folio several times, only
>   		 * mark it as accessed the first time.
>   		 */
> -		if (iocb->ki_pos >> PAGE_SHIFT !=
> -		    ra->prev_pos >> PAGE_SHIFT)
> +		if (!pos_same_folio(iocb->ki_pos, ra->prev_pos - 1,
> +							fbatch.folios[0]))
>   			folio_mark_accessed(fbatch.folios[0]);
>   
>   		for (i = 0; i < folio_batch_count(&fbatch); i++) {

