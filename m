Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768C162043
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfGHOO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 10:14:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39489 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbfGHOO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:14:59 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkUPi-0001Ht-7E; Mon, 08 Jul 2019 16:14:42 +0200
Date:   Mon, 8 Jul 2019 16:14:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
cc:     corbet@lwn.net, mcgrof@kernel.org,
        Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        manfred@colorfullife.com, jwilk@jwilk.net, dvyukov@google.com,
        feng.tang@intel.com, sunilmut@microsoft.com,
        quentin.perret@arm.com, linux@leemhuis.info, alex.popov@linux.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, tedheadster@gmail.com,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH next] softirq: enable MAX_SOFTIRQ_TIME tuning with sysctl
 max_softirq_time_usecs
In-Reply-To: <c1b7a345-fa22-e52a-4db8-1f1288e7ad15@huawei.com>
Message-ID: <alpine.DEB.2.21.1907081558400.4709@nanos.tec.linutronix.de>
References: <f274f85a-bbb6-3e32-b293-1d5d7f27a98f@huawei.com> <alpine.DEB.2.21.1906231820470.32342@nanos.tec.linutronix.de> <0099726a-ead3-bdbe-4c66-c8adc9a4f11b@huawei.com> <alpine.DEB.2.21.1906241141370.32342@nanos.tec.linutronix.de>
 <c1b7a345-fa22-e52a-4db8-1f1288e7ad15@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zhiqiang,

On Tue, 25 Jun 2019, Zhiqiang Liu wrote:

> I have a doubt about _msecs_to_jiffies funcs, especially when input m is
> equal to 0.
>
> For different HZ setttings, different _msecs_to_jiffies funcs will be
> chosen for msecs_to_jiffies func. However, the performance of different
> _msecs_to_jiffies is inconsistent with input m is equal to 0.
>
> If HZ satisfies the condition: HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC %
> HZ), the return value of _msecs_to_jiffies func with m=0 is different
> with different HZ setting.

> ------------------------------------
> | HZ |	MSEC_PER_SEC / HZ | return |
> ------------------------------------
> |1000|		1	  |   0	   |
> |500 |		2	  |   1	   |
> |200 |		5	  |   1	   |
> |100 |		10	  |   1	   |
> ------------------------------------
> 
> Why only the return value of HZ=1000 is equal to 0 with m=0 ?

I don't know how you tested that, but obviously all four HZ values use
this variant:

>     #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
>     static inline unsigned long _msecs_to_jiffies(const unsigned int m)
>     {
>             return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
>     }

and for all four HZ values the result is 0. Why?

For m = 0 the calculation reduces to:

      ((MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ)

i.e.

	(x - 1) / x	where x = [1, 2, 5, 10]

which is guaranteed to be 0 for integer math. If not, you have a compiler
problem.

Thanks,

	tglx
