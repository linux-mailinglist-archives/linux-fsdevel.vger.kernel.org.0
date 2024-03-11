Return-Path: <linux-fsdevel+bounces-14169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B064A878AD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A98282234
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844825812A;
	Mon, 11 Mar 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc5NxIpL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34B482C1;
	Mon, 11 Mar 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196697; cv=none; b=CHN8DzBHot1AZJmH4zcrsYNaBhKlJK0xP+kY2nX9+76mKTZR/Tl/UTpPJznRWyd15s9BAw810oWNUJyVQ4gn+HMAOcZyCX+yNWNFpAYKjoTRPaQYSLHQxQ88er4iEEp/Rayy8uSzsUxwIlfzabW7pfHik6Hx9y9UfvS701taj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196697; c=relaxed/simple;
	bh=hJur/pDiHJhAry8SmKfQygvh/y7PJVKL8g1n94l4nyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln6llg2fYCJcaFwOS+8PDWU5ayP6YpwmNe2nyv0DwcGdPYVsvqBJ69YPspPP5d52F1QAKB8l+hpo/LvwRFmgzdRSDKWK5rxlZWKO62jiX/Qd/inrj4UVNybKng7l+40VYwb4rzVno+c1TKti/BX/zW1fKKwn8/9udD5R32z0f+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc5NxIpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D870C43390;
	Mon, 11 Mar 2024 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710196696;
	bh=hJur/pDiHJhAry8SmKfQygvh/y7PJVKL8g1n94l4nyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zc5NxIpLQhKwbRvhfYCZw5nNzCYgx8pGde02Jr+kqIsJ2Ya6IfzJxLXRLmqHVa/MS
	 PnuRTFTd4GJ5ArL3Y1zv6GA92/Ugc9fzCiTpLObZDi7Foqo3HduW4a9/3GoK9rWHrR
	 lXigdAJaXtyDSX5ZTBVZeWqh7doOG5Z0lXGC5sKkAG42SR0JDw0xE2LHsxbogyni/t
	 Cxo3ZccaqAD2AOpLPQTeEwJ3i74ISBWRxe6hXwZbV6zMdUGAII5Xj6cqIYkqNxcZ0C
	 UFODpOUC+2gOeL1TL0HEYpsvOIRtKBfKrnOYkBMC/uwTOx7W2tssR8OccyvqTpF4fN
	 BRCOXZOSiWXDw==
Date: Mon, 11 Mar 2024 15:38:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v5 06/24] fsverity: pass tree_blocksize to
 end_enable_verity()
Message-ID: <20240311223815.GW1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-8-aalbersh@redhat.com>
 <20240305005242.GE17145@sol.localdomain>
 <20240306163000.GP1927156@frogsfrogsfrogs>
 <20240307220224.GA1799@sol.localdomain>
 <20240308034650.GK1927156@frogsfrogsfrogs>
 <20240308044017.GC8111@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308044017.GC8111@sol.localdomain>

[add willy and linux-mm]

