Return-Path: <linux-fsdevel+bounces-70185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD3AC9315B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 21:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C273A5634
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705E2D877B;
	Fri, 28 Nov 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SP0bjic/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74926C3BE;
	Fri, 28 Nov 2025 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360657; cv=none; b=D6C7BM5/bfkvkqaCBGcR9X2S1CrP91ixisuhzpj8wPizTyRygJzRfd9qkmN3ZTYRCaaGGJOVlY7uFPk1AXiTyKc5RJK7Abilyga959eOaabqLoyFl/UdIpv0ZXFPN1jkCZ4MnjMfara7kOciKsRr0fdOJm4rCrvowP3lDeUhDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360657; c=relaxed/simple;
	bh=auN1a84JRWxnB1XNBU4HMzIcpeIgKu83yBI/s/DSmQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoD1klHhwlSvK2Mjioy+Dgwl9kHCE862PKB4E9sj+qYYEovCA+YSJT6Ta/YzhyDWnL9rYmXNPE4skVi92lr5pUwnxDTQmPuUh9d3QtwCZ3JrJh0C6K2o8A7h3eJJCcfnpCLxsyylA2+OYYXoN0XOnqxLDeuyc3E+/l0J2OVnIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SP0bjic/; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764360651; x=1764965451; i=quwenruo.btrfs@gmx.com;
	bh=jIpEfNH3taQKpiKQry7eq3zQsUELBM1PYw8yuPuCLdc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SP0bjic/OTBcxGHIIaBl0jAX3BzyGElCXmr8traWyP52jyhQL/sWdKu/WCvHObcV
	 dXN21+dp35agtcY7CV3OYk9PCpdiEfYuEnC/6dPdKvNBpif9/25D4B1pL2od7Gidf
	 IX1VWWuzqt1l0inpkQOnCQQufqapKuE63bM1zfBDIzaZ0ILVKN2IpzS/Bz5mb03EK
	 nP6W5bvQpksXmlIJVrPaK/5AbUuOFWyTL5gf63TQ4UCvlIHq1ZSzpVkIZgs5d8cbw
	 pKClm+SmoQFJvjfWMb69W/jG3a+ej//NDl7AxylF0dE9qZmSKJN5kr12V4jARavvd
	 65+4n1GxMkWlhcrFCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhhX-1vH8rF3fdf-009zOH; Fri, 28
 Nov 2025 21:10:51 +0100
Message-ID: <45e8a40a-635e-462e-9f83-9210a5961e1b@gmx.com>
Date: Sat, 29 Nov 2025 06:40:45 +1030
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
In-Reply-To: <f7e56d56-014f-4027-ab9d-d602c5e67137@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETbg+pype72rvgk+ijkooCwVjYrbbtDJ1fRSYlhAG1VId7wggNx
 B2wsmkUmp0YoNvgInFxyN2/GM6r5xNravBCuTF2Q4IcmMDKBqz7y+UdUkQWOy5BOy1+Saro
 Nv91q+ZiRsa3L+QKHOXddPUx5qZ6refxlp8HEybc1GKNOJuk7ehcT6pv+XcOmePOY9MVOw7
 LaOrOS31XoluO5S9mJDZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XQmJ38LFN6U=;SwrIbl+9Ucb1CfYRbMFUsK9T+hF
 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
 7JuwhP6M=



=E5=9C=A8 2025/11/29 06:19, Goffredo Baroncelli =E5=86=99=E9=81=93:
> On 28/11/2025 04.07, Qu Wenruo wrote:
>> Hi,
>>
>> With the recent bs > ps support for btrfs, I'm wondering if it's=20
>> possible to experiment some RAIDZ-like solutions to solve RAID56=20
>> write-holes problems (at least for data COW cases) without traditional=
=20
>> journal.
>=20
> More than a RAIDZ-like solution (=3D=3D a variable stripe size), it seem=
s=20
> that you want to use a stripe width equal to the fs block size. So you=
=20
> can avoid the RWM cycles inside a stripe. It is an interesting idea,=20
> with a little development cost, which may work quite well when the=20
> number of disks * ps matches the fs bs.
>=20
> In order to reduce some downside, I suggests to use a "per chunk" fs-bs
>=20
>>
>> Currently my idea looks like this:
>>
>> - Fixed and much smaller stripe data length
>> =C2=A0=C2=A0 Currently the data stripe length is fixed for all btrfs RA=
ID profiles,
>> =C2=A0=C2=A0 64K.
>>
>> =C2=A0=C2=A0 But will change to 4K (minimal and default) for RAIDZ chun=
ks.
>>
>> - Force a larger than 4K fs block size (or data io size)
>> =C2=A0=C2=A0 And that fs block size will determine how many devices we =
can use for
>> =C2=A0=C2=A0 a RAIDZ chunk.
>>
>> =C2=A0=C2=A0 E.g. with 32K fs block size, and 4K stripe length, we can =
use 8
>> =C2=A0=C2=A0 devices for data, +1 for parity.
>> =C2=A0=C2=A0 But this also means, one has to have at least 9 devices to=
 maintain
