Return-Path: <linux-fsdevel+bounces-52811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F1FAE7144
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1556A3BE757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D02566E2;
	Tue, 24 Jun 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kKPZ1RKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994C3074B5;
	Tue, 24 Jun 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799207; cv=none; b=KQx131SWFTY8PZyYbCyvIdmJ6Hyg/Vk+bwHJ38fB3PJiF8QqV9O7uKhUfffEHxz8uUJygC8tOlTSpJfrfz1RjMOlSYMbcWoHlGmRHHOexZFU8yDUHmfYT7y+zHG88Z/GntsFilQKfxqmmF3TSCQC4OGgtcO1d2xBLIy+ogvtTZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799207; c=relaxed/simple;
	bh=iH00NOPoob99oB2CH7I7kejxKqjAwcBvjTKajO6HZmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCPMeWKWG31g6vKGS6BtjkHqPBekopUkb1g7qeE5zHSQBSZnzGfGSVnJCh8Ifhonk62VEcmV3yfv2qPjpvTwLnlHLFKXh2RjLZvbbvvcgw/DAJfMbD2eRdoAv+3pZ3DV61AVXjouFRc9sOzR1/nV+uppMMfOMA0Vp1D7JQwwVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kKPZ1RKT; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750799183; x=1751403983; i=quwenruo.btrfs@gmx.com;
	bh=iH00NOPoob99oB2CH7I7kejxKqjAwcBvjTKajO6HZmE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kKPZ1RKTKIVa3RHip9cPjvLKKtrInoy8x+P0epMA+DSpW1VVQnVgoerymJ2n0Cro
	 85XEbn1R0QhEK4kBxR9PZwm8G+RD1VHHFv0phVg1978q/D97hCZvqSefk4IU9Alto
	 UnQ+QGFPqLxLujgetNZC/qNhWCmQEznNVBtmA39Df5VnmcIzt9DRn28Z4+Y4YPMxd
	 NjzkVD7xCeQmR2553MLvyVGMpzo9ZfC8I1nYVjvnxIsNMuPoYJGQJbiaXvEH89utH
	 4DkpTaTZcHNomVHGDWzpMHyrDDVc6Qtqg2HWm9POb3xs1X3Is6ATpFCJARJATWybL
	 eNGwQZpl8zuoJDQDTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1upZIC0tjn-00xodJ; Tue, 24
 Jun 2025 23:06:23 +0200
Message-ID: <eed720e5-2b1a-4177-bb5b-ef5c2cee955a@gmx.com>
Date: Wed, 25 Jun 2025 06:36:19 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
To: Christian Brauner <brauner@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk
References: <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
 <20250624-geerntet-haare-2ce4cc42b026@brauner>
 <8db82a80-242f-41ff-84b8-601d6dcd9b9d@suse.com>
 <20250624-briefe-hassen-f693b4fe3501@brauner>
 <abe98c94-b4e0-446b-90e7-c9cdb1c9d197@suse.com>
 <20250624-goldschatz-wohnviertel-aeb3209ad47b@brauner>
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
In-Reply-To: <20250624-goldschatz-wohnviertel-aeb3209ad47b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cdt/DUn6N4zcedTbz7fm6jK+XaB4uzE3gR/atOE8URxE58Ac7Ly
 uB7cfilVsvOFkxrL0Ex2bnKypLHFwqSYF4MJVlzeJhco0V6b8wKZMpefx46gReBQl5e5Gud
 ZbLyp0sfiEG/AjQ0pGlvNmGq2LZl1ngStaIIFBPACTjcbgVDy0Y7yW9F0d5dBGH2zepezzF
 ZCMj9HSqRCjGLWUVuLpBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cmmOsiyoerg=;WxAjMuCLMTWLaKMDCZOQiDFGlIQ
 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
 tcE+Vy/qoDbCgyF9iALWW7CnojCQw==



