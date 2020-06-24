Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6C207646
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404068AbgFXPAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 11:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404039AbgFXPAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:00:50 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98415C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:00:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i4so1272860pjd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q/jaQeCVttGzGBo3E3lk1QjN0UoCwQgqot3lYK2zXtk=;
        b=qsvuBeQgO4niMQcI2gC+VVoIgpUqo5H4wRPLlaR/5qawyoXdMx/bjxy7jtPw3aL8Dl
         cRg0StjUcxNFOmQnJunhva1NegHntMT8fa77CMkohiT1LX1ydJgW8uGuDjysJPCp/35R
         znrly6bkXru8zbZenMv52ZiGlSJ91NS8nCH0gnNyaTgbSN91QAtpFb9Pizp9ez9VUpZR
         lkCSizcvK1T9hmpEE8ePUTS0LPXCQRR/r7Kz54/FhrDGancf3WJTukegFfSwMmgTEQw7
         jqA687/rpGcmCpsu5xlVqxiDBCSFTSyk7tjMNs+8LBV//NZ7jPB012Xm3BxjFW42Ee5C
         w2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q/jaQeCVttGzGBo3E3lk1QjN0UoCwQgqot3lYK2zXtk=;
        b=XkYsqcr2zTRAXUSgtr7d8jA6/syHkbV+aYd4dCxMTFac7fe2Rlw1jaTXVQ1WjQvF7Y
         hib9yKQL/M1MiRoVaD878V6Y4xjui3+mhAja0g50wlyFrPIw5m/7hN7qlnLkvwRMzPg5
         kGKZeBzl9kMSU7WDdgpvIZZZIsNae1wwkpQSie7AD21Zx1nq6U/eq6/vdydz1/7/Mbd0
         W8fi+079oYZa8+GuHs9BzrHMhwOmCfhniP2GaYqIF+N9UcgqHUieU0Z78Q2+YcOYVPfe
         FIYX1cq0IaphNDxZp820zh4FXBjQz61DU7CPMqWUPyxc0FP3UoNIy7YBbs0CwNc1CwYD
         0/rA==
X-Gm-Message-State: AOAM5320rqrT4fYZ9mrb7KBM9yRXnmWJHU1QsSgVBy7/DDVAW7lzyyIu
        w4G+hh2xYC04E44jPN5ujLCUsQ==
X-Google-Smtp-Source: ABdhPJySN748/btTbadKTHVRipOZVFkvJAeaRPC1DlqdK8kxD+Mddoxrv8JQ5kTFSMXrj12Wq4V18g==
X-Received: by 2002:a17:90a:2070:: with SMTP id n103mr29733694pjc.109.1593010849032;
        Wed, 24 Jun 2020 08:00:49 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m8sm5470354pjk.20.2020.06.24.08.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:00:48 -0700 (PDT)
Subject: Re: [PATCH 05/15] mm: allow read-ahead with IOCB_NOWAIT set
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20200618144355.17324-1-axboe@kernel.dk>
 <20200618144355.17324-6-axboe@kernel.dk>
 <20200624010253.GB5369@dread.disaster.area>
 <20200624014645.GJ21350@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bad52be9-ae44-171b-8dbf-0d98eedcadc0@kernel.dk>
Date:   Wed, 24 Jun 2020 09:00:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624014645.GJ21350@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/23/20 7:46 PM, Matthew Wilcox wrote:
> On Wed, Jun 24, 2020 at 11:02:53AM +1000, Dave Chinner wrote:
>> On Thu, Jun 18, 2020 at 08:43:45AM -0600, Jens Axboe wrote:
>>> The read-ahead shouldn't block, so allow it to be done even if
>>> IOCB_NOWAIT is set in the kiocb.
>>
>> Doesn't think break preadv2(RWF_NOWAIT) semantics for on buffered
>> reads? i.e. this can now block on memory allocation for the page
>> cache, which is something RWF_NOWAIT IO should not do....
> 
> Yes.  This eventually ends up in page_cache_readahead_unbounded()
> which gets its gfp flags from readahead_gfp_mask(mapping).
> 
> I'd be quite happy to add a gfp_t to struct readahead_control.
> The other thing I've been looking into for other reasons is adding
> a memalloc_nowait_{save,restore}, which would avoid passing down
> the gfp_t.

That was my first thought, having the memalloc_foo_save/restore for
this. I don't think adding a gfp_t to readahead_control is going
to be super useful, seems like the kind of thing that should be
non-blocking by default.

-- 
Jens Axboe

