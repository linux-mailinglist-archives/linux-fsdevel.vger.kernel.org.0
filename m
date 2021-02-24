Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2813C324292
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 17:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhBXQye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbhBXQxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:53:44 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCA8C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:53:03 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id i8so2687788iog.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lkgf2NqealUW3pQjVN+lec9asYNfPi8RpEWally8zeE=;
        b=t4Bhc4RGwJM5Y6LB5l6RgQMro1eSjb8Lebn+rYoYG2GNiMW9NOXKPHcNDLabVNdmC+
         ZVLz7dvMl7OpxDefHSyqw2zBm8gMS9QnULN+9dsokYxbR6sEPTOI/iAt/B1oHsndBtlf
         eC1ndp0SL5ONMB717gmqAc+X+bUBvC8792wQL51cmJr58RsAFxcAJ4ZL8vxF0yRjxoBs
         a0WZ6MP1RqbNsPoWGjSx1fFJo/rzEJ56/oD4+WA/szkvNYYvNQRNtyEMbfLmhYOdRp8g
         eSaqtdwzFrnWknYSIB/sfp/A9zA2uAcnmP3GfYWHs5vWMx3UUimseFLkMDwjvDgpTH9b
         8bLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lkgf2NqealUW3pQjVN+lec9asYNfPi8RpEWally8zeE=;
        b=NAM568MSdihE1hJ8Hp/XIMq8qd+Xl2mJVoqyjz0n6tF6vKidZJmZoMrPR8/lT10BKy
         dVDI0P862H6lzexR1T7wx7YmS/JXXJ51gYxVi1mL070KcFimS/baeB6OnwNXAuR8ySvm
         UrblY19PaTCh8DOidVb23U1PvG0YWex0exuDnY8Zed3CnG5Iw6wIbPQH15Tzsk+x40xw
         n2kEd4BIER1Q0q+ZcizMU97umlb4YM6EoHsTkuzok20eUDF6F36YhZUnup2/3ksTcp5E
         xppNJyMQ/j4wPRoAJvOp021TldJWX4YSJr2Mc569/6hHZb5gC17Eu2EjbsTCYiWK5j9D
         RjWA==
X-Gm-Message-State: AOAM530kYBPnnyTCYXodHjcpWUcEaO9X6huHiu8EM25zxKuLS83ziQwH
        ieu3dg9i2jYQ+xWfBEh5VH6s4Q==
X-Google-Smtp-Source: ABdhPJwUIZ/sQcfJGBQzkwZD3VOnSClO8vLiL2SgI1eMZbKRG21TsnjPHUiXTYFzV3F/MJuSSJMCGA==
X-Received: by 2002:a05:6638:350:: with SMTP id x16mr17808007jap.119.1614185582871;
        Wed, 24 Feb 2021 08:53:02 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q15sm1857857ilt.30.2021.02.24.08.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 08:53:02 -0800 (PST)
Subject: Re: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20210224164455.1096727-1-axboe@kernel.dk>
 <20210224164455.1096727-2-axboe@kernel.dk>
 <20210224165054.GR2858050@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75e6dc0b-ca95-cc84-ef3b-81d8fe6c5833@kernel.dk>
Date:   Wed, 24 Feb 2021 09:53:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210224165054.GR2858050@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/24/21 9:50 AM, Matthew Wilcox wrote:
> On Wed, Feb 24, 2021 at 09:44:53AM -0700, Jens Axboe wrote:
>> +++ b/include/linux/fs.h
>> @@ -2633,6 +2633,8 @@ static inline int filemap_fdatawait(struct address_space *mapping)
>>  
>>  extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
>>  				  loff_t lend);
>> +extern bool filemap_range_needs_writeback(struct address_space *,
>> +					  loff_t lstart, loff_t lend);
>>  extern int filemap_write_and_wait_range(struct address_space *mapping,
>>  				        loff_t lstart, loff_t lend);
>>  extern int __filemap_fdatawrite_range(struct address_space *mapping,
> 
> These prototypes should all be in pagemap.h, not fs.h.  I can do
> a followup patch if you don't want to do it as part of this set.
> Also we're deprecating the use of 'extern' for prototypes.

Agree on both of those, but that should probably be a separate patch
for both of those. extern is just following the existing style, and
fs.h is the existing location...

> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks!

-- 
Jens Axboe

