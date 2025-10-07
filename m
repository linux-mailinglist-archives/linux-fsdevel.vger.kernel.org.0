Return-Path: <linux-fsdevel+bounces-63530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D910BC0270
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 06:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F3A1896A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 04:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA9C21ABBB;
	Tue,  7 Oct 2025 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lvLSD7cs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7E34BA3A;
	Tue,  7 Oct 2025 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811227; cv=none; b=oJg9uQKKkiqijfydvYgzbbqarCPIbgjkKOt/Ao7QGcCAu/uArLKlGaIwXDvpjCTs9Gz7i/fYnD8iypbd4GfzXcz+znIRluKZ7MLcpZDiwNI5nnVfqJc8iOs+69c1rZCjFQtBMF1hJg1pu6TRHQtJdpi8lhUBSIPmjQkJlg+k5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811227; c=relaxed/simple;
	bh=5hLOjUalD73GgD6p8T71Kq1JDj90XnZ0pglCaYDdOoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/eoQKk5FsqGv85okXOsp9OQNuaH8UFskQmenWuRQ5mP9EFZ9hFoPPnKAJ79UxjP0rB4mw/XGqB4l9GuNdyC0zL0oepNDugSRmeHBxJy3QC94Of1kSfaVWIFKgy2tT3hAPn+ybp2fquqdChHLmylvCvLHLqA83QaIq6A7iUW3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lvLSD7cs; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759811214; x=1760416014; i=quwenruo.btrfs@gmx.com;
	bh=ZbUdgePpnwxln1bzJyafXdu6AYPr9JU/zOErJxMzjGE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lvLSD7csqG3QPWNVaK8mVoJXqWMBJMigSsOmVxsoWMhsi9kiLqOwmaMXrRVMi9NJ
	 QM0oi7Q5EI6M2FkASGmeo9UtJempuNfq6P65djUijVq/+dpwuDcfLLmjXy4Ynxnlx
	 VrgU2XhsiP90qVAwTMlCcG2ySzbZRVSzEJ/LVsVb42v2nKCcvbUWPLobya8v8IRaA
	 usXm38GKBFkK42YR58+mFbpkqQ3gzTHU83Q02fRCts4ZOt0cBJtj7gn7O/IDkVeB4
	 IvGELFx7SpSAZNmnnWQt2+kwk1wLiAoS6w7zu8JfFct3snI5pphtu+64oXY5yuMAa
	 q5YRXvrBq4fQ9aujkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSc1B-1uiB2y32xl-00N5pD; Tue, 07
 Oct 2025 06:26:54 +0200
Message-ID: <95feb448-a48d-4347-b0fd-36f9fb9bb6da@gmx.com>
Date: Tue, 7 Oct 2025 14:56:49 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iomap: ensure iomap_dio_bio_iter() only submit bios
 that are fs block aligned
To: Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>
 <aOSOaYLpBOZwMMF9@casper.infradead.org> <aOSRe1wDI5JD_wvc@infradead.org>
 <aOSU3h7tTLz-qDeE@casper.infradead.org>
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
In-Reply-To: <aOSU3h7tTLz-qDeE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4LcmbAFTXKi7+9i0GNamgD1RjNMrdca70p7QxIt1WlO3BmI6hwS
 Lk9P2l3+A3iKQxCzmhHK9Pl+OeeAtbOBUiIz8211ZJBKC0vVUM0zlt9JKfnuSiR5uYlhIN5
 gOJy3pmkliEgzMJ0J+yrNno79gC6f0ZPsyCcxUXTOp0z53apCPOWRKlaan9BiFdvz1okhVf
 nSuXMhLatSKklUpEX5C+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ze/hM0+SziM=;DubYANQbCcbQzTyfWCAT5VhKReg
 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



=E5=9C=A8 2025/10/7 14:49, Matthew Wilcox =E5=86=99=E9=81=93:
> On Mon, Oct 06, 2025 at 09:05:15PM -0700, Christoph Hellwig wrote:
>> On Tue, Oct 07, 2025 at 04:52:09AM +0100, Matthew Wilcox wrote:
>>> On Tue, Oct 07, 2025 at 01:40:22PM +1030, Qu Wenruo wrote:
>>>> During my development of btrfs bs > ps support, I hit some read bios
>>>> that are submitted from iomap to btrfs, but are not aligned to fs blo=
ck
>>>> size.
>>>>
>>>> In my case the fs block size is 8K, the page size is 4K. The ASSERT()
>>>> looks like this:
>>>
>>> Why isn't bdev_logical_block_size() set correctly by btrfs?
>>
>> bdev_logical_block_size is never set by the file system.  It is the LBA
>> size of the underlying block device.  But if the file system block size
>> is larger AND the file system needs to do file system block size
>> granularity operations that is not the correct boundary.  See also the
>> iov_iter_alignment for always COW / zoned file system in
>> xfs_file_dio_write.
>=20
> But the case he's complaining about is bs>PS, so the LBA size really is
> larger than PAGE_SIZE.
>=20

That bdev_logical_block_size() really looks like something bounded to=20
the block device, not the fs, thus I'm not sure if it's the best layer=20
to handle it.

Furthermore, there is something like RAIDZ down in the roadmap, where we=
=20
will have raid stripe length smaller than fs block size.

In that case we will need to explicitly distinguish the io size from the=
=20
bdev, and the fs block size.

Thanks,
Qu

