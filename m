Return-Path: <linux-fsdevel+bounces-16906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F6D8A49D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 10:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9F0285BE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965536120;
	Mon, 15 Apr 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FzbQ1t0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1024B34;
	Mon, 15 Apr 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168660; cv=none; b=eANFM2tbDVmra+jT4ucBD2MoTpq8QZhqiVTj7zSOk4wJleM+RS+djKdZzROiGg/swxFJJtV9JgalqsvlCRr2m01UyDaMWhT1/yAgiw94+BHsPhjUKX1N1W5CIpQq8bZpqpwTjXpBvDUsoLf51e/gX7HfbEr2v/iIn8JLTOHUlSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168660; c=relaxed/simple;
	bh=RPKAQr7fYYMhG/1sbT9nzNIa6ykeTCEs8OSl8PHFWxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaUZZclfKQjVFV2jemToEJC12971aMIPc+sEXb5CLvCgIlyU+Lqa/Oa2BIh0qWAkXF4d3mPM81uFoPsRUP0NXcXVOdxcrogVMAMISkXMKsDl40iaKGlnUyzJD3DN/9RaG5w5Qd4BlfGiwe6ec/8P1T8pbIXCDeDwrilLX7ssWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FzbQ1t0p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SzKBuO4UZJjLysHYrSmx3tPUhFrnbhHWlG8m5l17y54=; b=FzbQ1t0piLn462pvSE6YK41Yqb
	R/4jWV7cAgcxk5YLNZwi4idsWhFiJyNNcgD8MSr4E+0ejq7NrxEWpCPVjvP0po+4gvKrd6Ufwdsf6
	o3Rmv4nB7oqsyrARwq2dlaDMdbSXGKXDL6nbK9iS8DOLIZ1MGF1TJDC0UMlWo9r2AKM2YimlUIKqw
	I2mwjbz/kXbsBk6yVIh8EcyZ92AVby3LXsu23+30B8Q2VA5hiHPKP2v/TYnRon7xjO9VfWDJJ7qG/
	4V+FXk9csiSNQmRnxyjxu7CfmlEHCYn4B3WX4Y6uRtS29RETUpg4LYQpiF7jVVfrI49BhG6EWe0AJ
	+YRM5lBw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwHQX-00000007Tlh-2R6F;
	Mon, 15 Apr 2024 08:10:57 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	hare@suse.de,
	john.g.garry@oracle.com,
	linux-xfs@vger.kernel.org,
	patches@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC] fstests: add mmap page boundary tests
Date: Mon, 15 Apr 2024 01:10:54 -0700
Message-ID: <20240415081054.1782715-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

mmap() POSIX compliance says we should zero fill data beyond a file
size up to page boundary, and issue a SIGBUS if we go beyond. While fsx
helps us test zero-fill sometimes, fsstress also let's us sometimes test
for SIGBUS however that is based on a random value and its not likley we
always test it. Dedicate a specic test for this to make testing for
this specific situation and to easily expand on other corner cases.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Does enough to get us to use to test this, however I'm aware of a bit
more polishing up to do:

  * maybe moving mread to common as generic/574 did it first
  * sharing round_up_to_page_boundary() as well

generic/574 is special, it was just testing for correctness of
integrity if we muck with mmap() however if you don't have verity
stuff available obviously you won't end up testing it.

This generalizes mmap() zero-fill and SIGBUS corner case tests.

I've tested so far only 4k and it works well there. For 16k bs on LBS
just the SIGBUS issue exists, I'll test smaller block sizes later like
512, 1k, 2k as well. We'll fix triggering the SIBGUS when LBS is used,
we'll address that in the next iteration.

Is this a worthy test as a generic test?

 common/filter         |   6 ++
 tests/generic/740     | 231 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/740.out |   2 +
 3 files changed, 239 insertions(+)
 create mode 100755 tests/generic/740
 create mode 100644 tests/generic/740.out

diff --git a/common/filter b/common/filter
index 36d51bd957dd..d7add06f3be7 100644
--- a/common/filter
+++ b/common/filter
@@ -194,6 +194,12 @@ _filter_xfs_io_unique()
     common_line_filter | _filter_xfs_io
 }
 
