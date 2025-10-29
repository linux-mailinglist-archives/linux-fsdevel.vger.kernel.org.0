Return-Path: <linux-fsdevel+bounces-66139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6EC17DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EB43BACF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8CB2D839E;
	Wed, 29 Oct 2025 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nClsLxYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F4450FE;
	Wed, 29 Oct 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700842; cv=none; b=ggNq3SgFPkMHpOl2fWK/5T5j5CHKUpEotdQs7L+hhv9DJW/heSXzY60o7jioZLv2jYCN7Kn0/PMPFwhSJqAQ52oqN+tz++6gm5mN8ktWMGOOqr4K0xxeTdeoU1fXGdT1mDrb2XJEdT8ht/zF+785P6HqF6Em1nhGRRirWWOg8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700842; c=relaxed/simple;
	bh=uOI85zxfN7eUVBvT1SxZF0+uf7e16pdXVNqZiwcaOcg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWEBZzsXFESJ1Gmr1R7h0qtzvKovo7WiPRCLrivKzD7bXXk9Ck+PVGXKecZuSUb24bLN+pTfwefpjdh5RoUa0yFCw0WoRw1iBm+fTTmuJxCzQhGHcTD0ddHkNW73dxfTczVE3EozxDlZvnr4AN5tapsZwdaQFhwvKsLox90Ny1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nClsLxYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A55C4CEE7;
	Wed, 29 Oct 2025 01:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700842;
	bh=uOI85zxfN7eUVBvT1SxZF0+uf7e16pdXVNqZiwcaOcg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nClsLxYtkdEe+zcEhiDle/cfiatSJoisi/V4pdKaM0M62QJJkIWcaVA9IGrvz6ldg
	 YbMTqrGZ94/AFIvI/PlzP8m/wt+UGx+PTPqWBSwuSVmtZe7id2mpaVF8MG9kyLU+8L
	 pcdHSIgHcsZYgbxRp/ZuC1xo1ANtNlPsrMqCI28VoMQE91NjYbeRnIbCO8xcE0csW+
	 As0VwjVeXGAc1offrWG/sDGiEqmi0cXNgXsS+SFFuT6d2R5jawwR95NDR/AaepTAun
	 R6cU/Es+w7jIdNpM9KEZ+7qLuKZyt/CAKyTZxS3Rl1d/CIcva2ZiN6rXYnRyEvswgx
	 BVrYPPdfcMCgA==
Date: Tue, 28 Oct 2025 18:20:41 -0700
Subject: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234] drivers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

It would be useful to be able to run fstests against the userspace
ext[234] driver program fuse2fs.  A convention (at least on Debian)
seems to be to install fuse drivers as /sbin/mount.fuse.XXX so that
users can run "mount -t fuse.XXX" to start a fuse driver for a
disk-based filesystem type XXX.

Therefore, we'll adopt the practice of setting FSTYP=fuse.ext4 to
test ext4 with fuse2fs.  Change all the library code as needed to handle
this new type alongside all the existing ext[234] checks, which seems a
little cleaner than FSTYP=fuse FUSE_SUBTYPE=ext4, which also would
require even more treewide cleanups to work properly because most
fstests code switches on $FSTYP alone.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 check             |   24 +++++++++++++++++-------
 common/casefold   |    4 ++++
 common/config     |   11 ++++++++---
 common/defrag     |    2 +-
 common/encrypt    |   16 ++++++++--------
 common/log        |   10 +++++-----
 common/populate   |   14 +++++++-------
 common/quota      |    9 +++++++++
 common/rc         |   50 +++++++++++++++++++++++++++++---------------------
 common/report     |    2 +-
 common/verity     |    8 ++++----
 tests/generic/020 |    2 +-
 tests/generic/067 |    2 +-
 tests/generic/441 |    2 +-
 tests/generic/496 |    2 +-
 tests/generic/621 |    2 +-
 tests/generic/740 |    2 +-
 tests/generic/746 |    4 ++--
 tests/generic/765 |    4 ++--
 19 files changed, 103 insertions(+), 67 deletions(-)


