Return-Path: <linux-fsdevel+bounces-57184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1519B1F6F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 00:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8E317E306
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C797327BF95;
	Sat,  9 Aug 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lBKLKYvA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1032239E80;
	Sat,  9 Aug 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754777235; cv=none; b=Ov1cNKpzPGRWK/BjreeiuM2KUdTucCujEo7vjB5VVTA4+HivWbZdLffvDxs2kphlYXnDJoaZzD2v5ihiPSvavEnjH91Q+WrQ19N7ppgzoGSQFHR7TC/WYkmxwXzdCraQtD2INZrv6tyt6sQWfyjZp8pzwz4KTvP+5RrCXlbYXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754777235; c=relaxed/simple;
	bh=k6B/H4S6MdhjYQLwtq56RGLwWJ8FLvlWxTAz3iDv+iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnyLm9enDsaRyWbOQqCyHiVM6K9JSoOWuzSmQYqT3TOp8e/OObMhcUWIh5GU5mf963RijzBq1k8XwVf1EBKv102QrP1tkE8H3hQj8HqYCRgauI7FUf5OjupnyGtDDZNeAXpGyfdHOY+0qtWwaIoZQp0zmlUiZ49mEhwQfG0EO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lBKLKYvA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754777216; x=1755382016; i=quwenruo.btrfs@gmx.com;
	bh=M2exi6zGRls/6WsShoZiDewKyQlrX98a+/KHqe3I32c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lBKLKYvAnK9QEELne5HREJx9SEOqtubzausvwFDblJePHI5J5i6qvn31Y+IYpyvI
	 g8om4sDmC9zUTEY6p0EfTYwro1ysqHiac3z1DgjJCckgMxcucLP9h+Rzen9hBEPbD
	 GoA3yhwB8AGJGFkCM3LDGxZWRuRQPlebEgnoC9JLdFNOM+9SKTrgG7ptHHPsSpGSx
	 H8bSoo4hNFew7ewPQSlQ9IVeMaASsUOe8ff8s3h8yfiAS/hPEL82M0zSo/riOT0SU
	 PGS5BWIjR5jj+zDSFb7+9KcdKHsRuGqqaEpGBmzLE9sNUdBMjRclA66xMmEIPl3vO
	 ZEDn0IrXek7wHQRbmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26r3-1umneY3QiH-00De77; Sun, 10
 Aug 2025 00:06:56 +0200
Message-ID: <15a4c437-d276-4503-9e30-4d48f5b7a4ff@gmx.com>
Date: Sun, 10 Aug 2025 07:36:48 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
To: Zhang Yi <yi.zhang@huaweicloud.com>, Qu Wenruo <wqu@suse.com>,
 Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
 <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
 <20250808121659.GC778805@mit.edu>
 <035ad34e-fb1e-414f-8d3c-839188cfa387@suse.com>
 <c2a00db8-ed34-49bb-8c01-572381451af3@huaweicloud.com>
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
In-Reply-To: <c2a00db8-ed34-49bb-8c01-572381451af3@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kb1Wtbd4yjXCk96Nn33GMp/yKC4+w4Hz238YNxO8U9n7bIBhEHD
 16iaHUDNnhHdfA9Ww5wHRULL9ZnGsblrETuidHMgF0a3z688a5KyxXmH6D7YE/CTvkv/3Xe
 xkvO4EhShYDGdUvT50DmI+k9HfRYhLcMaBcvx9V9gchl1Xt4iW2wF3fZcxdvgEntB8+gici
 orXzwbgyn75jCjqaSBwIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WdLwypDf5vQ=;9vSHC47K+MsPtESAj9ruQHu7nLM
 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



