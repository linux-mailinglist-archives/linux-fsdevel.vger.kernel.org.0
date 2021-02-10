Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DBF316966
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 15:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBJOsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 09:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhBJOsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:48:31 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F16C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 06:47:49 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n14so2132262iog.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iLQB+ZEK+T1kkPIMmSiRQAuvCttN7l5jwO4FPXByOu0=;
        b=S75Rvmwn8cPlYmIasDVtSfCicnMqmAmDIOC1KeS8b561gye7C5Z9s9xzzScUn2gzOp
         x0YDpxqpXkhDAsX+n28rOKL53rEazrurt+Z+F3Elgnz81MXX8K8B23BwTVot7KHqtlGo
         YMseBPoVonFI3uN0x26++7p5TJ+t4VdLq8rRdsM5JrLi2z1mM8iYQYt8tYTd6+ztrIuq
         J/YFQXQ13fvlM1XfHZcgiHIXtfqvRbP7HkW7UNdQd3oS8q43SzVv9d1x4N1d+Fj0eYYT
         agPR1I+hPbYFjqPdqfG0YhBoqNazVRrSFt/RQCVLunMGRcYvWu+XaGRjq8B5fK7kUnAM
         ImVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iLQB+ZEK+T1kkPIMmSiRQAuvCttN7l5jwO4FPXByOu0=;
        b=Cqxc3I5PKN/kxHx0hp1zA3AjSBuQKXJ2eU/FMQquqHhSLM5LUPA8Kj7FvYDqrIW1kZ
         lRMrXPiuyQDsZrY6PJ4dl6u91Aj8zeb8XL3ZmaOz/CLrJLPUOxMDwK/tP+EzJrjkolTB
         CXiNTMGSiTjpQE4IZjoaf7oBDqHjUZvsdonoYtRAk/uGyKmVlbUgcVXL7fpPz/0W/SJL
         mbnSChN1pdLJdaBEQYhEga04pcEWuUcsOkB1WkryjdJperaD/2nni/ao/f7FhrEBWE2J
         iQpYCAnnoN7ZPaT3ABhAPd4Sw2Nz+3o5l84wJlf42Tw2r96SfejSm/1RpgrD7i/0vnCv
         xCaw==
X-Gm-Message-State: AOAM533gTBaacXHw24g7oPMHwSwxH86H0Lc0FM2jUUTGdmfUCfLimJso
        IYAfFzWk6pl0viTTcHyJ8zcdww==
X-Google-Smtp-Source: ABdhPJzGI3wasT05NQNuC68AcYWOot4syxPq1VHZXP27MHio5htsMwcoYpP4TtJ1g5gZ9Ubksztcrw==
X-Received: by 2002:a05:6638:b12:: with SMTP id a18mr3760547jab.114.1612968468565;
        Wed, 10 Feb 2021 06:47:48 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m4sm1101011ilc.53.2021.02.10.06.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 06:47:48 -0800 (PST)
Subject: Re: [PATCHSET v2 0/3] Improve IOCB_NOWAIT O_DIRECT reads
To:     sedat.dilek@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org
References: <20210209023008.76263-1-axboe@kernel.dk>
 <20210209115542.3e407e306a4f1af29257c8f6@linux-foundation.org>
 <32dba5cc-7878-3b7b-45e4-84690a45a998@kernel.dk>
 <CA+icZUWBrHA72gQzyByKbNeCzaaVcNX85VwnYHozp6KWBt5tHQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6bb0288d-4a99-e971-636b-ebd48c59dfa4@kernel.dk>
Date:   Wed, 10 Feb 2021 07:47:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUWBrHA72gQzyByKbNeCzaaVcNX85VwnYHozp6KWBt5tHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/21 1:07 AM, Sedat Dilek wrote:
> On Tue, Feb 9, 2021 at 10:25 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 2/9/21 12:55 PM, Andrew Morton wrote:
>>> On Mon,  8 Feb 2021 19:30:05 -0700 Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>> Hi,
>>>>
>>>> For v1, see:
>>>>
>>>> https://lore.kernel.org/linux-fsdevel/20210208221829.17247-1-axboe@kernel.dk/
>>>>
>>>> tldr; don't -EAGAIN IOCB_NOWAIT dio reads just because we have page cache
>>>> entries for the given range. This causes unnecessary work from the callers
>>>> side, when the IO could have been issued totally fine without blocking on
>>>> writeback when there is none.
>>>>
>>>
>>> Seems a good idea.  Obviously we'll do more work in the case where some
>>> writeback needs doing, but we'll be doing synchronous writeout in that
>>> case anyway so who cares.
>>
>> Right, I think that'll be a round two on top of this, so we can make the
>> write side happier too. That's a bit more involved...
>>
>>> Please remind me what prevents pages from becoming dirty during or
>>> immediately after the filemap_range_needs_writeback() check?  Perhaps
>>> filemap_range_needs_writeback() could have a comment explaining what it
>>> is that keeps its return value true after it has returned it!
>>
>> It's inherently racy, just like it is now. There's really no difference
>> there, and I don't think there's a way to close that. Even if you
>> modified filemap_write_and_wait_range() to be non-block friendly,
>> there's nothing stopping anyone from adding dirty page cache right after
>> that call.
>>
> 
> Jens, do you have some numbers before and after your patchset is applied?

I don't, the load was pretty light for the test case - it was just doing
33-34K of O_DIRECT 4k random reads in a pretty small range of the device.
When you end up having page cache in that range, that means you end up
punting a LOT of requests to the async worker. So it wasn't as much a
performance win for this particular case, but an efficiency win. You get
rid of a worker using 40% CPU, and reduce the latencies.

> And kindly a test "profile" for FIO :-)?

To reproduce this, have a small range dio rand reads and then have
something else that does a few buffered reads from the same range.

-- 
Jens Axboe

