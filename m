Return-Path: <linux-fsdevel+bounces-24639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4B94221E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 23:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC682867D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C818E036;
	Tue, 30 Jul 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OBnTT4zx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B118C914;
	Tue, 30 Jul 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374358; cv=none; b=kOk0t4tbXqEdJSbUcJcbJGSM4GG/P4XVtARDBm2vrSLh2pZO0e7pnkXhXlrZ7HULvwGf80pOCj5LPEZiG8OWJRQJ/jCqkvmTnWHfr8JWvBoWK2FMrMUWMRFcagJVcUvVRcv2cb54hSF1rSzdtmlGNQsNLPQDnv+IYmAbJxEUoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374358; c=relaxed/simple;
	bh=3dskeMJT5cgmy/vQcw0aHiWe8vgBLpbEb5lodlovNuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdRtABZPlWECAjwhJJpyMGtb3XxamjokO0L+uXPBG9+vK+TBY+vAEz2xHcvn1seqxODjzXwntAi5H1r3ICGN6Y0Pk07D3EQZEgRw/T5/qQsHTVdD4BS3d7DTCtb9LcU3u2byOUG0FtIp3Pbsr6x6hoQV+SOZ3YyyFihvRdS7/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OBnTT4zx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722374341; x=1722979141; i=quwenruo.btrfs@gmx.com;
	bh=1tZkrCQj/8N6EM1a5ULIFKWfa+O4mm26vhEWtFZrC14=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OBnTT4zx+tbJPaampN9JZ+eTEZ50DonVwPLPhnTeWjGG3oeGvqSwtILAtbzeaFOV
	 io2x4ugdedi5BT6syuXDptCA4Mzwh0P2T4AJBoBuZi05e2Y+i00T82b6oozhHOJnF
	 17wX5OsTHBsofT8RgVhh/0oVjPp6AzSpnAEpDoCOpopobDfMXxvZ4SeQTIr2k6ML8
	 vh/6tx3OeMPz6lUU0H/QT9IW5O4puBk7G/nbCbiO755pGlxSe3/JtNOZ4Z1mRY06m
	 yPpcCGbUyTt//auvKibbSp8uFbO31DgiDoZ0FI71u3yUthHCeo3tiO0ZIApV0iK2x
	 dwnCNy+IdrHvm698iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulmF-1sHeZq0kbL-00zft2; Tue, 30
 Jul 2024 23:19:01 +0200
Message-ID: <2f6a2670-cf09-4750-9578-9198eea8dff6@gmx.com>
Date: Wed, 31 Jul 2024 06:48:57 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Forcing vmscan to drop more (related) pages?
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <7e68a0b2-0bee-4562-a29f-4dd7d8713cd9@gmx.com>
 <ZqkMq9Id43s-V_Sf@casper.infradead.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZqkMq9Id43s-V_Sf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eo9WSU/yOw0JuSavAvDPE4x5fB6Fg02TIaXegnCI5TQP2v+O/A0
 KioBmAyK3dtYwpXYA+lyYHSlBmktWPYrZGz7eRavfaMRZmMNeUgQUtfQ2Q4K1l4xGzz8gkV
 MER3VFY/uWYLfS76QrVq+1umHMqewxbIbngg7KbyOMTj2GBhv97LRp6QqzQq/drJp/KkO1w
 jrAXWGAqkNcvH/XkVsdRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VxWnu4AUxO0=;ZGTR7d65lueURPRG/By7dmFN6ty
 elQPMrx9KR4QiuzDN8GYpN8nQOIXfzeZ2gn1J7Lzid+MFXunCPl0tHEUiAgLZDZ62AEauOBKp
 eHBcLwY3IZegzrmXxocv7fP+kZakdI5Jiek+jUvdqJgIqrLIIWmX4rRyVtnDE7DdOKbhBAmij
 nlUyCOU4tacZftTn/QEDUo+5ShxRKJ0HORMLAn97bZIwpSyi3gIRBMosi37shMVkzqxxE9Umn
 qodOgsDQTHC9jXTYvek0gNHPrMcqCprjB7LadOEeVovKYptR+amoCRBrcMgfWP3NDXcMP7iUu
 2dTbMNVbreOtLjcs7h8RuaKqJQygL/wg2xHH9GamZtbp+ybfnTftWZOjCiWfy5XFsAHsBJYcU
 McXpXibhOGz9OCoHJwF7YX+boeB1mcwTgn873d0LgpqTg/w+2hidqClwf40lPcWXojfDZraKT
 8yCGx2oQ4nBshNO7tpv1GSfmyBmcfnK75HwP8oBStT0XnyDFhshoRhdLpRuM1CWH1nkLOQX4M
 7WH9F4iEl+jLTE9O0cMxweUM3MxGmJ6m420PxYLfESQdqNn8wwb9MaTYwRl0SHB71chGGYIOu
 a8ZTukQmaDhIouKM2B1Gdn8Z4KMiJE+C6JiR546qwHfRzHIGN80RYcy3rBeXUYM0tctOecVu5
 C+7ZjEYCAWjznluIrBb5eJkLrJ4vi1RmtLdMl/wE9TMlaFbpHzTXgsAztZIW+UwgcgA0XINN+
 70ztZEBXg0QqDdXPsmMXrqS8dpHfmy9qE0Js27YAxzXzxWOllc6CXSG4EBDIPWMyr+PB19hrk
 abiF8aHsKac4dUaFR37ypo7g==



