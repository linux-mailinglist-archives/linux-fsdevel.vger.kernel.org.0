Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74A371F0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhECR6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhECR6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 13:58:03 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21CEC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 10:57:09 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e2so4331092ilr.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=avcWuiy6tsbq1f22rdrxQoyeqmTZJ1reLQqSc/z3IZ8=;
        b=i4qQsqLBiQWfmezO2AaV9UW4XU11QnzIDshaa+1+RrXsuk0RBWopFGFsFOcodVhkwE
         5tNeFxIRgi+aUUAbfW6YL0DtdQLvSwTCJTIUJb1pzyolg1Rr2/eDiCoCGolmjjUQ5t8U
         kLjpnelyYn+b2wgowb1Eag5sBZGRdawUT0BXgiiu8pGnMsvAqTpl8JtcphB5jmsMWMHc
         k6FjeARvSr3iaoC0zQR0/AqNMDa6t3PQn2rkaKUO197DGBE5zBquSJwWAVcAo8dFM+66
         n6SejBWosyfn/36RjGi58VBY0a9fTbBsCBmqj8M+odR1MDbHvO1GaMUeXd08u+YkBQI8
         egQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=avcWuiy6tsbq1f22rdrxQoyeqmTZJ1reLQqSc/z3IZ8=;
        b=pC3j9HsiG4pPX5PVk8ihGUiJPOzTexDobsmFRgj6YaZdzRJokfre1Pe++TWPmkyCSA
         6WzuqVcs1G8GCqC3x6+yzI+6Oqmej9h6DGbNGDH1Ad1rWXLSGlppO3lfTdl2/O7Wbpwe
         OnAhY5wBlwda9SLtvlplDMHoz2/3d9pvhtLZwhJ7G2QDKVzJ+FjLsT2ucpoAHBxCyNqm
         cpr9vE3VAUd1AKml/mxgYCONTVQM0X7MxqC1SubD3J8uBp2di1FkYSbefNr8YffrWmG8
         BXygI6cT9OWE1MDLGnnE8lU/ZvNm+H1E4evCAOI5aw//dFyfJJ2u6gWZUkTcYgh+chuu
         lZ9A==
X-Gm-Message-State: AOAM531nQNKPaNM+5QaSJQssZXGeoxkNMvRpSRImTG8nxYN1EtWGhlqM
        es0uSGcxR8LO7ot8WJhABlLmnAS/IE4LSw==
X-Google-Smtp-Source: ABdhPJwvINkT+z0VTGqjF92a1ufiuzJa5oBz8kXHNp3weW5ubCneHvn3pnXXTd3h9c+Pfq9q2RoqDQ==
X-Received: by 2002:a05:6e02:1c42:: with SMTP id d2mr16051389ilg.287.1620064629181;
        Mon, 03 May 2021 10:57:09 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x5sm134544iom.43.2021.05.03.10.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 10:57:08 -0700 (PDT)
Subject: Re: [PATCH] eventfd: convert to using ->write_iter()
To:     David Laight <David.Laight@ACULAB.COM>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <7b98e3c2-2d9f-002b-1da1-815d8522b594@kernel.dk>
 <de316af8f88947fabd1422b04df8a66e@AcuMS.aculab.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7caa3703-af14-2ff6-e409-77284da11e1f@kernel.dk>
Date:   Mon, 3 May 2021 11:57:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <de316af8f88947fabd1422b04df8a66e@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/3/21 10:12 AM, David Laight wrote:
> From: Jens Axboe
>> Sent: 03 May 2021 15:58
>>
>> Had a report on writing to eventfd with io_uring is slower than it
>> should be, and it's the usual case of if a file type doesn't support
>> ->write_iter(), then io_uring cannot rely on IOCB_NOWAIT being honored
>> alongside O_NONBLOCK for whether or not this is a non-blocking write
>> attempt. That means io_uring will punt the operation to an io thread,
>> which will slow us down unnecessarily.
>>
>> Convert eventfd to using fops->write_iter() instead of fops->write().
> 
> Won't this have a measurable performance degradation on normal
> code that does write(event_fd, &one, 4);

If ->write_iter() or ->read_iter() is much slower than the non-iov
versions, then I think we have generic issues that should be solved.
That should not be a consideration, since the non-iov ones are
legacy and should not be adopted in new code.

-- 
Jens Axboe

