Return-Path: <linux-fsdevel+bounces-21373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 320EC902EE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C58B22611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 03:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214A16FF4B;
	Tue, 11 Jun 2024 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f6ZgZOTM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581541A84;
	Tue, 11 Jun 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074930; cv=none; b=Vbov4+x9Z4FPw7Brt5wuc3SpAS5NTbeaa1OJTggBS/GGdBceHyWVk5TnlNQi/PBLN4L5K3ri2x8c3V5Fix+tmlgdLF5gXz+t+xa6tMZGLPWx2d1aAa/h3NVJ97yaxHijsDBhYiVmqrazO/86S3IUl5+Vry7HKI0aJP3ik5UkgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074930; c=relaxed/simple;
	bh=xEdlx0C6+CBVFUixuuPh9rdLz3o9ezV6g+DZ2gwEO/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKywjS1eJikajsRADSGip2jt/hDwI4Orf2qm2w/uLAPy/0gZIZ4LxL41UO/f3QWlf0uZpBryMIsDl9I8Xhz0AheZnyWSlp49usrIPp0a3SadKCCLFgEesar3aIV8FvDjJTd7KcP5NV8x/fYGHsCvUS9PiFsMTUZBohV7utYbiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f6ZgZOTM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CX8GkoD1lrWdXbOILcd8kqt0xs0WnOHnk3dNstWrvmw=; b=f6ZgZOTMdrlAqlPZArCc35aXQc
	0aob4eDMIoMJkwFReDEAOGuj6u8becvRxbtlACrVJNRLnjaLW8kM4gtbNmH4ipl+dTmUKXdu5cKNv
	O5uMhahpgsMC9NZ5XOYDrOB+nKftYJKZGKziK/q9RjP9A9KLWVM/fz2nN8JrEJxwjkZXavn3QC9js
	W9+kXvgP6ELe5TgSlYmME+GX9WbTTeey/kmwkOiwwROLeOIcCebexa14Nz+WIyUe4IS57A9xiTO1M
	Tu8jih2vYCWzTf1TkwiZDX9+KGmpENr+zcIl77MtyiPhvhlcOoq85yYBwz1WViJLPP7mrhR5zdBZn
	W72QhX4A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGrls-00000007DDG-1iC3;
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
	mcgrof@kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 1/5] common: move mread() to generic helper _mread()
Date: Mon, 10 Jun 2024 20:01:58 -0700
Message-ID: <20240611030203.1719072-2-mcgrof@kernel.org>
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

We want a shared way to use mmap in a way that we can test
for the SIGBUS, provide a shared routine which other tests can
leverage.

Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/rc         | 28 ++++++++++++++++++++++++++++
 tests/generic/574 | 36 ++++--------------------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/common/rc b/common/rc
index 163041fea5b9..fa7942809d6c 100644
--- a/common/rc
+++ b/common/rc
@@ -52,6 +52,34 @@ _pwrite_byte() {
 	$XFS_IO_PROG $xfs_io_args -f -c "pwrite -S $pattern $offset $len" "$file"
 }
 
+_round_up_to_page_boundary()
+{
+	local n=$1
+	local page_size=$(_get_page_size)
+
+	echo $(( (n + page_size - 1) & ~(page_size - 1) ))
+}
+
+_mread()
+{
+	local file=$1
+	local offset=$2
+	local length=$3
+	local map_len=$(_round_up_to_page_boundary $(_get_filesize $file))
+
+	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
+	# causing the shell to print "Bus error" to stderr.  To allow this
+	# message to be redirected, execute xfs_io in a new shell instance.
+	# However, for this to work reliably, we also need to prevent the new
+	# shell instance from optimizing out the fork and directly exec'ing
+	# xfs_io.  The easiest way to do that is to append 'true' to the
+	# commands, so that xfs_io is no longer the last command the shell sees.
+	# Don't let it write core files to the filesystem.
+	bash -c "trap '' SIGBUS; ulimit -c 0; $XFS_IO_PROG -r $file \
+		-c 'mmap -r 0 $map_len' \
+		-c 'mread -v $offset $length'; true"
+}
+
 # mmap-write a byte into a range of a file
 _mwrite_byte() {
 	local pattern="$1"
diff --git a/tests/generic/574 b/tests/generic/574
index cb42baaa67aa..d44c23e5abc2 100755
--- a/tests/generic/574
+++ b/tests/generic/574
@@ -52,34 +52,6 @@ setup_zeroed_file()
 	cmp $fsv_orig_file $fsv_file
 }
 
-round_up_to_page_boundary()
-{
-	local n=$1
-	local page_size=$(_get_page_size)
-
-	echo $(( (n + page_size - 1) & ~(page_size - 1) ))
-}
-
-mread()
-{
-	local file=$1
-	local offset=$2
-	local length=$3
-	local map_len=$(round_up_to_page_boundary $(_get_filesize $file))
-
-	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
-	# causing the shell to print "Bus error" to stderr.  To allow this
-	# message to be redirected, execute xfs_io in a new shell instance.
-	# However, for this to work reliably, we also need to prevent the new
-	# shell instance from optimizing out the fork and directly exec'ing
-	# xfs_io.  The easiest way to do that is to append 'true' to the
-	# commands, so that xfs_io is no longer the last command the shell sees.
-	# Don't let it write core files to the filesystem.
-	bash -c "trap '' SIGBUS; ulimit -c 0; $XFS_IO_PROG -r $file \
-		-c 'mmap -r 0 $map_len' \
-		-c 'mread -v $offset $length'; true"
-}
-
 corruption_test()
 {
 	local block_size=$1
@@ -142,7 +114,7 @@ corruption_test()
 	fi
 
 	# Reading the full file via mmap should fail.
-	mread $fsv_file 0 $file_len >/dev/null 2>$tmp.err
+	_mread $fsv_file 0 $file_len >/dev/null 2>$tmp.err
 	if ! grep -q 'Bus error' $tmp.err; then
 		echo "Didn't see SIGBUS when reading file via mmap"
 		cat $tmp.err
@@ -150,7 +122,7 @@ corruption_test()
 
 	# Reading just the corrupted part via mmap should fail.
 	if ! $is_merkle_tree; then
-		mread $fsv_file $zap_offset $zap_len >/dev/null 2>$tmp.err
+		_mread $fsv_file $zap_offset $zap_len >/dev/null 2>$tmp.err
 		if ! grep -q 'Bus error' $tmp.err; then
 			echo "Didn't see SIGBUS when reading corrupted part via mmap"
 			cat $tmp.err
@@ -174,10 +146,10 @@ corrupt_eof_block_test()
 	head -c $zap_len /dev/zero | tr '\0' X \
 		| _fsv_scratch_corrupt_bytes $fsv_file $file_len
 
-	mread $fsv_file $file_len $zap_len >$tmp.out 2>$tmp.err
+	_mread $fsv_file $file_len $zap_len >$tmp.out 2>$tmp.err
 
 	head -c $file_len /dev/zero >$tmp.zeroes
-	mread $tmp.zeroes $file_len $zap_len >$tmp.zeroes_out
+	_mread $tmp.zeroes $file_len $zap_len >$tmp.zeroes_out
 
 	grep -q 'Bus error' $tmp.err || diff $tmp.out $tmp.zeroes_out
 }
-- 
2.43.0


