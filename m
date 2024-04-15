Return-Path: <linux-fsdevel+bounces-16956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B099E8A56DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A74F28457C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B787F492;
	Mon, 15 Apr 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmZ1//Ib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A081D556;
	Mon, 15 Apr 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196706; cv=none; b=XdaDarU7q+daNDiQE3h7cHG89qoD4PFgYr1hhmw2nZF8dz6S3TdkX/D5zT+X/JANCOdX5pdxzTYIpBfTpsW18Jw2ggVCeZ16GwsJVQA+/PK2xRNSg3hMWZu7IUnJHCEG+7vnIoEpA76up+SRdJy+rgn2RByKq664InTKxddaBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196706; c=relaxed/simple;
	bh=sUQBpgSyUBZlM66UyHHOKPx3i5wfe4drA8tsjM+tnzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgjjQutx3mQmfVnH54jHRjD4mRibabNsR2JXKftHsSSALUoOj+Jl+2RdLGyrju5Gib7CpPBvyVWbZ9xj37b0tm+gT1Q9SFAUCINv3KQC22duPBMleKThKxiZ7Retet43LfP/ib0DqHyE1i7H5LbiHwr/euk2i45Wo0WGQzeBofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmZ1//Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C4BC113CC;
	Mon, 15 Apr 2024 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713196706;
	bh=sUQBpgSyUBZlM66UyHHOKPx3i5wfe4drA8tsjM+tnzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmZ1//IbatG5VVmZj0HFpruiwGMNf1VAY9hGDZZemVXe3AUoXDEwV816mHhKVH7BQ
	 ySBuEEFBcAxFWD8PM6ZEO1Le2E2M3jokY/m7Q9urj4i7j/OjacVkrX8CAmHzcVSzzB
	 2p+10cjvC/bsS705ClPX6uGnxQUzcn59gBKiZqYZ9jIHoYiz8xRi6QbGcEXFXCsvwv
	 rFQGCI7F5rXWt5xIekjV8LCgMX2Lm/Y2++81B70FtedObx9QCVyqKpUcaYWzo5Dj+5
	 GlBeFv443nG6ySXo5ZmcA7gMrfaUcUpHcB6V8YIsSfGV2CQzUM2cXxsSVmIdcZniQR
	 IZfJudkf8384w==
Date: Mon, 15 Apr 2024 08:58:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, p.raghav@samsung.com, da.gomez@samsung.com,
	hare@suse.de, john.g.garry@oracle.com, linux-xfs@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC] fstests: add mmap page boundary tests
Message-ID: <20240415155825.GC11948@frogsfrogsfrogs>
References: <20240415081054.1782715-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415081054.1782715-1-mcgrof@kernel.org>

