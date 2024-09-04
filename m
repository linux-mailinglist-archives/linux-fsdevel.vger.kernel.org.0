Return-Path: <linux-fsdevel+bounces-28630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981996C7EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 21:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290951F22508
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A51E766A;
	Wed,  4 Sep 2024 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Qo0vJlNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6C1E6DFE;
	Wed,  4 Sep 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479342; cv=none; b=dhuGjnmHoWfUYZWuI8Wc1wpsimNqogaF5AuHehZX7AOaw+Tx3PwY597WKaQ4AXBZu4BeV6MMoEpQDlCX79Pn1DApkxet/a2Q3RPvyCDyfQ7MtWfttZ8EBsvpndJqsin6lbs4SppIWefFISPVfibMi4dDvTcuNPH6a+Xvr5lj1oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479342; c=relaxed/simple;
	bh=2K+VX4p3uDGakxs+L7o+AlNEOWnCPpWPn3F8rdwgk9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHNNi2/H2C/Q/aHj09CyylcuP8pWw/oKSNgUnI8Gxmc2ovmzLB8xAVa3pqvTcRhMzixbhdI7ri4HAcUcGPHNw75G1tI36ql09Z2Xu+yo5DzX0dx9D8uyYR5BdicR3Dw/HP0ynyr9r51hRYDda+Zq1AUBu6X1gmhk7Plach3xHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Qo0vJlNC; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WzY2q2HrJz9spS;
	Wed,  4 Sep 2024 21:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725479331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BSu2Q0T9+xOgt78zbEntYoVoIo9mHWjBB4iqf/3dj8=;
	b=Qo0vJlNCJJoL3PC5OALfFqchf+wlFA0F7M9SUTN8Jec2MfCzteYQ/k8Xu2Lt07V1TTDTJ7
	lyrgByXi7LeHIWu/qVWkoH+VyUqqpE27WDfLjH8ZyOUqhLvgsIve9Oecij8ub327KyyZai
	MJMQuNWK9G3wSKcJfmcmaYt0DNatskjHCD2Fn2dgVmESTOfMDOhHZz5gkKkoN4XHJRtZGH
	0QEXM2XozeEDaFxyGvwm8YxT6i+uPrSDM76RE0ylXF5tldfDerIABMOhFnbcLcMm9LncPO
	enMpMFkeP615NTNoFFUrHhDgAm2Rej6frEG44KSyqfHN/TT/xy54kLg7iOdUcQ==
From: Aleksa Sarai <cyphar@cyphar.com>
To: fstests@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH xfstests v4 2/2] generic/756: test name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) explicitly
Date: Thu,  5 Sep 2024 05:48:23 +1000
Message-ID: <20240904194823.2456471-2-cyphar@cyphar.com>
In-Reply-To: <20240904194823.2456471-1-cyphar@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240904194823.2456471-1-cyphar@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to make sure we are actually testing AT_HANDLE_MNT_ID_UNIQUE,
add a test (based on generic/426) which runs the open_by_handle in a
mode where it will error out if there is a problem with getting mount
IDs. The test is skipped if the kernel doesn't support the necessary
features.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 common/rc             | 24 ++++++++++++++++
 src/open_by_handle.c  | 61 ++++++++++++++++++++++++++++++++++------
 tests/generic/756     | 65 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/756.out |  5 ++++
 4 files changed, 146 insertions(+), 9 deletions(-)
 create mode 100755 tests/generic/756
 create mode 100644 tests/generic/756.out

diff --git a/common/rc b/common/rc
index 9da9fe188297..0beaf2ff1126 100644
--- a/common/rc
+++ b/common/rc
@@ -5178,6 +5178,30 @@ _require_fibmap()
 	rm -f $file
 }
 
