Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571ED413402
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 15:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhIUN0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhIUN0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:26:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4824C061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 06:25:20 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b10so26977374ioq.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cwmswst5kJrAM2nn0VJL/xiETxBOzg10iSbgL/hoHx4=;
        b=BCW/vHyUj3DI5Wh+s6/fHAoB58Wsd8XH53tlmUwNgVW6+5m++vca7WpI59nEG8BjAA
         WtAyimp8JHXrV81uFFBiJLLkbrTAxt/+sqWNsCinWqjRN1T9DaFrvP2EvmgnVC53EdWa
         KgTSMbGZ6Ui+whXuiGSnfhYDywVzKjayv4+H0xmE378TXVdBWkK3gDvr6ar7qIVpNO6k
         VzOozL78PE10YtmcjLZeJjy9Slxgf1erkYBwVzvRB8ux0Jgett9hj81Hbnxq5DOEv/4K
         Pc3hu9UV/5WIArwFhUAYcSADUxxUB5LbQ+3lxL6ZcjKf6cXlNM9Su18jPiwtDwkS7GIi
         pAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cwmswst5kJrAM2nn0VJL/xiETxBOzg10iSbgL/hoHx4=;
        b=dHbivYXZVXuO4pmc6lXTdYdMZhNOcvfvn0fQCjUVSlUQHoPigPpmE9ARhByfzos3xR
         +Yul89h9OHWP+mIrT5Xgx+x6kMbNdFA8F7wGvaTC9wQRaeCCr5ak4X7x0R29Uzbmypj9
         3YK73Q/DabjzAchbbXVH5vw8gB/7hOAm64FOg/+R5dsIN0bKKeMtx8f2lmCy4jGeNQLX
         Y4qwu5IHOTY6nXhNjSLhGSw41M9wuHnNAUV8DApTLKm+dbFCFfTg/3RiYHMBxM+L67To
         BJ0e9CP+QTSK9CjRt29FfFnS68Eymh6PkvByXYCmvk9xr/yDfdDifdrheXncTMnVPoly
         vmtQ==
X-Gm-Message-State: AOAM532adCw4j73BQM1pqY9aGFyARfUUYl721zrFb2vMTZVKL6ftcaur
        thXgg/OgBF7zZ3Njzz2pmxz4UWomt5nTUXFK8V4=
X-Google-Smtp-Source: ABdhPJwUpjmu74tGL/pQCBaZYX+IaiZEVY3COYFdS+OU7bz1alDHtneqxHFLl0YYQuSlOHkysY/epw==
X-Received: by 2002:a05:6602:2243:: with SMTP id o3mr13598017ioo.10.1632230719881;
        Tue, 21 Sep 2021 06:25:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z4sm10098188ioj.45.2021.09.21.06.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 06:25:19 -0700 (PDT)
Subject: Re: [5.15-rc1 regression] io_uring: fsstress hangs in do_coredump()
 on exit
To:     Dave Chinner <david@fromorbit.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210921064032.GW2361455@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9d2255c-fbac-3259-243a-2934b7ed0293@kernel.dk>
Date:   Tue, 21 Sep 2021 07:25:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921064032.GW2361455@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/21 12:40 AM, Dave Chinner wrote:
> Hi Jens,
> 
> I updated all my trees from 5.14 to 5.15-rc2 this morning and
> immediately had problems running the recoveryloop fstest group on
> them. These tests have a typical pattern of "run load in the
> background, shutdown the filesystem, kill load, unmount and test
> recovery".
> 
> Whent eh load includes fsstress, and it gets killed after shutdown,
> it hangs on exit like so:
> 
> # echo w > /proc/sysrq-trigger 
> [  370.669482] sysrq: Show Blocked State
> [  370.671732] task:fsstress        state:D stack:11088 pid: 9619 ppid:  9615 flags:0x00000000
> [  370.675870] Call Trace:
> [  370.677067]  __schedule+0x310/0x9f0
> [  370.678564]  schedule+0x67/0xe0
> [  370.679545]  schedule_timeout+0x114/0x160
> [  370.682002]  __wait_for_common+0xc0/0x160
> [  370.684274]  wait_for_completion+0x24/0x30
> [  370.685471]  do_coredump+0x202/0x1150
> [  370.690270]  get_signal+0x4c2/0x900
> [  370.691305]  arch_do_signal_or_restart+0x106/0x7a0
> [  370.693888]  exit_to_user_mode_prepare+0xfb/0x1d0
> [  370.695241]  syscall_exit_to_user_mode+0x17/0x40
> [  370.696572]  do_syscall_64+0x42/0x80
> [  370.697620]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> It's 100% reproducable on one of my test machines, but only one of
> them. That one machine is running fstests on pmem, so it has
> synchronous storage. Every other test machine using normal async
> storage (nvme, iscsi, etc) and none of them are hanging.
> 
> A quick troll of the commit history between 5.14 and 5.15-rc2
> indicates a couple of potential candidates. The 5th kernel build
> (instead of ~16 for a bisect) told me that commit 15e20db2e0ce
> ("io-wq: only exit on fatal signals") is the cause of the
> regression. I've confirmed that this is the first commit where the
> problem shows up.

Thanks for the report Dave, I'll take a look. Can you elaborate on
exactly what is being run? And when killed, it's a non-fatal signal?

-- 
Jens Axboe

