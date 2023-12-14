Return-Path: <linux-fsdevel+bounces-6132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8509813A79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087141C20A2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52DA68E8D;
	Thu, 14 Dec 2023 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bL4awJd2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC563BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b709f8ba01so74421139f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702580820; x=1703185620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqOs0PUF8MGjM25NmW96fbAjdjE87kFFPmbKKuRqHvQ=;
        b=bL4awJd2dj3qHosM8eBvoUaKpIe1R+kn55itYPM3IVqAvSHqJw9d+91EGPeS7RKeYU
         vnx4DZHxVDHCcdHZPVLk0qcpmPAVpr3HMed/irDPnw3qZxQi9/NJXpDjJziweXtuh9Qu
         qtb9fTusD/I0ygf18zlLDFKT62D6vnx1cuk+RAfudjbnjNrskRZzfq/IznpAOvI4ZVJd
         1Ygx6KHrmApvRgvJ/bSriDn8uQgLjfMFCVafQNsuzInCI2e2GtYNRhhq2UcoJMGtsuRl
         l+yCW/FxdjKwCN28crOix8XijxZpGk4dlgjofVDxXRP7w4SEKD546srkx3WCeB7UJ2hD
         xriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702580820; x=1703185620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqOs0PUF8MGjM25NmW96fbAjdjE87kFFPmbKKuRqHvQ=;
        b=eAmzgk7T0P4JWUU03HYPmod8R08sll8SuGhZOxklcqnqZ0VfcCYGfncJ7IXQIbodWE
         t2Xg9gbcEXtV4l6pEpK2LOdUbn6vLsIgN8ZAKyNIFu5IWA4Bp/E4/LyvXRdlV61VnCMC
         6JbBpHCxYY2OM/c1z3W/hrmidvaZk8xabzNsTdEn/adTdiDAOXtMnaOVGg4ZkQ5egJJA
         YPWclyXofygO/6C7HyLQOapGTSGwzVkP22EbEeQHJvWOSYS+RsNkY69enXaUsBD8vtRg
         cKGM9j+hzKk8iKouwRVAox4/McXBXSc0lgw3rK91SAup5aLgSvem7wX2T9L1Q4FRbb7h
         l+3Q==
X-Gm-Message-State: AOJu0YxDQFLrz8Bc8pPlS9Hpgdvj+VGoAqJ57yQkKO/1909/lx/h9eWt
	78srj8aQl7Ni/tcoCZRpjNWnmg==
X-Google-Smtp-Source: AGHT+IE3qnRY0GPW/oTuXUJK/CBtuYMJpexJ/Mxt7AcR4ZY9+DxMzO/BMx+55mB/jlMVfnrfp5mTbA==
X-Received: by 2002:a05:6e02:1c05:b0:35f:847c:1e5c with SMTP id l5-20020a056e021c0500b0035f847c1e5cmr1655231ilh.0.1702580820321;
        Thu, 14 Dec 2023 11:07:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e6-20020a028606000000b00469010b6cc7sm3588131jai.114.2023.12.14.11.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:06:59 -0800 (PST)
Message-ID: <500557ed-3967-455e-8a79-d64711045b70@kernel.dk>
Date: Thu, 14 Dec 2023 12:06:57 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RERESEND 00/11] splice(file<>pipe) I/O on file as-if
 O_NONBLOCK
Content-Language: en-US
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 "D. Wythe" <alibuda@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Andrew Morton <akpm@linux-foundation.org>, Boris Pismenny
 <borisp@nvidia.com>, Cong Wang <cong.wang@bytedance.com>,
 David Ahern <dsahern@kernel.org>, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Gavrilov Ilia
 <Ilia.Gavrilov@infotecs.ru>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Karsten Graul <kgraul@linux.ibm.com>, Kirill Tkhai <tkhai@ya.ru>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Li kunyu <kunyu@nfschina.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Paolo Abeni <pabeni@redhat.com>, Pengcheng Yang <yangpc@wangsu.com>,
 Shigeru Yoshida <syoshida@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Xu Panda <xu.panda@zte.com.cn>, Zhang Zhengming <zhang.zhengming@h3c.com>
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/23 11:44 AM, Ahelenia Ziemia?ska wrote:
> First:  https://lore.kernel.org/lkml/cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz/t/#u
> Resend: https://lore.kernel.org/lkml/1cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz/t/#u
> Resending again per https://lore.kernel.org/lkml/20231214093859.01f6e2cd@kernel.org/t/#u
> 
> Hi!
> 
> As it stands, splice(file -> pipe):
> 1. locks the pipe,
> 2. does a read from the file,
> 3. unlocks the pipe.
> 
> For reading from regular files and blcokdevs this makes no difference.
> But if the file is a tty or a socket, for example, this means that until
> data appears, which it may never do, every process trying to read from
> or open the pipe enters an uninterruptible sleep,
> and will only exit it if the splicing process is killed.
> 
> This trivially denies service to:
> * any hypothetical pipe-based log collexion system
> * all nullmailer installations
> * me, personally, when I'm pasting stuff into qemu -serial chardev:pipe
> 
> This follows:
> 1. https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
> 2. a security@ thread rooted in
>    <irrrblivicfc7o3lfq7yjm2lrxq35iyya4gyozlohw24gdzyg7@azmluufpdfvu>
> 3. https://nabijaczleweli.xyz/content/blogn_t/011-linux-splice-exclusion.html
> 
> Patches were posted and then discarded on principle or funxionality,
> all in all terminating in Linus posting
>> But it is possible that we need to just bite the bullet and say
>> "copy_splice_read() needs to use a non-blocking kiocb for the IO".
> 
> This does that, effectively making splice(file -> pipe)
> request (and require) O_NONBLOCK on reads fron the file:
> this doesn't affect splicing from regular files and blockdevs,
> since they're always non-blocking
> (and requesting the stronger "no kernel sleep" IOCB_NOWAIT is non-sensical),

Not sure how you got the idea that regular files or block devices is
always non-blocking, this is certainly not true without IOCB_NOWAIT.
Without IOCB_NOWAIT, you can certainly be waiting for previous IO to
complete.

> but always returns -EINVAL for ttys.
> Sockets behave as expected from O_NONBLOCK reads:
> splice if there's data available else -EAGAIN.
> 
> This should all pretty much behave as-expected.

Should it? Seems like there's a very high risk of breaking existing use
cases here.

Have you at all looked into the approach of enabling splice to/from
_without_ holding the pipe lock? That, to me, would seem like a much
saner approach, with the caveat that I have not looked into that at all
so there may indeed be reasons why this is not feasible.

-- 
Jens Axboe


