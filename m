Return-Path: <linux-fsdevel+bounces-28610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2D196C5E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A928597D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78E1E201E;
	Wed,  4 Sep 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="xveeOLsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314821D88BF;
	Wed,  4 Sep 2024 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472657; cv=none; b=B3vAKaExqNPMOjmjX2jG23Jm1SFD7iL26ICUh1HAwzBVpU3m845jxbHok5xDrENaio5jnq7/5CHVniTKOQzCzK/mdfJX6HUOxXvHc+CqVcYgIvvSQk98fzd80xeaRBRCwkbMoUAHtJZLuNIkK6eJ+nJepJuolLfR5QIkZHnwpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472657; c=relaxed/simple;
	bh=mbQY96fadVQKkjHHDNLTX6VsbwYFPIbMrxRflrgLvtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxtci1kG8sx8RZHB9upv653zr4ZeoZvOpFAJtb0aSWLnEHcBDr2w+j8ncFOmv95c76K+VyOyX1dBu3XGiVB6WGOizelOBGNEcdf1tsC/NzXuPUJ9rabupcu8QhpXDOtdtUb0BzOTNcXg5d5MeQePQQtPrrMPbSn0jCTdEuvbp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=xveeOLsd; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WzVZM3J95z9smd;
	Wed,  4 Sep 2024 19:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725472651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFUBWsaEsbT6fgvvkMDEobts6P4xhFg/DI3+nLRIuE8=;
	b=xveeOLsdV0mNwm5U0y3Le5j+3JxdEypTapn/qxTkyOI+ebtNwyEqlYP5pxtMlQ/d+2rhq1
	WTRwa+rkNiH6suiQDathT31BGPfO/NMp+o+9JLY5zzULIpb8tz9PuXgBTJ7ikZI6T1WJ/5
	dGoe9HA3L4Y7jmUEL8Gh7hZb+Ly84eLGSaC9WcsnXUt/QK3bmhnvM/ueXAvvaHEnF0wq8J
	eAcXcrAWUvZiYhCpD1F/fx4/kx2pxW3DRZyqFdRxYNIh9gbpc4M7e4oA1h50mOZ3FudXuV
	JnhDE2VGDFxgHLliLkXon0l9PdurpuzexUSoDDdbkNesMVFXUexp5vrgCGfxfQ==
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
Subject: [PATCH xfstests v3 2/2] generic/756: test name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) explicitly
Date: Thu,  5 Sep 2024 03:56:38 +1000
Message-ID: <20240904175639.2269694-2-cyphar@cyphar.com>
In-Reply-To: <20240904175639.2269694-1-cyphar@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240904175639.2269694-1-cyphar@cyphar.com>
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
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 common/rc             | 24 ++++++++++++++++
 src/open_by_handle.c  | 63 ++++++++++++++++++++++++++++++++++-------
 tests/generic/756     | 65 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/756.out |  5 ++++
 4 files changed, 147 insertions(+), 10 deletions(-)
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
index 920ec7d9170b..b5c1a30abbbc 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -106,9 +106,11 @@ struct handle {
 
 void usage(void)
 {
-	fprintf(stderr, "usage: open_by_handle [-cludmrwapknhs] [<-i|-o> <handles_file>] <test_dir> [num_files]\n");
+	fprintf(stderr, "usage: open_by_handle [-cludmMrwapknhs] [<-i|-o> <handles_file>] <test_dir> [num_files]\n");
+	fprintf(stderr, "       open_by_handle -C <feature>\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N test files under test_dir, try to get file handles and exit\n");
+	fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N test files under test_dir, try to get file handles and exit\n");
 	fprintf(stderr, "open_by_handle    <test_dir> [N] - get file handles of test files, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -n <test_dir> [N] - get file handles of test files and try to open by handle without drop caches\n");
 	fprintf(stderr, "open_by_handle -k <test_dir> [N] - get file handles of files that are kept open, drop caches and try to open by handle\n");
@@ -117,19 +119,23 @@ void usage(void)
 	fprintf(stderr, "open_by_handle -a <test_dir> [N] - write data to test files after open by handle\n");
 	fprintf(stderr, "open_by_handle -l <test_dir> [N] - create hardlinks to test files, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -u <test_dir> [N] - unlink (hardlinked) test files, drop caches and try to open by handle\n");
-	fprintf(stderr, "open_by_handle -U <test_dir> [N] - verify the mount ID returned with AT_HANDLE_MNT_ID_UNIQUE is correct\n");
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
@@ -145,10 +151,15 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
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
@@ -160,10 +171,15 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
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
@@ -204,6 +220,10 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
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
@@ -216,6 +236,22 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
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
@@ -235,16 +271,20 @@ int main(int argc, char **argv)
 	int	create = 0, delete = 0, nlink = 1, move = 0;
 	int	rd = 0, wr = 0, wrafter = 0, parent = 0;
 	int	keepopen = 0, drop_caches = 1, sleep_loop = 0;
+	int force_check_mountid = 0;
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
@@ -271,6 +311,9 @@ int main(int argc, char **argv)
 		case 'm':
 			move = 1;
 			break;
+		case 'M':
+			force_check_mountid = 1;
+			break;
 		case 'p':
 			parent = 1;
 			break;
@@ -403,7 +446,7 @@ int main(int argc, char **argv)
 				return EXIT_FAILURE;
 			}
 		} else {
-			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz);
+			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz, force_check_mountid);
 			if (ret)
 				return EXIT_FAILURE;
 		}
@@ -433,7 +476,7 @@ int main(int argc, char **argv)
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


