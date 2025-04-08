Return-Path: <linux-fsdevel+bounces-46000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6FA810B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B5E1891495
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB9C23236A;
	Tue,  8 Apr 2025 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpjZfva9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FB22DFA3
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127118; cv=none; b=eJxKdFvaMRPQL6obkaYT5c4BKxmFAJ+vS2VdC9/3zyGpB/+KebUqQkwyI4XChThlDNhNB0Fj2G9hr+Yg5F/JeMxbJEkgPB97BPcRA6WHEyiVEJI9JzgRv5wwfAz6qAllxMD4kDj0Qt+oY3eZxbAL/Nicv+4gtAjMPAoY3KyDyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127118; c=relaxed/simple;
	bh=gWY4qYVuXQYpPu6DnRt5fyW/q+BaOUkelmZHAk9QMdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aynhqTetbquZZp+huV+UAJ9yn9FHahvRhvVkZrfTv8ccKO25CuElM41VnKGPcR/w3qSNlea2P9P1Fi3cPaD+ksKIvvhr3Yzt9ey/V2xTMEE5G2mzSgpooh22/ZVhcKfNA8piyqhgKU+GcSbA7YihQJHKe0u/NAqsQGWeBsZe0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpjZfva9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744127114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IrZXw4h7RzYFuAaDUglqcvWIlh71sQKcQYaM+0JCMGE=;
	b=gpjZfva9x1eunVOAlYMiQGLZGUvgcc+XAnteLE7U+cBG6ZAJwKveQa2SWyx/Qjkz70nLoM
	EUwJpiRM+PN63URWGgJs/7kXUVcfIrNxZBgaQnJdMSwygEdk99TgfrJzEzGz/cdvhvr7ya
	ReZufWMB041N2iVlEh6FTv3PG0EU6GI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111--F8IlXz1M4evSfYBcdK8vQ-1; Tue, 08 Apr 2025 11:45:13 -0400
X-MC-Unique: -F8IlXz1M4evSfYBcdK8vQ-1
X-Mimecast-MFC-AGG-ID: -F8IlXz1M4evSfYBcdK8vQ_1744127112
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so815831966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 08:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127112; x=1744731912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrZXw4h7RzYFuAaDUglqcvWIlh71sQKcQYaM+0JCMGE=;
        b=sEWHERGpx4PuTB8nupthk4Tm8za/spERNuUfIMM8ZlF8ez36UVmlCavq33t2oe1Pr1
         cpY2enLi4fz5V5jMnGoQfrdCmoNKTC1FRSz6D5sKhVd/z88wTqM+3hQCjFaq/oo81S9t
         zqTjZeWJclB+oMmfYju+3uAUHddRCmweIKAHO+xbG9ni25eakuNnAtXSKWfZBf+H90sC
         RvhuQGBigukhVTGg8fHgunniFSkrTh9HEgjpwi+rsjWq/AKPiJ6mx5GKo2TchQYKmkZa
         StjVoobFZBqMYgyMLOrIRQUvVPYjuWD5YwA7fyYoXP9WHWOghEqG4Pr/pXnqGFLODQQt
         SKlg==
X-Forwarded-Encrypted: i=1; AJvYcCXps/xsCf0kzGy65SDys7MvyjnWpj5+ZgGBTwA7nMzgOhH//xJ9DGE0Jaco4wKXnLSqmc6+/6y3pzGJykkw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3zRwEkR8+3lUS+pSKZvweQvBSVz7k5POOoN1cK0z6vkcU1j5
	CKhdDKNTUPaP8pMow6Z98K5vmkylxCwcnP3yaJ5gFfvHNNVC/2J35iekmEgakuFBJzlwtyYyZfE
	oorovWWOiH+e/EHjKOjabsk/oWmS0AzLKZc1bINa31gCXFSqdHCEMV/prQp/8ERc=
X-Gm-Gg: ASbGnctqWheuQmT2KtPL6TQrAFwUBVdbrA32v53+c9HpHC5U50EEJcP0lYyhKyhK+PP
	6zq2ZxHxwLlvKXL+uIzXc2vM3PLM0NzhoD8w7t5FEMteNWD8cIiRQ4C17WS6+WqIZu7XE3j6lHw
	kSA7WfO1ZSZYfHrbI8w65ci+6dxOERsVnauzPmXbYWABrAEV4pia0hDGxS5IgHA4g+7uLqHoWKl
	cnnKT1foEMtqdp5mZs5KeJ+DLqrq8Z3NCNBmCqOyuV0TJcyCBw96DaZoQJUsk+bczMB7zA+kNBx
	zVimFN9v2drmVxlhz8cSpyoYwo42eOPRZBo+Lzh3wXnQVt33SAjVQ/PDxDwtc1qHjrG4r9UQ
