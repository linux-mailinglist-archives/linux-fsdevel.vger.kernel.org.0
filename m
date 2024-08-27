Return-Path: <linux-fsdevel+bounces-27326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425C3960468
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AB41C221B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D63194A45;
	Tue, 27 Aug 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pKqr7iDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E6131182;
	Tue, 27 Aug 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747417; cv=none; b=r7BNpa7EEIvXFeIWGo8iDtDF8iZfBdppLtCvD8s6KjCU6gPMxCneKOgF0UEEWpVX8rGeT7gVKT/cwtBYtHOuEMn2SUVXORgr4tNqZvTOAWdadq4R+78Tv92XpPnX51DP7qNb0xlczuL7+K40Bpz0th4/CaH86xygy66o7by6234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747417; c=relaxed/simple;
	bh=jg0/rmsvwp3GNFrAUQKLYX2B3qJwQV1WYxwLvOeHNy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb60rGFjVTXK7nLg/fK0du4N/FURck8abtRWN5sMQLCrFhrpmYaWAMZZsjtGeRabDgZFDtbIq85MGjWKko2TvFCYNEahlqMxHX+OBoAviQHlBnhWg2AbtYwJh/wuq/KBAAqx4HqghqHXGOuM6mLZz4WMMrY6YazQ0uoZSvQKs5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pKqr7iDL; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724747405; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8NSi4V9Xxq4vzXfZ0faptjHFkTPl6+ibwu1U8zjxjJM=;
	b=pKqr7iDL+TXUWFBCfLw260z5pjdpHmfI08+qMXIn6wy4Wa3AcPBvddNVoUKUn64OYN+m+JRvHRB5Eg934pOTENVbssx1cl/xy5kDauDoGrKLDZYVnqi4rJymWrkoc9mXDBSxRjUjUly2LeAQKEOeDK++VlzeNyI+tN3wNKps3EA=
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WDlwG37_1724747404)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 16:30:05 +0800
Message-ID: <efc65503-15fd-4f8d-a6c4-b3bacb7481cb@linux.alibaba.com>
Date: Tue, 27 Aug 2024 16:30:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: remove useless IOCB_DIRECT in
 fuse_direct_read/write_iter
To: Miklos Szeredi <miklos@szeredi.hu>, yangyun <yangyun50@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 lixiaokeng@huawei.com
References: <20240826130612.2641750-1-yangyun50@huawei.com>
 <CAJfpegt_P=Dj-CXnbZYK+XZW8ZwNH0_Str30q9vub0o00UMuWQ@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegt_P=Dj-CXnbZYK+XZW8ZwNH0_Str30q9vub0o00UMuWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

On 8/27/24 3:12 AM, Miklos Szeredi wrote:
> On Mon, 26 Aug 2024 at 15:07, yangyun <yangyun50@huawei.com> wrote:
>>
>> Commit 23c94e1cdcbf ("fuse: Switch to using async direct IO
>> for FOPEN_DIRECT_IO") gave the async direct IO code path in the
>> fuse_direct_read_iter() and fuse_direct_write_iter(). But since
>> these two functions are only called under FOPEN_DIRECT_IO is set,
>> it seems that we can also use the async direct IO even the flag
>> IOCB_DIRECT is not set to enjoy the async direct IO method. Also
>> move the definition of fuse_io_priv to where it is used in fuse_
>> direct_write_iter.
> 
> I'm interested in the motivation for this patch.
> 
> There's a minor risk of regressions when introducing such a behavior
> change, so there should also be a strong supporting argument, which
> seems to be missing in this case.
> 


I'm not sure what yangyun's use case is, but we indeed also observed a
potential performance optimization for FOPEN_DIRECT_IO path.  When the
buffer IO is submitted to a file flagged with FOPEN_DIRECT_IO, the code
path is like:

fuse_direct_read_iter
  __fuse_direct_read
    fuse_direct_io
      # split the request to multiple fuse requests according to
      # max_read and max_pages constraint, for each split request:
        fuse_send_read
          fuse_simple_request

When the size of the user requested IO is greater than max_read and
max_pages constraint, it's split into multiple requests and these split
requests can not be sent to the fuse server until the previous split
request *completes* (since fuse_simple_request()), even when the user
request is submitted from async IO e.g. io-uring.

-- 
Thanks,
Jingbo

