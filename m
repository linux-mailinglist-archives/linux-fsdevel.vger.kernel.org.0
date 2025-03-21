Return-Path: <linux-fsdevel+bounces-44694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA6A6B6CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 10:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740411898795
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997B1F03F4;
	Fri, 21 Mar 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NwxlUS8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA4374EA;
	Fri, 21 Mar 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548586; cv=none; b=hiC5P/xx7+AC3d71nEoYyXIrGeqnj92343bSVgPKk2s2ZYofYrB/41oH/VEVXSeJaP+tzip2mFyRKV9mAb4rfD6VHLnj1E+E9ZNfc1JBNSFIOwJEHz+FmW6KTsfQYpaWmD6MmM1zPInpGjRNtXJXqShGT9r0j6ob/h54d0Iq/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548586; c=relaxed/simple;
	bh=gmZGwBlujsya0qb9iK7invYZ7mBz+7qTjt8Dty1Oe5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfgvVZOwwX7Z2MC826hBHXZzzjAW6b2MCDzcKb1XtF5ovMFXLZixyi00mYx/ZWWLKYGTVn0T6NdLuvj4Pf1sF2W/iFXNwzwc0tLYMZaTSqD1TBSgWYubqoBN4ciiMvfm9Rg6iRsI58vaFuJllygz7/cHzksIHTn+TgDd9Kye4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NwxlUS8H; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1742548576; x=1743153376; i=quwenruo.btrfs@gmx.com;
	bh=cqKGHNif+uKW4XLItfKP7I2aMgFT/ssObNzU1p66PCw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NwxlUS8H3RSi+vUXZOmSMYU26CmF7dHD7JK+L06N4ZqPuv/yocM/SruTSPxGVJqW
	 QxQvevxkuRnFyP4vzgEafTF7YEESxgm6O3aCbke78JmXOIOyzuhEfTR0gCLxsjq4s
	 q59LMXy0fQOv8H1yRzmS2KJjtQ4TQYUJHR0h5aW2VP5Yk58rx7lo4ePWztqChk9lu
	 7MZc2R4iUM3Yb3N9ig3Yt5zZGXAfIz0MiB7RP3OM5dqNCus7CMzz1NWeikB+i4VNE
	 dEQtp8dOh+IRuA+Wgh9M6W1ouWMNXTjW3cUUePQ+8mTfB+925MUdu4flXNdh/W+xs
	 XEBxao7/h9mCOBT+NA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1ti8L822d7-00PNkd; Fri, 21
 Mar 2025 10:16:16 +0100
Message-ID: <65a02281-bd7d-4b34-a8a2-97af052da301@gmx.com>
Date: Fri, 21 Mar 2025 19:46:11 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Iomap buffered write short copy handling (with full folio
 uptodate)
To: Dave Chinner <david@fromorbit.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-xfs@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <1f7da968-4a4c-4d3e-8014-5c2e89d65faa@gmx.com>
 <Z90p3fep5m8Lxv7d@dread.disaster.area>
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
In-Reply-To: <Z90p3fep5m8Lxv7d@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZTTWwdppiNopFBim3QrfdHDRC1tJnXoA/wIimo+WvU5PvA8sMWX
 zevcyJKeAEaxO8m4fOZDUvpjYa2blyzb3CEi1+Ajj4qvsh/jCUzK4q73QwPKgOJAtt3PiwD
 SzAnkxZwtcIAvv5iudxjzQCicdeyBtkVrw0YtbHQK/SMXiRM3JKzlrK0Ks7hMLJor1KKmr+
 UFlbqMifY+J2/qWniqCEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UkyKSzWa5QA=;hhM5X6S8yNbK1e1WUOQ8wfDXTC2
 JDTOmFJwbhlqeKmVwvTbKYYFaKg9leU/I/5efSauPGqSCt8IgOPZkTvAKPXEVID6gNh7crebS
 5hw36HPW0ZiGcSbJgdCDO2s1DKql7fbNfRVT90YspFPR3RdlLRgDXcmAZhZtOcDUZoPj0uI/w
 QZ5gKg8fXB4AvwaQTjjMdnFnET3vNUYoA3WsCni8hkhfqua5fN7G2wHPdPPCWBHY0ccV0ATk6
 u8iwtLQSkbHq9+nTvunfYsCVlALMVq87kEOLGFCz81e+oQgRvO4C7i77yckfiUN81q5C7/j6/
 yKuerzKGpdTuJYaZvX//fymprX0KBwpvtQze0tyLN1OjdKydpQ01mteutOzwC54XGgYUup+bU
 Sh6kKKon9CEC5/HbkZoOb3WqQjjYWD0r5QmaqAzfU1FESO8QPMeedMRble76/JOgmyYA3QSus
 qbqgEAuY9jx70ic2SftvO5g6yHxvqsIWAnt394RJfwnCDdXXLAR8CG65HRaxQFWO/X3oL2Um5
 7390DyesEuPC78JOaqWM/P1DXXtUM8q646GfWtbTHGZ2LJboymJlQy8Fv+B/PjM8jFwjRcgMl
 Wod2HGa5MAaIKChDNA8nw6zHvSf0H2ZIpe3ZZpDkbGo2fmz+8VfptfzBEgpSQ2cl+/pcPDJWh
 jmVK6JPrbcXClOFQ6wfmnV+g9Gltz0nbr5w2cZlKuBnmRo0UzzvVOEg/yipCLNhN4KGvYMnsk
 B46zOhHc/l5r4Hh2zjueARXUEyr8g09KxE8lpWk23GZKMfYKlE1g7r84YF0izn9W+8JEE+Nqn
 ooRWRr8YUA0YYPyilbfgck4prubpAArY1qMRpecinZCY0T4lzBdv/xpOtlKMpyB1PPbZiH7e2
 TrYkwzPnKpD0x53XTYbywtN9YtX+HuxlIHAj/J0v6cyklvmi9mekXb0azbk8t5rH2BZ+kh6ex
 12sK3w4Kyyqdwv2DmiwYlSbIq7m+/NrT4tzQhPQgMuungifW+BngiZk/MZlgZdXEg91ObJn9o
 exvxwZznXrDAk26zAxr62E/pPOG53V04fgaXQm/SFZzztM4e9o331r9uZhe9+oZtmFK/KqwVs
 bRvR++iAvSGCTUn3u0YFeZISxJ+FZ4hNC+9eqSGxyCBif/K924KJ5lpwIjotkp1DxU8rXwPgL
 NW4cftbyWsQik6a0egx1zPByxmf04L7OG8qiEMiEJe69lWTv0KbnJtVnGaJPr9i8VoXRw2+ME
 a3SAtJWHmsvWYRdlrsGOfU1sH+LIpYBu7Y2lz0zSmh8m//ob/JH4pl+OWYmb5ikYpQdF/Eqv9
 UX45Y9Ok9gA9ab7Ol8B1uKGXx8g+2N1Osq5fKhBTRoWVL/ujPI2/YPmq0UuIraz9yGUokJY4D
 /zpB24Q4lNToTfhHAvZC7oJsTGc9fT391HNLkSH4C+deEgZlZhXBMb0jR9WmeEfwNzhLteFdM
 qY6D2cvKd+FxR3I9VEweUBvbRa6g=



