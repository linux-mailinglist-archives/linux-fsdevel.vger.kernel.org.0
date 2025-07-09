Return-Path: <linux-fsdevel+bounces-54391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF15AFF336
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D26317B7E62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 20:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB5A245005;
	Wed,  9 Jul 2025 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QfxLRjgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793B202F8F;
	Wed,  9 Jul 2025 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093616; cv=none; b=Uv+g7AyPfk79iybiA4XIz3a5anMqJXMA6JD86P6nSjvVcvfTAEPMBlrXVWy1XbpMUrNkAWOynxNHi2kEXKCNBgHdxMJMFUSSr8PdK9TgHK09GMLBe/7FRrVaBkCfhtOWcMYr9tzZZsHaUTT7nBXkWxlrH06/yklMFYs8Xdj53Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093616; c=relaxed/simple;
	bh=6bCNaAgvFnAoxUXkG51sXFPAF2A8790czG/Stio24hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5AQJFGa9r0YWXG/KJ0M2IhEytQYIPIJSIu6Dl5NhuLBgi3j10FeX+M/DIYOA25oq40OTRk757CkCiUU4GWC3blKo+1iltFeHqXPVBjWKMdT6e/jJVqQKTHaFH4xnoOKlaw2i3K5dNEd4+Sw6lj8EH4NKEKJj/1CdPQduTzR9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QfxLRjgb; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752093611; x=1752698411; i=quwenruo.btrfs@gmx.com;
	bh=7u2SCYDTY11+D5/U+Iljw8ciYu2Uiz0x7huvA6oXWLk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QfxLRjgbeW9fw+ryxzK3IEmk+g/btYHPl5UyumVoUAs5upPG53DzeE/wjjwiSKGb
	 0nUtKC14xBELfzjutFkcFTktfDlF/0/bpjuIcIFH9Tdxs0FAMdKJYGx7pg2XrLnSr
	 TnurZ4S6L/MDVLMoqMFmyu3sjRXSvurVymXBaxNi42DKNuZ4p3I2tcTsw8jqEXrJO
	 gBcsAGkLBKaYTEFXsq8RcOWRlU9m6sWOcc7xGNc/7D/aHTKPeqDmkrQBIQoiIZFfq
	 W1i/GRWJ7td7D0ZrWQNt0pzjLi4AQGcLyyGdligArZ1e6VdO3d6jI2PKWJSSzmXd2
	 bP+aArDPexNtpGyOvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MulqD-1uqifC06F9-00tCD2; Wed, 09
 Jul 2025 22:40:09 +0200
Message-ID: <02bf24f8-c7f1-4f70-8af0-73b9656c00b6@gmx.com>
Date: Thu, 10 Jul 2025 06:10:04 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why a lot of fses are using bdev's page cache to do super block
 read/write?
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Catherine Hoang <catherine.hoang@oracle.com>
References: <5459cd6d-3fdb-4a4e-b5c7-00ef74f17f7d@gmx.com>
 <20250709150436.GG2672029@frogsfrogsfrogs>
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
In-Reply-To: <20250709150436.GG2672029@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q9rIlRXjKpYAgjC74tvIkGsQsrpvVxzXlsF1wqz+4UcDpQihmRo
 3oauzGxaDGcMb1L7KHASr2KCg70fAjRVit8Pg3eDZS26/XONjQ4QrLg9L3Ecfbv5eIzlZ/Y
 1zS0x0s10ipZQPY9u7DfzBaJBqnYNQTXLkbiR5oX9veY1ZHlqrF61kssNJspFap2qGPBKqz
 JfBnHWGUVbglNJIKyI/jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xx+WpaXSmis=;f6jgJDkIMFVbz687wCPHdDzgSxy
 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
 uemXQZNk5j8qoM8cf80FNx4=



=E5=9C=A8 2025/7/10 00:34, Darrick J. Wong =E5=86=99=E9=81=93:
> On Wed, Jul 09, 2025 at 06:35:00PM +0930, Qu Wenruo wrote:
>> Hi,
>>
>> Recently I'm trying to remove direct bdev's page cache usage from btrfs
>> super block IOs.
>>
>> And replace it with common bio interface (mostly with bdev_rw_virt()).
>>
>> However I'm hitting random generic/492 failure where sometimes blkid fa=
iled
>> to detect any useful super block signature of btrfs.
>=20
> Yes, you need to invalidate_bdev() after writing the superblock directly
> to disk via submit_bio.

Since invalidate_bdev() is invaliding the whole page cache of the bdev,=20
it may increase the latency of super block writeback, which may bring=20
unexpected performance change.

All we want is only to ensure the content of folio where our sb is,
so it looks like we're better sticking with the existing bdev page cache=
=20
usage.
Although the btrfs' super block writeback is still doing something out=20
of normal, and will be properly addressed.

Thanks Matthew and Darrick for this detailed explanation,
Qu

>=20
>> This leads more digging, and to my surprise using bdev's page cache to =
do
>> superblock IOs is not an exception, in fact f2fs is doing exactly the s=
ame
>> thing.
>>
>>
>> This makes me wonder:
>>
>> - Should a fs use bdev's page cache directly?
>>    I thought a fs shouldn't do this, and bio interface should be
>>    enough for most if not all cases.
>>
>>    Or am I wrong in the first place?
>=20
> As willy said, most filesystems use the bdev pagecache because then they
> don't have to implement their own (metadata) buffer cache.  The downside
> is that any filesystem that does so must be prepared to handle the
> buffer_head contents changing any time they cycle the bh lock because
> anyone can write to the block device of a mounted fs ala tune2fs.
>=20
> Effectively this means that you have to (a) revalidate the entire buffer
> contents every time you lock_buffer(); and (b) you can't make decisions
> based on superblock feature bits in the superblock bh directly.
>=20
> I made that mistake when adding metadata_csum support to ext4 -- we'd
> only connect to the crc32c "crypto" module if checksums were enabled in
> the ondisk super at mount time, but then there were a couple of places
> that looked at the ondisk super bits at runtime, so you could flip the
> bit on and crash the kernel almost immediately.
>=20
> Nowadays you could protect against malicious writes with the
> BLK_DEV_WRITE_MOUNTED=3Dn so at least that's mitigated a little bit.
> Note (a) implies that the use of BH_Verified is a giant footgun.
>=20
> Catherine Hoang [now cc'd] has prototyped a generic buffer cache so that
> we can fix these vulnerabilities in ext2:
> https://lore.kernel.org/linux-ext4/20250326014928.61507-1-catherine.hoan=
g@oracle.com/
>=20
>> - What is keeping fs super block update from racing with user space
>>    device scan?
>>
>>    I guess it's the regular page/folio locking of the bdev page cache.
>>    But that also means, pure bio based IO will always race with buffere=
d
>>    read of a block device.
>=20
> Right.  In theory you could take the posix advisory lock (aka flock)
> from inside the kernel for the duration of the sb write, and that would
> prevent libblkid/udev from seeing torn/stale contents because they take
> LOCK_SH.
>=20
>> - If so, is there any special bio flag to prevent such race?
>>    So far I am unable to find out such flag.
>=20
> No.
>=20
> --D
>=20
>> Thanks,
>> Qu
>>
>=20


