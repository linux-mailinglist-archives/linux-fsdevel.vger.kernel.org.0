Return-Path: <linux-fsdevel+bounces-21370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718C902EDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D69285E8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 03:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3716F91F;
	Tue, 11 Jun 2024 03:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OInBicyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557DC3307B;
	Tue, 11 Jun 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074929; cv=none; b=axq34O8tyvxjqory689bsKW4IMtZayKFBoi0VpRQdIBV1Hlbk9+slGI3bvsMSV0QxNCn6ai3PPeJa+PYG3eM2PzulsS8MS9w+4wjs8kwKdXdtS6oNMK9+8AoSWyzvOAoBp3btzgu1RJtR1mrIH6y7CLBse/9OIxKyeu36nQFaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074929; c=relaxed/simple;
	bh=mruonLpbc7gAllv7hpACrVEvJQil1yeCxK8HZ6SkBr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch7UQIb6Ov1sPO84+9mtbFpftfeV0TvIigqvBN6wP+SKJX+kTHI60vsYbwDlDXx/+JQ3MSDTB2MUHFIZ8G3bwt5RutDH8cRd5nkKQI4LiVShdx4YiV4nlZZHmSUeKIrQMpE8d9v828YYIR7sCyKF+rMRiq0YmvfraPaSP9pHeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OInBicyN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=X20aGf13pHClluFWu9rdKRIp4/K80BReNWAfi/7xV0w=; b=OInBicyN3WpoZTYbSGVw9oTxSZ
	36n8WHTUQSHiAfFgkbSwFkR00UxQbl9zLmHLzWoHGolD7ErnDE7t19NmqlO/fey64CvkSXe9LR4Ag
	qva+dDNr+8AzbhTQvhVkUrCQaI1v0iHEq9HN6HGJDYUYax1pWSv4aRfDB/76pmOiQEB7+ic+YGSD1
	DtRUzjAIRzIpUPQYTiR1ZfPHL8aEFIFLF8Y05gf2VkBfNABYEmXnFZ7VzPp1QRxWtXgmRgIcHCeEd
	4unXHAJTDyOO9XXOjA0jgtsoPyWuPbyQiitjnjr3iwGfQjmEUCmoFPi1sGAUOuAM/1rQzP/gz6/F4
	9op2ukeg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGrls-00000007DDI-1vyh;
	Tue, 11 Jun 2024 03:02:04 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: patches@lists.linux.dev,
	fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	vbabka@suse.cz,
	seanjc@google.com,
	willy@infradead.org,
	david@redhat.com,
	hughd@google.com,
	linmiaohe@huawei.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	hare@suse.de,
	john.g.garry@oracle.com,
	mcgrof@kernel.org
Subject: [PATCH 2/5] fstests: add mmap page boundary tests
Date: Mon, 10 Jun 2024 20:01:59 -0700
Message-ID: <20240611030203.1719072-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240611030203.1719072-1-mcgrof@kernel.org>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
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
for SIGBUS however that is based on a random value and its not likely we
always test it. Dedicate a specic test for this to make testing for
this specific situation and to easily expand on other corner cases.

The only filesystem currently known to fail is tmpfs with huge pages,
but the pending upstream patch "filemap: cap PTE range to be created to
allowed zero fill in folio_map_range()" fixes this issue for tmpfs and
also for LBS support.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/rc             |   5 +-
 tests/generic/749     | 238 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/749.out |   2 +
 3 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/749
 create mode 100644 tests/generic/749.out

diff --git a/common/rc b/common/rc
index fa7942809d6c..e812a2f7cc67 100644
--- a/common/rc
+++ b/common/rc
@@ -60,12 +60,15 @@ _round_up_to_page_boundary()
 	echo $(( (n + page_size - 1) & ~(page_size - 1) ))
 }
 
