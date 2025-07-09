Return-Path: <linux-fsdevel+bounces-54319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED3BAFDC93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 02:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4854E1F49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 00:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EF3146588;
	Wed,  9 Jul 2025 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NrATP4Jw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E4B86359;
	Wed,  9 Jul 2025 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022528; cv=none; b=iaJeX82lTAxlIQ6bxogukVeVPr6FTAVgkxvF4knKUCmzZ8hiudJgOsYpRb6GzTlRzX1+f++5S6oZlqbFJM1MYW3r6+8XmndEt3rETsrYov/wLD/ETrD3mPwlghFBYsC0ybY/Q2+GKnpM0pU9X3FH4dOKhv0IJMSNJqJa9OLztag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022528; c=relaxed/simple;
	bh=IR8dXPs/OqKIwE9zCsW4desmv5ZaWYFly+NbBszb4CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJQVSB9JElm+kTUjwjfX3wd5yT+OMgMaQspMlTawvoNLU6ln2znqa2G6xJlD12Qlr8CRp5dLX6bsuhoKgesENELRHyTipT0E9MY16EKUEFUmChFbHaI5d+YK2BlTVzPci76/vL1cYW/92dod4dPQz/07PQxAyLStzpJZA3zWv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NrATP4Jw; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752022517; x=1752627317; i=quwenruo.btrfs@gmx.com;
	bh=J7Noojv8EhaGmsF8cdDLD8Vh1yUJu0qM0pvHlEj+l9I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NrATP4JwKJI/Jk/YtvsohJRowJENTHCQ90LCIfD5MV4KpABIez/SGgFnFoGr0sAT
	 6CKnXuD2S8zrnlYXcE6hxxpNWdWMnF501cyMQTEuhsjZDPKCZklas+WjQa+m2E+Cj
	 ty2zTeJqr4wrmUmgP9RetYsQ3A9nQr5+Gg6i57EJqp3KibX5od+B46cTVctWKx/3O
	 gaE7qR3I3XC0F6x8+bJ3R7ilWQirKYAUkXX/gmdyhhj48Yegb6InjWPOI0PWNbQFS
	 U/YRbSZhU/C3kDt4Nhf2e88McB/MZ+pWsNeoR2ZPAg6IOt46PODLqbqlRx29jWnaW
	 cKM73T+Vy889i4Uyyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQj7-1uRGbA0A4T-006Owy; Wed, 09
 Jul 2025 02:55:17 +0200
Message-ID: <eb7c3b1c-b5c0-4078-9a88-327f1220cae8@gmx.com>
Date: Wed, 9 Jul 2025 10:25:08 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Christian Brauner
 <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <20250708-geahndet-rohmaterial-0419fd6a76b3@brauner>
 <aG2i3qP01m-vmFVE@dread.disaster.area>
 <00f5c2a2-4216-4eeb-b555-ef49f8cfd447@gmx.com>
 <lcbj2r4etktljckyv3q4mgryvwqsbl7pwe6sqdtyfwgmunhkov@4oinzvvnt44s>
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
In-Reply-To: <lcbj2r4etktljckyv3q4mgryvwqsbl7pwe6sqdtyfwgmunhkov@4oinzvvnt44s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KoRb14HHFIAA+xqWmHqOQOGOiXTovP17rrEdeiqQxz8aS+6I5Tb
 rhHCePgI9F49lmQs60u319Dd0Lq0RzAW22Jtsfjd2DXnag5nje5Nl6cgBKyT+m0SIociET6
 wCrOSY2ZsdYkY9sCzzk9qQQt2wJfrOsp3A6uQBSZ8wXXwTh8b49w2ljv5K9slLAy/cXQtFo
 9EhGpkqbThnDWor1J0YnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jmQnZt7y5Qg=;d3CB1vWdsEGlq9XHF3omUXIjtiY
 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
 012xsk4XwNAK6aJyA6oxhs7NZsa4D1yw=



