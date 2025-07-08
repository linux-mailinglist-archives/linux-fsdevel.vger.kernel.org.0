Return-Path: <linux-fsdevel+bounces-54213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9539AFC122
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 05:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397D84A6373
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1E22FDE6;
	Tue,  8 Jul 2025 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QGjBb7Xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812071E2838;
	Tue,  8 Jul 2025 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944026; cv=none; b=lltJr0ZkWpGWSSHS2grLrq4zur13apS5Raiz1qFWd4lNnibXatIsf0asHe553ywXPN/ejQKXz9+D9XQUXn1Tc3WMWfJyV2qq831dhRnHEmIKF2sp8ehaDpYH8Lmu+qOiqvUo5B3Ly5aJ42Bh6cOT0wFH5w+/2OeNe8FNbCnwSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944026; c=relaxed/simple;
	bh=PaHuVfJC+k3tFxfJhrCwUlDKM9NB4b03RRhYql896gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPH8DCHstb+9S4svkM4zZg8cIsimhMv2MDAEWj4HqyTlGQcD/AgGebr6DYOM7psTqKhaOTQYUeAwmk7cNyijHbZ+5oJvSOE4xk2LQ6JnzFyXa7sdkaoFXehiHi+Vx0PQgUZJ85jIOKA6X4iUyrkbtkQGKGbCY9PbEdCUmgNuUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QGjBb7Xg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751944016; x=1752548816; i=quwenruo.btrfs@gmx.com;
	bh=9AkzgC4LlgXiHeb40Q9FmYsfdBTPMHgFtx84I6wW3D4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QGjBb7Xg76I5cepZC7k+sDhZKiY9iZBexu2Slm5KiAoVa6wAi26NQIoSpK5MMFgS
	 zCSnGqba7J6DP0Z1qNIZ53wXLv+PgZFuqDT0ND0quKkTdPQuX1G06QNIEEhP/yUVs
	 bkemeR+Z9HuYb8Cb41twO+KpyIBw9YVVDHWU8PY8YlbG5tlu7nktyKlQy+hQtyuPx
	 yB5BNF+SGdgOtltiHjfR4FqkHP8eRz0JtBU1FnHxprpJY5lehgq4jlZhEb0vVmoj5
	 1NUKArBjAlg5vrmQDefy3p161M2IgSL0DgpoXdFBhfwUpDoG+nAP8uKl90kYM3xCa
	 67n5CD400KtneLbelQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1uIYmR1jB6-00WURW; Tue, 08
 Jul 2025 05:06:55 +0200
Message-ID: <bdce1e62-c6dd-4f40-b207-cfaf4c5e25e4@gmx.com>
Date: Tue, 8 Jul 2025 12:36:48 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>,
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
In-Reply-To: <02584a40-a2c0-4565-ab46-50c1a4100b21@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2uUHVMbXI47p/AI325FvUcM1/NPkQSa7e22wurBVRkYZWtBEG9+
 KxGZW9RvAvS4omNKm93sr2isMPhuwkIAR1Te9f4cB0gx35BTUzUIsd+b1qC7CVb7OAYuZcw
 Yu8UZcmytWqWW8HALz0VRXMuG4rW3jXgVhSjW8qGzTOvLoJSMH8bnFkgWtvvUmohZBUICnC
 TQ/uRc/BhQwcegfxg4f+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cqTZ8MddLiQ=;OOTm8pMVOQ0XR4tqU/yKcjDSCxc
 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



