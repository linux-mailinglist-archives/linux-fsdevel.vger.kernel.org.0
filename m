Return-Path: <linux-fsdevel+bounces-78313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMobFugenml+TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:58:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF418CFB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23BFA30297A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 21:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8B343D80;
	Tue, 24 Feb 2026 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TrJ7vwsu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ECB34252C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970258; cv=none; b=XMmVeap4Z2H0zsozKKjK4eb4p/ZlxMaADEZr8sXZsAk6QSP1tXa41bTP9UiGRamf6Dgl19QI2g5YJY4topKa0foWifSpV51AYXoU0r7wAy+IvaA6N8rjUWpY8tOQrdyAMv/T8d1yyWJ65tk9lIogGnQtT4i5zZTYSG3/1/IGHgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970258; c=relaxed/simple;
	bh=rS/vF8oePReEKo9zkYWkQUSQSG0rPsm+zvpTUbJggnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhCUCNtvr4jk2xSVYhtfKtpwwNwnELM8ckAT+CRgHf0NWl6nAQKtqz3sSEUud3q+bnX/yJ/3Vp31sHXkmbX9xBFcV3R3pKwvcQAIEU/82XwiPHPDRq3tNEj8dcM3gqjvNptRQQGyl4dCsmUZeoSh5bOePB0kC9mg0B1HAjrac3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TrJ7vwsu; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-463f00cda04so3644154b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 13:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771970256; x=1772575056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwP5kE4h/MaU7UR5/1NVkgVwsMPA0UhiFJBkhtrREU0=;
        b=TrJ7vwsu2jrJ0ut8SwUFgQuhiaULW2XgRFfHaocJMHeA5ACQhvdtgwl5DMSrCiGMRH
         3/LLcGI2D0dQV1Mh4AXsJxpTtNVtw7vcFA3eGaNiUy/Wr8n0vgCQI55XV74Yv4DLod/g
         1SERXoqahjT4/g1FZxFxiVEH0z70GrjGPZxdABIC2FIqDzkZ3WJpusv3LZ8sWDuRhpna
         OPeot7JKC9YVgZjW46RW0LMhMuEKRPBGQYTPD2lhXMIkNyCoEd4Cwex3Wi53Up7M3Jm3
         2IiwhPSJSNRJbRQ4bIq8qYqKuSJGD1qegkhPwxfNMlFfBfXMyp7YPLfzwgdpbx9UJOEb
         7qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771970256; x=1772575056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwP5kE4h/MaU7UR5/1NVkgVwsMPA0UhiFJBkhtrREU0=;
        b=FD6BLMqbyGld+Q17OR66a5iLO+kZcnt5Xd5xPyXUObYMZ53tGXEbMSf9+oTUrEaAnF
         lE6zadq/AQVki3ay3AlHWXVOa92Nvg2bnhVvxxcXBS7Hvvn2qjluWeAR8HyBumM7dej/
         7y01YeWhWPZyUhK3pESAc7ji7I7Vhp27t4PpVpeZKzyegWenuxgryzImTYxC041SFObz
         1M/xSQBdYk2Ap8Xp6blP76MtQz41YBIwHLKedrsoNtJas3WneMNkQ05qACHMcoQdbAho
         Ix/LikinqK8OjW3JE1Qa0pTyVm7gMFRtoz4GtT1XhWHE+xvj1zAa89CJmnoZZlTzXf9G
         Pfqg==
X-Forwarded-Encrypted: i=1; AJvYcCXULFx0j52W0tPXkn8YqGVPknvEp9CoTuecPDCZ0TziZ3gDQtWxQUL8ElbWEQEkkheOdZ5XBj/PbUC8Ho38@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xfvpTaGt7hKsgvywurE7TPLqm2A16ARZe6FkD31lXzXZR+Q1
	cGl3nxQ7MA3qyVyirpjRgjG6/s4b89bvTlW1iQNONkZj0RicbzgfAbqTmvgR0s6K6MI=
X-Gm-Gg: AZuq6aI9JPK426ErD9EOLbzLpUvJF7JeHSO48opf5RET2YczTP79ppyeJzJ9vkxU3qW
	uuO6G1mRw8I8Tr0QbbNoRJp9oE0V3oe7uMADFyiiGu3xGsGmAYx1R9NNWsWIP7h7szn4+kOifM8
	psOJeQMkeW35R8Gyi9P3m5HcAvm8iZyxUg47mclFCUb2aLP6re5OQZwwX9dMGuuSRVC8do0uB8S
	XfzCO+iiLPca7EqZGO89REXsyx1qAP7kJkIIIdrZEIfFrRswyxov5Ek83Icc5U/oG+ckc7dY3tu
	swpcfBEM7ez0PM1J8LBnz+39OZYgEGYrY9M8mRZb6asu8Dp4/PyRa9iov1kPcWI0iS1l0ygXEII
	O0i6P1MDtqFxnkep7+p8ngFSS3t5UcejpWFFpZEZTWQw3npm+eRgwe8cBAUnNu9/Qjk/kxsX9D4
	UPmrq8B4w7YwsR3VC37sSZNWyfU5O1MXeZRS1TTdvV0hq8Cqp6H1xY6ibk+hb4RKZ3rWbf1zTK5
	p1w8LZZOA==
X-Received: by 2002:a05:6808:150d:b0:450:b249:718c with SMTP id 5614622812f47-46446343c9emr7080160b6e.31.1771970256570;
        Tue, 24 Feb 2026 13:57:36 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4648a4ecf1fsm936075b6e.12.2026.02.24.13.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 13:57:36 -0800 (PST)
Message-ID: <825ab511-9335-4827-a3fd-6dd6f498326e@kernel.dk>
Date: Tue, 24 Feb 2026 14:57:35 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] buffer: fix kmemleak false positive in submit_bh_wbc
To: Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
 brauner@kernel.org
Cc: jack@suse.cz, changfengnan@bytedance.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260224190637.3279019-1-sashal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260224190637.3279019-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-78313-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: ABDF418CFB4
X-Rspamd-Action: no action

On 2/24/26 12:06 PM, Sasha Levin wrote:
> Bios allocated in submit_bh_wbc are properly freed via their end_io
> handler. Since commit 48f22f80938d, bio_put() caches them in a per-CPU
> bio cache for reuse rather than freeing them back to the mempool.
> While cached bios are reachable by kmemleak via the per-CPU cache
> pointers, once recycled for new I/O they are only referenced by block
> layer internals that kmemleak does not scan, causing false positive
> leak reports.
> 
> Mark the bio allocation with kmemleak_not_leak() to suppress the false
> positive.
> 
> Fixes: 48f22f80938d ("block: enable per-cpu bio cache by default")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 22b43642ba574..c298df6c7f8c6 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -49,6 +49,7 @@
>  #include <linux/sched/mm.h>
>  #include <trace/events/block.h>
>  #include <linux/fscrypt.h>
> +#include <linux/kmemleak.h>
>  #include <linux/fsverity.h>
>  #include <linux/sched/isolation.h>
>  
> @@ -2799,6 +2800,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>  		opf |= REQ_PRIO;
>  
>  	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
> +	kmemleak_not_leak(bio);
>  
>  	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);

What if they do end up getting leaked? This seems like an odd
work-around, would be better to ensure the caching side marks them as
in-use when grabbed and freed when put.

-- 
Jens Axboe

