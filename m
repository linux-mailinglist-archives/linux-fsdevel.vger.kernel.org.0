Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FD025A2EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 04:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBCMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 22:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIBCMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:12:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C87C061244
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 19:12:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so1737407pgd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 19:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eDn4H8C3rvbkfT2QTNfX9/NNgOmpWWzhsOOAvMq08G0=;
        b=nm2odj8d9USAWrDN0g+bHXzNG/RcPcWRX7VnJYkhvFC3aw2I0bzjfDViTVS8ODRYUA
         fLd8SEAnfNgAT4J7OV5fy1vq1dFtpwcEcZrSmM8swQO2qdRMxBrqTZpsuhSmyxWgo8Ch
         pjzsQ7BIFq5DOVeNcrGoPoJqUyAYu3xeaMhaJNH/V05Pe9gh9FN1P5LXGjNTHYVJCx3a
         aNMpWu1BTNTCKTfDvKmVSpVs54K+LWOnSZWhFxLzS9bJMlzy5T8/QXtR1chxEDBpqjZE
         4sU0BicGDTKLHrJCseGnWW2FJCv9YJjkLdPgzJGfTBrLrVDnQkEx8HE4iGYoCdsdjpxr
         ++Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eDn4H8C3rvbkfT2QTNfX9/NNgOmpWWzhsOOAvMq08G0=;
        b=TLse646tNPsF4M3K9Yd0srsP/xqzSoL2ah3c7uD2fdPSvpxZafXZrdqrZYoqew5yFR
         IS6CVSJdP3Hl066Twsihw8lltEbOWJNvMswSVtK5fOZWGdP1bjOzJvAfd07zczTGno9H
         q4eNygTbf4MRfeBd3K+karMJCmxGiaAEcaDX8kMcTMEp6pAjhirDR6mhYcm7TlcJ7VH6
         DsGkCxqY3YjrNdb9PPASmfeCKYUZ8VpAdGn/HDMFDbaXOr5+rGYY25JOoGoPCeZixCCK
         O16is2A9JVzUbCpUluGxTWFcgXa1EaS9BKyyIHj1kYs8O8KbX/bGEpgbsOHORl39N2by
         qLZw==
X-Gm-Message-State: AOAM531gcFlNy29GDLfSTIWJR4Xrntho4/yNJNLuJ1lFBBsi9yvLNTgy
        G2tR/TliaX6Y86BmAffhPEIYTA==
X-Google-Smtp-Source: ABdhPJxRN5Q1ePyU37A3TlwCXtmce0zhsFRZjYXGpiehBCiXkA2V5nB0n9WaHKiS5nHgJ2MzwAb31w==
X-Received: by 2002:aa7:9584:: with SMTP id z4mr1063657pfj.271.1599012753395;
        Tue, 01 Sep 2020 19:12:33 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q2sm3552880pgs.90.2020.09.01.19.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 19:12:32 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Fix NULL pointer dereference in
 io_sq_wq_submit_work()
