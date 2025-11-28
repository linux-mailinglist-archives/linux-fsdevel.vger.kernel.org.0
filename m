Return-Path: <linux-fsdevel+bounces-70187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E20DC931DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 21:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6C6F34CE8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DF82D6E67;
	Fri, 28 Nov 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Um0F/fga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCE25F7A9;
	Fri, 28 Nov 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764361818; cv=none; b=Xewvk2NXWaqTxnzkvRHhYz6xS3e+x3v1i2bECXJ1e8QPCorCNlv4SEgAag0REKgFau05q0yNhLzIFbPMm9KERVpPW9Ec+uzk8MZEe6KJAbu+xi8YxJMkrkTmUni67758bYsOkZ3nmxrf30z9x8TiaV0t/DOIO3gwtF9lU91iNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764361818; c=relaxed/simple;
	bh=sugWLgJEvhax4QBMAzH8zN6P2WNpE7OeQ7CDLzg8bq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Woql4c5GvgK0YYnp4tYmB0mgwzPeZr5jsqEC4jMmnwLUs2tnd2hA3/iez7MRw9di5z+imhlMtOPSRg1f75g4PsZ9y4CEzI+r5267trGE4vfej1ijv+GL+p9SUkQYWHbfmX391q8EkTzlIwUZ7sffZYGRpTQNQ8ImAC0hFWRpFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Um0F/fga; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764361811; x=1764966611; i=quwenruo.btrfs@gmx.com;
	bh=sugWLgJEvhax4QBMAzH8zN6P2WNpE7OeQ7CDLzg8bq0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Um0F/fgaMktEOzqp31/gH/vNu9m90dACdS8faWD6KacTn6K6gPDsnAzLSDDQSqEL
	 K4Xp68G09OpKZ8+uQNn3Msz+oS1e7wUrCTHWcq3VPl0+lyfDC/m/7+/CqbnGvowvo
	 Qkgu7NWkuDEaObhuQtJMpMkHU9bS7zV0hYbAQzA7myw86sq2zgRogD5Hz2tRLDowC
	 fWMOOXrR3ihOh84qhF2VyAJjovP0xzlz2njPDwozKzXC/f6jYdYaFjjFhgbF5nGmc
	 Ua7tfCzhiQY4tkGQdDDUSeQYeAt4xNNYHoQkCipDUbRorkD6tHwKG9kL6U7M0nPv+
	 j+LwGzQaLgUQOeAV7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Md6Mt-1vy8o537dD-00ZSis; Fri, 28
 Nov 2025 21:30:11 +0100
Message-ID: <e04e525f-8cc1-42c1-b234-e74e06d91446@gmx.com>
Date: Sat, 29 Nov 2025 07:00:06 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ideas for RAIDZ-like design to solve write-holes, with larger fs
 block size
To: kreijack@inwind.it, Qu Wenruo <wqu@suse.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, zfs-devel@list.zfsonlinux.org
References: <4c0c1d27-957c-4a6f-9397-47ca321b1805@suse.com>
 <f7e56d56-014f-4027-ab9d-d602c5e67137@libero.it>
 <45e8a40a-635e-462e-9f83-9210a5961e1b@gmx.com>
 <466de455-a413-424f-9853-7d7d10abce49@inwind.it>
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
In-Reply-To: <466de455-a413-424f-9853-7d7d10abce49@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oLscAnfmxiqarFmwlIjzMW2oGoT34/nJESPVCu60KpHUBFZByfn
 tsFyOOz0W71w/yhbDZ4KzJTtkioia6gbXG+aJAZZk52ccMiApAEQIbjk5U9MdbWLfeuiFmz
 H9QOmMhdiKYjcby0KA3LHfMPjMND+Ea3XWopBWJxyM8QSGdKvyiEGN/JXPrZ5EWGb0bWaU6
 ivM+xYph+DcYyMU8tSCgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fC5dKIKlN98=;WbR7/FaxGVU7220JIQdpw92DSFC
 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
 UAzTpJwHwg+QQPeYE=



=E5=9C=A8 2025/11/29 06:51, Goffredo Baroncelli =E5=86=99=E9=81=93:
> On 28/11/2025 21.10, Qu Wenruo wrote:
[...]
>>> As wrote above, I suggests to use a "per chunk" fs-bs
>>
>> As mentioned, bs must be per-fs, or writes can not be ensured to be bs=
=20
>> aligned.
>=20
>=20
> Ok.. try to see from another POV: may be that it would be enough that=20
> the allocator=C2=A0 ... allocates space for extent with a specific multi=
ple=20
> of ps ?
> This and the fact that an extent is immutable, should be enough...

Nope, things like relocation can easily break the immutable assumption.

That's why I don't think it's even possible to implement a per-chunk=20
stripe length, as that will make some extent that's totally bs aligned=20
to be not aligned on another chunk.

Thanks,
Qu

