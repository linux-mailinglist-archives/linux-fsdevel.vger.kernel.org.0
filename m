Return-Path: <linux-fsdevel+bounces-28626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF6396C7B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 21:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42AF1C252E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0701E764C;
	Wed,  4 Sep 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kh7e704G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E41E7640
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478833; cv=none; b=O+9/O2w+aHWmAeLVg5bQIbjFGTJj45Od+cchtAhxv5jHBHLUxDzPrXbenz9aUyNa6Z+Vb73NfYvQk6pRxqrRKBq5c90Cbtk4eo9Xhxl9SE92zAnKAzgHWldlBsosYWxBPG20otsswc3OZgy4ouSOs3nNP7Cae260Pu9zKxKZLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478833; c=relaxed/simple;
	bh=sFK+z6j83B7nG0l5C6th3o3jysNFQkS+EooM493U8fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bbfg0Rg1jMf8+U5rJu5sbGn0WeRuXGduvJmlWTS3U+7lKys/7AtNGPodyxZMh3q5od8BSXaPmfdfxyxnfAZaq03PSvGCCTXoCaT8Lu14Z0uG5dy5UWjbmlLMAVJzEj10SGG/t7Hn81kikNoDrwUWBJt57ar0lnOrwnoQfj9rwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kh7e704G; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82a1b84e6e1so284085939f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725478829; x=1726083629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8rrocRi3RpXHkuZGvE5+l0ZyE6WtAH/Qdvl6OvNLPk=;
        b=Kh7e704Gnv6r56z+qRBZJchoAocwnzikdgK9MgbfBhQnuoNzuKBGNDuxKb5l+ZUlTJ
         FgVomc3G5quxom4wDhUUhRCzkgZLBhu1S6OlARQzQ3ndQ+VxsL3eYclpfabdjC3Pnmf8
         97raK5qnKv0PzXnNuiING4+nebXY4Z2leWT0kwbl4QIIOgNjh1EryXVrr7CtHfrJxqu7
         7i1CYPksUHfSFGyUj3F4OS78FT9EjodTegv8lxn1hgon5svGpVAQjBUQJXHmN2TGtc75
         NUbpcVTEVOjDR8RiXCj5pK6dW5lgpj/d+/ek4R9ZYfwjOKCYBX3OknMi1EwfI8VqRGBz
         UOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478829; x=1726083629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8rrocRi3RpXHkuZGvE5+l0ZyE6WtAH/Qdvl6OvNLPk=;
        b=eOde8k/eh3soVrswxIl84fK3XK0yp6jlhg8MegItNYpEy7aZz07cduaVzAk/KCLsDM
         JwGruNVq5LIvmKjAbvGjZvymCXmIgMjfk1LNYfwHoId+BORsgxbuLDjpmxLQrE1HX00O
         HyA79/K8bza/IQZyV+/rvOLoHfjzu77Q5wJudEAxVQqVLNM0ezCUQ4sj72MJFSPULeuT
         s+mnlFhnjLSBtJam8rsoFK6pAyHaPQwNyiUktWDEpFEIhmIJn9azSfBECnwC3SvQRrkp
         8B8OrSsaZYHypkXsqbLWqga5WMJqS7mCGEa+yVJ0E84S6an4yS7O/N4IBSgcLGbJla+X
         slmg==
X-Gm-Message-State: AOJu0YzPv5T/2vaT8Yt/4eDlvbZJjWUq9rywXIVGDnnKLmt0N0/+6ttY
	QwQ75mVOvJpiBdbMHe61z9YsmuuG0Nk1SYRXXJvbVnMMrCt+heVjZXTZoEa6TZM=
X-Google-Smtp-Source: AGHT+IGaWvDYTOVwXSvbGG/BoMgDFN6OpixpP8yoxax2T3Jx8e5XLjM/FHBqklG5nc/eiOURBXj2Ww==
X-Received: by 2002:a05:6602:6d16:b0:827:9393:4e1e with SMTP id ca18e2360f4ac-82a648b2170mr697351239f.9.1725478829316;
        Wed, 04 Sep 2024 12:40:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de7825sm3331968173.63.2024.09.04.12.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:40:28 -0700 (PDT)
Message-ID: <20342352-773c-4fb1-ac66-bcc6cf45d577@kernel.dk>
Date: Wed, 4 Sep 2024 13:40:27 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 17/17] fuse: {uring} Pin the user buffer
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Pavel Begunkov <asml.silence@gmail.com>, bernd@fastmail.fm
Cc: linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Amir Goldstein <amir73il@gmail.com>
References: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-0-9207f7391444@ddn.com>
 <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-17-9207f7391444@ddn.com>
 <9a0e31ff-06ad-4065-8218-84b9206fc8a5@kernel.dk>
 <6c336a8f-4a91-4236-9431-9d0123b38796@fastmail.fm>
 <cd1e8d26-a0f0-49f2-ac27-428d26713cc1@kernel.dk>
 <26c96371-a113-4384-b97b-cf4913cdf8b5@fastmail.fm>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <26c96371-a113-4384-b97b-cf4913cdf8b5@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 1:25 PM, Bernd Schubert wrote:
> 
> 
> On 9/4/24 18:16, Jens Axboe wrote:
>> On 9/4/24 10:08 AM, Bernd Schubert wrote:
>>> Hi Jens,
>>>
>>> thanks for your help.
>>>
>>> On 9/4/24 17:47, Jens Axboe wrote:
>>>> On 9/1/24 7:37 AM, Bernd Schubert wrote:
>>>>> This is to allow copying into the buffer from the application
>>>>> without the need to copy in ring context (and with that,
>>>>> the need that the ring task is active in kernel space).
>>>>>
>>>>> Also absolutely needed for now to avoid this teardown issue
>>>>
>>>> I'm fine using these helpers, but they are absolutely not needed to
>>>> avoid that teardown issue - well they may help because it's already
>>>> mapped, but it's really the fault of your handler from attempting to map
>>>> in user pages from when it's teardown/fallback task_work. If invoked and
>>>> the ring is dying or not in the right task (as per the patch from
>>>> Pavel), then just cleanup and return -ECANCELED.
>>>
>>> As I had posted on Friday/Saturday, it didn't work. I had added a 
>>> debug pr_info into Pavels patch, somehow it didn't trigger on PF_EXITING 
>>> and I didn't further debug it yet as I was working on the pin anyway.
>>> And since Monday occupied with other work...
>>
>> Then there's something wrong with that patch, as it definitely should
>> work. How did you reproduce the teardown crash? I'll take a look here.
> 
> Thank you! In this specific case
> 
> 1) Run passthrough_hp with --debug-fuse
> 
> 2) dd if=/dev/zero of=/scratch/test/testfile bs=1M count=1
> 
> Then on the console that has passthrough_hp output and runs slow with my
> ASAN/etc kernel: ctrl-z and kill -9 %
> I guess a pkill -9 passthrough_hp should also work

Eerily similar to what I tried, but I managed to get it to trigger.
Should work what's in there, but I think checking for task != current is
better and not race prone like PF_EXITING is. So maybe? Try with the
below incremental.

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 55bdcb4b63b3..fa5a0f724a84 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -121,7 +121,8 @@ static void io_uring_cmd_work(struct io_kiocb *req, struct io_tw_state *ts)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	unsigned flags = IO_URING_F_COMPLETE_DEFER;
 
-	if (req->task->flags & PF_EXITING)
+	/* Different task should only happen if the original is going away */
+	if (req->task != current)
 		flags |= IO_URING_F_TASK_DEAD;
 
 	/* task_work executor checks the deffered list completion */

-- 
Jens Axboe


