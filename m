Return-Path: <linux-fsdevel+bounces-63918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B75BD1BC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 551473483C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A502E7F17;
	Mon, 13 Oct 2025 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KfpAAC8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3142E0923;
	Mon, 13 Oct 2025 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339194; cv=none; b=btfpHNaPNBvFHnPtA7aLdtkLqZS0CB2KFUDNgMJoF+xxcU6kOHrQhRREwihgOeTIcqLwMynB4xislpdWXmBPkM85cmUFtmjM2hWpJ2UyVdQGNcDRdc5oDQtxUsBEDs7G/QyRIXIyzq6cVBYtuCGS/WcKOdnDQyVvwD5DyKxSZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339194; c=relaxed/simple;
	bh=w7f+aKyLrwRQjIYVIPNz67dvwy7i2Du3KIPycAZ2YRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUEQKgPflI+tCtiqrvP0azA0uGefYKckZdJWisKA1CQoD2KWcUdLwN0mml5ps+FJT+8rMXFETWaQkA0YD5zPo9kv7bfmqeGnPAXkakp6A1EYDAfIVj4ZWPta73y3qhgfcLgM30EGY7fhhnpwPWltB94fAKo59LSJEx8mNjsz4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KfpAAC8J; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760339189; x=1760943989; i=quwenruo.btrfs@gmx.com;
	bh=l/VqGTZZE3wrs+COPAImkDmUm9RnAANz15WjcvaO2/4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KfpAAC8JvP0059dmrGLP+FNiEBHEnV3T3od0oyI8Vycb6cew4nDbcGSpZpTOBY+b
	 KQHr7CzRAtun2BQqekd6XsLcyHnLB0HYvUqL7P+TdqrR/eqIS908fbFO8adMfKS6H
	 WrV2F/zQ94Fvt0C2WMmEcVgnHl+wwtXWeTjjPiWPIcHWNQE/dBhX1Y9o4IKGhOLmF
	 HEAjiH6XBKiRYY8ufU1F5Pu0PlTPeyOkJIt3O9uJ+cplIBlOrY+PRv3MJf76QAsjZ
	 4NMt0KfC3eexyg+kmqm67G22nIOhYh8qR2RZ7spAaTJueU2UZn+DgzfYAlCZEEwci
	 hd/njyu3n8D+0nDdlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V4J-1u62G20aUR-00vKCq; Mon, 13
 Oct 2025 09:06:29 +0200
Message-ID: <595ea9e3-0f3a-4aa3-8915-de10e3085a8b@gmx.com>
Date: Mon, 13 Oct 2025 17:36:25 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: add IOMAP_DIO_ALIGNED flag for btrfs
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <5dbcc1d717c1f8a6ed85da4768306efb0073ff78.1760335677.git.wqu@suse.com>
 <aOydN1rIsWiNo4m6@infradead.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <aOydN1rIsWiNo4m6@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U/FaAQkZJlsQz/G/FFDL3BLy/ryqbc1UJPBSFI4i3mvEDhOtTtP
 vnWnmsZysQFmzk/Fs+TYzr4+PB5WupuaE6txx4KTxS+LYCHxxxmxC7yrLgbA6UDjPUYDXMq
 ciW6fO7hP5wZfTR6a26HeOqs9ui1bqW1W7Vdxcn2wZEiD/CKB/GpDhbDiFGlK05J6TB06oe
 5wQj4Kv9VhyUfcwP+ruxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rpq0I6hoFdo=;0Nw5zpU8D4PrZKjOhN+G7bxy3Zf
 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



=E5=9C=A8 2025/10/13 17:03, Christoph Hellwig =E5=86=99=E9=81=93:
> On Mon, Oct 13, 2025 at 04:38:40PM +1030, Qu Wenruo wrote:
>> For now only btrfs will utilize this flag, as btrfs needs to calculate
>> checksum for direct read.
>=20
> Maybe reword this as:
>=20
> The initial user of this flag is btrfs, whichs needs to calculate
> the checksum for direct read and thus requires the biovec to be
> file system block size aligned?
>=20
>> index 802d4dbe5b38..15aff186642d 100644
>> --- a/fs/btrfs/direct-io.c
>> +++ b/fs/btrfs/direct-io.c
>=20
> Please split the patch to use the flag in btrfs from the one adding
> the the flag to iomap.
>=20
>> +	const unsigned int alignment =3D (dio->flags & IOMAP_DIO_ALIGNED) ?
>> +		max(fs_block_size, bdev_logical_block_size(iomap->bdev)) :
>> +		bdev_logical_block_size(iomap->bdev);
>=20
> Please unwind this into an if/else to be easily readable.  Also a
> comment on why you still need the max when the flag is set would be
> useful.

The max part is mostly to be future proof, in case the bdev block size=20
is larger than fs block size.
And in that case, aligning to the larger value will make everyone (block=
=20
layer and fs layer) happy.

Will add the comment on this.

>=20
>> +		ret =3D bio_iov_iter_get_pages(bio, dio->submit.iter, alignment - 1)=
;
>=20
> Please avoid overly long lines in the iomap code.

I'm not sure if this line (83 chars) counts as long lines.
As the recent patchchecker will only report lines over 100 chars as long.

But sure, if iomap still follows the old 80 chars limit, I'm completely=20
fine to follow.

Thanks,
Qu

>=20
>> +/*
>> + * Ensure each bio is aligned to fs block size.
>> + *
>> + * For filesystems which need to calculate/verify data checksum for ea=
ch data bio.
>=20
> Another overly long line here.
>=20
>> + */
>> +#define IOMAP_DIO_ALIGNED		(1 << 3)
>=20
> Maybe call the flag IOMAP_DIO_FSBLOCK_ALIGNED to make it clear
> what alignment is implied by the flag.
>=20


