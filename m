Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF72FC9C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 16:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKNPUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 10:20:22 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46160 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKNPUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:20:21 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so7141205iol.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 07:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vpd16eavpmhvftjyKz985AmPeNIs+JfDlbBiiR7zkfc=;
        b=uGb1zBYJJpThFDYCcIxgKaHpCNVMaZuYtiKEcWiz/VxIPkRceu3ODp9cuiBPjIgwtM
         +RF7+sl2A5D2Y7yY80BSsBNmSzLakYQdXzuYhEq7szm1lWGcDB/QELSsZhHkMZUxGeHg
         oiIwmv61f86XHQseUbizRrJnJBp3LlSlE77CahpuSmBsl7un4nwN9pkDKU/xcb2OdCZp
         LM+FGwaPD1818bRln/cKHCSlWOti795zAtaijCkF5MMtBYKokt8cTmkNI+eDloUh33IE
         K1gRrFI+tZdmsmsugG/WlDn81+axhx8uEZk35SjDM7fgesNXwGmRbosHh0ZAh43+US9L
         Tdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vpd16eavpmhvftjyKz985AmPeNIs+JfDlbBiiR7zkfc=;
        b=hIHzb/XQN1Dt9eGqB2WzE4UC1MZCIOK3aetUlAc2UBiRu4KuLWOE4o+ACXrGV+CaKm
         jThI+7Hn8Pxm6QKy6eSd5QtSBkTmtGii8USGlLEELvyEs7BreGxy09FSAYAKeIdU3kyP
         PpYg8wbk9YkBh0vlNWaPgubGjChhNE79qRmIHQG7iIIIBlZW9k57WBequEXXBiUswEJ0
         fjIYEbHeZuYrhu4YGYyVC7dmvtKvvN+udRwjEP/XPOOelnbFKVqHL9W9InN/8pLbmCXz
         xO3/H9aaYCWJyloU8Z1/9eS7sRN0VDS8mVm7l9oQCzzxedifor5lZnXxewvN/2LeJseh
         RgQw==
X-Gm-Message-State: APjAAAUO8zqule51erwMOZKf5+Eb5yUPG3GSqRsiwWDSTGP677dfxX/a
        4fq3zFLhKt/GmhmKr8Rno21tcg==
X-Google-Smtp-Source: APXvYqy5EI/qSRAtCkOOx7aGDPcLuTi/cX9oQolxwD7v62CvKOF5bCsQVZPHj//oBiARdvv0st34yw==
X-Received: by 2002:a6b:7c42:: with SMTP id b2mr8780551ioq.184.1573744821048;
        Thu, 14 Nov 2019 07:20:21 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t68sm768152ilb.66.2019.11.14.07.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:20:20 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio)
 POLL
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
 <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk>
 <ec3526fb-948a-70c0-4a7b-866d6cd6a788@rasmusvillemoes.dk>
 <CAG48ez3dpphoQGy8G1-QgZpkMBA2oDjNcttQKJtw5pD62QYwhw@mail.gmail.com>
 <ea7a428d-a5bd-b48e-9680-82a26710ec83@rasmusvillemoes.dk>
 <e568a403-3712-4612-341a-a6f22af877ae@kernel.dk>
 <0f74341f-76fa-93ee-c03e-554d02707053@rasmusvillemoes.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6243eb59-3340-deb5-d4b8-08501be01f34@kernel.dk>
Date:   Thu, 14 Nov 2019 08:20:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0f74341f-76fa-93ee-c03e-554d02707053@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/14/19 8:19 AM, Rasmus Villemoes wrote:
> On 14/11/2019 16.09, Jens Axboe wrote:
>> On 11/14/19 7:12 AM, Rasmus Villemoes wrote:
> 
>>> So, I can't really think of anybody that might be relying on inheriting
>>> a signalfd instead of just setting it up in the child, but changing the
>>> semantics of it now seems rather dangerous. Also, I _can_ imagine
>>> threads in a process sharing a signalfd (initial thread sets it up and
>>> blocks the signals, all threads subsequently use that same fd), and for
>>> that case it would be wrong for one thread to dequeue signals directed
>>> at the initial thread. Plus the lifetime problems.
>>
>> What if we just made it specific SFD_CLOEXEC?
> 
> O_CLOEXEC can be set and removed afterwards. Sure, we're far into
> "nobody does that" land, but having signalfd() have wildly different
> semantics based on whether it was initially created with O_CLOEXEC seems
> rather dubious.
> 
>   I don't want to break
>> existing applications, even if the use case is nonsensical, but it is
>> important to allow signalfd to be properly used with use cases that are
>> already in the kernel (aio with IOCB_CMD_POLL, io_uring with
>> IORING_OP_POLL_ADD). Alternatively, if need be, we could add a specific
>> SFD_ flag for this.
> 
> Yeah, if you want another signalfd flavour, adding it via a new SFD_
> flag seems the way to go. Though I can't imagine the resulting code
> would be very pretty.

Well, it's currently _broken_ for the listed in-kernel use cases, so
I think making it work is the first priority here.

-- 
Jens Axboe

