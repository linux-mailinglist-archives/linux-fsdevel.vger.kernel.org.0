Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2C2EEC09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 04:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbhAHDxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 22:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbhAHDxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:53:05 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D73C0612F5
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 19:52:24 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 15so6800072pgx.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 19:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HiGLLfAjEAR8On+QKrY3j3HfRNusrkUwxaBKD2WhMIY=;
        b=nhj/PEcH3hPyhteiZrCIGv25mArSLWZVLSTZIxhYkKZSbus/kbnaWPpxjE426s0GoV
         HoeSVKw1dD5JH+mG0ZTb5XgeBNe4k2yuQrXrWDhygYlmX9fODeRS4Dl8y3bFMRxgEfIC
         5VYbyjQrpCkn8wSUDNs/sfLQEmZV1xcqfcIio23kUS1PJMZ7+zOCtMO71wdIlU0lRFF4
         4U0bHPsopTWTWiGuPwRXYUEDUNLuWtQ9QRl+72cBhYg8i4opH6dj380UGOYZZWcmqV5A
         siDO/BmzDv8rEFGnsKlPfG+l7Mxrq5eHMjJV+AXtDCl2d+hWC6FKeGmjV2C1C6u/dHgw
         Wssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HiGLLfAjEAR8On+QKrY3j3HfRNusrkUwxaBKD2WhMIY=;
        b=M2qe420PH0CC02FGKEob4h1MfJvFIlBlmUu9nBP6ksQ5pb2+hNMEO73i97hob5Bjt9
         vXYfRj+Bvp+p7Nip8OEMsyzNkWlmiXCmTqGN/erMFDc6FIaZMJQI/4BX7WiL8AHkxDLR
         vJkW/xpE6SlRSEY/q6/iIj36959Id2RflYwXEA0cYCrnUT8/CaTIaBf0sgb0Y9kavdTN
         WqtEmUpQszWiL6ihX9MR6Qfa49JGrVkjqIZ3kmyaGSnZeQHU2LbDwxPxNo9yFsWf3HvD
         fioTLArMyEK2ywnc7B4+SBwDmOKpnyqWCoJ4XvWHBetA/KvhTbu5Dcu7g0AOSTlLLrsu
         S19Q==
X-Gm-Message-State: AOAM530jKAEnZcSeR0FLVf9BvcN7wqskFy7cQUTfkkwKnOzLV8EQJFTY
        Zf+nTqhyGvxCsm5pXNFHSFYqMQ==
X-Google-Smtp-Source: ABdhPJykzR/yNkFwQof7rEfk4PolELnvPOEL9jCEBYC2w5Vd/AKL2rEYYJapcEWygpxrhJCVX0tm+A==
X-Received: by 2002:a63:174f:: with SMTP id 15mr5064327pgx.49.1610077944403;
        Thu, 07 Jan 2021 19:52:24 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b10sm7796209pgh.15.2021.01.07.19.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 19:52:23 -0800 (PST)
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
 <CAD=FV=WJzNEf+=H2_Eyz3HRnv+0hW5swikg=hFMkHxGb569Bpw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6fdffaf6-2a40-da4f-217d-157f163111cb@kernel.dk>
Date:   Thu, 7 Jan 2021 20:52:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WJzNEf+=H2_Eyz3HRnv+0hW5swikg=hFMkHxGb569Bpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/7/21 3:17 PM, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jan 5, 2021 at 10:30 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Song reported a boot regression in a kvm image with 5.11-rc, and bisected
>> it down to the below patch. Debugging this issue, turns out that the boot
>> stalled when a task is waiting on a pipe being released. As we no longer
>> run task_work from get_signal() unless it's queued with TWA_SIGNAL, the
>> task goes idle without running the task_work. This prevents ->release()
>> from being called on the pipe, which another boot task is waiting on.
>>
>> Use TWA_SIGNAL for the file fput work to ensure it's run before the task
>> goes idle.
>>
>> Fixes: 98b89b649fce ("signal: kill JOBCTL_TASK_WORK")
>> Reported-by: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> I just spend a bit of time bisecting and landed on commit 98b89b649fce
> ("signal: kill JOBCTL_TASK_WORK") causing my failure to bootup
> mainline.  Your patch fixes my problem.  I haven't done any analysis
> of the code--just testing, thus:
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>

Thanks, adding your Tested-by.

-- 
Jens Axboe