X-Received: by 2002:a17:906:d269:b0:ac7:971b:ffd with SMTP id a640c23a62f3a-ac7d185cf4cmr1668860066b.10.1744127111469;
        Tue, 08 Apr 2025 08:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDc6EzCTSkM9P/vQ+vGwy/jjsGfTUHUm6bbSMoWasW+rQPa2zAsD/FTj4XJmfMvcIznGslTQ==
X-Received: by 2002:a17:906:d269:b0:ac7:971b:ffd with SMTP id a640c23a62f3a-ac7d185cf4cmr1668856666b.10.1744127110932;
        Tue, 08 Apr 2025 08:45:10 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-212-63.pool.digikabel.hu. [193.226.212.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01c20f1sm949630666b.177.2025.04.08.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:45:10 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fstests@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH] overlay/08[89]: add tests for data-only redirect with userxattr
Date: Tue,  8 Apr 2025 17:45:09 +0200
Message-ID: <20250408154509.674118-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New kernel feature (target release is v6.16) allows data-only redirect to
be enabled without metacopy and redirect_dir turned on.  This works with or
without verity enabled.

Tests are done with the userxattr option, to verify that it will work in a
user namespace.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 common/overlay        |  29 +++++
 tests/overlay/088     | 296 ++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/088.out |  39 ++++++
 tests/overlay/089     | 272 ++++++++++++++++++++++++++++++++++++++
 tests/overlay/089.out |   5 +
 5 files changed, 641 insertions(+)
 create mode 100755 tests/overlay/088
 create mode 100644 tests/overlay/088.out
 create mode 100755 tests/overlay/089
 create mode 100644 tests/overlay/089.out

diff --git a/common/overlay b/common/overlay
index 01b6622f5573..a6d37a933e6b 100644
--- a/common/overlay
+++ b/common/overlay
@@ -268,6 +268,22 @@ _require_scratch_overlay_lowerdir_add_layers()
 	_scratch_unmount
 }
 
+# Check kernel support for datadir+=<datadir> without "metacopy=on" option
+_require_scratch_overlay_datadir_without_metacopy()
+{
+	local lowerdir="$OVL_BASE_SCRATCH_MNT/$OVL_UPPER"
+	local datadir="$OVL_BASE_SCRATCH_MNT/$OVL_LOWER"
+
+	_scratch_mkfs > /dev/null 2>&1
+	_overlay_scratch_mount_opts \
+		-o"lowerdir+=$lowerdir,datadir+=$datadir" > /dev/null 2>&1 || \
+	        _notrun "overlay datadir+ without metacopy not supported on ${SCRATCH_DEV}"
+
+	_scratch_unmount
+
+}
+
+
 # Helper function to check underlying dirs of overlay filesystem
 _overlay_fsck_dirs()
 {
@@ -467,6 +483,19 @@ _require_unionmount_testsuite()
 		_notrun "newer version of unionmount testsuite required to support OVERLAY_MOUNT_OPTIONS."
 }
 
