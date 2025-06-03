Return-Path: <linux-fsdevel+bounces-50435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE428ACC2F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 11:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DED1887DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D823281504;
	Tue,  3 Jun 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Nb5lGzB/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78A956B81;
	Tue,  3 Jun 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942638; cv=none; b=kGg2XvGsvbl/PWOhXB3g58s1yBdD8JvXS0X5Hmp63x1DbPRh27G2Ls5aRytz9d8EmWhZhfHjU/dHECbZ5Fva76LW658Fk2O9Q06Bi0D9anQI+/Paf51ID9HTQhunbykDAyjYJEXK6dXl4Yj/fDF0FY6LpoZqrCM1JYv8Xt3TPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942638; c=relaxed/simple;
	bh=opCIcvtwNLugJw15pDXvfOi1rP7qFvIVwcLbBnJGU+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEIwEKyAIs00lhajRhhRSu8eyDlC7O7nN0pJtAngzLTc3u8+Sv7zO5pJVsvnArY2Los3cOz30M7oJkRoykL7WsSV0vplFGkPWSPsA5RcDi5xOyZHjaCiZtqDB5rPL+AUEvTePegE/gVFvar5+UvY3AisNA+tjBQPy2VilvkVghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Nb5lGzB/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748942633; x=1749547433; i=quwenruo.btrfs@gmx.com;
	bh=Zgn3IPto+hy4/z+Y4Dg4Mn7KSxcYCG9Mrm77XBlS5Pc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nb5lGzB/xZQpU60MyhqJBnBZExENj3FcGzjeZlOMrSQCOD6YTiHIOLndY6ZMZrb+
	 LEKnUN32lid78aFRSJ/RcaZOhTLuttFw+XqdlsJSM65n1uxql8ee0tEteoDNceSVD
	 nkO8/Ds1FGP3mgxopOIxlmzK3S9h0h3wvpQ35nsaMz0CDDxhfPpioQjvRGbazZO2z
	 yES7iNMU5U/YYK9cNwQRMCOJGIuC19gIhQlIb8mSUujmaUZJL3vhr3UEWT0pD3UWj
	 6xhWZ/x0T1J+Zz7eQ6y7W4Bp+DuQcKQsg/QC6PiLRkiQW8+z2R448Hx8V4PuO0Vvc
	 sa0PFwknxnmMPBNksg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma20q-1uPhGu1WfE-00U4C8; Tue, 03
 Jun 2025 11:23:52 +0200
Message-ID: <74260737-f153-437f-bf98-1f3944f493d6@gmx.com>
Date: Tue, 3 Jun 2025 18:53:47 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
References: <20250505030345.GD2023217@ZenIV> <20250506193405.GS2023217@ZenIV>
 <20250506195826.GU2023217@ZenIV>
 <9a49247a-91dd-4c13-914a-36a5bfc718ba@suse.com>
 <20250603075902.GJ4037@twin.jikos.cz>
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
In-Reply-To: <20250603075902.GJ4037@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iuLLtxx9P+qReRkYGtWq/xUBawLkhBQL2NEqiMdsYdo9BEV7xPC
 wsWQSUyOY5EmTTS0XKBGAdeR6mCKtJ+oHSSV0HSbttGERtqRSWcb6nk6UnZdAeByabFGU5+
 oHDu0TwUcwIhl3n1xJBtWoXFYHOsb5H4r5cKiIEmebtGDkb3rbReRRlM/vbu9J8ecz5jt6c
 6DbBZluJ97XDDm/a9PV6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EKNTBDq63Ss=;2QKFbVNyNY/OzLJoO+JTzCj/dfB
 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
 I9bPMdX7BmkJZyPl



=E5=9C=A8 2025/6/3 17:29, David Sterba =E5=86=99=E9=81=93:
> On Thu, May 08, 2025 at 06:59:04PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/5/7 05:28, Al Viro =E5=86=99=E9=81=93:
>>> [Aaarghh...]
>>> it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_t=
ree() -
>>> no need to mess with ->s_umount.
>>>      =20
>>> [fix for braino(s) folded in - kudos to Klara Modin <klarasmodin@gmail=
.com>]
>>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>> Test-by: Qu Wenruo <wqu@suse.com>
>>
>> Although the commit message can be enhanced a little, I can handle it a=
t
>> merge time, no need to re-send.
>=20
> If you're going to add the patch to for-next, please fix the subject
> line and update the changelog. Thanks.
>=20

I have merged this one to for-next just minutes ago.

However the version I pushed doesn't only have its commit=20
message/subject modified, but also modified its error handling, to align=
=20
with our error-first behavior.
(Which is much easier to read compared to the one in the patch)

So I have sent the updated version to the mail list just for reference.

Thanks,
Qu

