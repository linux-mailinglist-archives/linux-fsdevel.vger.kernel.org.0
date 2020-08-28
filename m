Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7375F2556F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 10:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgH1I4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 04:56:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgH1I4i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:56:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A09BB649;
        Fri, 28 Aug 2020 08:57:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD8021E12C0; Fri, 28 Aug 2020 10:56:34 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:56:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     viro@zeniv.linux.org.uk, bcrl@kvack.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: make aio wait path to account iowait time
Message-ID: <20200828085634.GC7072@quack2.suse.cz>
References: <20200828060712.34983-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200828060712.34983-1-tian.xianting@h3c.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 28-08-20 14:07:12, Xianting Tian wrote:
> As the normal aio wait path(read_events() ->
> wait_event_interruptible_hrtimeout()) doesn't account iowait time, so use
> this patch to make it to account iowait time, which can truely reflect
> the system io situation when using a tool like 'top'.
> 
> The test result as below.
> 
> Test environment：
> 	Architecture:          x86_64
> 	CPU op-mode(s):        32-bit, 64-bit
> 	Byte Order:            Little Endian
> 	CPU(s):                32
> 	On-line CPU(s) list:   0-31
> 	Thread(s) per core:    2
> 	Core(s) per socket:    8
> 	Socket(s):             2
> 	NUMA node(s):          2
> 	Vendor ID:             GenuineIntel
> 	CPU family:            6
> 	Model:                 85
> 	Model name:            Intel(R) Xeon(R) Silver 4108 CPU @ 1.80GHz
> 	Stepping:              4
> 	CPU MHz:               801.660
> 
> AIO test command:
> 	fio -ioengine=libaio -bs=8k -direct=1 -numjobs 32 -rw=read -size=10G
>           -filename=/dev/sda3 -name="Max throughput" -iodepth=128 -runtime=60
> 
> Before test, set nr_requests to 512(default is 256), aim to to make the backend
> device busy to handle io request, and make io_getevents() have more chances to
> wait for io completion:
> 	echo 512 >  /sys/block/sda/queue/nr_requests
> 
> Fio test result with the AIO iowait time accounting patch showed as below,
> almost all fio threads are in 'D' state to waiting for io completion, and the
> iowait time is accounted as 48.0%:
> 	top - 19:19:23 up 29 min,  2 users,  load average: 14.60, 9.45, 9.45
> 	Tasks: 456 total,   4 running, 247 sleeping,   0 stopped,   0 zombie
> 	%Cpu(s):  0.4 us,  1.0 sy,  0.0 ni, 50.6 id, 48.0 wa,  0.0 hi,  0.0 si,  0.0 st
> 	KiB Mem : 19668915+total, 19515264+free,   866476 used,   670028 buff/cache
> 	KiB Swap:  4194300 total,  4194300 free,        0 used. 19449948+avail Mem
> 
> 	  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
> 	16135 root      20   0  294092  63724  63060 S   1.7  0.0   0:03.31 fio
> 	16173 root      20   0  272352   3540   1792 D   1.7  0.0   0:03.85 fio
> 	16175 root      20   0  272360   3544   1796 D   1.7  0.0   0:03.85 fio
> 	16185 root      20   0  272400   3556   1808 D   1.7  0.0   0:03.84 fio
> 	16187 root      20   0  272408   3552   1804 D   1.7  0.0   0:03.82 fio
> 	16190 root      20   0  272420   3500   1804 R   1.7  0.0   0:03.88 fio
> 	16169 root      20   0  272336   3444   1740 D   1.3  0.0   0:03.75 fio
> 	16170 root      20   0  272340   3504   1804 R   1.3  0.0   0:03.80 fio
> 	16172 root      20   0  272348   3500   1800 D   1.3  0.0   0:03.86 fio
> 	16174 root      20   0  272356   3544   1796 D   1.3  0.0   0:03.77 fio
> 	16179 root      20   0  272376   3528   1780 D   1.3  0.0   0:03.79 fio
> 	16180 root      20   0  272380   3500   1800 D   1.3  0.0   0:03.85 fio
> 	16181 root      20   0  272384   3552   1804 D   1.3  0.0   0:03.87 fio
> 	16182 root      20   0  272388   3520   1772 D   1.3  0.0   0:03.80 fio
> 	16183 root      20   0  272392   3552   1804 D   1.3  0.0   0:03.77 fio
> 	16186 root      20   0  272404   3500   1804 D   1.3  0.0   0:03.88 fio
> 	16188 root      20   0  272412   3500   1800 D   1.3  0.0   0:03.89 fio
> 	16191 root      20   0  272424   3500   1800 D   1.3  0.0   0:03.92 fio
> 	16192 root      20   0  272428   3500   1800 D   1.3  0.0   0:03.87 fio
> 	16194 root      20   0  272436   3500   1804 D   1.3  0.0   0:03.82 fio
> 	16195 root      20   0  272440   3500   1800 R   1.3  0.0   0:03.82 fio
> 	16196 root      20   0  272444   3552   1804 D   1.3  0.0   0:03.84 fio
> 	16198 root      20   0  272452   3500   1804 D   1.3  0.0   0:03.89 fio
> 	16199 root      20   0  272456   3504   1800 D   1.3  0.0   0:03.84 fio
> 	16200 root      20   0  272460   3552   1804 D   1.3  0.0   0:03.85 fio
> 	16171 root      20   0  272344   3504   1800 D   1.0  0.0   0:03.84 fio
> 	16176 root      20   0  272364   3520   1772 D   1.0  0.0   0:03.76 fio
> 	16177 root      20   0  272368   3556   1808 D   1.0  0.0   0:03.74 fio
> 	16178 root      20   0  272372   3500   1804 D   1.0  0.0   0:03.90 fio
> 	16184 root      20   0  272396   3500   1800 D   1.0  0.0   0:03.83 fio
> 	16189 root      20   0  272416   3500   1804 D   1.0  0.0   0:03.86 fio
> 	16193 root      20   0  272432   3500   1804 D   1.0  0.0   0:03.85 fio
> 	16197 root      20   0  272448   3556   1808 D   1.0  0.0   0:03.75 fio
> 
> Fio test result without the AIO iowait time accounting patch showed as below,
> almost all fio threads are in 'S' state to waiting for io completion, and the
> iowait time is not accounted, iowait is 0.0%.
> 	top - 19:20:44 up 31 min,  2 users,  load average: 12.50, 10.15, 9.72
> 	Tasks: 458 total,   2 running, 249 sleeping,   0 stopped,   0 zombie
> 	%Cpu(s):  0.4 us,  0.9 sy,  0.0 ni, 98.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> 	KiB Mem : 19668915+total, 19513945+free,   879652 used,   670040 buff/cache
> 	KiB Swap:  4194300 total,  4194300 free,        0 used. 19448636+avail Mem
> 
> 	  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
> 	16243 root      20   0  294092  63736  63068 S   1.7  0.0   0:03.06 fio
> 	16277 root      20   0  272336   3568   1868 S   1.7  0.0   0:03.59 fio
> 	16287 root      20   0  272376   3564   1864 S   1.7  0.0   0:03.64 fio
> 	16291 root      20   0  272392   3620   1868 S   1.7  0.0   0:03.63 fio
> 	16298 root      20   0  272420   3564   1868 S   1.7  0.0   0:03.61 fio
> 	16302 root      20   0  272436   3560   1868 S   1.7  0.0   0:03.61 fio
> 	16303 root      20   0  272440   3552   1800 S   1.7  0.0   0:03.62 fio
> 	16308 root      20   0  272460   3568   1864 S   1.7  0.0   0:03.60 fio
> 	16278 root      20   0  272340   3568   1868 S   1.3  0.0   0:03.59 fio
> 	16279 root      20   0  272344   3508   1800 S   1.3  0.0   0:03.60 fio
> 	16280 root      20   0  272348   3564   1864 S   1.3  0.0   0:03.60 fio
> 	16281 root      20   0  272352   3624   1872 S   1.3  0.0   0:03.57 fio
> 	16283 root      20   0  272360   3612   1860 S   1.3  0.0   0:03.60 fio
> 	16285 root      20   0  272368   3592   1840 S   1.3  0.0   0:03.62 fio
> 	16286 root      20   0  272372   3580   1828 S   1.3  0.0   0:03.61 fio
> 	16288 root      20   0  272380   3620   1868 S   1.3  0.0   0:03.55 fio
> 	16289 root      20   0  272384   3564   1868 S   1.3  0.0   0:03.59 fio
> 	16292 root      20   0  272396   3536   1836 S   1.3  0.0   0:03.62 fio
> 	16293 root      20   0  272400   3624   1872 S   1.3  0.0   0:03.63 fio
> 	16295 root      20   0  272408   3620   1868 S   1.3  0.0   0:03.61 fio
> 	16297 root      20   0  272416   3568   1868 S   1.3  0.0   0:03.62 fio
> 	16300 root      20   0  272428   3564   1864 R   1.3  0.0   0:03.61 fio
> 	16304 root      20   0  272444   3564   1864 S   1.3  0.0   0:03.59 fio
> 	16305 root      20   0  272448   3456   1760 S   1.3  0.0   0:03.65 fio
> 	16307 root      20   0  272456   3568   1864 S   1.3  0.0   0:03.64 fio
> 	16282 root      20   0  272356   3556   1860 S   1.0  0.0   0:03.55 fio
> 	16284 root      20   0  272364   3612   1860 S   1.0  0.0   0:03.57 fio
> 	16290 root      20   0  272388   3616   1864 S   1.0  0.0   0:03.54 fio
> 	16294 root      20   0  272404   3624   1872 S   1.0  0.0   0:03.60 fio
> 	16296 root      20   0  272412   3564   1864 S   1.0  0.0   0:03.60 fio
> 	16299 root      20   0  272424   3540   1840 S   1.0  0.0   0:03.62 fio
> 	16301 root      20   0  272432   3568   1868 S   1.0  0.0   0:03.63 fio
> 	16306 root      20   0  272452   3624   1872 S   1.0  0.0   0:03.60 fio
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>

