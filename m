Return-Path: <linux-fsdevel+bounces-31663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F97999C08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 07:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1533F285750
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 05:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7D1F4FAE;
	Fri, 11 Oct 2024 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ps5/9pzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E08F58;
	Fri, 11 Oct 2024 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728623971; cv=none; b=W30c9hFBZmYL4m0Aw4vaQhKcRkDSshb8Qai8wXVK2qrCOalPVYCu43UB8mHjtoOxgWmeti8Y8+uuwBJnUP7YEGlX8TJLuU5aOpBJiIFQnS04Gfk641FrrIn6D6Yg9SKzVRtjp68ZmEvoW9RVR3ox8GDTnGpyrSqyyif/WuUKXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728623971; c=relaxed/simple;
	bh=kF4Zi97F2mBPqNTaQRlaFgww7MXfO65DLKW6UZiOz1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hs91VzytX5tyqLIN2gF4zKDbgqOelcC81ZEaLeag5YUZKuHUHg6+PsCA9IkpU8OuPIzW6ErRFt8LxtjQK6Cb0q8ypdiXCaa52mzesNIlPMkrfI2dQhSyCXEGU55dHouC8nD6Vbz38HBZon+RdhbYkB0BRtE+RHjEYQ46Op8NKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ps5/9pzO; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728623958; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aAAGesr3LlXkZHRGQ5wlPZ55691z3kev5cH3VSYpE6U=;
	b=ps5/9pzO8NAkcecKx74/bTESApq5UZo49G+R3Gm/h+guwKcOgrA+vllJbpFA2PwYQByQOs4iz7lsWNyxZFqi4EaXa90E5l6b407yeHA+dZ57sCo8sTJ5VpZY56WvEs8qtyQJMCpGLrAQ6jDtCL0oWNVckACZNyfry7qEiy9PxVQ=
Received: from 30.27.66.120(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGowwCK_1728623956 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 13:19:17 +0800
Message-ID: <71aff177-90d8-44ef-9e9d-f043eb682da9@linux.alibaba.com>
Date: Fri, 11 Oct 2024 13:19:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] iomap: Introduce read_inline() function hook
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.de>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <8147ae0a45b9851eacad4e8f5a71b7997c23bdd0.1728071257.git.rgoldwyn@suse.com>
 <ZwCk3eROTMDsZql1@casper.infradead.org>
 <20241007174758.GE21836@frogsfrogsfrogs>
 <kplkze6blu5pmojn6ikv65qdsccyuxg4yexgkrmldv5stn2mr4@w6zj7ug63f3f>
 <Zwh0rzp8hpCoF/or@dread.disaster.area>
 <381c349d-2eb7-419f-a2f8-a41ca6a9e9f0@linux.alibaba.com>
 <ZwivELSTeFI41ubf@dread.disaster.area>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZwivELSTeFI41ubf@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/11 12:52, Dave Chinner wrote:
> [FYI, your email got classified as spam by gmail...]

(I know.. yet that is the only permitted way to send email at work..)

> 
> On Fri, Oct 11, 2024 at 11:28:42AM +0800, Gao Xiang wrote:
>> Hi Dave,
>>
>> On 2024/10/11 08:43, Dave Chinner wrote:
>>> On Thu, Oct 10, 2024 at 02:10:25PM -0400, Goldwyn Rodrigues wrote:
>>
>> ...
>>
>>>
>>> .... there is specific ordering needed.
>>>
>>> For writes, the ordering is:
>>>
>>> 	1. pre-write data compression - requires data copy
>>> 	2. pre-write data encryption - requires data copy
>>> 	3. pre-write data checksums - data read only
>>> 	4. write the data
>>> 	5. post-write metadata updates
>>>
>>> We cannot usefully perform compression after encryption -
>>> random data doesn't compress - and the checksum must match what is
>>> written to disk, so it has to come after all other transformations
>>> have been done.
>>>
>>> For reads, the order is:
>>>
>>> 	1. read the data
>>> 	2. verify the data checksum
>>> 	3. decrypt the data - requires data copy
>>> 	4. decompress the data - requires data copy
>>> 	5. place the plain text data in the page cache
>>
>> Just random stuffs for for reference, currently fsverity makes
>> markle tree for the plain text,
> 
> Well, that is specifically an existing implementation detail -
> the fsverity core does not care what data is asked to measure as long
> as it is the same data that it is asked to verify.
> 
> Hence a filesystem could ask fsverity to measure compressed,
> encrypted data, and as long as the filesystem also asks fsverity to
> measure the same compressed, encrypted data as it is read from disk
> it will work as expected.
> 
> We could do this quite easily - hand the compressed data record
> to fsverity one fsblock sized chunk at a time, and treat the empty
> regions between the end of the compressed record and the offset
> of the start of the next compressed record as a hole....

