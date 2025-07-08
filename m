Return-Path: <linux-fsdevel+bounces-54217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A3AFC235
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB603B9FDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 05:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41AF21A421;
	Tue,  8 Jul 2025 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aYqrLG2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3808918024;
	Tue,  8 Jul 2025 05:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953326; cv=none; b=iFwM184sIi8HnVA5LEhJ1BaDTJCyxA7xYAGXoja9JEn7snLjs9oMNx/jxwwkJGD9i4LD73dQf//CKmIBMZ2iQExIPTToUfFabng9azssvgrZAHrCplEFZ/5o1fDB4gMuXzY6O0H/fN/DDpZ4dkiTFSCmpUKriajnJoFf22BnsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953326; c=relaxed/simple;
	bh=EAlbBeWoK3RNJAtErDy9F+fUUi9HiiRCm9ZFeu3xqpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgQOuWuYe6oxjZvxnrrm+iyCwJ/eX8Ep7vai0xV/KDIceTeFTDYiSub+MoM/jpuJ7xmRr6r7V2FP14R/wYpHU8Z7wxIeqFN/4KjammVGspF4T8HK9m0URNTMM2ZKmXB/anTTqVP8DLEzNqwbsbiA17n7awrT+FSkc4HYydBonfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aYqrLG2c; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751953309; x=1752558109; i=quwenruo.btrfs@gmx.com;
	bh=riyCXE5gKKYIpfq8XUSBh84iFbyW0X9hUsfvBULvywI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aYqrLG2cm0iEAMBeW3jd4w7SLBsfxqTjxpzZhNantYHyNixKtfaLP3btMd+WtZ23
	 rngCGErOAj0uzoPtUTYhF6KsgDuBjjq7uMt8ePyibFlyRHLXavD9SfDc24cRG7hvA
	 sD8ezeWXQ/MW1kPkXknvAihs4/ZTKj9rOviIsdCPKRzP+lC968Fz2hJNW9mxwhQTI
	 hwSaq/65jSdKq7Vbu8OW51IXPMAQRi6PwDMR2mTsESUzrbXnW+LREJwX1AZEfU/1r
	 SET1/kN1P5Dy+S95j2UM90PriXebf4tBorRVNaRcKNSl08wihNvKTmPkt0xQFEYgv
	 pjaAfmPna3xNNQh+FA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwXh-1uOFSH401B-000v94; Tue, 08
 Jul 2025 07:41:49 +0200
Message-ID: <31d4c67f-160b-456d-a47b-869ddc5be6d0@gmx.com>
Date: Tue, 8 Jul 2025 15:11:43 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <02584a40-a2c0-4565-ab46-50c1a4100b21@gmx.com>
 <bdce1e62-c6dd-4f40-b207-cfaf4c5e25e4@gmx.com>
 <aGynIewLL-05fuoJ@dread.disaster.area>
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
In-Reply-To: <aGynIewLL-05fuoJ@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DZshX1x/Z8YAMhLnJ2+UeFiwTjMPrwyrZ85RITtwjEDU/AurW5K
 +SJ2veNL9n+tpNoL2eb53lzkrhbexEmLh0BbM4wCDbF4GWdweUxd132TGn0w87/x1fnkJPo
 ZAkV1lR+zGtIh2Fy0g+dRWJiGdAjtu6aSWAS0Vt1NAl9PEJI/FJ+4oQFh0H1GZA36FTo9+n
 Cq4/YglOlX5B3fEx2wl7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2TVEOnqouYY=;TnGclIOpdVuPZRjCsvWX+V4Y8+6
 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



=E5=9C=A8 2025/7/8 14:35, Dave Chinner =E5=86=99=E9=81=93:
[...]
>>> Not really worthy if we only want a single different behavior.
>=20
> This is the *3rd* different behaviour for ->mark_dead. We
> have the generic behaviour, the bcachefs behaviour, and now the
> btrfs behaviour (whatever that may be).

Then why not merging the btrfs/bcachefs callback into one generic=20
callback? Other than introducing 3 different bdev_holder_ops?

This looks exactly the opposite what VFS is trying to do.

Thanks,
Qu

>=20
>>> Thus I strongly prefer to do with the existing fs_holder_ops, no matte=
r
>>> if it's using/renaming the shutdown() callback, or a new callback.
>>
>> Previously Christoph is against a new ->remove_bdev() callback, as it i=
s
>> conflicting with the existing ->shutdown().
>>
>> So what about a new ->handle_bdev_remove() callback, that we do somethi=
ng
>> like this inside fs_bdev_mark_dead():
>>
>> {
>> 	bdev_super_lock();
>> 	if (!surprise)
>> 		sync_filesystem();
>>
>> 	if (s_op->handle_bdev_remove) {
>> 		ret =3D s_op->handle_bdev_remove();
>> 		if (!ret) {
>> 			super_unlock_shared();
>> 			return;
>> 		}
>> 	}
>> 	shrink_dcache_sb();
>> 	evict_inodes();
>> 	if (s_op->shutdown)
>> 		s_op->shutdown();
>> }
>>
>> So that the new ->handle_bdev_remove() is not conflicting with
>> ->shutdown() but an optional one.
>>
>> And if the fs can not handle the removal, just let
>> ->handle_bdev_remove() return an error so that we fallback to the exist=
ing
>> shutdown routine.
>>
>> Would this be more acceptable?
>=20
> No.
>=20
> -Dave.


