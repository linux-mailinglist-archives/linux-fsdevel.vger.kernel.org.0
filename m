Return-Path: <linux-fsdevel+bounces-21735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828CD909514
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 02:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750661C21552
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5510D26D;
	Sat, 15 Jun 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0kfkb99+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2671870;
	Sat, 15 Jun 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718411382; cv=none; b=usSHrFJyb3W5i/nni8iFXinDpMKpGNj7q0l7UGrjqwvz32IGWAaSd4yWFSNoJRHWZSdB7GDsPutu9ZYK0yJzLqO1YiAi0mkHhY9vW2SYj2SHflrqe0vOeOet2O81RGpsBfQE0LuF+Grz5G+5B998g07MlfOtGpY0v0FydlaWhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718411382; c=relaxed/simple;
	bh=+3+u5+X0v9RFjGJ0zrmyhWdYV1/3m5YPqccEAwPvPoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKP9XHjsshNPJoCzjlmyEpxpTJeqp4xVk5n41qxVbowmQGeQPpOx6ecifSG9uhz5vFjIUfAMueCx/E2Sd4SzdHijtf1JTvzbhBMIYhBazOQajNzA6RUuEeheOFan+SgcUn5fJjVxm45aSGUyfujyEpcqViWKUjhsyzhuIpm3vpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0kfkb99+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=a0YpzQbc4885wTLRBldgc5txs7sG8X1GDE95bq1YM1o=; b=0kfkb99+FjH5kDAj9MYM1I5d6l
	jxeaINq1pFg29cDb6SWS5Mdj5UAPGdQhfM0n6hA96InSW1APdhTHyO9HKA5OoJpIRk6TXZiFMa5FU
	IKDvjyDnCDwl/MX3R3pCEspPjlx4FrEvw9gvJoqCY47hwjymTZzRIFFONZA2aaoUYwZ47llbJGmhP
	BtGqL8QBWjaPVCbr0LVfJSzBtbWVoeN10ftF3Hv28gm0O6PA+f58FXGiCfg3Rq4F7w7m8RLd72Ubs
	l6SviYbhycAp+fpceBqSuUwYnwQ4zb/46ljGXve83eSSUp+W5WlcBWrbz3GzSrWTud+PYMEpDtwLr
	wRJ8oKyw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIHIV-00000004KkK-3mPB;
	Sat, 15 Jun 2024 00:29:35 +0000
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
Subject: [PATCH v2 2/5] fstests: add mmap page boundary tests
Date: Fri, 14 Jun 2024 17:29:31 -0700
Message-ID: <20240615002935.1033031-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240615002935.1033031-1-mcgrof@kernel.org>
References: <20240615002935.1033031-1-mcgrof@kernel.org>
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

The only filesystem currently known to fail is tmpfs with huge pages on
a 4k base page size system, on 64k base page size it does not fail.
The pending upstream patch "filemap: cap PTE range to be created to
allowed zero fill in folio_map_range()" fixes this issue for tmpfs on
4k base page size with huge pages and it also fixes it for LBS support.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/rc             |   5 +-
 tests/generic/749     | 256 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/749.out |   2 +
 3 files changed, 262 insertions(+), 1 deletion(-)
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
index 000000000000..2dcced4e3c13
--- /dev/null
+++ b/tests/generic/749
@@ -0,0 +1,256 @@
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
+	local failed=0
+
+	echo -en "\n\n==> Testing blocksize $block_size " >> $seqres.full
+	echo -en "file_len: $file_len offset: $offset " >> $seqres.full
+	echo -e "len: $len sparse: $use_sparse_file" >> $seqres.full
+
+	if ((fs_block_size != block_size)); then
+		_fail "Block size created ($block_size) doesn't match _get_file_block_size on mount ($fs_block_size)"
+	fi
+
+	rm -f $SCRATCH_MNT/file
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
+	#    file. As per mmap(2) subsequent mappings *may* see the modified
+	#    content. This means that it also can get other data and we have
+	#    no rules about what this data should be. Since the data read after
+	#    the actual object data can vary this test just verifies that the
+	#    filesize does not change.
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
+			let failed=$failed+1
+			echo "Expected data: $expected_zero_data"
+			echo "  Actual data: $zero_filled_data"
+			echo "Zero-fill expectations with mmap() not respected"
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
+			let failed=$failed+1
+			echo "Expected csum: $csum_orig"
+			echo " Actual  csum: $csum_post"
+			echo "mmap() write up to page boundary should not change actual file contents"
+		fi
+
+		local filelen_test=$(_get_filesize $test_file)
+		if [[ "$filelen_test" != "$new_filelen" ]]; then
+			let failed=$failed+1
+			echo "Expected file length: $new_filelen"
+			echo " Actual  file length: $filelen_test"
+			echo "mmap() write up to page boundary should not change actual file size"
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
+		failed=1
+		cat $tmp.err
+		echo "Not expecting SIGBUS when reading up to page boundary"
+	fi
+
+	# This should just work
+	_mread $test_file 0 $map_len >> $seqres.full  2>$tmp.err
+	if [[ $? -ne 0 ]]; then
+		let failed=$failed+1
+		echo "mmap() read up to page boundary should work"
+	fi
+
+	# This should just work
+	mwrite $map_len 0 $map_len >> $seqres.full  2>$tmp.err
+	if [[ $? -ne 0 ]]; then
+		let failed=$failed+1
+		echo "mmap() write up to page boundary should work"
+	fi
+
+	# If we mmap() on the boundary but try to read beyond it just
+	# fails, we don't get a SIGBUS
+	$XFS_IO_PROG -r $test_file \
+		-c "mmap -r 0 $map_len" \
+		-c "mread 0 $((map_len + 10))" >> $seqres.full  2>$tmp.err
+	local mread_err=$?
+	if [[ $mread_err -eq 0 ]]; then
+		let failed=$failed+1
+		echo "mmap() to page boundary works as expected but reading beyond should fail: $mread_err"
+	fi
+
+	$XFS_IO_PROG -w $test_file \
+		-c "mmap -w 0 $map_len" \
+		-c "mwrite 0 $((map_len + 10))" >> $seqres.full  2>$tmp.err
+	local mwrite_err=$?
+	if [[ $mwrite_err -eq 0 ]]; then
+		let failed=$failed+1
+		echo "mmap() to page boundary works as expected but writing beyond should fail: $mwrite_err"
+	fi
+
+	# Now let's go beyond the allowed mmap() page boundary
+	_mread $test_file 0 $((map_len + 10)) $((map_len + 10)) >> $seqres.full  2>$tmp.err
+	if ! grep -q 'Bus error' $tmp.err; then
+		let failed=$failed+1
+		echo "Expected SIGBUS when mmap() reading beyond page boundary"
+	fi
+
+	mwrite $test_file 0 $((map_len + 10)) $((map_len + 10))  >> $seqres.full  2>$tmp.err
+	if ! grep -q 'Bus error' $tmp.err; then
+		let failed=$failed+1
+		echo "Expected SIGBUS when mmap() writing beyond page boundary"
+	fi
+
+	local filelen_test=$(_get_filesize $test_file)
+	if [[ "$filelen_test" != "$new_filelen" ]]; then
+		let failed=$failed+1
+		echo "Expected file length: $new_filelen"
+		echo " Actual  file length: $filelen_test"
+		echo "reading or writing beyond file size up to mmap() page boundary should not change file size"
+	fi
+
+	if [[ $failed -eq 1 ]]; then
+		_fail "Test had $failed failures..."
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


