Return-Path: <linux-fsdevel+bounces-54206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBAEAFC084
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 04:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D19F4A3BC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 02:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A6A21B908;
	Tue,  8 Jul 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aFbYN7eX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA621883F;
	Tue,  8 Jul 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940617; cv=none; b=bAGy+2Frdvx7UdvHep/snAJ8tW+dbV1qhpLxWAoRqDoZtil1yKwQIyEhKvT7ogKcMJc6NhVXAQCrf8TGFAs6diTrWjiK2nTx7Y+d3RI8BvinUOHxNvosFINrGmtMbBGp7SqyWByxMHWg5a5kN3CHVjwTxNK5NhHEanzVlZ2ZhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940617; c=relaxed/simple;
	bh=IS2SOsI8AEa2vY4ttEk43WaJKe9m69fh3kSiDj7OMpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHtVjmIki/K7LazCLtQbPt7SKa3E8Z5JegOx/zjnIDFJlXu01ChFhPM8f8azzjDSEAZXzBV4/meScNkFHu9kBWBbov+HcXyFyv8I9/vMsEqifI3mOLw/cMU7WwD7fkFiLf2xzSC9iVepxlyl5tXFzI0JRxHe/C2+DlJRoMKAT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aFbYN7eX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751940590; x=1752545390; i=quwenruo.btrfs@gmx.com;
	bh=0h5VDs/ZUqYitD9U3zCLJQXOlFnOTO0lH7VNO4yWm1o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aFbYN7eXZ1e/aKYoUwoDgU20cCqPFEg5zR7Gs3BrJDK+vrSjkAaL3vqEHxUj37GF
	 JHVtFZxu93XEl+GNo5x40+aDuTouonHo6szImifyFO2R5EROwsIt4vA4NyOn6mIMs
	 jDaShxYI31H3BZVkROP68nzx3jc5c1OLwUgCZ+qjv+i1Onq3zAU6YKHy8UFiPXWdn
	 aMUXokgp+tOHNQHBwg+FtUu9OIxkIsrh/LmuYPD+6JxPcbHDV7teenMsabvoEwJhi
	 J2gom3jhhscbBpj68ZgVfQBt09tWMml9IMxnEPhUavS7YpXFpVDgtmx5W8cfUef6F
	 oijnnAoHH32HC4XcdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKHc-1urhS546iy-015pS4; Tue, 08
 Jul 2025 04:09:50 +0200
Message-ID: <02584a40-a2c0-4565-ab46-50c1a4100b21@gmx.com>
Date: Tue, 8 Jul 2025 11:39:42 +0930
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
In-Reply-To: <20250708004532.GA2672018@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LtuoZyNaToYftOWmNW8wynAcLNGgt+BTG26KXfqxGFyysSJQjTY
 dGo/srMDXitMVyTRVSmSOtL1PY7v+HCDDQ5vpZsUIIfbSl6Bs7Rni7glh6FXMu0TjDaxYaQ
 yCqbBIQ0ZYlyLA09sy6wJ03IwRa6XFPsuELICG2CuXtgr7Q/P3Su+/HGfif4SkQZxEd//nI
 KGoR/TiIp7+sEKBCSd/2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wZmAZRbajo0=;PNV3xrk5N3151j3iXOadSy+eecD
 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



=E5=9C=A8 2025/7/8 10:15, Darrick J. Wong =E5=86=99=E9=81=93:
[...]
>>
>> I do not think it's the correct way to go, especially when there is alr=
eady
>> fs_holder_ops.
>>
>> We're always going towards a more generic solution, other than letting =
the
>> individual fs to do the same thing slightly differently.
>=20
> On second thought -- it's weird that you'd flush the filesystem and
> shrink the inode/dentry caches in a "your device went away" handler.
> Fancy filesystems like bcachefs and btrfs would likely just shift IO to
> a different bdev, right?  And there's no good reason to run shrinkers on
> either of those fses, right?

That's right, some part of fs_bdev_mark_dead() is not making much sense=20
if the fs can handle the dev loss.

>=20
>> Yes, the naming is not perfect and mixing cause and action, but the end
>> result is still a more generic and less duplicated code base.
>=20
> I think dchinner makes a good point that if your filesystem can do
> something clever on device removal, it should provide its own block
> device holder ops instead of using fs_holder_ops.

Then re-implement a lot of things like bdev_super_lock()?

I'd prefer not.


fs_holder_ops solves a lot of things like handling mounting/inactive=20
fses, and pushing it back again to the fs code is just causing more=20
duplication.

Not really worthy if we only want a single different behavior.

Thus I strongly prefer to do with the existing fs_holder_ops, no matter=20
if it's using/renaming the shutdown() callback, or a new callback.

>  I don't understand
> why you need a "generic" solution for btrfs when it's not going to do
> what the others do anyway.

Because there is only one behavior different.

Other things like freezing/thawing/syncing are all the same.

Thanks,
Qu

>=20
> Awkward naming is often a sign that further thought (or at least
> separation of code) is needed.
>=20
> As an aside:
> 'twould be nice if we could lift the *FS_IOC_SHUTDOWN dispatch out of
> everyone's ioctl functions into the VFS, and then move the "I am dead"
> state into super_block so that you could actually shut down any
> filesystem, not just the seven that currently implement it.
>=20
> --D
>=20
>>> Hence Btrfs should be doing the same thing as bcachefs. The
>>> bdev_handle_ops structure exists precisly because it allows the
>>> filesystem to handle block device events in the exact manner they
>>> require....
>>>
>>>> - Add a new @bdev parameter to remove_bdev() callback
>>>>     To allow the fs to determine which device is missing, and do the
>>>>     proper handling when needed.
>>>>
>>>> For the existing shutdown callback users, the change is minimal.
>>>
>>> Except for the change in API semantics. ->shutdown is an external
>>> shutdown trigger for the filesystem, not a generic "block device
>>> removed" notification.
>>
>> The problem is, there is no one utilizing ->shutdown() out of
>> fs_bdev_mark_dead().
>>
>> If shutdown ioctl is handled through super_operations::shutdown, it wil=
l be
>> more meaningful to split shutdown and dev removal.
>>
>> But that's not the case, and different fses even have slightly differen=
t
>> handling for the shutdown flags (not all fses even utilize journal to
>> protect their metadata).
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>> Hooking blk_holder_ops->mark_dead means that btrfs can also provide
>>> a ->shutdown implementation for when something external other than a
>>> block device removal needs to shut down the filesystem....
>>>
>>> -Dave.
>>
>=20


