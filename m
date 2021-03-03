Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2440D32B4C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354178AbhCCF1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574002AbhCBRVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:21:08 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E8C06178B
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 09:20:07 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k2so18697681ili.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Mar 2021 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sh65LRoHuVRPsDGLX3GRGcPTnOnIBRMJupzc4IzVU6I=;
        b=AfbsNmqFy3S+qFtMhETZmS844x2HF/0yBZ/jrJr1YMJAqHbgJLTsDcfogzB2kw1XOw
         AquhGcMSG+qEbPYJq5m0Tk87wcK+YdmBByortG8WCmlJrEmchr2qhGQQLSF5u6ZtdzC9
         iQu5iXWf7PjECJA2Rr2p4kbd7iJ9mxiTnpWVuiZtrPxbT+3sNxSa0ccOBVsgKD1rYgT1
         Z8i1jcVbmJZ2AVyIdHVKusmFOOzIZipI9o1PpC8aot8Pm2EdA8V4V9dHOun4Zz5lT8Zr
         jqnIZdJx70LcowSimTzN7dzI87Z1Xhfk2cpL8AM7eGqof4GEEQis7WINrOASV8lyg2EJ
         yNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sh65LRoHuVRPsDGLX3GRGcPTnOnIBRMJupzc4IzVU6I=;
        b=YMsq3YS6Xsfy6czoEyjEPAwvjoq18VPbPDGUw/qFhRPT7bZmcMtpzRQoi6h6eelTwA
         EHudRziOx/RB8F2KnirxEIkdcTHJDsu0FYjCgk3hsoPhc4ffiu9gOQRyJB7z6YcdHSqR
         JxhtekDCKQAi/RGTpppQFm5Y0g4wLjdLcfi6QYaR21L3/N8Y+4yv2wq0+FTDR67hmqI9
         LrBHCz9UL+iivLzOqtmdaD6MRse/L/jykeoT5xh6YUA/xNMHwfwV2ltiJFBeOjw8jiXc
         7seucgNM5nafnd4X1xk92dH6ECm6FwqQJKcFBZOwJx/X/LFbGcR88NMa/u8JtmfpEzv/
         cc0Q==
X-Gm-Message-State: AOAM533K3lc2vvLNZ5ZXvp9EF4oFToP1UO3yJyraSVFOwaM8PIQ4zEwO
        EO2G/dfnYgK8iVrA8g3AlJ4OJg==
X-Google-Smtp-Source: ABdhPJw+5VByLAeYJ0ZImVbSIH16qdrKcxtii9v5iNC7h4UskOQCi+I26+ogy2SG7ou1/1yMWtg9Gw==
X-Received: by 2002:a92:cd8a:: with SMTP id r10mr18146014ilb.110.1614705606961;
        Tue, 02 Mar 2021 09:20:06 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t9sm10913710iln.61.2021.03.02.09.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 09:20:06 -0800 (PST)
Subject: Re: possible deadlock in io_poll_double_wake (2)
To:     syzbot <syzbot+28abd693db9e92c160d8@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000a52fb105bc71e7b8@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <586d357d-8c4c-8875-3a1c-0599a0a64da0@kernel.dk>
Date:   Tue, 2 Mar 2021 10:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000a52fb105bc71e7b8@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/28/21 9:18 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> possible deadlock in io_poll_double_wake
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.11.0-syzkaller #0 Not tainted
> --------------------------------------------
> syz-executor.0/10241 is trying to acquire lock:
> ffff888012e09130 (&runtime->sleep){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
> ffff888012e09130 (&runtime->sleep){..-.}-{2:2}, at: io_poll_double_wake+0x25f/0x6a0 fs/io_uring.c:4921
> 
> but task is already holding lock:
> ffff888013b00130 (&runtime->sleep){..-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&runtime->sleep);
>   lock(&runtime->sleep);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation

Since the fix is in yet this keeps failing (and I didn't get it), I looked
closer at this report. While the names of the locks are the same, they are
really two different locks. So let's try this...

#syz test: git://git.kernel.dk/linux-block syzbot-test

-- 
Jens Axboe

