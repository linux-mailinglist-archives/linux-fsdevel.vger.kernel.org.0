Return-Path: <linux-fsdevel+bounces-53446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0210AEF1A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FF5189516D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE31E26A1DD;
	Tue,  1 Jul 2025 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="T+zDCNDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F71EC01D;
	Tue,  1 Jul 2025 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359618; cv=none; b=jxT2g4TK9CfzBOiK7CYlfTQ23xQK805yKIUPmyFpuaV0c2xlk7HP/4/KB2owe/Q3uC/Vo6Ybar66KEznZIIFxJWPjDG6dVlmgX56qoP9Ay0/eXn6EbOy0nW7e4buw22AfUHi3fK6/nP2RrZaFfGMxhN2FXsHdaUALzlzA43i6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359618; c=relaxed/simple;
	bh=qU/9VkiHj7ijOetrr/MvYBE4G3xwpd+xB5b6lyXQTWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZcue18ViYVEYxWGryfzxB1A3WzwPLYKX1P8WkjjjDtyZYis5OgdVPTV1praAifOu13vqQhQjbb1u1gXzg5zhk2DuRe6/rxB3i8IWTWtg1Ew+1CioCc5hjSc5x+3QJR0+pryc8N2/5wok4FNx3ECno+rwIM9BWwf25axLnO1HOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=T+zDCNDb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751359600; x=1751964400; i=quwenruo.btrfs@gmx.com;
	bh=YudY/ZM/rmx3cSbEA/yES/Ra50DzYmrGbdlfV/TbpHU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T+zDCNDbE+FDw+y2Lbh6iqpoL6kMkHnQ7/EozmHoGdWcvMge52b6lcxV1lXUjACV
	 6R9FfXkmqbEXgo6Dtq5lGRgVZr4tQAPkHbB/AwJDMA9xiGMfo1NBPdgsQmq/2U2ZE
	 HAPS97e3arqDdT9YXNkNVgNppRRjjlwoiTI6EQnezX5d+iIAZnLF7mlbYQ6E01eiB
	 W3DxCy97yfNkesG0+PCH48DxoqQjZxR7BLiDiuLK1iZL7AwdIdWI6H+Vw4VMGrNq3
	 jCilJ4YZ5Mne45xJ2w+es0t+BkQ8AJIeXZw5K37kP7CY/O/Mvoudwmrlqk2DiRWed
	 ikwy6u+3+pYwxrftDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIMbU-1uTDFD1jpk-004ZPJ; Tue, 01
 Jul 2025 10:46:39 +0200
Message-ID: <db803720-66a6-4e0e-88ce-6b8a05845146@gmx.com>
Date: Tue, 1 Jul 2025 18:16:33 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev,
 linux-xfs@vger.kernel.org
References: <cover.1751347436.git.wqu@suse.com>
 <6164b8c708b6606c640c066fbc42f8ca9838c24b.1751347436.git.wqu@suse.com>
 <aGN8zsyYEArKr0DV@infradead.org>
 <baec02a0-e2fb-4801-b2ad-f602fc4d1cfc@gmx.com>
 <20250701-beziffern-penetrant-ed93dbc57654@brauner>
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
In-Reply-To: <20250701-beziffern-penetrant-ed93dbc57654@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tZio1FPOqX5rmOFKcRLf6dtEMceSPgpkWrQcDvgYxLZGTsic4PE
 0af3ZDmh/UaY7u8DxnvaWWUa4HoEBauptoTq9wEPvpXvGykuI/67+4cZdaldwbSf1e5BiPY
 xVHSooQ8Q8fgM/R6wjTi7rTLbnNDMgh+EywL9qf9IRt+z0cJWdm6WOg4D2KG778R142GYbn
 P9QujpMieBPJbVJ8/NTWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kvlb2w5npLI=;JVQoLpUuKRfZJiwHI9KietYGhuB
 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
 Gw==



=E5=9C=A8 2025/7/1 18:11, Christian Brauner =E5=86=99=E9=81=93:
> On Tue, Jul 01, 2025 at 04:05:03PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/7/1 15:44, Christoph Hellwig =E5=86=99=E9=81=93:
>>> On Tue, Jul 01, 2025 at 03:02:34PM +0930, Qu Wenruo wrote:
>>>> To allow those multi-device filesystems to be integrated to use
>>>> fs_holder_ops:
>>>>
>>>> - Rename shutdown() call back to remove_bdev()
>>>>     To better describe when the call back is called.
>>>
>>> What is renamed back here?
>>
>> Rename the old shutdown to remove_bdev().
>>
>>>
>>>> -static void exfat_shutdown(struct super_block *sb)
>>>> +static void exfat_shutdown(struct super_block *sb, struct block_devi=
ce *bdev)
>>>>    {
>>>>    	exfat_force_shutdown(sb, EXFAT_GOING_DOWN_NOSYNC);
>>>>    }
>>>> @@ -202,7 +202,7 @@ static const struct super_operations exfat_sops =
=3D {
>>>>    	.put_super	=3D exfat_put_super,
>>>>    	.statfs		=3D exfat_statfs,
>>>>    	.show_options	=3D exfat_show_options,
>>>> -	.shutdown	=3D exfat_shutdown,
>>>> +	.remove_bdev	=3D exfat_shutdown,
>>>
>>> Please also rename the function so that they match the method name.
>>
>> I prefer not, and it is intentionally left as is.
>>
>> This give us a very clear view what a fs is expected to do.
>=20
> Qu, would you please rename the individual functions?

Sure. I'll keep the fs' function names consistent with the callback names.

Especially there are already quite some maintainers wanting a consistent=
=20
pattern here.

Thanks,
Qu

>=20
> The NAK later just because of this is unnecessary. I will say clearly
> that I will ignore gratuitous NAKs that are premised on large scale
> rewrites that are out of scope for the problem.
>=20
> Here the requested rework has an acceptable scope though and we can
> sidestep the whole problem and solve it so everyone's happy.
>=20