To:     Xin Yin <yinxin_1989@aliyun.com>, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200902015948.109580-1-yinxin_1989@aliyun.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c1ae234-0084-bddd-990f-5fd92c4e6430@kernel.dk>
Date:   Tue, 1 Sep 2020 20:12:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902015948.109580-1-yinxin_1989@aliyun.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/20 7:59 PM, Xin Yin wrote:
> the commit <1c4404efcf2c0> ("<io_uring: make sure async workqueue
> is canceled on exit>") caused a crash in io_sq_wq_submit_work().
> when io_ring-wq get a req form async_list, which not have been
> added to task_list. Then try to delete the req from task_list will caused
> a "NULL pointer dereference".
> 
> Ensure add req to async_list and task_list at the sametime.
> 
> The crash log looks like this:
> [95995.973638] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [95995.979123] pgd = c20c8964
> [95995.981803] [00000000] *pgd=1c72d831, *pte=00000000, *ppte=00000000
> [95995.988043] Internal error: Oops: 817 [#1] SMP ARM
> [95995.992814] Modules linked in: bpfilter(-)
> [95995.996898] CPU: 1 PID: 15661 Comm: kworker/u8:5 Not tainted 5.4.56 #2
> [95996.003406] Hardware name: Amlogic Meson platform
> [95996.008108] Workqueue: io_ring-wq io_sq_wq_submit_work
> [95996.013224] PC is at io_sq_wq_submit_work+0x1f4/0x5c4
> [95996.018261] LR is at walk_stackframe+0x24/0x40
> [95996.022685] pc : [<c059b898>]    lr : [<c030da7c>]    psr: 600f0093
> [95996.028936] sp : dc6f7e88  ip : dc6f7df0  fp : dc6f7ef4
> [95996.034148] r10: deff9800  r9 : dc1d1694  r8 : dda58b80
> [95996.039358] r7 : dc6f6000  r6 : dc6f7ebc  r5 : dc1d1600  r4 : deff99c0
> [95996.045871] r3 : 0000cb5d  r2 : 00000000  r1 : ef6b9b80  r0 : c059b88c
> [95996.052385] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [95996.059593] Control: 10c5387d  Table: 22be804a  DAC: 00000055
> [95996.065325] Process kworker/u8:5 (pid: 15661, stack limit = 0x78013c69)
> [95996.071923] Stack: (0xdc6f7e88 to 0xdc6f8000)
> [95996.076268] 7e80:                   dc6f7ecc dc6f7e98 00000000 c1f06c08 de9dc800 deff9a04
> [95996.084431] 7ea0: 00000000 dc6f7f7c 00000000 c1f65808 0000080c dc677a00 c1ee9bd0 dc6f7ebc
> [95996.092594] 7ec0: dc6f7ebc d085c8f6 c0445a90 dc1d1e00 e008f300 c0288400 e4ef7100 00000000
> [95996.100757] 7ee0: c20d45b0 e4ef7115 dc6f7f34 dc6f7ef8 c03725f0 c059b6b0 c0288400 c0288400
> [95996.108921] 7f00: c0288400 00000001 c0288418 e008f300 c0288400 e008f314 00000088 c0288418
> [95996.117083] 7f20: c1f03d00 dc6f6038 dc6f7f7c dc6f7f38 c0372df8 c037246c dc6f7f5c 00000000
> [95996.125245] 7f40: c1f03d00 c1f03d00 c20d3cbe c0288400 dc6f7f7c e1c43880 e4fa7980 00000000
> [95996.133409] 7f60: e008f300 c0372d9c e48bbe74 e1c4389c dc6f7fac dc6f7f80 c0379244 c0372da8
> [95996.141570] 7f80: 600f0093 e4fa7980 c0379108 00000000 00000000 00000000 00000000 00000000
> [95996.149734] 7fa0: 00000000 dc6f7fb0 c03010ac c0379114 00000000 00000000 00000000 00000000
> [95996.157897] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [95996.166060] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [95996.174217] Backtrace:
> [95996.176662] [<c059b6a4>] (io_sq_wq_submit_work) from [<c03725f0>] (process_one_work+0x190/0x4c0)
> [95996.185425]  r10:e4ef7115 r9:c20d45b0 r8:00000000 r7:e4ef7100 r6:c0288400 r5:e008f300
> [95996.193237]  r4:dc1d1e00
> [95996.195760] [<c0372460>] (process_one_work) from [<c0372df8>] (worker_thread+0x5c/0x5bc)
> [95996.203836]  r10:dc6f6038 r9:c1f03d00 r8:c0288418 r7:00000088 r6:e008f314 r5:c0288400
> [95996.211647]  r4:e008f300
> [95996.214173] [<c0372d9c>] (worker_thread) from [<c0379244>] (kthread+0x13c/0x168)
> [95996.221554]  r10:e1c4389c r9:e48bbe74 r8:c0372d9c r7:e008f300 r6:00000000 r5:e4fa7980
> [95996.229363]  r4:e1c43880
> [95996.231888] [<c0379108>] (kthread) from [<c03010ac>] (ret_from_fork+0x14/0x28)
> [95996.239088] Exception stack(0xdc6f7fb0 to 0xdc6f7ff8)
> [95996.244127] 7fa0:                                     00000000 00000000 00000000 00000000
> [95996.252291] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [95996.260453] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [95996.267054]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0379108
> [95996.274866]  r4:e4fa7980 r3:600f0093
> [95996.278430] Code: eb3a59e1 e5952098 e5951094 e5812004 (e5821000)

Thanks for catching this, I'll get it queued for stable.

-- 
Jens Axboe

