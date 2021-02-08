Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ECC3143A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 00:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBHXWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 18:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBHXWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:22:34 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE30C061786
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 15:21:54 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b145so10715257pfb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 15:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K4iCaQx2KOxgVXKZ58QNUBJ5G2mvFus55zm+d+J4hcE=;
        b=Hr/N2ePz2H3KWz2ulMypdoXaiBart0hMDY85msjXzZcuGuryV7nrE/0VIDxZqqaLSc
         i9S4/d4FFKfuO6c4mF2eiCYN9e+e7hgy2aOGVdj9Wb/j1nbZYy45b/GRfU+oytlZ4Wof
         Cpqrdzjh8VzI2d96BYEkIyRfdQKiNEPu8wE+0rGA3cLuuLkqngysfD31Tk4KxiqSs/lh
         raAiZN5wFxBhc83bQ59Pvo1qK4LMWdL5m4D1BX/mWpaviUOeDtvBVN0/AsZ2rTjnUSpI
         gsDfSo3x0gvrDvr+TAgpFJjmI7lANTJxwMPvz9/DgFuFMJ6vx97DOVbg7lPMR0zGv6rR
         z+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K4iCaQx2KOxgVXKZ58QNUBJ5G2mvFus55zm+d+J4hcE=;
        b=Zep0p1Ua1IXvdOAEUjETdZCUcDjjCUh83nhR5FDTtZggyy4jBikqUe0/ioSBi9vVkr
         IFBH9R5M1SRHoAEXhi9ZUj7xHoIvnwKFgFOEYKENn5a6pcM3Z8XnSzPMQ3p17HvWoZyA
         NFPFqTkRITq0dGoU9GplCFUX/cg/j4LmOwtCI4J2GU+iSA2NwldxuGGMfHwG+xMfJKuz
         UFS8pdPhFwOpmWNDJMPFxeuseePiffZ/k8HsGOvnmXnk0CwcYpzTvfXU3iJtAM7DrKl5
         Oc7xo41nBbyAG+VmaI1CEgLLghrTOv/UQMOx+0JVH4tvaGdaq6pBSIZx3g6jYQ+3ai58
         4AKA==
X-Gm-Message-State: AOAM532m1wObSp5iFQ0ooY9+nopz4lof4Y/VDt5LXoH/73a7kor5+gzt
        WHl67OJQHctqxhlV50dEIiAe+A==
X-Google-Smtp-Source: ABdhPJyAsSEuD8JNeAi971eFAYPq0GTV79Lj1tuCctsAnt7ByTYECNmwXQlpxC3nb7+Y1ruSmgVZCQ==
X-Received: by 2002:a63:6e0f:: with SMTP id j15mr19265946pgc.21.1612826513553;
        Mon, 08 Feb 2021 15:21:53 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s21sm19428323pga.12.2021.02.08.15.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 15:21:53 -0800 (PST)
Subject: Re: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, akpm@linux-foundation.org
References: <20210208221829.17247-1-axboe@kernel.dk>
 <20210208221829.17247-2-axboe@kernel.dk>
 <20210208230205.GV308988@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4fc9f1e-e1b6-ff46-e5cf-5e59ca9db936@kernel.dk>
Date:   Mon, 8 Feb 2021 16:21:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210208230205.GV308988@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/8/21 4:02 PM, Matthew Wilcox wrote:
> On Mon, Feb 08, 2021 at 03:18:27PM -0700, Jens Axboe wrote:
>> +	rcu_read_lock();
>> +	xas_for_each(&xas, head, max) {
>> +		if (xas_retry(&xas, head))
>> +			continue;
>> +		if (xa_is_value(head))
>> +			continue;
>> +		page = find_subpage(head, xas.xa_index);
>> +		if (PageDirty(page) || PageLocked(page) || PageWriteback(page))
>> +			break;
>> +		page = NULL;
>> +	}
>> +	rcu_read_unlock();
> 
> There's no need to find the sub-page for any of these three conditions --
> the bit will be set on the head page.

Gotcha, that makes it simpler. I'll make the edit.

-- 
Jens Axboe

