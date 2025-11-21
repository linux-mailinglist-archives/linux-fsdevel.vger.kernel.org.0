Return-Path: <linux-fsdevel+bounces-69454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B83C7B71A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 20:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C36FE4E9099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9B2F7AD7;
	Fri, 21 Nov 2025 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hOrNs6oA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDB2EA168;
	Fri, 21 Nov 2025 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752116; cv=none; b=VWGFBEeu0bs3RTY051cCVZ3p2fW3Fr+Yjdj///rlUr9uZxrRdscfLetEAgmIhRnNmqJ1Kr4us92YFQ3XTHE5+eTMJXk2xZ/1ei/RNYoTp8VcfMr2hAJWAHSrL9WdfVCFHD+DgD8GyO/yhi6CYV/jDV3S7n6cpMO6uYIvOAmvhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752116; c=relaxed/simple;
	bh=fcB8SPtmrRE0Wmsx7xlj4KKJwI0TQ7zFnxSYHRiOk3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfkIO1Kbz+Z+kh+F2rMuBRlNe7ygVgqblufhop7I/L8mHM1Uuqy46ahggMCZDCghzt/BpnmOyGlzjXEKgYZDxg26XWzg/A1cPBlZDwtGPkZFXXJZxAsT0eCfbXF8NQah3vQRuETa5myGoar+8TWJ8nKEoesGR3ZUEYa+mJI7rnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hOrNs6oA; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763752112; x=1764356912; i=quwenruo.btrfs@gmx.com;
	bh=fcB8SPtmrRE0Wmsx7xlj4KKJwI0TQ7zFnxSYHRiOk3g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hOrNs6oAOyT/qlAqO6+feFw7GxuLE5UcLB2HgdrS3Czyno1hLiPuT2esbuQDzrzg
	 YMHV0fwrEO3vJCKowyuibnH4GR9/6daDY+WT+icIj+UN49mgMTD4ABPM+AWmA8jYV
	 FM9PPMlI+qTBL9AZhz+HshBMbqbYV8t5qvWLUpuDD8C6xxamjA+9whbztpY8CjfT4
	 +aMdDgqeaonhae7J70YxdK03wf0ICvku6LTBw3Ulx21n8e70UA0htwrlarAnhtJRe
	 D+A0de9Rko9Vg9JuURAGoRAsnxVoOqUeOReLcyO5B+Ji79g+dBsbQ9b0Vjt7vl8tn
	 D3Kh333RW6EtZ+xBig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1vqs9g3uvP-00phQa; Fri, 21
 Nov 2025 20:08:32 +0100
Message-ID: <74cd4139-6795-4611-8649-77626bc25a10@gmx.com>
Date: Sat, 22 Nov 2025 05:38:27 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about encryption and (possibly weak) checksum
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-crypto@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
References: <48a91ada-c413-492f-86a4-483355392d98@suse.com>
 <CAPjX3Ffrs28a6wC3PvtXpPy5Hw9pOmGYqchpg7WRtTwdDo1mgg@mail.gmail.com>
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
In-Reply-To: <CAPjX3Ffrs28a6wC3PvtXpPy5Hw9pOmGYqchpg7WRtTwdDo1mgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:83mBSJumEUyW/i5UDLDbpDCfNEC9PJF8pK8GWDxantkviHCmkin
 r0sdSahxoEqOdE0X9OBAEru6p7x6wVJ1/kWqjKMsI4u6OV9jxM6WcguHuAuu/UJGJ2oCUzL
 CYZgSpGIPfuOp/LpMngMC5T6qWJnBaS298uAM93+VY0NnGzSBEZ7sdyDRtk9zRMDJUh0cU/
 J72xOsfz9mQ93I746FH3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cf1cgWdafUQ=;sbdMzhzwdFP4knZnbYcNcH2wAZ4
 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
 zXuisI/tFzG7qZq6KOfUek8pLrDC9M49F17QML



=E5=9C=A8 2025/11/21 23:32, Daniel Vacek =E5=86=99=E9=81=93:
> On Thu, 20 Nov 2025 at 22:58, Qu Wenruo <wqu@suse.com> wrote:
>> Hi,
>>
>> Recently Daniel is reviving the fscrypt support for btrfs, and one thin=
g
>> caught my attention, related the sequence of encryption and checksum.
>>
>> What is the preferred order between encryption and (possibly weak) chec=
ksum?
>>
>> The original patchset implies checksum-then-encrypt, which follows what
>> ext4 is doing when both verity and fscrypt are involved.
>=20
> If by "the original patchset" you mean the few latest btrfs encryption
> support iterations sent by Josef a couple years back then you may have
> misunderstood the implementation. The design is precisely taking
> checksum of the encrypted data which is exactly the right thing to do.
> And I'm not touching that part at all. You can check it out when I'll
> post the next iteration (or check the v5 on ML archive).

Then you really make me confused.

What's the problem of the existing=20
fscrypt_encrypt_pagecache_blocks()/fscrypt_encryt_pages()?
They don't introduce any limits like the new proposed callback hook,=20
which has limits on the checksum calculation (can not be delayed), can=20
not split bios etc.

And all existing filesystems like f2fs/ext4/ceph are using them fine,=20
and using that interface is completely compatible with any btrfs=20
specific features (read-verification/read-repair/bio split etc).

That idea completely discard the layer separation, and I didn't see any=20
reason why that must to be done in that way.

Thanks,
Qu

>=20
> But I'm happy you care :-)
>=20
> --nX
>=20
>> But on the other hand, btrfs' default checksum (CRC32C) is definitely
>> not a cryptography level HMAC, it's mostly for btrfs to detect incorrec=
t
>> content from the storage and switch to another mirror.
>>
>> Furthermore, for compression, btrfs follows the idea of
>> compress-then-checksum, thus to me the idea of encrypt-then-checksum
>> looks more straightforward, and easier to implement.
>>
>> Finally, the btrfs checksum itself is not encrypted (at least for now),
>> meaning the checksum is exposed for any one to modify as long as they
>> understand how to re-calculate the checksum of the metadata.
>>
>>
>> So my question here is:
>>
>> - Is there any preferred sequence between encryption and checksum?
>>
>> - Will a weak checksum (CRC32C) introduce any extra attack vector?
>>
>> Thanks,
>> Qu
>=20