=E5=9C=A8 2025/6/24 19:45, Christian Brauner =E5=86=99=E9=81=93:
> On Tue, Jun 24, 2025 at 07:21:50PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/6/24 18:43, Christian Brauner =E5=86=99=E9=81=93:
>> [...]
>>>> It's not hard for btrfs to provide it, we already have a check functi=
on
>>>> btrfs_check_rw_degradable() to do that.
>>>>
>>>> Although I'd say, that will be something way down the road.
>>>
>>> Yes, for sure. I think long-term we should hoist at least the bare
>>> infrastructure for multi-device filesystem management into the VFS.
>>
>> Just want to mention that, "multi-device filesystem" already includes f=
ses
>> with external journal.
>=20
> Yes, that's what I meant below by "We've already done a bit of that".
> It's now possible to actually reach all devices associted with a
> filesystem from the block layer. It works for xfs and ext4 with
> journal fileystems. So for example, you can freeze the log device and
> the main device as the block layer is now able to find both and the fs
> stays frozen until both have been unfrozen. This wasn't possible before
> the rework we did.
>=20
> Now follows a tiny rant not targeted at you specifically but something
> that still bugs me in general:
>=20
> We had worked on extending this to btrfs so that it's all integrated
> properly with the block layer. And we heard long promises of how you
> would make that switch happen but refused us to let us make that switch.
> So now it's 2 years later and zero happend in that area.

I believe we (the btrfs community) are not intentionally rejecting this,=
=20
bad luck and lack of review bandwidth is involved, as at that time we're=
=20
focusing on migrating to the new fsconfig mount interface.

That delayed review of the original patchset from Christoph, then the=20
old series no longer applies due to the fsconfig change, until Johannes=20
revived the series for the first time.

Then even more (minor) conflicts with recent mount ro/rw mount fixes,=20
and although Johannes tried his best to refresh the series, those=20
conflicts eventually resulted test failures.


And I wasn't even following all those updates, until one day I'm=20
eventually freed from btrfs large folio support, and had time to attack=20
the long failure generic/730 due to lack of shutdown support.

Then I was dragged into the rabbit hole and finally we're here.


Also I have to admit, at least me do not have much experience in the=20
block/VFS field, and sometimes we still assume the existing=20
infrastructure is still mostly targeting single-ish block device=20
filesystems, but it's not true anymore.

We're improving this, and got quite some help from Christoph, e.g. he=20
contributed the btrfs bio layer to do all the bio split/chain inside btrfs=
.

I hope this remove_bdev() call back can be a good start point to bridge=20
the btrfs and block community closer.

>=20
> That also means block device freezing on btrfs is broken. If you freeze
> a block device used by btrfs via the dm (even though unlikely) layer you
> freeze the block device without btrfs being informed about that.

Yes, you're totally right and I also believe that may be the reason of=20
btrfs corruption after hibernation/suspension.

>=20
> It also means that block device removal is likely a bit yanky because
> btrfs won't be notified when any device other than the main device is
> suddenly yanked. You probably have logic there but the block layer can
> easily inform the filesystem about such an event nowadays and let it
> take appropriate action.

Yep, btrfs doesn't handling removal of devices at runtime at all, but=20
still tries to do IO on that device, only saved by the extra mirrors.

Meaning unless a user is monitoring the dmesg, one won't notice the=20
problem, which a huge degradation of availability happening silently.

>=20
> And fwiw, you also don't restrict writing to mounted block devices.
> That's another thing you blocked us from implementing even though we
> sent the changes for that already and so we disabled that in
> ead622674df5 ("btrfs: Do not restrict writes to btrfs devices"). So
> you're also still vulnerable to that stuff.

Oh, that's something new and let me explore this after all the=20
remove_bdev() callback thing.

Thanks,
Qu

>=20
>>
>> Thus the new callback may be a good chance for those mature fses to exp=
lore
>> some corner case availability improvement, e.g. the loss of the externa=
l
>> journal device while there is no live journal on it.
>=20
> Already handled for xfs and ext4 cleanly since our rework iiuc.
>=20
>> (I have to admin it's super niche, and live-migration to internal journ=
al
>> may be way more complex than my uneducated guess)
>>
>> Thanks,
>> Qu
>>
>>> Or we should at least explore whether that's feasible and if it's
>>> overall advantageous to maintenance and standardization. We've already
>>> done a bit of that and imho it's now a lot easier to reason about the
>>> basics already.
>>>
>>>>
>>>> We even don't have a proper way to let end user configure the device =
loss
>>>> behavior.
>>>> E.g. some end users may prefer a full shutdown to be extra cautious, =
other
>>>> than continue degraded.
>>>
>>> Right.
>>
>=20


