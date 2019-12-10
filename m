Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD45118E73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 18:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfLJRCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 12:02:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44388 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfLJRCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:02:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id bh2so102964plb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rRqPLE4dXnF4n2+9+iyu9OEiIv3PDL4Q8KoD2x2W6Gk=;
        b=zphgx8SE0ecZBftbR1vGSNvgVTJ+UjBN6JyiXOeU4wVBNAWrP0m3GLK2dU0i2R7uOv
         Pj0Oki2wCvjCoA/DFnJKkERIZqI4Z4mmudNnH6LdOZZqSblGL9eBdTRSXxpAnmnFjnjW
         r0O4e5y1OnxroqqTs2NAwnObYlrAlCINpmBb4DcCY1hQyvd6Ldz6PxFAOfkFktW86DDf
         TtohfMDX7XOtvt8Q8f4yXJUGDT8EPbRtAEDtCoAt/LkftPIQ7RyE9zTPuB7OwVqWt2KE
         CrfpZ/jPduPdklP9julfsqkFbMq5c+47BIo3FDCXFWaAc0vY6AlBj21swzrhnepuYjDN
         Ydgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rRqPLE4dXnF4n2+9+iyu9OEiIv3PDL4Q8KoD2x2W6Gk=;
        b=dJ7Bi3bXJqaZ9yv9mdwchrayiagl0AbVIvVPpuJ1msYzOKSuyHOmgS46ckMzbY7DWZ
         4rvY8B4UL1Gcu16ufBFbnZlM8uMa5hYxqm5GkQr3hhtpWIfSUo8QUpnZ2kES3Db5TZNp
         QiLRdj4231GYjfIPXkgwH4t6mcQZSyLoQQYtejqMUv9E3cAozwelkOiNe83vS9D6vQmw
         uW8W1KzYSA3UQfHr+Ok6mGP0Yw4nujb399ddwf1yZGdGy2TAPbi0BhLXWqYQ0JSi0v87
         wQou8woDcZsX8+kcp/4eCuG+n1brhMdQy7MmZOR2SPxAekKd2Xr7Jc2tkUCYqc5vfEby
         G0jg==
X-Gm-Message-State: APjAAAUfwfMWYQU2UqPww6/j77khYQJjvogUea4xSJKj0lQ8kQg3jJg0
        WJiZIaw+LqUyAZTis/5FDjpyWg==
X-Google-Smtp-Source: APXvYqyd0yR6JXRmVjr21noLl8IiI3HSB25yPpBjQvYCieXOg4m2hODG+fIOIbjIJGZGkXWU0Riafw==
X-Received: by 2002:a17:902:bc8b:: with SMTP id bb11mr24150424plb.52.1575997341297;
        Tue, 10 Dec 2019 09:02:21 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1365? ([2620:10d:c090:180::b7af])
        by smtp.gmail.com with ESMTPSA id c19sm4487904pfc.144.2019.12.10.09.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 09:02:20 -0800 (PST)
Subject: Re: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191210162454.8608-4-axboe@kernel.dk>
 <20191210165532.GJ32169@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <721d8d7e-9e24-bded-a3c0-fa5bf433e129@kernel.dk>
Date:   Tue, 10 Dec 2019 10:02:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210165532.GJ32169@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/19 9:55 AM, Matthew Wilcox wrote:
> On Tue, Dec 10, 2019 at 09:24:52AM -0700, Jens Axboe wrote:
>> +/*
>> + * Start writeback on the pages in pgs[], and then try and remove those pages
>> + * from the page cached. Used with RWF_UNCACHED.
>> + */
>> +void write_drop_cached_pages(struct page **pgs, struct address_space *mapping,
>> +			     unsigned *nr)
> 
> It would seem more natural to use a pagevec instead of pgs/nr.

I did look into that, but they are intertwined with LRU etc. I
deliberately avoided the LRU on the read side, as it adds noticeable
overhead and gains us nothing since the pages will be dropped agian.

>> +{
>> +	loff_t start, end;
>> +	int i;
>> +
>> +	end = 0;
>> +	start = LLONG_MAX;
>> +	for (i = 0; i < *nr; i++) {
>> +		struct page *page = pgs[i];
>> +		loff_t off;
>> +
>> +		off = (loff_t) page_to_index(page) << PAGE_SHIFT;
> 
> Isn't that page_offset()?

I guess it is! I'll make that change.

>> +	__filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
>> +
>> +	for (i = 0; i < *nr; i++) {
>> +		struct page *page = pgs[i];
>> +
>> +		lock_page(page);
>> +		if (page->mapping == mapping) {
> 
> So you're protecting against the page being freed and reallocated to a
> different file, but not against the page being freed and reallocated
> to a location in the same file which is outside (start, end)?

I guess so, we can add that too, probably just check if the index is
still the same. More of a behavioral thing, shouldn't be any
correctness issues there.

-- 
Jens Axboe

