Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7663111C0AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 00:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLKXl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 18:41:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42633 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLKXl4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:41:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so89488pfz.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 15:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kpNlzVcv7JN7E6YhjIPCUm4BYR7x79EcBxfrlw22S00=;
        b=lNMQ0l96BGpM2u4/wCZBoSrFB93g3IOanTEQQ+kdic7G16RGwofrZTW8qUp1QNENny
         T1Eb/+YV7QhwyPRj9GARsbeTzqugStumohKT6y0N2LcAsgp11lKJYqym6sJkQoYWcML7
         tv6Tk038FmRqpyXdZbMU1yMUeYzTbL+KVUXE3j9+u5tYvO14L9z7nNlWu7bUQ50bxPfh
         X+12YPIyy3eQjnNp9WFgw5NnextOhh69DfsoZEJbYUYw9qT4jmF2nAKnOliEKnQjAPc6
         0f/gEoMuhK3OcD1hyPTntiz+91l7s6taPogaoXlu5MaMRGRPWbjPtG7F4qOLOQld1YYJ
         v+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kpNlzVcv7JN7E6YhjIPCUm4BYR7x79EcBxfrlw22S00=;
        b=bKnxfGdPnhOg2d9FWamRBdDazw4lBHllgTy62OCk2OCzAaxnLQIgUnFEMMaebsnApO
         AQaEcbj5TouLg8jLvJQMVTQOgABUugFqjBb+JRhoD1evhkajghay8KsIPeHVpPfU7OvK
         NTgVLE0Oj+MttQTRkU5aW0eSVPp/romwPpxS+DcKwylHONmT+GyMPN9bg9rcESJFhg5f
         Tw+dKS9IOdE1HWRt9xMoBOvjIvHhGSicA0ze5r/P+gLla4BJ9tovp1RBUE0BgPy8Lz3C
         LfumYStac6GqNAz4OmksU9gowqC7X5YphYdQEAanPBdrofHMiuKtUSlPG+cdmGX5cy8o
         2a1w==
X-Gm-Message-State: APjAAAUNCImLa2s71BnH/Z3QEYl4eXGnqlDogju7V9EawtIMhoSjFLfJ
        4cHukn9+BqUvjoybHoR4XdS/cQ==
X-Google-Smtp-Source: APXvYqwGOwKUwd/HWjO/NJjda16cvXL4uvMFEOj+dWRqjsE0z2VrBX/uK93JoRyDrVWFrEuUz+X4rg==
X-Received: by 2002:aa7:801a:: with SMTP id j26mr6656838pfi.50.1576107715544;
        Wed, 11 Dec 2019 15:41:55 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id s27sm4414042pfd.88.2019.12.11.15.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 15:41:54 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
Date:   Wed, 11 Dec 2019 16:41:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/19 1:18 PM, Linus Torvalds wrote:
> On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> $ cat /proc/meminfo | grep -i active
>> Active:           134136 kB
>> Inactive:       28683916 kB
>> Active(anon):      97064 kB
>> Inactive(anon):        4 kB
>> Active(file):      37072 kB
>> Inactive(file): 28683912 kB
> 
> Yeah, that should not put pressure on some swap activity. We have 28
> GB of basically free inactive file data, and the VM is doing something
> very very bad if it then doesn't just quickly free it with no real
> drama.
> 
> In fact, I don't think it should even trigger kswapd at all, it should
> all be direct reclaim. Of course, some of the mm people hate that with
> a passion, but this does look like a prime example of why it should
> just be done.

For giggles, I ran just a single thread on the file set. We're only
doing about 100K IOPS at that point, yet when the page cache fills,
kswapd still eats 10% cpu. That seems like a lot for something that
slow.

> MM people - mind giving this a look?  Jens, if you have that NOACCESS
> flag in a git tree too and a trivial way to recreate your load, that
> would be good for people to be able to just try things out.

I've pushed the NOACCESS thing to my buffered-uncached branch as well,
and fio has a 'noaccess' branch that enables it for pvsync2 (which is
preadv2/pwritev2) and the io_uring engine.

Here's what I did to reproduce:

- Boot the box with 32G of memory.
- On a fast device, create 10x RAM size of files. I used 32 files, each
  10G. Mine are in /data, and they are named file[1-32].
- Run a buffered read workload on those files.

For pvsync2, something ala:

$ cat job.fio
[test]
ioengine=pvsync2
#uncached=1
#noaccess=1
iodepth=4
bs=4k
group_reporting=1
rw=randread
norandommap
buffered=1
directory=/data
filename=file1:file2:file3:file4:file5:file6:file7:file8:file9:file10:file11:file12:file13:file14:file15:file16:file17:file18:file19:file20:file21:file22:file23:file24:file25:file26:file27:file28:file29:file30:file31:file32

If you want to use more than one thread, add:

numjobs=4

for 4 threads. Uncomment the 'uncached=1' and/or 'noaccess=1' to enable
either RWF_UNCACHED or RWF_NOACCESS.

-- 
Jens Axboe

