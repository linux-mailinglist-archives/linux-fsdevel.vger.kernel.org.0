Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C883B2A117B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 00:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgJ3XVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 19:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgJ3XVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:21:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609E3C0613D5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 16:21:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r10so6447752pgb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 16:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=szW1ujHcKlBlbMuxSna8/x1FV/mLWXPIGi7WYHdP5RM=;
        b=MRu1uNMLSDq03iUk3DC0Pyz6AuV+8o119QEJ7Puem5z6bNl0q5bPjercQbL8bYsRoF
         dqkAeLhHPy3CZsdyVPycF7b9++R3t4rKKe8WWWJo+j1rWGHsEXuVb69iRFl7LV8HAv7D
         sUUals8KvsFxC1klknVWcsqZj5g6BwXcv4fctxjISJZ3m7O48K3ZGxuJ9tGSJl4Ao4m/
         chODOm/qUrj+7qHI9Viv47dRIhWnChXLheBD/fqpepLGc144igZGAY/vDY3gQXa1VfFd
         QSUTWuHYP3Cc6n6pzJIQAgtAXcacZ1m5I6bB4u9ep4pVa0MuKFeYnCzcL0Od5oAu+5CI
         0Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szW1ujHcKlBlbMuxSna8/x1FV/mLWXPIGi7WYHdP5RM=;
        b=lzuiPD0C+nlwnXalPAOUWv1PwVyLjhbtzF4BTg4l0d/8We1O+D/V13pU3amQGT7o3P
         S2Mo39I4UVv0rVkjARC42UXI06Ccp8PrvBy/G3jD02f4sGh5s+cHzy1RVbYADRxVyU/W
         bQyz82n2rkxjKx5UuKnT2Esdb5+IUIFme4HcPQMIdxMDyClNij+FAx4cel6hMIymR1cB
         PKk1h1wzZwktuLlddUvwQDZP0o89h3hcNHzanfQ/+w92U17upWpKYZD5RY4QwTbgdqJ3
         kwyciAcdQnAEvp9o6qvQ+LsOPp75tN7tr5kwV4E/kuwN2m32mLwD6zTBuswK93PUHoD5
         EjIQ==
X-Gm-Message-State: AOAM53383sIlbhFQx9ytoSYG9DFpqmDO767UOMqN1yqKWFa9b6XOArzK
        mB/GlJtDE0zdBllt6YaTZf/L8oNHRv7c+w==
X-Google-Smtp-Source: ABdhPJxE49m3f1tuToCW0KsWKfsPhKhMZaTatHli0bSelZdrZm9BlFEbvOaF/9jL8wcme/V2ibEAYg==
X-Received: by 2002:a62:1844:0:b029:152:80d3:8647 with SMTP id 65-20020a6218440000b029015280d38647mr11131900pfy.18.1604100106559;
        Fri, 30 Oct 2020 16:21:46 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w205sm6744899pfc.78.2020.10.30.16.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 16:21:45 -0700 (PDT)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Qian Cai <cai@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
 <20201030184255.GP3576660@ZenIV.linux.org.uk>
 <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
 <20201030184918.GQ3576660@ZenIV.linux.org.uk>
 <d858ba48-624f-43be-93cf-07d94f0ebefd@kernel.dk>
 <20201030222213.GR3576660@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1e17902-a204-f03d-2a51-469633eca751@kernel.dk>
Date:   Fri, 30 Oct 2020 17:21:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030222213.GR3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 4:22 PM, Al Viro wrote:
> On Fri, Oct 30, 2020 at 02:33:11PM -0600, Jens Axboe wrote:
>> On 10/30/20 12:49 PM, Al Viro wrote:
>>> On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:
>>>
>>>> See other reply, it's being posted soon, just haven't gotten there yet
>>>> and it wasn't ready.
>>>>
>>>> It's a prep patch so we can call do_renameat2 and pass in a filename
>>>> instead. The intent is not to have any functional changes in that prep
>>>> patch. But once we can pass in filenames instead of user pointers, it's
>>>> usable from io_uring.
>>>
>>> You do realize that pathname resolution is *NOT* offloadable to helper
>>> threads, I hope...
>>
>> How so? If we have all the necessary context assigned, what's preventing
>> it from working?
> 
> Semantics of /proc/self/..., for starters (and things like /proc/mounts, etc.
> *do* pass through that, /dev/stdin included)

Don't we just need ->thread_pid for that to work?

-- 
Jens Axboe

