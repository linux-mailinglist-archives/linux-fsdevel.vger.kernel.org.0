Return-Path: <linux-fsdevel+bounces-55192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04779B0809D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 00:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A75D174197
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA202EBDF7;
	Wed, 16 Jul 2025 22:45:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-04.prod.sxb1.secureserver.net (sxb1plsmtpa01-04.prod.sxb1.secureserver.net [188.121.53.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869228640D
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705953; cv=none; b=GPbPzuFH+n3x9cubSJiQuUYyZOZ5FO04clVeAqoL8ukU0QQtnnDyUNejhquNqV6Zqj5V9Enijha5642xqT5j5ZyFEatpuukHgl+etWO0jrfHF89J3Fdo5LiXc4kq+y5CSLiEMJDnTXtj7yUeiBqvFTd0MWNpqN04hr3jffbbNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705953; c=relaxed/simple;
	bh=NMP9084JD75v2eU5pfqTbg/2XaSNjwAG/rAMydJ3TiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lcWysXy0QmflpKBunP30DSNuwlU2xF9rldPMyivX2UNGYaDunaUDIc2HXIVVseZt30HolDRSnpACm9X95h0saFz5Utt4CYgPo5qeW9ttbeiDIQRRu1KaXpgf+ElcRktaAOaZoFvzsG9Ge0iZlaZumQ152c7/GeOgmLFdY9wnaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id cAlKuoVr96J4FcAlNu4Dmt; Wed, 16 Jul 2025 15:38:10 -0700
X-CMAE-Analysis: v=2.4 cv=TYmWtQQh c=1 sm=1 tr=0 ts=687829d2
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=Z9je9KOXq8erZ9ix0VAA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <f4b9faf9-8efd-4396-b080-e712025825ab@squashfs.org.uk>
Date: Wed, 16 Jul 2025 23:37:28 +0100
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
 linux-cifs@vger.kernel.org
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfF7PhqfDTvf0GLbE+ZqPgfM1AhwOJlHSpsMzx6XOcDZuT9YqsTaq8QVlGaLYbZSCACkmupuX6+moDnsLw8z6oXo/oW+NBiLgU6y5TBJWXg6tV88e5Euj
 1giZ2fZsoopVdzm/v4Tlp3z0KvSwDUxO6m0SnvjOtH9zvReYNZLA2FNMM+DrFEJFaiIkCvRrmoBmbv4h3OnUHX5sclo1/Wezm+BEj6dLaDXAyuKVHku8Kvy6
 3A9SkS3ZtrCtIQcuDoAamTotabkyq8u+NbETcu+wgZcHz79D2Cqa4hBUqSAxUGPLdjqjvKdz0Y+w0IVDS3aE1LUKcnIDytVIxDas6bwTbJD2/Yz7PsjwtKtl
 JoRL1DOXscuVOLxBvw+0xQnpDotzu0Vo1GrTRn1rfHJKD4Exmb3wOCyCD+h2AYMKaGBCjBVgXvf5G6DK3/s3MVbkLRjH09uolqpyyQAsKggrC2Moa3qwKWia
 tBwCIdLZWPpQOFc2HOlLjv7vmcMVwr97TODyoKXcYSBdRG5Aj19H80t7Vc1kPbVELOFd5EDHNfQ8ATDugkZBq2J/V21dERsOluc2pak7RNmbJyOzrPcIwalB
 Nf6fEekDRHicDoV2q2tew6sPotWewTjdjMw9iwbRhZpamiZqsp/XI9f5XhZcOQoUdsCy/ey/U995vHBeMMo6H0yRk9BNVCMpINAVKCtQmjIv7xNp+Ioo2Sxs
 gPnTBcUD++qhM8KfplNiTcJXoQ96eTIssdBe+BMWUXv1qhpWQ9GKojXGcX8mKMvEG7sKSgFMNrc3J5Xm28GieZWCzy/+ZDv2I7VwecP2j5T1w/WLBfHEUgk5
 gufg4AqEMh/tWtnL4rvSfpFcA6zbEUbuBjvPEzIYLlyjogb7n+266BU1vQZO72XCtgIJOh/KDHsuteA4LS7mxuWjWepHBR+R1mjV5Mwu



On 15/07/2025 21:40, Matthew Wilcox wrote:
> I've started looking at how the page cache can help filesystems handle
> compressed data better.  Feedback would be appreciated!  I'll probably
> say a few things which are obvious to anyone who knows how compressed
> files work, but I'm trying to be explicit about my assumptions.
> 
> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.  This would be a good
> point to stop reading and tell me about counterexamples.

For Squashfs Yes.

> 
>>From what I've been reading in all your filesystems is that you want to
> allocate extra pages in the page cache in order to store the excess data
> retrieved along with the page that you're actually trying to read.  That's
> because compressing in larger chunks leads to better compression.
> 

Yes.

> There's some discrepancy between filesystems whether you need scratch
> space for decompression.  Some filesystems read the compressed data into
> the pagecache and decompress in-place, while other filesystems read the
> compressed data into scratch pages and decompress into the page cache.
> 

Squashfs uses scratch pages.

> There also seems to be some discrepancy between filesystems whether the
> decompression involves vmap() of all the memory allocated or whether the
> decompression routines can handle doing kmap_local() on individual pages.
> 

Squashfs does both, and this depends on whether the decompression
algorithm implementation in the kernel is multi-shot or single-shot.

The zlib/xz/zstd decompressors are multi-shot, in that you can call them
multiply, giving them an extra input or output buffer when it runs out.
This means you can get them to output into a 4K page at a time, without
requiring the pages to be contiguous.  kmap_local() can be called on each
page before passing it to the decompressor.

The lzo/lz4 decompressors are single-shot, they expect to be called once,
with a single contiguous input buffer containing the data to be
decompressed, and a single contiguous output buffer large enough to hold
all the uncompressed data.

> So, my proposal is that filesystems tell the page cache that their minimum
> folio size is the compression block size.  That seems to be around 64k,
> so not an unreasonable minimum allocation size.  That removes all the
> extra code in filesystems to allocate extra memory in the page cache.
> It means we don't attempt to track dirtiness at a sub-folio granularity
> (there's no point, we have to write back the entire compressed bock
> at once).  We also get a single virtually contiguous block ... if you're
> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
> vmap_file() which would give us a virtually contiguous chunk of memory
> (and could be trivially turned into a noop for the case of trying to
> vmap a single large folio).
> 

The compression block size in Squashfs can be 4K to 1M in size.

Phillip