diff --git a/check b/check
index 9bb80a22440f97..81cd03f73ce155 100755
--- a/check
+++ b/check
@@ -140,12 +140,25 @@ get_sub_group_list()
 	echo $grpl
 }
 
+get_group_dirs()
+{
+	local fsgroup="$FSTYP"
+
+	case "$FSTYP" in
+	ext2|ext3|fuse.ext[234])
+		fsgroup=ext4
+		;;
+	esac
+
+	echo $SRC_GROUPS
+	echo $fsgroup
+}
+
 get_group_list()
 {
 	local grp=$1
 	local grpl=""
 	local sub=$(dirname $grp)
-	local fsgroup="$FSTYP"
 
 	if [ -n "$sub" -a "$sub" != "." -a -d "$SRC_DIR/$sub" ]; then
 		# group is given as <subdir>/<group> (e.g. xfs/quick)
@@ -154,10 +167,7 @@ get_group_list()
 		return
 	fi
 
-	if [ "$FSTYP" = ext2 -o "$FSTYP" = ext3 ]; then
-	    fsgroup=ext4
-	fi
-	for d in $SRC_GROUPS $fsgroup; do
+	for d in $(get_group_dirs); do
 		if ! test -d "$SRC_DIR/$d" ; then
 			continue
 		fi
@@ -171,7 +181,7 @@ get_group_list()
 get_all_tests()
 {
 	touch $tmp.list
-	for d in $SRC_GROUPS $FSTYP; do
+	for d in $(get_group_dirs); do
 		if ! test -d "$SRC_DIR/$d" ; then
 			continue
 		fi
@@ -387,7 +397,7 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
 fi
 
 if [ -n "$subdir_xfile" ]; then
-	for d in $SRC_GROUPS $FSTYP; do
+	for d in $(get_group_dirs); do
 		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
 		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
 			exclude_tests+=($d/$f)
diff --git a/common/casefold b/common/casefold
index 2aae5e5e6c8925..fcdb4d210028ac 100644
--- a/common/casefold
+++ b/common/casefold
@@ -6,6 +6,10 @@
 _has_casefold_kernel_support()
 {
 	case $FSTYP in
+	fuse.ext[234])
+		# fuse2fs does not support casefolding
+		false
+		;;
 	ext4)
 		test -f '/sys/fs/ext4/features/casefold'
 		;;
diff --git a/common/config b/common/config
index 7fa97319d7d0ca..0cd2b33c4ade40 100644
--- a/common/config
+++ b/common/config
@@ -386,6 +386,11 @@ _common_mount_opts()
 	overlay)
 		echo $OVERLAY_MOUNT_OPTIONS
 		;;
+	fuse.ext[234])
+		# fuse sets up secure defaults, so we must explicitly tell
+		# fuse2fs to use the more relaxed kernel access behaviors.
+		echo "-o kernel $EXT_MOUNT_OPTIONS"
+		;;
 	ext2|ext3|ext4)
 		# acls & xattrs aren't turned on by default on ext$FOO
 		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
@@ -472,7 +477,7 @@ _mkfs_opts()
 _fsck_opts()
 {
 	case $FSTYP in
-	ext2|ext3|ext4)
+	ext2|ext3|fuse.ext[234]|ext4)
 		export FSCK_OPTIONS="-nf"
 		;;
 	reiser*)
@@ -514,11 +519,11 @@ _source_specific_fs()
 
 		. ./common/btrfs
 		;;
-	ext4)
+	fuse.ext4|ext4)
 		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
 		. ./common/ext4
 		;;
-	ext2|ext3)
+	ext2|ext3|fuse.ext[23])
 		. ./common/ext4
 		;;
 	f2fs)
diff --git a/common/defrag b/common/defrag
index 055d0d0e9182c5..c054e62bde6f4d 100644
--- a/common/defrag
+++ b/common/defrag
@@ -12,7 +12,7 @@ _require_defrag()
         _require_xfs_io_command "falloc"
         DEFRAG_PROG="$XFS_FSR_PROG"
 	;;
