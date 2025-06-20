Return-Path: <linux-fsdevel+bounces-52368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C20DAE24E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 00:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D3818979DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 22:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FBE23BCE3;
	Fri, 20 Jun 2025 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WEnwk9eN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D9201000;
	Fri, 20 Jun 2025 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457433; cv=none; b=G0sk0xOWpfIhvok4cdKVZOhLzuUVS/ERZpxlHo1MP13bZPqScZAQzdeOey0nG0nxDT+Ix/3q8S7/YPHc+ImK8F+pHU+rqYore7q06gK9TsiggK9hIx8SyQNKTdp4FcXj6h93q1iq3xb/41DUCoJfluhIpo8C4bq3vEtMiTdNBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457433; c=relaxed/simple;
	bh=bchtQjtzlCQwerRNf8Q3jR2GeVmUzfVpJZ1bEmW0Ybc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+0OY5Urf8HIMoLhL6Q+StNBCTjfWboRVRMTsEV2C5uZA7PJpuSpIJPYDvqnVEF4V/ZPmK7bCLN/iWMpUqK6GVR+M2c+nHyVrDT7bn5f5nYUw05N/WadkQun4OLuNGBfLRLwZPEkgOlVzyiGBeH7mzKu+Go5N4KjmnKRzQ54ago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WEnwk9eN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750457413; x=1751062213; i=quwenruo.btrfs@gmx.com;
	bh=z1x0c41a0Hxf6xd4GKNqMyUoBZLnfTJvW6PFTUKyi3Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WEnwk9eN+3GIIxdj0gG8dyn3mg8eNHAQdNEqlk4v6XmhLm2sQFKW4uPL/EKOQAxb
	 x3RoRUfL0+gOW3dGRy3reWf7+vR5EYn23vC/TNUmsmRN9whp7gwfv4CtTefn5hMFa
	 9LOCKD6if3URtQv5W5J7dfX6g0cF4PWc9BD2MLolcGpoKVsmubEclpPD1uEAWk47M
	 S5NCetzb7uqOCDGgRxLCj/CZjCGzxhu0G+/PHLrInx5AK7ZvZPwv1lphPXjphe+wu
	 E6kijcLk6ba8jJ8S3+qUOZzlNg7R7ZuARuMtGtJwizTf5PlAqlP0gBvSo+Ks+7EdT
	 PJBAEUggHGmNDfNcBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmDIu-1vAdPR02Iy-00cAiV; Sat, 21
 Jun 2025 00:10:13 +0200
Message-ID: <ab5232d3-04ee-4930-a857-36f888c8b190@gmx.com>
Date: Sat, 21 Jun 2025 07:40:08 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
To: Jan Kara <jack@suse.cz>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
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
In-Reply-To: <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Di0RUlxt+gqb+5KQNBo6cIiqhefk1jHNCq9CSow66/YUtOslWcM
 U5WIyvWDzhIhQMgIjbs52BL+Lt6DZtPcZYhUdM3Zm2w6c8Ryt4ucRvCiM0vKcehODcVaLE7
 abaaHv5lbjdB4uD2I9r6C1y0kwvKnBBaDs6RpYgXCD1KT60eFu1/gJ9E+yJaBVRaGCjfyzn
 Ht51xkEQemt+ouTLrt0jw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eQlEuEsACSo=;m22czwFfryIbYyjUq8HeuewQ1u3
 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
 2WosWPXzNiAInet3zEOWvN3EMyesvHrteYGLcA==



=E5=9C=A8 2025/6/21 01:06, Jan Kara =E5=86=99=E9=81=93:
> On Fri 20-06-25 15:17:28, Qu Wenruo wrote:
>> Currently we already have the super_operations::shutdown() callback,
>> which is called when the block device of a filesystem is marked dead.
>>
>> However this is mostly for single(ish) block device filesystems.
>>
>> For multi-device filesystems, they may afford a missing device, thus ma=
y
>> continue work without fully shutdown the filesystem.
>>
>> So add a new super_operation::shutdown_bdev() callback, for mutli-devic=
e
>> filesystems like btrfs and bcachefs.
>>
>> For now the only user is fs_holder_ops::mark_dead(), which will call
>> shutdown_bdev() if supported.
>> If not supported then fallback to the original shutdown() callback.
>>
>> Btrfs is going to add the usage of shutdown_bdev() soon.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Thanks for the patch. I think that we could actually add 'bdev' that
> triggered shutdown among arguments ->shutdown takes instead of introduci=
ng
> a new handler.
>=20
> 								Honza

That makes sense.

Will add the new bdev parameters instead.

Thanks,
Qu

>=20
>> ---
>>   fs/super.c         |  4 +++-
>>   include/linux/fs.h | 10 ++++++++++
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index 21799e213fd7..8242a03bd5ce 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -1461,7 +1461,9 @@ static void fs_bdev_mark_dead(struct block_device=
 *bdev, bool surprise)
>>   		sync_filesystem(sb);
>>   	shrink_dcache_sb(sb);
>>   	evict_inodes(sb);
>> -	if (sb->s_op->shutdown)
>> +	if (sb->s_op->shutdown_bdev)
>> +		sb->s_op->shutdown_bdev(sb, bdev);
>> +	else if (sb->s_op->shutdown)
>>   		sb->s_op->shutdown(sb);
>>  =20
>>   	super_unlock_shared(sb);
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 96c7925a6551..4f6b4b3cbe22 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2363,7 +2363,17 @@ struct super_operations {
>>   				  struct shrink_control *);
>>   	long (*free_cached_objects)(struct super_block *,
>>   				    struct shrink_control *);
>> +	/*
>> +	 * For single-device filesystems. Called when the only block device i=
s
>> +	 * marked dead.
>> +	 */
>>   	void (*shutdown)(struct super_block *sb);
>> +
>> +	/*
>> +	 * For multi-device filesystems. Called when any of its block device =
is
>> +	 * marked dead.
>> +	 */
>> +	void (*shutdown_bdev)(struct super_block *sb, struct block_device *bd=
ev);
>>   };
>>  =20
>>   /*
>> --=20
>> 2.49.0
>>


