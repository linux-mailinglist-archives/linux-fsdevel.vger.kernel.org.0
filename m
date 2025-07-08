Return-Path: <linux-fsdevel+bounces-54316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2FAFDB85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 01:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF01AA18CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730D231A21;
	Tue,  8 Jul 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="i4pf8EKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF512FF69;
	Tue,  8 Jul 2025 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016039; cv=none; b=OyehqiQkq8a9VAj1Czvx9fDTMtCylcgouI1fUIacAvn+tTOys1rqGVTwly/5ga7eODNOolUIEXZ0oi7FxNc1Z6qYvTSRbfEMSFjweIZKZICmGlku4ARQebht3AB8mnrXcAngVG3vmj8Rei2wJund75Z1fjuDVzVNQcZlv3t3/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016039; c=relaxed/simple;
	bh=W1WHwgkDMdMsKd9bO2IuL/SRhqUNzsCIeZJQPuA9FYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uE2I0Gttk8ktPTkVHVjdThRmcJHmNPf3dccqRwtkIcxHgmNSdlTg/Z1waBhnmx+uSFm5u6XDhuiyV/4Z1eLYj5h2KhOnqfb5pQ2Itq3SbWXPJF5fQMlxH2QcQegpJhn9lJ2i1yjKKS1qS8DK/AwXHKJgWU2ylRGpvmf74BBZ8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=i4pf8EKF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752016034; x=1752620834; i=quwenruo.btrfs@gmx.com;
	bh=cCQMtvwE0mNayWpvuapXEW0romZ3tVtpbG7Lv3AsWFA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i4pf8EKFeIoWpfqPsXZYMyeE+6T+whwPw5w9rP+mHZIjCu0oiaSG4bXrGEU98aNI
	 on0B0J1cMyD2aADLMytxit8sb7aWDpc0OB4aBwHB/CP3Y7OuBNRilOgL2CUDpKgqs
	 bijoJUjohZ+w5NE+PUqx5LtoCzVsdVzZiE34aqY4SkNqe18Vlevum45vhjpqniLyh
	 +oNZSUmbJRRN70SBZPPtZ/SF6MGHegO7SRTtVe1fglC0W+W2OrUfW9SzcQkRsu97s
	 LZvLfSovA7B9LAdnILsp3dqJ+YEI9h0PkJiSHhsv7DB4OlNxWbPkSaYahmB6KTzTe
	 DOz1VR7Kl25vC2/cXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1v0LxE17Vd-00fkCB; Wed, 09
 Jul 2025 01:07:13 +0200
Message-ID: <00f5c2a2-4216-4eeb-b555-ef49f8cfd447@gmx.com>
Date: Wed, 9 Jul 2025 08:37:05 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
To: Dave Chinner <david@fromorbit.com>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev,
 linux-xfs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <20250708-geahndet-rohmaterial-0419fd6a76b3@brauner>
 <aG2i3qP01m-vmFVE@dread.disaster.area>
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
In-Reply-To: <aG2i3qP01m-vmFVE@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:paNGj6ylr6iQz3ydUbolGyyQuT3DFdLzYnRgrgGXO6m3nvNy43S
 TawhOSazFwGac1Ie3E+Vp60tp3UZ9Y2leLV1unV5bBcg8XKx6AA6TXH1TD7/BEzhwPBEdBB
 vavDNJMLbiNdhECLKgfaSuY/D93lTIrVazjpHNN+vgxnj+bX43jJaYP4uenge5hjTuGCnlw
 spiCSNHw1yGS3XjigN7qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vDqChiyReGA=;EBS2Kh860vT4bMlBx37uQgO01Vy
 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
 r5+WbbMk1GtQwoU/NYacPopJkA7zbMQg=



=E5=9C=A8 2025/7/9 08:29, Dave Chinner =E5=86=99=E9=81=93:
> On Tue, Jul 08, 2025 at 09:55:14AM +0200, Christian Brauner wrote:
>> On Mon, Jul 07, 2025 at 05:45:32PM -0700, Darrick J. Wong wrote:
>>> On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2025/7/8 08:32, Dave Chinner =E5=86=99=E9=81=93:
>>>>> On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
>>>>>> Currently all the filesystems implementing the
>>>>>> super_opearations::shutdown() callback can not afford losing a devi=
ce.
>>>>>>
>>>>>> Thus fs_bdev_mark_dead() will just call the shutdown() callback for=
 the
