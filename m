Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2C41AC12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbhI1JlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 05:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235071AbhI1JlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632821962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2uyMcFBCVrIDBWQdHgkCbftCKZFjQ/HH9/eUB243hc=;
        b=CosQk+HnUtrpcV2AfyBTQn63Wo87BgXSmOQEta+xJKzYkCBL893jmfkU6spoCODJ/83MGi
        Xc3BG+RxpGh6vnJtWp33LcVhCx8Gt2mjL3NiXoEkG9ATD3PEzVmPN0HCytewwuWSMnpk5T
        hRgEEyeBDWjdD1y7+JArxXOAmzeb8/w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-aqYqqcouOHOiQRifSHD-AA-1; Tue, 28 Sep 2021 05:39:20 -0400
X-MC-Unique: aqYqqcouOHOiQRifSHD-AA-1
Received: by mail-ed1-f69.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so21092590edy.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 02:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i2uyMcFBCVrIDBWQdHgkCbftCKZFjQ/HH9/eUB243hc=;
        b=S2MqphlioYFH5/KDfbGII1dVbeHPWXoZ/9DAWLcLKzLcE/woE1Sm54MB1yS0PP7EXO
         eLdhETFXLJt8E5iGn0LnoRzmrcd53ltQNu0RH6oY6ips11pSXeiJ+UihnGedlylb8QVy
         ZsMj9QZPnI+gdJhPSHBRjHpnsqaBE387vX2gvxYKWKR+5MTUdso5QPtyNQRCYqgyxboo
         qXksprtQxzN4R6XbTwm615VKWWmNjg1ah4QOnnNsnBxXLRwL+UJE7hA/3S8asNvUOtje
         icz+Cd85BW9IUmCuAXlNWkl/GtU39nLB4hP2qhT99+w/tlhQKgOtcqJ36eJ5MOLcg8pr
         Wntw==
X-Gm-Message-State: AOAM530sSQJiIpsba/1niqdzXMdrL/gA759b1fyIR7a9ksxUmS0YvuOv
        KFhWRQHoh7VeSUDC5vu+rg1tJV4mDyBudxcPbwXK9QispffWaa70AvrAXJJ4SwLyY1+Q3SyUd0j
        x3xBIEgc0w2H/TgdUAuXLAo2sng==
X-Received: by 2002:a17:906:32d9:: with SMTP id k25mr5584656ejk.290.1632821959172;
        Tue, 28 Sep 2021 02:39:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj/uQoNsIYtJkfNoCs3oxlZlXiGiHVMDCqJw3+0oiGI8SSqcnheFy6heoARl3+raOp0WwbkA==
X-Received: by 2002:a17:906:32d9:: with SMTP id k25mr5584577ejk.290.1632821958364;
        Tue, 28 Sep 2021 02:39:18 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ds10sm2442705ejc.99.2021.09.28.02.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:39:17 -0700 (PDT)
Subject: Re: [PATCH] vboxsf: fix old signature detection
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
References: <20210927094123.576521-1-arnd@kernel.org>
 <40217483-1b8d-28ec-bbfc-8f979773b166@redhat.com>
 <20210927130253.GH2083@kadam>
 <CAK8P3a3YFh4QTC6dk6onsaKcqCM3Nmb2JhMXK5QdZpHtffjyLg@mail.gmail.com>
 <CAHk-=wheEHQxdSJgTkt7y4yFjzhWxMxE-p7dKLtQSBs4ceHLmw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <70a77e44-c43a-f5ce-58d5-297ca2cfe5d9@redhat.com>
Date:   Tue, 28 Sep 2021 11:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wheEHQxdSJgTkt7y4yFjzhWxMxE-p7dKLtQSBs4ceHLmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On 9/27/21 8:33 PM, Linus Torvalds wrote:
> On Mon, Sep 27, 2021 at 6:22 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> More specifically, ' think '\377' may be either -1 or 255 depending on
>> the architecture.
>> On most architectures, 'char' is implicitly signed, but on some others
>> it is not.
> 
> Yeah. That code is just broken.
> 
> And Arnd, your patch may be "conceptually minimal", in that it keeps
> thed broken code and makes it work. But it just dials up the oddity to
> 11.
> 
> The proper patch is just this appended thing that stops playing silly
> games, and just uses "memcmp()".
> 
> I've verified that with sane build configurations, it just generates
> 
>         testq   %rsi, %rsi
>         je      .L25
>         cmpl    $-33620224, (%rsi)
>         je      .L31
> 
> for that
> 
>         if (data && !memcmp(data, VBSF_MOUNT_SIGNATURE, 4)) {
> 
> test. With a lot of crazy debug options you'll actually see the
> "memcmp()", but the bad code generation is the least of your options
> in that case.

I agree that your suggestion is to be the best solution,
so how do we move forward with this, do I turn this into a
proper patch with you as the author and Arnd as Reported-by and
if yes may I add your Signed-off-by to the patch ?

Or do I make myself author and set you as Suggested-by ?

Regards,

Hans

