Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D2D3B2518
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 04:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFXCjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 22:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFXCi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:38:59 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8877C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 19:36:41 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r12so6028460ioa.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 19:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EIxse06UlTGpopuKabb5eQIQ9fnurVmSUcwaOObP4yQ=;
        b=tzNIt+HxId9FEjsg6rubH98s3IFMp5yzDrltIM7UIizB34vOoeTuKlvKPlFe3aQlV5
         gQ6ZwaXw1oei6ERkm2uIepT/qIrvXgvC8uJikGOZa6oIHHxGsIxwQsZuZ7mbhNwRHlOc
         IRxHdeW43i2RmbkRqN2odQToHi+zHenxtGNzLoyjkF0e+DaSV7UjA54QsZ7l7khPaMME
         gi+7YFnmrmj5V643dTs0TYLuZ4oBKe2+mE32PI/CijpK2gdBbipK+DDdpjJ+HKfTEh5w
         jgtZ+BzEHSc7lTKLwTixhNsKtPQkYw0avVIX/2xsxT2JZH09nhAz4ZaXEElwSI9YRlEL
         kjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EIxse06UlTGpopuKabb5eQIQ9fnurVmSUcwaOObP4yQ=;
        b=f9EAL9n9/6JELbSOQmMECcqavM3793OEt49X5FMI2oP6b45hSe+EsCDsJ3uwWDb1tb
         gWvQGK81sX/Vc7tv7SydTIFl2NYRJarcw8HykU+K1F6C4JiYK1l/nKnG9TocCiz7FwwF
         JOkLGJiphggvinoAH0MyOd5mHPlMshUbYqd7175KsRGAx3BW+dmd0WY0ARd6mDZN8tlM
         kZxRII1uJ69B9AD/V7Va+0xdwEfbrtOP6mdfSxs9SCWSHY9Gax+O/o1CC0aZeYHTdMRy
         rEDKvEEwzAcSc+b2bcjBiEGcK04ppUPAPQh4vG/vnSebsk7wNxyu0ve7bPFiQrAkD42i
         MsOQ==
X-Gm-Message-State: AOAM533ogvlVk+v2YaXK6xWESYsVzTNFsYFzp9xyY6ZX6lsqGpcZam3X
        ZBmYOWG7/MUQcdU/Uvvb19zSAQ==
X-Google-Smtp-Source: ABdhPJy7o/V2R6LKxlStfu4QXa+5jJROnXJnpQK4b7rWq53Nd/m+BmNWAVs5MZ5+G2A+n7VbNzSvNQ==
X-Received: by 2002:a6b:fe0e:: with SMTP id x14mr2142887ioh.79.1624502201182;
        Wed, 23 Jun 2021 19:36:41 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 17sm140496iog.20.2021.06.23.19.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 19:36:40 -0700 (PDT)
Subject: Re: [PATCH v5 10/10] io_uring: add support for IORING_OP_MKNODAT
To:     Dmitry Kadashev <dkadashev@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, io-uring <io-uring@vger.kernel.org>
References: <20210603051836.2614535-1-dkadashev@gmail.com>
 <20210603051836.2614535-11-dkadashev@gmail.com>
 <1a3812fe-1e57-a2ad-dc19-9658c0cf613b@gmail.com>
 <CAOKbgA489C=ZS_E6YCBFxo+zYNb5ccE4dfFBntAO=qNH7_Uu=A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff18a10b-a202-71e3-8c1c-6ad4851291d8@kernel.dk>
Date:   Wed, 23 Jun 2021 20:36:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOKbgA489C=ZS_E6YCBFxo+zYNb5ccE4dfFBntAO=qNH7_Uu=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/23/21 12:26 AM, Dmitry Kadashev wrote:
> On Tue, Jun 22, 2021 at 6:52 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 6/3/21 6:18 AM, Dmitry Kadashev wrote:
>>> IORING_OP_MKNODAT behaves like mknodat(2) and takes the same flags and
>>> arguments.
>>>
>>> Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
>>> Link: https://lore.kernel.org/io-uring/20210514145259.wtl4xcsp52woi6ab@wittgenstein/
>>> Signed-off-by: Dmitry Kadashev <dkadashev@gmail.com>
>>> ---
>>>  fs/internal.h                 |  2 ++
>>>  fs/io_uring.c                 | 56 +++++++++++++++++++++++++++++++++++
>>>  fs/namei.c                    |  2 +-
>>>  include/uapi/linux/io_uring.h |  2 ++
>>>  4 files changed, 61 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/internal.h b/fs/internal.h
>>> index 15a7d210cc67..c6fb9974006f 100644
>>
>> [...]
>>
>>>  static bool io_disarm_next(struct io_kiocb *req);
>>> @@ -3687,6 +3697,44 @@ static int io_linkat(struct io_kiocb *req, int issue_flags)
>>>       io_req_complete(req, ret);
>>>       return 0;
>>>  }
>>> +static int io_mknodat_prep(struct io_kiocb *req,
>>> +                         const struct io_uring_sqe *sqe)
>>> +{
>>> +     struct io_mknod *mkn = &req->mknod;
>>> +     const char __user *fname;
>>> +
>>> +     if (unlikely(req->flags & REQ_F_FIXED_FILE))
>>> +             return -EBADF;
>>
>> IOPOLL won't support it, and the check is missing.
>> Probably for other opcodes as well.
>>
>> if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
>>         return -EINVAL;
> 
> This change is based on some other similar opcodes (unlinkat, renameat) that
> were added a while ago. Those lack the check as well. I guess I'll just prepare
> a patch that adds the checks to all of them. Thanks, Pavel.
> 
> Jens, separately it's my understanding that you do not want the MKNODAT opcode
> at all, should I drop this from the subsequent series?

Right, just drop that one for now. Would be great if you could resend
the series with the suggested fixes folded in. Might as well just do
a clean sweep.

-- 
Jens Axboe

