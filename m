Return-Path: <linux-fsdevel+bounces-14224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07A87993C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A7E2837BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239DB7E58C;
	Tue, 12 Mar 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4zgQ6no"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F17E562;
	Tue, 12 Mar 2024 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261885; cv=none; b=BVJb48y9vySE+29kdCro2xvdc+rLnJZwY2oH1wCd4bv97mWP44Ol/myHP1rNaDKYGIbrF5bN226b+EmYyFk6AG83zuDHVGaez9oE7dw0kWqun8M7nPUcz8f1qTseLwRtjuuX97oTxvkhKube6ZmNtujnHbI8kJ4HetMtjfdo4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261885; c=relaxed/simple;
	bh=I6muzZAlPFU73ezeQNc4Ie26UaC6Pt4x8gLjyUf/DM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn0mEJuAVv2sgFk5Cv319nWnOxm+wEkEAuTs/eb0L+CgGIPaBOoD3k/Lhv8JJvoBnsVkJK+SBFn5qc01fDvs5gNoKd6k3pKNtJdeCN+ZERmP5ibNNvdeYt9G/EBEu01ElkEqwR3Q0+tD/Z/TVCHn5ERCChJ0+bh8XcVPUozqCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4zgQ6no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFBEC43390;
	Tue, 12 Mar 2024 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710261885;
	bh=I6muzZAlPFU73ezeQNc4Ie26UaC6Pt4x8gLjyUf/DM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4zgQ6noTbtMcjhK+KmyN7jQlPMYH955VeDUWyc7NnI7e0vm1tzTdTbqdPalp3hOS
	 vkeMEKj11LXobwqrvsrqqaPh4aitP0DU31ZxNXglNN591a3nVHN2tzTJzl7XtK0bgV
	 VYJx00wuYr0LFNhn3AVGt6mjj3+0pCpAE9K/+Sl/n/RAtV6x0VaGXo/QRCkXHjHPoC
	 SFo0TdI63LPg41HN1qAO+2YJTp6Bjw53fWOaSfE5NvH/+zIT/h2cvDhWSUBkQMe4p8
	 65BcDtL2KWhgA+VOUiAi/sYJ98iRVP3RBl3rjtJVhhDeA1Rykz0vNNGNDJkTbhY70B
	 Owb3WcQiCQBgA==
Date: Tue, 12 Mar 2024 09:44:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v5 06/24] fsverity: pass tree_blocksize to
 end_enable_verity()
Message-ID: <20240312164444.GG1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-8-aalbersh@redhat.com>
 <20240305005242.GE17145@sol.localdomain>
 <20240306163000.GP1927156@frogsfrogsfrogs>
 <20240307220224.GA1799@sol.localdomain>
 <20240308034650.GK1927156@frogsfrogsfrogs>
 <20240308044017.GC8111@sol.localdomain>
 <20240311223815.GW1927156@frogsfrogsfrogs>
 <9927568e-9f36-4417-9d26-c8a05c220399@redhat.com>
 <08905bcc-677d-4981-926d-7f407b2f6a4a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08905bcc-677d-4981-926d-7f407b2f6a4a@redhat.com>

