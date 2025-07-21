Return-Path: <linux-fsdevel+bounces-55589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED75B0C368
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286D31AA43F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98A2C15AD;
	Mon, 21 Jul 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G+7PDLAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466552D661F;
	Mon, 21 Jul 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097835; cv=none; b=BFcD4YXYrnZYekz+/fpxEcl/yKb3yBx91chDOWtoSw1GIUQ6O2ZTLCnJq19oXj9xG1MUIVi7mh+fGS0LY8xzIqfLakp29bqr99fSfKSufCzQuasg7Mw6nYY+VWx6y+rome5reElJljipEBvvpfWpVehCs6aaUJZIEhhSFTJGaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097835; c=relaxed/simple;
	bh=sRlnlHK50gxNXgPw45qulU5Fk/tDZapxH/oKQgNTsiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVEEfDTzbrZZ7IxpLrcVGEsH963UdwsRhyMRlhyTnCrERU0eCxjnXs3d/19p9s38wKETlF/FjUZL0M6srhIwrudNVVdfK0+MXN6M647BAPl6jG8p6o2WQf3gOhTYH3VTujNxHxUH2aIYjyr02aWDpx/Z3NJNNaewG5g4b57XaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G+7PDLAi; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753097812; x=1753702612; i=quwenruo.btrfs@gmx.com;
	bh=zBIsLLD0agXGs83w4tbKBYZqttgfplGTbcXLQzdNcrg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G+7PDLAi1AxvmZ/TaDgO317qqRqOqAN0zAgfp7epxgqYrJfiiIF0XCpbXm5LxS/1
	 wZdVeYgw3hRxCeD6bX7kQB3PKUn+OjtoyKh34v1XGhIZZaQQiUXb0RPIFcx3HoyR4
	 e8XOF/1bybaGC82vrBiWQYlKxNoeOdAuFFdiJjy07qf2Qz/UPCYwq+PLQ+n/3V2wg
	 Wa5aCd5eOd3ksv+PpAHHtX44RqBDQPDwPwxY++QYnBLNXkE6+4NW7KdD9LCt1z1IP
	 c+0mO3x9Pu8RS23gtW6E9WFnR28pgM5fOHCv/4rHi17Ny7a/4yGIYVHILtpWm1fvD
	 2+nvmrn717GJHFxL0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MybGh-1uoDpm0wnN-010ycz; Mon, 21
 Jul 2025 13:36:51 +0200
Message-ID: <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
Date: Mon, 21 Jul 2025 21:06:38 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>,
 Hailong Liu <hailong.liu@oppo.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
 <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
 <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
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
In-Reply-To: <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KDXt1vR1fT3Zmk9s0ZPAImsaPPiOo0tezqUWd5Kf9CdjbZbF7k4
 k3gVPpxoDBzZaxV6R+UYdLWaK1/PTnGXVRZ1s6k8AUc3RGswW9CCDD2U/eWO9Hwv8oYpkYI
 THIoD2qPA/NKqeH2x5OB4BeuIqWMGlXiYNhqMnFs75vdCpTKJCpG82FqfbLeMe6qpgbYlsV
 LdrTRCbJ1pA9hGbTaSpcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LrWi0qhLJaY=;eltaPT9HJUWueclF2/CsWbEt+J5
 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



=E5=9C=A8 2025/7/21 19:55, Jan Kara =E5=86=99=E9=81=93:
> On Mon 21-07-25 11:14:02, Gao Xiang wrote:
>> Hi Barry,
>>
>> On 2025/7/21 09:02, Barry Song wrote:
>>> On Wed, Jul 16, 2025 at 8:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
[...]
>>> Given the difficulty of allocating large folios, it's always a good
>>> idea to have order-0 as a fallback. While I agree with your point,
>>> I have a slightly different perspective =E2=80=94 enabling large folio=
s for
>>> those devices might be beneficial, but the maximum order should
>>> remain small. I'm referring to "small" large folios.
>>
>> Yeah, agreed. Having a way to limit the maximum order for those small
>> devices (rather than disabling it completely) would be helpful.  At
>> least "small" large folios could still provide benefits when memory
>> pressure is light.
>=20
> Well, in the page cache you can tune not only the minimum but also the
> maximum order of a folio being allocated for each inode. Btrfs and ext4
> already use this functionality. So in principle the functionality is the=
re,
> it is "just" a question of proper user interfaces or automatic logic to
> tune this limit.
>=20
> 								Honza

And enabling large folios doesn't mean all fs operations will grab an=20
unnecessarily large folio.

For buffered write, all those filesystem will only try to get folios as=20
large as necessary, not overly large.

This means if the user space program is always doing buffered IO in a=20
power-of-two unit (and aligned offset of course), the folio size will=20
match the buffer size perfectly (if we have enough memory).

So for properly aligned buffered writes, large folios won't really cause=
=20
  unnecessarily large folios, meanwhile brings all the benefits.


Although I'm not familiar enough with filemap to comment on folio read=20
and readahead...

Thanks,
Qu