-    ext4)
+    fuse.ext4|ext4)
 	testfile="$TEST_DIR/$$-test.defrag"
 	donorfile="$TEST_DIR/$$-donor.defrag"
 	bsize=`_get_block_size $TEST_DIR`
diff --git a/common/encrypt b/common/encrypt
index f2687631b214cf..4fa7b6853fd461 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -191,7 +191,7 @@ _require_hw_wrapped_key_support()
 _scratch_mkfs_encrypted()
 {
 	case $FSTYP in
-	ext4|f2fs)
+	fuse.ext4|ext4|f2fs)
 		_scratch_mkfs -O encrypt
 		;;
 	ubifs)
@@ -210,7 +210,7 @@ _scratch_mkfs_encrypted()
 _scratch_mkfs_sized_encrypted()
 {
 	case $FSTYP in
-	ext4|f2fs)
+	fuse.ext4|ext4|f2fs)
 		MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" _scratch_mkfs_sized $*
 		;;
 	*)
@@ -225,7 +225,7 @@ _scratch_mkfs_sized_encrypted()
 _scratch_mkfs_stable_inodes_encrypted()
 {
 	case $FSTYP in
-	ext4)
+	fuse.ext4|ext4)
 		if ! _scratch_mkfs -O encrypt -O stable_inodes; then
 			_notrun "-O stable_inodes is not supported"
 		fi
@@ -330,7 +330,7 @@ _num_to_hex()
 _get_fs_keyprefix()
 {
 	case $FSTYP in
-	ext4|f2fs)
+	fuse.ext4|ext4|f2fs)
 		echo $FSTYP
 		;;
 	*)
@@ -557,7 +557,7 @@ _get_encryption_nonce()
 	local inode=$2
 
 	case $FSTYP in
-	ext4)
+	fuse.ext4|ext4)
 		# Use debugfs to dump the special xattr named "c", which is the
 		# file's fscrypt_context.  This produces a line like:
 		#
@@ -605,7 +605,7 @@ _require_get_encryption_nonce_support()
 {
 	echo "Checking for _get_encryption_nonce() support for $FSTYP" >> $seqres.full
 	case $FSTYP in
-	ext4)
+	fuse.ext4|ext4)
 		_require_command "$DEBUGFS_PROG" debugfs
 		;;
 	f2fs)
@@ -631,7 +631,7 @@ _get_ciphertext_filename()
 	local dir_inode=$3
 
 	case $FSTYP in
-	ext4)
+	fuse.ext4|ext4)
 		# Extract the filename from the debugfs output line like:
 		#
 		#  131075  100644 (1)      0      0       0 22-Apr-2019 16:54 \xa2\x85\xb0z\x13\xe9\x09\x86R\xed\xdc\xce\xad\x14d\x19
@@ -685,7 +685,7 @@ _require_get_ciphertext_filename_support()
 {
 	echo "Checking for _get_ciphertext_filename() support for $FSTYP" >> $seqres.full
 	case $FSTYP in
-	ext4)
+	fuse.ext4|ext4)
 		# Verify that the "ls -l -r" debugfs command is supported and
 		# that it hex-encodes non-ASCII characters, rather than using an
 		# ambiguous escaping method.  This requires e2fsprogs v1.45.1 or
diff --git a/common/log b/common/log
index ab7bc9f8733e28..b846d7087c0de5 100644
--- a/common/log
+++ b/common/log
@@ -228,7 +228,7 @@ _scratch_dump_log()
 	f2fs)
 		$DUMP_F2FS_PROG $SCRATCH_DEV
 		;;
-	ext4)
+	fuse.ext[34]|ext[34])
 		$DEBUGFS_PROG -R "logdump -a" $SCRATCH_DEV
 		;;
 	*)
@@ -245,7 +245,7 @@ _test_dump_log()
 	f2fs)
 		$DUMP_F2FS_PROG $TEST_DEV
 		;;