+_require_statx_unique_mountid()
+{
+	# statx(STATX_MNT_ID=0x1000) was added in Linux 5.8.
+	# statx(STATX_MNT_ID_UNIQUE=0x4000) was added in Linux 6.9.
+	# We only need to check the latter.
+
+	export STATX_MNT_ID_UNIQUE=0x4000
+	local statx_mask=$(
+		${XFS_IO_PROG} -c "statx -m $STATX_MNT_ID_UNIQUE -r" "$TEST_DIR" |
+		sed -En 's/stat\.mask = (0x[0-9a-f]+)/\1/p'
+	)
+
+	[[ $(( statx_mask & STATX_MNT_ID_UNIQUE )) == $((STATX_MNT_ID_UNIQUE)) ]] ||
+		_notrun "statx does not support STATX_MNT_ID_UNIQUE on this kernel"
+}
+
+_require_open_by_handle_unique_mountid()
+{
+	_require_test_program "open_by_handle"
+
+	$here/src/open_by_handle -C AT_HANDLE_MNT_ID_UNIQUE 2>&1 \
+		|| _notrun "name_to_handle_at does not support AT_HANDLE_MNT_ID_UNIQUE"
+}
+
 _try_wipe_scratch_devs()
 {
 	test -x "$WIPEFS_PROG" || return 0
diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index dcbcd35561fb..a99cce4b3558 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -106,7 +106,8 @@ struct handle {
 
 void usage(void)
 {
-	fprintf(stderr, "usage: open_by_handle [-cludmrwapknhs] [<-i|-o> <handles_file>] <test_dir> [num_files]\n");
+	fprintf(stderr, "usage: open_by_handle [-cludmMrwapknhs] [<-i|-o> <handles_file>] <test_dir> [num_files]\n");
+	fprintf(stderr, "       open_by_handle -C <feature>\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N test files under test_dir, try to get file handles and exit\n");
 	fprintf(stderr, "open_by_handle    <test_dir> [N] - get file handles of test files, drop caches and try to open by handle\n");
@@ -119,16 +120,21 @@ void usage(void)
 	fprintf(stderr, "open_by_handle -u <test_dir> [N] - unlink (hardlinked) test files, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test files and hardlinks, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test files, drop caches and try to open by handle\n");
+	fprintf(stderr, "open_by_handle -M <test_dir> [N] - do not silently skip the mount ID verifications\n");
 	fprintf(stderr, "open_by_handle -p <test_dir>     - create/delete and try to open by handle also test_dir itself\n");
 	fprintf(stderr, "open_by_handle -i <handles_file> <test_dir> [N] - read test files handles from file and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -o <handles_file> <test_dir> [N] - get file handles of test files and write handles to file\n");
 	fprintf(stderr, "open_by_handle -s <test_dir> [N] - wait in sleep loop after opening files by handle to keep them open\n");
 	fprintf(stderr, "open_by_handle -z <test_dir> [N] - query filesystem required buffer size\n");
+	fprintf(stderr, "\n");
+	fprintf(stderr, "open_by_handle -C <feature>      - check if <feature> is supported by the kernel.\n");
+	fprintf(stderr, "  <feature> can be any of the following values:\n");
+	fprintf(stderr, "  - AT_HANDLE_MNT_ID_UNIQUE\n");
 	exit(EXIT_FAILURE);
 }
 
 static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
-				int bufsz)
+				int bufsz, bool force_check_mountid)
 {
 	int ret;
 	int mntid_short;
@@ -144,10 +150,15 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
 			fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", fname);
 			return EXIT_FAILURE;
 		}
-		if (!(statxbuf.stx_mask & STATX_MNT_ID))
+		if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
+			if (force_check_mountid) {
+				fprintf(stderr, "%s: statx(STATX_MNT_ID) not supported by running kernel\n", fname);
+				return EXIT_FAILURE;
+			}
 			skip_mntid = true;
-		else
+		} else {
 			statx_mntid_short = statxbuf.stx_mnt_id;
+		}
 	}
 
 	if (!skip_mntid_unique) {
@@ -159,10 +170,15 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
 		 * STATX_MNT_ID_UNIQUE was added fairly recently in Linux 6.8, so if the
 		 * kernel doesn't give us a unique mount ID just skip it.
 		 */
-		if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE))
+		if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE)) {
+			if (force_check_mountid) {
+				fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE) not supported by running kernel\n", fname);
+				return EXIT_FAILURE;
+			}
 			skip_mntid_unique = true;
-		else
+		} else {
 			statx_mntid_unique = statxbuf.stx_mnt_id;
+		}
 	}
 
 	fh->handle_bytes = bufsz;
@@ -203,6 +219,10 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
 				return EXIT_FAILURE;
 			}
 			/* EINVAL means AT_HANDLE_MNT_ID_UNIQUE is not supported */
