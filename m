Return-Path: <linux-fsdevel+bounces-30132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8AC986A5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 03:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64521C2156F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 01:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4811714A8;
	Thu, 26 Sep 2024 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UjZejoKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837B139B;
	Thu, 26 Sep 2024 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727312659; cv=none; b=gSrOPyZG/lbwC0NBtIXrLtFwV+CBQLlI2enz5lvRRZY9q7rKMJua58vIPIqJKD+n0RZEFYnNtGNqI2p5+7eVEGhKoDrpdnV97+hlRxSDDNPkdc0/mZAKtDg+OG67ygHPlY+WMD0zAQUS7mhX+wU+0W4c/edg/uhfaLFOT6fAA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727312659; c=relaxed/simple;
	bh=OTXtnIyXvv3ctTfp1uZptvfnkaFLbGK9hNEOisZ33s0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JfX+qgLz5x9cRbn8oVa6eRd4cogOkgqHrZVRvrISR6JsGioeXB5tPyeqqBnKXqzdTCUxrHqzkQdbDrP5ieSe7h8yjS0R2tWgq6bDu1eU01u/P7e+cG/XXXVEicuRho+nMmdOs7J+kMZTTU4kOfqpV9DDrAjIdZXhPRlbgeph6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UjZejoKC; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727312653; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Fwd7Ybo+H+LowOXsq8VU7uRzWXWrPpIwnjgLH/1cB08=;
	b=UjZejoKCB0DGk1D6Kb2BON+NvvvxmnC+IFLoLiGCzvl6mQK8SWBvMJXlCxSWXyFqssHyNnaP+Due/zgx0pvJ/TRg79bvX+s76Seq1FC/e2SKRJWzqnzJ0C4N5amq+8L+XLACIjoUIWeb8ce497fnbFNhMzp5myKrgLwmOkJdsg8=
Received: from 30.244.99.85(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFlPsQC_1727312650)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 09:04:12 +0800
Message-ID: <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
Date: Thu, 26 Sep 2024 09:04:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Ariel Miculas <amiculas@cisco.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>,
 Yiyang Wu <toolmanp@tlmp.cc>, rust-for-linux@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
In-Reply-To: <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/26 08:40, Gao Xiang wrote:
> 
> 
> On 2024/9/26 05:45, Ariel Miculas wrote:

...

>>
>> I honestly don't see how it would look good if they're not using the
>> existing filesystem abstractions. And I'm not convinced that Rust in the
>> kernel would be useful in any way without the many subsystem
>> abstractions which were implemented by the Rust for Linux team for the
>> past few years.
> 
> So let's see the next version.

Some more words, regardless of in-tree "fs/xfs/libxfs",
you also claimed "Another goal is to share the same code between user
space and kernel space in order to provide one secure implementation."
for example in [1].

I wonder Rust kernel VFS abstraction is forcely used in your userspace
implementation, or (somewhat) your argument is still broken here.

[1] https://lore.kernel.org/r/20230609-feldversuch-fixieren-fa141a2d9694@brauner

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> Cheers,
>> Ariel
>>


