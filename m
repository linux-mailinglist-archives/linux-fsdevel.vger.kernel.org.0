Return-Path: <linux-fsdevel+bounces-13141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C08286BC25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412F5B2224C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A6713D316;
	Wed, 28 Feb 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZZMtG4hA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593DF13D2EE
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162670; cv=none; b=A9riMS+EKy2jW/Vuk4VGAyEqv/oY7V1tiBoYwbqG/ocJ1OLjUnVEdM7LvP66FScJVI5KWHWX/9q9WySYMFeflwrwxtTPZq/d/3Us1ji3VyltoNizJgz8Er4xHYoit6ioRqDXsMDepOws5m4xKICz47YFJqkAhKklUeG92jZTt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162670; c=relaxed/simple;
	bh=FgKJ8Nr8dXhQAliq0DvjYyHS+0VtzZFmVxXs5XQA3/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGB3xZ61YaAImAWh/kX/0dPsq2ZcF7EEFQ4CGt3jIvsGXtmpiC9BETkY0O/cMUHglLplE1yURy8Apz8FofpSF2DBymLtilPo3eIQ0kYCqbVbQBPD3RqZNYhe8Wv0cIjjFUsxMmGkD1NUbjkZ3rkq5e7KkU/HKFz/zPOuU777KC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZZMtG4hA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41SNOFnH004196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1709162658; bh=aLpaKC/xGwoHgFdGHg3o2dOEfRFF5USt86hoOxmf/NA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZZMtG4hAt+6zTQfKlkdJHAVcfAbrF+z9GlpdchJesS0W8mipd9Zcm0zzB8vYTbc7V
	 Azy7YCyorU4FuPCKjFVL5wtgZOpCgHM3aGb4AaV9RCJkBtL6t2blun/G6P9N068ALk
	 jgfcXbwOBYvIiI3VyizoGq7Txcz06uAQ1nSpA9zYq2xCexkBxuBkYZxELHeP+7g8ga
	 Gu9AbFQoCSEeS9cWUZxCSmwY72X5zt+3e8NxDWVsIpKfpKcdnuCUvY9I7uv8a1/P7G
	 nCDdnfzqqmOM/6BP4k74gRAmZympygLitxB0Wca6D5pUJMH2/wp1Ur4LMkh9NwYi1G
	 m4ltjvSU0Ko1Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 8B0913404B0; Wed, 28 Feb 2024 17:24:15 -0600 (CST)
Date: Wed, 28 Feb 2024 17:24:15 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Garry <john.g.garry@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <20240228232415.GB177082@mit.edu>
References: <20240228061257.GA106651@mit.edu>
 <b184a072-86ef-462b-a6da-c2537299aa59@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b184a072-86ef-462b-a6da-c2537299aa59@oracle.com>

On Wed, Feb 28, 2024 at 04:06:43PM +0000, John Garry wrote:
> 
> Note that the initial RFC for my series did propose an interface that does
> allow a write to be split in the kernel on a boundary, and that boundary was
> evaluated on a per-write basis by the length and alignment of the write
> along with any extent alignment granularity.
> 
> We decided not to pursue that, and instead require a write per 16K page, for
> the example above.

Yes, I did see that.  And that leads to the problem where if you do an
RWF_ATOMIC write which is 32k, then we are promising that it will be
sent as a single 32k SCSI or NVMe request --- even though that isn't
required by the database, the API is *promising* that we will honor
it.  But that leads to the problem where for buffered writes, we need
to track which dirty pages are part of write #1, where we had promised
a 32k "atomic" write, which pages were part of writes #2, and #3,
which were each promised to be 16k "atomic writes", and which pages
were part of write #4, which was promised to be a 64k write.  If the
pages dirtied by writes #1, #2, and #3, and #4 are all contiguous, how
do we know what promise we had made about which pages should be
atomically sent together in a single write request?  Do we have to
store all of this information somewhere in the struct page or struct
folio?

And if we use Matthew's suggestion that we treat each folio as the
atomic write unit, does that mean that we have to break part or join
folios together depending on which writes were sent with an RWF_ATOMIC
write flag and by their size?

You see?  This is why I think the RWF_ATOMIC flag, which was mostly
harmless when it over-promised unneeded semantics for Direct I/O, is
actively harmful and problematic for buffered I/O.

> 
> If you check the latest discussion on XFS support we are proposing something
> along those lines:
> https://lore.kernel.org/linux-fsdevel/Zc1GwE%2F7QJisKZCX@dread.disaster.area/
> 
> There FS_IOC_FSSETXATTR would be used to set extent size w/ fsx.fsx_extsize
> and new flag FS_XGLAG_FORCEALIGN to guarantee extent alignment, and this
> alignment would be the largest untorn write granularity.
> 
> Note that I already got push back on using fcntl for this.

There are two separable untorn write granularity that you might need to
set, One is specifying the constraints that must be required for all
block allocations associated with the file.  This needs to be
persistent, and stored with the file or directory (or for the entire
file system; I'll talk about this option in a moment) so that we know
that a particular file has blocks allocated in contiguous chunks with
the correct alignment so we can make the untorn write guarantee.
Since this needs to be persistent, and set when the file is first
created, that's why I could imagine that someone pushed back on using
fcntl(2) --- since fcntl is a property of the file descriptor, not of
the inode, and when you close the file descriptor, nothing that you
set via fcntl(2) is persisted.

However, the second untorn write granularity which is required for
writes using a particular file descriptor.  And please note that these
two values don't necessarily need to be the same.  For example, if the
first granularity is 32k, such that block allocations are done in 32k
clusters, aligned on 32k boundaries, then you can provide untorn write
guarantees of 8k, 16k, or 32k ---- so long as (a) the file or block
device has the appropriate alignment guarantees, and (b) the hardware
can support untorn write guarantees of the requested size.

And for some file systems, and for block devices, you might not need
to set the first untorn write granularity size at all.  For example,
if the block device represents the entire disk, or represents a
partition which is aligned on a 1MB boundary (which tends to be case
for GPT partitions IIRC), then we don't need to set any kind of magic
persistent granularity size, because it's a fundamental propert of the
partition.  As another example, ext4 has the bigalloc file system
feature, which allows you to set at file system creation time, a
cluster allocation size which is a power of two multiple of the
blocksize.  So for example, if you have a block size of 4k, and
block/cluster ratio is 16, then the cluster size is 64k, and all data
blocks will be done in aligned 64k chunks.

The ext4 bigalloc feature has been around since 2011, so it's
something that can be enabled even for a really ancient distro kernel.
:-) Hence, we don't actually *need* any file system format changes.
If there was a way that we could set a requeted untorn write
granularity size associated with all writes to a particular file
descriptor, via fcntl(2), that's all we actually need.  That is, we
just need the non-persistent, file descriptor-specific write
granularity parameter which applies to writes; and this would work for
raw block devices, where we wouldn't have any *place* to store file
attribute.  And like with ext4 bigalloc file systems, we don't need
any file system format changes in order to support untorn writes for
block devices, so long as the starting offset of the block device
(zero if it's the whole disk) is appropriately aligned.

Cheers,

						- Ted

