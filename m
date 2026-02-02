Return-Path: <linux-fsdevel+bounces-76014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEflM8QLgGkL2AIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 03:28:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37150C7DF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 03:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2792D30056EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 02:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA121D3C0;
	Mon,  2 Feb 2026 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D78dTBlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A51F91E3
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769999280; cv=none; b=pTEAGsZM4dziQ1Ln0TD4NSHQifSIQTWBZiZZte/iHCpvyxuO3TjEDEzN7UcKaXxDhFUJ2gP2XrZUM6/S253VMr6ooIa/RW2CT5SdxoAXlM4UUpjxChnAYSSPXhiABGKeUALG4e0a+G9EjPA2EAGVyyLpQnXQrSqIjNQj3DyR8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769999280; c=relaxed/simple;
	bh=c18aY+u6puIMVPmuCxKY+tqBdy/i964ilbAn+cS1m8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GF6OMbazquXc0UElKdlrzqjNII56YK+4KiTU3gIMp2rmhsckoM5nlxWo2Q1tgP0dyXaZMX2tflYCZKjtugnEjbztiQjlsO8zzb4LePjivJEJ0rZiX77i2ZvqVPgp+7K/2dKE5U/vRPi7UaudbTNIWkUzghI9gbqB6q6r9nmr6Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D78dTBlj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34abc7da414so2424262a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Feb 2026 18:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1769999277; x=1770604077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib1/7wDujkxaZJbA6XE/xuPmxkcPG0qS3D0QygAAiJo=;
        b=D78dTBljEP/laJiq2oBjhhl7MkCD4Yz418eE87w4eK4X3uvotIXTYkT75vbPqNwz58
         QXHurnvF4kzvphwnPCoMmi75HkloUKJV29Wd1sIbIW8TJwQWVG2bUhhg/Bmf31OSP1Lj
         +BmXJpqY6AW+/Ewz7MPMOPP/8cIhkwcg/kA2bUFRYRmU+bB7Kye6+JwMOdvzeZFnqfQJ
         lL5eP4cG7CR0hXpgvjAV6St53AY9FwVQA3tzOIgLziKKXswQikSieZYCGeA2fMgvq+nS
         C5olY/JKQxm2R7nS68vK9zJryKyonqeox3YBu1GBC/woCVhgDUXrn4ouPo8QX/JXquFA
         p3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769999277; x=1770604077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ib1/7wDujkxaZJbA6XE/xuPmxkcPG0qS3D0QygAAiJo=;
        b=g7mJrPmqA/YHiclYr4qdY4y+qHOcm7XRLASzgGNxJuCPWkZGkVXqOKgDqD6HDxXamd
         y43uXmY+YubC/NvGl8+QMNUSrTojVyieGbAuVHXgL5WL/9dW8c4+WkKhDOu20odDGkC/
         4du7Sxc8Z7Ie4NO+KEfPmmyv3Vi5IT53u6zjlN/zUI4tyrEIRZTgOWmmfH/ukBMREzmL
         iTdAYKrkhk78Wi+e32+v0Q7SqPpryknDubqETpVZUI1xNCf2ARK+f4K0WWolEsK+7evr
         kCb5yIbIT55Cq0OZKfwC+JWyBihgFsC4CXT02Zr8xsp68ap8K4l7y0UeZeJnKlQpwO5b
         3eFA==
X-Forwarded-Encrypted: i=1; AJvYcCWNQglbno60WbZ2dmF1ch9pYJsYdjKDVsUKURVclEeOrj2gSHlADoGRrdRHzLUUvnnzUCg0ypQmn5GFt3UA@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1aHcD+nZE8SpvkBX4N5A8AQyP6vXlQrhIMQvWVkO4q0I8j8B
	isFkoqVZp0sFT6bbYI7IJbXZsAXKhW9YMZBIPCCWmWRgY2bjuKhBY5zVIxOIrE4EfQ8=
