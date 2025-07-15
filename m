Return-Path: <linux-fsdevel+bounces-55043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA2B069EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 01:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEDC16E99A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 23:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7142D63E6;
	Tue, 15 Jul 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="foYLwkng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BDB2AD0C;
	Tue, 15 Jul 2025 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622345; cv=none; b=gKprirQfkwdEwM7WNBnXNXKhJx3xdQD0KMVF09XVZyrYsYBJAupJ5UfvQL8eU0C7WSQ2EpqD02ibVZyPep5y/7AYMx7S4K1dngnkrznASTev2v28ZKYZEfDIS3ciBGbPd6lubh2TPihiT14+mMX2mlMFL91/7tG4eWGHSsshw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622345; c=relaxed/simple;
	bh=XiWC8Sf5y4F6iv4CG0GS88ZI3bnXxVegBbJcvsyC144=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=El4nT+DvwTaTFW+8Xx0m7zcgOpg576JGrNuq4ku42+1SiOMcqhn5YtXICXtXF4t/ctV/64p7VkfORo5K+VttYOygv3UiUtNEABzsaug/ayuDnu2GpoRDEhgvgSTV/91StCktdnCxcjcP3raPcfOoShd/csRre3PYqLqNXB79ZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=foYLwkng; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752622335; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nUy4PEMS4CazYHiywIu/1adtHnlC3QRDbiuwxgypLnQ=;
	b=foYLwkngtxAcCNclAv3NgyQLrrd3+GvGKJd/1yCSBLqHX+hl375L0fPC2ATk6/qkINjWggYd5RukK0NZaPVSnrs92uOnqvqZtwngFNE4Aq+/0r9pWNv15OBkFZHiF/fufdl5FVziQD7bbR83d3yCBS/YliwMd1ru+UU1NRa9qmQ=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj1gQiN_1752622331 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 07:32:12 +0800
Message-ID: <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
Date: Wed, 16 Jul 2025 07:32:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
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
 Hailong Liu <hailong.liu@oppo.com>, Barry Song <21cnbao@gmail.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matthew,

On 2025/7/16 04:40, Matthew Wilcox wrote:
> I've started looking at how the page cache can help filesystems handle
> compressed data better.  Feedback would be appreciated!  I'll probably
> say a few things which are obvious to anyone who knows how compressed
> files work, but I'm trying to be explicit about my assumptions.
> 
> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.  This would be a good
> point to stop reading and tell me about counterexamples.

At least the typical EROFS compresses variable-sized plaintext (at least
one block, e.g. 4k, but also 4k+1, 4k+2, ...) into fixed-sized compressed
blocks for efficient I/Os, which is really useful for small compression
granularity (e.g. 4KiB, 8KiB) because use cases like Android are usually
under memory pressure so large compression granularity is almost
unacceptable in the low memory scenarios, see:
https://erofs.docs.kernel.org/en/latest/design.html

Currently EROFS works pretty well on these devices and has been
successfully deployed in billions of real devices.

> 
>  From what I've been reading in all your filesystems is that you want to
> allocate extra pages in the page cache in order to store the excess data
> retrieved along with the page that you're actually trying to read.  That's
> because compressing in larger chunks leads to better compression.
> 
> There's some discrepancy between filesystems whether you need scratch
> space for decompression.  Some filesystems read the compressed data into
> the pagecache and decompress in-place, while other filesystems read the
> compressed data into scratch pages and decompress into the page cache.
> 
> There also seems to be some discrepancy between filesystems whether the
> decompression involves vmap() of all the memory allocated or whether the
> decompression routines can handle doing kmap_local() on individual pages.
> 
> So, my proposal is that filesystems tell the page cache that their minimum
> folio size is the compression block size.  That seems to be around 64k,
> so not an unreasonable minimum allocation size.  That removes all the
> extra code in filesystems to allocate extra memory in the page cache.> It means we don't attempt to track dirtiness at a sub-folio granularity
> (there's no point, we have to write back the entire compressed bock
> at once).  We also get a single virtually contiguous block ... if you're
> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
> vmap_file() which would give us a virtually contiguous chunk of memory
> (and could be trivially turned into a noop for the case of trying to
> vmap a single large folio).

I don't see this will work for EROFS because EROFS always supports
variable uncompressed extent lengths and that will break typical
EROFS use cases and on-disk formats.

Other thing is that large order folios (physical consecutive) will
caused "increase the latency on UX task with filemap_fault()"
because of high-order direct reclaims, see:
https://android-review.googlesource.com/c/kernel/common/+/3692333
so EROFS will not set min-order and always support order-0 folios.

I think EROFS will not use this new approach, vmap() interface is
always the case for us.

Thanks,
Gao Xiang

> 


