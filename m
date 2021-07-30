Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF543DBED1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 21:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhG3TLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhG3TLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:11:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC64C0613D5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 12:11:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ca5so16582276pjb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n8Xzq3g5EUvGu5nqxpWUkOTLx58MtbEpXoxV2GjBSeQ=;
        b=Sv7WsQpzJXuZ2SUhzG2bGjpWNnytpUZdCK8FYoFWF9yOt4mZznLl0b5TaHZC7Qu401
         ChnKZAQFWipERZDAB1wdwpm+weuk5ABCbHWmkxILOkO6uCKJuakBpGwrGsxzM1RtC4k0
         qEDUu4Tm1UonZUugjieoXPSLmFbmnayCWGU9qqr4S0OtvgXuaf2cCnFTOGNJEwAUxD2h
         Fgs/r/RrnYyywObNfkOltfO5503+Y0VfrDZbeQRFD+mwxRlPMaMkcjSdc+4lZp7Zt24f
         nmZmbYDIemJ0fA4/bqoNsQPXYKSEdsi1cEs1Mz0NdOtPsISC4V4z1wpTQbO5d/aUePbg
         xNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8Xzq3g5EUvGu5nqxpWUkOTLx58MtbEpXoxV2GjBSeQ=;
        b=m5MPrGUMCENoiXvbJ4Dy6WyMPhE2+xLfI/Ip6eUf3FH7bKmGAbxX7TKrGqJka2q6i5
         E1/0jFzFOi2kqWD5MGxd7M/5YdBSH6nI51xettjbm7bBPWTesn9qgEowdYpHe1r9uSq9
         B+AsYqeM4DNWY13dAtUEmPc64ZNEj8GXcmCvvipW0CsLkvu8XFpxrzffHbkbMKsRCrq2
         XTfBE8WJPk458LkmzIvWGpfc7wIZe/o8hlQ+pxEshGTkJxSFhNPG/VFjId6TVTsTkX++
         GtScH6sy1YGKh13TXnd6WbRJZz6d5eY8ZrrJGXnONV2/eszy+EIpSKDPsUei2/wQMPuG
         CVzQ==
X-Gm-Message-State: AOAM531PwXeXfVPbNxwPYjkGcpJ36wNg6/I9AylBTbKsXGAd1tMCMaWR
        TSMAIfVmeGedx6+T2vVrrUbdQw==
X-Google-Smtp-Source: ABdhPJyXyX6iKm7qrBPH2IumcnmmX6q4RO4ehWBMCE7OPZk8FXLocXu7ds1yO4SUF+quMbUTidipmQ==
X-Received: by 2002:a65:40cc:: with SMTP id u12mr3008779pgp.18.1627672292048;
        Fri, 30 Jul 2021 12:11:32 -0700 (PDT)
Received: from sspatil2.c.googlers.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id y64sm3625985pgy.32.2021.07.30.12.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 12:11:31 -0700 (PDT)
Subject: Re: [PATCH 1/1] fs: pipe: wakeup readers everytime new data written
 is to pipe
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20210729222635.2937453-1-sspatil@android.com>
 <20210729222635.2937453-2-sspatil@android.com>
 <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
From:   Sandeep Patil <sspatil@android.com>
Message-ID: <cee514d6-8551-8838-6d61-098d04e226ca@android.com>
Date:   Fri, 30 Jul 2021 19:11:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/29/21 11:01 PM, Linus Torvalds wrote:
> On Thu, Jul 29, 2021 at 3:27 PM Sandeep Patil <sspatil@android.com> wrote:
>>
>> So restore the old behavior to wakeup all readers if any new data is
>> written to the pipe.
> 
> Ah-hahh.
> 
> I've had this slightly smaller patch waiting for the better part of a year:
> 
>    https://lore.kernel.org/lkml/CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com/
> 
> waiting to see if some broken program actually depends on the bogus
> epollet semantics.
> 
> Can you verify that that patch fixes the realm-core brokenness too?

Yes, your patch fixes all apps on Android I can test that include this 
library.

fwiw, the library seems to have been fixed. However, I am not sure
how long it will be for all apps to take that update :(.

- ssp
