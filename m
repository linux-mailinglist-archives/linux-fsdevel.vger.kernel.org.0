Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263BD1459BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAVQXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 11:23:51 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45713 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgAVQXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:23:51 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so5549127iln.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 08:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qd212GpAeBiT+bOhcHajd5vqUEUa5I9kMtyq3yCAEmQ=;
        b=mue3pte0awojv5WEyjmQ3pHKEZX89ZarBjS2AYER83NH5HAIrjmTOwryC12I1rBCHB
         iMpA2fcylzZACr8/s6y7K6tiDwf+q3XJNxOOs9PlBOmkJsafryGEKBWO9VO3nVsQsUdi
         Nz1aVfBlRk+aYPRB9SiAMEbtmde1KpXvyLeJxwHuqnT8neki6NKXfuodIwZaTmF5O91A
         8kAEf+l64Rac7N1bhQQ7xWMbNKlZHT0PNzldwehQQrLOrriwNVZbevZKMmkjd/N8AP3m
         szOkOSm6wR19jyuu3PG/3wzXvYrRocP1VyXExr3a/m0gRW/rbJo76snewIpNUa77N9u0
         2wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qd212GpAeBiT+bOhcHajd5vqUEUa5I9kMtyq3yCAEmQ=;
        b=W6kgvnkJIcIEb/cmYKhxPHhqlmWMTrjSPh4uOMh+ipKAWde1Ft7OVQormWR5LoZv5/
         Z5IXC2MoKm2t2frQluJP5/Ewog3v346mPm27xs6Mg7m6h4APZxkO8k12lJiKQeJQpKEh
         ZGo/Z2kDfrXLYYqc7hK9k8A9nDwm1JxWoQ+sQUQoLQVSac0QxYF6++dPnauDyNJtFVhB
         5Y+cRO4kCKwWcsoCaf1LpLrMp8i00UqTTtDShFcnIr6Skywz4BIuXyQt+/wQ+yieHBSS
         UP48RW9ujS6mMQucheiwkB53LXIWNv1WE0VFGmemmXNoLfyg2iR3jL/CV5GqBEKe8or3
         pHlA==
X-Gm-Message-State: APjAAAWO/KPlfQ2J4L0d6Ri4T8KNQN04CvJHP43P5lawhxgKhSQ6I0y1
        UBLHq8hEJ0oebt+rHOjGHNfaGyZo3LI=
X-Google-Smtp-Source: APXvYqzG2nxbgjWfdj++WWu0Lcd8vAWQE+i0nPSmtm/UEar+o5yT5c3DZjKhKvefiPslG91vrmPzqA==
X-Received: by 2002:a92:b6d1:: with SMTP id m78mr7600031ill.245.1579710230238;
        Wed, 22 Jan 2020 08:23:50 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h85sm14472875ili.22.2020.01.22.08.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:23:49 -0800 (PST)
Subject: Re: [PATCH 2/3] eventpoll: support non-blocking do_epoll_ctl() calls
To:     Jann Horn <jannh@google.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20200122160231.11876-1-axboe@kernel.dk>
 <20200122160231.11876-3-axboe@kernel.dk>
 <CAG48ez0+wiY4i0nFFXpKvqpQDNYQvzHAJhAMVD0rv5cpEicWkw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b1dbe59e-fd25-d8da-e909-667d2a515e46@kernel.dk>
Date:   Wed, 22 Jan 2020 09:23:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez0+wiY4i0nFFXpKvqpQDNYQvzHAJhAMVD0rv5cpEicWkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/20 9:20 AM, Jann Horn wrote:
> On Wed, Jan 22, 2020 at 5:02 PM Jens Axboe <axboe@kernel.dk> wrote:
>> Also make it available outside of epoll, along with the helper that
>> decides if we need to copy the passed in epoll_event.
> [...]
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index cd848e8d08e2..162af749ea50 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
> [...]
>> -static int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds)
>> +static inline int epoll_mutex_lock(struct mutex *mutex, int depth,
>> +                                  bool nonblock)
>> +{
>> +       if (!nonblock) {
>> +               mutex_lock_nested(mutex, depth);
>> +               return 0;
>> +       }
>> +       if (!mutex_trylock(mutex))
>> +               return 0;
>> +       return -EAGAIN;
> 
> The documentation for mutex_trylock() says:
> 
>  * Try to acquire the mutex atomically. Returns 1 if the mutex
>  * has been acquired successfully, and 0 on contention.
> 
> So in the success case, this evaluates to:
> 
>     if (!1)
>       return 0;
>     return -EAGAIN;
> 
> which is
> 
>     if (0)
>       return 0;
>     return -EAGAIN;
> 
> which is
> 
>     return -EAGAIN;
> 
> I think you'll have to get rid of the negation.

Doh indeed. I'll rework and run the test case, just rebased this and I
think I inadvertently used an older version. Ditto for the below.

-- 
Jens Axboe