=E5=9C=A8 2024/7/31 01:24, Matthew Wilcox =E5=86=99=E9=81=93:
> On Tue, Jul 30, 2024 at 03:35:31PM +0930, Qu Wenruo wrote:
>> Hi,
>>
>> With recent btrfs attempt to utilize larger folios (for its metadata), =
I
>> am hitting a case like this:
>>
>> - Btrfs allocated an order 2 folio for metadata X
>>
>> - Btrfs tries to add the order 2 folio at filepos X
>>    Then filemap_add_folio() returns -EEXIST for filepos X.
>>
>> - Btrfs tries to grab the existing metadata
>>    Then filemap_lock_folio() returns -ENOENT for filepos X.
>>
>> The above case can have two causes:
>>
>> a) The folio at filepos X is released between add and lock
>>     This is pretty rare, but still possible
>>
>> b) Some folios exist at range [X+4K, X+16K)
>>     In my observation, this is way more common than case a).
>>
>> Case b) can be caused by the following situation:
>>
>> - There is an extent buffer at filepos X
>>    And it is consisted of 4 order 0 folios.
>>
>> - vmscan wants to free folio at filepos X
>>    It calls into the btrfs callback, btree_release_folio().
>>    And btrfs did all the checks, release the metadata.
>>
>>    Now all the 4 folios at file pos [X, X+16K) have their private
>>    flags cleared.
>>
>> - vmscan freed folio at filepos X
>>    However the remaining 3 folios X+4K, X+8K, X+12K are still attached
>>    to the filemap, and in theory we should free all 4 folios in one go.
>>
>>    And later cause the conflicts with the larger folio we want to inser=
t.
>>
>> I'm wondering if there is anyway to make sure we can release all
>> involved folios in one go?
>> I guess it will need a new callback, and return a list of folios to be
>> released?
>
> I feel like we're missing a few pieces of this puzzle:
>
>   - Why did btrfs decide to create four order-0 folios in the first
>     place?

Maybe the larger folio allocation failed (we go with __GFP_NORETRY |
__GFP_NOWARN for larger folio allocation), thus it falls back to order 0
directly.

>   - Why isn't there an EEXIST fallback from order-2 to order-1 to order-=
0
>     folios?

Mostly related to the cross folio handling.

We have existing code to handle multiple order 0 folios, but that's all.
For one single order 2 folio, it's also pretty easy to handle as it
covers the full metadata range.

If we go support other orders, we need to handle mixed orders instead,
which doesn't bring much benefit.

So here we only support order 0, or order 2 (for 16K nodesize).
And that's why we're not using __filemap_get_folio() with FGP_CREATE to
allocate the filemap folios.

Maybe it's better to use a bitmap for allowed orders for FGP_CREATE instea=
d?
As for certain future use cases (e.g. fs supporting blocksize larger
than page size), we will require a minimal folio size anyway and falling
below that is not acceptable.

>
> But there's no need for a new API.  You can remove folios from the page
> cache whenever you like.  See delete_from_page_cache_batch() as an
> example.

So you mean to manually truncate the other pages, inside the
release_folio() callback?

That sounds feasible, and let me experiment with that solution.

Thanks,
Qu

