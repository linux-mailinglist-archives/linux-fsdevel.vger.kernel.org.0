Return-Path: <linux-fsdevel+bounces-65018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFADBF9BC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB07565A20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC405221577;
	Wed, 22 Oct 2025 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tku4TThP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D221FF4D;
	Wed, 22 Oct 2025 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100098; cv=none; b=RIMZ7ZssHXPz9pPx5CyFalp0LtbRVXBZIpQtVf/vGReXI7XOvpNwglz+KrSJvMAOIL7DN7wb1KkjzNOuBMZueTYNyGVLTbjYDW/9OfwkURAs9pN9ijH12onS9CcQp/Di95/759r5k8BdcSAUTzfe9tRGrpj74QdLXCpsq/aTpWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100098; c=relaxed/simple;
	bh=1QoSt2OAO5msjRLlx0ou8wqycJmNVtxFRi0Rhw7Tn7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAPXipGfS7eWD0ZlBhAiIsjVEs5P5vDdye8ve2g1uW44ulETNt7+yYmYAUoUBRsSyAebahkUyQCBpihun8o/zEsEe6Fs7HdcuODT4a442dU4sZr610uYFai1pOr4bRf7okrNzm+p/MyyEynkEbuIqtLX4VE9zpxRhBv+FLYxNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tku4TThP; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761100079; x=1761704879; i=quwenruo.btrfs@gmx.com;
	bh=UVX0nmd056i0xmICe0q2++vUyjyuTAipoKbvlzs47VU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tku4TThPnv94EjxWD1brO8rmGeXvI3vIF68TXT0bhqte5Y6YALmvMOAMBFQYe7p/
	 OE7fRyW5867frAdcDw9hbzYK6Ffxibgt7qpQytocBy1mQhnLwfzdv9UT6I61AoLrq
	 o4cPS7U09usXg5Lh6cyffXKE6nBSVzZ8Edqcl7L4nJpaI+Ut9TSjQDCpc5nX5Jkfd
	 UXcFY1w/lMvE4KMD+5qoz2/GIuYMGu6TNEX11CuS1pHFlz0XByTyGS3kr5Q6cRTKc
	 dcn/9R4r0h19myoSd1w1/LaDQ+PqPWxAzFIIMBv2CyTWnET+GUWov0Eo0vkFf9YEG
	 w97YcFO6xWERKPN5TA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXyJ-1ugJrV3N0x-00Hqcj; Wed, 22
 Oct 2025 04:27:59 +0200
Message-ID: <f13c9393-1733-4f52-a879-94cdc7a724f2@gmx.com>
Date: Wed, 22 Oct 2025 12:57:51 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "hch@infradead.org" <hch@infradead.org>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "jack@suse.com" <jack@suse.com>
References: <aPYIS5rDfXhNNDHP@infradead.org>
 <b91eb17a-71ce-422c-99a1-c2970a015666@gmx.com>
 <aPc6uLKJkavZ_SkM@infradead.org>
 <4f4c468a-ac87-4f54-bc5a-d35058e42dd2@suse.com>
 <25742d91-f82e-482e-8978-6ab2288569da@wdc.com>
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
In-Reply-To: <25742d91-f82e-482e-8978-6ab2288569da@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DMNhgb+bRQv1CGCFUdNbrLUjyIg09hD8em/oI4ZEtuEJAP6dRrS
 vHfT4/Ty2j6KsYnIjSVZ4BFbSPQYltbPsVaDAIQzykluPsBWsQyMXaAZXduEDXS53ZlFwI4
 zCziieGDXEwkr0dUvncdNKSxH3Ymh8LUG0V6/zZlkfBQZF+fMxiDidqdH5RRrymEesbXz6A
 S6U5r78Wdbl0EVzQdCtFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WvNsCEW7dMA=;4HqMlMWFPrSDZxAImQYjHuskv+C
 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



=E5=9C=A8 2025/10/21 22:00, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 10/21/25 10:15 AM, Qu Wenruo wrote:
>>
>> =E5=9C=A8 2025/10/21 18:18, Christoph Hellwig =E5=86=99=E9=81=93:
>>> On Tue, Oct 21, 2025 at 01:47:03PM +1030, Qu Wenruo wrote:
>>>> Off-topic a little, mind to share the performance drop with PI enable=
d on
>>>> XFS?
>>> If the bandwith of the SSDs get close or exceeds the DRAM bandwith
>>> buffered I/O can be 50% or less of the direct I/O performance.
>> In my case, the DRAM is way faster than the SSD (tens of GiB/s vs less
>> than 5GiB/s).
>>
>>>> With this patch I'm able to enable direct IO for inodes with checksum=
s.
>>>> I thought it would easily improve the performance, but the truth is, =
it's
>>>> not that different from buffered IO fall back.
>>> That's because you still copy data.
>> Enabling the extra copy for direct IO only drops around 15~20%
>> performance, but that's on no csum case.
>>
>> So far the calculation matches your estimation, but...
>>
>>>> So I start wondering if it's the checksum itself causing the miserabl=
e
>>>> performance numbers.
>>> Only indirectly by touching all the cachelines.  But once you copy you
>>> touch them again.  Especially if not done in small chunks.
>> As long as I enable checksum verification, even with the bouncing page
>> direct IO, the result is not any better than buffered IO fallback, all
>> around 10% (not by 10%, at 10%) of the direct IO speed (no matter
>> bouncing or not).
>>
>> Maybe I need to check if the proper hardware accelerated CRC32 is
>> utilized...
>=20
>=20
> You could also hack in a NULL-csum for testing. Something that writes a
> fixed value every time. This would then rule out all the cost of the
> csum generation and only test the affected IO paths.
>=20

It turns out to be checksum, and particularly my VM setup.

My VM is using kvm64 CPU type, which blocks quite a lot of CPU features,=
=20
thus the CRC32 performance is pretty poor.

I just tried a short hack to always make direct IO to fallback to=20
buffered IO, the nodatasum performance is the same as the bouncing page=20
solution, so the slow down is not page cache itself but really the checksu=
m.

With CPU features all passed to the VM, the falling-back-to-buffered=20
direct IO performance is only slightly worse (10~20%) than nodatasum cases=
.

Really sorry for the noise.

Thanks,
Qu

