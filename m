Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4B5ED301
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 12:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfKCLEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 06:04:30 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:43248 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbfKCLEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 06:04:30 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 509B82E0DF6;
        Sun,  3 Nov 2019 14:04:25 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id f9gFDOcFPJ-4N0eZTBT;
        Sun, 03 Nov 2019 14:04:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572779065; bh=2i2bVk2+UygXToc0zDVE6qE+jkcPQQ3hzQ1MvPverB8=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=i4LML2QZoCkt8DIBPABI/dlrD58SLUjwEJijFK24r3LACkqTtKfBH7LZY2SaVNkkg
         6PdYzDsGPJpni/KP5cBLP4/vRMV1zjuX51ouEUYdb4eKtKYgqLB70kwuTBT9nI20xV
         aeGDNl/dMuYAoTdqw4RHwH0fYznFD2xRyXdU/91Q=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7101::1:7])
        by myt5-6212ef07a9ec.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id fO5Ga8HQmK-4NVKRUIb;
        Sun, 03 Nov 2019 14:04:23 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [RFC PATCH 07/10] pipe: Conditionalise wakeup in pipe_read() [ver
 #2]
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <fe167a90-1503-7ca2-4150-eeffd5cb1378@yandex-team.ru>
 <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186189069.3995.10292601951655075484.stgit@warthog.procyon.org.uk>
 <3165.1572539884@warthog.procyon.org.uk>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <f8810057-d92a-bcd2-c703-0a947336ce8d@yandex-team.ru>
Date:   Sun, 3 Nov 2019 14:04:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3165.1572539884@warthog.procyon.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31/10/2019 19.38, David Howells wrote:
> Okay, attached is a change that might give you what you want.  I tried my
> pipe-bench program (see cover note) with perf.  The output of the program with
> the patch applied was:
> 
> -       pipe                  305127298     36262221772       302185181         7887690
> 
> The output of perf with the patch applied:
> 
>          239,943.92 msec task-clock                #    1.997 CPUs utilized
>              17,728      context-switches          #   73.884 M/sec
>                 124      cpu-migrations            #    0.517 M/sec
>               9,330      page-faults               #   38.884 M/sec
>     885,107,207,365      cycles                    # 3688822.793 GHz
>   1,386,873,499,490      instructions              #    1.57  insn per cycle
>     311,037,372,339      branches                  # 1296296921.931 M/sec
>          33,467,827      branch-misses             #    0.01% of all branches
> 
> And without:
> 
>          239,891.87 msec task-clock                #    1.997 CPUs utilized
>              22,187      context-switches          #   92.488 M/sec
>                 133      cpu-migrations            #    0.554 M/sec
>               9,334      page-faults               #   38.909 M/sec
>     884,906,976,128      cycles                    # 3688787.725 GHz
>   1,391,986,932,265      instructions              #    1.57  insn per cycle
>     311,394,686,857      branches                  # 1298067400.849 M/sec
>          30,242,823      branch-misses             #    0.01% of all branches
> 
> So it did make something like a 20% reduction in context switches.

Ok. Looks promising. Depending on workload reduction might be much bigger.

I suppose buffer resize (grow) makes wakeup unconditionally. Should be ok.

> 
> David
> ---
> diff --git a/fs/pipe.c b/fs/pipe.c
> index e3d5f7a39123..5167921edd73 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -276,7 +276,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   	size_t total_len = iov_iter_count(to);
>   	struct file *filp = iocb->ki_filp;
>   	struct pipe_inode_info *pipe = filp->private_data;
> -	int do_wakeup;
> +	int do_wakeup, wake;
>   	ssize_t ret;
> 
>   	/* Null read succeeds. */
> @@ -329,11 +329,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   				tail++;
>   				pipe->tail = tail;
>   				do_wakeup = 1;
> -				if (head - (tail - 1) == pipe->max_usage)
> +				wake = head - (tail - 1) == pipe->max_usage / 2;
> +				if (wake)
>   					wake_up_interruptible_sync_poll_locked(
>   						&pipe->wait, EPOLLOUT | EPOLLWRNORM);
>   				spin_unlock_irq(&pipe->wait.lock);
> -				if (head - (tail - 1) == pipe->max_usage)
> +				if (wake)
>   					kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>   			}
>   			total_len -= chars;
> 
