Return-Path: <linux-fsdevel+bounces-58295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC5B2C38E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17091897DD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653DD2C11E9;
	Tue, 19 Aug 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G/lUupuO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB9F305078;
	Tue, 19 Aug 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606219; cv=none; b=J7y0KYb7jDxQVZZpCad3HL6kof+AwZoHo7Fq4doFaIcurWQyn4+YAGzkAqVd0von9IuL8xw7Afc+zKkK6/lYyk7GhfJw/+fvfjSeYGyuOU+45HxrkDK1FeuFVyxN6hsY1hMp2bs0Un76As8eps1af0Sw5DbZwRl1EjwOtw/7MAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606219; c=relaxed/simple;
	bh=1VdulYw8sjVrTvFb45ts8Jy3oKZXFvjBD18XLKm9r1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxy21DuwrpnG8FvUsgh6BR9NNJm4tLD3M0QKDgaawB9tbtj2waG5dlXr3YLUntaJrdyi8aPHw9NzPzTRLPw3vYpqkUOlr2Mah2W1Ex5gGwWW+q/IcQAgKGG1LUUUYG2Wve3H0H8kjtwKKpAiMaN3hWfwwpvQUr5rtg5DDYbc+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G/lUupuO; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=XML5m6XHKtdCDAlB9JUUL64oZubz2drUcUaH/mhajyY=;
	b=G/lUupuOjYUya+gk2UT6VYOhHDLWY9lQWtoMPaL09/X+ucvel+ATwE2MzZRu94
	DiPS/eomMWeBhfB8FVkv79u0B8PNRGtZi/EGmvH6JgQ09AiKmUIj9biZpndji1Ei
	AzdCOGqWGa8NzR2jp6ztNHLm3PmuKT1K+VIYOM/hXisbs=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3v_WSbKRofFI1DA--.58046S2;
	Tue, 19 Aug 2025 20:22:43 +0800 (CST)
Message-ID: <10485bcf-5ccf-4fec-b403-0d895236c131@163.com>
Date: Tue, 19 Aug 2025 20:22:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mpage: terminate read-ahead on read error
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20250812072225.181798-1-chizhiling@163.com>
 <20250817194125.921dd351332677e516cc3b53@linux-foundation.org>
 <9b3116ba-0f68-44bb-9ec9-36871fe6096e@163.com>
 <aKM5sUFuOevaG4_i@casper.infradead.org>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <aKM5sUFuOevaG4_i@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3v_WSbKRofFI1DA--.58046S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrykGFy3WFW8ZF45uF18Grg_yoW3ZFc_uF
	sFkanrGw17Kr4xJanxuan0grn0kw4rWry5Gr48Wrn7t345Zr98Xa1Dur9agFZ8Jw42vrZa
	kFs7WrW3G3sFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU4SotUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBawSunWikZrC5bgAAsR

On 2025/8/18 22:33, Matthew Wilcox wrote:
> On Mon, Aug 18, 2025 at 06:04:23PM +0800, Chi Zhiling wrote:
>>> Also, boy this is old code.  Basically akpm code from pre-git times.
>>> It was quite innovative back then, but everybody who understood it has
>>> since moved on,  got senile or probably died.  Oh well.
>>
>> Actually, I think this patch is safe, but I'm not sure if we should fix this
>> issue. After all, this code has existed for a long time, and it's quite rare
>> to unplug the device during a copy operation :)
> 
> Converting exfat to use iomap would be a valuable piece of work ...

Yes, this is indeed worthwhile, and exFAT should also be restructured to 
support extents rather than fetching entries one by one.

I estimate this would bring significant performance improvements


Thanks,
Chi Zhiling