>> =C2=A0=C2=A0 the this scheme with 4K stripe length.
>> =C2=A0=C2=A0 (More is fine, less is not possible)
>>
>>
>> But there are still some uncertainty that I hope to get some feedback=
=20
>> before starting coding on this.
>>
>> - Conflicts with raid-stripe-tree and no zoned support
>> =C2=A0=C2=A0 I know WDC is working on raid-stripe-tree feature, which w=
ill support
>> =C2=A0=C2=A0 all profiles including RAID56 for data on zoned devices.
>>
>> =C2=A0=C2=A0 And the feature can be used without zoned device.
>>
>> =C2=A0=C2=A0 Although there is never RAID56 support implemented so far.
>>
>> =C2=A0=C2=A0 Would raid-stripe-tree conflicts with this new RAIDZ idea,=
 or it's
>> =C2=A0=C2=A0 better just wait for raid-stripe-tree?
>>
>> - Performance
>> =C2=A0=C2=A0 If our stripe length is 4K it means one fs block will be s=
plit into
>> =C2=A0=C2=A0 4K writes into each device.
>>
>> =C2=A0=C2=A0 The initial sequential write will be split into a lot of 4=
K sized
>> =C2=A0=C2=A0 random writes into the real disks.
>>
>> =C2=A0=C2=A0 Not sure how much performance impact it will have, maybe i=
t can be
>> =C2=A0=C2=A0 solved with proper blk plug?
>>
>> - Larger fs block size or larger IO size
>> =C2=A0=C2=A0 If the fs block size is larger than the 4K stripe length, =
it means
>> =C2=A0=C2=A0 the data checksum is calulated for the whole fs block, and=
 it will
>> =C2=A0=C2=A0 make rebuild much harder.
>>
>> =C2=A0=C2=A0 E.g. fs block size is 16K, stripe length is 4K, and have 4=
 data
>> =C2=A0=C2=A0 stripes and 1 parity stripe.
>>
>> =C2=A0=C2=A0 If one data stripe is corrupted, the checksum will mismatc=
h for the
>> =C2=A0=C2=A0 whole 16K, but we don't know which 4K is corrupted, thus h=
as to try
>> =C2=A0=C2=A0 4 times to get a correct rebuild result.
>>
>> =C2=A0=C2=A0 Apply this to a whole disk, then rebuild will take forever=
...
>=20
> I am not sure about that: the checksum failure should be an exception.
> A disk failure is more common. But it this case, the parity should be=20
> enough
> to rebuild correctly the data and in the most case the checksum will be=
=20
> correct.

Well, there will definitely be some crazy corner cases jumping out of=20
the bush, like someone just copy a super block into a completely blank=20
disk, and let btrfs try to rebuild it.

And not to mention RAID6...

>=20
>>
>> =C2=A0=C2=A0 But this only requires extra rebuild mechanism for RAID ch=
unks.
>>
>>
>> =C2=A0=C2=A0 The other solution is to introduce another size limit, may=
be something
>> =C2=A0=C2=A0 like data_io_size, and for example using 16K data_io_size,=
 and still
>> =C2=A0=C2=A0 4K fs block size, with the same 4K stripe length.
>>
>> =C2=A0=C2=A0 So that every writes will be aligned to that 16K (a single=
 4K write
>> =C2=A0=C2=A0 will dirty the whole 16K range). And checksum will be calc=
ulated for
>> =C2=A0=C2=A0 each 4K block.
>>
>> =C2=A0=C2=A0 Then reading the 16K we verify every 4K block, and can det=
ect which
>> =C2=A0=C2=A0 block is corrupted and just repair that block.
>>
>> =C2=A0=C2=A0 The cost will be the extra space spent saving 4x data chec=
ksum, and
>> =C2=A0=C2=A0 the extra data_io_size related code.
>=20
> I am not sure about the assumption that the BS must be equal to=20
> 4k*(ndisk-1).
>=20
> This is an upper limit, but you could have different mapping. E.g.=20
> another valid
> example is having BS=3D4k*(ndisk/2-2). But I think that even more strang=
e=20
> arrangement
> can be done, like:
>  =C2=A0=C2=A0=C2=A0=C2=A0ndisk =3D 7
>  =C2=A0=C2=A0=C2=A0=C2=A0BS=3D4k*3

