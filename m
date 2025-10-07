Return-Path: <linux-fsdevel+bounces-63531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8225BC027C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 06:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C0C94E95BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 04:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8B21ABBB;
	Tue,  7 Oct 2025 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EfVYRklZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286834BA3A;
	Tue,  7 Oct 2025 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811358; cv=none; b=tH5gkHe8ZAd8W2qHewBNljkL9k3JUqmTQv1E7dETo/FTaJNObdN92GA+hg14OrE48szw1/LSZ1DpFm6UmaMp+yysQKBuKdoc/JM7LnRtknA2dt6te3i/bXsJPPSOdRPgUJfhDwgUfgwFgkM/kO/KWW8+PpHANEs/Wu8sxKmV+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811358; c=relaxed/simple;
	bh=Cj32sGVdQXcNd8TSD7BkRfyIQoFSCy2WjpMxmWjd4Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLQHNnyVe4qqmnNQ2NQCth7cI1R2lS9HFRx/4z2U1Wh2cvqu9GxfzcWRk+K3fe2V/t/ry0w08jQK8TERgFHovq4Rnmvsnot8Wvv3hcRBsWb+WSDruumqvu5G4eke2BUv3zQC5eC9s7CA21CZ98+qCI78vgeHH6dIxffA/jCJgnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=EfVYRklZ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759811345; x=1760416145; i=quwenruo.btrfs@gmx.com;
	bh=3dskJRhZYFHO0bMo95uDlMVTHmjQgj+a6MUJZZk7gkY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EfVYRklZ+kMyYBpn5ORbbCclj7lcjOQ8XW56V2/67qOdzTe8aHNK3OzONU2qRmJt
	 Pw/l2KU5xnmM5r3Qm5VovkMko4bAk9BDO4/Fi2KzAMYCgW0TiiwVhGPGM9xvFRdv1
	 Y9VGDwji/evGqbKVHnOHoAjz3qrh/194tWbtvljVF9/rqkLL8wc15fHNj9LOylzzp
	 mUygKeRpP4I7WitOOHVwEEZSyV3XYtXNOwXbrGo1MCupu7n46YzMSjIgGbZf8GdOE
	 2DA3YnTkZGtDBnBlCPwsMvkX8XO6ei62PKcDLfokNYNOflZY5Gf4RQ257hE7ahoWg
	 EY2eo5kwBx7cuwKJ2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1uPoYY0YD1-00lk89; Tue, 07
 Oct 2025 06:29:05 +0200
Message-ID: <ace821bc-55c2-411e-ab9f-fe16e614c3a9@gmx.com>
Date: Tue, 7 Oct 2025 14:59:01 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iomap: ensure iomap_dio_bio_iter() only submit bios
 that are fs block aligned
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>
 <aOSSs2CodljBMeTL@infradead.org>
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
In-Reply-To: <aOSSs2CodljBMeTL@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Aq9nDGcSQPBlqxuTFhdKeVgVzjIniqNmOrnpugGJZHYTe4R7Tj3
 6pjHzfIH1BY4A0nuN2B8DAfeI0sYchOzEZqJqKC2Ap8yRaid3rbUxeIx67fpJqFyhZ3RbQI
 bsvXc4YRKTtxdq4Weofuiqi7Uwnsz3j426+SKc5UQj6Ti/bYDy/YbVkqEBQDKTbW5lob5cy
 Sh6jNTEcMX4hcV1w719Yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:62g/Z8OH/B8=;OaGBn/D9LwaTQoWVa04Ula0WK14
 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
 0r8xfwWzNnkDcZa9U=



=E5=9C=A8 2025/10/7 14:40, Christoph Hellwig =E5=86=99=E9=81=93:
> On Tue, Oct 07, 2025 at 01:40:22PM +1030, Qu Wenruo wrote:
>> +++ b/fs/iomap/direct-io.c
>> @@ -419,6 +419,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *it=
er, struct iomap_dio *dio)
>>   	nr_pages =3D bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>>   	do {
>>   		size_t n;
>> +		size_t unaligned;
>>   		if (dio->error) {
>=20
> Nit: please add an empty line after the ceclarations when touching this.
> The existing version keeps irking me every time I get into this code.
>=20
>> +		/*
>> +		 * bio_iov_iter_get_pages() can split the ranges at page boundary,
>=20
> Overly long line.
>=20
>> +		 * if the fs has block size > page size and requires checksum,
>> +		 * such unaligned bio will cause problems.
>> +		 * Revert back to the fs block boundary.
>> +		 */
>=20
> The comment here feels a bit too specific to your use case.
>=20
>> +		unaligned =3D bio->bi_iter.bi_size & (fs_block_size - 1);
>> +		bio->bi_iter.bi_size -=3D unaligned;
>> +		iov_iter_revert(dio->submit.iter, unaligned);
>>   		n =3D bio->bi_iter.bi_size;
>=20
> But more importantly I think this is the wrong layer.  In Linus'
> current tree, Keith added bio_iov_iter_get_pages_aligned which can pass
> in the expected alignment.  We should use that, and figure out a way
> to make it conditional and not require the stricter alignment for
> everyone, i.e. by adding a flag passes through the dio_flags argument
> to iomap_dio_rw.

Thanks a lot, the newer helper is exactly what I need, and unfortunately=
=20
it's not yet in btrfs tree. I'll rebase my patches and utilize the new=20
helper.

The DIO flag solution sounds pretty good to me. Will go that path.

Thanks a lot for all the hints,
Qu


