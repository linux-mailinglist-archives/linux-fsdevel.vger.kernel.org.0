Return-Path: <linux-fsdevel+bounces-8993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75783C9E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C2D1C234F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88A1130E59;
	Thu, 25 Jan 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bELAfsi4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9A6EB57;
	Thu, 25 Jan 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203395; cv=none; b=UWhXM9NcN6FCeT3WFfBlUwZl9ylnxSTREwm6nvd3fzXI9LLp8Hjk/6dsUr1lGz/2O9D+x7aMFR+QAuaki0stjo0hEvPHxmsOe1OF9JjDeFpDvqvHP8OVbuNCCeXbui55XymrjmloIzl/t/+pdRQdiHSFnFd+lomyjFVDciWnY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203395; c=relaxed/simple;
	bh=MK+U2MEGE3SsUnEsjfwVCkC79N7AdgnSB76OtGlsmFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpdVeVZTBXJEXgg1YS06L4gcblQyb9w1IVvwTOEZPfk1G/YrWZJ9CuFcvzi416DwoU5EotUpSMhsETX3j92wXAunfmZ2ttQ4YOo1YEkOn6d4kulkE7PyoX5cznTv0JyXZ5x+wEQBbIUrE8jdw+tKO2ckAnPAJjOkP7sYpq1jXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bELAfsi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E871C433C7;
	Thu, 25 Jan 2024 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706203394;
	bh=MK+U2MEGE3SsUnEsjfwVCkC79N7AdgnSB76OtGlsmFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bELAfsi4o/o7nKz7GDBtHHe/SexgXEjtuTMfj5KVkhgPx2+poUhouIZiLvdQd86P4
	 v9yiR8Witdo0BgZS9p69GEmMpB41cRlclRM7rU8VprFiAoagEDV4Bsod00TlmOJpLa
	 ulTEPeTZx5+fpFVPlrbZUhrmrPLBni56tk4jP4OvN0QB/HNYLOzyouLHVgwjc/01zJ
	 MpiC6wNZfqygP9y9QE5/23RBVC85CWc0ic11WfkJDE9vSjvNyzoJlnjJYStqcKU08Z
	 yx1j7CgtlaFZZBaS0qypLoCHtkM0dPiKc7q33sccf1pRIBO4nK8PjkxqmBZ00Kd24i
	 CiIjo+terGXoQ==
Date: Thu, 25 Jan 2024 18:23:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Gao Xiang <xiang@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Eric Sandeen <esandeen@redhat.com>, v9fs@lists.linux.dev, 
	linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
Message-ID: <20240125-eruption-holprig-1dea37c287a4@brauner>
References: <520668.1706191347@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <520668.1706191347@warthog.procyon.org.uk>

On Thu, Jan 25, 2024 at 02:02:27PM +0000, David Howells wrote:
> Here's a roadmap for the future development of netfslib and local caching
> (e.g. cachefiles).
> 
> Netfslib
> ========
> 
> [>] Current state:
> 
> The netfslib write helpers have gone upstream now and are in v6.8-rc1, with
> both the 9p and afs filesystems using them.  This provides larger I/O size
> support to 9p and write-streaming and DIO support to afs.
> 
> The helpers provide their own version of generic_perform_write() that:
> 
>  (1) doesn't use ->write_begin() and ->write_end() at all, completely taking
>      over all of of the buffered I/O operations, including writeback.
> 
>  (2) can perform write-through caching, setting up one or more write
>      operations and adding folios to them as we copy data into the pagecache
>      and then starting them as we finish.  This is then used for O_SYNC and
>      O_DSYNC and can be used with immediate-write caching modes in, say, cifs.
> 
> Filesystems using this then deal with iov_iters and ideally would not deal
> pages or folios at all - except incidentally where a wrapper is necessary.
> 
> 
> [>] Aims for the next merge window:
> 
> Convert cifs to use netfslib.  This is now in Steve French's for-next branch.
> 
> Implement content crypto and bounce buffering.  I have patches to do this, but
> it would only be used by ceph (see below).
> 
> Make libceph and rbd use iov_iters rather than referring to pages and folios
> as much as possible.  This is mostly done and rbd works - but there's one bit
> in rbd that still needs doing.
> 
> Convert ceph to use netfslib.  This is about half done, but there are some
> wibbly bits in the ceph RPCs that I'm not sure I fully grasp.  I'm not sure
> I'll quite manage this and it might get bumped.
> 
> Finally, change netfslib so that it uses ->writepages() to write data to the
> cache, even data on clean pages just read from the server.  I have a patch to
> do this, but I need to move cifs and ceph over first.  This means that
> netfslib, 9p, afs, cifs and ceph will no longer use PG_private_2 (aka
> PG_fscache) and Willy can have it back - he just then has to wrest control
> from NFS and btrfs.
> 
> 
> [>] Aims for future merge windows:
> 
> Using a larger chunk size than PAGE_SIZE - for instance 256KiB - but that
> might require fiddling with the VM readahead code to avoid read/read races.
> 
> Cache AFS directories - there are just files and currently are downloaded and
> parsed locally for readdir and lookup.
> 
> Cache directories from other filesystems.
> 
> Cache inode metadata, xattrs.

Implications for permission checking might get interesting depending on
how that's supposed to work for filesystems such as cephfs that support
idmapped mounts. But I need to understand more details to say something
less handwavy.

> 
> Add support for fallocate().
> 
> Implement content crypto in other filesystems, such as cifs which has its own
> non-fscrypt way of doing this.
> 
> Support for data transport compression.
> 
> Disconnected operation.
> 
> NFS.  NFS at the very least needs to be altered to give up the use of
> PG_private_2.
> 
> 
> Local Caching
> =============
> 
> There are a number of things I want to look at with local caching:
> 
> [>] Although cachefiles has switched from using bmap to using SEEK_HOLE and
> SEEK_DATA, this isn't sufficient as we cannot rely on the backing filesystem
> optimising things and introducing both false positives and false negatives.
> Cachefiles needs to track the presence/absence of data for itself.
> 
> I had a partially-implemented solution that stores a block bitmap in an xattr,
> but that only worked up to files of 1G in size (with bits representing 256K
> blocks in a 512-byte bitmap).
> 
> [>] An alternative cache format might prove more fruitful.  Various AFS
> implementations use a 'tagged cache' format with an index file and a bunch of
> small files each of which contains a single block (typically 256K in OpenAFS).
> 
> This would offer some advantages over the current approach:
> 
>  - it can handle entry reuse within the index
>  - doesn't require an external culling process
>  - doesn't need to truncate/reallocate when invalidating
> 
> There are some downsides, including:
> 
>  - each block is in a separate file
>  - metadata coherency is more tricky - a powercut may require a cache wipe
>  - the index key is highly variable in size if used for multiple filesystems
> 
> But OpenAFS has been using this for something like 30 years, so it's probably
> worth a try.
> 
> [>] Need to work out some way to store xattrs, directory entries and inode
> metadata efficiently.
> 
> [>] Using NVRAM as the cache rather than spinning rust.
> 
> [>] Support for disconnected operation to pin desirable data and keep
> track of changes.
> 
> [>] A user API by which the cache for specific files or volumes can be
> flushed.
> 
> 
> Disconnected Operation
> ======================
> 
> I'm working towards providing support for disconnected operation, so that,
> provided you've got your working set pinned in the cache, you can continue to
> work on your network-provided files when the network goes away and resync the
> changes later.

As long as it doesn't involve upcalls... :)