At least for btrfs block size must be power of 2, and the whole fs must=20
follow the same block size.
So 12K block size is not going to exist.

We can slightly adjust the stripe length of each chunk, but I tend to=20
not do so until I got an RFC version.

>=20
> so the 2nd stripe is in two different rows:
>=20
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 D1=C2=A0=C2=A0=C2=A0=C2=A0 D2=C2=A0=C2=A0=C2=A0=C2=A0 D2=C2=A0=C2=A0=
=C2=A0=C2=A0 D4=C2=A0=C2=A0=C2=A0=C2=A0 D5=C2=A0=C2=A0=C2=A0=C2=A0 D6=C2=
=A0=C2=A0=C2=A0=C2=A0 D7
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ------ ---=
=2D-- ------ ------ ------ ------ ------
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 B1=C2=A0=C2=A0=C2=A0=C2=A0 B1=C2=A0=C2=A0=C2=A0=C2=A0 B1=C2=A0=C2=A0=
=C2=A0=C2=A0 P1=C2=A0=C2=A0=C2=A0=C2=A0 B2=C2=A0=C2=A0=C2=A0=C2=A0 B2=C2=
=A0=C2=A0=C2=A0=C2=A0 B2
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 P2=C2=A0=C2=A0=C2=A0=C2=A0 B3 ....
>=20
> What you really need is that:
> 1) bs=3Dstripe width <=3D (ndisk - parity-level)* 4k
> 2) each bs is never updated in the middle (which would create a new RWM=
=20
> cycle)
>=20
>>
>>
>> - Way more rigid device number requirement
>> =C2=A0=C2=A0 Everything must be decided at mkfs time, the stripe length=
, fs block
>> =C2=A0=C2=A0 size/data io size, and number of devices.
>=20
> As wrote above, I suggests to use a "per chunk" fs-bs

As mentioned, bs must be per-fs, or writes can not be ensured to be bs=20
aligned.

Thanks,
Qu

>=20
>> =C2=A0=C2=A0 Sure one can still add more devices than required, but it =
will just
>> =C2=A0=C2=A0 behave like more disks with RAID1.
>> =C2=A0=C2=A0 Each RAIDZ chunk will have fixed amount of devices.
>>
>> =C2=A0=C2=A0 And furthermore, one can no longer remove devices below th=
e minimal
>> =C2=A0=C2=A0 amount required by the RAIDZ chunks.
>> =C2=A0=C2=A0 If going with 16K blocksize/data io size, 4K stripe length=
, then it
>> =C2=A0=C2=A0 will always require 5 disks for RAIDZ1.
>> =C2=A0=C2=A0 Unless the end user gets rid of all RAIDZ chunks (e.g. con=
vert
>> =C2=A0=C2=A0 to regular RAID1* or even SINGLE).
>>
>> - Larger fs block size/data io size means higher write amplification
>> =C2=A0=C2=A0 That's the most obvious part, and may be less obvious high=
er memory
>> =C2=A0=C2=A0 pressure, and btrfs is already pretty bad at write-amplifi=
cation.
>>
>=20
> This is true, but you avoid the RWM cycle which is also expensive.
>=20
>> =C2=A0=C2=A0 Currently page cache is relying on larger folios to handle=
 those