+# You can override the $map_len but its optional, by default we use the
+# max allowed size. If you use a length greater than the default you can
+# expect a SIBGUS and test for it.
 _mread()
 {
 	local file=$1
 	local offset=$2
 	local length=$3
-	local map_len=$(_round_up_to_page_boundary $(_get_filesize $file))
+	local map_len=${4:-$(_round_up_to_page_boundary $(_get_filesize $file)) }
 
 	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
 	# causing the shell to print "Bus error" to stderr.  To allow this
diff --git a/tests/generic/749 b/tests/generic/749
new file mode 100755
index 000000000000..c1d3a2028549
--- /dev/null
+++ b/tests/generic/749
@@ -0,0 +1,238 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Luis Chamberlain. All Rights Reserved.
+#
+# FS QA Test 749
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
+_begin_fstest auto quick prealloc
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch_nocheck
+_require_test
+_require_xfs_io_command "truncate"
+_require_xfs_io_command "falloc"
+
+# _fixed_by_git_commit kernel <pending-upstream> \
+#        "filemap: cap PTE range to be created to allowed zero fill in folio_map_range()"
+
+filter_xfs_io_data_unique()
+{
+    _filter_xfs_io_offset | sed -e 's| |\n|g' | grep -E -v "\.|XX|\*" | \
+	sort -u | tr -d '\n'
+}
+
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
+mwrite()
+{
+       local file=$1
+       local offset=$2
+       local length=$3
+       local map_len=${4:-$(_round_up_to_page_boundary $(_get_filesize $file)) }
+
+       # Some callers expect xfs_io to crash with SIGBUS due to the mread,
+       # causing the shell to print "Bus error" to stderr.  To allow this
+       # message to be redirected, execute xfs_io in a new shell instance.
+       # However, for this to work reliably, we also need to prevent the new
+       # shell instance from optimizing out the fork and directly exec'ing
+       # xfs_io.  The easiest way to do that is to append 'true' to the
+       # commands, so that xfs_io is no longer the last command the shell sees.
+       bash -c "trap '' SIGBUS; ulimit -c 0; \
+		$XFS_IO_PROG $file \
+               -c 'mmap -w 0 $map_len' \
+               -c 'mwrite $offset $length'; \
+	       true"
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
+	local fs_block_size=$(_get_file_block_size $SCRATCH_MNT)
+
+	echo -en "\n\n==> Testing blocksize $block_size " >> $seqres.full
+	echo -en "file_len: $file_len offset: $offset " >> $seqres.full
+	echo -e "len: $len sparse: $use_sparse_file" >> $seqres.full
+
+	if ((fs_block_size != block_size)); then
+		_fail "Block size created ($block_size) doesn't match _get_file_block_size on mount ($fs_block_size)"
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
+	map_len=$(_round_up_to_page_boundary $new_filelen)
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
+	if [[ $map_len -gt $new_filelen ]]; then
+		zero_filled_data_len=$((map_len - new_filelen))
+		_scratch_cycle_mount
+		expected_zero_data="00"
+		zero_filled_data=$($XFS_IO_PROG -r $test_file \
+			-c "mmap -r 0 $map_len" \
+			-c "mread -v $new_filelen $zero_filled_data_len" \
+			-c "munmap" | \
+			filter_xfs_io_data_unique)
+		if [[ "$zero_filled_data" != "$expected_zero_data" ]]; then
+			echo "Expected data: $expected_zero_data"
+			echo "  Actual data: $zero_filled_data"
+			_fail "Zero-fill expectations with mmap() not respected"
+		fi
+
+		_scratch_cycle_mount
+		$XFS_IO_PROG $test_file \
+			-c "mmap -w 0 $map_len" \
+			-c "mwrite $new_filelen $zero_filled_data_len" \
+			-c "munmap"
+		sync
+		csum_post="$(_md5_checksum $test_file)"
+		if [[ "$csum_orig" != "$csum_post" ]]; then
+			echo "Expected csum: $csum_orig"
+			echo " Actual  csum: $csum_post"
+			_fail "mmap() write up to page boundary should not change actual file contents"
+		fi
+
+		local filelen_test=$(_get_filesize $test_file)
+		if [[ "$filelen_test" != "$new_filelen" ]]; then
+			echo "Expected file length: $new_filelen"
+			echo " Actual  file length: $filelen_test"
+			_fail "mmap() write up to page boundary should not change actual file size"
+		fi
+	fi
+
+	# Now lets ensure we get SIGBUS when we go beyond the page boundary
+	_scratch_cycle_mount
+	new_filelen=$(_get_filesize $test_file)
+	map_len=$(_round_up_to_page_boundary $new_filelen)
+	csum_orig="$(_md5_checksum $test_file)"
+	_mread $test_file 0 $map_len >> $seqres.full  2>$tmp.err
+	if grep -q 'Bus error' $tmp.err; then
+		cat $tmp.err
+		_fail "Not expecting SIGBUS when reading up to page boundary"
+	fi
+
+	# This should just work
+	_mread $test_file 0 $map_len >> $seqres.full  2>$tmp.err
+	if [[ $? -ne 0 ]]; then
+		_fail "mmap() read up to page boundary should work"
+	fi
+
+	# This should just work
+	mwrite $map_len 0 $map_len >> $seqres.full  2>$tmp.err
+	if [[ $? -ne 0 ]]; then
+		_fail "mmap() write up to page boundary should work"
+	fi
+
+	# If we mmap() on the boundary but try to read beyond it just
+	# fails, we don't get a SIGBUS
+	$XFS_IO_PROG -r $test_file \
+		-c "mmap -r 0 $map_len" \
+		-c "mread 0 $((map_len + 10))" >> $seqres.full  2>$tmp.err
+	local mread_err=$?
+	if [[ $mread_err -eq 0 ]]; then
+		_fail "mmap() to page boundary works as expected but reading beyond should fail: $mread_err"
+	fi
+
+	$XFS_IO_PROG -w $test_file \
+		-c "mmap -w 0 $map_len" \
+		-c "mwrite 0 $((map_len + 10))" >> $seqres.full  2>$tmp.err
+	local mwrite_err=$?
+	if [[ $mwrite_err -eq 0 ]]; then
+		_fail "mmap() to page boundary works as expected but writing beyond should fail: $mwrite_err"
+	fi
+
+	# Now let's go beyond the allowed mmap() page boundary
+	_mread $test_file 0 $((map_len + 10)) $((map_len + 10)) >> $seqres.full  2>$tmp.err
+	if ! grep -q 'Bus error' $tmp.err; then
+		_fail "Expected SIGBUS when mmap() reading beyond page boundary"
+	fi
+
+	mwrite $test_file 0 $((map_len + 10)) $((map_len + 10))  >> $seqres.full  2>$tmp.err
+	if ! grep -q 'Bus error' $tmp.err; then
+		_fail "Expected SIGBUS when mmap() writing beyond page boundary"
+	fi
+
+	local filelen_test=$(_get_filesize $test_file)
+	if [[ "$filelen_test" != "$new_filelen" ]]; then
+		echo "Expected file length: $new_filelen"
+		echo " Actual  file length: $filelen_test"
+		_fail "reading or writing beyond file size up to mmap() page boundary should not change file size"
+	fi
+}
+
+test_block_size()
+{
+	local block_size=$1
+
+	do_mmap_tests $block_size 512 3 5
+	do_mmap_tests $block_size 11k 0 $((4096 * 3 + 3))
+	do_mmap_tests $block_size 16k 0 $((16384+3))
+	do_mmap_tests $block_size 16k $((16384-10)) $((16384+20))
+	do_mmap_tests $block_size 64k 0 $((65536+3))
+	do_mmap_tests $block_size 4k 4090 30 true
+}
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+test_file=$SCRATCH_MNT/file
+block_size=$(_get_file_block_size "$SCRATCH_MNT")
+test_block_size $block_size
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/749.out b/tests/generic/749.out
new file mode 100644
index 000000000000..24658deddb99
--- /dev/null
+++ b/tests/generic/749.out
@@ -0,0 +1,2 @@
+QA output created by 749
+Silence is golden
-- 
2.43.0