On Tue, Mar 12, 2024 at 04:33:14PM +0100, David Hildenbrand wrote:
> On 12.03.24 16:13, David Hildenbrand wrote:
> > On 11.03.24 23:38, Darrick J. Wong wrote:
> > > [add willy and linux-mm]
> > > 
> > > On Thu, Mar 07, 2024 at 08:40:17PM -0800, Eric Biggers wrote:
> > > > On Thu, Mar 07, 2024 at 07:46:50PM -0800, Darrick J. Wong wrote:
> > > > > > BTW, is xfs_repair planned to do anything about any such extra blocks?
> > > > > 
> > > > > Sorry to answer your question with a question, but how much checking is
> > > > > $filesystem expected to do for merkle trees?
> > > > > 
> > > > > In theory xfs_repair could learn how to interpret the verity descriptor,
> > > > > walk the merkle tree blocks, and even read the file data to confirm
> > > > > intactness.  If the descriptor specifies the highest block address then
> > > > > we could certainly trim off excess blocks.  But I don't know how much of
> > > > > libfsverity actually lets you do that; I haven't looked into that
> > > > > deeply. :/
> > > > > 
> > > > > For xfs_scrub I guess the job is theoretically simpler, since we only
> > > > > need to stream reads of the verity files through the page cache and let
> > > > > verity tell us if the file data are consistent.
> > > > > 
> > > > > For both tools, if something finds errors in the merkle tree structure
> > > > > itself, do we turn off verity?  Or do we do something nasty like
> > > > > truncate the file?
> > > > 
> > > > As far as I know (I haven't been following btrfs-progs, but I'm familiar with
> > > > e2fsprogs and f2fs-tools), there isn't yet any precedent for fsck actually
> > > > validating the data of verity inodes against their Merkle trees.
> > > > 
> > > > e2fsck does delete the verity metadata of inodes that don't have the verity flag
> > > > enabled.  That handles cleaning up after a crash during FS_IOC_ENABLE_VERITY.
> > > > 
> > > > I suppose that ideally, if an inode's verity metadata is invalid, then fsck
> > > > should delete that inode's verity metadata and remove the verity flag from the
> > > > inode.  Checking for a missing or obviously corrupt fsverity_descriptor would be
> > > > fairly straightforward, but it probably wouldn't catch much compared to actually
> > > > validating the data against the Merkle tree.  And actually validating the data
> > > > against the Merkle tree would be complex and expensive.  Note, none of this
> > > > would work on files that are encrypted.
> > > > 
> > > > Re: libfsverity, I think it would be possible to validate a Merkle tree using
> > > > libfsverity_compute_digest() and the callbacks that it supports.  But that's not
> > > > quite what it was designed for.
> > > > 
> > > > > Is there an ioctl or something that allows userspace to validate an
> > > > > entire file's contents?  Sort of like what BLKVERIFY would have done for
> > > > > block devices, except that we might believe its answers?
> > > > 
> > > > Just reading the whole file and seeing whether you get an error would do it.
> > > > 
> > > > Though if you want to make sure it's really re-reading the on-disk data, it's
> > > > necessary to drop the file's pagecache first.
> > > 
> > > I tried a straight pagecache read and it worked like a charm!
> > > 
> > > But then I thought to myself, do I really want to waste memory bandwidth
> > > copying a bunch of data?  No.  I don't even want to incur system call
> > > overhead from reading a single byte every $pagesize bytes.
> > > 
> > > So I created 2M mmap areas and read a byte every $pagesize bytes.  That
> > > worked too, insofar as SIGBUSes are annoying to handle.  But it's
> > > annoying to take signals like that.
> > > 
> > > Then I started looking at madvise.  MADV_POPULATE_READ looked exactly
> > > like what I wanted -- it prefaults in the pages, and "If populating
> > > fails, a SIGBUS signal is not generated; instead, an error is returned."
> > > 
> > 
> > Yes, these were the expected semantics :)
> > 
> > > But then I tried rigging up a test to see if I could catch an EIO, and
> > > instead I had to SIGKILL the process!  It looks filemap_fault returns
> > > VM_FAULT_RETRY to __xfs_filemap_fault, which propagates up through
> > > __do_fault -> do_read_fault -> do_fault -> handle_pte_fault ->
> > > handle_mm_fault -> faultin_page -> __get_user_pages.  At faultin_pages,
> > > the VM_FAULT_RETRY is translated to -EBUSY.
> > > 
> > > __get_user_pages squashes -EBUSY to 0, so faultin_vma_page_range returns
> > > that to madvise_populate.  Unfortunately, madvise_populate increments
> > > its loop counter by the return value (still 0) so it runs in an
> > > infinite loop.  The only way out is SIGKILL.
> > 
> > That's certainly unexpected. One user I know is QEMU, which primarily
> > uses MADV_POPULATE_WRITE to prefault page tables. Prefaulting in QEMU is
> > primarily used with shmem/hugetlb, where I haven't heard of any such
> > endless loops.
> > 
> > > 
> > > So I don't know what the correct behavior is here, other than the
> > > infinite loop seems pretty suspect.  Is it the correct behavior that
> > > madvise_populate returns EIO if __get_user_pages ever returns zero?
> > > That doesn't quite sound right if it's the case that a zero return could
> > > also happen if memory is tight.
> > 
> > madvise_populate() ends up calling faultin_vma_page_range() in a loop.
> > That one calls __get_user_pages().
> > 
> > __get_user_pages() documents: "0 return value is possible when the fault
> > would need to be retried."
> > 
> > So that's what the caller does. IIRC, there are cases where we really
> > have to retry (at least once) and will make progress, so treating "0" as
> > an error would be wrong.
> > 
> > Staring at other __get_user_pages() users, __get_user_pages_locked()
> > documents: "Please note that this function, unlike __get_user_pages(),
> > will not return 0 for nr_pages > 0, unless FOLL_NOWAIT is used.".
> > 
> > But there is some elaborate retry logic in there, whereby the retry will
> > set FOLL_TRIED->FAULT_FLAG_TRIED, and I think we'd fail on the second
> > retry attempt (there are cases where we retry more often, but that's
> > related to something else I believe).
> > 
> > So maybe we need a similar retry logic in faultin_vma_page_range()? Or
> > make it use __get_user_pages_locked(), but I recall when I introduced
> > MADV_POPULATE_READ, there was a catch to it.
> 
> I'm trying to figure out who will be setting the VM_FAULT_SIGBUS in the
> mmap()+access case you describe above.
> 
> Staring at arch/x86/mm/fault.c:do_user_addr_fault(), I don't immediately see
> how we would transition from a VM_FAULT_RETRY loop to VM_FAULT_SIGBUS.
> Because VM_FAULT_SIGBUS would be required for that function to call
> do_sigbus().

