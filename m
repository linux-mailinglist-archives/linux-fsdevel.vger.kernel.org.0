Return-Path: <linux-fsdevel+bounces-53421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64266AEEEDE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FE73A85B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060725B309;
	Tue,  1 Jul 2025 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ivu8T6gd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04119ABAC;
	Tue,  1 Jul 2025 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351736; cv=none; b=HOZ2TcyYUSi5LdvPbY5C3hOfI3VTnou5lEg9NP0dIAVf7qX3Rf9yc0P4dgDAFDtr7P6SYsy6QmONkzQGaegJ33mqAYRXfJAKU769ALORVon5AmwC1uSF29JSBeq+zlqgqn+F/HZzixqWReXP6bEhSjVS3Y78e19IHhxscrP5l1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351736; c=relaxed/simple;
	bh=6xFIO76MPpCFJJTkyVSP+pgnaU2OR2GEadfb7mDgdcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6eeeEqRhfFHYyKAQqo3AO/XomwBxZlFUmt0xnk6Y/LyA62r7NI0H/fFQcGU2maqqMHStvrSzokyjdPGmZHI8tJTlAcLiNuXdz33+HmUuLpy4F8YHsavP/XXmoOV4M/RJ/Ex4H94ehwEMgBM66qOI0kg0VTpHebIOEHl7R8Ta4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ivu8T6gd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751351711; x=1751956511; i=quwenruo.btrfs@gmx.com;
	bh=cJjIAj6ubRAM7ciGlGMfKU676Bp5+7L6s2UhrUMnQUo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ivu8T6gdtYq/jFVc4ZZ/H1laUOqJeL7QsGKmiSqQ92I8wN0iujvpv51O34Bn80et
	 C5Q8Vz3ECXHZq8rLtibuBtldPHI3uh69Xh2oydWIagKY0bCNc29BVjVsA/9uK8x1y
	 4w41AegzAsGfyMEjFxDq8cyrCVGyXhfxmbZU5A+mK5yGQhg3syWZNTK5eGdqPAsfR
	 GVdMnNUUBPwFkRtCU3A+Iuly0OskixYQkCxbD28tWNOjumiMD855EQxNBE7pIT7Ky
	 JwDUb+Gs//wiyJAL9wC1wO3HG7PEmRvf8XB162mFx5sGXAw7y825EejYkYmpLuPES
	 bcrTDG3b9l8PdJRFdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MD9T7-1uNS2h0pxB-00370P; Tue, 01
 Jul 2025 08:35:11 +0200
Message-ID: <baec02a0-e2fb-4801-b2ad-f602fc4d1cfc@gmx.com>
Date: Tue, 1 Jul 2025 16:05:03 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
References: <cover.1751347436.git.wqu@suse.com>
 <6164b8c708b6606c640c066fbc42f8ca9838c24b.1751347436.git.wqu@suse.com>
 <aGN8zsyYEArKr0DV@infradead.org>
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
In-Reply-To: <aGN8zsyYEArKr0DV@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S7b/wFGvHmGysao1RvJ5BvTVYCoxhFsUUgP9+ZmDouj5riSCLuB
 HJLJ+sFRwgRLl/xwKk4ZHo/mA6h4P5ZzuP9SwvIpKL12iJJBN6f1yxxxvPLV9CbZ1SOblCN
 tpLhTIxkdJYro/whp5G0/k9o/pt/4mREtY6OwrbFY/k54rLHQJaHn0D1p/0UgApA1UqKUuu
 pKVOQfnKQFcoFkw/TBgVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:28atqJa8nMM=;yeGscrFOtxsnsZ/7rrIPy5xvBxZ
 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



=E5=9C=A8 2025/7/1 15:44, Christoph Hellwig =E5=86=99=E9=81=93:
> On Tue, Jul 01, 2025 at 03:02:34PM +0930, Qu Wenruo wrote:
>> To allow those multi-device filesystems to be integrated to use
>> fs_holder_ops:
>>
>> - Rename shutdown() call back to remove_bdev()
>>    To better describe when the call back is called.
>=20
> What is renamed back here?

Rename the old shutdown to remove_bdev().

>=20
>> -static void exfat_shutdown(struct super_block *sb)
>> +static void exfat_shutdown(struct super_block *sb, struct block_device=
 *bdev)
>>   {
>>   	exfat_force_shutdown(sb, EXFAT_GOING_DOWN_NOSYNC);
>>   }
>> @@ -202,7 +202,7 @@ static const struct super_operations exfat_sops =3D=
 {
>>   	.put_super	=3D exfat_put_super,
>>   	.statfs		=3D exfat_statfs,
>>   	.show_options	=3D exfat_show_options,
>> -	.shutdown	=3D exfat_shutdown,
>> +	.remove_bdev	=3D exfat_shutdown,
>=20
> Please also rename the function so that they match the method name.

I prefer not, and it is intentionally left as is.

This give us a very clear view what a fs is expected to do.

If a fs can only shutdown when losing any device, a read won't need to=20
dig into the details, just looking at that line will tell us what is the=
=20
behavior.

Thanks,
Qu


