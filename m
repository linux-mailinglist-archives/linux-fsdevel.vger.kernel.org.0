Return-Path: <linux-fsdevel+bounces-39446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F62A14425
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE2316B371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 21:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4331D90DF;
	Thu, 16 Jan 2025 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="js3OSsLk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FF19343E
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063770; cv=none; b=VplU5HHsp4E5K13qPSR24En7i7PwdC93KQblJT9Sw24ON0Oq3RGU/MAHQNVzX61mi/nwbeajibdZkf7R6uLMo1qG3d7EuGDphl0BuniphRzD09z4X6YGfprmqeJs3zjCuvKtpazMAfya7pqjUmZLgdJ4Vu+Ahs5uYIsmlRwwn6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063770; c=relaxed/simple;
	bh=FpLEkxvtz2GZLcIKc0fpEAt0ZXmo6H4S12CV/j4qCWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0cWV3Ll+a2cXmMxp+2QlP4KEaN7+hg2w+Dn/zfxjRKp47LTewmD/V+LXPGJEp9DWcZKvkyV6T/zYd6Ig93zjbLyxA6JhXCwt6xf600Wj6h/wv//HWwZUCU6HwmoE3jHfWgif73MeuluVL131PhbXw/OQikYz6RMxvpoFer5xYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=js3OSsLk; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737063759; x=1737668559; i=quwenruo.btrfs@gmx.com;
	bh=vVnhercMgaLPfA4oa9moEewcucL8tWyMe9JobdYFaao=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=js3OSsLkmhVTYI13+eBMYB8aDsxefK55kSi7t8wZ8PmtSyW9vtvCpk4UjJFUy5PR
	 ROjB0YbrqW3mB6fZ58qdPxsqibT9Db4JbfFUEtCt67JLTX9a84rYeIXKGIE0u+bQ5
	 //ckNV8zaohFEaKLMvuXILSDnLTwdJaizVCvNh/iDNstEp/PXhSC6jtBXzfqFimcp
	 ni4hILsklsaroKEpZE9q4rvmr2DvrBoIp0jKN3w2w0SrI6LmEMEm99bo5udxw9KHa
	 9SAq5R2W7GQBlHN938MX7P78zn2I3aDWZllG0/bPIE3qp0QKSxseSWDYQSy8zBH6F
	 Z54aAOTCavFkOtuf8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5QJD-1tZMRn28CD-00AbBr; Thu, 16
 Jan 2025 22:42:39 +0100
Message-ID: <c8a92d4b-41f6-46af-97b7-f6315bdc2871@gmx.com>
Date: Fri, 17 Jan 2025 08:12:33 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible bug with open between unshare(CLONE_NEWNS) calls
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Boris Burkov <boris@bur.io>,
 linux-fsdevel@vger.kernel.org, daan.j.demeyer@gmail.com