-	ext4)
+	fuse.ext[34]|ext[34])
 		$DEBUGFS_PROG -R "logdump -a" $TEST_DEV
 		;;
 	*)
@@ -262,7 +262,7 @@ _print_logstate()
     f2fs)
         dirty=$(_scratch_f2fs_logstate)
         ;;
-    ext4)
+    fuse.ext[34]|ext[34])
         dirty=$(_scratch_ext4_logstate)
         ;;
     *)
@@ -531,7 +531,7 @@ _require_logstate()
             _notrun "This test requires dump.f2fs utility."
         fi
         ;;
-    ext4)
+    fuse.ext[34]|ext[34])
 	if [ -z "$DUMPE2FS_PROG" ]; then
 		_notrun "This test requires dumpe2fs utility."
 	fi
@@ -599,7 +599,7 @@ _get_log_configs()
     f2fs)
         _f2fs_log_config
         ;;
-    ext4)
+    fuse.ext[34]|ext[34])
         _ext4_log_config
         ;;
     *)
diff --git a/common/populate b/common/populate
index 1c0dd03e4ac787..6ca4a68b129806 100644
--- a/common/populate
+++ b/common/populate
@@ -21,7 +21,7 @@ _require_populate_commands() {
 		_require_command "$WIPEFS_PROG" "wipefs"
 		_require_scratch_xfs_mdrestore
 		;;
-	ext*)
+	fuse.ext[234]|ext[234])
 		_require_command "$DUMPE2FS_PROG" "dumpe2fs"
 		_require_command "$E2IMAGE_PROG" "e2image"
 		;;
@@ -61,7 +61,7 @@ __populate_fail() {
 
 		_scratch_xfs_metadump "$metadump" "${mdargs[@]}"
 		;;
-	ext4)
+	fuse.ext[234]|ext[234])
 		_scratch_unmount
 		_ext4_metadump "${SCRATCH_DEV}" "$metadump"
 		;;
@@ -978,7 +978,7 @@ _scratch_populate() {
 		_scratch_xfs_populate
 		_scratch_xfs_populate_check
 		;;
-	"ext2"|"ext3"|"ext4")
+	fuse.ext[234]|ext[234])
 		_scratch_ext4_populate
 		_scratch_ext4_populate_check
 		;;
@@ -1072,7 +1072,7 @@ _scratch_populate_cache_tag() {
 	fi
 
 	case "${FSTYP}" in
-	"ext4")
+	fuse.ext[234]|ext[234])
 		extra_descr="LOGDEV_SIZE ${logdev_sz}"
 		;;
 	"xfs")
@@ -1095,7 +1095,7 @@ _scratch_populate_restore_cached() {
 		_scratch_xfs_mdrestore "${metadump}"
 		return $?
 		;;
-	"ext2"|"ext3"|"ext4")
+	fuse.ext[234]|ext[234])
 		local logdev=none
 		[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
 			logdev=$SCRATCH_LOGDEV
@@ -1130,7 +1130,7 @@ _scratch_populate_save_metadump()
 				"$rtdev" compress "${mdargs[@]}"
 		res=$?
 		;;
-	"ext2"|"ext3"|"ext4")
+	fuse.ext[234]|ext[234])
 		_ext4_metadump "${SCRATCH_DEV}" "${metadump_file}" compress
 		res=$?
 		;;
@@ -1168,7 +1168,7 @@ _scratch_populate_cached() {
 		_scratch_xfs_populate $@
 		_scratch_xfs_populate_check
 		;;
-	"ext2"|"ext3"|"ext4")
+	fuse.ext[234]|ext[234])
 		_scratch_ext4_populate $@
 		_scratch_ext4_populate_check
 		;;
diff --git a/common/quota b/common/quota
index a51386b1dd249b..e22a8b5d2f0d3c 100644
--- a/common/quota
+++ b/common/quota
@@ -12,6 +12,9 @@ _require_quota()
     [ -n "$QUOTA_PROG" ] || _notrun "Quota user tools not installed"
 
     case $FSTYP in
