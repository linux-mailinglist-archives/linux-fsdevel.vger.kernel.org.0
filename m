Return-Path: <linux-fsdevel+bounces-54312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9741FAFDABC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 00:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D26A3BFC0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 22:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0B253F03;
	Tue,  8 Jul 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lc/jmtzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789AAD21;
	Tue,  8 Jul 2025 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012762; cv=none; b=YZqTrtidqyHbtA4/HF7MLJvkd0mmHhXZXkoENig9nWSWD9tXgciv7OtA4VruXQR4EnEJepgi181SljT7R5Nq6d4CvuG8CBqFTvuLqAUnAF5oPhR7Mxqq6KajLNDfb70RleqgCE+c2/+fOA0I51Ui2BSnqtsv/WPsJD7r7l46ODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012762; c=relaxed/simple;
	bh=qz7OfKvy9UkusQ0pIiJ8C7Vv6iWfvqCTDZ2EafqNzfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxUEV5Mt+E3kLkAucX/hHOapDj8iLOv8rXw4DwGX95QkcUwWG/muQIzxFujodqzyUXBPY28DuOFaBlBUpXW+gRkSiUfqmSCePFDWCvY/loYqZ+SwAcO6IvEnutuUX4yleVuHOuHcf4KyWHAP/AdHX53mtZh61gUSjgqjEviS8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lc/jmtzs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752012737; x=1752617537; i=quwenruo.btrfs@gmx.com;
	bh=tKiXQzcJnHUoFYy1SQwgQQJ2Y4OJhs4iWApYS2UOz0w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lc/jmtzsvIfILu3IOxjndYwN0WxXgGlEKxLrIeJ57F4ESKQP52XCEvwyg5mIPZuQ
	 iCOEG9eFjdarPpeMtymVoon7hSNEIDqnDINnwezhhFkQq7JZuhq0cE1H9a9Kujh41
	 3DwNiLTITql/IjHRkIt6zLMtzTy8rMHYE4KCucWvHgbHNYJ7h9UwTvXJYn7aDQtDI
	 uSEnn07wvm6qV0MPw8G9kQOxybqtZEtQa7k4/3d6lj+4nXTOvxzHWZQW75jmeDM2F
	 qn8IuFTdNTWfsBA1kDVyWGQso+6yGydsTZlsmRuNanWGKfV00ZHYRLEoejKSPUa8B
	 WJG9TFWhhJLjr4MKeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mirng-1vBbVc3I9s-00qUDJ; Wed, 09
 Jul 2025 00:12:17 +0200
Message-ID: <debab09d-5eb8-4742-96f4-b2c39233f9b7@gmx.com>
Date: Wed, 9 Jul 2025 07:42:11 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
To: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev,
 linux-xfs@vger.kernel.org
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <2dm6bsup7vxwl4vwmllkvt5erncirr272bov4ehd5gix7n2vnw@bkagb26tjtj5>
 <20250708202050.GG2672049@frogsfrogsfrogs>
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
In-Reply-To: <20250708202050.GG2672049@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1aTVJTVlu9i6lCW/LoieK4tzGVQNDEqTWrn2So/d5vdAo2no05b
 w7fxbRr0HI5ATdhhPmCGZPEkmqpkJ06eckuxn3KXOoJZ+jtOdc/VWu6gU9kUhR9FT/CvMDx
 Mam0v4a14/lWOLR0IfklHjEv5QOt8D4pJlHHww46UvqoSrf7Uw9cSa79lxxIVDyy3wOoYWk
 lEu2TtQLbqiPLWPbm4oQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:geYc7ZXsxis=;bu5kTzrVCY6/wrS/1m+bAkP1XZE
 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



=E5=9C=A8 2025/7/9 05:50, Darrick J. Wong =E5=86=99=E9=81=93:
[...]
>> Well, I'd also say just go for own fs_holder_ops if it was not for the
>> awkward "get super from bdev" step. As Christian wrote we've encapsulat=
ed
>> that in fs/super.c and bdev_super_lock() in particular but the calling
>> conventions for the fs_holder_ops are not very nice (holding
>> bdev_holder_lock, need to release it before grabbing practically anythi=
ng
>> else) so I'd have much greater peace of mind if this didn't spread too
>> much. Once you call bdev_super_lock() and hold on to sb with s_umount h=
eld,
>> things are much more conventional for the fs land so I'd like if this
>> step happened before any fs hook got called. So I prefer something like
>> Qu's proposal of separate sb op for device removal over exporting
>> bdev_super_lock(). Like:
>>
>> static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>> {
>>          struct super_block *sb;
>>
>>          sb =3D bdev_super_lock(bdev, false);
>>          if (!sb)
>>                  return;
>>
>> 	if (sb->s_op->remove_bdev) {
>> 		sb->s_op->remove_bdev(sb, bdev, surprise);

The only concern here is, remove_bdev() will handle two different things:

- Mark the target devices as missing and continue working
   Of course that's when the fs can handle it.

- Shutdown
   If the fs can not handle it.

And if the fs has to shutdown, we're missing all the shrinks in the=20
shutdown path.

Thus I'd prefer the remove_bdev() to have a return value, so that we can=
=20
fallback to shutdown path if the remove_bdev() failed.

This also aligns more towards Brauner's idea that we may want to expose=20
if the fs can handle the removal.

Thanks,
Qu

>> 		return;
>> 	}
>=20
> It feels odd but I could live with this, particularly since that's the
> direction that brauner is laying down. :)
>=20
> Do we still need to super_unlock_shared here?
>=20
> --D
>=20
>>
>> 	if (!surprise)
>> 		sync_filesystem(sb);
>> 	shrink_dcache_sb(sb);
>> 	evict_inodes(sb);
>> 	if (sb->s_op->shutdown)
>> 		sb->s_op->shutdown(sb);
>>
>> 	super_unlock_shared(sb);
>> }
>>
>>> As an aside:
>>> 'twould be nice if we could lift the *FS_IOC_SHUTDOWN dispatch out of
>>> everyone's ioctl functions into the VFS, and then move the "I am dead"
>>> state into super_block so that you could actually shut down any
>>> filesystem, not just the seven that currently implement it.
>>
>> Yes, I should find time to revive that patch series... It was not *that=
*
>> hard to do.
>>
>> 								Honza
>> --=20
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
>>


