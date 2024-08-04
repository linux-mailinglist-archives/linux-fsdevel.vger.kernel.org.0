Return-Path: <linux-fsdevel+bounces-24960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6031947183
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 00:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603D8B20B4B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 22:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FCD13A40F;
	Sun,  4 Aug 2024 22:51:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-06.prod.sxb1.secureserver.net (sxb1plsmtpa01-06.prod.sxb1.secureserver.net [188.121.53.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B051ABED7
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722811862; cv=none; b=rbgtoC0/lPJp81kOyMW61ghVHHT6LsKY0B6QOpYvD7+dfKrW/R4SCwePX4YIX9McnDWjYg2ihLlxRD1DMkyiZpGoVn+yXfcj7pahU/BuvrMHzSy5NNFxN2xkZdXomAOP8EmTWnFchxL+d5MJPKeErToOG4ZosRtPO3bPo0omnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722811862; c=relaxed/simple;
	bh=kr7KdbGbdyjDWogmI5Rj4lRL6azQU4Kh2dQJnVEJobo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8zjDGlaxSzXWF2LEjnbHD3c5632YN+aQ2tzrYTx5C8tsYOedDEDLpwVj4nYh9LTQ+gUgNgyUrtfOW7AWrtxCDtsnh8RKyEl8Lv2tQ/WKPjVx4zZDRSEizHY4bc4MbuD5C60520sPQDQYhiJHDmmf2PZwzWY4eu0GMkB0WQyfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.90] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id ajlcsFI3xUO4kajlcsAEzD; Sun, 04 Aug 2024 15:31:57 -0700
X-CMAE-Analysis: v=2.4 cv=N9DiFH9B c=1 sm=1 tr=0 ts=66b0015d
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=NqGczTKSS6nHx0CtAX0A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <023b6204-ad41-42e8-ad24-6d704ef3cd6c@squashfs.org.uk>
Date: Sun, 4 Aug 2024 23:31:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Lizhi Xu <lizhi.xu@windriver.com>, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 squashfs-devel@lists.sourceforge.net,
 syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20240803040729.1677477-1-lizhi.xu@windriver.com>
 <20240803074349.3599957-1-lizhi.xu@windriver.com>
 <ee839d00-fd42-4b69-951d-8571140c077b@squashfs.org.uk>
 <20240804212034.GE5334@ZenIV>
Content-Language: en-GB
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20240804212034.GE5334@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKzl8G1K/ysKowjA1ifGdmiWVl2kBb9Ya4CQnUnSJ0U+Hgi9QSfjGMRUy6YGPPgBuj3/Y3KrNtg5ao0AhGYr1bdTcNfXPH4yLLvYtm7Ri2I0VeMTHHsN
 iNZ2uCaU1iHtiBBCmU/sDR9Ft26t+w5yLQBplFhLwVnxNc+x5LEHTcqXo7RcQdOhq6W3OUt+DBiEOYeHSoxO+L27hyfufEpMYhlRBBpdzsQsXOcgNmYgIVB/
 LrC4IUP2Iq4G2gk2+1LEpWpttW5+EFnHsbayhk0bZEsK611DuiwQas/eI4j3AleN33MV1mAsSUy53JxH75ZGpmM5gf8XKdNgheoucGO2H7XG8WNXbB/dHVUM
 Bz/PWefBkZHdtlfnVMN1IRCuWbQhPN1ixX3qtr2r5ByNk9e1D9qOlkLkoBkLoEvhWFy8LH6ccGYN3ZR6ArQY6CfWp1SCeKkwE/8tv1kWKIF36THbFqr3N0Ro
 BjQM6W2niCyzDiofufhXikNrmZo0ShP6w2PlTc6j3u9Tf66rmVp4Mi6L1YwpMNnfgK/aq1BTKVLeBqMc

On 04/08/2024 22:20, Al Viro wrote:
> On Sun, Aug 04, 2024 at 10:16:05PM +0100, Phillip Lougher wrote:
> 
>> NACK. I see no reason to introduce an intermediate variable here.
>>
>> Please do what Al Viro suggested.
> 
> Alternatively, just check ->i_size after assignment.  loff_t is
> always a 64bit signed; le32_to_cpu() returns 32bit unsigned.
> Conversion from u32 to s64 is always going to yield a non-negative
> result; comparison with PAGE_SIZE is all you need there.

I'm happy with that as well.

Thanks

Phillip