On Thu, Mar 07, 2024 at 08:40:17PM -0800, Eric Biggers wrote:
> On Thu, Mar 07, 2024 at 07:46:50PM -0800, Darrick J. Wong wrote:
> > > BTW, is xfs_repair planned to do anything about any such extra blocks?
> > 
> > Sorry to answer your question with a question, but how much checking is
> > $filesystem expected to do for merkle trees?
> > 
> > In theory xfs_repair could learn how to interpret the verity descriptor,
> > walk the merkle tree blocks, and even read the file data to confirm
> > intactness.  If the descriptor specifies the highest block address then
> > we could certainly trim off excess blocks.  But I don't know how much of
> > libfsverity actually lets you do that; I haven't looked into that
> > deeply. :/
> > 
> > For xfs_scrub I guess the job is theoretically simpler, since we only
> > need to stream reads of the verity files through the page cache and let
> > verity tell us if the file data are consistent.
> > 
> > For both tools, if something finds errors in the merkle tree structure
> > itself, do we turn off verity?  Or do we do something nasty like
> > truncate the file?
> 
> As far as I know (I haven't been following btrfs-progs, but I'm familiar with
> e2fsprogs and f2fs-tools), there isn't yet any precedent for fsck actually
> validating the data of verity inodes against their Merkle trees.
> 
> e2fsck does delete the verity metadata of inodes that don't have the verity flag
> enabled.  That handles cleaning up after a crash during FS_IOC_ENABLE_VERITY.
> 
> I suppose that ideally, if an inode's verity metadata is invalid, then fsck
> should delete that inode's verity metadata and remove the verity flag from the
> inode.  Checking for a missing or obviously corrupt fsverity_descriptor would be
> fairly straightforward, but it probably wouldn't catch much compared to actually
> validating the data against the Merkle tree.  And actually validating the data
> against the Merkle tree would be complex and expensive.  Note, none of this
> would work on files that are encrypted.
> 
> Re: libfsverity, I think it would be possible to validate a Merkle tree using
> libfsverity_compute_digest() and the callbacks that it supports.  But that's not
> quite what it was designed for.
> 
> > Is there an ioctl or something that allows userspace to validate an
> > entire file's contents?  Sort of like what BLKVERIFY would have done for
> > block devices, except that we might believe its answers?
> 
> Just reading the whole file and seeing whether you get an error would do it.
> 
> Though if you want to make sure it's really re-reading the on-disk data, it's
> necessary to drop the file's pagecache first.

I tried a straight pagecache read and it worked like a charm!

But then I thought to myself, do I really want to waste memory bandwidth
copying a bunch of data?  No.  I don't even want to incur system call
overhead from reading a single byte every $pagesize bytes.

So I created 2M mmap areas and read a byte every $pagesize bytes.  That
worked too, insofar as SIGBUSes are annoying to handle.  But it's
annoying to take signals like that.

Then I started looking at madvise.  MADV_POPULATE_READ looked exactly
like what I wanted -- it prefaults in the pages, and "If populating
fails, a SIGBUS signal is not generated; instead, an error is returned."

But then I tried rigging up a test to see if I could catch an EIO, and
instead I had to SIGKILL the process!  It looks filemap_fault returns
VM_FAULT_RETRY to __xfs_filemap_fault, which propagates up through
__do_fault -> do_read_fault -> do_fault -> handle_pte_fault ->
handle_mm_fault -> faultin_page -> __get_user_pages.  At faultin_pages,
the VM_FAULT_RETRY is translated to -EBUSY.

__get_user_pages squashes -EBUSY to 0, so faultin_vma_page_range returns
that to madvise_populate.  Unfortunately, madvise_populate increments
its loop counter by the return value (still 0) so it runs in an
infinite loop.  The only way out is SIGKILL.

So I don't know what the correct behavior is here, other than the
infinite loop seems pretty suspect.  Is it the correct behavior that
madvise_populate returns EIO if __get_user_pages ever returns zero?
That doesn't quite sound right if it's the case that a zero return could
also happen if memory is tight.

I suppose filemap_fault could return VM_FAULT_SIGBUS in this one
scenario so userspace would get an -EFAULT.  That would solve this one
case of weird behavior.  But I think that doesn't happen in the
page_not_uptodate case because fpin is non-null?

As for xfs_scrub validating data files, I suppose it's not /so/
terrible to read one byte every $fsblocksize so that we can report
exactly where fsverity and the file data became inconsistent.  The
POPULATE_READ interface doesn't tell you how many pages it /did/ manage
to load, so perhaps MADV_POPULATE_READ isn't workable anyway.

(and now I'm just handwaving wildly about pagecache behaviors ;))

--D

> > Also -- inconsistencies between the file data and the merkle tree aren't
> > something that xfs can self-heal, right?
> 
> Similar to file data itself, only way to self-heal would be via mechanisms that
> provide redundancy.  There's been some interest in adding support forward error
> correction (FEC) to fsverity similar to what dm-verity has, but this would be
> complex, and it's not something that anyone has gotten around to yet.
> 
> - Eric
> 

