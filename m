Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71C6E4D5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502181AbfJYN7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 09:59:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36165 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393764AbfJYN7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:59:41 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so2529443ioc.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5damUobXw35eKUSqmStJSloE/QuWy0XVotbTFO5vID0=;
        b=RZyaCaiJaHYmSMdwUP82cTCXFN3vu0WxKxVQjZKeFy57IDmzRSD7tcqvaTfRo/dDt9
         x8b4s31KmLKmHKJ3pBRxKEGbbo3XLDPhjDllXUJAOIURhCUO9hxU7QktQcTH3kS/7JTD
         Eb9xVA717huW4WbnH4JREIx0emrcxIpXHLNdbGO4axO7AVDdHaGBx1Pge2yEpK9mZ8/V
         Jrnh7+cvPCrV3IBwXRRUuF5DEq35cE7V8lMDdGcKs5zcIw8r4axr8hTaAZTrXFH2a3TZ
         fpBF2y/GuV/e2GPRUzudtDxE4044d1m99NSLQ6nwpqx56q/orsOWZbbr7TlvamZvdFch
         dz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5damUobXw35eKUSqmStJSloE/QuWy0XVotbTFO5vID0=;
        b=h7q8LH66VoHCIp0JXffnmgUb6F/NH6vcSi9mhecpld1GfevzHz2dLN+7lDkdsPqwp2
         7EwlLjCnh651umiHBbraGzUBnk/tb/54EsKbkUXtr1PaCOUBTicVxJZdNtr64bRcXpbH
         7naIeba0R6LomWncVBIYM/TOb6oNYHB39f3sOWtupLHBUfjav3Qu6okA2QJYFSXf7FD/
         eiKkzGtxTQ7kieIBQc2WfssOUjMHS2EyJcYqTpQdP151r+La1Oe40e1F8VV/dSSnFR5P
         v8DCBalDvUHEG71L80I10GoHqrVivLCChTXxuyBUF3d+ELkyH3PCPaZ5T2lI4Z++7aCL
         zzLA==
X-Gm-Message-State: APjAAAXEyvIbPIIMtRF0sQSWEFxztKIy1QiGrVCBeovGd6tcTMl0F9U+
        gpVt9BzEzSM74vhzy3gHR5yW3g==
X-Google-Smtp-Source: APXvYqw+GYMIOhF+Eo/gR33C8Q/wZtTiAp6hopd13x3qNlBV5U7aFaV5rqHPKzQp867TNpG5VC6dYw==
X-Received: by 2002:a6b:e30f:: with SMTP id u15mr3566633ioc.96.1572011980590;
        Fri, 25 Oct 2019 06:59:40 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 9sm343223ilt.16.2019.10.25.06.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 06:59:39 -0700 (PDT)
Subject: Re: [PATCH][next] io-wq: fix unintentional integer overflow on left
 shift
To:     Colin Ian King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191025124315.21742-1-colin.king@canonical.com>
 <fc23061e-31ec-8a66-2b62-771121d182de@kernel.dk>
 <02517010-9244-771f-d0ce-558bbebe6a63@kernel.dk>
 <a13505ab-52f1-b47d-7b1d-45552982fc82@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a750188-2696-c35a-9c5a-8bfe509edf14@kernel.dk>
Date:   Fri, 25 Oct 2019 07:59:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a13505ab-52f1-b47d-7b1d-45552982fc82@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/25/19 7:59 AM, Colin Ian King wrote:
> On 25/10/2019 14:56, Jens Axboe wrote:
>> On 10/25/19 6:54 AM, Jens Axboe wrote:
>>> On 10/25/19 6:43 AM, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> Shifting the integer value 1U is evaluated with type unsigned int
>>>> using 32-bit arithmetic and then used in an expression that expects
>>>> a 64-bit value, so there is potentially an integer overflow. Fix this
>>>> by using the BIT_ULL macro to perform the shift and avoid the overflow.
>>>
>>> Good catch, that should indeed have been 1ULL. I'll fold in your
>>> fix, thanks!
>>
>> BTW, this missed the same issue on the clear side of it, in
>> io_worker_handle_work(). I've fixed that one up the same way.
>>
> Ah, good, somehow the scanner missed that.

Something to take a look at! :-)

-- 
Jens Axboe

