Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B094B257F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 19:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgHaRTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHaRTw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:19:52 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BB6C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:19:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w3so1831569ilh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VFdt7etUeQh3jxuMBHIEMKMPh4ts8dvxCAT119Mpugg=;
        b=Vo11h+a+ZfPnLz90Hd5qdtWJf5qj5Gs5Nn7Qk8AU09Nz03B4/3IvZR9TowM01rZgm8
         UgS2O7aT2iXFkO0KpGd1Gb8ZZ+YOQs6GiV8gfS7Xl3uz4NsQj3zqpBGySrjkzG5PX9LL
         f1GKb86gQK77dSHf2aqusA2iSI9zbxGuUTtINnRnKqvOG6z0O2g3lQ8DWAP9QKlof5+2
         l0izvmIPBAqmgzE8xR2vzkpuLGExEjdCw3XPLfffBBguLs/BSra6Aw3e+XoTKJfPodQj
         uRXaLG0zidNJsRrip8Q4GpE1YYfgGZYZIOWQDsefBUyPfU2sug3Yb+I/uOw8wZne539P
         IxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VFdt7etUeQh3jxuMBHIEMKMPh4ts8dvxCAT119Mpugg=;
        b=JjYmHB0IH47ELk7k8FNtGTl2VTKOLy3h0PNsQJF7+XXvdNvf/0qdlYvB3ApE1/O5xG
         Yfdvgozgl4/LdJH3pDsz95sUFvMchONISnzRVGnFbA/Di/IazVcxCAFNQ8rPyJA8ZkKt
         3YhPxQc7B0UzQIl5m+kseMxVZkII3pC/rdvhzG05tsyiFPLbegWU2CpzA3UkL6Oz9Y2G
         MmDJ3XHItzPf4CSN4ipvKAr2MMACjz9VVMjBPxspJGSKiAm11A0zNdKXD24CaX5vLowp
         g1OM9MsGimE5lsqsnsk3+kpiil0+qq4ldHKKjyXOMGY/b3cjw1+n2thFk0cv5+d97/eE
         NCng==
X-Gm-Message-State: AOAM530UC22aD9uH8YJbLKxuj2zGqk0XdBY76drCuuQTHuFHujmZBW+k
        rPWtoMKp8YY5w26JHPOdfdCTYpRWXqzsaKjZ
X-Google-Smtp-Source: ABdhPJwFd4evUDpn/xryReIn3mh0v88tjP/Ib5bE0rsCoTyUZ7768JdIl8QQxa4QHw5UGsIo5PWuuQ==
X-Received: by 2002:a92:8709:: with SMTP id m9mr2295649ild.242.1598894390456;
        Mon, 31 Aug 2020 10:19:50 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t4sm4288408iob.48.2020.08.31.10.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 10:19:49 -0700 (PDT)
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>
References: <87ft85osn6.fsf@mail.parknet.co.jp>
 <b4e1f741-989c-6c9d-b559-4c1ada88c499@kernel.dk>
 <87o8mq6aao.fsf@mail.parknet.co.jp>
 <4010690f-20ad-f7ba-b595-2e07b0fa2d94@kernel.dk>
 <87h7si68hn.fsf@mail.parknet.co.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f4d6aef-c75c-dd0f-02cb-a1246079c429@kernel.dk>
Date:   Mon, 31 Aug 2020 11:19:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7si68hn.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/20 11:16 AM, OGAWA Hirofumi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 8/31/20 10:37 AM, OGAWA Hirofumi wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> I don't think we should work-around this here. What device is this on?
>>>> Something like the below may help.
>>>
>>> The reported bug is from nvme stack, and the below patch (I submitted
>>> same patch to you) fixed the reported case though. But I didn't verify
>>> all possible path, so I'd liked to use safer side.
>>>
>>> If block layer can guarantee io_pages!=0 instead, and can apply to
>>> stable branch (5.8+). It would work too.
>>
>> We really should ensure that ->io_pages is always set, imho, instead of
>> having to work-around it in other spots.
> 
> I think it is good too. However, the issue would be how to do it for
> stable branch.

Agree

> If you think that block layer patch is enough and submit to stable
> (5.8+) branch instead, I'm fine without fatfs patch. (Or removing
> workaround in fatfs with block layer patch later?)

Well, it should catch any block based case as we then set it when
allocating the queue. So should do the trick for all block based
cases at least.

-- 
Jens Axboe

