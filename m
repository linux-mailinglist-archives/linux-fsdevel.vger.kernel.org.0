Return-Path: <linux-fsdevel+bounces-36727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9C9E8B9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 07:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574DA281697
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 06:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD952147FF;
	Mon,  9 Dec 2024 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="GGhoYZKv";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="Z5KtUWBm";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="yLHIY8QZ";
	dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="TMHLkG1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136ED20FA9A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726602; cv=none; b=deSgZW1T6wBLr64Hoh3ViEe9wlz3AUuGL8yYw7guBZCYhP0+eBn/HZWcD90vXYXsYAX1FinuKkjbeENiFhWTsIhoBWM8U+imZtPxwrFG6xrHhodxijzCEMg5L7NUKFKHI8EVb2fFMOB+x+B7agYpz7tKZXJIyXGPNV1YaYqHruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726602; c=relaxed/simple;
	bh=VLl24JjwUJIISsY5ZHirFSo4Tjf+de30AU9E/AZFcn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqLHrYnr3hBtm4I2P1WVPUqqkYEcBbliDTmD51qQvCyu/nU0OZM3ax1ebVUNK3608YFgghyT44ZI5DKNXvs7AVErHfDpQybXpK6/mnOsJT4UiwH7atn2bjGeg1VY1LwyERQ3hkDxCZoQ6DHnN5RLrcY6BIGbznzNvewyP0N6LmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=GGhoYZKv; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=Z5KtUWBm; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=yLHIY8QZ; dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=TMHLkG1j; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:808e:8168:83e7:b10])
	by mail.tnxip.de (Postfix) with ESMTPS id 3FA98208CF;
	Mon,  9 Dec 2024 07:43:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733726586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPaby7d1KNGnXuhnAhoPzjpDWoAOEwxOOxWLYqZGA24=;
	b=GGhoYZKvm2H7Z03rbU4MNjWSg74qR5TsmfEW9GwU87+XlhQmYfhKZ1B13xZ4qmi/EnppF9
	Ku31l5mx1FGWb/6x8p/QBYhO+SePnqTnbj5YyuJSYKEKq7AfsvKQ3RZHbqsnpV4dW0fCzU
	5FtQeoNLOHoYgctQTpwvIyEQkl0cXys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733726586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPaby7d1KNGnXuhnAhoPzjpDWoAOEwxOOxWLYqZGA24=;
	b=Z5KtUWBmzgbwYGX4etrRfSYOz4U2FLlu4PKmDdD7R4iLT7ykXQCmqJ2GWNPa+Wm8LUvwHb
	/wbqGLcPuJfP+eBw==
Received: from [IPV6:2a04:4540:8c0e:b000:78f6:dfc8:70c7:7ba] (unknown [IPv6:2a04:4540:8c0e:b000:78f6:dfc8:70c7:7ba])
	by gw.tnxip.de (Postfix) with ESMTPSA id EDFF4380EA9F4;
	Mon, 09 Dec 2024 07:42:59 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733726586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPaby7d1KNGnXuhnAhoPzjpDWoAOEwxOOxWLYqZGA24=;
	b=yLHIY8QZa7m/Qs6xE952f07QBp3vM7CTih7fD7YIiIAo64Q9EPaae9cYPfYTIYVCHsV0D5
	OCOhObedgJvlspDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733726586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPaby7d1KNGnXuhnAhoPzjpDWoAOEwxOOxWLYqZGA24=;
	b=TMHLkG1j/WvlZ4aCjqrgIfceadVvrK5a1K70fL/SK49XrrwGCPFo5syfGLZOKky/oC21UU
	BqE+Y7eYcAyklIBxn2VwxfsUcDZC6/9501r7/WYbuH7vgPMNGervXGLNwRP1oJGIFAvW1w
	2TlHhKcH8+uO51xbrzhLK9eV7jU4DBw=
Message-ID: <804c06e3-4318-4b78-b108-12e0843c2855@tnxip.de>
Date: Mon, 9 Dec 2024 07:42:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: silent data corruption in fuse in rc1
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Bernd Schubert <bschubert@ddn.com>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <0d5ac910-97c1-44a8-aee7-56500a710b9e@linux.alibaba.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <0d5ac910-97c1-44a8-aee7-56500a710b9e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/12/2024 02:57, Jingbo Xu wrote:
> Hi, Malte
>
> On 12/9/24 6:32 AM, Malte Schröder wrote:
>> On 08/12/2024 21:02, Malte Schröder wrote:
>>> On 08/12/2024 02:23, Matthew Wilcox wrote:
>>>> On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
>>>>> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
>>>>> me.     
>>>> That's a merge commit ... does the problem reproduce if you run
>>>> d1dfb5f52ffc?  And if it does, can you bisect the problem any further
>>>> back?  I'd recommend also testing v6.12-rc1; if that's good, bisect
>>>> between those two.
>>>>
>>>> If the problem doesn't show up with d1dfb5f52ffc? then we have a dilly
>>>> of an interaction to debug ;-(
>>> I spent half a day compiling kernels, but bisect was non-conclusive.
>>> There are some steps where the failure mode changes slightly, so this is
>>> hard. It ended up at 445d9f05fa149556422f7fdd52dacf487cc8e7be which is
>>> the nfsd-6.13 merge ...
>>>
>>> d1dfb5f52ffc also shows the issue. I will try to narrow down from there.
>>>
>>> /Malte
>>>
>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
>> with 3b97c3652d91 as the culprit.
> Would you mind checking if [1] fixes the issue?  It is a fix for
> 3b97c3652d91, though the initial report shows 3b97c3652d91 will cause
> null-ptr-deref.
>
>
> [1]
> https://lore.kernel.org/all/20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com/
It does not fix the issue, still behaves the same.