=E5=9C=A8 2025/7/8 11:39, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/7/8 10:15, Darrick J. Wong =E5=86=99=E9=81=93:
> [...]
>>>
>>> I do not think it's the correct way to go, especially when there is=20
>>> already
>>> fs_holder_ops.
>>>
>>> We're always going towards a more generic solution, other than=20
>>> letting the
>>> individual fs to do the same thing slightly differently.
>>
>> On second thought -- it's weird that you'd flush the filesystem and
>> shrink the inode/dentry caches in a "your device went away" handler.
>> Fancy filesystems like bcachefs and btrfs would likely just shift IO to
>> a different bdev, right?=C2=A0 And there's no good reason to run shrink=
ers on
>> either of those fses, right?
>=20
> That's right, some part of fs_bdev_mark_dead() is not making much sense=
=20
> if the fs can handle the dev loss.
>=20
>>
>>> Yes, the naming is not perfect and mixing cause and action, but the en=
d
>>> result is still a more generic and less duplicated code base.
>>
>> I think dchinner makes a good point that if your filesystem can do
>> something clever on device removal, it should provide its own block
>> device holder ops instead of using fs_holder_ops.
>=20
> Then re-implement a lot of things like bdev_super_lock()?
>=20
> I'd prefer not.
>=20
>=20
> fs_holder_ops solves a lot of things like handling mounting/inactive=20
> fses, and pushing it back again to the fs code is just causing more=20
> duplication.
>=20
> Not really worthy if we only want a single different behavior.
>=20
> Thus I strongly prefer to do with the existing fs_holder_ops, no matter=
=20
> if it's using/renaming the shutdown() callback, or a new callback.

Previously Christoph is against a new ->remove_bdev() callback, as it is=
=20
conflicting with the existing ->shutdown().

So what about a new ->handle_bdev_remove() callback, that we do=20
something like this inside fs_bdev_mark_dead():

{
	bdev_super_lock();
	if (!surprise)
		sync_filesystem();

	if (s_op->handle_bdev_remove) {
		ret =3D s_op->handle_bdev_remove();
		if (!ret) {
			super_unlock_shared();
			return;
		}
	}
	shrink_dcache_sb();
	evict_inodes();
	if (s_op->shutdown)
		s_op->shutdown();
}

So that the new ->handle_bdev_remove() is not conflicting with
->shutdown() but an optional one.

And if the fs can not handle the removal, just let
->handle_bdev_remove() return an error so that we fallback to the=20
existing shutdown routine.

Would this be more acceptable?

Thanks,
Qu

>=20
>> =C2=A0I don't understand
>> why you need a "generic" solution for btrfs when it's not going to do
>> what the others do anyway.
>=20
> Because there is only one behavior different.
>=20
> Other things like freezing/thawing/syncing are all the same.
>=20
> Thanks,
> Qu
>=20
>>
>> Awkward naming is often a sign that further thought (or at least
>> separation of code) is needed.
>>
>> As an aside:
>> 'twould be nice if we could lift the *FS_IOC_SHUTDOWN dispatch out of
>> everyone's ioctl functions into the VFS, and then move the "I am dead"
>> state into super_block so that you could actually shut down any
>> filesystem, not just the seven that currently implement it.
>>
>> --D
>>
>>>> Hence Btrfs should be doing the same thing as bcachefs. The
>>>> bdev_handle_ops structure exists precisly because it allows the
>>>> filesystem to handle block device events in the exact manner they
>>>> require....
>>>>
>>>>> - Add a new @bdev parameter to remove_bdev() callback
>>>>> =C2=A0=C2=A0=C2=A0 To allow the fs to determine which device is miss=
ing, and do the
>>>>> =C2=A0=C2=A0=C2=A0 proper handling when needed.
>>>>>
>>>>> For the existing shutdown callback users, the change is minimal.
>>>>
>>>> Except for the change in API semantics. ->shutdown is an external
>>>> shutdown trigger for the filesystem, not a generic "block device
>>>> removed" notification.
>>>
>>> The problem is, there is no one utilizing ->shutdown() out of
>>> fs_bdev_mark_dead().
>>>
>>> If shutdown ioctl is handled through super_operations::shutdown, it=20
>>> will be
>>> more meaningful to split shutdown and dev removal.
>>>
>>> But that's not the case, and different fses even have slightly differe=
nt
>>> handling for the shutdown flags (not all fses even utilize journal to
>>> protect their metadata).
>>>
>>> Thanks,
>>> Qu
>>>
>>>
>>>>
>>>> Hooking blk_holder_ops->mark_dead means that btrfs can also provide
>>>> a ->shutdown implementation for when something external other than a
>>>> block device removal needs to shut down the filesystem....
>>>>
>>>> -Dave.
>>>
>>
>=20
>=20