>> =C2=A0=C2=A0 bs > ps cases, requiring more contigous physical memory sp=
ace.
>>
>> =C2=A0=C2=A0 And this limit will not go away even the end user choose t=
o get
>> =C2=A0=C2=A0 rid of all RAIDZ chunks.
>>
>>
>> So any feedback is appreciated, no matter from end users, or even ZFS=
=20
>> developers who invented RAIDZ in the first place.
>>
>> Thanks,
>> Qu
>>
>=20
> Let me to add a "my" proposal (which is completely unrelated to your=20
> one :-)
>=20
>=20
> Assumptions:
>=20
> - an extent is never update (true for BTRFS)
> - in the example below it is showed a raid5 case; but it can be easily=
=20
> extend for higher redundancy level
>=20
> Nomenclature:
> - N =3D disks count
> - stride =3D number of consecutive block in a disk, before jumping to=20
> other disks
> - stripe =3D stride * (N - 1)=C2=A0=C2=A0 # -1 is for raid5, -2 in case =
of raid6 ...
>=20
> Idea design:
>=20
> - the redundancy is put inside the extent (and not below). Think it like=
=20
> a new kind of compression.
>=20
> - a new chunk type is created composed by a sequence of blocks (4k ?)=20
> spread on the disks, where the 1st block is disk1 - offeset 0,=C2=A0 2nd=
=20
> block is disk2 - offset 0 .... Nth block is disk N, offset 0, (N+1)th=20
> block is placed at disk1, offset +4K.... Like raid 0 with stride 4k.
>=20
> - option #1 (simpler)
>=20
>  =C2=A0=C2=A0=C2=A0 - when an extent is created, every (N-1) blocks a pa=
rity block is=20
> stored; if the extent is shorter than N-1, a parity block is attached at=
=20
> its end;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 D1=C2=A0=C2=A0=C2=A0=C2=A0 D2=C2=A0=C2=A0=C2=A0=C2=A0 D2=C2=A0=C2=A0=
=C2=A0=C2=A0 D4
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ------ ---=
=2D-- ------ ------
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E1,0=
=C2=A0=C2=A0 E1,1=C2=A0=C2=A0 P1,0=C2=A0=C2=A0 E2,0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E2,1=
=C2=A0=C2=A0 E2,2=C2=A0=C2=A0 P2,1=C2=A0=C2=A0 E2,3
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E2,4=
=C2=A0=C2=A0 P2,1=C2=A0=C2=A0 E3,0=C2=A0=C2=A0 E3,1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E3,2=
=C2=A0=C2=A0 P3,0=C2=A0=C2=A0 E3,3=C2=A0=C2=A0 E3,4
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E3,5=
=C2=A0=C2=A0 P3,1=C2=A0=C2=A0 E3,6=C2=A0=C2=A0 E3,7
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E3,8=
=C2=A0=C2=A0 P3,2=C2=A0=C2=A0 E3,9=C2=A0=C2=A0 E3,10
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P3,3
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Dz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
isk #z
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ex,y=C2=A0=C2=A0=C2=A0 Extent x, o=
ffset y
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Px,y=C2=A0=C2=A0=C2=A0 Parity, ext=
ent x, range [y*N...y*N+N-1]
>=20
>=20
> - option #2 (more complex)
>=20
>  =C2=A0=C2=A0=C2=A0 - like above when an extent is created, every (N-1) =
blocks a parity=20
> block is stored; if the extent is shorter than N-1, a parity block is=20
> attached at its end;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The idea is that if an extent spans more=
 than a rows, the logical=20
> block can be arranged so the stride may be longer (comparable with the=
=20
> number of the rows).
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In this way you can write more *consecut=
ive* 4K block a time=20
> (when enough data to write is available). In this case is crucial the=20
> delayed block allocation.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See E2,{0,1} and E3,{0,3},E3,{4,7}, E3,{=
8,10}....
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 D1=C2=A0=C2=A0=C2=A0=C2=A0 D2=C2=A0=C2=A0=C2=A0=C2=A0 D2=C2=A0=C2=A0=
=C2=A0=C2=A0 D4
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ------ ---=
=2D-- ------ ------
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E1,0=
=C2=A0=C2=A0 E1,1=C2=A0=C2=A0 P1,0=C2=A0=C2=A0 E2,0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E2,1=
=C2=A0=C2=A0 E2,3=C2=A0=C2=A0 P2,1=C2=A0=C2=A0 E2,4
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E2,2=
=C2=A0=C2=A0 P2,1=C2=A0=C2=A0 E3,0=C2=A0=C2=A0 E3,4
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E3,8=
=C2=A0=C2=A0 P3,0=C2=A0=C2=A0 E3,1=C2=A0=C2=A0 E3,5
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E3,9=
=C2=A0=C2=A0 P3,1=C2=A0=C2=A0 E3,2=C2=A0=C2=A0 E3,6
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E3,1=
0=C2=A0 P3,2=C2=A0=C2=A0 E3,3=C2=A0=C2=A0 E3,7
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P3,3
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Dz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
isk #z
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ex,y=C2=A0=C2=A0=C2=A0 Extent x, o=
ffset y
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Px,y=C2=A0=C2=A0=C2=A0 Parity, ext=
ent x, range row related
>=20
>=20
>=20
> Pros:
> - no update in the middle of a stripe with so no RWM cycles anymore
> - (option 2 only), in case a large write, consecutive blocks can be=20
> arranged in the same disk
> - each block can have its checksum
> - each stripe can have different raid level
> - maximum flexibility to change the number of disks
>=20
> Cons:
> - the scrub logic must be totally redesigned
> - the map logical block <-> physical block in option#1 is not complex to=
=20
> compute. However in option#2 it will be ... funny to find a good algorit=
hm.
> - the ratio data-blocks/parity-blocks may be very inefficient for small=
=20
> write.
> - moving an extent between different block groups with different number=
=20
> of disks, would cause to reallocate the parity blocks inside the extent
>=20
> Best
> G.Baroncelli
>=20


