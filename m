Return-Path: <linux-fsdevel+bounces-54455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A0AFFE88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 11:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890501BC538D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00DF2D5419;
	Thu, 10 Jul 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tbG8CSmE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CD289361;
	Thu, 10 Jul 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141327; cv=none; b=HDmXKePf4zFMfIV8pRBmT0+OGYG/hz2bHN+I1aSEQc3D+tsMaJthxzHGmb9WaQFh7yJV4y6tHxLuDyCWki1H7q8ndJn5JTAdzrPxnpoKc8tGq0JxLXUUVqK/BqtiOV0JCQgt19tPGNEW5le3DGmXwlYXN/kqDVr8Oa3uYADv/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141327; c=relaxed/simple;
	bh=e9qUisRxwwidKFvRTK7OGyfwL2wMUXU5bOAVnlE+XLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTG6ZrVyNHPik2DADAKBueIUDoDMg1UkXI+tzPxhBDX2MU2BD2bGmdOjLLkl3WNfFvAQGEQYDaikzOXqmJcWp5RfWokMlIaOVAnd++ZLhQFIE6AtXQAHv0Xj23UCsbhw+FR5uMKbV1d0yhEyFW8UADLSjgTsjCycnCNR6tbh32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tbG8CSmE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752141300; x=1752746100; i=quwenruo.btrfs@gmx.com;
	bh=aR7vXnpCePeT/rE72CbwBDX2iPnDc0SYSzqKSb+99mo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tbG8CSmElvb/jdsqnNKFpxQgJJsSHIAE48BWVajnLAAj4Ev8QLYcrqMynTIC7Oe9
	 Rqryg0pYKffdQcg9lSxfeWrkHbXOZs1A4sgKii3aghuarOAX2QHCh48d6/mSYMoRy
	 c13cR1pvZvTj1zzWmz0PKVZm2tm1O3cs8A6UYQNWO8lqivz720QyGTBpg1fBQ2XiS
	 7ySQK1Old2eIeA0KyiWTfwACEUZLY9zezjFyFo6TmIAQ2ESQySgKtpdcI01y/cedY
	 bqyRZy3L+ZR1vNOfr6AwyHj+19wdCMEsEc0s9t2V+JikrTuKlg8a+yZ/D8vhlx7yU
	 /bcDKN4rdmD2v6fr+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsUp-1uRJvg2l6V-005qzo; Thu, 10
 Jul 2025 11:55:00 +0200
Message-ID: <9bce3d22-5ea2-4a95-9a7e-fc391ae9a2b6@gmx.com>
Date: Thu, 10 Jul 2025 19:24:46 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
To: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <2dm6bsup7vxwl4vwmllkvt5erncirr272bov4ehd5gix7n2vnw@bkagb26tjtj5>
 <20250708202050.GG2672049@frogsfrogsfrogs>
 <20250710-sitzung-gelaufen-4ee804949772@brauner>
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
In-Reply-To: <20250710-sitzung-gelaufen-4ee804949772@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zk/p0EZft3KrOgVt/nIdYjYIWl4uxNLAUTaU28CGhNHADEN8Xwc
 LIt3HWN00a8X+SmFKF+Nv/Tc72dJnAyqikjcWphxEhqHIAaI+JYUbV5SRncKHjvU0mNMtnk
 /hBIGgNkzShL/SLmAOjTykg3dP6TycQiScfYF9OiwtM75F8ujgunAko55zoZRGZ24Wp2FcD
 eL5Ym8R5+sc3ry0clxx8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9ifGE7fFVRM=;YBkCltU6DVBZBukXR8SicoJuadT
 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
 B6/QvLIQLd9CZsiNEK/jIAo=



