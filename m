Return-Path: <linux-fsdevel+bounces-54196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86851AFBE90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 01:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D638425B72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110A528A1EA;
	Mon,  7 Jul 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Zjv8hKUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17211F1302;
	Mon,  7 Jul 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751930581; cv=none; b=cqHKhU6Q7mF2S0ev01oZKw2/7el3jimERLwf2ntHpTZQ/s0ffp3JqzFf4WMU9Os8j/hTQNPjctx5KFCoa8yM2HuVMLEHrFhkYgTqlBROdXn3st45Em6dZAzmMVRe18aE7fURU4Kv530nuLvJBFGNSG7iBZeEuQHI7HYIpaTAMYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751930581; c=relaxed/simple;
	bh=AJ2YorkMO+xyn8pnD7583uO+MofRse2wmTScwQ26Tjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1fUPSO4Eb/rzdOmjrghSoa8Xu3s4ux/q7UIWQmQ19D1Ybygua7pifNzJYmdSfJJDXN+tbiRGk26uzgE9VhMNhkErOuLOm94kVJn2KSWcokwltavwDlAvxIApXw49trGc5O1GCuvnPZ3LHD1rYOUIMCJ4pWVhwGiw7tYHXjs3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Zjv8hKUP; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751930573; x=1752535373; i=quwenruo.btrfs@gmx.com;
	bh=oDGxAytI/hZJOsHwe4zDzBvCFX7I/dRtdpEmiKudrRE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zjv8hKUPvtZLYQ/Db4xUW3RyEjTpXnamacdEVh6Rnw9sLCRtYcnHI36Dvdrs6RdL
	 Cmqj6k4ihMDxox4yLKPVZcwLDbaTKg5EcYNN8Z7vluCz/+vV6h7q6glSoP4BjwFGN
	 iCNCvtn97eFyU7DQr1vW0yNITj1/hV9lmVqrclk2b68zGtIWwsgZjSL8W04PIfP2+
	 9jNFGSv0OC3ryOk+HPwgHpNr1XHXHu0xapcTUsL4UEIzHUoXNVIkMHCcbYUAZyeF/
	 HYfJ4QZ4EEgwi/ZWEseP3TCbrcY0c+oB5COpC6xKnK25YPlPokunXoemznHj7tZ5I
	 lRe1GAz7I8LGnOEqSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzjt-1uAxJV1a81-00Pnh5; Tue, 08
 Jul 2025 01:22:52 +0200
Message-ID: <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
Date: Tue, 8 Jul 2025 08:52:47 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
To: Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
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
In-Reply-To: <aGxSHKeyldrR1Q0T@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fh9STDID+y5LPw9/Fq2kSOxplS0SXa5VtGqgX/sxr1gsWYqYXA6
 1rRl/yaLLYb6KJ9q0c+H5/KrcT94wO8dtavXEpF09yKDKEx0aNXu7eKzbpJAnXG6echlBxK
 8Ienl9KdjETF35uTAwTfrMYVCOvaAJNRtB1JZs8RXDHmVaL63WxLIhFK7l5DKfXnpP5Jc0L
 UlV+XmBBOycuGBFPFkvFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vxzf/0dc4gs=;cEtS4m0APqpDTI0YVG7hCD8EKfv
 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



=E5=9C=A8 2025/7/8 08:32, Dave Chinner =E5=86=99=E9=81=93:
> On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
>> Currently all the filesystems implementing the
>> super_opearations::shutdown() callback can not afford losing a device.
>>
>> Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
>> involved filesystem.
>>
>> But it will no longer be the case, with multi-device filesystems like
>> btrfs and bcachefs the filesystem can handle certain device loss withou=
t
>> shutting down the whole filesystem.
>>
>> To allow those multi-device filesystems to be integrated to use
>> fs_holder_ops:
>>
>> - Replace super_opearation::shutdown() with
>>    super_opearations::remove_bdev()
>>    To better describe when the callback is called.
>=20
> This conflates cause with action.
>=20
> The shutdown callout is an action that the filesystem must execute,
> whilst "remove bdev" is a cause notification that might require an
> action to be take.
>=20
> Yes, the cause could be someone doing hot-unplug of the block
> device, but it could also be something going wrong in software
> layers below the filesystem. e.g. dm-thinp having an unrecoverable
> corruption or ENOSPC errors.
>=20
> We already have a "cause" notification: blk_holder_ops->mark_dead().
>=20
> The generic fs action that is taken by this notification is
> fs_bdev_mark_dead().  That action is to invalidate caches and shut
> down the filesystem.
>=20
> btrfs needs to do something different to a blk_holder_ops->mark_dead
> notification. i.e. it needs an action that is different to
> fs_bdev_mark_dead().
>=20
> Indeed, this is how bcachefs already handles "single device
> died" events for multi-device filesystems - see
> bch2_fs_bdev_mark_dead().

I do not think it's the correct way to go, especially when there is=20
already fs_holder_ops.

We're always going towards a more generic solution, other than letting=20
the individual fs to do the same thing slightly differently.

Yes, the naming is not perfect and mixing cause and action, but the end=20
result is still a more generic and less duplicated code base.

>=20
> Hence Btrfs should be doing the same thing as bcachefs. The
> bdev_handle_ops structure exists precisly because it allows the
> filesystem to handle block device events in the exact manner they
> require....
>=20
>> - Add a new @bdev parameter to remove_bdev() callback
>>    To allow the fs to determine which device is missing, and do the
>>    proper handling when needed.
>>
>> For the existing shutdown callback users, the change is minimal.
>=20
> Except for the change in API semantics. ->shutdown is an external
> shutdown trigger for the filesystem, not a generic "block device
> removed" notification.

The problem is, there is no one utilizing ->shutdown() out of=20
fs_bdev_mark_dead().

If shutdown ioctl is handled through super_operations::shutdown, it will=
=20
be more meaningful to split shutdown and dev removal.

But that's not the case, and different fses even have slightly different=
=20
handling for the shutdown flags (not all fses even utilize journal to=20
protect their metadata).

Thanks,
Qu


>=20
> Hooking blk_holder_ops->mark_dead means that btrfs can also provide
> a ->shutdown implementation for when something external other than a
> block device removal needs to shut down the filesystem....
>=20
> -Dave.