+# transform overlay xattrs (trusted.overlay -> user.overlay)
+_overlay_trusted_to_user()
+{
+	local dir=$1
+
+	for file in `find $dir`; do
+		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | setfattr --restore=-
+		for xattr in `_getfattr --absolute-names -d -m '^trusted.overlay.' $file  | tail -n +2 | cut -d= -f1`; do
+			setfattr -x $xattr $file;
+		done
+	done
+}
+
 _unionmount_testsuite_run()
 {
 	[ "$FSTYP" = overlay ] || \
diff --git a/tests/overlay/088 b/tests/overlay/088
new file mode 100755
index 000000000000..05944e71b3d5
--- /dev/null
+++ b/tests/overlay/088
@@ -0,0 +1,296 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+# Copyright (C) 2023 CTERA Networks. All Rights Reserved.
+#
+# FS QA Test No. 088
+#
+# Test data-only layers functionality.
+# This is a variant of test overlay/085 with userxattr and without
+# redirect_dir/metacopy options
+#
+. ./common/preamble
+_begin_fstest auto quick metacopy redirect prealloc
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+
+# We use non-default scratch underlying overlay dirs, we need to check
+# them explicity after test.
+_require_scratch_nocheck
+_require_scratch_overlay_features redirect_dir metacopy
+_require_scratch_overlay_lowerdir_add_layers
+_require_scratch_overlay_datadir_without_metacopy
+_require_xfs_io_command "falloc"
+
+# remove all files from previous tests
+_scratch_mkfs
+
+# File size on lower
+dataname="datafile"
+sharedname="shared"
+datacontent="data"
+dataname2="datafile2"
+datacontent2="data2"
+datasize="4096"
+
+# Number of blocks allocated by filesystem on lower. Will be queried later.
+datarblocks=""
+datarblocksize=""
+estimated_datablocks=""
+
+udirname="pureupper"
+ufile="upperfile"
+
+
+# Check redirect xattr
+check_redirect()
+{
+	local target=$1
+	local expect=$2
+
+	value=$(_getfattr --absolute-names --only-values -n \
+		user.overlay.redirect $target)
+
+	[[ "$value" == "$expect" ]] || echo "Redirect xattr incorrect. Expected=\"$expect\", actual=\"$value\""
+}
+
+# Check size
+check_file_size()
+{
+	local target=$1 expected_size=$2 actual_size
+
+	actual_size=$(_get_filesize $target)
+
+	[ "$actual_size" == "$expected_size" ] || echo "Expected file size $expected_size but actual size is $actual_size"
+}
+
+check_file_blocks()
+{
+	local target=$1 expected_blocks=$2 nr_blocks
+
+	nr_blocks=$(stat -c "%b" $target)
+
+	[ "$nr_blocks" == "$expected_blocks" ] || echo "Expected $expected_blocks blocks but actual number of blocks is ${nr_blocks}."
+}
+
+check_file_contents()
+{
+	local target=$1 expected=$2
+	local actual target_f
+
+	target_f=`echo $target | _filter_scratch`
+
+	read actual<$target
+
+	[ "$actual" == "$expected" ] || echo "Expected file $target_f contents to be \"$expected\" but actual contents are \"$actual\""
+}
+
+check_no_file_contents()
+{
+	local target=$1
+	local actual target_f out_f
+
+	target_f=`echo $target | _filter_scratch`
+	out_f=`cat $target 2>&1 | _filter_scratch`
+	msg="cat: $target_f: No such file or directory"
+
+	[ "$out_f" == "$msg" ] && return
+
+	echo "$target_f unexpectedly has content"
+}
+
+
+check_file_size_contents()
+{
+	local target=$1 expected_size=$2 expected_content=$3
+
+	check_file_size $target $expected_size
+	check_file_contents $target $expected_content
+}
+
+mount_overlay()
+{
+	local _lowerdir=$1 _datadir2=$2 _datadir=$3
+
+	_overlay_scratch_mount_opts \
+		-o"lowerdir+=$_lowerdir,datadir+=$_datadir2,datadir+=$_datadir" \
+		-o"upperdir=$upperdir,workdir=$workdir" \
+		-o userxattr
+}
+
+mount_ro_overlay()
+{
+	local _lowerdir=$1 _datadir2=$2 _datadir=$3
+
+	_overlay_scratch_mount_opts \
+		-o"lowerdir+=$_lowerdir,datadir+=$_datadir2,datadir+=$_datadir" \
+		-o userxattr
+}
+
+umount_overlay()
+{
+	$UMOUNT_PROG $SCRATCH_MNT
+}
+
+test_no_access()
+{
+	local _target=$1
+
+	mount_ro_overlay "$lowerdir" "$datadir2" "$datadir"
+
+	stat $SCRATCH_MNT/$_target >> $seqres.full 2>&1 || \
+		echo "No access to lowerdata layer $_target"
+
+	echo "Unmount and Mount rw"
+	umount_overlay
+	mount_overlay "$lowerdir" "$datadir2" "$datadir"
+	stat $SCRATCH_MNT/$_target >> $seqres.full 2>&1 || \
+		echo "No access to lowerdata layer $_target"
+	umount_overlay
+}
+
+test_common()
+{
+	local _lowerdir=$1 _datadir2=$2 _datadir=$3
+	local _target=$4 _size=$5 _blocks=$6 _data="$7"
+	local _redirect=$8
+
+	echo "Mount ro"
+	mount_ro_overlay $_lowerdir $_datadir2 $_datadir
+
+	# Check redirect xattr to lowerdata
+	[ -n "$_redirect" ] && check_redirect $lowerdir/$_target "$_redirect"
+
+	echo "check properties of metadata copied up file $_target"
+	check_file_size_contents $SCRATCH_MNT/$_target $_size "$_data"
+	check_file_blocks $SCRATCH_MNT/$_target $_blocks
+
+	# Do a mount cycle and check size and contents again.
+	echo "Unmount and Mount rw"
+	umount_overlay
+	mount_overlay $_lowerdir $_datadir2 $_datadir
+	echo "check properties of metadata copied up file $_target"
+	check_file_size_contents $SCRATCH_MNT/$_target $_size "$_data"
+	check_file_blocks $SCRATCH_MNT/$_target $_blocks
+
+	# Trigger metadata copy up and check absence of metacopy xattr.
+	chmod 400 $SCRATCH_MNT/$_target
+	umount_overlay
+	check_file_size_contents $upperdir/$_target $_size "$_data"
+}
+
+test_lazy()
+{
+	local _target=$1
+
+	mount_overlay "$lowerdir" "$datadir2" "$datadir"
+
+	# Metadata should be valid
+	check_file_size $SCRATCH_MNT/$_target $datasize
+	check_file_blocks $SCRATCH_MNT/$_target $estimated_datablocks
+
+	# But have no content
+	check_no_file_contents $SCRATCH_MNT/$_target
+
+	umount_overlay
+}
+
+create_basic_files()
+{
+	_scratch_mkfs
+	mkdir -p $datadir/subdir $datadir2/subdir $lowerdir $lowerdir2 $upperdir $workdir $workdir2
+	mkdir -p $upperdir/$udirname
+	echo "$datacontent" > $datadir/$dataname
+	chmod 600 $datadir/$dataname
+	echo "$datacontent2" > $datadir2/$dataname2
+	chmod 600 $datadir2/$dataname2
+
+	echo "$datacontent" > $datadir/$sharedname
+	echo "$datacontent2" > $datadir2/$sharedname
+	chmod 600 $datadir/$sharedname  $datadir2/$sharedname
+
+	# Create files of size datasize.
+	for f in $datadir/$dataname $datadir2/$dataname2 $datadir/$sharedname $datadir2/$sharedname; do
+		$XFS_IO_PROG -c "falloc 0 $datasize" $f
+		$XFS_IO_PROG -c "fsync" $f
+	done
+
+	# Query number of block
+	datablocks=$(stat -c "%b" $datadir/$dataname)
+
+	# For lazy lookup file the block count is estimated based on size and block size
+	datablocksize=$(stat -c "%B" $datadir/$dataname)
+	estimated_datablocks=$(( ($datasize + $datablocksize - 1)/$datablocksize ))
+}
+
+prepare_midlayer()
+{
+	local _redirect=$1
+
+	_scratch_mkfs
+	create_basic_files
+	if [ -n "$_redirect" ]; then
+		mv "$datadir/$dataname" "$datadir/$_redirect"
+		mv "$datadir2/$dataname2" "$datadir2/$_redirect.2"
+		mv "$datadir/$sharedname" "$datadir/$_redirect.shared"
+		mv "$datadir2/$sharedname" "$datadir2/$_redirect.shared"
+	fi
+	# Create midlayer
+	_overlay_scratch_mount_dirs $datadir2:$datadir $lowerdir $workdir2 -o redirect_dir=on,index=on,metacopy=on
+	# Trigger a metacopy with or without redirect
+	if [ -n "$_redirect" ]; then
+		mv "$SCRATCH_MNT/$_redirect" "$SCRATCH_MNT/$dataname"
+		mv "$SCRATCH_MNT/$_redirect.2" "$SCRATCH_MNT/$dataname2"
+		mv "$SCRATCH_MNT/$_redirect.shared" "$SCRATCH_MNT/$sharedname"
+	else
+		chmod 400 $SCRATCH_MNT/$dataname
+		chmod 400 $SCRATCH_MNT/$dataname2
+		chmod 400 $SCRATCH_MNT/$sharedname
+	fi
+	umount_overlay
+
+	_overlay_trusted_to_user $lowerdir
+}
+
+# Create test directories
+datadir=$OVL_BASE_SCRATCH_MNT/data
+datadir2=$OVL_BASE_SCRATCH_MNT/data2
+lowerdir=$OVL_BASE_SCRATCH_MNT/lower
+upperdir=$OVL_BASE_SCRATCH_MNT/upper
+workdir=$OVL_BASE_SCRATCH_MNT/workdir
+workdir2=$OVL_BASE_SCRATCH_MNT/workdir2
+
+echo -e "\n== Check no follow to lowerdata layer without redirect =="
+prepare_midlayer
+test_no_access "$dataname"
+test_no_access "$dataname2"
+test_no_access "$sharedname"
+
+echo -e "\n== Check no follow to lowerdata layer with relative redirect =="
+prepare_midlayer "$dataname.renamed"
+test_no_access "$dataname"
+test_no_access "$dataname2"
+test_no_access "$sharedname"
+
+echo -e "\n== Check follow to lowerdata layer with absolute redirect =="
+prepare_midlayer "/subdir/$dataname"
+test_common "$lowerdir" "$datadir2" "$datadir" "$dataname" $datasize $datablocks \
+		"$datacontent" "/subdir/$dataname"
+test_common "$lowerdir" "$datadir2" "$datadir" "$dataname2" $datasize $datablocks \
+		"$datacontent2" "/subdir/$dataname.2"
+# Shared file should be picked from upper datadir
+test_common "$lowerdir" "$datadir2" "$datadir" "$sharedname" $datasize $datablocks \
+		"$datacontent2" "/subdir/$dataname.shared"
+
+echo -e "\n== Check lazy follow to lowerdata layer =="
+
+prepare_midlayer "/subdir/$dataname"
+rm $datadir/subdir/$dataname
+test_lazy $dataname
+
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/088.out b/tests/overlay/088.out
new file mode 100644
index 000000000000..c85c998d503a
--- /dev/null
+++ b/tests/overlay/088.out
@@ -0,0 +1,39 @@
+QA output created by 088
+
+== Check no follow to lowerdata layer without redirect ==
+No access to lowerdata layer datafile
+Unmount and Mount rw
+No access to lowerdata layer datafile
+No access to lowerdata layer datafile2
+Unmount and Mount rw
+No access to lowerdata layer datafile2
+No access to lowerdata layer shared
+Unmount and Mount rw
+No access to lowerdata layer shared
+
+== Check no follow to lowerdata layer with relative redirect ==
+No access to lowerdata layer datafile
+Unmount and Mount rw
+No access to lowerdata layer datafile
+No access to lowerdata layer datafile2
+Unmount and Mount rw
+No access to lowerdata layer datafile2
+No access to lowerdata layer shared
+Unmount and Mount rw
+No access to lowerdata layer shared
+
+== Check follow to lowerdata layer with absolute redirect ==
+Mount ro
+check properties of metadata copied up file datafile
+Unmount and Mount rw
+check properties of metadata copied up file datafile
+Mount ro
+check properties of metadata copied up file datafile2
+Unmount and Mount rw
+check properties of metadata copied up file datafile2
+Mount ro
+check properties of metadata copied up file shared
+Unmount and Mount rw
+check properties of metadata copied up file shared
+
+== Check lazy follow to lowerdata layer ==
diff --git a/tests/overlay/089 b/tests/overlay/089
new file mode 100755
index 000000000000..2259f917ecf8
--- /dev/null
+++ b/tests/overlay/089
@@ -0,0 +1,272 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+# Copyright (C) 2023 CTERA Networks. All Rights Reserved.
+#
+# FS QA Test No. 089
+#
+# Test fs-verity functionallity
+# This is a variant of test overlay/080 with userxattr and without
+# redirect_dir/metacopy options
+#
+. ./common/preamble
+_begin_fstest auto quick metacopy redirect verity
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+. ./common/verity
+
+# We use non-default scratch underlying overlay dirs, we need to check
+# them explicity after test.
+_require_scratch_nocheck
+_require_scratch_overlay_features redirect_dir metacopy
+_require_scratch_overlay_lowerdata_layers
+_require_scratch_overlay_datadir_without_metacopy
+_require_scratch_overlay_verity
+
+# remove all files from previous tests
+_scratch_mkfs
+
+verityname="verityfile"
+noverityname="noverityfile"
+wrongverityname="wrongverityfile"
+missingverityname="missingverityfile"
+lowerdata="data1"
+lowerdata2="data2"
+lowerdata3="data3"
+lowerdata4="data4"
+lowersize="5"
+
+# Create test directories
+lowerdir=$OVL_BASE_SCRATCH_MNT/lower
+lowerdir2=$OVL_BASE_SCRATCH_MNT/lower2
+upperdir=$OVL_BASE_SCRATCH_MNT/upper
+workdir=$OVL_BASE_SCRATCH_MNT/workdir
+workdir2=$OVL_BASE_SCRATCH_MNT/workdir2
+
+# Check metacopy xattr
+check_metacopy()
+{
+	local target=$1 exist=$2 dataonlybase=$3
+	local out_f target_f
+	local msg
+
+	out_f=$( { _getfattr --absolute-names --only-values -n \
+		"user.overlay.metacopy" $target 2>&3 | od -A n -t x1 -w256 ; } 3>&1 | _filter_scratch)
+        has_version0=`echo $out_f | awk 'NR==1{print $1 == 0}'`
+
+	if [ "$exist" == "y" ];then
+		[ "$out_f" == "" -o "$has_version0" == "1" ] && return
+		echo "Metacopy xattr does not exist on ${target}. stdout=$out_f"
+		return
+	fi
+
+	if [ "$out_f" == ""  -o "$has_version0" == "1" ];then
+		echo "Metacopy xattr exists on ${target} unexpectedly."
+		return
+	fi
+
+	target_f=`echo $target | _filter_scratch`
+	msg="$target_f: user.overlay.metacopy: No such attribute"
+
+	[ "$out_f" == "$msg" ] && return
+
+	echo "Error while checking xattr on ${target}. stdout=$out"
+}
+
+# Check verity set in metacopy
+check_verity()
+{
+	local target=$1 exist=$2
+	local out_f target_f
+	local msg
+
+	out_f=$( { _getfattr --absolute-names --only-values -n "user.overlay.metacopy" $target 2>&3 | od -A n -t x1 -w256 ; } 3>&1 | _filter_scratch)
+
+	target_f=`echo $target | _filter_scratch`
+	msg="$target_f: user.overlay.metacopy: No such attribute"
+	has_digest=`echo $out_f | awk 'NR==1{print $4 == 1}'`
+
+	if [ "$exist" == "y" ]; then
+		[ "$out_f" == "$msg" -o "$has_digest" == "0" ] && echo "No verity on ${target}. stdout=$out_f"
+		return
+	fi
+
+	[ "$out_f" == "$msg" -o "$has_digest" == "0" ] && return
+	echo "Verity xattr exists on ${target} unexpectedly. stdout=$out_f"
+}
+
+# Check redirect xattr
+check_redirect()
+{
+	local target=$1
+	local expect=$2
+
+	value=$(_getfattr --absolute-names --only-values -n \
+		"user.overlay.redirect" $target)
+
+	[[ "$value" == "$expect" ]] || echo "Redirect xattr incorrect. Expected=\"$expect\", actual=\"$value\""
+}
+
+# Check size
+check_file_size()
+{
+	local target=$1 expected_size=$2 actual_size
+
+	actual_size=$(_get_filesize $target)
+
+	[ "$actual_size" == "$expected_size" ] || echo "Expected file size of $target $expected_size but actual size is $actual_size"
+}
+
+check_file_contents()
+{
+	local target=$1 expected=$2
+	local actual target_f
+
+	target_f=`echo $target | _filter_scratch`
+
+	read actual<$target
+
+	[ "$actual" == "$expected" ] || echo "Expected file $target_f contents to be \"$expected\" but actual contents are \"$actual\""
+}
+
+check_file_size_contents()
+{
+	local target=$1 expected_size=$2 expected_content=$3
+
+	check_file_size $target $expected_size
+	check_file_contents $target $expected_content
+}
+
+check_io_error()
+{
+	local target=$1
+	local actual target_f out_f
+
+	target_f=`echo $target | _filter_scratch`
+	out_f=`cat $target 2>&1 | _filter_scratch`
+	msg="cat: $target_f: Input/output error"
+
+	[ "$out_f" == "$msg" ] && return
+
+	echo "$target_f unexpectedly has no I/O error"
+}
+
+create_basic_files()
+{
+	local subdir=$1
+
+	_scratch_mkfs
+	mkdir -p $lowerdir $lowerdir2 $upperdir $workdir $workdir2
+
+	if [ "$subdir" != "" ]; then
+	    mkdir $lowerdir/$subdir
+	fi
+
+	echo -n "$lowerdata" > $lowerdir/$subdir$verityname
+	echo -n "$lowerdata2" > $lowerdir/$subdir$noverityname
+	echo -n "$lowerdata3" > $lowerdir/$subdir$wrongverityname
+	echo -n "$lowerdata4" > $lowerdir/$subdir$missingverityname
+
+	for f in $verityname $noverityname $wrongverityname $missingverityname; do
+		chmod 600 $lowerdir/$subdir$f
+
+		if [ "$f" != "$noverityname" ]; then
+			_fsv_enable $lowerdir/$subdir$f
+		fi
+        done
+}
+
+prepare_midlayer()
+{
+	subdir="base/"
+
+	create_basic_files "$subdir"
+	# Create midlayer
+	_overlay_scratch_mount_dirs $lowerdir $lowerdir2 $workdir2 -o redirect_dir=on,index=on,verity=on,metacopy=on
+	for f in $verityname $noverityname $wrongverityname $missingverityname; do
+		mv $SCRATCH_MNT/base/$f $SCRATCH_MNT/$f
+	done
+	umount_overlay
+
+	_overlay_trusted_to_user $lowerdir2
+
+	rm -rf $lowerdir2/base
+
+	for f in $verityname $noverityname $wrongverityname $missingverityname; do
+		# Ensure we have right metacopy and verity xattrs
+		check_metacopy $lowerdir2/$f "y"
+
+		if [ "$f" == "$noverityname" ]; then
+		    check_verity $lowerdir2/$f "n"
+		else
+		    check_verity $lowerdir2/$f "y"
+		fi
+
+		check_redirect $lowerdir2/$f "/base/$f"
+
+		check_file_size_contents $lowerdir2/$f $lowersize ""
+	done
+
+	# Fixup missing and wrong verity in lowerdir
+	rm -f $lowerdir/$subdir$wrongverityname $lowerdir/$subdir$missingverityname
+	echo -n "changed" > $lowerdir/$subdir$wrongverityname
+	_fsv_enable $lowerdir/$subdir$wrongverityname
+	echo "$lowerdata4" > $lowerdir/$subdir$missingverityname
+}
+
+test_common()
+{
+	local verity=$1
+
+	mount_overlay "$lowerdir2::$lowerdir" $verity
+
+	check_file_size_contents $SCRATCH_MNT/$verityname $lowersize "$lowerdata"
+
+	if [ "$verity" == "require" ]; then
+		check_io_error $SCRATCH_MNT/$noverityname
+	else
+		check_file_size_contents $SCRATCH_MNT/$noverityname $lowersize "$lowerdata2"
+	fi
+
+	if [ "$verity" == "off" ]; then
+		check_file_size_contents $SCRATCH_MNT/$wrongverityname $lowersize "changed"
+		check_file_size_contents $SCRATCH_MNT/$missingverityname $lowersize "$lowerdata4"
+	else
+		check_io_error $SCRATCH_MNT/$missingverityname
+		check_io_error $SCRATCH_MNT/$wrongverityname
+	fi
+
+	umount_overlay
+}
+
+mount_overlay()
+{
+	local _lowerdir=$1
+	local _verity=$2
+
+	_overlay_scratch_mount_dirs "$_lowerdir" $upperdir $workdir -o userxattr,verity=$_verity
+}
+
+umount_overlay()
+{
+	$UMOUNT_PROG $SCRATCH_MNT
+}
+
+
+echo -e "\n== Check fsverity validation =="
+
+prepare_midlayer
+test_common "off"
+prepare_midlayer
+test_common "on"
+
+echo -e "\n== Check fsverity require =="
+
+prepare_midlayer
+test_common "require"
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/089.out b/tests/overlay/089.out
new file mode 100644
index 000000000000..0c3eee7103b1
--- /dev/null
+++ b/tests/overlay/089.out
@@ -0,0 +1,5 @@
+QA output created by 089
+
+== Check fsverity validation ==
+
+== Check fsverity require ==
-- 
2.49.0