+    fuse.ext[234])
+	    _notrun "quota not supported on fuse.ext[234]"
+	    ;;
     ext2|ext3|ext4|f2fs)
 	if [ ! -d /proc/sys/fs/quota ]; then
 	    _notrun "Installed kernel does not support quotas"
@@ -163,6 +166,9 @@ _require_getnextquota()
 _scratch_enable_pquota()
 {
 	case $FSTYP in
+	fuse.ext[234])
+		_notrun "fuse.ext[234] doesn't support project quota"
+		;;
 	ext2|ext3|ext4)
 		tune2fs -O quota,project $SCRATCH_DEV >>$seqres.full 2>&1
 		_try_scratch_mount >/dev/null 2>&1 \
@@ -335,6 +341,9 @@ _check_quota_usage()
 
 	VFS_QUOTA=0
 	case $FSTYP in
+	fuse.ext[234])
+		echo "fuse.ext[234] doesn't support quota"
+		;;
 	ext2|ext3|ext4|f2fs|gfs2|bcachefs)
 		VFS_QUOTA=1
 		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
diff --git a/common/rc b/common/rc
index 01b6f1d50c856f..3fe6f53758c05b 100644
--- a/common/rc
+++ b/common/rc
@@ -372,7 +372,7 @@ _scratch_options()
     "xfs")
 	_scratch_xfs_options "$@"
 	;;
-    ext2|ext3|ext4)
+    ext2|ext3|fuse.ext[234]|ext4)
 	_scratch_ext4_options "$@"
 	;;
     esac
@@ -430,7 +430,7 @@ _supports_filetype()
 	xfs)
 		_xfs_has_feature $dir ftype
 		;;
-	ext2|ext3|ext4)
+	ext2|ext3|fuse.ext[234]|ext4)
 		local dev=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $1}'`
 		tune2fs -l $dev | grep -q filetype
 		;;
@@ -845,7 +845,7 @@ _metadump_dev() {
 	btrfs)
 		_btrfs_metadump $device $dumpfile
 		;;
-	ext*)
+	ext*|fuse.ext*)
 		_ext4_metadump $device $dumpfile $compressopt
 		;;
 	xfs)
@@ -897,7 +897,7 @@ _test_mkfs()
     btrfs)
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
-    ext2|ext3|ext4)
+    ext2|ext3|fuse.ext[234]|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
     f2fs)
@@ -946,7 +946,7 @@ _try_mkfs_dev()
     btrfs)
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $*
 	;;
-    ext2|ext3|ext4)
+    ext2|ext3|fuse.ext[234]|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
 	;;
     f2fs)
@@ -1021,7 +1021,7 @@ _scratch_mkfs()
 		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
 		return 0
 		;;
-	ext4)
+	ext4|fuse.ext4)
 		_scratch_mkfs_ext4 $*
 		return $?
 		;;
@@ -1037,7 +1037,7 @@ _scratch_mkfs()
 		mkfs_cmd="$MKFS_BTRFS_PROG"
 		mkfs_filter="cat"
 		;;
-	ext3)
+	ext3|fuse.ext3)
 		mkfs_cmd="$MKFS_PROG -t $FSTYP -- -F"
 		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
 
@@ -1046,7 +1046,7 @@ _scratch_mkfs()
 		$mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
 		mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"
 		;;
-	ext2)
+	ext2|fuse.ext2)
 		mkfs_cmd="$MKFS_PROG -t $FSTYP -- -F"
 		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
 		;;
@@ -1287,7 +1287,7 @@ _try_scratch_mkfs_sized()
 	btrfs)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
 		;;
-	ext2|ext3|ext4|reiser4|ocfs2)
+	ext2|ext3|fuse.ext[234]|ext4|reiser4|ocfs2)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 		;;
 	udf)
@@ -1356,7 +1356,7 @@ _try_scratch_mkfs_sized()
 				-b size=$blocksize "$@"
 		fi
 		;;