=E5=9C=A8 2025/8/9 18:39, Zhang Yi =E5=86=99=E9=81=93:
> On 2025/8/9 6:11, Qu Wenruo wrote:
>> =E5=9C=A8 2025/8/8 21:46, Theodore Ts'o =E5=86=99=E9=81=93:
>>> On Fri, Aug 08, 2025 at 06:20:56PM +0930, Qu Wenruo wrote:
>>>>
>>>> =E5=9C=A8 2025/8/8 17:22, Qu Wenruo =E5=86=99=E9=81=93:
>>>>> Hi,
>>>>>
>>>>> [BACKGROUND]
>>>>> Recently I'm testing btrfs with 16KiB block size.
>>>>>
>>>>> Currently btrfs is artificially limiting subpage block size to 4K.
>>>>> But there is a simple patch to change it to support all block sizes =
<=3D
>>>>> page size in my branch:
>>>>>
>>>>> https://github.com/adam900710/linux/tree/larger_bs_support
>>>>>
>>>>> [IOMAP WARNING]
>>>>> And I'm running into a very weird kernel warning at btrfs/136, with =
16K
>>>>> block size and 64K page size.
>>>>>
>>>>> The problem is, the problem happens with ext3 (using ext4 modeule) w=
ith
>>>>> 16K block size, and no btrfs is involved yet.
>>>
>>>
>>> Thanks for the bug report!=C2=A0 This looks like it's an issue with us=
ing
>>> indirect block-mapped file with a 16k block size.=C2=A0 I tried your
>>> reproducer using a 1k block size on an x86_64 system, which is how I
>>> test problem caused by the block size < page size.=C2=A0 It didn't
>>> reproduce there, so it looks like it really needs a 16k block size.
>>>
>>> Can you say something about what system were you running your testing
>>> on --- was it an arm64 system, or a powerpc 64 system (the two most
>>> common systems with page size > 4k)?=C2=A0 (I assume you're not trying=
 to
>>> do this on an Itanic.=C2=A0 :-)=C2=A0=C2=A0 And was the page size 16k =
or 64k?
>>
>> The architecture is aarch64, the host board is Rock5B (cheap and fast e=
nough), the test machine is a VM on that board, with ovmf as the UEFI firm=
ware.
>>
>> The kernel is configured to use 64K page size, the *ext3* system is usi=
ng 16K block size.
>>
>> Currently I tried the following combination with 64K page size and ext3=
, the result looks like the following
>>
>> - 2K block size
>> - 4K block size
>>  =C2=A0 All fine
>>
>> - 8K block size
>> - 16K block size
>>  =C2=A0 All the same kernel warning and never ending fsstress
>>
>> - 32K block size
>> - 64K block size
>>  =C2=A0 All fine
>>
>> I am surprised as you that, not all subpage block size are having probl=
ems, just 2 of the less common combinations failed.
>>
>> And the most common ones (4K, page size) are all fine.
>>
>> Finally, if using ext4 not ext3, all combinations above are fine again.
>>
>> So I ran out of ideas why only 2 block sizes fail here...
>>
>=20
> This issue is caused by an overflow in the calculation of the hole's
> length on the forth-level depth for non-extent inodes. For a file system
> with a 4KB block size, the calculation will not overflow. For a 64KB
> block size, the queried position will not reach the fourth level, so thi=
s
> issue only occur on the filesystem with a 8KB and 16KB block size.
>=20
> Hi, Wenruo, could you try the following fix?
>=20
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index 7de327fa7b1c..d45124318200 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -539,7 +539,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct ino=
de *inode,
>   	int indirect_blks;
>   	int blocks_to_boundary =3D 0;
>   	int depth;
> -	int count =3D 0;
> +	u64 count =3D 0;
>   	ext4_fsblk_t first_block =3D 0;
>=20
>   	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags=
);
> @@ -588,7 +588,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct ino=
de *inode,
>   		count++;
>   		/* Fill in size of a hole we found */
>   		map->m_pblk =3D 0;
> -		map->m_len =3D min_t(unsigned int, map->m_len, count);
> +		map->m_len =3D umin(map->m_len, count);
>   		goto cleanup;
>   	}

It indeed solves the problem.

Tested-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> Thanks,
> Yi.
>=20


