Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D367B2DA6B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 04:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgLODTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 22:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgLODTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:19:00 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9585C06179C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 19:18:20 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id r4so10195152pls.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 19:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x0F4e7e8J+VvKx26V8nuLlBsAEt7nzUZe1QX+0WOrZI=;
        b=MqehWWdECBfcy09hKHbVwBWV3Wg8cAoFYJzpCQkTfIfUaVG5dG8h/UMRJfToYrRuPb
         w1e1VfIscbIr+nSDeUJJCIKQhiFGPi24shyg10hdKusCE/Y3b+4GpjIuiYInowiCFThq
         g7uuGHAu/Re3fmXw7mdFFKg5dk+KA5PkdpNB7drpJcCCexbI/col4A6/i0OoNzK3Qbe6
         7/vC8Ws0H1JDbLO460Bb0KkmuXrxYgvHWbsc/6p1ca86g6+/vIQAgz280Vb+WAizulY7
         ydM3+xIiri12FgfoM0QTaF2fVN4opYZhQOLmjVKkjthfPes7N/5utXUrZM2sEg0zisTu
         BENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x0F4e7e8J+VvKx26V8nuLlBsAEt7nzUZe1QX+0WOrZI=;
        b=JzIeT/pAZCsFY8T40ou61CWQmgoPAT//3LNIUMrnfBJB1cay872NyFi3FCX38RHinY
         E2y/vofmBWF33IeMN4ylYg4/ikfbVZ9Y/TSD22fajRpOdZPhzWzwy0EPd34LsvxHMWio
         HJ2nD4LCC9UGsEcaOoPcGVu4vOI+JJWpSJCb3lEdNckZvmbR0miIpW26Vd7LMLcQKk4Y
         euKOEJkCgJbngNfxMQ45JQ4p1r8RfkZcdFNqv8Ba6B86LI8cKyQJChtr3xz763nAei2+
         3o9q6rBkFOTzmfYfVnWU10A0Q7oAnL96TIUr87SXpTgi+jSD6XgH9YOjq/qZpPAtlXhL
         u1bg==
X-Gm-Message-State: AOAM532o/ZnuxFCu86B52EOB2c3o3PsBDT35AiYeXHSG+CDxpGAAup2M
        Fg4lq0N8Q+4gYNvdl0HNkA9nHQ==
X-Google-Smtp-Source: ABdhPJyLAnVndemEaMwEL9ZPFp/FJzydb6o6UC59mdfPy13MPNnUS984np59pd8NYPwHr7iVBIOk7w==
X-Received: by 2002:a17:90a:970b:: with SMTP id x11mr28106576pjo.16.1608002300280;
        Mon, 14 Dec 2020 19:18:20 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a141sm21678462pfa.189.2020.12.14.19.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 19:18:19 -0800 (PST)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <CAHk-=wh7-H541jDYiFYkJvmVKdbyUH9+zVKf+=y-SnMFEFEkZA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ac6a45f-26b2-ef4a-8941-f3bffcf03900@kernel.dk>
Date:   Mon, 14 Dec 2020 20:18:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh7-H541jDYiFYkJvmVKdbyUH9+zVKf+=y-SnMFEFEkZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/14/20 8:06 PM, Linus Torvalds wrote:
> On Mon, Dec 14, 2020 at 11:13 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I'm pretty happy with this at this point. The core change is very simple,
>> and the users end up being trivial too.
> 
> It does look very simple.

Agree, hard to imagine it being much simpler than this.

> It strikes me that io_statx would be another user of this. But it
> obviously depends on what the actual io_uring users do..

Indeed, I did mention that in my email from the other thread earlier
today, and I think it's potentially an even bigger deal than nonblock
open. Lots of workloads are very stat intensive. So I did do that:

https://git.kernel.dk/cgit/linux-block/log/?h=nonblock-path-lookup

it's the top three patches there. Basically all local file systems are
fine with AT_STATX_LOOKUP just basically mapping to LOOKUP_NONBLOCK,
various (mostly) networked file systems like to do revalidation and
other kinds of communication as part of getattr. Hence the second patch
there is needed to have some:

if (query_flags & AT_STATX_NONBLOCK)
	return -EAGAIN;

constructs in there to avoid it in the nonblock path. Outside of that,
it's very trivial and just works. I didn't include it in this posting to
avoid detracting from the core work, but I definitely think we should be
doing that as well.

-- 
Jens Axboe