-	ext2|ext3|ext4)
+	ext2|ext3|fuse.ext[234]|ext4)
 		# Can't use _scratch_mkfs_ext4 here because the block count has
 		# to come after the device path.
 		if [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ]; then
@@ -1457,7 +1457,7 @@ _scratch_mkfs_geom()
 		MKFS_OPTIONS+=" -d su=$sunit_bytes,sw=$swidth_mult"
 	fi
 	;;
-    ext4)
+    fuse.ext4|ext4)
 	MKFS_OPTIONS+=" -b $blocksize -E stride=$sunit_blocks,stripe_width=$swidth_blocks"
 	;;
     *)
@@ -1494,7 +1494,7 @@ _scratch_mkfs_blocksized()
 	xfs)
 		_try_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
 		;;
-	ext2|ext3|ext4)
+	ext2|ext3|fuse.ext[234]|ext4)
 		_scratch_mkfs_ext4 $MKFS_OPTIONS -b $blocksize
 		;;
 	gfs2)
@@ -2174,10 +2174,10 @@ _require_scratch_size_nocheck()
 _require_scratch_16T_support()
 {
 	case $FSTYP in
-	ext2|ext3|f2fs)
+	ext2|ext3|f2fs|fuse.ext[23])
 		_notrun "$FSTYP doesn't support >16T filesystem"
 		;;
-	ext4)
+	fuse.ext4|ext4)
 		_scratch_mkfs >> $seqres.full 2>&1
 		_scratch_mount
 		local blocksize=$(_get_block_size $SCRATCH_MNT)
@@ -2773,10 +2773,10 @@ _filesystem_timestamp_range()
 	s64min=$((1<<63))
 
 	case $fstyp in
-	ext2)
+	ext2|fuse.ext2)
 		echo "$s32min $s32max"
 		;;
-	ext3|ext4)
+	fuse.ext[34]|ext3|ext4)
 		if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
 			printf "%d %d\n" $s32min 0x37fffffff
 		else
@@ -3386,7 +3386,7 @@ _fstyp_has_non_default_seek_data_hole()
 	fi
 
 	case "$fstyp" in
-	btrfs|ext4|xfs|cifs|f2fs|gfs2|ocfs2|tmpfs)
+	btrfs|ext4|fuse.ext4|xfs|cifs|f2fs|gfs2|ocfs2|tmpfs)
 		return 0
 		;;
 	nfs*)
@@ -3405,6 +3405,10 @@ _fstyp_has_non_default_seek_data_hole()
 			return 1
 		fi
 		;;
+	fuse.ext[23])
+		# fuse2fs doesn't implement SEEK_DATA/SEEK_HOLE yet
+		return 1
+		;;
 	*)
 		# by default fstyp has default SEEK_HOLE behavior;
 		# if your fs has non-default behavior, add it to whitelist above!
@@ -3588,7 +3592,7 @@ _check_generic_filesystem()
 
     if [ $ok -eq 0 ] && [ -n "$DUMP_CORRUPT_FS" ]; then
         case "$FSTYP" in
-        ext*)
+        ext*|fuse.ext*)
             local flatdev="$(basename "$device")"
             _ext4_metadump "$device" "$seqres.$flatdev.check.qcow2" compress
             ;;
@@ -4305,6 +4309,10 @@ _has_metadata_journaling()
 	fi
 
 	case "$FSTYP" in
+	fuse.ext[234])
+		echo "fuse4fs does not support metadata journaling on $FSTYP"
+		return 1
+		;;
 	ext2|vfat|msdos|udf|exfat|tmpfs)
 		echo "$FSTYP does not support metadata journaling"
 		return 1
@@ -5535,7 +5543,7 @@ _label_get_max()
 	f2fs)
 		echo 255
 		;;
-	ext2|ext3|ext4)
+	ext2|ext3|fuse.ext[234]|ext4)
 		echo 16
 		;;
 	*)
