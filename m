Return-Path: <linux-fsdevel+bounces-15977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B08089660D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7E0B22E6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209358AAC;
	Wed,  3 Apr 2024 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G2towl6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289675674E;
	Wed,  3 Apr 2024 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128814; cv=none; b=Lro+0jsb/UK1o4re20jR+B1nq7Z1n7r4cFmvkz22whEGkOO/8mOiyS53qPFzHtof4/QKubahbSzZ3mROkfpJ6UkM0jZRbuc2gLhrqB57QivARtn/DTpB4KdrqMF6I/ola9ZvOYA+gOBZgXUOlytVDmv0aALRcym9cpvpsvEVFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128814; c=relaxed/simple;
	bh=EFQS2MPmdKlaZCoJDkONRd0nJJkmqhYJ9gH6BBCNkHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=njVSUKmSoB8NwWWUddHc8490GEevxGDw7wnZ+lgwf2ejg/k9QycuA5DNjwHuJjfIYQe5sB/yJWrjDm8lNyj8SfnJhno3SiP1TScdRhSADoPMTzb1WdGzXuMi1bozgrLR5RJ002ok14jKdPR3YWpfKZMXvk9158SBh1cIc3x686E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G2towl6C; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712128791; x=1712733591; i=quwenruo.btrfs@gmx.com;
	bh=EFQS2MPmdKlaZCoJDkONRd0nJJkmqhYJ9gH6BBCNkHw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=G2towl6CkzN+XkTSCmNhWGH+HFsZaq7v8WFyzt0LA4ZLSXnm9xDdDaRNpI/JhqFI
	 66UVzlQBhyFmBFUR8H5FFyW2v2NiEO4D7M19Puy6/Q0sfrJK5HaH64V3n7hyVAhpz
	 8BunCS/tEKqlTQNN7wxUemtKrRn0jWhKJ7MWqshA/S061cioBbk6Vx7MXlPZ494pn
	 p7a41wI47HtsKlvXDkMVqTcC24meaRulhSr7L8cP3DJyuAfa2Q+VGjcHTr6Xig9JG
	 uWJ3JfYL1QK9EiQcesMxQY2xNrCNMiCbymrKe1CsdTy0osUAqntbXIF0Hz6hCEJ9Q
	 O12W4S1qn66aiR5FGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1slxw32IuD-00woyE; Wed, 03
 Apr 2024 09:19:51 +0200
Message-ID: <305008f4-9e17-4435-bb1d-a56b1de63c9b@gmx.com>
Date: Wed, 3 Apr 2024 17:49:42 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] btrfs: fiemap: return extent physical size
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Qu Wenruo <wqu@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-doc@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
 <93686d5c4467befe12f76e4921bfc20a13a74e2d.1711588701.git.sweettea-kernel@dorminy.me>
 <a2d3cdef-ed4e-41f0-b0d9-801c781f9512@suse.com>
 <ff320741-0516-410f-9aba-fc2d9d7a6b01@dorminy.me>
 <d01b4606-38fa-4f27-8fbd-31de505ba3a3@dorminy.me>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <d01b4606-38fa-4f27-8fbd-31de505ba3a3@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ROFUlrDE9KuTfg3XnrTVZcAlE+oZ8h4b2aZaGlsGN3ksSnTnX3R
 Xgdozm5F7/5r/G/z2Y9IKAmhClKP/sOcyJrGE9/iwxVuLrN+DgzX8s9FpiwzH6qGIfVdb+/
 X9NA0TUEjxPOk9rbd50waz2wTJ08bpG4zKswvPJPN9qi2ajXcRsOh/WiYqx6q+Pj3rnQk6y
 PtXVoPKm5QMua2vs5Vm/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fFJ6QcTzzmQ=;PEC+EFG24g9kSZWvVL4C3T1WGly
 KeuAco8ruUUJ3c8EIe+N3XVce/YDGejxblVMMpTduskNsTZyimiN9iw+ER6IPsw6tZlBTi507
 YKQubyf/NvCbbcW/6ykkU4JJHp3jYcZVLzZ2398G+PBHgjuFLahYnvd9/jUUmaJBlLNJEeDmI
 O9xmCrlyGW+hdx/ODRVMIyQztNqLWdfhpFmxt8gMYOwqAPQyPjykFLSRdT/lRCLTQ8op3Iick
 LWpEswJ19aZ9cbaus9jY6Gxe82DX+e/74hePLCamGablWkudmbUNVjARisLun1w1Lj8oLKZcw
 ZrH6KrM5geCxtpQHk9ATxOD7gfFeqCOBT6qgeqFtEJd2AjGCHXnEZJ8p6EFWoH3RTY7fHNP9K
 uL2paiLucribzp7tH4KGsO1wxh999e35STQo3mbcXDAT1xcha1jQU2xWhZdXO3j/++BbwHc1G
 KuHuqNG5LawVQUprBAsInBBK2xri0xEtzELN+QQjYzR5+CyTPDj548HZRh3BXRF7hY9fKNihp
 5is9djHe2nwINeP/3QlTPx9uwJmsB6xCSkfwvzVXCB39HxqxRJ5KYz1Fix5VsO5b9C7N7q5i1
 ICf7W5aUjpK1WoY40hWLm2reBIDyeMOKdrrQ9JkSUgbEaPwxf7WA1/pme8Q6WxXjVeHcaKEqN
 Pcvq2SqyAS2RGFHPgJBHrE4+oj0RGE/LhmxpkFddrEzTYoaBGU/h32Y61gk2VtXyCg4uj+JjX
 ENgEHeCMZ1EsWCRvBmW1gDzm1EUWt3s8tSDvz8QnDJopoEmBUbi8VO0dQUIkz2V3ETxb+cJ7Q
 XAEU3orwSqcQjUXbxUj2muOmLI8D8DJ+CIZCyT/m+oRos=