X-Gm-Gg: AZuq6aKqXQ0DxW5iPBOouazWM8xrNCRf9qolzXyAZOGwsRXEM4kxldAc0FYz61Jna76
	yoMp858I/PgtH20OSYLkzr0b2sIYUF7TyguNgHU/MknFmGBnQ1P69nzrI3XZYDl5rtsOZvm1o7X
	rSeSMFbykiXc9Lbal0v7PkcE9A4ItA2oKwimurNucOAAHhdAXClYSkukyWnX6YKKAcbnJT51XLc
	ZLEiObl7cSx8Vn3nNj5T00iNOTkdqV5hoKuxURCjugh78lGkWzXsjXQotZxpG20Z2HapuTNBZhP
	xw4Gsx0boL5/Ga+gz00QIZoDgXx7qnXo1qO1snrxjHXAM7k40NY5bmd+7u4NC8eirQvOIR2M3Bi
	h+azyFlZnpbWO3rJIruFaucAaoXE0dwSJTQ2queG5dUP6xyE0AL8Jh7Q/c1NipLq0aXJt6Gqo8p
	5iAzqRLFRPV0zChc7NLFUE5j0rB5ZVD1g3vdI=
X-Received: by 2002:a17:90a:d886:b0:341:88c9:ca62 with SMTP id 98e67ed59e1d1-3543b3d120fmr8851545a91.31.1769999276970;
        Sun, 01 Feb 2026 18:27:56 -0800 (PST)
Received: from [10.254.198.225] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d73386asm3333466a91.14.2026.02.01.18.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 18:27:56 -0800 (PST)
Message-ID: <2538bda2-e14a-4ae0-a32d-e944ca44b37f@bytedance.com>
Date: Mon, 2 Feb 2026 10:27:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] writeback: Fix wakeup and logging timeouts for
 !DETECT_HUNG_TASK
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 Xuefeng Li <lixuefeng@loongson.cn>, linux-kernel@vger.kernel.org
References: <20260131090724.4128443-1-chenhuacai@loongson.cn>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20260131090724.4128443-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	TAGGED_FROM(0.00)[bounces-76014-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjunchao@bytedance.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email]
X-Rspamd-Queue-Id: 37150C7DF6
X-Rspamd-Action: no action

On 1/31/26 5:07 PM, Huacai Chen wrote:
> Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
> is not enabled:
> 
> INFO: The task sync:1342 has been waiting for writeback completion for more than 1 seconds.
> 
> The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
> is not enabled, then it causes the warning message even if the writeback
> lasts for only one second.
> 
> I believe the wakeup and logging is also useful for !DETECT_HUNG_TASK,
> so I don't want to disable them completely. As DEFAULT_HUNG_TASK_TIMEOUT
> is 120 seconds, so for the !DETECT_HUNG_TASK case let's use 120 seconds
> instead of sysctl_hung_task_timeout_secs.
> 
> Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing the writeback of a chunk.")
> Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   fs/fs-writeback.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 5444fc706ac7..847e46f0e019 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -198,10 +198,15 @@ static void wb_queue_work(struct bdi_writeback *wb,
>   
>   static bool wb_wait_for_completion_cb(struct wb_completion *done)
>   {
> +#ifndef CONFIG_DETECT_HUNG_TASK
> +	unsigned long hung_secs = 120;
> +#else
> +	unsigned long hung_secs = sysctl_hung_task_timeout_secs;
> +#endif
>   	unsigned long waited_secs = (jiffies - done->wait_start) / HZ;
>   
>   	done->progress_stamp = jiffies;
> -	if (waited_secs > sysctl_hung_task_timeout_secs)
> +	if (waited_secs > hung_secs)
>   		pr_info("INFO: The task %s:%d has been waiting for writeback "
>   			"completion for more than %lu seconds.",
>   			current->comm, current->pid, waited_secs);
> @@ -1947,6 +1952,11 @@ static long writeback_sb_inodes(struct super_block *sb,
>   	long write_chunk;
>   	long total_wrote = 0;  /* count both pages and inodes */
>   	unsigned long dirtied_before = jiffies;
> +#ifndef CONFIG_DETECT_HUNG_TASK
> +	unsigned long hung_secs = 120;
> +#else
> +	unsigned long hung_secs = sysctl_hung_task_timeout_secs;
> +#endif
>   
>   	if (work->for_kupdate)
>   		dirtied_before = jiffies -
> @@ -2031,8 +2041,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>   
>   		/* Report progress to inform the hung task detector of the progress. */
>   		if (work->done && work->done->progress_stamp &&
> -		   (jiffies - work->done->progress_stamp) > HZ *
> -		   sysctl_hung_task_timeout_secs / 2)
> +		   (jiffies - work->done->progress_stamp) > HZ * hung_secs / 2)
>   			wake_up_all(work->done->waitq);
>   
>   		wbc_detach_inode(&wbc);

Thanks for the patch, looks good to me.

Reviewed-by: Julian Sun <sunjunchao@bytedance.com>


-- 
Julian Sun <sunjunchao@bytedance.com>