@@ -5779,7 +5787,7 @@ _require_od_endian_flag()
 # fs labels, and extended attribute names) as raw byte sequences.
 _require_names_are_bytes() {
         case "$FSTYP" in
-        ext2|ext3|ext4|f2fs|xfs|btrfs)
+        ext2|ext3|fuse.ext[234]|ext4|f2fs|xfs|btrfs)
 		# do nothing
 	        ;;
 	*)
@@ -5957,7 +5965,7 @@ _require_duplicate_fsid()
 	"btrfs")
 		_require_btrfs_fs_feature temp_fsid
 		;;
-	"ext4")
+	fuse.ext[234]|"ext4")
 		;;
 	*)
 		_notrun "$FSTYP does not support duplicate fsid"
diff --git a/common/report b/common/report
index a41a58f790b784..33978321f56a90 100644
--- a/common/report
+++ b/common/report
@@ -77,7 +77,7 @@ __generate_report_vars() {
 
 	# Add per-filesystem variables to the report variable list
 	test "$FSTYP" = "xfs" && __generate_xfs_report_vars
-	[[ "$FSTYP" == ext[0-9]* ]] && __generate_ext4_report_vars
+	[[ "$FSTYP" =~ ext[0-9]* ]] && __generate_ext4_report_vars
 
 	# Optional environmental variables
 	for varname in "${REPORT_ENV_LIST_OPT[@]}"; do
diff --git a/common/verity b/common/verity
index 11e839d2e7dfcf..9a15642190ded9 100644
--- a/common/verity
+++ b/common/verity
@@ -198,7 +198,7 @@ _require_fsverity_corruption()
 _scratch_mkfs_verity()
 {
 	case $FSTYP in
-	ext4|f2fs)
+	fuse.ext4|ext4|f2fs)
 		_scratch_mkfs -O verity
 		;;
 	btrfs)
@@ -216,7 +216,7 @@ _scratch_mkfs_verity()
 _scratch_mkfs_encrypted_verity()
 {
 	case $FSTYP in
-	ext4)
+	fuse.ext4|ext4)
 		_scratch_mkfs -O encrypt,verity
 		;;
 	f2fs)
@@ -386,7 +386,7 @@ _fsv_scratch_corrupt_merkle_tree()
 	local offset=$2
 
 	case $FSTYP in
-	ext4|f2fs)
+	fuse.ext4|ext4|f2fs)
 		# ext4 and f2fs store the Merkle tree after the file contents
 		# itself, starting at the next 65536-byte aligned boundary.
 		(( offset += ($(_get_filesize $file) + 65535) & ~65535 ))
@@ -417,7 +417,7 @@ _fsv_scratch_corrupt_merkle_tree()
 _require_fsverity_max_file_size_limit()
 {
 	case $FSTYP in
-	btrfs|ext4|f2fs)
+	btrfs|fuse.ext4|ext4|f2fs)
 		;;
 	*)
 		_notrun "$FSTYP does not store verity data past EOF; no special file size limit"
diff --git a/tests/generic/020 b/tests/generic/020
index 8b77d5ca750105..b98216b1f21b52 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -59,7 +59,7 @@ _attr_get_max()
 	xfs|udf|pvfs2|9p|ceph|fuse|nfs|ceph-fuse)
 		max_attrs=1000
 		;;
-	ext2|ext3|ext4)
+	ext2|ext3|fuse.ext[234]|ext4)
 		# For 4k blocksizes, most of the attributes have an attr_name of
 		# "attribute_NN" which is 12, and "value_NN" which is 8.
 		# But for larger block sizes, we start having extended
