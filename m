Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67940CD54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 21:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhIOTlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 15:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhIOTle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:41:34 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77D7C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 12:40:15 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a15so4980438iot.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vLtmJXvR2J5knD2TvLxYASXE+JfGOljHkjODlZyHGxg=;
        b=bxTC27KedJinuoU32GaD2v5RZ8BiHmlffv9CKft0jN7nVQOe0gdLxQ2t5JX6QmaRh7
         cbf38nNKUthezpBgEvNjyRepMJh0f8UqavxINZKxys2wQt9v2Mpg8PBRuUlvLzPCRo3d
         TzRlY6/lk9ReodPDdslrRgd2Xpq3XcuFXr164zfzcm8Ej4k5wCDgYrERqMr1RLWALwUI
         C6WiFkKHfsSwaDpyJorXB/cm2Ewdgf2hurwvuDAr98VQR/UkEVUtOmgZreYyehkmiqh0
         c0FrFmPCRB4eu+XgMkoVV1x1TYF4Q4OrCyWvNUQhTNjwVLXO01PrgrTp8cB/j6K3mO2H
         pXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vLtmJXvR2J5knD2TvLxYASXE+JfGOljHkjODlZyHGxg=;
        b=hKGTqxUfwsOFPF1vwPGWTbRVcK0sKBd6goaJKtMcDEcMsdq7n09sPpZ1jUz4KLd/wM
         6CBoUE8lHkD6AGg1vFw/RZBxRXdOVte4uU3NG+5hQr4rrfPwilQzweJaZ8ZXiiKK0m/n
         SmsjuYpn6UQGdfxRm47uaioZ8kfbpvx3rq64GrQypNRgouY59uOuJUkZX2oL19zJRLQx
         vGRYgXZ5Nd2JK2smwHwbLJE8mf40jVbgt6q541b7BmOgt0b6jXTv6D/ZXv+57ukJiF3M
         Sr0MgyIw62BTrjvqRzb/dWg35ncHtV/DqiHSMzk2OOduMGuWTDFbq8pNht1PK1VI+ebw
         u1AQ==
X-Gm-Message-State: AOAM530Wdz3e0PZozwZ735plc8iy2XKB0YyH3hnCQUL7MIUHXq34bD98
        SeOzyGaLEsOfkTTbYHsow02A7Q==
X-Google-Smtp-Source: ABdhPJxxq2B1KEdED7rlaD250q9cNV3xVLruR3F1eTVGTX+ZPS0kn50c+XPQMue5y2nWrDYXXdTXRw==
X-Received: by 2002:a6b:e712:: with SMTP id b18mr1473435ioh.186.1631734815054;
        Wed, 15 Sep 2021 12:40:15 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s10sm452088iom.40.2021.09.15.12.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 12:40:14 -0700 (PDT)
Subject: Re: [PATCHSET v3 0/3] Add ability to save/restore iov_iter state
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20210915162937.777002-1-axboe@kernel.dk>
 <CAHk-=wgtROzcks4cozeEYG33UU1Q3T4RM-k3kv-GqrdLKFMoLw@mail.gmail.com>
 <8c7c8aa0-9591-a50f-35ee-de0037df858a@kernel.dk>
 <CAHk-=wj3dsQMK4y-EeMD1Zyod7=Sv68UqrND-GYgHXx6wNRawA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6688d40c-b359-364b-cdff-1e0714eb6945@kernel.dk>
Date:   Wed, 15 Sep 2021 13:40:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj3dsQMK4y-EeMD1Zyod7=Sv68UqrND-GYgHXx6wNRawA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/21 1:26 PM, Linus Torvalds wrote:
> On Wed, Sep 15, 2021 at 11:46 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>    The usual tests
>> do end up hitting the -EAGAIN path quite easily for certain device
>> types, but not the short read/write.
> 
> No way to do something like "read in file to make sure it's cached,
> then invalidate caches from position X with POSIX_FADV_DONTNEED, then
> do a read that crosses that cached/uncached boundary"?
> 
> To at least verify that "partly synchronous, but partly punted to
> async" case?
> 
> Or were you talking about some other situation?

No that covers some of it, and that happens naturally with buffered IO.
The typical case is -EAGAIN on the first try, then you get a partial
or all of it the next loop, and then done or continue. I tend to run
fio verification workloads for that, as you get all the flexibility
of fio with the data verification. And there are tests in there that run
DONTNEED in parallel with buffered IO, exactly to catch some of these
csaes. But they don't verify the data, generally.

In that sense buffered is a lot easier than O_DIRECT, as it's easier to
provoke these cases. And that does hit all the save/restore parts and
looping, and if you do it with registered buffers then you get to work
with bvec iter as well. O_DIRECT may get you -EAGAIN for low queue depth
devices, but it'll never do a short read/write after that. 

But that's not in the regressions tests. I'll write a test case
that can go with the liburing regressions for it.

-- 
Jens Axboe