=E5=9C=A8 2024/4/3 16:32, Sweet Tea Dorminy =E5=86=99=E9=81=93:
>>> This means, we will emit a entry that uses the end to the physical
>>> extent end.
>>>
>>> Considering a file layout like this:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0item 6 key (257 EXTENT_DATA 0) itemoff 1=
5816 itemsize 53
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 7 type 1 (=
regular)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte=
 13631488 nr 65536
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data offset 0 =
nr 4096 ram 65536
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent compression 0 =
(none)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0item 7 key (257 EXTENT_DATA 4096) itemof=
f 15763 itemsize 53
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 type 1 (=
regular)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte=
 13697024 nr 4096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data offset 0 =
nr 4096 ram 4096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent compression 0 =
(none)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0item 8 key (257 EXTENT_DATA 8192) itemof=
f 15710 itemsize 53
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 7 type 1 (=
regular)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte=
 13631488 nr 65536
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data offset 81=
92 nr 57344 ram 65536
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent compression 0 =
(none)
>>>
>>> For fiemap, we would got something like this:
>>>
>>> fileoff 0, logical len 4k, phy 13631488, phy len 64K
>>> fileoff 4k, logical len 4k, phy 13697024, phy len 4k
>>> fileoff 8k, logical len 56k, phy 13631488 + 8k, phylen 56k
>>>
>>> [HOW TO CALCULATE WASTED SPACE IN USER SPACE]
>>> My concern is on the first entry. It indicates that we have wasted
>>> 60K (phy len is 64K, while logical len is only 4K)
>>>
>>> But that information is not correct, as in reality we only wasted 4K,
>>> the remaining 56K is still referred by file range [8K, 64K).
>>>
>>> Do you mean that user space program should maintain a mapping of each
>>> utilized physical range, and when handling the reported file range
>>> [8K, 64K), the user space program should find that the physical range
>>> covers with one existing extent, and do calculation correctly?
>>
>> My goal is to give an unprivileged interface for tools like compsize
>> to figure out how much space is used by a particular set of files.
>> They report the total disk space referenced by the provided list of
>> files, currently by doing a tree search (CAP_SYS_ADMIN) for all the
>> extents pertaining to the requested files and deduplicating extents
>> based on disk_bytenr.
>>
>> It seems simplest to me for userspace for the kernel to emit the
>> entire extent for each part of it referenced in a file, and let
>> userspace deal with deduplicating extents. This is also most similar
>> to the existing tree-search based interface. Reporting whole extents
>> gives more flexibility for userspace to figure out how to report
>> bookend extents, or shared extents, or ...
>>
>> It does seem a little weird where if you request with fiemap only e.g.
>> 4k-16k range in that example file you'll get reported all 68k
>> involved, but I can't figure out a way to fix that without having the
>> kernel keep track of used parts of the extents as part of reporting,
>> which sounds expensive.
>>
>> You're right that I'm being inconsistent, taking off extent_offset
>> from the reported disk size when that isn't what I should be doing, so
>> I fixed that in v3.
>
> Ah, I think I grasp a point I'd missed before.
> - Without setting disk_bytenr to the actual start of the data on disk,
> there's no way to find the location of the actual data on disk within
> the extent from fiemap alone

Yes, that's my point.

> - But reporting disk_bytenr + offset, to get actual start of data on
> disk, means we need to report a physical size to figure out the end of
> the extent and we can't know the beginning.

disk_bytenr + offset + disk_num_bytes, and with the existing things like
length (aka, num_bytes), filepos (aka, key.offset) flags
(compression/hole/preallocated etc), we have everything we need to know
for regular extents.

For compressed extents, we also need ram_bytes.

If you ask me, I'd say put all the extra members into fiemap entry if we
have the space...

It would be u64 * 4 if we go 1:1 on the file extent items, otherwise we
may cheap on offset and ram_bytes (u32 is enough for btrfs at least), in
that case it would be u64 * 2 + u32 * 2.

But I'm also 100% sure, the extra members would not be welcomed by other
filesystems either.

Thanks,
Qu

>
> We can't convey both actual location, start, and end of the extent in
> just two pieces of information.
>
> On the other hand, if someone really needs to know the actual location
> on disk of their data, they could use the tree_search ioctl as root to
> do so?
>
> So I still think we should be reporting entire extents but am less
> confident that it doesn't break existing users. I am not sure how common
> it is to take fiemap output on btrfs and use it to try to get to
> physical data on disk - do you know of a tool that does so?
>
> Thank you!
>

