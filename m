Return-Path: <linux-fsdevel+bounces-21462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A719043F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 20:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4661F286F31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5CC7404F;
	Tue, 11 Jun 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCEc5Ow5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B7101E2;
	Tue, 11 Jun 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131564; cv=none; b=YqNpl5zBbB/7e/jViSlwwijYiNqMvMMKvAJbWij7A3Ow/8bkrslaJcOECe7dCgrhzebaDXNc5A6WBAf6UtEv0sXO0pyvsBYnXjAUnFPULlTX/dNTOcBJQNpjczZzr4U3RJoFdmu/hQ1QDFSLIdDGqfs0gZ5JvPwMQbAXj/abkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131564; c=relaxed/simple;
	bh=fQvBpIT6KQAxfjKGEbjvREPakNLI7ETD7RyksVDEKf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4m8j0OCqHlgQjOy7C04el7HOJQNgpyXgZklNy5vdQ2D/+AEP2nImmDePEd0KgGMm3MReVajPesxHHVwFBGu7IWCCpDL/zXe1TBuX75jHE1tZTpms/g4teZH2+iUZIc/pM/1uZpP2Uva82VJ8gZ8DxzW0VhdPlqrkbf/C5RtyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCEc5Ow5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270C6C2BD10;
	Tue, 11 Jun 2024 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718131564;
	bh=fQvBpIT6KQAxfjKGEbjvREPakNLI7ETD7RyksVDEKf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCEc5Ow5f2FvsdBvOSotl00EucsrMNJCn6sDkeRkkc0F7su4BsuT/U6h+E3LgJAvh
	 anIZ023tdSi2la4eSQNioiTK1uSfI92zRcMVrnfFNgG7KalmiYWwcxUgO6GDPZO3WJ
	 +z+/9BTybZw522QmmYnlApZYy7HS2wgC54GPlBvluTuna2a6LBye5uHDaokBt0y4mA
	 RieQLqFZl2BTARfyyr2Mm0JB7CxoPPWfH63y0h7DkKNEWkCM92HELsioa5+X1VyuDP
	 d01roPcEJGxFqgVGl9wHEmtinFKEtRBbCM3PPnyxzEFr3bxcvYmrD+Go65K3c7zw8G
	 blJCpMQvKL+uA==
Date: Tue, 11 Jun 2024 11:46:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 2/5] fstests: add mmap page boundary tests
Message-ID: <20240611184603.GA52987@frogsfrogsfrogs>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-3-mcgrof@kernel.org>
 <20240611164811.GL52977@frogsfrogsfrogs>
 <ZmiTBZLQ8uOGS5i8@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmiTBZLQ8uOGS5i8@bombadil.infradead.org>

On Tue, Jun 11, 2024 at 11:10:13AM -0700, Luis Chamberlain wrote:
> On Tue, Jun 11, 2024 at 09:48:11AM -0700, Darrick J. Wong wrote:
> > On Mon, Jun 10, 2024 at 08:01:59PM -0700, Luis Chamberlain wrote:
> > > +# As per POSIX NOTES mmap(2) maps multiples of the system page size, but if the
> > > +# data mapped is not multiples of the page size the remaining bytes are zeroed
> > > +# out when mapped and modifications to that region are not written to the file.
> > > +# On Linux when you write data to such partial page after the end of the
> > > +# object, the data stays in the page cache even after the file is closed and
> > > +# unmapped and  even  though  the data  is never written to the file itself,
> > > +# subsequent mappings may see the modified content. If you go *beyond* this
> > 
> > Does this happen (mwrite data beyond eof sticks around) with large
> > folios as well?
> 
> That corner case of checking to see if it stays is not tested by this
> test, but we could / should extend this test later for that. But then
> the question becomes, what is right, given we are in grey area, if we
> don't have any defined standard for it, it seems odd to test for it.
> 
> So the test currently only tests for correctness of what we expect for
> POSIX and what we all have agreed for Linux.
> 
> Hurding everyone to follow suit for the other corner cases is something
> perhaps we should do. Do we have a "strict fail" ? So that perhaps we can
> later add a test case for it and so that onnce and if we get consensus
> on what we do we can enable say a "strict-Linux" mode where we are
> pedantic about a new world order?

