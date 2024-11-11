Return-Path: <linux-fsdevel+bounces-34230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72A29C3F2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31006B25531
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB12319E966;
	Mon, 11 Nov 2024 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="vqnq1dST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19C155CB3;
	Mon, 11 Nov 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330259; cv=none; b=XsvyAi1Dq5VUh+Xuu1/4uZFI5W1on3PFIcZ3zN6nPeULVz968Or7ySPyhd4WUguDrHVedtMTuXnoP8AMgctmoVy6fdxz9jUyWokC/ss2d2vT1qiCKeKzE65eQx1st063PqD3lNqxuMUXE4J+Mp5A4TXZXxqA9P1Js4XyfvJ8enE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330259; c=relaxed/simple;
	bh=gqC/kUedyrtC5XrbMDdoG/YI6RVhmvKtndWDGNJ5BWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2C8EY58+Qn8xv3CrdZeOGhEFWJ51qTqa/3L+scNaVNpDc05sdAnOrCVazzFx2tesjPSo11Rn3YYpOBtkmJUsw9ZiLY1oxP7a747d7bpdwBMnxNpiLEWCFBB0OXmK13IK8w4xyzCxG9BCIOTnjf850wYGfANGFpjZVsw1Lu6NtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=vqnq1dST; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=2WZioZbMK62yjCWYpF2+yStEVV9m8+tk5g3PAsrD4Hg=; b=vqnq1dSTE4DLsWq7PvwJjagckv
	wLMdMwbJidH/rwtecbzaIz2T7IbDEUg6OnPrylt8V0L3wVvnFNAGDXQ61BwyOy+h61T2NuALktLmu
	iNSDm1VdPYTfzuZrO907A2htvGfoaxe1lVLnlZRfHklmydhsCFwuk2daq69tgZlGSziofGNTT3XmU
	HqxmL3NgCxXUuauvd1HbjaZD/sHRYbmm5PFru4lZpr1QDSiTeIYNCT7UBnBE9hI7Gy9an/35AL+6q
	DYp5HktoKK8JLYZgXHP7ZFqiKk/4BYoNsiu/ziOnL++sIYLUk52ZXMkcp2IgfWOQZB6kq1DtQukGL
	p0OHRSzfGUw3U+8q4xqjp7m4P/VKCUxp43gOeziXEbVzneLY9GZQ/wsfWOk+0E7GyxFtoGssiUSPi
	ytO1o28cWk7KPCmp6FjGkjqmlLkoyKHzJiBCPhS+0c5pkDX2SWqr6GoU/z7Ll/CPGIEjuEBhelgnz
	3aXhIp2l4bQiDhMbJTH65q6V;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1tAU5V-00A3Hc-1B;
	Mon, 11 Nov 2024 13:04:13 +0000
Message-ID: <dbcad551-bf66-406b-a6cd-b8047d1cbace@samba.org>
Date: Mon, 11 Nov 2024 14:04:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] fs: add read support for RWF_UNCACHED
To: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-9-axboe@kernel.dk>
Content-Language: en-US, de-DE
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20241108174505.1214230-9-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jens,

> If the same test case is run with RWF_UNCACHED set for the buffered read,
> the output looks as follows:
> 
> Reading bs 65536, uncached 0
>    1s: 153144MB/sec
>    2s: 156760MB/sec
>    3s: 158110MB/sec
>    4s: 158009MB/sec
>    5s: 158043MB/sec
>    6s: 157638MB/sec
>    7s: 157999MB/sec
>    8s: 158024MB/sec
>    9s: 157764MB/sec
>   10s: 157477MB/sec
>   11s: 157417MB/sec
>   12s: 157455MB/sec
>   13s: 157233MB/sec
>   14s: 156692MB/sec
> 
> which is just chugging along at ~155GB/sec of read performance. Looking
> at top, we see:
> 
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> 7961 root      20   0  267004      0      0 S  3180   0.0   5:37.95 uncached
> 8024 axboe     20   0   14292   4096      0 R   1.0   0.0   0:00.13 top
> 
> where just the test app is using CPU, no reclaim is taking place outside
> of the main thread. Not only is performance 65% better, it's also using
> half the CPU to do it.

Do you have numbers of similar code using O_DIRECT just to
see the impact of the memcpy from the page cache to the userspace
buffer...

Thanks!
metze


