Return-Path: <linux-fsdevel+bounces-36508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0E19E4BED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 02:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86A9285539
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 01:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5853D3EA76;
	Thu,  5 Dec 2024 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c4W3BQGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0292F56
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733363516; cv=none; b=ascTJrP109xOoPF5+d32AH5+MbpDZeqG8G9SGsz0n/hC1QxACD/1fBtudAVJM6P3VTzzkGF3YySIIM0jwluug+X1CQQEosgYVieMTIAls2FeitDeX/ynRJj6nA6bPlVLDPnJbluuQt7A8zbxhiDVUC/SxUsq7pgB7MUkf0Ebqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733363516; c=relaxed/simple;
	bh=Tjqc2uYQ1im63RBj2uXW5iNJf+66qi/dFZKiLb6thPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdxLyZZvorQjcN3uoEEiElNot1L7WG+lQHHJVWyyuLdUQrHhXEeiTW5d5FRBye2XAiLalR311Bm3pPDqqX38jkDiuDpRNhT04EH7nTRc+WtWCZRBNnm2LjdVbpoQvMsquvGBvyGi7Ih4mqH/zr/i0HV3u1k/v0gGAsT4RSkieGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c4W3BQGu; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733363511; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l7QQYWzasy95ASh1DN4RVhk0/uWr+VanzlYK/LdHj3E=;
	b=c4W3BQGunxRUNierx3gM4CILRg7wibGolC0FZLFoWGgltA3XLNW7wCTqEf8+BLjAr5fFnSJgw9uZ7X4IS2WAKzP1r1HE67wQSD3wiba5K1E+Yc0tSMn27pICC4mokAVsMtNDpuKzqGSEAGEh048fNXeNjzErer/Qata8PWnbfwQ=
Received: from 30.221.144.183(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WKrL1MI_1733363510 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 09:51:50 +0800
Message-ID: <15ff89fd-f1b1-4dc2-9837-467de7ee2ba4@linux.alibaba.com>
Date: Thu, 5 Dec 2024 09:51:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Prevent hung task warning if FUSE server gets stuck
To: etmartin4313@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc: etmartin@cisco.com
References: <20241204164316.219105-1-etmartin4313@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241204164316.219105-1-etmartin4313@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/5/24 12:43 AM, etmartin4313@gmail.com wrote:
> From: Etienne Martineau <etmartin4313@gmail.com>
> 
> If hung task checking is enabled and FUSE server stops responding for a
> long period of time, the hung task timer may fire towards the FUSE clients
> and trigger stack dumps that unnecessarily alarm the user.

Isn't that expected that users shall be notified that there's something
wrong with the FUSE service (because of either buggy implementation or
malicious purpose)?  Or is it expected that the normal latency of
handling a FUSE request is more than 30 seconds?

> 
> So, if hung task checking is enabled, we should wake up periodically to
> prevent it from triggering stack dumps. This patch uses a wake-up interval
> equal to half the hung_task_timeout_secs timer period, which keeps overhead
> low.
> 
> Without this patch, an unresponsive FUSE server can leave the FUSE clients
> in D state and produce stack dumps like below when the hung task timer
> expire.
> 
>  INFO: task cp:2780 blocked for more than 30 seconds.
>        Not tainted 6.13.0-rc1 #4
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:cat state:D stack:0 pid:2598 tgid:2598 ppid:2583 flags:0x00004006
>   ......
>   <TASK>
>   __schedule+0x443/0x16b0
>   schedule+0x2b/0x140
>   request_wait_answer+0x143/0x220
>   __fuse_simple_request+0xd8/0x2c0
>   fuse_send_open+0xc5/0x130
>   fuse_file_open+0x117/0x1a0
>   fuse_open+0x92/0x2f0
>   do_dentry_open+0x25d/0x5c0
>   vfs_open+0x2a/0x100
>   path_openat+0x2f5/0x11d0
>   do_filp_open+0xbe/0x180
>   do_sys_openat2+0xa1/0xd0
>   __x64_sys_openat+0x55/0xa0
>   x64_sys_call+0x1998/0x26f0
>   do_syscall_64+0x7c/0x170
>   ......
>   </TASK>
> 
> Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
> ---
>  fs/fuse/dev.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d..29e0c9adb799 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -21,6 +21,7 @@
>  #include <linux/swap.h>
>  #include <linux/splice.h>
>  #include <linux/sched.h>
> +#include <linux/sched/sysctl.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include "fuse_trace.h"
> @@ -422,6 +423,8 @@ static void request_wait_answer(struct fuse_req *req)
>  {
>  	struct fuse_conn *fc = req->fm->fc;
>  	struct fuse_iqueue *fiq = &fc->iq;
> +	/* Prevent hung task timer from firing at us */
> +	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
>  	int err;
>  
>  	if (!fc->no_interrupt) {
> @@ -461,7 +464,12 @@ static void request_wait_answer(struct fuse_req *req)
>  	 * Either request is already in userspace, or it was forced.
>  	 * Wait it out.
>  	 */
> -	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
> +	if (timeout)
> +		while (!wait_event_timeout(req->waitq,
> +				test_bit(FR_FINISHED, &req->flags), timeout))
> +			;
> +	else
> +		wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
>  }
>  
>  static void __fuse_request_send(struct fuse_req *req)

-- 
Thanks,
Jingbo