Nice! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c             |  2 +-
>  include/linux/wait.h | 26 ++++++++++++++++++++++----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 5736bff48..8d00548e0 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1290,7 +1290,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
>  	if (until == 0)
>  		aio_read_events(ctx, min_nr, nr, event, &ret);
>  	else
> -		wait_event_interruptible_hrtimeout(ctx->wait,
> +		io_wait_event_hrtimeout(ctx->wait,
>  				aio_read_events(ctx, min_nr, nr, event, &ret),
>  				until);
>  	return ret;
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 898c890fc..fb5902a25 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -312,6 +312,13 @@ do {										\
>  	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
>  			    io_schedule())
>  
> +#define __io_wait_event_hrtimeout(wq_head, condition, timeout)			\
> +({										\
> +	int __ret = 0;								\
> +	__ret = __wait_event_hrtimeout(wq_head, condition, timeout,		\
> +			    TASK_UNINTERRUPTIBLE, io_schedule());		\
> +})
> +
>  /*
>   * io_wait_event() -- like wait_event() but with io_schedule()
>   */
> @@ -323,6 +330,15 @@ do {										\
>  	__io_wait_event(wq_head, condition);					\
>  } while (0)
>  
> +
> +#define io_wait_event_hrtimeout(wq_head, condition, timeout)			\
> +do {										\
> +	might_sleep();								\
> +	if (condition)								\
> +		break;								\
> +	__io_wait_event_hrtimeout(wq_head, condition, timeout);			\
> +} while (0)
> +
>  #define __wait_event_freezable(wq_head, condition)				\
>  	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,		\
>  			    freezable_schedule())
> @@ -500,7 +516,7 @@ do {										\
>  	__ret;									\
>  })
>  
> -#define __wait_event_hrtimeout(wq_head, condition, timeout, state)		\
> +#define __wait_event_hrtimeout(wq_head, condition, timeout, state, cmd) 	\
>  ({										\
>  	int __ret = 0;								\
>  	struct hrtimer_sleeper __t;						\
> @@ -517,7 +533,7 @@ do {										\
>  			__ret = -ETIME;						\
>  			break;							\
>  		}								\
> -		schedule());							\
> +		cmd);								\
>  										\
>  	hrtimer_cancel(&__t.timer);						\
>  	destroy_hrtimer_on_stack(&__t.timer);					\
> @@ -546,7 +562,8 @@ do {										\
>  	might_sleep();								\
>  	if (!(condition))							\
>  		__ret = __wait_event_hrtimeout(wq_head, condition, timeout,	\
> -					       TASK_UNINTERRUPTIBLE);		\
> +					       TASK_UNINTERRUPTIBLE,		\
> +					       schedule());			\
>  	__ret;									\
>  })
>  
> @@ -572,7 +589,8 @@ do {										\
>  	might_sleep();								\
>  	if (!(condition))							\
>  		__ret = __wait_event_hrtimeout(wq, condition, timeout,		\
> -					       TASK_INTERRUPTIBLE);		\
> +					       TASK_INTERRUPTIBLE,		\
> +						schedule());			\
>  	__ret;									\
>  })
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
