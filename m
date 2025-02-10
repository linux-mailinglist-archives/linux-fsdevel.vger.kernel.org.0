Return-Path: <linux-fsdevel+bounces-41349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67807A2E30E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34281886AC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 04:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635815574E;
	Mon, 10 Feb 2025 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WaJ6wcAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9F219E0;
	Mon, 10 Feb 2025 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739161025; cv=none; b=d16W+dA0+jrB05qEGIS6i4neBadIJ+TlZsTyXax/IskCi6IkOVxQEq31PZjYrwXHrX1AHbbgdJbHKxKx0p5SjPZRQsgqoOLe7A8AFtqMcbreJvDhJ5RoB77FmpuZCcfAIXh+B2nwCw6ar2ya54j/GDXycnzZtG0P+fVoa2SGq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739161025; c=relaxed/simple;
	bh=h40D6IFohjXn8bORf+uNypUnWTRvTcb+np2x9fLlL04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbtUkHBZOc0t7EQY369Jt/RQvKlxrDc3RS9k6f4jN1MO4fBZGpO55Qsa3MFuL9tTxJL/knb713fQdclzT1avw9nStbz0rPu5HTbvI6wUY6A/oVyxtT1lA1SC0F54dj5XE3rdWzCPpSyUGrCv1Y/omLm2er2o5wzGxLn2KyoZ0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WaJ6wcAM; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739160998; x=1739765798; i=quwenruo.btrfs@gmx.com;
	bh=h40D6IFohjXn8bORf+uNypUnWTRvTcb+np2x9fLlL04=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WaJ6wcAM9mu/fYqUNK4tJgOS3rSb+uW6xKHjnk9z9hbjKniKFCYZmU5wBVtZ7usB
	 60daudIiWCCCa7EwtPEENXVwvoJ/SSQGAdVZFQdixjBIEAIF5/jhSAIA+6ZDywo1/
	 dsAPQMXMIat3SvSttqYjDc8GYgXaUJ2wlvvkthdazARlgGpnbrHqDQTkO9OHkz9Wt
	 /qVcVI9tTcMqeAClnA/zCPiOJPxko2lsomBZYBbDGg+KmkN6zwih8pLvY7vyhk7B3
	 e1VDI6p5qRBcCTvPHxDl3ZfhFMjyvkwlnBae6KkC+fuOtF5rCL2pDw4ZHdWhW0Bj4
	 HuyzYeOWlkA05fKI7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgesQ-1tBYBG1EE8-00b01Q; Mon, 10
 Feb 2025 05:16:38 +0100