+_filter_xfs_io_data_unique()
+{
+    _filter_xfs_io_offset | sed -e 's| |\n|g' | egrep -v "\.|XX|\*" | \
+	sort | uniq | tr -d '\n'
+}
+
 _filter_xfs_io_units_modified()
 {
 	UNIT=$1
diff --git a/tests/generic/740 b/tests/generic/740
new file mode 100755
index 000000000000..cbb823014600
--- /dev/null
+++ b/tests/generic/740
@@ -0,0 +1,231 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Luis Chamberlain. All Rights Reserved.
+#
+# FS QA Test 740
+#
+# As per POSIX NOTES mmap(2) maps multiples of the system page size, but if the
+# data mapped is not multiples of the page size the remaining bytes are zeroed
+# out when mapped and modifications to that region are not written to the file.
+# On Linux when you write data to such partial page after the end of the
+# object, the data stays in the page cache even after the file is closed and
+# unmapped and  even  though  the data  is never written to the file itself,
+# subsequent mappings may see the modified content. If you go *beyond* this
+# page, you should get a SIGBUS. This test verifies we zero-fill to page
+# boundary and ensures we get a SIGBUS if we write to data beyond the system
+# page size even if the block size is greater than the system page size.
+. ./common/preamble
+. ./common/rc
+_begin_fstest auto quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch_nocheck
+_require_test
+
+setup_zeroed_file()
+{
+	local file_len=$1
+	local sparse=$2
+
+	if $sparse; then
+		$XFS_IO_PROG -f -c "truncate $file_len" $test_file
+	else
+		$XFS_IO_PROG -f -c "falloc 0 $file_len" $test_file
+	fi
+}
+
+round_up_to_page_boundary()
+{
+	local n=$1
+	local page_size=$(_get_page_size)
+
+	echo $(( (n + page_size - 1) & ~(page_size - 1) ))
+}
+
+mread()
+{
+	local file=$1
+	local map_len=$2
+	local offset=$3
+	local length=$4
+
+	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
+	# causing the shell to print "Bus error" to stderr.  To allow this
+	# message to be redirected, execute xfs_io in a new shell instance.
+	# However, for this to work reliably, we also need to prevent the new
+	# shell instance from optimizing out the fork and directly exec'ing
+	# xfs_io.  The easiest way to do that is to append 'true' to the
+	# commands, so that xfs_io is no longer the last command the shell sees.
+	bash -c "trap '' SIGBUS; $XFS_IO_PROG -r $file \
+		-c 'mmap -r 0 $map_len' \
+		-c 'mread $offset $length'; true"
+}
+
+do_mmap_tests()
+{
+	local block_size=$1
+	local file_len=$2
+	local offset=$3
+	local len=$4
+	local use_sparse_file=${5:-false}
+	local new_filelen=0
+	local map_len=0
+	local csum=0
+	local fs_block_size=$(_get_block_size $SCRATCH_MNT)
+
+	echo -en "\n\n==> Testing blocksize $block_size " >> $seqres.full
+	echo -en "file_len: $file_len offset: $offset " >> $seqres.full
+	echo -e "len: $len sparse: $use_sparse_file" >> $seqres.full
+
+	if ((fs_block_size != block_size)); then
+		echo "Block size created ($block_size) doesn't match _get_block_size on mount ($fs_block_size)"
+		_fail
+	fi
+
+	rm -rf "${SCRATCH_MNT:?}"/*
+
+	# This let's us also test against sparse files
+	setup_zeroed_file $file_len $use_sparse_file
+
+	# This will overwrite the old data, the file size is the
+	# delta between offset and len now.
+	$XFS_IO_PROG -f -c "pwrite -S 0xaa -b 512 $offset $len" \
+		$test_file >> $seqres.full
+
+	sync
+	new_filelen=$(_get_filesize $test_file)
+	map_len=$(round_up_to_page_boundary $new_filelen)
+	csum_orig="$(_md5_checksum $test_file)"
+
+	# A couple of mmap() tests:
+	#
+	# We are allowed to mmap() up to the boundary of the page size of a
+	# data object, but there a few rules to follow we must check for:
+	#
+	# a) zero-fill test for the data: POSIX says we should zero fill any
+	#    partial page after the end of the object. Verify zero-fill.
+	# b) do not write this bogus data to disk: on Linux, if we write data
+	#    to a partially filled page, it will stay in the page cache even
+	#    after the file is closed and unmapped even if it never reaches the
+	#    file. Subsequent mappings *may* see the modified content, but it
+	#    also can get other data. Since the data read after the actual
+	#    object data can vary we just verify the filesize does not change.
+	#    This is not true for tmpfs.
+	if [[ $map_len -gt $new_filelen ]]; then
+		zero_filled_data_len=$((map_len - new_filelen))
+		_scratch_cycle_mount
+		expected_zero_data="00"
+		zero_filled_data=$($XFS_IO_PROG -r $test_file \
+			-c "mmap -r 0 $map_len" \
+			-c "mread -v $new_filelen $zero_filled_data_len" \
+			-c "munmap" | \
+			_filter_xfs_io_data_unique)
+		if [[ "$zero_filled_data" != "$expected_zero_data" ]]; then
+			echo "Expected data: $expected_zero_data"
+			echo "  Actual data: $zero_filled_data"
+			echo "Zero-fill broken see mmap() requirements"
+			_fail
+		fi
+
+		if [[ "$FSTYP" != "tmpfs" ]]; then
+			_scratch_cycle_mount
+			$XFS_IO_PROG $test_file \
+				-c "mmap -w 0 $map_len" \
+				-c "mwrite $new_filelen $zero_filled_data_len" \
+				-c "munmap"
+			sync
+			csum_post="$(_md5_checksum $test_file)"
+			if [[ "$csum_orig" != "$csum_post" ]]; then
+				echo "Expected csum: $csum_orig"
+				echo " Actual  csum: $csum_post"
+				_fail
+			fi
+
+			local filelen_test=$(_get_filesize $test_file)
+			if [[ "$filelen_test" != "$new_filelen" ]]; then
+				echo "Expected file length: $new_filelen"
+				echo " Actual  file length: $filelen_test"
+				_fail
+			fi
+		fi
+	fi
+
+	# Now lets ensure we get SIGBUS when we go beyond the page boundary
+	if [[ "$FSTYP" != "tmpfs" ]]; then
+		_scratch_cycle_mount
+		new_filelen=$(_get_filesize $test_file)
+		map_len=$(round_up_to_page_boundary $new_filelen)
+		csum_orig="$(_md5_checksum $test_file)"
+		mread $test_file $map_len 0 $map_len >> $seqres.full  2>$tmp.err
+		if grep -q 'Bus error' $tmp.err; then
+			echo "Not expecting SIGBUS when reading up to page boundary"
+			cat $tmp.err
+			_fail
+		fi
+
+		# This should just work
+		mread $test_file $map_len 0 $map_len >> $seqres.full  2>$tmp.err
+		if [[ $? -ne 0 ]]; then
+			_fail
+		fi
+
+		# If we mmap() on the boundary but try to read beyond it just
+		# fails, we don't get a SIGBUS
+		$XFS_IO_PROG -r $test_file \
+			-c "mmap -r 0 $map_len" \
+			-c "mread 0 $((map_len + 10))" >> $seqres.full  2>$tmp.err
+		local mread_err=$?
+		if [[ $mread_err -eq 0 ]]; then
+			echo "mmap() to page boundary works as expected but reading beyond should fail"
+			echo "err: $?"
+			_fail
+		fi
+
+		# Now let's go beyond the allowed mmap() page boundary
+		mread $test_file $((map_len + 10)) 0 $((map_len + 10)) >> $seqres.full  2>$tmp.err
+		if ! grep -q 'Bus error' $tmp.err; then
+			echo "Expected SIGBUS when mmap() reading beyond page boundary"
+			_fail
+		fi
+		local filelen_test=$(_get_filesize $test_file)
+		if [[ "$filelen_test" != "$new_filelen" ]]; then
+			echo "Expected file length: $new_filelen"
+			echo " Actual  file length: $filelen_test"
+			_fail
+		fi
+	fi
+}
+
+test_block_size()
+{
+	local block_size=$1
+
+	do_mmap_tests $block_size 512 3 5
+	do_mmap_tests $block_size 16k 0 $((16384+3))
+	do_mmap_tests $block_size 16k $((16384-10)) $((16384+20))
+	do_mmap_tests $block_size 64k 0 $((65536+3))
+	do_mmap_tests $block_size 4k 4090 30 true
+}
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+test_file=$SCRATCH_MNT/file
+block_size=$(_get_block_size "$SCRATCH_MNT")
+test_block_size $block_size
+_scratch_unmount
+_check_scratch_fs
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/740.out b/tests/generic/740.out
new file mode 100644
index 000000000000..3f841e600ed3
--- /dev/null
+++ b/tests/generic/740.out
@@ -0,0 +1,2 @@
+QA output created by 740
+Silence is golden
-- 
2.43.0


