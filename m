Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D334FD07
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 19:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFWRBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jun 2019 13:01:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33811 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWRBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:01:35 -0400
X-Greylist: delayed 1355 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 13:01:34 EDT
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf5Vk-0003To-B7; Sun, 23 Jun 2019 18:38:36 +0200
Date:   Sun, 23 Jun 2019 18:38:34 +0200 (CEST)
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
In-Reply-To: <f274f85a-bbb6-3e32-b293-1d5d7f27a98f@huawei.com>
Message-ID: <alpine.DEB.2.21.1906231820470.32342@nanos.tec.linutronix.de>
References: <f274f85a-bbb6-3e32-b293-1d5d7f27a98f@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zhiqiang,

On Thu, 20 Jun 2019, Zhiqiang Liu wrote:

> From: Zhiqiang liu <liuzhiqiang26@huawei.com>
> 
> In __do_softirq func, MAX_SOFTIRQ_TIME was set to 2ms via experimentation by
> commit c10d73671 ("softirq: reduce latencies") in 2013, which was designed
> to reduce latencies for various network workloads. The key reason is that the
> maximum number of microseconds in one NAPI polling cycle in net_rx_action func
> was set to 2 jiffies, so different HZ settting will lead to different latencies.
> 
> However, commit 7acf8a1e8 ("Replace 2 jiffies with sysctl netdev_budget_usecs
> to enable softirq tuning") adopts netdev_budget_usecs to tun maximum number of
> microseconds in one NAPI polling cycle. So the latencies of net_rx_action can be
> controlled by sysadmins to copy with hardware changes over time.

So much for the theory. See below.

> Correspondingly, the MAX_SOFTIRQ_TIME should be able to be tunned by sysadmins,
> who knows best about hardware performance, for excepted tradeoff between latence
> and fairness.
> 
> Here, we add sysctl variable max_softirq_time_usecs to replace MAX_SOFTIRQ_TIME
> with 2ms default value.

...

>   */
> -#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
> +unsigned int __read_mostly max_softirq_time_usecs = 2000;
>  #define MAX_SOFTIRQ_RESTART 10
> 
>  #ifdef CONFIG_TRACE_IRQFLAGS
> @@ -248,7 +249,8 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
> 
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
> -	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> +	unsigned long end = jiffies +
> +		usecs_to_jiffies(max_softirq_time_usecs);

That's still jiffies based and therefore depends on CONFIG_HZ. Any budget
value will be rounded up to the next jiffie. So in case of HZ=100 and
time=1000us this will still result in 10ms of allowed loop time.

I'm not saying that we must use a more fine grained time source, but both
the changelog and the sysctl documentation are misleading.

If we keep it jiffies based, then microseconds do not make any sense. They
just give a false sense of controlability.

Keep also in mind that with jiffies the accuracy depends also on the
distance to the next tick when 'end' is evaluated. The next tick might be
imminent.

That's all information which needs to be in the documentation.

> +	{
> +		.procname	= "max_softirq_time_usecs",
> +		.data		= &max_softirq_time_usecs,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1		= &zero,
> +	},

Zero as the lower limit? That means it allows a single loop. Fine, but
needs to be documented as well.

Thanks,

	tglx