I doubt there's an easy way to guarantee more than "initialized to zero,
contents may stay around in memory but will not be written to disk".
You could do asinine things like fault on every access and manually
inject zero bytes, but ... yuck.

That said -- let's say you have a 33k file, and a space mapping for
0-63k (e.g. it was preallocated).  Can the pagecache grab (say) a 64k
folio for the EOF part of the pagecache?  And can you mmap that whole
region?  And see even more grey area mmapping?  Or does mmap always cut
off the mapping at roundup(i_size_read(), PAGE_SIZE) ?

(I feel like I've asked this before, and forgotten the answer. :()

> > > +	rm -rf "${SCRATCH_MNT:?}"/*
> > 
> > rm -f $SCRATCH_MNT/file ?
> 
> Sure.
> 
> > > +	# A couple of mmap() tests:
> > > +	#
> > > +	# We are allowed to mmap() up to the boundary of the page size of a
> > > +	# data object, but there a few rules to follow we must check for:
> > > +	#
> > > +	# a) zero-fill test for the data: POSIX says we should zero fill any
> > > +	#    partial page after the end of the object. Verify zero-fill.
> > > +	# b) do not write this bogus data to disk: on Linux, if we write data
> > > +	#    to a partially filled page, it will stay in the page cache even
> > > +	#    after the file is closed and unmapped even if it never reaches the
> > > +	#    file. Subsequent mappings *may* see the modified content, but it
> > > +	#    also can get other data. Since the data read after the actual
> > 
> > What other data?
> 
> Beats me, got that from the man page bible on mmap. I think its homework
> for us to find out who is spewing that out, which gives a bit more value
> to the idea of that strict-linux thing. How else will we find out?

Oh, ok.  I couldn't tell if *you* had seen "other" data emerging from
the murk, or if that was merely what a spec says.  Please cite the
particular bible you were reading. ;)

> > > +	#    object data can vary we just verify the filesize does not change.
> > > +	if [[ $map_len -gt $new_filelen ]]; then
> > > +		zero_filled_data_len=$((map_len - new_filelen))
> > > +		_scratch_cycle_mount
> > > +		expected_zero_data="00"
> > > +		zero_filled_data=$($XFS_IO_PROG -r $test_file \
> > > +			-c "mmap -r 0 $map_len" \
> > > +			-c "mread -v $new_filelen $zero_filled_data_len" \
> > > +			-c "munmap" | \
> > > +			filter_xfs_io_data_unique)
> > > +		if [[ "$zero_filled_data" != "$expected_zero_data" ]]; then
> > > +			echo "Expected data: $expected_zero_data"
> > > +			echo "  Actual data: $zero_filled_data"
> > > +			_fail "Zero-fill expectations with mmap() not respected"
> > > +		fi
> > > +
> > > +		_scratch_cycle_mount
> > > +		$XFS_IO_PROG $test_file \
> > > +			-c "mmap -w 0 $map_len" \
> > > +			-c "mwrite $new_filelen $zero_filled_data_len" \
> > > +			-c "munmap"
> > > +		sync
> > > +		csum_post="$(_md5_checksum $test_file)"
> > > +		if [[ "$csum_orig" != "$csum_post" ]]; then
> > > +			echo "Expected csum: $csum_orig"
> > > +			echo " Actual  csum: $csum_post"
> > > +			_fail "mmap() write up to page boundary should not change actual file contents"
> > 
> > Do you really want to stop the test immediately?  Or keep going and see
> > what other errors fall out?  (i.e. s/_fail/echo/ here)
> 
> Good point. We could go on, I'll change on the next v2.
> 
> Thanks!

NP.

--D

> 
>   Luis
> 