>>>>>> involved filesystem.
>>>>>>
>>>>>> But it will no longer be the case, with multi-device filesystems li=
ke
>>>>>> btrfs and bcachefs the filesystem can handle certain device loss wi=
thout
>>>>>> shutting down the whole filesystem.
>>>>>>
>>>>>> To allow those multi-device filesystems to be integrated to use
>>>>>> fs_holder_ops:
>>>>>>
>>>>>> - Replace super_opearation::shutdown() with
>>>>>>     super_opearations::remove_bdev()
>>>>>>     To better describe when the callback is called.
>>>>>
>>>>> This conflates cause with action.
>>>>>
>>>>> The shutdown callout is an action that the filesystem must execute,
>>>>> whilst "remove bdev" is a cause notification that might require an
>>>>> action to be take.
>>>>>
>>>>> Yes, the cause could be someone doing hot-unplug of the block
>>>>> device, but it could also be something going wrong in software
>>>>> layers below the filesystem. e.g. dm-thinp having an unrecoverable
>>>>> corruption or ENOSPC errors.
>>>>>
>>>>> We already have a "cause" notification: blk_holder_ops->mark_dead().
>>>>>
>>>>> The generic fs action that is taken by this notification is
>>>>> fs_bdev_mark_dead().  That action is to invalidate caches and shut
>>>>> down the filesystem.
>>>>>
>>>>> btrfs needs to do something different to a blk_holder_ops->mark_dead
>>>>> notification. i.e. it needs an action that is different to
>>>>> fs_bdev_mark_dead().
>>>>>
>>>>> Indeed, this is how bcachefs already handles "single device
>>>>> died" events for multi-device filesystems - see
>>>>> bch2_fs_bdev_mark_dead().
>>>>
>>>> I do not think it's the correct way to go, especially when there is a=
lready
>>>> fs_holder_ops.
>>>>
>>>> We're always going towards a more generic solution, other than lettin=
g the
>>>> individual fs to do the same thing slightly differently.
>>>
>>> On second thought -- it's weird that you'd flush the filesystem and
>>> shrink the inode/dentry caches in a "your device went away" handler.
>>> Fancy filesystems like bcachefs and btrfs would likely just shift IO t=
o
>>> a different bdev, right?  And there's no good reason to run shrinkers =
on
>>> either of those fses, right?
>>>
>>>> Yes, the naming is not perfect and mixing cause and action, but the e=
nd
>>>> result is still a more generic and less duplicated code base.
>>>
>>> I think dchinner makes a good point that if your filesystem can do
>>> something clever on device removal, it should provide its own block
>>> device holder ops instead of using fs_holder_ops.  I don't understand
>>> why you need a "generic" solution for btrfs when it's not going to do
>>> what the others do anyway.
>>
>> I think letting filesystems implement their own holder ops should be
>> avoided if we can. Christoph may chime in here. I have no appettite for
>> exporting stuff like get_bdev_super() unless absolutely necessary. We
>> tried to move all that handling into the VFS to eliminate a slew of
>> deadlocks we detected and fixed. I have no appetite to repeat that
>> cycle.
>=20
> Except it isn't actually necessary.
>=20
> Everyone here seems to be assuming that the filesystem *must* take
> an active superblock reference to process a device removal event,
> and that is *simply not true*.
>=20
> bcachefs does not use get_bdev_super() or an active superblock
> reference to process ->mark_dead events.

Yes, bcachefs doesn't go this path, but the reason is more important.

Is it just because there is no such callback so that Kent has to come up=
=20
his own solution, or something else?

If the former case, all your argument here makes no sense.

Adding Kent here to see if he wants a more generic s_op->remove_bdev()=20
solution or the current each fs doing its own mark_dead() callback.

Thanks,
Qu