=E5=9C=A8 2025/7/9 10:05, Kent Overstreet =E5=86=99=E9=81=93:
> On Wed, Jul 09, 2025 at 08:37:05AM +0930, Qu Wenruo wrote:
>> =E5=9C=A8 2025/7/9 08:29, Dave Chinner =E5=86=99=E9=81=93:
>>> On Tue, Jul 08, 2025 at 09:55:14AM +0200, Christian Brauner wrote:
>>>> On Mon, Jul 07, 2025 at 05:45:32PM -0700, Darrick J. Wong wrote:
>>>>> On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> =E5=9C=A8 2025/7/8 08:32, Dave Chinner =E5=86=99=E9=81=93:
>>>>>>> On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
>>>>>>>> Currently all the filesystems implementing the
>>>>>>>> super_opearations::shutdown() callback can not afford losing a de=
vice.
>>>>>>>>
>>>>>>>> Thus fs_bdev_mark_dead() will just call the shutdown() callback f=
or the
>>>>>>>> involved filesystem.
>>>>>>>>
>>>>>>>> But it will no longer be the case, with multi-device filesystems =
like
>>>>>>>> btrfs and bcachefs the filesystem can handle certain device loss =
without
>>>>>>>> shutting down the whole filesystem.
>>>>>>>>
>>>>>>>> To allow those multi-device filesystems to be integrated to use
>>>>>>>> fs_holder_ops:
>>>>>>>>
>>>>>>>> - Replace super_opearation::shutdown() with
>>>>>>>>      super_opearations::remove_bdev()
>>>>>>>>      To better describe when the callback is called.
>>>>>>>
>>>>>>> This conflates cause with action.
>>>>>>>
>>>>>>> The shutdown callout is an action that the filesystem must execute=
,
>>>>>>> whilst "remove bdev" is a cause notification that might require an
>>>>>>> action to be take.
>>>>>>>
>>>>>>> Yes, the cause could be someone doing hot-unplug of the block
>>>>>>> device, but it could also be something going wrong in software
>>>>>>> layers below the filesystem. e.g. dm-thinp having an unrecoverable
>>>>>>> corruption or ENOSPC errors.
>>>>>>>
>>>>>>> We already have a "cause" notification: blk_holder_ops->mark_dead(=
).
>>>>>>>
>>>>>>> The generic fs action that is taken by this notification is
>>>>>>> fs_bdev_mark_dead().  That action is to invalidate caches and shut
>>>>>>> down the filesystem.
>>>>>>>
>>>>>>> btrfs needs to do something different to a blk_holder_ops->mark_de=
ad
>>>>>>> notification. i.e. it needs an action that is different to
>>>>>>> fs_bdev_mark_dead().
>>>>>>>
>>>>>>> Indeed, this is how bcachefs already handles "single device
>>>>>>> died" events for multi-device filesystems - see
>>>>>>> bch2_fs_bdev_mark_dead().
>>>>>>
>>>>>> I do not think it's the correct way to go, especially when there is=
 already
>>>>>> fs_holder_ops.
>>>>>>
>>>>>> We're always going towards a more generic solution, other than lett=
ing the
>>>>>> individual fs to do the same thing slightly differently.
>>>>>
>>>>> On second thought -- it's weird that you'd flush the filesystem and
>>>>> shrink the inode/dentry caches in a "your device went away" handler.
>>>>> Fancy filesystems like bcachefs and btrfs would likely just shift IO=
 to
>>>>> a different bdev, right?  And there's no good reason to run shrinker=
s on
>>>>> either of those fses, right?
>>>>>
>>>>>> Yes, the naming is not perfect and mixing cause and action, but the=
 end
>>>>>> result is still a more generic and less duplicated code base.
>>>>>
>>>>> I think dchinner makes a good point that if your filesystem can do
>>>>> something clever on device removal, it should provide its own block
>>>>> device holder ops instead of using fs_holder_ops.  I don't understan=
d
>>>>> why you need a "generic" solution for btrfs when it's not going to d=
o
>>>>> what the others do anyway.
>>>>
>>>> I think letting filesystems implement their own holder ops should be
>>>> avoided if we can. Christoph may chime in here. I have no appettite f=
or
>>>> exporting stuff like get_bdev_super() unless absolutely necessary. We
>>>> tried to move all that handling into the VFS to eliminate a slew of
>>>> deadlocks we detected and fixed. I have no appetite to repeat that
>>>> cycle.
>>>
>>> Except it isn't actually necessary.
>>>
>>> Everyone here seems to be assuming that the filesystem *must* take
>>> an active superblock reference to process a device removal event,
>>> and that is *simply not true*.
>>>
>>> bcachefs does not use get_bdev_super() or an active superblock
>>> reference to process ->mark_dead events.
>>
>> Yes, bcachefs doesn't go this path, but the reason is more important.
>>
>> Is it just because there is no such callback so that Kent has to come u=
p his
>> own solution, or something else?
>>
>> If the former case, all your argument here makes no sense.
>>
>> Adding Kent here to see if he wants a more generic s_op->remove_bdev()
>> solution or the current each fs doing its own mark_dead() callback.
>=20
> Consider that the thing that has a block device open might not even be a
> filesystem, or at least a VFS filesystem.
>=20
> It could be a stacking block device driver - md or md - and those
> absolutely should be implementing .mark_dead() (likely passing it
> through on up the stack), or something else entirely.
>=20
> In bcachefs's case, we might not even have created the VFS super_block
> yet: we don't do that until after recovery finishes, and indeed we can't
> because creating a super_block and leaving it in !SB_BORN will cause
> such fun as sync calls to hang for the entire system...
>=20

Not related to the series, but IIRC if s_flags doesn't have SB_ACTIVE=20
set, things like bdev_super_lock() won't choose that superblock, thus=20
won't call ->sync() callback through the bdev callbacks.

And btrfs also follows the same scheme, only setting SB_ACTIVE after=20
everything is done (including replaying the log etc), and so far we=20
haven't yet hit such sync during mount.

Thanks,
Qu

