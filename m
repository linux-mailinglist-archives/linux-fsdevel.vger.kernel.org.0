Return-Path: <linux-fsdevel+bounces-63523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E2BBC007E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 04:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C5F734C458
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 02:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266271DF75D;
	Tue,  7 Oct 2025 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AXpUNAzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884F3FF1;
	Tue,  7 Oct 2025 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759804278; cv=none; b=Hy3hCllwXPCpvZDvbewqVQaNvY/8S1F9M5SpmRKbIGV/J8WU1YUEE8F3Pd/EwYtZLhuevaWXpv51jc9RWnrx95dWaaEgmJnSAd4dQrdEb4wTPTCUnIoESKje5fBmdTAUa/kRTmfWF8aFps7DgWHKGSYVuOLMa11caE2hAxtXVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759804278; c=relaxed/simple;
	bh=3/pnPmO7sMRhTATgGMHIZAWnprwwZ7YQQyDlLJFNJ6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F30sxKDE7gs3oMS/fdgCNlbkK4Q4RMRW1cWo25k89aE1XYAMG2mnzvXy/n1G4FwGeWLO8o/iD3ysi2h0YSHSfSal8AbstwUcIbbCulOxk+qbUxfyqjRaXu7ZTF4VYjz+vqEIHPMSQBo5I7w9dxIxkRpvSEHQfdo9ZCwjmfHckL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AXpUNAzX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759804264; x=1760409064; i=quwenruo.btrfs@gmx.com;
	bh=7Ga2evIDAJBOa3UWFjHA8pZeZbVP/NIudHxqgHqIrMs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AXpUNAzX7zWHY9rarJadne4ks9eUt7g30zIiU263eSwAo3/1UCZvd+pFbMWi59ql
	 jg1ZxsPaiMt5yx88Jws2gNIVP3PswrO1Dkfnpw7+VBN5yCulcS69EYxVU7yA/T7nG
	 I+DyexdWmrpF6SGghX2Cn+crmoRYDoHM7IvINcaMwANljgvGuEOFyQCOcsSuv0Vtc
	 ilH1pKlVVv2GVPvempAXMAuNLu/vUJ4P+wU0a7r9k2Tf/CayduYEQOARjeB3RV47S
	 F9EkvbC45l5OOzR4WKgSTZ50frDStwiY2im08UZiKKREpJGuF+Yz6zgi71KwCtj42
	 eNvCgml20ZTLVzNcDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNKhm-1uvPcD49gg-00QcPC; Tue, 07
 Oct 2025 04:31:04 +0200
Message-ID: <c9fae0e3-88ad-4e50-a54e-8a73cdc72e38@gmx.com>
Date: Tue, 7 Oct 2025 13:00:58 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct IO reads being split unexpected at page boundary, but in
 the middle of a fs block (bs > ps cases)
To: Matthew Wilcox <willy@infradead.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 linux-bcachefs@vger.kernel.org
References: <048c3d9c-6cba-438a-a3a9-d24ac14feb62@gmx.com>
 <aOPbMs4_wML4qxUg@casper.infradead.org>
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
In-Reply-To: <aOPbMs4_wML4qxUg@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:azwRuxQDYT3U7rOS2fft/dMY2mJKrolA4PZA0rGYvSmqVftcFcY
 DcgAxRLtYdefebgC2V6emSqRvLBR7NPN9jKYCRyXAa9Ywtn0EZO7WjIc8aFjD+HbBVorXyh
 vYBOUDctE1cuCq3LAGyea0qVPpl8dlMLf16X9OcKMjv2CQAgq3nLPk7+5zyTaMfedTTyRep
 iyHpe9XHXDw/QPfkib8zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SDuNfVqdsak=;yW3oH5lTZynmAVcij1V30IPxCjR
 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



=E5=9C=A8 2025/10/7 01:37, Matthew Wilcox =E5=86=99=E9=81=93:
> On Wed, Oct 01, 2025 at 10:59:18AM +0930, Qu Wenruo wrote:
>> Recently during the btrfs bs > ps direct IO enablement, I'm hitting a c=
ase
>> where:
>>
>> - The direct IO iov is properly aligned to fs block size (8K, 2 pages)
>>    They do not need to be large folio backed, regular incontiguous page=
s
>>    are supported.
>>
>> - The btrfs now can handle sub-block pages
>>    But still require the bi_size and (bi_sector << 9) to be block size
>>    aligned.
>>
>> - The bio passed into iomap_dio_ops::submit_io is not block size
>>    aligned
>>    The bio only contains one page, not 2.
>=20
> That seems like a bug in the VFS/iomap somewhere.  Maybe try cc'ing the
> people who know this code?
>=20

Add xfs and bcachefs subsystem into CC.

The root cause is that, function __bio_iov_iter_get_pages() can split=20
the iov.

In my case, I hit the following dio during iomap_dio_bio_iter();

  fsstress-1153      6..... 68530us : iomap_dio_bio_iter: length=3D81920=
=20
nr_pages=3D20 enter
  fsstress-1153      6..... 68539us : iomap_dio_bio_iter: length=3D81920=
=20
realsize=3D69632(17 pages)
  fsstress-1153      6..... 68540us : iomap_dio_bio_iter: nr_pages=3D3 for=
=20
next

Which bio_iov_iter_get_pages() split the 20 pages into two segments (17=20
+ 3 pages).
That 17/3 split is not meeting the btrfs' block size requirement (in my=20
case it's 8K block size).


I'm seeing XFS having a comment related to bio_iov_iter_get_pages()=20
inside xfs_file_dio_write(), but there is no special checks other than=20
iov_iter_alignment() check, which btrfs is also doing.

I guess since XFS do not need to bother data checksum thus such split is=
=20
not a big deal?


On the other hand, bcachefs is doing reverting to the block boundary=20
instead thus solved the problem.
However btrfs is using iomap for direct IOs, thus we can not manually=20
revert the iov/bio just inside btrfs.

So I guess in this case we need to add a callback for iomap, to get the=20
fs block size so that at least iomap_dio_bio_iter() can revert to the fs=
=20
block boundary?

Thanks,
Qu

