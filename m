Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD13F3AEA87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 15:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFUN4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 09:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229876AbhFUN4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624283677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6MGuavx6twbb/Q17ohA/BfaVJ/Bc9SFHn9Ch8eWwEM=;
        b=ZTgJRx9OcWTz6nl9MmvBc8RINEwDCwiFHZtQTXXiQMM6nEZt81uMuvMyG0n1RL54WA7VuN
        7xLla8vCzhvL8ckL+o9S6mG3BXPVQ9RDidgoXO0m2Ycijuq6XHv0ohbL/gKyVLe4C3btsh
        C3vHRgVYRNm8zr1Bb3G2NtvhOOTyZGA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-NFtChH5MPqCUdVQVJbqZ-Q-1; Mon, 21 Jun 2021 09:54:35 -0400
X-MC-Unique: NFtChH5MPqCUdVQVJbqZ-Q-1
Received: by mail-oi1-f198.google.com with SMTP id c193-20020aca4eca0000b02901fccdb83b9eso10726966oib.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 06:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W6MGuavx6twbb/Q17ohA/BfaVJ/Bc9SFHn9Ch8eWwEM=;
        b=bwauGuFgG2eR6aO+ngPYMGraoWmVMsSE2UZxh6LnOP+MZ0OIcW3xE3vBMlO1RWXZke
         CvKlNX9Rp5twPrOuxGSosORKw6FQlzZVRyRjHsyH4Rv5odW3yyLpUvbr/El049md9OBe
         l7nzYoqRqVjU/OG+7uJmsUNPz826PMiW3izVvZBuV3feUYPgjiY5r5r9pdK+l7hFSiE3
         z8M4UDG9AiA3+qIo4UZBca7f2Zua/lz7tB7z8Bx/tkk1tL5LrS06gvX+NNEx9RpiZu7X
         txevrdxqcXzJCVGSEIgQk8wjAq9cixVvsKj2DdlPsKFdcKlrjwqKSLM6KRcB+f8pKnLi
         GcBA==
X-Gm-Message-State: AOAM530A6phGTVYXlRqkVa1kVVLFoGVLRnkda0PltiEPgnuI1yGBwhq+
        h4xsz7rYhbjP6Gu7nVD5CvtZkeGTO21YTcLhdStvXWRfTOmfDuFBaKz14HLZCSlH2Ut92b/coDr
        btLSz+798LxWv80kTT6rhVeqdjg==
X-Received: by 2002:a9d:6484:: with SMTP id g4mr20666950otl.331.1624283675204;
        Mon, 21 Jun 2021 06:54:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9gLvrQ1EIeX4G4mLsyuw8nbCdFPUgfViIEUWkdMzDU/6Ta9UolDlhooUW7oL86dB0u0Fp9Q==
X-Received: by 2002:a9d:6484:: with SMTP id g4mr20666933otl.331.1624283675020;
        Mon, 21 Jun 2021 06:54:35 -0700 (PDT)
Received: from [192.168.0.173] (ip68-102-25-99.ks.ok.cox.net. [68.102.25.99])
        by smtp.gmail.com with ESMTPSA id f12sm1232858ooh.38.2021.06.21.06.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 06:54:34 -0700 (PDT)
Subject: Re: [PATCH] fuse: Send FUSE_WRITE_KILL_SUIDGID for killpriv v1
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210423151919.195033-1-ckuehl@redhat.com>
 <CAJfpegsXXGcZDbbtDoXG8sQqHrAS1fs-TsRz5ndQ62sse1Av_w@mail.gmail.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <74f1eff1-570d-03b1-7a27-1ec343c5c3ab@redhat.com>
Date:   Mon, 21 Jun 2021 08:54:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegsXXGcZDbbtDoXG8sQqHrAS1fs-TsRz5ndQ62sse1Av_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/21 3:26 AM, Miklos Szeredi wrote:
> On Fri, 23 Apr 2021 at 17:19, Connor Kuehl <ckuehl@redhat.com> wrote:
>>
>> FUSE doesn't seem to be adding the FUSE_WRITE_KILL_SUIDGID flag on write
>> requests for FUSE connections that support FUSE_HANDLE_KILLPRIV but not
>> FUSE_HANDLE_KILLPRIV_V2.
>>
>> However, the FUSE userspace header states:
>>
>>         FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on
>>         write/chown/trunc
>>         ^^^^^
>>
>> To improve backwards compatibility with file servers that don't support
>> FUSE_HANDLE_KILLPRIV_V2, add the FUSE_WRITE_KILL_SUIDGID flag to write
>> requests if FUSE_HANDLE_KILLPRIV has been negotiated -OR- if the
>> conditions for FUSE_HANDLE_KILLPRIV_V2 support are met.
> 
> 
> If server does not support FUSE_HANDLE_KILLPRIV_V2, then it does not
> support FUSE_WRITE_KILL_SUIDGID either.  The two were introduced
> together and the latter is only meaningful if the
> FUSE_HANDLE_KILLPRIV_V2 feature was negotiated.
> 
> What am I missing?

You're not missing anything, this patch is wrong. Let's nack this.

Thanks!

Connor

