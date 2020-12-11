Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40D2D7EC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 19:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391845AbgLKSvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 13:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390401AbgLKSuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:50:55 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E84C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 10:50:15 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u4so5013968plr.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 10:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GG0/h4Va1WulHBW9N2JBUEKUPLoBiia+nDrqhRrdYf4=;
        b=rQnx09Zn/6lYrARn5fUhi5+3P5m0dK+VnhfK9zc/hOveTg3OobAe7CRrAoDRF9FLMK
         bzDynvbozi5ndo2O46ls95/AIJ545K/YjBw/CA8JEPrdp04SYBvNcv45J8y81jvACPQb
         6DG2pQebbeQ/rwUDevKgTgG/RZK3r/8S9MaazzrhBbAHA0ocH/gTOYxy8KFeDJqhb2/B
         c2aJ9Uus/00WMQp0hvcraYzzc633BiEbVVK0rGlRUUypehpg0Yws0stvEzybMu7NPn6m
         XSCIELovSJGoOGpqSwAiAcOEm/LbljQN22lPyzwrdwoD00qthbl9/lp0XH3C5xkS2rvZ
         83dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GG0/h4Va1WulHBW9N2JBUEKUPLoBiia+nDrqhRrdYf4=;
        b=HHGYvtA5kJauGIF1F0YeoTgFMAtjwu6Smhje8xvWf/9ml/bAhFzFnhufkIXcA0i5Ao
         dsNSCKLmDt18LQ/vVCLYGlVH4uQ6qcpffjQ0jpRS6Sjp1C55IPmNAKiHLeCjmsjH7+V6
         pVbPGAc55/zfFyRd6x/GHu1GfcpFNzE8FKvh/iy/3louJDiaR5oOJRlCYes/OvKcV5B+
         eemCM13XtGgpcQbORdna5wQe/Tn8515l4fpWAhczqBB6Xd0iyNtGMgFIsCWEvsRfasmL
         it+FnbGcQvV6mGYZ54Mgy/5b9QVsnQPvwDxGMgxqCSWAT/DJgamawZRM6UQOx5ey/lAl
         xh7Q==
X-Gm-Message-State: AOAM5313t9bRYcpE9bS1LlVnh8A683Jt5IKeTB9So/24LHC9oU4CzmQs
        uBIMoNfMkpudYD35KiYmwDq+3SpRFaz3wg==
X-Google-Smtp-Source: ABdhPJxiaR1WrjUwgZGWCP4xAio7wV4m1lSpV9cnX3r4ij0vz4mPJXjKzlE1KL2Q9qRCQx/labmdfw==
X-Received: by 2002:a17:90a:6809:: with SMTP id p9mr13944076pjj.112.1607712614881;
        Fri, 11 Dec 2020 10:50:14 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v63sm10899224pfb.217.2020.12.11.10.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 10:50:14 -0800 (PST)
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
 <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
 <20201211024553.GW3579531@ZenIV.linux.org.uk>
 <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk>
 <20201211172054.GX3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b4dbb32-14b0-fe5d-9330-2bae036cbb93@kernel.dk>
Date:   Fri, 11 Dec 2020 11:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211172054.GX3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/20 10:20 AM, Al Viro wrote:
> On Fri, Dec 11, 2020 at 09:05:26AM -0700, Jens Axboe wrote:
> 
>>> Finally, I really wonder what is that for; if you are in conditions when
>>> you really don't want to risk going to sleep, you do *NOT* want to
>>> do mnt_want_write().  Or ->open().  Or truncate().  Or, for Cthulhu
>>> sake, IMA hash calculation.
>>
>> I just want to do the RCU side lookup, that is all. That's my fast path.
>> If that doesn't work, then we'll go through the motions of pushing this
>> to a context that allows blocking open.
> 
> Explain, please.  What's the difference between blocking in a lookup and
> blocking in truncate?  Either your call site is fine with a potentially
> long sleep, or it is not; I don't understand what makes one source of
> that behaviour different from another.

I could filter on O_TRUNC (and O_CREAT) in the caller from the io_uring
side, and in fact we may want to do that in general for RESOLVE_LOOKUP
as well. Or handle it in do_open(), which probably makes a lot more
sense. In reality, io_uring would check this upfront and just not bother
with an inline attempt if O_TRUNC is set, as we know we'll wind up with
-EAGAIN at the end of it.  I don't think the combined semantics make any
sense, as you very well may block if you're doing truncate on the file
as part of open. So that should get added to the patch adding
RESOLVE_LOOKUP.

> "Fast path" in context like "we can't sleep here, but often enough we
> won't need to; here's a function that will bail out rather than blocking,
> let's call that and go through offload to helper thread in rare case
> when it does bail out" does make sense; what you are proposing to do
> here is rather different and AFAICS saying "that's my fast path" is
> meaningless here.

What you're describing is exactly what it is - and in my terminology,
O_TRUNC is not part of my fast path. It may be for the application, but
I cannot support it as we don't know if it'll block. We just have to
assume that it might, and that means it'll be handled from a different
context.

> I really do not understand what it is that you are trying to achieve;
> fastpath lookup part would be usable on its own, but mixed with
> the rest of do_open() (as well as the open_last_lookups(), BTW)
> it does not give the caller any useful warranties.

open_last_lookups() will end up bailing us out early, as we end the RCU
lookup side of things and hence would terminate a LOOKUP_NONBLOCK with
-EAGAIN at that point anyway.

> Theoretically it could be amended into something usable, but you
> would need to make do_open(), open_last_lookups() (as well as
> do_tmpfile()) honour your flag, with similar warranties provided
> to caller.
> 
> AFAICS, without that part it is pretty much worthless.  And details
> of what you are going to do in the missing bits *do* matter - unlike the
> pathwalk side (which is trivial) it has potential for being very
> messy.  I want to see _that_ before we commit to going there, and
> a user-visible flag to openat2() makes a very strong commitment.

Fair enough. In terms of patch flow, do you want that as an addon before
we do RESOLVE_NONBLOCK, or do you want it as part of the core
LOOKUP_NONBLOCK patch?

> PS: just to make sure we are on the same page - O_NDELAY will *NOT*
> suffice here.  I apologize if that's obvious to you, but I think
> it's worth spelling out explicitly.
> 
> PPS: regarding unlazy_walk() change...  If we go that way, I would
> probably changed the name to "try_to_unlazy" and inverted the meaning
> of return value.  0 for success, -E... for failure is fine, but
> false for success, true for failure is asking for recurring confusion.
> IOW, I would rather do something like (completely untested)

Agree, if we're going bool, we should make it the more usually followed
success-on-false instead. And I'm happy to see you drop those
likely/unlikely as well, not a huge fan. I'll fold this into what I had
for that and include your naming change.

-- 
Jens Axboe

