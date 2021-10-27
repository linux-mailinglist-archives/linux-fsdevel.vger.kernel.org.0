Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8A43CDF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242851AbhJ0PxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242848AbhJ0PxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:53:22 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E61C061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 08:50:56 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n67so4214552iod.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 08:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UmEiVd56uxCBfYVCrAIrqJWeH7UWYmcDb5px/zcfIIQ=;
        b=RvoNIZTO/Vg6CRvLWTxAUD8tGIK+KbSL9q4utULvct4x4IXK/vmoDAepU7aN/k3xmk
         l82G37x0EkA9OO/Slzs6T6v6UCwrJodMDJPc2gAOROzajpZ/8/Sw5o8Fd9ZTeP2d3HxC
         DsqxOlKFaz+jUzCj5iCVzrZVYx+fTjN1mBaVFVD9HYGLo7Vu3sjPq7l7R3Am/BLdmFW9
         uLjfofCJLnPypG846GsZRG6cVVNRYYZp8xOr3/m5/Ra9PsGXhiWe2qb3AXE4lmic2SnQ
         COBhPnwkLbVrFzhvrW4BLBXplOMFz/AIiYLpiydK6gH+g6U0MkazQBRrAbpR1X2z5h61
         iSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UmEiVd56uxCBfYVCrAIrqJWeH7UWYmcDb5px/zcfIIQ=;
        b=MbqdPZszBJkdJoXl3CJ5GGworMUJVj3rxO/IzC96fvlTnlhbc4r6AYqNHCvG70GSB2
         MqHGRVABxAAWDuFmV2IG/bBGIH4GIDVa1lKU5zvqAzD07/euayXvdfH01DKWcBP3PDDl
         7bFxulOuLeGaA/ndJxJnSelw5tuQDdwY6rIQD1bqEcQwECDdVKrk9Fqbb+rY5shMPFZj
         Nz4h5gUZ6jET7Ztd90bEZqg6kl220NALbpULGMXEp12DaR3nfPn7deqi5gjfcylnxg4X
         nfEMfZMpns/hExFdlEH+FOzMkR0tnnYnbGEfUW5GVGoikJP84aC2BJSHqmk5/cI0LGna
         x/YQ==
X-Gm-Message-State: AOAM530Y7AuMjUMPaxb2+M1c4BfNKg+Df2BAaLvJuZkWWrbj6oVdY8qf
        QvH/I55fQ/19ZSoMFXHAqTVdYLI5c6cLJg==
X-Google-Smtp-Source: ABdhPJybAU8wujcK1UkmwgEfErgDodVvZtlHe3owVu1nGa9biDysYR/KyAbNoJgVPZA2oa9J3fX9hw==
X-Received: by 2002:a5d:9d46:: with SMTP id k6mr3640586iok.55.1635349856273;
        Wed, 27 Oct 2021 08:50:56 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a4sm126847ild.52.2021.10.27.08.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 08:50:55 -0700 (PDT)
Subject: Re: mm: don't read i_size of inode unless we need it
To:     Chris Mason <clm@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <6b67981f-57d4-c80e-bc07-6020aa601381@kernel.dk>
 <9383DBC8-0C0E-4EF7-A3E3-272FFA9F14D2@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dbe0e37a-cc67-a8e4-64e5-17fbe887fa40@kernel.dk>
Date:   Wed, 27 Oct 2021 09:50:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9383DBC8-0C0E-4EF7-A3E3-272FFA9F14D2@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/26/21 1:11 PM, Chris Mason wrote:
> 
>> On Oct 26, 2021, at 2:15 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> We always go through i_size_read(), and we rarely end up needing it. Push
>> the read to down where we need to check it, which avoids it for most
>> cases.
>>
>> It looks like we can even remove this check entirely, which might be
>> worth pursuing. But at least this takes it out of the hot path.
>>
>> Acked-by: Chris Mason <clm@fb.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> I came across this and wrote the patch the other day, then Pavel pointed
>> me at his original posting of a very similar patch back in August.
>> Discussed it with Chris, and it sure _seems_ like this would be fine.
>>
>> In an attempt to move the original discussion forward, here's this
>> posting.
>>
> 
> I had the same concerns Dave Chinner did, but I think the i_size check
> inside generic_file_read_iter() is dead code at this point.  Checking
> ki_pos against i_size was added for Btrfs:
> 
> commit 66f998f611897319b555364cefd5d6e88a205866
> Author: Josef Bacik <josef@redhat.com>
> Date:   Sun May 23 11:00:54 2010 -0400
> 
>     fs: allow short direct-io reads to be completed via buffered IO
> 
> And we’ve switched to btrfs_file_read_iter(), which does the check the
> same way PavelJens have done it here.
> 
> I don’t think checking i_size before or after O_DIRECT makes the race
> fundamentally different.  We might return a short read at different
> times than we did before, but we won’t be returning stale/incorrect
> data.

Andrew, can you queue this one up in the mm branch?

-- 
Jens Axboe

