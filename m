Return-Path: <linux-fsdevel+bounces-16967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302258A5C02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 22:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C071F226DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AD515625E;
	Mon, 15 Apr 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR2kr7/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C6154446
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211553; cv=none; b=mjocI+u44V+YnNVVY9daTXyqjA9qvPu5tmrDBuMTtO436Oi9tdx7fDKlwSLWcdYsPSQDtc+gJjx9nU7mZd9oGGF0TRQVS7ngRRT3KAFvQRBAWInO9kJRIw/ga5PMV1OW6ZV8T9B+eIG44XSL1FIYmQn/Am+tLsqAlYl4gt/zX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211553; c=relaxed/simple;
	bh=aXWaiVtOoKdwBTIUitFW7m8qZPFa01tXJcaSJUWNagQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTP2PL5rN995Edz9oPWHaosMeR2LCz0QbZQ/F+0pkOYvNKu1V0ph9R0qhcJfE0wkp0PlPCXsZ7yr2hwzoSmkSHSmM3e8CjmKgbW05WaAfGbZcmKyWfnYamBW4XQ4lznc9JfedS8hS/LRqWp3fLPqgOPek6KFWCfaSM73SU+nmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR2kr7/1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713211550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5CZ1D81mkUoRoN0akrhw8IpUnU1JIN4ADzHwggVAfw=;
	b=LR2kr7/1YQ/X1t/kdu7c9k9MbVe+slEBALBjrWXpwVeGBWqOdkDdPu7c82d0MOhvOHNc75
	Uvw0OPvnlmp1TymNwwzdsyatB3d6fQwvJjSPVmON5uivNRTHjPTzFTHFWBEtYnEkFga7pB
	dWlOy6VwfVHMgWbu8e24SwxlstaVHwc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-QfOCCCTpNAiDP_oI_mZwTg-1; Mon, 15 Apr 2024 16:05:49 -0400
X-MC-Unique: QfOCCCTpNAiDP_oI_mZwTg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e2bb241663so34388295ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 13:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713211548; x=1713816348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5CZ1D81mkUoRoN0akrhw8IpUnU1JIN4ADzHwggVAfw=;
        b=l9CZ5BHXkTukDF0IUrONe45Du18qRCjrPyPpYA7cFkbUVcZ1wUP8eEmZJUJce6Y+qb
         Du33eU7FtZTsBDiJpz1yhwOj7ghVdgY6kEwf2UczGXgA4yUZvxtWJcqOrVTaj5ukh0iU
         UMYOTQflQBrk+OGn+/to3TCoCqJ5yajuP36wwPmyR9eWegFNSJsATyPoWRaKAO3gyvBm
         6dKEa0Lthk58ajTgdHZPjnYX6HbYxUfMxQslGuJ6/+BptfRkg7eINlQz4xcs9cY2WwQF
         J8CuX3HaD6gUSGrMV8gT92BWvHeS2+hoW72Ht5YM5xB9Uy5ObWsmYBp+Ohl2NxhC/93B
         0wXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVGWPU7qu6aBLFnyrI+UZm/+qmBFEp432YSaeCjnF/7W1YZ0OWlA48c0168oP3CgydlNXIipGRMk8lQMlnM8aVzN2rHZ2F2pbpXHcSDg==
X-Gm-Message-State: AOJu0YzBNVPIU92tcw67Hx6MOVrD8ytdBAB6qRNIn8Waw9BJ2zvEe4yj
	riUG+wA4QVt4EeP9c6TAe5e0Z2WLI+7iTQUzvL29Hko/jXmc64kRg3rQ/acJ/MBXIgaB6dFHn+/
	ZxruiWtd6mtoCzWwpa54nC1Dwu/uw3WbNR9jsS+C6tOL9DX6i8Y8qzZkfbjVrDDE=
X-Received: by 2002:a17:903:41cf:b0:1e2:bc3c:bef6 with SMTP id u15-20020a17090341cf00b001e2bc3cbef6mr11422419ple.37.1713211547674;
        Mon, 15 Apr 2024 13:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjgzwCGe0UZzwJjL5GmXGc2aEUQUE4ZOewXA3Atf5N+7IVVHJAYgjX8NEjHcb/yS7ImFYdDw==
X-Received: by 2002:a17:903:41cf:b0:1e2:bc3c:bef6 with SMTP id u15-20020a17090341cf00b001e2bc3cbef6mr11422378ple.37.1713211546963;
        Mon, 15 Apr 2024 13:05:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001db8a5ea0a3sm8347548plf.94.2024.04.15.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:05:46 -0700 (PDT)
Date: Tue, 16 Apr 2024 04:05:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, p.raghav@samsung.com, da.gomez@samsung.com,
	hare@suse.de, john.g.garry@oracle.com, linux-xfs@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC] fstests: add mmap page boundary tests
Message-ID: <20240415200542.bww7gupflrq3mqoo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

The egrep is deprecated, please use 'grep -E'.

> +	sort | uniq | tr -d '\n'

Isn't "sort | uniq" equal to "sort -u" ?

> +}

Do we need this filter to be a common helper? Will it be used widely? If not,
this can be a local function of below single test case.

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

This _cleanup is same with the default one, don't need this override.

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

_require_xfs_io_command "truncate"

> +	else
> +		$XFS_IO_PROG -f -c "falloc 0 $file_len" $test_file

_require_xfs_io_command "falloc"

And with this, better to add this case into "prealloc" group

> +	fi
> +}
> +
> +round_up_to_page_boundary()
> +{
> +	local n=$1
> +	local page_size=$(_get_page_size)
> +
> +	echo $(( (n + page_size - 1) & ~(page_size - 1) ))
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

Generally the _get_file_block_size is recommended, rather than _get_block_size.

> +
> +	echo -en "\n\n==> Testing blocksize $block_size " >> $seqres.full
> +	echo -en "file_len: $file_len offset: $offset " >> $seqres.full
> +	echo -e "len: $len sparse: $use_sparse_file" >> $seqres.full
> +
> +	if ((fs_block_size != block_size)); then
> +		echo "Block size created ($block_size) doesn't match _get_block_size on mount ($fs_block_size)"
> +		_fail


_fail "Block size created ($block_size) doesn't match _get_block_size on mount ($fs_block_size)" ?

Generally we don't use an empty _fail, same as all "_fail" call in this patch.

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
> +	#    object data can vary we just verify the filesize does not change.
> +	#    This is not true for tmpfs.
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
> +test_block_size $block_size
> +_scratch_unmount
> +_check_scratch_fs

The _scratch_unmount && _check_scratch_fs aren't needed, they'll be done
after this test done.

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