The code I was looking at yesterday in filemap_fault was:

page_not_uptodate:
	/*
	 * Umm, take care of errors if the page isn't up-to-date.
	 * Try to re-read it _once_. We do this synchronously,
	 * because there really aren't any performance issues here
	 * and we need to check for errors.
	 */
	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
	if (fpin)
		goto out_retry;
	folio_put(folio);

	if (!error || error == AOP_TRUNCATED_PAGE)
		goto retry_find;
	filemap_invalidate_unlock_shared(mapping);

	return VM_FAULT_SIGBUS;

Wherein I /think/ fpin is non-null in this case, so if
filemap_read_folio returns an error, we'll do this instead:

out_retry:
	/*
	 * We dropped the mmap_lock, we need to return to the fault handler to
	 * re-find the vma and come back and find our hopefully still populated
	 * page.
	 */
	if (!IS_ERR(folio))
		folio_put(folio);
	if (mapping_locked)
		filemap_invalidate_unlock_shared(mapping);
	if (fpin)
		fput(fpin);
	return ret | VM_FAULT_RETRY;

and since ret was 0 before the goto, the only return code is
VM_FAULT_RETRY.  I had speculated that perhaps we could instead do:

	if (fpin) {
		if (error)
			ret |= VM_FAULT_SIGBUS;
		goto out_retry;
	}

But I think the hard part here is that there doesn't seem to be any
distinction between transient read errors (e.g. disk cable fell out) vs.
semi-permanent errors (e.g. verity says the hash doesn't match).
AFAICT, either the read(ahead) sets uptodate and callers read the page,
or it doesn't set it and callers treat that as an error-retry
opportunity.

For the transient error case VM_FAULT_RETRY makes perfect sense; for the
second case I imagine we'd want something closer to _SIGBUS.

</handwave>

--D

> -- 
> Cheers,
> 
> David / dhildenb
> 
> 