References: <20250115185608.GA2223535@zen.localdomain>
 <20250116-audienz-wildfremd-04dc1c71a9c3@brauner>
 <98df4904-6b61-4ddb-8df2-706236afcd8e@gmx.com>
 <20250116212912.GN1977892@ZenIV>
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
In-Reply-To: <20250116212912.GN1977892@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qYdLfSWQsa4l9d5ldSc2fkt0r+BpLWEDF7wsThruac/qDO94/uy
 UzaVmcYPEpaG6C6LQ3G0Bxr6toGWhZ0OnY4xBs3PHU8OK5iZrLDriRLEARxJJLLGVYEgoT8
 Xb+eTVUYFOwBW/nIWAPxrvbnmkSfh702JMTns8/ciujTOH+aszJ9VCiTQ5MC3ygkbjyauTt
 EsSOVW9l6Y8Qq4dolzawQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rEKNRIEx6qg=;pAP0ZcBqt+Adzf9uaIOb3fLW1ZX
 SGrVO0x6T4x3pbwHf+GI/dHGX64tAh7NzOX3NpRjthUfM2djTXHxTHmt177hUeMcLOhVWVQIM
 w8uZ+8fuYg39QhON1VqRrN45iIuhJkw+cHav0M/C5g9vYqNKnZz9S66DqGn9+w+vijNJzSWDk
 El6xgMhNBcWEiL498OGGALyMWsytUPFA9GYzWVI8L29MWVq3dcgd/gHlgzw/fbJz05MSWcva1
 L+51l8Zj1icCzPOGB5URUwJSw2zCsc4Q2fxdfP+eMjUoi0hD8GJiKZ/IlUquMYTtXEkA86KtP
 qLvHDshLHpr7rk8FhUu40ATDu14D7sGTCdr1Y0aEb47nu3nctaQhmgaeBQ01LfdmfL84szAfo
 fPJaShrUle5bjCPE2u9AHHcBaCb+kLOwVrqAWv66PHKZWDiqenBID04D01GOBK1qamhme0jqj
 pvP9BjKSKX820Oln2O96ZkBTx4HYbUUc9R2elxzmRCP80ouGYJYG0TZ9A0dJ8YX/w/D5E3QM4
 m4uxQKsnDAg7aQuO6oGKPEsxEAay0t9We0MjP2Q8k/dMU+MJX2tg/57hdcb+7ayCx5wLU9Sb6
 Zuz03cxS00rdJgpFfW4QHRGDik6GyYcxlPt9DpFc0j0v15kECkrq861Iydr0rsOJf8MWUtbnv
 dCfRJnGrnda3q5P9zs7F107q/2xeUWab8aXKVvLVgJCAzBcvpm0zANqVTJpuRrUtovtIrfS3V
 Lxfagy1zlXWEdg3nYpO/S0lcrO92m4ygTdG3yaAb9weWHMA5bOWf0btRv07Ee0dbf0Wfx0Ta8
 eGpwIOa8HnFKISO4LBueHVMloudT1Q2oauuTCxYeT9w4SqPEDS8C3a+Vt0QhCNHDLnvc52qKt
 zBquHh93pt3fP6DeBFL1R94eOCMw/4h/12WXffESoiPeJozTGN9unHE9T0CQARoSOpmHreM6x
 7YxInXVmlrJW46WjZjF2oABrqdG8surbVwdN5MWbq78Uled9jJQlhpDxtaX+0F6X+S92LzNG3
 avMCx+N1xR1b95G/oWqlm+QRnU6Hvj0uOsYIo1mdDzBqa+qU1iip+Pu9lF8QZuqnO8hUDAnQ6
 DwN1g6op3Wq5bOlZRzBZVIloq7p1U5z5ula9vMWfU/5KUKRycBnsY6lL1Dy/nFrpqfRlZHHMK
 XiGPKeU6azg6XQOYfgPGJLRNJih8uPpysz7vvmU3nnw==



=E5=9C=A8 2025/1/17 07:59, Al Viro =E5=86=99=E9=81=93:
> On Fri, Jan 17, 2025 at 07:39:09AM +1030, Qu Wenruo wrote:
>
>> The original problem is that we can get very weird device path, like
>> '/proc/<pid>/<fd>' or any blockdev node created by the end user, as
>> mount source, which can cause various problems in mount_info for end us=
ers.
>
> You do realize that different namespaces may very well have the same
> pathname resolve to different things, right?  So "userland can't open
> a device pathname it sees in /proc/self/mountinfo" was not going to
> be solved that way anyway...
>
> While we are at it, it is entirely possible to have a trimmed-down
> ramfs with the minimal set of static device nodes mounted on
> /dev in user's namespace, with not a block device in sight - despite
> having a bunch of local filesystems mounted.

So it just means, we will have weird names in mountinfo, and we can only
accept that?

If some weird programs (exactly the one mentioned in 7e06de7c83a7
("btrfs: canonicalize the device path before adding it")) really choose
to do stupid things, we have no way to prevent it from happening, and
can only blame the program?

Thanks,
Qu


