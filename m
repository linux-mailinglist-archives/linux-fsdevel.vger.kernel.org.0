Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D007B1C0D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 06:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEAEV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 00:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726153AbgEAEV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 00:21:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B37C035494
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 21:21:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l25so1735049pgc.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 21:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZHNPXY+VTbm7N7GaannHtaXZdAjYtMYWNGs5o8TEew=;
        b=YzmzeI6xz5S+smmboDtAuuvUdQGBRsBntKMDP2fjMBAyeQEgbx6QUBVkqqD5Uz5Boy
         RLy79t1R3hKfhMGM3Nh/EnJD+nCy+AfcU54C0N0CECOfZRA7OxYd/9TL+2yrJ9Kd6HTT
         8TrI1w9lbJnzYn8cJbFiVvnlDexCuCw9BMfDrC76omtIY06KSjHcQ0+KHiXXVW9kL632
         /9dkDiaDIn4FK5Vfth+oMEiFoHRyKIgdjQIPyGov8o+kJbQIeB2ugFDPZRfgFlU41Ru/
         znFIDOetIAX8aPOOFpSH0JVle5mOO7fMQVGtW1FuPYHyfI8YjYZVu5nT/TWsV4UcB57F
         jGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZHNPXY+VTbm7N7GaannHtaXZdAjYtMYWNGs5o8TEew=;
        b=qgGpIKh8aE5AQJ5vZBUBwFLIAnTKW4iRRht3L3vd96n0A4Ndu3bzC3SaDTJzotdM+i
         3ZZRFwHUfW5CyQnBrv/sxNkZ73P/B6xElGUH+ydusWe7P78h8nGq/uJkIFqzOxs2E2ld
         ZosNXTJbbeZqINMASiu9Pu0l9OEta3sHYUPDUGmz8UYaEX7r0f0kXAqPXdgKKQ5tQY0w
         V3+C/TQAOmjRpekNGxORWC/yDMfAqos5MkNzLkQGzuNvquWo+Z0sBDqKkBJqwj/ulTLv
         Sc3bNfFVvDhVvR0P/MXCikJyxMawOHceyB2HnG2KRCm1z8ZoHiu5BqlW7qG7Bf+DsmV9
         kuoQ==
X-Gm-Message-State: AGi0PuakeMwW4yVV+OPhvz7fZ/hUQIrz5U8xFzbUo0pX0/RlGd6O9Kcu
        dSwd8jJ62cXeTJKvmeSLj1RKL3jx3jQsgg==
X-Google-Smtp-Source: APiQypI/M9SF/2cancLSbCaQVwKb5vIVsonHN4uSzVZ3JfjAjy2t2l4/9I7INa5SyIMPmK2feGga0A==
X-Received: by 2002:aa7:843a:: with SMTP id q26mr2180988pfn.240.1588306913353;
        Thu, 30 Apr 2020 21:21:53 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id dw12sm984795pjb.31.2020.04.30.21.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 21:21:52 -0700 (PDT)
Subject: Re: [PATCH] pipe: read/write_iter() handler should check for
 IOCB_NOWAIT
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
 <20200501035820.GH23230@ZenIV.linux.org.uk>
 <210c6b72-179a-993f-1ec8-1960db107174@kernel.dk>
Message-ID: <269ef3a5-e30f-ceeb-5f5e-58563e7c5367@kernel.dk>
Date:   Thu, 30 Apr 2020 22:21:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <210c6b72-179a-993f-1ec8-1960db107174@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/20 10:14 PM, Jens Axboe wrote:
> On 4/30/20 9:58 PM, Al Viro wrote:
>> On Thu, Apr 30, 2020 at 10:24:46AM -0600, Jens Axboe wrote:
>>> Pipe read/write only checks for the file O_NONBLOCK flag, but we should
>>> also check for IOCB_NOWAIT for whether or not we should handle this read
>>> or write in a non-blocking fashion. If we don't, then we will block on
>>> data or space for iocbs that explicitly asked for non-blocking
>>> operation. This messes up callers that explicitly ask for non-blocking
>>> operations.
>>
>> Why does io_uring allow setting IOCB_NOWAIT without FMODE_NOWAIT, anyway?
> 
> To do per-io non-blocking operations. It's not practical or convenient
> to flip the file flag, nor does it work if you have multiple of them
> going. If pipes honor the flag for the read/write iter handlers, then
> we can handle them a lot more efficiently instead of requiring async
> offload.

Sorry, I think I misread you and the answer, while correct by itself, is
not the answer to the question you are asking. You're saying we should
not be using IOCB_NOWAIT if FMODE_NOWAIT isn't set, which is fair. I'll
re-do the patch, we can probably just use FMODE_NOWAIT for the final
check in io_uring instead.

For pipes, we should include the setting of FMODE_NOWAIT for fifo_open()
with the patch, at least.

-- 
Jens Axboe

