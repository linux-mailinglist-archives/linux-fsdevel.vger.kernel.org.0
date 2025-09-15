Return-Path: <linux-fsdevel+bounces-61466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0499B5882A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C9B1749C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F32DBF49;
	Mon, 15 Sep 2025 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fZ9D9Irl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2E29BDA7;
	Mon, 15 Sep 2025 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978480; cv=none; b=ARAiL/ZdouI1uWX/pdHq69FhlTGaKSyUfj/4cO9xycd+PCxKh1pOptq/XHgg9AWDFaM7gysudMhMWj7R2Y8YsfTp/xm2yL6Ej0ieQw8QYImjI3aqcrXHdU6Te8IQVuh6FqGdRXNbbRu5Jz+iDio0nLzabCGeCoBl+HL1VwRoalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978480; c=relaxed/simple;
	bh=9P7nsIGcMVfx0rJpmWf3bAx+uOpuVUJZZHlB/5VJ7hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJBzDEIECljSOyb+NeeCqS3xeYO5tCB/f5/6Zjrusg02LJJtPnw+rCltbuzLnjo5iU0vPkUzGp7ldke06u77TYm9GDRjJAs6/npz4C0lnPfIR5+1/ZcLJ2r66byJ+TUYXaIVuzq3l6u/ik6FWLZmdzBvnJKmgy+m7WRPzsUiP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fZ9D9Irl; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1757978463; x=1758583263; i=quwenruo.btrfs@gmx.com;
	bh=0dzM/F0pMhJLbN2H9n6kfZ46Rb+HV+KS6f+4ttzTOd4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fZ9D9IrlkV3d/DQzt8OuUNaxCJLr/wFPNQ3cqf0tYeoA3taNsZ9hyCiqoD3mFOBP
	 TJjSpY0xyYM+HU5bV4+v6Dqtsko5+cJVBR4ldYENTkxS1eRXZJj2PYKhqvhq1aaEo
	 00ww2t2ZqNxUtzf/b/Tok8Mwl7roY6QcAbEK7gKqewt8K/0ZJWqZb1LL5TiglR3zQ
	 CocQjS1oWV1g2qYZnUa+RLJyuZcch1e0GopUkYbGzUeB/A98Wg2AJx6UOqJo1vp3/
	 jCOcNJsITfT+zDfk0JAwCpanR9VlP4JI/Qm16pMwOlE1GEOp1F+NaxIqUuSQrHb+J
	 8VlI2Qu7vNUJyefk4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCtj-1uQscz0zhf-00dSmf; Tue, 16
 Sep 2025 01:21:02 +0200
Message-ID: <a54b3a0b-76da-4fb3-bdcd-db54941a255b@gmx.com>
Date: Tue, 16 Sep 2025 08:50:56 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Any way to ensure minimal folio size and alignment for iomap
 based direct IO?
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, linux-mm@kvack.org,
 mcgrof@kernel.org, p.raghav@samsung.com
References: <9598a140-aa45-4d73-9cd2-0c7ca6e4020a@gmx.com>
 <aMgOtdmxNoYB7_Ye@casper.infradead.org>
 <2h2azgruselzle2roez7umdh5lghtm7kkfxib26pxzsjhmcdja@x3wjdx2r6jeu>
 <fc7da57f-5b11-4056-857c-bb16a4a20bb5@gmx.com>
 <aMibrFB8_21GQWUD@casper.infradead.org>
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
In-Reply-To: <aMibrFB8_21GQWUD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FLgxIHkyhEpbW2GCPh2prIylMGj3YVjmYa3Kch+hCnMaBLQMi4P
 t9J4c6Foe6T7dqS4Tzp86+rMPKaM1ACCj55i6c8wpUMBL2e4MlNwX9dmTM3R4i3RSwWsmp/
 75O00jFNu+l5spC9IHUFu+kIvnuOISPaKIiWGEdY9+8lSq2S4CunFwDYXo0HYnfqG4jdoFm
 Y4AolPKX50y1yqp7ubcyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AfD2Jpv7DPE=;G86lQ1BONnlJEsPxyoIAZwt3q71
 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
 S9la2BYI30M4BKubaOg



=E5=9C=A8 2025/9/16 08:35, Matthew Wilcox =E5=86=99=E9=81=93:
> On Tue, Sep 16, 2025 at 07:16:48AM +0930, Qu Wenruo wrote:
>>> Is it very difficult to add multi-shot checksum calls for a data block
>>> in btrfs? Does it break certain reliability guarantees?
>>
>> I'd say it's not impossible, but still not an easy thing to do.
>>
>> E.g. at data read time we need to verify the checksum. Currently we're =
able
>> to do the checksum for one block in one go, then advance the bio iter.
>>
>> But with multi-shot one, we have to update the shash several times befo=
re we
>> can determine if the result is correct.
>>
>> There is even compression algorithm which can not support multi-shot
>> interface, lzo.
>>
>> Thankfully compression is only possible for buffered IO, so it's not
>> involved in this case.
>=20
> Would it be acceptable to vmap() the pages and do the checksum on the
> virtual address?

That may not be any better than multi-shot runs, as we still need to=20
advance the iter by a sub-block sized length and mapping them.

Considering we need to do sub-block handling anyway, I'll just come up=20
with a helper to handle the iteration.

>=20
>> However then the problem is why the read iov_iter passes the alignment
>> check, but we still get the bio not meeting the large folio requirement=
?
>=20
> The virtual address _is_ aligned.  It's just not backed with large
> folios, for whatever reason.
>=20

Oh, that explains the problem.

So even if we do the extra checks to ensure all the pages of the iter is=
=20
backed by large folios inside btrfs, it will still be very problematic=20
for user space programs.

As they have no control on the underlying page layouts, and will hit=20
random DIO failure or fallback, which is not acceptable for end users.

Thanks a lot for the determining answer,
Qu

