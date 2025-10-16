Return-Path: <linux-fsdevel+bounces-64396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06562BE592B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 23:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102C55855E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE202DFA31;
	Thu, 16 Oct 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XFjYvqj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6F21ADB9;
	Thu, 16 Oct 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650291; cv=none; b=kzaOqAm4n8Al7f3x3qqPM+QZ+tf535Tan4qeu+kmTjNDQF5hdMMUrWjBEVL0bAuVeTlLhlyiaiAr3wL8H2+A3GQE7URknUbK/a6ObZ1+eREdsmm1uCohbMRsmQZyErKK1nVsVCyCybx/4d6i9aRBP+qRNACq4PykUPPpReGetKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650291; c=relaxed/simple;
	bh=nbVEIyu2OmxN9T2NhsCDZHATHuCid5n6l/jI5zNb8NQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=iTnL+8hEzvJl5sTOpSKxB0LAPT+ONOi1MsfxFzFf6p6mzGttHRr0iv68L9vs0+Nm7VJ4WuJWQ1EdGM0d7kf+neoLOEd8RkF5+O72bwwr2COm3gSPo27Z4s/EWuDGJMd0WCHCN40g1Gl4yx6yAEV1QZssO6eLpb5XCb4NbUFkAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XFjYvqj4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760650287; x=1761255087; i=quwenruo.btrfs@gmx.com;
	bh=nbVEIyu2OmxN9T2NhsCDZHATHuCid5n6l/jI5zNb8NQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XFjYvqj41yV65e2nF0PTLvmfzkW04Jw6AU39tbU7H1AsKntucgcyiP7iVSXKR0XN
	 p0si1ijQayZ9ojHiN7/BRiZBMbIptGkoULzZdJdxYkbTaF6fc47VqEuko+//VwxTU
	 qZl8HUHLsO6FrkNzdiC2vPqunulYqrZPpSzpfUSuEIKP0r9KBbovw5wMT883nGJWJ
	 PnGaw2id2Nvl9Y0KmWYtKBHa1iPmV+LSdg7MBpwPJrIENBkVqxyiuNImW9z92yq+m
	 /YIu1PkTMdaSfMgZQsg3LgM06DPEhBnliR3ErH42aRCur6EXi8GvQ6uu+ZYTFpAFB
	 TGVzXNu9CFc0m0K08w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOiHf-1ur2Zu46IB-00Qc5W; Thu, 16
 Oct 2025 23:31:26 +0200
Message-ID: <3a77483d-d8c3-4e1b-8189-70a2a741517e@gmx.com>
Date: Fri, 17 Oct 2025 08:01:23 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-pm@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Long running ioctl and pm, which should have higher priority?
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZXtsi07HFk0b8zbP8k0YNtWgNUkUCTJtBJmuRNW/ucFhuZzAU3f
 X0MXoFJbv4an5/lpcrm4iAdTkvt8xejYB5W0ZwMoWEEqj3jzUnSe2znNdToZ0lY1696HrdN
 Wcx3lpwcZ87JWxHJ9MOpAUHT6/8F+HPO45nedlQoyyExJn4XRyBQve/WDxI7OiI3DbL20PZ
 y6Jb6ObrKZhwPXDeoVcYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:22x/BDxslaA=;7pNgfHPs89ntft62DbHBP8ZXaeJ
 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
 RiyKQ==

Hi,

Recently I'm dealing with a bug that long running btrfs ioctls (e.g.=20
scrub, dev-replace, relocation etc) can block pm suspension/hibernation.

The reason is not that hard to understand, pm requires all user=20
processes to be frozen, which requires them to return to the user space,=
=20
thus long running ioctl will break that requirement and leads to timeout.

I have submitted a fix to btrfs so that when it detects the fs or the=20
process is being frozen, cancel the ioctl so pm can continue.
(https://lore.kernel.org/linux-btrfs/cover.1760588662.git.wqu@suse.com/T/#=
t)

But there is a question concerning me, which should have the higher=20
priority? The long running ioctl or pm?


A) Long running ioctl has the priority

If the ioctl should have higher priority, the current code is fine, but=20
the problem is pm will freeze all other processes (e.g. hang the GUI)=20
while waiting for the long running ioctl until time out.

This can be a very frustrating behavior, thus I'm wondering if we go=20
this path, is there any interface to show something like, DO NOT=20
SUSPEND/HIBERNATE, and immediately let the pm to abort any=20
suspension/hibernation attempt without extra timeout?


B) PM has the priority

That's what my patchset did, but the problem is a lot of jobs can not be=
=20
ensured to finish.
If a long running ioctl is interrupted, user may need manual=20
intervention to restart the process.

In some cases, the interrupted ioctl is fine to resume, like balance,=20
and previously relocated blocks are already written to disk, and re-run=20
the operation will start from what's left.

But some operations are not, like scrub which doesn't have any on-disk=20
record on the process. It's completely on the ioctl caller to do the=20
extra resume.

Furthermore the interruption may be indistinguishable between pm and=20
real user signals (SIGINT etc).
If we resume immediately after pm thaw, it may mean intentionally=20
interrupted operation will also be resumed.


Any feedback will be appreciated, especially from PM side.

Thanks,
Qu

