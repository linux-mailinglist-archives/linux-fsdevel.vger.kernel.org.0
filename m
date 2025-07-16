Return-Path: <linux-fsdevel+bounces-55088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A52FB06D4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305DA1AA7174
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8CC2E764B;
	Wed, 16 Jul 2025 05:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oeT1Nyqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EE48CFC;
	Wed, 16 Jul 2025 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644412; cv=none; b=DbQE0fNRm6jT1MfVKaYHKgbF7y1Ob0DFvQRyDb+1LeEVhlNtlUyJjE0APtvJrQbF3Mt+oTk3Y8uCf3YdCom1zC5Pj190CoE5Oj/+2vicUHaOQskabfHSLWpL0AEr+CrGbljUG21cFIK+Jpf3oJlEQA8aeE7EPlg4/EZn7WixUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644412; c=relaxed/simple;
	bh=rZBG7DQM33GlZMGKj4mp03qZwHVbPzsqeifBB1LM3js=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rWZsIOkzysITSSuYJJP3g8AVpV1HVDvoVhRStDEnKePaYDxgBtWqOidT9n+qxE7nNTE8nNguKhghVXJE9PzqV83j24Vv09+ypBopsh2FTPImPx9yZdO/PATCyc35ilvIrlTZg+uXnttLiTm+QiW179GUW/I+iFndLt8WYEztWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oeT1Nyqj; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752644406; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/qADFoeOXBnAEHP6o81g96cI4IF1HJRJHWKwBGouJpA=;
	b=oeT1NyqjfjzJ2YmhyWz+Hq0lkl9JUfQCtaQFx8hH6YXWYCgfH64BMXKh8sJpQGi7JInaf2W6P8tWyemCvsUmbktNUNpPOSD3n6jok1RgbrHkKsZ2LA/TR9xnJfl9YduELmT8pgwEOO0pEYWw+VT/gXQJwNw/XyDLIlKYYzYw3Hs=
Received: from 30.221.131.131(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj2mLXU_1752644403 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 13:40:04 +0800
Message-ID: <e143f730-6ae7-491e-985e-cc021411edd8@linux.alibaba.com>
Date: Wed, 16 Jul 2025 13:40:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Qu Wenruo <wqu@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, David Howells <dhowells@redhat.com>,
 netfs@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
 <eeee0704-9e76-4152-bb8e-b5a0e096ec18@linux.alibaba.com>
 <b43fe06d-204b-4f47-a7ff-0c405365bc48@suse.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b43fe06d-204b-4f47-a7ff-0c405365bc48@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/16 12:54, Qu Wenruo wrote:
> 
> 
> 在 2025/7/16 10:46, Gao Xiang 写道:
>> ...
>>
>>>
>>>>
>>>> There's some discrepancy between filesystems whether you need scratch
>>>> space for decompression.  Some filesystems read the compressed data into
>>>> the pagecache and decompress in-place, while other filesystems read the
>>>> compressed data into scratch pages and decompress into the page cache.
>>>
>>> Btrfs goes the scratch pages way. Decompression in-place looks a little tricky to me. E.g. what if there is only one compressed page, and it decompressed to 4 pages.
>>
>> Decompression in-place mainly optimizes full decompression (so that CPU
>> cache line won't be polluted by temporary buffers either), in fact,
>> EROFS supports the hybird way.
>>
>>>
>>> Won't the plaintext over-write the compressed data halfway?
>>
>> Personally I'm very familiar with LZ4, LZMA, and DEFLATE
>> algorithm internals, and I also have experience to build LZMA,
>> DEFLATE compressors.
>>
>> It's totally workable for LZ4, in short it will read the compressed
>> data at the end of the decompressed buffers, and the proper margin
>> can make this almost always succeed.
> 
> I guess that's why btrfs can not go that way.
> 
> Due to data COW, we're totally possible to hit a case that we only want to read out one single plaintext block from a compressed data extent (the compressed size can even be larger than one block).
> 
> In that case such in-place decompression will definitely not work.

Ok, I think it's mainly due to btrfs compression design.  Another point
is that decompression inplace can also be used for multi-shot interfaces
(as you said, "swapping input/ output buffer when one of them is full")
like deflate, lzma and zstd. Because you can know when the decompressed
buffers and compressed buffers are overlapped since APIs are multi-shot,
and only copy the overlapped compressed data to some additional temprary
buffers (and they can be shared among multiple compressed extents).

It has less overhead than allocating temporary buffers to keep compressed
data during the whole I/O process (again, because it just uses very small
number buffers during decompression process), especially for slow (even
network) storage devices.

I do understand Btrfs may not consider this because of different target
users, but one of EROFS main use cases is low overhead decompression
under the memory pressure (maybe + cheap storage), LZ4 + inplace
decompression is useful.

Anyway, I'm not advocating inplace decompression in any case.  I think
unlike plain text, encoded data has various approaches to organize
on disk and utilize page cache.  Due to different on-disk design and
target users, there will be different usage mode.

As for EROFS, we already natively supports compressed large folios
since 6.11, and order-0 folio is always our use cases, so I don't
think this will give extra benefits to users.

> 
> [...]
> 
>>> All the decompression/compression routines all support swapping input/ output buffer when one of them is full.
>>> So kmap_local() is completely feasible.
>>
>> I think one of the btrfs supported algorithm LZO is not,
> 
> It is, the tricky part is btrfs is implementing its own TLV structure for LZO compression.
> 
> And btrfs does extra padding to ensure no TLV (compressed data + header) structure will cross block boundary.
> 
> So btrfs LZO compression is still able to swap out input/output halfway, mostly due to the btrfs' specific design.

Ok, it seems much like a btrfs-specific design, because it's much
like per-block compression for LZO instead, and it will increase
the compressed size, I know btrfs may not care, but it's not the
EROFS case anyway.

Thanks,
Gao Xiang

> 
> Thanks,
> Qu

