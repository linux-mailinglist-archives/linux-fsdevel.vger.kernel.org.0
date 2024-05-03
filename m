Return-Path: <linux-fsdevel+bounces-18666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102638BB375
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 20:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416FE1C22591
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E4154C12;
	Fri,  3 May 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q+sjMUO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EB12EBFB
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762157; cv=none; b=Qap9tKJAUVi2PoDUW/e+IAMx8G4HG2f1ZXmD4Aw2rXL6OeGqgcsXrq/1pWgg6IdsaTuIFlE83ekUfPUNONVBv/p32SXX3afq8O3xmVDO+9z/GdAGzdxxBCtlIuNcaUyNTJv+SK0xAxr8WpjpzzIJa/MmRhVoJxqKad8E8neBUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762157; c=relaxed/simple;
	bh=lgWvD3PbcoJjHAvCMG758qd7evw4OjG5rRe4FiYHJto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0rt/lPnKcTCMCtgvGl+F0HCy+yGew47BavVrQLBAXME7y3ecs2SHSQa5N7PBLrmF/TQuzo6e/fuGMnDBWyejd2bCb95pEwstG5xoyxdQ0g39R/OwE45K0xk5YUmFaVXwh7Afa5+06Tk5zFMzD7iZ1JwvhGwPKpuiTCrDdvSwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q+sjMUO8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b360096cc4so11715a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714762154; x=1715366954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6sVd1TZfxbwE7hyL107cZLQAt+SkbJAdkmwm2tiV/I=;
        b=Q+sjMUO8PZGIDVJ0sjVlnFmWGpW5R5dlmERHPvlPSEgdnsq3kfGv5jMIh8dKmX0s98
         55l/T8RNk4BIBcXN1q6pKWw6uuYeXpBNbpujDJo0vAGYt5to/QPaEvJY+Pv7CqXPEvSk
         H5aAdeV+RLRdkTgbzC/57IY46AMqXAIBqIdiYxjm+wgCAkpkOnbuJKGhbJO7MpX/ZqwA
         KGET9W94fI79Ft8sVoxncNhFUB9S2Fpd+n9iiwwkviVamygQOE2wH34UjJiR/ffuxdQ7
         lnxJaxwKdS6TrJYHcUk2OFbYTeSKff9lDRGexXPAofquyNDp/z7CHN3IrRXcTC0ybJC+
         8jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714762154; x=1715366954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6sVd1TZfxbwE7hyL107cZLQAt+SkbJAdkmwm2tiV/I=;
        b=XUXn2EM7a1XuRnUr7m9VqWzqZmh81GJ+5hXXKxexUKb/xfZIN0zmsY32jIgS5h8sth
         qkvLzv3GQbdbJ2JNBtNBszwq1+toR+Am3pA3xVW5oBUcdLcvUuaLgz+hhh46Evn19UEj
         zKuI8TxBdex9q/uZPcXRr9AKV8x//5FU7YOI/FLJOQ6qvAub/4tClf0xC2KnYW+thSE0
         23V3YWioHSTpo/SmZzVaK8VycCYFELLdzsxkdVvr1JRfLGx4hu0i2/bTMdY7O62c8675
         RCzzySgS7yW8u5k8f10Px3Zs85i6sUPu7tmY8uU/+vYVkw/rRRzixp23bOWZgMKhDHRD
         QNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLAix+Aeog9kvciJKQcHtNKZe5L8tFUS43V0pwij64Nuz+ntxi+7jU0Mmjc78mKB0bM4TNWJ9mUxtWZ1+U/EFJbF2Hoq8Nh3j+UcbmKg==
X-Gm-Message-State: AOJu0Yz+XxzwPwFPYT1eSc+5e9kcG5rhRtF7qJRdQEGgQ7YD2dtyRJT4
	NLzqeEFCg0TuEEJSjG41+9iEDmyBEP0lGvmAph12eXi9wLvTO+rfxUYFV6HVWvs=
X-Google-Smtp-Source: AGHT+IG3+qjTWapc+Q+wN/PJnBYud4dggeONIpdmMvZWXIbQyfbY8nF72QViuq38TDN9fCmFOCrwSg==
X-Received: by 2002:aa7:8617:0:b0:6ea:6f18:887a with SMTP id p23-20020aa78617000000b006ea6f18887amr3538580pfn.1.1714762153806;
        Fri, 03 May 2024 11:49:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b8-20020a056a000cc800b006f0ba75b6b7sm3374417pfv.208.2024.05.03.11.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 11:49:13 -0700 (PDT)
Message-ID: <64b51cc5-9f5b-4160-83f2-6d62175418a2@kernel.dk>
Date: Fri, 3 May 2024 12:49:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: get_file() unsafe under epoll (was Re: [syzbot] [fs?] [io-uring?]
 general protection fault in __ep_remove)
To: Kees Cook <keescook@chromium.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Laura Abbott <laura@labbott.name>
References: <0000000000002d631f0615918f1e@google.com>
 <7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com>
 <202405031110.6F47982593@keescook>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202405031110.6F47982593@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 12:26 PM, Kees Cook wrote:
> Thanks for doing this analysis! I suspect at least a start of a fix
> would be this:
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 8fe5aa67b167..15e8f74ee0f2 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -267,9 +267,8 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>  
>  		if (events & EPOLLOUT) {
>  			/* Paired with fput in dma_buf_poll_cb */
> -			get_file(dmabuf->file);
> -
> -			if (!dma_buf_poll_add_cb(resv, true, dcb))
> +			if (!atomic_long_inc_not_zero(&dmabuf->file) &&
> +			    !dma_buf_poll_add_cb(resv, true, dcb))
>  				/* No callback queued, wake up any other waiters */

Don't think this is sane at all. I'm assuming you meant:

	atomic_long_inc_not_zero(&dmabuf->file->f_count);

but won't fly as you're not under RCU in the first place. And what
protects it from being long gone before you attempt this anyway? This is
sane way to attempt to fix it, it's completely opposite of what sane ref
handling should look like.

Not sure what the best fix is here, seems like dma-buf should hold an
actual reference to the file upfront rather than just stash a pointer
and then later _hope_ that it can just grab a reference. That seems
pretty horrible, and the real source of the issue.

> Due to this issue I've proposed fixing get_file() to detect pathological states:
> https://lore.kernel.org/lkml/20240502222252.work.690-kees@kernel.org/

I don't think this would catch this case, as the memory could just be
garbage at this point.

-- 
Jens Axboe