=E5=9C=A8 2025/7/10 18:10, Christian Brauner =E5=86=99=E9=81=93:
> On Tue, Jul 08, 2025 at 01:20:50PM -0700, Darrick J. Wong wrote:
>> On Tue, Jul 08, 2025 at 12:20:00PM +0200, Jan Kara wrote:
>>> On Mon 07-07-25 17:45:32, Darrick J. Wong wrote:
>>>> On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
>>>>> =E5=9C=A8 2025/7/8 08:32, Dave Chinner =E5=86=99=E9=81=93:
>>>>>> On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
>>>>>>> Currently all the filesystems implementing the
>>>>>>> super_opearations::shutdown() callback can not afford losing a dev=
ice.
>>>>>>>
>>>>>>> Thus fs_bdev_mark_dead() will just call the shutdown() callback fo=
r the
>>>>>>> involved filesystem.
>>>>>>>
>>>>>>> But it will no longer be the case, with multi-device filesystems l=
ike
>>>>>>> btrfs and bcachefs the filesystem can handle certain device loss w=
ithout
>>>>>>> shutting down the whole filesystem.
>>>>>>>
>>>>>>> To allow those multi-device filesystems to be integrated to use
>>>>>>> fs_holder_ops:
>>>>>>>
>>>>>>> - Replace super_opearation::shutdown() with
>>>>>>>     super_opearations::remove_bdev()
>>>>>>>     To better describe when the callback is called.
>>>>>>
>>>>>> This conflates cause with action.
>>>>>>
>>>>>> The shutdown callout is an action that the filesystem must execute,
>>>>>> whilst "remove bdev" is a cause notification that might require an
>>>>>> action to be take.
>>>>>>
>>>>>> Yes, the cause could be someone doing hot-unplug of the block
>>>>>> device, but it could also be something going wrong in software
>>>>>> layers below the filesystem. e.g. dm-thinp having an unrecoverable
>>>>>> corruption or ENOSPC errors.
>>>>>>
>>>>>> We already have a "cause" notification: blk_holder_ops->mark_dead()=
.
>>>>>>
>>>>>> The generic fs action that is taken by this notification is
>>>>>> fs_bdev_mark_dead().  That action is to invalidate caches and shut
>>>>>> down the filesystem.
>>>>>>
>>>>>> btrfs needs to do something different to a blk_holder_ops->mark_dea=
d
>>>>>> notification. i.e. it needs an action that is different to
>>>>>> fs_bdev_mark_dead().
>>>>>>
>>>>>> Indeed, this is how bcachefs already handles "single device
>>>>>> died" events for multi-device filesystems - see
>>>>>> bch2_fs_bdev_mark_dead().
>>>>>
>>>>> I do not think it's the correct way to go, especially when there is =
already
>>>>> fs_holder_ops.
>>>>>
>>>>> We're always going towards a more generic solution, other than letti=
ng the
>>>>> individual fs to do the same thing slightly differently.
>>>>
>>>> On second thought -- it's weird that you'd flush the filesystem and
>>>> shrink the inode/dentry caches in a "your device went away" handler.
>>>> Fancy filesystems like bcachefs and btrfs would likely just shift IO =
to
>>>> a different bdev, right?  And there's no good reason to run shrinkers=
 on
>>>> either of those fses, right?
>>>
>>> I agree it is awkward and bcachefs avoids these in case of removal it =
can
>>> handle gracefully AFAICS.
>>>
>>>>> Yes, the naming is not perfect and mixing cause and action, but the =
end
>>>>> result is still a more generic and less duplicated code base.
>>>>
>>>> I think dchinner makes a good point that if your filesystem can do
>>>> something clever on device removal, it should provide its own block
>>>> device holder ops instead of using fs_holder_ops.  I don't understand
>>>> why you need a "generic" solution for btrfs when it's not going to do
>>>> what the others do anyway.
>>>
>>> Well, I'd also say just go for own fs_holder_ops if it was not for the
>>> awkward "get super from bdev" step. As Christian wrote we've encapsula=
ted
>>> that in fs/super.c and bdev_super_lock() in particular but the calling
>>> conventions for the fs_holder_ops are not very nice (holding
>>> bdev_holder_lock, need to release it before grabbing practically anyth=
ing
>>> else) so I'd have much greater peace of mind if this didn't spread too
>>> much. Once you call bdev_super_lock() and hold on to sb with s_umount =
held,
>>> things are much more conventional for the fs land so I'd like if this
>>> step happened before any fs hook got called. So I prefer something lik=
e
>>> Qu's proposal of separate sb op for device removal over exporting
>>> bdev_super_lock(). Like:
>>>
>>> static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise=
)
>>> {
>>>          struct super_block *sb;
>>>
>>>          sb =3D bdev_super_lock(bdev, false);
>>>          if (!sb)
>>>                  return;
>>>
>>> 	if (sb->s_op->remove_bdev) {
>>> 		sb->s_op->remove_bdev(sb, bdev, surprise);
>>> 		return;
>>> 	}
>>
>> It feels odd but I could live with this, particularly since that's the
>> direction that brauner is laying down. :)
>=20
> I want to reiterate that no one is saying "under no circumstances
> implement your own holder ops". But if you rely on the VFS locking then
> you better not spill it's guts into your filesystem and make us export
> this bloody locking that half the world had implemented wrong in their
> drivers in the first places spewing endless syzbot deadlocks reports
> that we had to track down and fix. That will not happen again similar
> way we don't bleed all the nastiness of other locking paths.
>=20
> Please all stop long philosophical treatises about things no on has ever
> argued. btrfs wants to rely on the VFS infra. That is fine and well. We
> will support and enable this.
>=20
> I think the two method idea is fine given that they now are clearly
> delineated.
>=20
> Thanks for providing some clarity here, Darrick and Qu.
>=20

So the next update would be something like this for fs_bdev_mark_dead():

	sb =3D bdev_super_lock();
	if (!sb)
		return;
	if (!surprise)
		sync_filesystem(sb);
+	if (sb->s_op->remove_bdev) {
+		ret =3D sb->s_op->remove_bdev();
+		if (!ret) {
+			/* Fs can handle the dev loss. */
+			super_unlock_shared();
+			return;
+		}
+	}
+	/* Fs can not handle the dev loss, shutdown. */
	shrink_dcache_sb();
	evict_inodes();
	if (sb->s_op->shutdown)
		sb->s_op->shutdown();
	super_unlock_shared();

This means ->remove_bdev() must have a return value to indicate if the=20
fs can handle the loss.
And any error, no matter if it's not enough tolerance from the fs or=20
some other problem during the dev loss handling, the old shutdown=20
behavior will be triggered.

Would this be an acceptable solution?

Thanks,
Qu