+			if (force_check_mountid) {
+				fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) not supported by running kernel\n", fname);
+				return EXIT_FAILURE;
+			}
 			skip_mntid_unique = true;
 		} else {
 			if (mntid_unique != statx_mntid_unique) {
@@ -215,6 +235,22 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
 	return 0;
 }
 
+static int check_feature(const char *feature)
+{
+	if (!strcmp(feature, "AT_HANDLE_MNT_ID_UNIQUE")) {
+		int ret = name_to_handle_at(AT_FDCWD, ".", NULL, NULL, AT_HANDLE_MNT_ID_UNIQUE);
+		/* If AT_HANDLE_MNT_ID_UNIQUE is supported, we get EFAULT. */
+		if (ret < 0 && errno == EINVAL) {
+			fprintf(stderr, "name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) not supported by running kernel\n");
+			return EXIT_FAILURE;
+		}
+		return 0;
+	}
+
+	fprintf(stderr, "unknown feature name '%s'\n", feature);
+	return EXIT_FAILURE;
+}
+
 int main(int argc, char **argv)
 {
 	int	i, c;
@@ -234,16 +270,20 @@ int main(int argc, char **argv)
 	int	create = 0, delete = 0, nlink = 1, move = 0;
 	int	rd = 0, wr = 0, wrafter = 0, parent = 0;
 	int	keepopen = 0, drop_caches = 1, sleep_loop = 0;
+	int	force_check_mountid = 0;
 	int	bufsz = MAX_HANDLE_SZ;
 
 	if (argc < 2)
 		usage();
 
-	while ((c = getopt(argc, argv, "cludmrwapknhi:o:sz")) != -1) {
+	while ((c = getopt(argc, argv, "cC:ludmMrwapknhi:o:sz")) != -1) {
 		switch (c) {
 		case 'c':
 			create = 1;
 			break;
+		case 'C':
+			/* Check kernel feature support. */
+			return check_feature(optarg);
 		case 'w':
 			/* Write data before open_by_handle_at() */
 			wr = 1;
@@ -270,6 +310,9 @@ int main(int argc, char **argv)
 		case 'm':
 			move = 1;
 			break;
+		case 'M':
+			force_check_mountid = 1;
+			break;
 		case 'p':
 			parent = 1;
 			break;
@@ -402,7 +445,7 @@ int main(int argc, char **argv)
 				return EXIT_FAILURE;
 			}
 		} else {
-			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz);
+			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz, force_check_mountid);
 			if (ret)
 				return EXIT_FAILURE;
 		}
@@ -432,7 +475,7 @@ int main(int argc, char **argv)
 				return EXIT_FAILURE;
 			}
 		} else {
-			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz);
+			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz, force_check_mountid);
 			if (ret)
 				return EXIT_FAILURE;
 		}
diff --git a/tests/generic/756 b/tests/generic/756
new file mode 100755
index 000000000000..c7a82cfd25f4
--- /dev/null
+++ b/tests/generic/756
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2017 CTERA Networks. All Rights Reserved.
+# Copyright (C) 2024 Aleksa Sarai <cyphar@cyphar.com>
+#
+# FS QA Test No. 756
+#
+# Check stale handles pointing to unlinked files and non-stale handles pointing
+# to linked files while verifying that u64 mount IDs are correctly returned.
+#
+. ./common/preamble
+_begin_fstest auto quick exportfs
+
+# Import common functions.
+. ./common/filter
+
+
+# Modify as appropriate.
+_require_test
+# _require_exportfs and  already requires open_by_handle, but let's not count on it
+_require_test_program "open_by_handle"
+_require_exportfs
+# We need both STATX_MNT_ID_UNIQUE and AT_HANDLE_MNT_ID_UNIQUE.
+_require_statx_unique_mountid
+_require_open_by_handle_unique_mountid
+
+NUMFILES=1024
+testdir=$TEST_DIR/$seq-dir
+mkdir -p $testdir
+
+# Create empty test files in test dir
+create_test_files()
+{
+	local dir=$1
+
+	mkdir -p $dir
+	rm -f $dir/*
+	$here/src/open_by_handle -c $dir $NUMFILES
+}
+
+# Test encode/decode file handles
+test_file_handles()
+{
+	local dir=$1
+	local opt=$2
+
+	echo test_file_handles $* | _filter_test_dir
+	$here/src/open_by_handle $opt $dir $NUMFILES
+}
+
+# Check stale handles to deleted files
+create_test_files $testdir
+test_file_handles $testdir -Md
+
+# Check non-stale handles to linked files
+create_test_files $testdir
+test_file_handles $testdir -M
+
+# Check non-stale handles to files that were hardlinked and original deleted
+create_test_files $testdir
+test_file_handles $testdir -Ml
+test_file_handles $testdir -Mu
+
+status=0
+exit
diff --git a/tests/generic/756.out b/tests/generic/756.out
new file mode 100644
index 000000000000..48aed88d87b9
--- /dev/null
+++ b/tests/generic/756.out
@@ -0,0 +1,5 @@
+QA output created by 756
+test_file_handles TEST_DIR/756-dir -Md
+test_file_handles TEST_DIR/756-dir -M
+test_file_handles TEST_DIR/756-dir -Ml
+test_file_handles TEST_DIR/756-dir -Mu
-- 
2.46.0