diff --git a/tests/generic/067 b/tests/generic/067
index 99d10ee0be0a0f..f8a59758668d5d 100755
--- a/tests/generic/067
+++ b/tests/generic/067
@@ -56,7 +56,7 @@ mount_free_loopdev()
 mount_wrong_fstype()
 {
 	local fs=ext4
-	if [ "$FSTYP" == "ext4" ]; then
+	if [[ "$FSTYP" =~ ext4 ]]; then
 		fs=xfs
 	fi
 	echo "# mount with wrong fs type" >>$seqres.full
diff --git a/tests/generic/441 b/tests/generic/441
index 6b48fc9ed5fbb3..063ca3f8daa258 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -33,7 +33,7 @@ case $FSTYP in
 	btrfs)
 		_notrun "btrfs has a specialized test for this"
 		;;
-	ext3|ext4|xfs|bcachefs)
+	ext3|fuse.ext[234]|ext4|xfs|bcachefs)
 		# Do the more thorough test if we have a logdev
 		_has_logdev && sflag=''
 		;;
diff --git a/tests/generic/496 b/tests/generic/496
index 344a4f5b08b4d4..0e76f55dd03b69 100755
--- a/tests/generic/496
+++ b/tests/generic/496
@@ -52,7 +52,7 @@ $XFS_IO_PROG -f -c "falloc 0 $len" $swapfile >> $seqres.full
 
 # ext4/xfs should not fail for swapon on fallocated files
 case $FSTYP in
-ext4|xfs)
+fuse.ext[234]|ext4|xfs)
 	"$here/src/swapon" $swapfile >> $seqres.full 2>&1 || \
 		_fail "swapon failed on fallocated file"
 	;;
diff --git a/tests/generic/621 b/tests/generic/621
index e5f92894c8eb4b..2d3fa4be0f9044 100755
--- a/tests/generic/621
+++ b/tests/generic/621
@@ -144,7 +144,7 @@ done
 # directories); otherwise e2fsck doesn't check for duplicate filenames.
 echo -e "\n# Checking for duplicate filenames via fsck"
 _scratch_unmount
-if [ "$FSTYP" = ext4 ]; then
+if [[ "$FSTYP" =~ ext4 ]]; then
 	if ! e2fsck -f -y -D $SCRATCH_DEV &>> $seqres.full; then
 		_log_err "filesystem on $SCRATCH_DEV is inconsistent"
 	fi
diff --git a/tests/generic/740 b/tests/generic/740
index ce55200f7bc34c..83a16052a8a252 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -36,7 +36,7 @@ do
 	postargs=""	# for any special post-device options
 
 	case "$fs"  in
-	ext2|ext3|ext4)
+	ext2|ext3|fuse.ext[234]|ext4)
 		preargs="-F"
 		;;
 	cramfs)
diff --git a/tests/generic/746 b/tests/generic/746
index 6f02b1cc354782..aa9282c66ebe06 100755
--- a/tests/generic/746
+++ b/tests/generic/746
@@ -26,7 +26,7 @@ btrfs)
 	_require_fs_space $TEST_DIR 3145728
 	fssize=3000
 	;;
-ext4)
+fuse.ext[234]|ext4)
 	_require_dumpe2fs
 	;;
 xfs)
@@ -65,7 +65,7 @@ get_holes()
 get_free_sectors()
 {
 	case $FSTYP in
-	ext4)
+	fuse.ext[234]|ext4)
 	_unmount $loop_mnt
 	$DUMPE2FS_PROG $loop_dev  2>&1 | grep " Free blocks" | cut -d ":" -f2- | \
 		tr ',' '\n' | $SED_PROG 's/^ //' | \
diff --git a/tests/generic/765 b/tests/generic/765
index 8c4e0bd02e4e65..a714f8db33a873 100755
--- a/tests/generic/765
+++ b/tests/generic/765
@@ -28,7 +28,7 @@ get_supported_bsize()
             fi
         done
         ;;
-    "ext4")
+    fuse.ext[234]|"ext4")
         min_bsize=1024
         max_bsize=$(_get_page_size)
         ;;
@@ -50,7 +50,7 @@ get_mkfs_opts()
     "xfs")
         mkfs_opts="-b size=$bsize"
         ;;
-    "ext4")
+    fuse.ext[234]|"ext4")
         mkfs_opts="-b $bsize"
         ;;
     *)


