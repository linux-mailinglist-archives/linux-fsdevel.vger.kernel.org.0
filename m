Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F92D8143
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 22:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392369AbgLKVr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 16:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393075AbgLKVrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:47:18 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46715C0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 13:46:38 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id p5so10168671iln.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5YZ3H6K6bc/G0qXrDIFefGVxnZGlM8U6jgQ2tyAiHTI=;
        b=d0CMIkFnqPwcAWOJhffv5xQONGukI+RI+CCX4W/nrLhy/6MzwNWjgJvqXGyz/8dH/g
         dkXfvj6pSlyX2brya87K/bCg/sZRYnJvN+eURC4O9j1syrqt/TtubWnnE25PAMOKrm8d
         8bixsCiybezNYWurE/XFjFuYKjv6aicmpmninUdh5VL+CmJ0sFZ438gcD+yFMB032BJj
         5dt7wXcCSF03GanZo3wzgUdF/umQq06hjgQHlq/ufg90lbQf1kXzElAC/pr7H1Mr3xNM
         hkOfREND0JYyWVCKC52maN+PzePflAvflLoKr8y2QEHMRIJcsIsVV1OH6VYJOk4e2NKZ
         lvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5YZ3H6K6bc/G0qXrDIFefGVxnZGlM8U6jgQ2tyAiHTI=;
        b=EEf0Y1zOGWTFh9kPIjMUjesILrVMZXlydwRKDHTQnLySGOVfj8RYwHD6F0aoT4XXap
         x1MIbx3VbPtdG/9FiqcdUr8G5cW1WVEJUf9ZdUdTtFXoTsjifox5bhoM6UDWdWsXMf6P
         rh9ttCDFYLe7wxN8+TUVJ0Y1pN3tJfXyKvV2N6Nw9QFRhXnbVgWA47ScmzTH/BR1YZ6i
         Ye6u+ezNfZ8Dealnc5vy7cjj1jpYo8sRkPR0ydbVGVpTBVb1AJd/hyliHEdCL3dH1WaH
         eSskU4Pd0JbH26f0j6UY7aLqnzcC8PC0wVn3Uh8xRehjcgorZ4YV7D948YTr0SlDP2KY
         BKKg==
X-Gm-Message-State: AOAM530dAlTGfeRcgmTJhzGx1wTsUUonPR1vMbUIIbmo52Z5R62v2TFL
        RSFjyr6NX/V4X8lX3LJVvkRy6V8idxGtWA==
X-Google-Smtp-Source: ABdhPJzFs1zoFAVC/V57JNhrw/nxzy6wlKpS5dRbJXmmPpEjzyKV+/qO9IKDaTnxbzZOSPKqc199IQ==
X-Received: by 2002:a92:358a:: with SMTP id c10mr18422376ilf.258.1607723197273;
        Fri, 11 Dec 2020 13:46:37 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm6272628iln.63.2020.12.11.13.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 13:46:36 -0800 (PST)
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <20201211023555.GV3579531@ZenIV.linux.org.uk>
 <bef3f905-f6b7-1134-7ca9-ff9385d6bf86@kernel.dk>
 <CAHk-=wjkA5Rx+0UjkSFQUqLJK9eRJ_MqoTZ8y2nyt4zXwE9vDg@mail.gmail.com>
 <20201211172931.GY3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53f6be3d-58d7-9471-44ab-1b594b83a4b9@kernel.dk>
Date:   Fri, 11 Dec 2020 14:46:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211172931.GY3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/20 10:29 AM, Al Viro wrote:
> On Fri, Dec 11, 2020 at 09:21:20AM -0800, Linus Torvalds wrote:
>> On Fri, Dec 11, 2020 at 7:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 12/10/20 7:35 PM, Al Viro wrote:
>>>> _IF_ for some theoretical exercise you want to do "lookup without dropping
>>>> out of RCU", just add a flag that has unlazy_walk() fail.  With -ECHILD.
>>>> Strip it away in complete_walk() and have path_init() with that flag
>>>> and without LOOKUP_RCU fail with -EAGAIN.  All there is to it.
>>>
>>> Thanks Al, that makes for an easier implementation. I like that suggestion,
>>> boils it down to just three hunks (see below).
>>
>> Ooh. Yes, very nice.
> 
> Except for the wrong order in path_init() - the check should go _before_
>         if (!*s)
>                 flags &= ~LOOKUP_RCU;
> for obvious reasons.

Oops yes, I fixed that up.

> Again, that part is trivial - what to do with
> do_open()/open_last_lookups() is where the nastiness will be.
> Basically, it makes sure we bail out in cases when lookup itself
> would've blocked, but it does *not* bail out when equally heavy (and
> unlikely) blocking sources hit past the complete_walk(). Which makes
> it rather useless for the caller, unless we get logics added to that
> part as well.  And _that_ I want to see before we commit to anything.

A few items can be handled by just disallowing them upfront - like
O_TRUNC with RESOLVE_NONBLOCK. I'd prefer to do that instead of
sprinkling trylock variants in places where they kind of end up being
nonsensical anyway (eg O_TRUNC with RESOLVE_NONBLOCK just doesn't make
sense). Outside of that, doesn't look like to me that do_open() needs
any further massaging. open_last_lookups() needs to deal with
non-blocking mnt_want_write(), but that looks pretty trivial, and
trylock on the inode.

So all seems pretty doable. Which makes me think I must be missing
something?

-- 
Jens Axboe

