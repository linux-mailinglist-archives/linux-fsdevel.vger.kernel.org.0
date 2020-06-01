Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE491EA84B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 19:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgFARP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 13:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgFARP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:15:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED19EC08C5C9
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 10:15:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d6so113695pjs.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2020 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WsYNSM2tJ88YCalPymb6HrMzWTrL06Vmn6FYR6YE7/Y=;
        b=UgTmTyPNErDWoyfDpvqEdQs/U0cshfD8CeAre29uvZ/dsDLiaKCLIx+B0hmevfnub2
         0tDRZhun5AbIaUe8SBeRwV24cBYLkx5zGsLhc5btRwWKuuENnv81W1XD4EzHeU2TFL+Y
         YPXWGNMQB3ZfSNqm0aK6qvPU8H0P/AAcN3ohrkN+vUQc1U37ZPjHjGoxZ9FQoEXx9fFM
         1wtG0Pg1H2Xqifo4XuQFBFtIU8HsukcHZMHwyTUDR+6WV7LFfjpVnCxNeUYBZQCA+ERb
         +nkfqnqnfPlKH2LndTUNPgXx9+YkQF0yCX5ZGsn9nw2tkdHaJ11TlFd+n8Tq7PTfxJdJ
         qQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WsYNSM2tJ88YCalPymb6HrMzWTrL06Vmn6FYR6YE7/Y=;
        b=OO282tVsTGnZqiGFoyg7GPO/lChmkHeOJyBZQqCtH77Y7OZxJurmmvYbEzBM4FCnPi
         wZzn4ti4WSOwk8/Zdn+znPHLiNG9dtbugm+5RlSUdxlTKTC+ZFHtKGTIiNmM6UidJO7/
         TZQ4qeKhNLzvud5AjRAuMny/0DQpKM8CYo9o3/sL1eiEAyE+CeNco++ySruYnoRplK6j
         0FsOZvBAd8/jWwy5igkW8pVzf6UdbAe0amli+IElP6aMDL22aUjr0PoWB8pYPAB+W/mX
         jCzk4NEdPqCNjAsGBkQ3mZY6+26orxx1E2VZ8Y15QuIOd70ACWtMU/ScJu2Ll2Kdjl+w
         ncaw==
X-Gm-Message-State: AOAM532GVmgrAlF7eokmqcLQicSvpa2GZfsE9uKEmE2QHD5PexfvZZR5
        nKCoMi4JlcNO6CG1c+IYLN++Eg==
X-Google-Smtp-Source: ABdhPJwfvpv+bJ+nV4YfmPVaXfQZIyLbxNwCqF8WqLkarYS7Wisy1DDnTyqP7EEmu/OsOjnF86QdFA==
X-Received: by 2002:a17:90a:4d4e:: with SMTP id l14mr470026pjh.10.1591031724348;
        Mon, 01 Jun 2020 10:15:24 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id mg14sm33297pjb.48.2020.06.01.10.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 10:15:23 -0700 (PDT)
Subject: Re: [PATCH 04/12] mm: add support for async page locking
To:     Matthew Wilcox <willy@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-5-axboe@kernel.dk>
 <20200601142649.GJ19604@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f4dbb05-4874-6386-f9ee-06fdbaf482bf@kernel.dk>
Date:   Mon, 1 Jun 2020 11:15:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601142649.GJ19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/1/20 8:26 AM, Matthew Wilcox wrote:
> On Tue, May 26, 2020 at 01:51:15PM -0600, Jens Axboe wrote:
>> +static int __wait_on_page_locked_async(struct page *page,
>> +				       struct wait_page_queue *wait, bool set)
>> +{
>> +	struct wait_queue_head *q = page_waitqueue(page);
>> +	int ret = 0;
>> +
>> +	wait->page = page;
>> +	wait->bit_nr = PG_locked;
>> +
>> +	spin_lock_irq(&q->lock);
>> +	if (set)
>> +		ret = !trylock_page(page);
>> +	else
>> +		ret = PageLocked(page);
>> +	if (ret) {
>> +		__add_wait_queue_entry_tail(q, &wait->wait);
>> +		SetPageWaiters(page);
>> +		if (set)
>> +			ret = !trylock_page(page);
>> +		else
>> +			ret = PageLocked(page);
> 
> Between the callers and this function, we actually look at PG_lock three
> times; once in the caller, then after taking the spinlock, then after
> adding ourselves to the waitqueue.  I understand the first and third, but
> is it really worth doing the second test?  It feels unlikely to succeed
> and only saves us setting PageWaiters.

That's probably true, and we can skip the 2nd one. I'll make the change.

-- 
Jens Axboe

