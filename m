Return-Path: <linux-fsdevel+bounces-65054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09348BFA307
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A6D1A020EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B92ECD2E;
	Wed, 22 Oct 2025 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PdxHbGQE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627B246BB0;
	Wed, 22 Oct 2025 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113898; cv=none; b=NKxhExMr7XgSxqw74eJroUQzeOu3429SlHxZvOp30WELABlEs/pCB9cDDC+V/mrjvnw0RKVT/cPpqHTFZZ2uz6WT96C1lL8rI6bi1qdh9Jk+1nkubAJormHNIQ15iw1B1iPtCy8US0xgz4eB8JgJ5tfgnn16PbFQInkvPnLcfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113898; c=relaxed/simple;
	bh=UFBAW9MqcAwalue9nVFvXVSowWp9/V9DYA2zMY03uqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWmj9PtlOhrWWH9lPMK2w1/uCk7bDdkILjNpunCE5TXV/7RZzoepU27sTYva7c7tCEjR6n0uTp5kwkzvgESSlIH3cx43H7i+ELmmAhx4AhIiz5MUoUMYDoAXBPUNh2sbSZN7FnM04yXUWP527GmhoNkdmwmr7JS93p5s/FknO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PdxHbGQE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761113886; x=1761718686; i=quwenruo.btrfs@gmx.com;
	bh=BPTw5jHUElS7aveYDc5jidDfx148g7p99GJ+eTCc8Qs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PdxHbGQEULy8gxEJT1Xj2h88aFiLU4/0dqbGVVeGelyHqwvTxtSLHNXF2QE4CcUq
	 l8mKg7Cijrfmv8YbN6gACly8hrzFSRQnem7QpcKrDsKrVGsBU+Nc26JNQW9527Yx1
	 zbwqeS70ggBgjeTD+7gv/M+Ia63/fkIIRIjPvnWzxrTskpmsmrCHhJpzRrjj3aIzI
	 hfkiH/tTqFUDRKdXLs4wZuESZ3G9pQSSFdaiwqXHxvsZgJQNlCRsMY1vP2VxT7o5/
	 G23lg3om9c2/UWndzKTwWXzTt7Wt2DnIVt/XZcoogXPKAnsOR++GG27oGO7Sv1u4s
	 A84Am27xhJl5Fbgf8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyuc-1uHx8N1O22-0128ob; Wed, 22
 Oct 2025 08:18:05 +0200
Message-ID: <3677cfe8-00cd-466d-b9e3-680c6d6d8c73@gmx.com>
Date: Wed, 22 Oct 2025 16:47:56 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
To: "hch@infradead.org" <hch@infradead.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
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
 <f13c9393-1733-4f52-a879-94cdc7a724f2@gmx.com>
 <aPhl7wvyZ8b7cnLw@infradead.org>
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
In-Reply-To: <aPhl7wvyZ8b7cnLw@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Buk30N8c6lyBjh5NJzMKw61WSRAnaKM73nR8dqY2FyJqFMeTbA9
 b60HpNfNtgH9/F3VneCVa0ExtyQ32wJIvJdWdrHm/b8zH97y/3YbnAtz/4pp7cnqSg6NBhB
 oBN4eN1jyMK9LJR+5nyV8MNzxf+Zouq+HCvll1bQwoPL+dA17eLD4H3nV3DZSja17aWJax4
 l3L1onjxPTvq2YhIr5XRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v8rfOyZfR8k=;SVjzB7k5xorKc6yg5gvs6WpeD4V
 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



=E5=9C=A8 2025/10/22 15:34, hch@infradead.org =E5=86=99=E9=81=93:
> On Wed, Oct 22, 2025 at 12:57:51PM +1030, Qu Wenruo wrote:
>> My VM is using kvm64 CPU type, which blocks quite a lot of CPU features=
,
>> thus the CRC32 performance is pretty poor.
>=20
> Yes, unaccelerated CRC32 is a bad idea.
>=20
>>
>> I just tried a short hack to always make direct IO to fallback to buffe=
red
>> IO, the nodatasum performance is the same as the bouncing page solution=
, so
>> the slow down is not page cache itself but really the checksum.
>>
>> With CPU features all passed to the VM, the falling-back-to-buffered di=
rect
>> IO performance is only slightly worse (10~20%) than nodatasum cases.
>=20
> I'm a bit lost, what are the exact cases you are comparing here?

I'm just checking the impact of btrfs checksum for data writes.

I may skipped some points, but overall the idea is:

- direct writes, no data csum
   True zero-copy.

- direct writes, no data csum but with bounce pages
   Affected by memcpy()

- direct writes, no data csum but force fallback to buffered
   Affected by memcpy()

- direct writes, data sum
   Fallback to buffered IO, affected by both memcpy() and csum.

So far it looks like the bounce pages solution is wasting a lot of code=20
for almost nothing, it's not any better than falling back.


And the checksum part looks can be improved for writes.

Since we always fallback to buffered IO for checksums, the content=20
should not change and we can do the submission and checksum calculation=20
in parallel.

Already got a prototype, results around 10% improvement inside my VM.
Will fix the bugs related to compression and send an RFC for it.

Thanks,
Qu

