Return-Path: <linux-fsdevel+bounces-55046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7DB06A6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F821A640E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD407DA6D;
	Wed, 16 Jul 2025 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IWDgOfBY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD871172A;
	Wed, 16 Jul 2025 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625704; cv=none; b=fy+givWn9Hbxk0oyj+8pc5PB87c9dszdAqnC0/idupDgUjcaqHnTUgFtkaGU4drPImL2SB2rL/WbY7vddfMW532qTT+PbOxWBIqfNHwhSu6tZ2+/bgIeNwO4mvPpz1hO0+do3SbxdIJQEJdgUVADEP5xEBa+cAMpAV5j7g84E9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625704; c=relaxed/simple;
	bh=9ARb6EXj/Zkf3wG6jmItTKfTpPPPlWBHIVXQb2ehvko=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=FvPp7E+6D0K6RKHC+mj6Ajs1a7sfzGsd2CXAmHBArEND+db2shSAKvU+U+8eZEKbnpG6l2qrUsdz+rDUDFPvpGXbIq5AaeBBrsGUWjV1LhLiuXvJxVDRnvicsOUz3z5CwOd1r7BViloNaZwGUt0VBghJA3zxJYC96ImBStq2pfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IWDgOfBY; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752625699; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=LbjcxXFKh7BwDlSh88rF8t3KBJnwLKqPh8QSBj+K9Y8=;
	b=IWDgOfBYrG0/duq19Yqx8i8dLbAcIc1UrtDMk0EsBGf5nbAP6pxMcw4TeUy1v/YmKOl0Ql8NMeqHSFFzH1z8M5cpTj1HwwULW/f7IHW56wtGUcmjQKdCbsf8ZtkF0kP94sYSFRVYMShffV6t7CAjptkrUJ7TVKh78Qs+TNKpYIw=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj1msOW_1752625684 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 08:28:15 +0800
Message-ID: <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
Date: Wed, 16 Jul 2025 08:28:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>,
 Hailong Liu <hailong.liu@oppo.com>, Barry Song <21cnbao@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
In-Reply-To: <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/16 07:32, Gao Xiang wrote:
> Hi Matthew,
> 
> On 2025/7/16 04:40, Matthew Wilcox wrote:
>> I've started looking at how the page cache can help filesystems handle
>> compressed data better.  Feedback would be appreciated!  I'll probably
>> say a few things which are obvious to anyone who knows how compressed
>> files work, but I'm trying to be explicit about my assumptions.
>>
>> First, I believe that all filesystems work by compressing fixed-size
>> plaintext into variable-sized compressed blocks.  This would be a good
>> point to stop reading and tell me about counterexamples.
> 
> At least the typical EROFS compresses variable-sized plaintext (at least
> one block, e.g. 4k, but also 4k+1, 4k+2, ...) into fixed-sized compressed
> blocks for efficient I/Os, which is really useful for small compression
> granularity (e.g. 4KiB, 8KiB) because use cases like Android are usually
> under memory pressure so large compression granularity is almost
> unacceptable in the low memory scenarios, see:
> https://erofs.docs.kernel.org/en/latest/design.html
> 
> Currently EROFS works pretty well on these devices and has been
> successfully deployed in billions of real devices.
> 
>>
>>  From what I've been reading in all your filesystems is that you want to
>> allocate extra pages in the page cache in order to store the excess data
>> retrieved along with the page that you're actually trying to read.  That's
>> because compressing in larger chunks leads to better compression.
>>
>> There's some discrepancy between filesystems whether you need scratch
>> space for decompression.  Some filesystems read the compressed data into
>> the pagecache and decompress in-place, while other filesystems read the
>> compressed data into scratch pages and decompress into the page cache.
>>
>> There also seems to be some discrepancy between filesystems whether the
>> decompression involves vmap() of all the memory allocated or whether the
>> decompression routines can handle doing kmap_local() on individual pages.
>>
>> So, my proposal is that filesystems tell the page cache that their minimum
>> folio size is the compression block size.  That seems to be around 64k,
>> so not an unreasonable minimum allocation size.  That removes all the
>> extra code in filesystems to allocate extra memory in the page cache.> It means we don't attempt to track dirtiness at a sub-folio granularity
>> (there's no point, we have to write back the entire compressed bock
>> at once).  We also get a single virtually contiguous block ... if you're
>> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
>> vmap_file() which would give us a virtually contiguous chunk of memory
>> (and could be trivially turned into a noop for the case of trying to
>> vmap a single large folio).
> 
> I don't see this will work for EROFS because EROFS always supports
> variable uncompressed extent lengths and that will break typical
> EROFS use cases and on-disk formats.
> 
> Other thing is that large order folios (physical consecutive) will
> caused "increase the latency on UX task with filemap_fault()"
> because of high-order direct reclaims, see:
> https://android-review.googlesource.com/c/kernel/common/+/3692333
> so EROFS will not set min-order and always support order-0 folios.
> 
> I think EROFS will not use this new approach, vmap() interface is
> always the case for us.

... high-order folios can cause side effects on embedded devices
like routers and IoT devices, which still have MiBs of memory (and I
believe this won't change due to their use cases) but they also use
Linux kernel for quite long time.  In short, I don't think enabling
large folios for those devices is very useful, let alone limiting
the minimum folio order for them (It would make the filesystem not
suitable any more for those users.  At least that is what I never
want to do).  And I believe this is different from the current LBS
support to match hardware characteristics or LBS atomic write
requirement.

BTW, AFAIK, there are also compression optimization tricks related
to COW (like what Btrfs currently does) or write optimizations,
which would also break this.

For example, recompressing an entire compressed extent when a user
updates just one specific file block (consider random data updates)
is inefficient. Filesystems may write the block as uncompressed data
initially (since recompressing the whole extent would be CPU-intensive
and cause write amplification) and then consider recompressing it
during background garbage collection or when there are enough blocks
have been written to justify recompression of the original extent.

The Btrfs COW case was also pointed out by Wenruo in the previous
thread:
https://lore.kernel.org/r/62f5f68d-7e3f-9238-5417-c64d8dcf2214@gmx.com

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
> 