Message-ID: <718cb1e0-c21e-41d5-a928-cf1fbf2edc57@gmx.com>
Date: Mon, 10 Feb 2025 14:46:32 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xfs/folio splat with v6.14-rc1
To: Qi Zheng <zhengqi.arch@bytedance.com>, Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J . Wong"
 <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
 <Z6aGaYkeoveytgo_@casper.infradead.org>
 <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
 <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
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
In-Reply-To: <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S9Z40HjSMhBiLJGWSHXFm8SH7GCqekWlDjIInTOEf1A38KTuu79
 MOgvP2Mu9Z+3rRaotdgbhevuCSPXifNYdnHBd+jqEqnijz1jtXwmrLIJi6CZkA4aio4vYrw
 axbkQkRzRPzi/1AB+b/qfePpWmiezKJO82gegqZGk4Qg33VZLsvhPlLHil3j2A1bLtUdk3z
 +EsTnocEFe/OWGm/D1nyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0+Y5YSAEOuA=;G/VhAmrFO27nuEiseERwTqiIUam
 YNdOZto8gnYexWtvRxqULQGnukd/cviobekxt9CX1x24Wx/3n7LLHy+2WpL0awFe9tYP0UCFF
 vXEdpOS4g0M3pxa8tODrS8q0ZIIIVIPnjNPRODvzbPuisPClLCxPi8IgJiIAKZTnZUZpgmiUZ
 9AN4WJOtP4ZShZbPMrLafjL/ehORJdLEl/HGf1nE1Pkh5YS1ZKtLpw/V2eOemtcuAWrckE78d
 i9suHwhVVn6qLwLyVoCqoNP5eCJ5xpDPKLhocI13lzAGOjoX5eclA0g3EKAjKLpGZjekVwrt9
 Dx75xneLXnJmE2vOsKnF6XW7yVDZoXQutbZA7s00eCGuToMSoIGCJ52hiUDclhlo7FFVsJPFW
 q+cNnJQw9n4+bfRx8KQBuwMUESPWQDiy/mHO7mtIoZGmCvcIsJUvrS9ZeECYvf4kNt2WEVFoa
 IYDkDsS9nauNs+OR52T8aBCEqN4Y0AkxW+A3TBGCu/DiO8Y8MsfYhqmNIcxnCSgudzn0d1yXE
 WE5RW3rlxN0dHfI7I8fURSndY4UTN2u+3EpniqRMN717WKBYtcjRssq80EEil+2p2PwOe3cCB
 yUSu1FJhPYRuMpkttRmrnp5+8GDJ2uRoIIDZX0hUQVE5/uhFwRf3Fc/t5vaIkXqs26JIfaTyI
 8QiQGyenGQgMA0Zvp/VhDFsZerCZ3LpvE0gFFeTdSveHSMKcJxvwg5ZU3n5qjG44znaldwHeZ
 FpTU2P8B8RRTmbaS0TckaIAdstWaM+HA58aSIsz1r9VyO/Daw9Z1VOZ+OdNE0Rm9G0MGqhTEE
 3WqVg+ARpblqOb98Qe6oa+Q94+e86PVml4FQoNXfm+XuDcWOs8CR/a+9IJEDLQfnwsfWZyDpj
 RneyOFFByNXEAtaiuz+9wpJt/Hu0M46Jz5AFKkb2bpvUJ1re5b7mWbm5k3g5zssi5H0DirRhz
 0bJJT54XnbaXIA060un1pZv7iMbVxdfUfcuUI52v4HerOq0U6KYMIrrfIe4V8TCeX+3H/CjXJ
 y4ysGD3MlV6r3tSoubOa4WDZqytrPCXdo4Xw2AT8zbcuG6y1iYWMX+krJWiw4aVOKsg4WluYI
 +DJzNKh4ErYSJUpRsyO0PV3A4FwKoQdxVTOvb2f6zXfANElg6tlqBE/ARQvJQPT/6gv2lIkfO
 +lVdtI0f7e18jNX4xIsoSpNamBOoyhWsLs1iAE15tkVlxxFVmm1ASH0oy1UqsSP4O6Whm5Ozr
 Z6Z/5Vdr472mp9XBbkHn9eSrwZcFyeqaFSOD0MVbyWKePfP9vYpDt+fYcV4NDWPb+D1pSpdba
 qPreFGxbmHIwZtkgWkGrwa4tXv/cfPG4jyiJQotIEyZ+g1ZIY3JOX6GOTDDTTteU1mXW80GLe
 dw7NiX02PozEtI744Q7eOuVZZ6k0nmwp43aazxeHnbkooSonsMEHvtaAWz



=E5=9C=A8 2025/2/10 14:32, Qi Zheng =E5=86=99=E9=81=93:
> Hi Zi,
>
> On 2025/2/10 11:35, Zi Yan wrote:
>> On 7 Feb 2025, at 17:17, Matthew Wilcox wrote:
>>
>>> On Fri, Feb 07, 2025 at 04:29:36PM +0100, Christian Brauner wrote:
>>>> while true; do ./xfs.run.sh "generic/437"; done
>>>>
>>>> allows me to reproduce this fairly quickly.
>>>
>>> on holiday, back monday
>>
>> git bisect points to commit
>> 4817f70c25b6 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64").
>> Qi is cc'd.
>>
>> After deselect PT_RECLAIM on v6.14-rc1, the issue is gone.
>> At least, no splat after running for more than 300s,
>> whereas the splat is usually triggered after ~20s with
>> PT_RECLAIM set.
>
> The PT_RECLAIM mainly made the following two changes:
>
> 1) try to reclaim page table pages during madvise(MADV_DONTNEED)
> 2) Unconditionally select MMU_GATHER_RCU_TABLE_FREE
>
> Will ./xfs.run.sh "generic/437" perform the madvise(MADV_DONTNEED)?
>
> Anyway, I will try to reproduce it locally and troubleshoot it.

BTW, btrfs is also able to reproduce the same problem on x86_64, all
default mount option.
Normally less than 32 runs of generic/437 (done by "./check -I 32
generic/437" of fstests) is enough to trigger it.
In my case, I go 128 runs to be extra sure.

And no more reproduce after deselect CONFIG_PT_RECLAIM option, thus it
really looks like 4817f70c25b6 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if
X86_64") is the cause.

And for aarch64 64K page size and 4K fs block size, no reproduce at all.

Thanks,
Qu
>
> Thanks!
>
>>
>> --
>> Best Regards,
>> Yan, Zi
>
>