On Mon, Apr 15, 2024 at 01:10:54AM -0700, Luis Chamberlain wrote:
> mmap() POSIX compliance says we should zero fill data beyond a file
> size up to page boundary, and issue a SIGBUS if we go beyond. While fsx
> helps us test zero-fill sometimes, fsstress also let's us sometimes test
> for SIGBUS however that is based on a random value and its not likley we
> always test it. Dedicate a specic test for this to make testing for
> this specific situation and to easily expand on other corner cases.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Does enough to get us to use to test this, however I'm aware of a bit
> more polishing up to do:
> 
>   * maybe moving mread to common as generic/574 did it first
>   * sharing round_up_to_page_boundary() as well
> 
> generic/574 is special, it was just testing for correctness of
> integrity if we muck with mmap() however if you don't have verity
> stuff available obviously you won't end up testing it.
> 
> This generalizes mmap() zero-fill and SIGBUS corner case tests.
> 
> I've tested so far only 4k and it works well there. For 16k bs on LBS
> just the SIGBUS issue exists, I'll test smaller block sizes later like
> 512, 1k, 2k as well. We'll fix triggering the SIBGUS when LBS is used,
> we'll address that in the next iteration.
> 
> Is this a worthy test as a generic test?
> 
>  common/filter         |   6 ++
>  tests/generic/740     | 231 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/740.out |   2 +
>  3 files changed, 239 insertions(+)
>  create mode 100755 tests/generic/740
>  create mode 100644 tests/generic/740.out
> 
> diff --git a/common/filter b/common/filter
> index 36d51bd957dd..d7add06f3be7 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -194,6 +194,12 @@ _filter_xfs_io_unique()
>      common_line_filter | _filter_xfs_io
>  }
>  
> +_filter_xfs_io_data_unique()
> +{
> +    _filter_xfs_io_offset | sed -e 's| |\n|g' | egrep -v "\.|XX|\*" | \
> +	sort | uniq | tr -d '\n'
> +}
> +
>  _filter_xfs_io_units_modified()
>  {
>  	UNIT=$1
> diff --git a/tests/generic/740 b/tests/generic/740
> new file mode 100755
> index 000000000000..cbb823014600
> --- /dev/null
> +++ b/tests/generic/740
> @@ -0,0 +1,231 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Luis Chamberlain. All Rights Reserved.
> +#
> +# FS QA Test 740
> +#
> +# As per POSIX NOTES mmap(2) maps multiples of the system page size, but if the
> +# data mapped is not multiples of the page size the remaining bytes are zeroed
> +# out when mapped and modifications to that region are not written to the file.
> +# On Linux when you write data to such partial page after the end of the
> +# object, the data stays in the page cache even after the file is closed and
> +# unmapped and  even  though  the data  is never written to the file itself,
> +# subsequent mappings may see the modified content. If you go *beyond* this
> +# page, you should get a SIGBUS. This test verifies we zero-fill to page
> +# boundary and ensures we get a SIGBUS if we write to data beyond the system
> +# page size even if the block size is greater than the system page size.
> +. ./common/preamble
> +. ./common/rc
> +_begin_fstest auto quick
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch_nocheck
> +_require_test
> +
> +setup_zeroed_file()
> +{
> +	local file_len=$1
> +	local sparse=$2
> +
> +	if $sparse; then
> +		$XFS_IO_PROG -f -c "truncate $file_len" $test_file
> +	else
> +		$XFS_IO_PROG -f -c "falloc 0 $file_len" $test_file
> +	fi
> +}
> +
> +round_up_to_page_boundary()
> +{
> +	local n=$1
> +	local page_size=$(_get_page_size)
> +
> +	echo $(( (n + page_size - 1) & ~(page_size - 1) ))

Does iomap put a large folio into the pagecache that crosses EOF, or
does it back down to base page size?

> +}
> +
> +mread()
> +{
> +	local file=$1
> +	local map_len=$2
> +	local offset=$3
> +	local length=$4
> +
> +	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
> +	# causing the shell to print "Bus error" to stderr.  To allow this
> +	# message to be redirected, execute xfs_io in a new shell instance.
> +	# However, for this to work reliably, we also need to prevent the new
> +	# shell instance from optimizing out the fork and directly exec'ing
> +	# xfs_io.  The easiest way to do that is to append 'true' to the
> +	# commands, so that xfs_io is no longer the last command the shell sees.
> +	bash -c "trap '' SIGBUS; $XFS_IO_PROG -r $file \
> +		-c 'mmap -r 0 $map_len' \
> +		-c 'mread $offset $length'; true"

Please hoist the mread() function with generic/574 to common; your copy
is out of date with the original.

> +}
> +
> +do_mmap_tests()
> +{
> +	local block_size=$1
> +	local file_len=$2
> +	local offset=$3
> +	local len=$4
> +	local use_sparse_file=${5:-false}
> +	local new_filelen=0
> +	local map_len=0
> +	local csum=0
> +	local fs_block_size=$(_get_block_size $SCRATCH_MNT)
> +
> +	echo -en "\n\n==> Testing blocksize $block_size " >> $seqres.full
> +	echo -en "file_len: $file_len offset: $offset " >> $seqres.full
> +	echo -e "len: $len sparse: $use_sparse_file" >> $seqres.full
> +
> +	if ((fs_block_size != block_size)); then
> +		echo "Block size created ($block_size) doesn't match _get_block_size on mount ($fs_block_size)"
> +		_fail

_fail "Block size created..."

> +	fi
> +
> +	rm -rf "${SCRATCH_MNT:?}"/*
> +
> +	# This let's us also test against sparse files
> +	setup_zeroed_file $file_len $use_sparse_file
> +
> +	# This will overwrite the old data, the file size is the
> +	# delta between offset and len now.
> +	$XFS_IO_PROG -f -c "pwrite -S 0xaa -b 512 $offset $len" \
> +		$test_file >> $seqres.full
> +
> +	sync
> +	new_filelen=$(_get_filesize $test_file)
> +	map_len=$(round_up_to_page_boundary $new_filelen)
> +	csum_orig="$(_md5_checksum $test_file)"
> +
> +	# A couple of mmap() tests:
> +	#
> +	# We are allowed to mmap() up to the boundary of the page size of a
> +	# data object, but there a few rules to follow we must check for:
> +	#
> +	# a) zero-fill test for the data: POSIX says we should zero fill any
> +	#    partial page after the end of the object. Verify zero-fill.
> +	# b) do not write this bogus data to disk: on Linux, if we write data
> +	#    to a partially filled page, it will stay in the page cache even
> +	#    after the file is closed and unmapped even if it never reaches the
> +	#    file. Subsequent mappings *may* see the modified content, but it
> +	#    also can get other data. Since the data read after the actual

What does "other data" mean?

> +	#    object data can vary we just verify the filesize does not change.
> +	#    This is not true for tmpfs.

Er... is this file size change a bug?

> +	if [[ $map_len -gt $new_filelen ]]; then
> +		zero_filled_data_len=$((map_len - new_filelen))
> +		_scratch_cycle_mount
> +		expected_zero_data="00"
> +		zero_filled_data=$($XFS_IO_PROG -r $test_file \
> +			-c "mmap -r 0 $map_len" \
> +			-c "mread -v $new_filelen $zero_filled_data_len" \
> +			-c "munmap" | \
> +			_filter_xfs_io_data_unique)
> +		if [[ "$zero_filled_data" != "$expected_zero_data" ]]; then
> +			echo "Expected data: $expected_zero_data"
> +			echo "  Actual data: $zero_filled_data"
> +			echo "Zero-fill broken see mmap() requirements"
> +			_fail
> +		fi
> +
> +		if [[ "$FSTYP" != "tmpfs" ]]; then
> +			_scratch_cycle_mount
> +			$XFS_IO_PROG $test_file \
> +				-c "mmap -w 0 $map_len" \
> +				-c "mwrite $new_filelen $zero_filled_data_len" \
> +				-c "munmap"
> +			sync
> +			csum_post="$(_md5_checksum $test_file)"
> +			if [[ "$csum_orig" != "$csum_post" ]]; then
> +				echo "Expected csum: $csum_orig"
> +				echo " Actual  csum: $csum_post"
> +				_fail
> +			fi
> +
> +			local filelen_test=$(_get_filesize $test_file)
> +			if [[ "$filelen_test" != "$new_filelen" ]]; then
> +				echo "Expected file length: $new_filelen"
> +				echo " Actual  file length: $filelen_test"
> +				_fail
> +			fi
> +		fi
> +	fi
> +
> +	# Now lets ensure we get SIGBUS when we go beyond the page boundary
> +	if [[ "$FSTYP" != "tmpfs" ]]; then
> +		_scratch_cycle_mount
> +		new_filelen=$(_get_filesize $test_file)
> +		map_len=$(round_up_to_page_boundary $new_filelen)
> +		csum_orig="$(_md5_checksum $test_file)"
> +		mread $test_file $map_len 0 $map_len >> $seqres.full  2>$tmp.err
> +		if grep -q 'Bus error' $tmp.err; then
> +			echo "Not expecting SIGBUS when reading up to page boundary"
> +			cat $tmp.err
> +			_fail
> +		fi
> +
> +		# This should just work
> +		mread $test_file $map_len 0 $map_len >> $seqres.full  2>$tmp.err
> +		if [[ $? -ne 0 ]]; then
> +			_fail
> +		fi
> +
> +		# If we mmap() on the boundary but try to read beyond it just
> +		# fails, we don't get a SIGBUS
> +		$XFS_IO_PROG -r $test_file \
> +			-c "mmap -r 0 $map_len" \
> +			-c "mread 0 $((map_len + 10))" >> $seqres.full  2>$tmp.err
> +		local mread_err=$?
> +		if [[ $mread_err -eq 0 ]]; then
> +			echo "mmap() to page boundary works as expected but reading beyond should fail"
> +			echo "err: $?"
> +			_fail
> +		fi
> +
> +		# Now let's go beyond the allowed mmap() page boundary
> +		mread $test_file $((map_len + 10)) 0 $((map_len + 10)) >> $seqres.full  2>$tmp.err
> +		if ! grep -q 'Bus error' $tmp.err; then
> +			echo "Expected SIGBUS when mmap() reading beyond page boundary"
> +			_fail
> +		fi
> +		local filelen_test=$(_get_filesize $test_file)
> +		if [[ "$filelen_test" != "$new_filelen" ]]; then
> +			echo "Expected file length: $new_filelen"
> +			echo " Actual  file length: $filelen_test"
> +			_fail
> +		fi
> +	fi
> +}
> +
> +test_block_size()
> +{
> +	local block_size=$1
> +
> +	do_mmap_tests $block_size 512 3 5
> +	do_mmap_tests $block_size 16k 0 $((16384+3))
> +	do_mmap_tests $block_size 16k $((16384-10)) $((16384+20))
> +	do_mmap_tests $block_size 64k 0 $((65536+3))
> +	do_mmap_tests $block_size 4k 4090 30 true
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +test_file=$SCRATCH_MNT/file
> +block_size=$(_get_block_size "$SCRATCH_MNT")

_get_file_block_size ?

> +test_block_size $block_size
> +_scratch_unmount
> +_check_scratch_fs

This work is done for you automatically if you simply exit the test
with the scratch fs still mounted.

--D

> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/740.out b/tests/generic/740.out
> new file mode 100644
> index 000000000000..3f841e600ed3
> --- /dev/null
> +++ b/tests/generic/740.out
> @@ -0,0 +1,2 @@
> +QA output created by 740
> +Silence is golden
> -- 
> 2.43.0
> 
> 

