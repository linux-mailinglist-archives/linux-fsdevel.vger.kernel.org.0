Return-Path: <linux-fsdevel+bounces-21459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B55904331
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 20:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256F428B566
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960225F47D;
	Tue, 11 Jun 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IV9DMC+d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021538FA1;
	Tue, 11 Jun 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129417; cv=none; b=JI9RR6xK2RFR6/cANK3g55fzY45NjxJkgAtQ27opJckosghCy9VbWApGQjvQ5CuJrSu2PpgUY/4ChBsSsVyMP54odBkDzeuO9zb3sW0RUqK+nsWp8Us9lXm9qoqumrhH8KxKoFu9cigtj8KktUxP2PM8F89jP15edLbbQC36IHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129417; c=relaxed/simple;
	bh=QNopZ6hfyaYylm8fIelAG/aufVDbS1qrfhks5K/FTfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+EbfpVmces7OiyweyTfZp6dDWl3SBTUx9rpg+HLSGAZ9KxX4NMFb4hhY3zWVighDY79HyFarBQW6+DRoOaWE1EuCG8IBqNVhRgH/dLxahsSU8w/J20UZAgnzRquJJrKQ7wbC3lLH68UJEr1g50dT1He/RRa/+KYeH9ABl4xc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IV9DMC+d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+8C4K0O1VTsIQOpcPvEVKsLduwUIDh16culMImH4PiU=; b=IV9DMC+d4/XGWyQOMmgwz5lThB
	k1bwJPc+XqT4q8ySl+fZcn+YjxvudTtEObDHCBK4qVjHbeCNxVOMDdg80DTYncSwKYjvdC68zQL0r
	a8/S9sdw22sXmZARPejwc9N4BGj8W0bYrRcexqbbZ9YrSsFZIuoHBjw+yb5EFOxG7Zlpv/xBluUk8
	nPGFDNYFBsVVCM/rumJgnKCQJEO2XAMZRe1i1B0d1omSBOIxgENDPzBncsB/7lNKeQPkckT29D1fd
	chyJWQMtMdbYVzF/ULMKPxPo96e4vwXwOaNO26fL7uhoZ7LHpu6M8oAStZ2mdT4/kzuM7Es86AeR1
	CnRLlHRA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5wj-00000009nRZ-3nNX;
	Tue, 11 Jun 2024 18:10:13 +0000
Date: Tue, 11 Jun 2024 11:10:13 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 2/5] fstests: add mmap page boundary tests
Message-ID: <ZmiTBZLQ8uOGS5i8@bombadil.infradead.org>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-3-mcgrof@kernel.org>
 <20240611164811.GL52977@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611164811.GL52977@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jun 11, 2024 at 09:48:11AM -0700, Darrick J. Wong wrote:
> On Mon, Jun 10, 2024 at 08:01:59PM -0700, Luis Chamberlain wrote:
> > +# As per POSIX NOTES mmap(2) maps multiples of the system page size, but if the
> > +# data mapped is not multiples of the page size the remaining bytes are zeroed
> > +# out when mapped and modifications to that region are not written to the file.
> > +# On Linux when you write data to such partial page after the end of the
> > +# object, the data stays in the page cache even after the file is closed and
> > +# unmapped and  even  though  the data  is never written to the file itself,
> > +# subsequent mappings may see the modified content. If you go *beyond* this
> 
> Does this happen (mwrite data beyond eof sticks around) with large
> folios as well?

That corner case of checking to see if it stays is not tested by this
test, but we could / should extend this test later for that. But then
the question becomes, what is right, given we are in grey area, if we
don't have any defined standard for it, it seems odd to test for it.

So the test currently only tests for correctness of what we expect for
POSIX and what we all have agreed for Linux.

Hurding everyone to follow suit for the other corner cases is something
perhaps we should do. Do we have a "strict fail" ? So that perhaps we can
later add a test case for it and so that onnce and if we get consensus
on what we do we can enable say a "strict-Linux" mode where we are
pedantic about a new world order?

> > +	rm -rf "${SCRATCH_MNT:?}"/*
> 
> rm -f $SCRATCH_MNT/file ?

Sure.

> > +	# A couple of mmap() tests:
> > +	#
> > +	# We are allowed to mmap() up to the boundary of the page size of a
> > +	# data object, but there a few rules to follow we must check for:
> > +	#
> > +	# a) zero-fill test for the data: POSIX says we should zero fill any
> > +	#    partial page after the end of the object. Verify zero-fill.
> > +	# b) do not write this bogus data to disk: on Linux, if we write data
> > +	#    to a partially filled page, it will stay in the page cache even
> > +	#    after the file is closed and unmapped even if it never reaches the
> > +	#    file. Subsequent mappings *may* see the modified content, but it
> > +	#    also can get other data. Since the data read after the actual
> 
> What other data?

Beats me, got that from the man page bible on mmap. I think its homework
for us to find out who is spewing that out, which gives a bit more value
to the idea of that strict-linux thing. How else will we find out?

> > +	#    object data can vary we just verify the filesize does not change.
> > +	if [[ $map_len -gt $new_filelen ]]; then
> > +		zero_filled_data_len=$((map_len - new_filelen))
> > +		_scratch_cycle_mount
> > +		expected_zero_data="00"
> > +		zero_filled_data=$($XFS_IO_PROG -r $test_file \
> > +			-c "mmap -r 0 $map_len" \
> > +			-c "mread -v $new_filelen $zero_filled_data_len" \
> > +			-c "munmap" | \
> > +			filter_xfs_io_data_unique)
> > +		if [[ "$zero_filled_data" != "$expected_zero_data" ]]; then
> > +			echo "Expected data: $expected_zero_data"
> > +			echo "  Actual data: $zero_filled_data"
> > +			_fail "Zero-fill expectations with mmap() not respected"
> > +		fi
> > +
> > +		_scratch_cycle_mount
> > +		$XFS_IO_PROG $test_file \
> > +			-c "mmap -w 0 $map_len" \
> > +			-c "mwrite $new_filelen $zero_filled_data_len" \
> > +			-c "munmap"
> > +		sync
> > +		csum_post="$(_md5_checksum $test_file)"
> > +		if [[ "$csum_orig" != "$csum_post" ]]; then
> > +			echo "Expected csum: $csum_orig"
> > +			echo " Actual  csum: $csum_post"
> > +			_fail "mmap() write up to page boundary should not change actual file contents"
> 
> Do you really want to stop the test immediately?  Or keep going and see
> what other errors fall out?  (i.e. s/_fail/echo/ here)

Good point. We could go on, I'll change on the next v2.

Thanks!

  Luis