.. honestly I'm not quite sure that is an implementation detail,
for example, currently userspace can get the root hash digest of
files to check the identical files, such as the same data A:
   A + LZ4 = A1
   A + DEFLATE = A2
   A + Zstd = A3
All three files will have the same root digest for the current
fsverity use cases, but if merkle trees are applied to transformed
data, that will be difference and might not meet some users' use
cases anyway.

> 
> So, yeah, I think that fsverity can be placed at the at the "verify
> data on disk" layer successfully rather than at the "verify plain
> text" layer without actually impacting on it's functionality.
> 
> ....
>>> Compression is where using xattrs gets interesting - the xattrs can
>>> have a fixed "offset" they blong to, but can store variable sized
>>> data records for that offset.
>>>
>>> If we say we have a 64kB compression block size, we can store the
>>> compressed data for a 64k block entirely in a remote xattr even if
>>> compression fails (i.e. we can store the raw data, not the expanded
>>> "compressed" data). The remote xattr can store any amount of smaller
>>> data, and we map the compressed data directly into the page cache at
>>> a high offset. Then decompression can run on the high offset pages
>>> with the destination being some other page cache offset....
>>
>> but compressed data itself can also be multiple reference (reflink
>> likewise), so currently EROFS uses a seperate pseudo inode if it
>> decides with physical addresses as indexes.
> 
> Sure, but handling shared data extents and breaking of shared
> mappings on write is not an iomap/page cache problem - that's a
> problem the filesystem block mapping operations that iomap calls
> need to handle.
> 
> EROFS uses a separate pseudo inode so taht it can share page cache
> as well as shared blocks on disk. I don't think that compression
> changes that at all - the page cache contents for all those blocks
> are still going to be identical...
> 
> As for the case of shared compressed data extents in XFS, I think
> that shared status just needs a shared bit to added to the remote
> xattr extent record header. Nothing else will really have to change,
> because xattr record overwrites are naturally copy-on-write. Hence
> updating a record will always break sharing, and the "shared bit"
> simply propagates into the block freeing operation to indicate a
> refcount update for the blocks being freed is needed. I don't see
> supporting FICLONE on compressed inodes as a major issue.

Yes, I agree for XFS on-disk format it's quite easy.  My comment
related to a minor runtime point: "compressed data directly into
the page cache at a high offset".

That is if a separate pseudo inode is used to contain cached
compressed data, it will take the only one copy and one I/O for
shared compressed data if cache decompression is used..  Anyway,
that is XFS's proposal, so that was my minor comment through.

> 
>>> On the write side, compression can be done directly into the high
>>> offset page cache range for that 64kb offset range, then we can
>>> map that to a remote xattr block and write the xattr. The xattr
>>> naturally handles variable size blocks.
>>
>> Also different from plain text, each compression fses may keep
>> different encoded data forms (e.g. fses could add headers or
>> trailers to the on-disk compressed data or add more informations
>> to extent metadata) for their own needs.i
> 
> Sure, but that's something that the filesystem can add when encoding
> the data into the page cache. iomap treats the contents of the page
> caceh as entirely opaque - how "transformed" data is encoded in the
> destination folios is completely up to the filesystem doing the
> transformation. All iomap needs to care about is the offset and
> length of the opaque transformed data the filesystem needs to reside
> in the cache to perform the transformation.
> 
> i.e. The example I gave above for XFS compression doesn't need
> metadata in the page cache data because it is held in an externally
> indexed xattr btree record. That's an XFS compression implementation
> detail, not an iomap concern.

Got it.

Thanks,
Gao Xiang

> 
> -Dave.


