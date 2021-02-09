Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F431519D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 15:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhBIOa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 09:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBIOa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:30:56 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA5C061786
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 06:30:16 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d6so16248096ilo.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cab2YQDGLwQqWKzHUVaQ5OkMysUjTn1iQdHgNt5AU6I=;
        b=BXyVFZsCRu+Kw/ULnfMl3jHNP++xqpSxBDCwAKnXdPEfZ5QyLIf/rqmQ4wQcJlFjVp
         7BqM6UOA4weKXs5adGLh0cAptrOqRCSXX9yaNDh9iz1bN6Y9Neiy/6ZIEy4KOCkLhUdO
         hqx1gixQ9PAcGFBoamEHhgy7CBFYofbBeyV/zu980vmjxRrbcR8Wz9N9v6m3pX7OzUD6
         RBN32yFPjFrTXr8Xd5A9iz+A5ebJPD0eCNlmiHqHqztI8N1y5yM3MUUaArBQ3AtLjObT
         xOMFev/YKeEjBIvxxmCzZLwCrzb0oz5/MOryc79jfQDPjLZPnYZggNFbqc5rjxT8wbx+
         twcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cab2YQDGLwQqWKzHUVaQ5OkMysUjTn1iQdHgNt5AU6I=;
        b=grBlwJLir65wHBu/7zIk3Q+A/HBURf8jzZZYqjXCXYrSHHe/RVn8yxYz0cQX+h1cbh
         ZotQ2au+wSmyvHLiQ6shRVd/Z0a81uCGf3mLBmqHTaOEIcM86/7AbAaTRWN7OjFTqEsZ
         t+aLohNo4FNT78GarBD2nd+O5StKmKycEVHtTVaP1igTPTPDzicFdE+5hdBNJPJfwExI
         Ldi2Isvpg/baz3dpQ60g1IvHnO6NE8ozxaGv5++qNjPfEzKqDM3Z1bBzuR/kr+YHWaPh
         QhT+Ozg9wDoFKUDaR1oOJU4EzvxF9XKzpEqtvjxeTKXyAZBT65QyawZ3AkZaPwr+vhh2
         8DDg==
X-Gm-Message-State: AOAM530C410HMt1I+LW5gbsLxLfb4H0rux53iUA1V+0Z1TCtLrNYorKS
        iP+PQipq8+fLaMZ3SSWILLk+8Q==
X-Google-Smtp-Source: ABdhPJyoGFhnjkcWAQUqBZpzFSz9mw3XkGxPt4DVU65yx179ebu5GXPI0y+kXGO5OvMzCMaPtTlMrA==
X-Received: by 2002:a05:6e02:180d:: with SMTP id a13mr19950864ilv.156.1612881016215;
        Tue, 09 Feb 2021 06:30:16 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k8sm10249656ilu.4.2021.02.09.06.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 06:30:15 -0800 (PST)
Subject: Re: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20210209023008.76263-1-axboe@kernel.dk>
 <20210209023008.76263-2-axboe@kernel.dk>
 <20210209074723.GA1696555@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d962be27-2b24-b3ef-8d14-4ba616f6a44a@kernel.dk>
Date:   Tue, 9 Feb 2021 07:30:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209074723.GA1696555@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 12:47 AM, Christoph Hellwig wrote:
>> +extern bool filemap_range_needs_writeback(struct address_space *,
>> +					  loff_t lstart, loff_t lend);
> 
> no need for the extern.

Just following the style in the file.

-- 
Jens Axboe

