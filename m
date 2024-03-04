Return-Path: <linux-fsdevel+bounces-13490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F168706B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE5D28D728
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40C4AEE1;
	Mon,  4 Mar 2024 16:15:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE01B965;
	Mon,  4 Mar 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568919; cv=none; b=JKfsJ2O2TZICimeKKTqoiqbX6k99mu0qjaC34fLid5VLHcDINfi+tMgo8jJwEYA4H3Oo8Y4QRlJwNB43Ws/0QKW67LtuMzwgjY2bfcbjZf8EC1BKrpC+CfKt2TLY2gVGrkOyVtiaGUqLts2c5RjtbsBImjDHNpZh8rMZ7EtCJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568919; c=relaxed/simple;
	bh=lha7KPbSrCOKkcUXND+FfsUumgNLDtPvNXPKPJzIJJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCy8N7SVuOfYh3DnCuv00po6I/viekG+g4l5Oeo++p9sE1NGbVT9W+bptAv8O8+g6lQKuCNr1bpClhgPxlc+uaJMIU38PHijLEVnde4Inigo9DocaKH/v0So87LmtU6abe5RussjCkuSLZBPaZ+Rut3fQpP2cRM/d0yuThbOaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dcd6a3da83so34025275ad.3;
        Mon, 04 Mar 2024 08:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568917; x=1710173717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0N1++WhM1AIkN34cqrS05xzIfET7Y9SKgJHP1ehG6E=;
        b=xPcLvldICzINteYzru+LW6QjYZI4y4ZYMNESvdQnLGMpGEkYA3VCuKnlFVVVy21evT
         f4iaAbk9MK1r26hlC63zr+EbowIptL6WKWnl5pbd2YaIXX3XTRumg3Qi/jebGVphLxtO
         wN5Zw82aBfRFmAMgNGjfjyugIcCqPkxMYcfMwX6PWnCVvBVLMc1DKEkRi9QvfkTtR9w1
         JGSLzdsGq/BtaVCOPufKGBUKlcfB0hUj+A1fSKcXow+h5vXNGnljK2LVyrn4NEfCt0+s
         8SFDItOZS5fSHART9BTJabZnxPqGAHBWGMs+E+6rq2jE+tHKldciifdkSAWOTTqF1/C+
         b+QA==
X-Forwarded-Encrypted: i=1; AJvYcCU9QgXs9Pt+pFZkWXZz5H2BtvReD7vBS63iBwztlvcFsqWcfbKNDA1qH2tgXnHBVhK4eKDBwo7htdEnqQYUoD/wqXw9awDy9Rb5J9Gg2+LEhQNPWzjZflP5rTc6AV0CzbuCMz6lnA7GU6MIkA==
X-Gm-Message-State: AOJu0YzbpNvgkeBg792eF+X7wVf4zQpRx2Y7R2YUk3j8yYagqXCBHjMP
	SpX5BPI39RzsX6JFuz5LYP/ZrLm1Pp5riekcdtRMNPwcqq64Q+HwnRA1R4B2++U=
X-Google-Smtp-Source: AGHT+IETMOb6FGFJ8mb+IprXZiOHnQTqINACq4gWjd2Lh/nCZBc4uNfO0MiNpe+Lh9iSPnGeWVEqJw==
X-Received: by 2002:a17:902:dacc:b0:1dc:b2ee:c7 with SMTP id q12-20020a170902dacc00b001dcb2ee00c7mr13916249plx.14.1709568917289;
        Mon, 04 Mar 2024 08:15:17 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b001db82fdc89asm8766821plc.305.2024.03.04.08.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:15:16 -0800 (PST)
Message-ID: <14f85d0c-8303-4710-b8b1-248ce27a6e1f@acm.org>
Date: Mon, 4 Mar 2024 08:15:15 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/aio: fix uaf in sys_io_cancel
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Cc: bcrl@kvack.org, brauner@kernel.org, jack@suse.cz, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <0000000000006945730612bc9173@google.com>
 <tencent_DC4C9767C786D2D2FDC64F099FAEFDEEC106@qq.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <tencent_DC4C9767C786D2D2FDC64F099FAEFDEEC106@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/24 04:21, Edward Adam Davis wrote:
> The aio poll work aio_poll_complete_work() need to be synchronized with syscall
> io_cancel(). Otherwise, when poll work executes first, syscall may access the
> released aio_kiocb object.
> 
> Fixes: 54cbc058d86b ("fs/aio: Make io_cancel() generate completions again")
> Reported-and-tested-by: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/aio.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 28223f511931..0fed22ed9eb8 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1762,9 +1762,8 @@ static void aio_poll_complete_work(struct work_struct *work)
>   	} /* else, POLLFREE has freed the waitqueue, so we must complete */
>   	list_del_init(&iocb->ki_list);
>   	iocb->ki_res.res = mangle_poll(mask);
> -	spin_unlock_irq(&ctx->ctx_lock);
> -
>   	iocb_put(iocb);
> +	spin_unlock_irq(&ctx->ctx_lock);
>   }
>   
>   /* assumes we are called with irqs disabled */
> @@ -2198,7 +2197,6 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
>   			break;
>   		}
>   	}
> -	spin_unlock_irq(&ctx->ctx_lock);
>   
>   	/*
>   	 * The result argument is no longer used - the io_event is always
> @@ -2206,6 +2204,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
>   	 */
>   	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
>   		aio_complete_rw(&kiocb->rw, -EINTR);
> +	spin_unlock_irq(&ctx->ctx_lock);
>   
>   	percpu_ref_put(&ctx->users);

I'm not enthusiast about the above patch because it increases the amount
of code executed with the ctx_lock held. Wouldn't something like the
untested patch below be a better solution?

Thanks,

Bart.


diff --git a/fs/aio.c b/fs/aio.c
index 28223f511931..c6fb10321e48 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2177,6 +2177,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, 
struct iocb __user *, iocb,
  	struct kioctx *ctx;
  	struct aio_kiocb *kiocb;
  	int ret = -EINVAL;
+	bool is_cancelled_rw = false;
  	u32 key;
  	u64 obj = (u64)(unsigned long)iocb;

@@ -2193,6 +2194,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, 
struct iocb __user *, iocb,
  	/* TODO: use a hash or array, this sucks. */
  	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
  		if (kiocb->ki_res.obj == obj) {
+			is_cancelled_rw = kiocb->rw.ki_flags & IOCB_AIO_RW;
  			ret = kiocb->ki_cancel(&kiocb->rw);
  			list_del_init(&kiocb->ki_list);
  			break;
@@ -2204,7 +2206,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, 
struct iocb __user *, iocb,
  	 * The result argument is no longer used - the io_event is always
  	 * delivered via the ring buffer.
  	 */
-	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
+	if (ret == 0 && is_cancelled_rw)
  		aio_complete_rw(&kiocb->rw, -EINTR);

  	percpu_ref_put(&ctx->users);