=E5=9C=A8 2025/3/21 19:27, Dave Chinner =E5=86=99=E9=81=93:
> On Fri, Mar 21, 2025 at 06:42:25PM +1030, Qu Wenruo wrote:
>> Hi,
>>
>> I'm wondering if the current iomap short copy handler can handle the
>> following case correctly:
>>
>> The fs block size is 4K, page size is 4K, the buffered write is into
>> file range [0, 4K), the fs is always doing data COW.
>>
>> The folio at file offset 0 is already uptodate, and the folio size is
>> also 4K.
>>
>> - ops->iomap_begin() got called for the range [0, 4K) from iomap_iter()
>>    The fs reserved space of one block of data, and some extra metadata
>>    space.
>>
>> - copy_folio_from_iter_atomic() only copied 1K bytes
>>
>> - iomap_write_end() returned true
>>    Since the folio is already uptodate, we can handle the short copy.
>>    The folio is marked dirty and uptodate.
>>
>> - __iomap_put_folio() unlocked and put the folio
>>
>> - Now a writeback was triggered for that folio at file offset 0
>>    The folio got properly written to disk.
>>
>>    But remember we have only reserved one block of data space, and that
>>    reserved space is consumed by this writeback.
>
> This bumps the internal inode mapping generation number....
>
>>    What's worse is, the fs can even do a snapshot of that involved inod=
e,
>>    so that the current copy of that 1K short-written block will not be
>>    freed.
>>
>> - copy_folio_from_iter_atomic() copied the remaining 3K bytes
>
> No, we don't get that far. iomap_begin_write() calls
> __iomap_get_folio() to get and lock the folio again, then calls
> folio_ops->iomap_valid() to check that the iomap is still valid.
>
> In the above case, the cookie in the iomap (the mapping generation
> number at the time the iomap was created by ->iomap_begin) won't
> match the current inode mapping generation number as it was bumped
> on writeback.
>
> Hence the iomap is marked IOMAP_F_STALE, the current write is
> aborted before it starts, then iomap_write_iter() sees IOMAP_F_STALE
> and restarts the write again.
>
> We then get a new mapping from ops->iomap_begin() with a new 1 block
> reservation for the remaining 3kB of data to be copied into that
> block.
>
> i.e. iomaps are cached information, and we have to validate that the
> mapping has not changed once we have all the objects we are about to
> modify locked and ready for modification.

Thanks a lot!

Didn't notice the iomap_valid() handling is even involved.

>
>>    All these happens inside the do {} while () loop of
>>    iomap_write_iter(), thus no iomap_begin() callback can be triggered =
to
>>    allocate extra space.
>>
>> - __iomap_put_folio() unlocked and put the folio 0 again.
>>
>> - Now a writeback got started for that folio at file offset 0 again
>>    This requires another free data block from the fs.
>>
>> In that case, iomap_begin() only reserved one block of data.
>> But in the end, we wrote 2 blocks of data due to short copy.
>>
>> I'm wondering what's the proper handling of short copy during buffered
>> write.
>
>> Is there any special locking I missed preventing the folio from being
>> written back halfway?
>
> Not locking, just state validation and IOMAP_F_STALE. i.e.
> filesystems that use delalloc or cow absolutely need to implement
> folio_ops->iomap_valid() to detect stale iomaps....

Got it, this also means a COW fs must implement that callback if using
iomap.

And this solution also has a good optimization where if no writeback
happened between the lock and unlock, we can just reuse the last
reserved space without extra allocation.

Let me explore if we can do a similar solution in btrfs, other than the
current always-re-allocate behavior.

Thanks,
Qu

>
>> Or is it just too hard to trigger such case in the real world?
>
> Triggered it, we certainly did. It caused data corruption and took
> quite some time to triage and understand.
>
> -Dave.


