Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C222DB3EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 19:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbgLOSpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 13:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbgLOSpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:45:15 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB453C06179C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 10:44:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n10so7819597pgl.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 10:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TVtE04yO2znxm7b6exvLWNdPBZc16ShPQu/7byYvvWM=;
        b=Id2jWSKj1ZiD7eQ+uQ8Xm6k8XfbLr11UVHdeevwNkeujTBCv3gPIg1ZPL+4VrmLgDe
         ydxaDncsH8vhFpZ9a/9i583/wi6DTzipezNCCZFRVzBkkNcBkdEJ5oO+XprJv0xqKpn2
         D/+a+pfIqez7tyTyN1/iwHP6DPpuXo/WOg1Kt3TAy+vFyoFe1fOvLTcxyiqzPBYF0pTq
         2PN/udYRERiP/ESMdZnr9V6VnInprkvE4rsREyo8LINo3QebDTQCw/8SqupMNNvJRqxW
         0DmqWStQJvkpV+6VeWyMJ8azhrM+PZGe07tXJ0VoEVNZeEwXylnGnIG6cYTeYIFux3IL
         HFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TVtE04yO2znxm7b6exvLWNdPBZc16ShPQu/7byYvvWM=;
        b=KtHF+EGmpt7+2r2tMcSiWlhHSaz1Xo0ArJR7KRPBdMPhJIMPmMZ/Sv6qu4KFk9dcRs
         yTfYZ2k1+NoWG9TEcYWPFEc3EywzIZMoO8htsHKv6izBQjycinaV+rWZNbZWuxxRg94s
         b4j3UT2IwakWEd4PA2qDIHWVno4KffolK7CTEojsY6pHhkhEQI9U//RSPdZ16iPh/h+J
         1HJl+Manf5U1CGciioa19wcKT/kcAQeaUaoy8z1ngbAP3toMZCifCdYzEEdDfCYVT59Y
         KHkWHLM2DvC2SCifnPYvu//haiDAp0530GMwRbn+HUhooFeKKLvXCt0SPwzuDUkX0CyC
         hyIw==
X-Gm-Message-State: AOAM5329QW9Ht//SYNxQUwH3st6FoNFBQ8KBR027wv0IHKBirYCAM5+k
        iRKnB2cQkRy6byOErVM0il8zFRBYbJdhHA==
X-Google-Smtp-Source: ABdhPJyCzxxGGWFg9VvidVvUxGbGIwKLaFSZOT4dVw23eKiM25BNB4ZPzElJlu8vIA+1BWpCMeZFrw==
X-Received: by 2002:a05:6a00:8c4:b029:196:6931:2927 with SMTP id s4-20020a056a0008c4b029019669312927mr29336555pfu.56.1608057874147;
        Tue, 15 Dec 2020 10:44:34 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m77sm25339516pfd.105.2020.12.15.10.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 10:44:33 -0800 (PST)
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
 <20201215122447.GQ2443@casper.infradead.org>
 <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
 <20201215153319.GU2443@casper.infradead.org>
 <7c2ff4dd-848d-7d9f-c1c5-8f6dfc0be7b4@kernel.dk>
 <4ddec582-3e07-5d3d-8fd0-4df95c02abfb@kernel.dk>
 <CAHk-=wgsdrdep8uT7DiWftUzW5E5tb_b6CRkMk0cb06q3yE_WQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <01be1442-a4d1-6347-f955-3a28a8d253e7@kernel.dk>
Date:   Tue, 15 Dec 2020 11:44:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgsdrdep8uT7DiWftUzW5E5tb_b6CRkMk0cb06q3yE_WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 11:29 AM, Linus Torvalds wrote:
> On Tue, Dec 15, 2020 at 8:08 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> OK, ran some numbers. The test app benchmarks opening X files, I just
>> used /usr on my test box. That's 182677 files. To mimic real worldy
>> kind of setups, 33% of the files can be looked up hot, so LOOKUP_NONBLOCK
>> will succeed.
> 
> Perhaps more interestingly, what's the difference between the patchset
> as posted for just io_uring?
> 
> IOW, does the synchronous LOOKUP_NONBLOCK actually help?
> 
> I'm obviously a big believer in the whole "avoid thread setup costs if
> not necessary", so I'd _expect_ it to help, but maybe the possible
> extra parallelism is enough to overcome the thread setup and
> synchronization costs even for a fast cached RCU lookup.

For basically all cases on the io_uring side where I've ended up being
able to do the hot/fast path inline, it's been a nice win. The only real
exception to that rule is buffered reads that are fully cached, and
having multiple async workers copy the data is obviously always going to
be faster at some point due to the extra parallelism and memory
bandwidth. So yes, I too am a big believer in being able to perform
operations inline if at all possible, even if for some thing it turns
into a full retry when we fail. The hot path more than makes up for it.

> (I also suspect the reality is often much closer to 100% cached
> lookups than just 33%, but who knows - there are things like just
> concurrent renames that can cause the RCU lookup to fail even if it
> _was_ cached, so it's not purely about whether things are in the
> dcache or not).

In usecs again, same test, this time just using io_uring:

Cached		5.10-git	5.10-git+LOOKUP_NONBLOCK
--------------------------------------------------------
33%		1,014,975	900,474
100%		435,636		151,475

As expected, the closer we get to fully cached, the better off we are
with using LOOKUP_NONBLOCK. It's a nice win even at just 33% cached.

-- 
Jens Axboe

