Return-Path: <linux-fsdevel+bounces-27547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C253962516
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAED31F21F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DA416CD10;
	Wed, 28 Aug 2024 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="d1A+Xs8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4A16C861;
	Wed, 28 Aug 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841479; cv=none; b=TQ4h3mYX2PDK7D0U+KQbj3IQ9gVNWuXY3R4/vlfmVitVMw8v1mBt5LE/5Uix0ren9xpeIFyM4OL6dEUcZuyqKL/xPkK8Rzi+0Wf/H51pRqWJWCBB1AoqMiCmnzjqEXqgi2u/5ywCDUMSHSR7sSVEvNkEHTpDZpmRBXjqRkoXB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841479; c=relaxed/simple;
	bh=YdcqY5tgN8I1+euhAExoLF6sEwGEa0TNIA91ZtOieag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4q3+Oh2PM7fvJCmUcWNLCmWB6KNdYrI15NpGXHDRCVm4iSETPTOLjDU9JObs9n2EawQu/EiOh6fzh/+IYSyhGocvTLFZ9VWJdXnAN6r9LuPKrHKG2OCcWwq9/RiWMDKvFR3ROIZTSAdRqKFCJtIn7SwFbsF1q7Vik8EXQKRMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=d1A+Xs8T; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wv18K2hlNz9stc;
	Wed, 28 Aug 2024 12:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1724841473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7u6iBKqUG9uM2FWmeYhcmGQ4DZ/GsUGK3jSWortZbM=;
	b=d1A+Xs8TukzNKWusd/04hdfSMpjYdggb9hM/i/IsrFkLKfh1M8h4LKD8R88Tab1wiHV67y
	zE341Esy3Y4HNyhTnMbV6JTCF8bsFlij7+0eemCSd5HIB6UBnbLrePvYzjrZPtq4MICI+9
	8nFQ9Kpq0RmmrRDXn6PPAb0nZQblx3OEWq9miAxf9JqgORFnfXWRFaKd/WzWkBzV5aZtrk
	iK6ghkG81ZUd+W01HVdvaWBU+aEy9YCdMaIEe+cTvh6iiugxoKaoiyepSeCTQAgQBx5HWx
	/bnO0zX1Xr7dUhhxXlShXXA/IHBlBieaOykO/SPxvs16dijf3P1NdR+H1BxObg==
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
Subject: [PATCH xfstests v1 2/2] open_by_handle: add tests for u64 mount ID
Date: Wed, 28 Aug 2024 20:37:06 +1000
Message-ID: <20240828103706.2393267-2-cyphar@cyphar.com>
In-Reply-To: <20240828103706.2393267-1-cyphar@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240828103706.2393267-1-cyphar@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Wv18K2hlNz9stc

Now that open_by_handle_at(2) can return u64 mount IDs, do some tests to
make sure they match properly as part of the regular open_by_handle
tests.

Link: https://lore.kernel.org/all/20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com/
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 src/open_by_handle.c | 123 ++++++++++++++++++++++++++++++++-----------
 tests/generic/426    |   1 +
 2 files changed, 93 insertions(+), 31 deletions(-)

diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index d9c802ca9bd1..cbd68aeadac1 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -86,10 +86,15 @@ Examples:
 #include <errno.h>
 #include <linux/limits.h>
 #include <libgen.h>
+#include <stdint.h>
 
 #include <sys/stat.h>
 #include "statx.h"
 
+#ifndef AT_HANDLE_MNT_ID_UNIQUE
+#	define AT_HANDLE_MNT_ID_UNIQUE 0x001
+#endif
+
 #define MAXFILES 1024
 
 struct handle {
@@ -99,7 +104,7 @@ struct handle {
 
 void usage(void)
 {
-	fprintf(stderr, "usage: open_by_handle [-cludmrwapknhs] [<-i|-o> <handles_file>] <test_dir> [num_files]\n");
+	fprintf(stderr, "usage: open_by_handle [-cludMmrwapknhs] [<-i|-o> <handles_file>] <test_dir> [num_files]\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N test files under test_dir, try to get file handles and exit\n");
 	fprintf(stderr, "open_by_handle    <test_dir> [N] - get file handles of test files, drop caches and try to open by handle\n");
@@ -111,6 +116,7 @@ void usage(void)
 	fprintf(stderr, "open_by_handle -l <test_dir> [N] - create hardlinks to test files, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -u <test_dir> [N] - unlink (hardlinked) test files, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test files and hardlinks, drop caches and try to open by handle\n");
+	fprintf(stderr, "open_by_handle -M <test_dir> [N] - confirm that the mount id returned by name_to_handle_at matches the mount id in statx\n");
 	fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test files, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -p <test_dir>     - create/delete and try to open by handle also test_dir itself\n");
 	fprintf(stderr, "open_by_handle -i <handles_file> <test_dir> [N] - read test files handles from file and try to open by handle\n");
@@ -120,6 +126,81 @@ void usage(void)
 	exit(EXIT_FAILURE);
 }
 
+int do_name_to_handle_at(const char *fname, struct file_handle *fh, int bufsz,
+			 int checkmountid)
+{
+	int ret;
+	int mntid_short;
+
+	uint64_t mntid_unique;
+	uint64_t statx_mntid_short = 0, statx_mntid_unique = 0;
+	struct handle dummy_fh;
+
+	if (checkmountid) {
+		struct statx statxbuf;
+
+		/* Get both the short and unique mount id. */
+		if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID, &statxbuf) < 0) {
+			fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", fname);
+			return EXIT_FAILURE;
+		}
+		if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
+			fprintf(stderr, "%s: no STATX_MNT_ID in stx_mask\n", fname);
+			return EXIT_FAILURE;
+		}
+		statx_mntid_short = statxbuf.stx_mnt_id;
+
+		if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID_UNIQUE, &statxbuf) < 0) {
+			fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE): %m\n", fname);
+			return EXIT_FAILURE;
+		}
+		if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE)) {
+			fprintf(stderr, "%s: no STATX_MNT_ID_UNIQUE in stx_mask\n", fname);
+			return EXIT_FAILURE;
+		}
+		statx_mntid_unique = statxbuf.stx_mnt_id;
+	}
+
+	fh->handle_bytes = bufsz;
+	ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
+	if (bufsz < fh->handle_bytes) {
+		/* Query the filesystem required bufsz and the file handle */
+		if (ret != -1 || errno != EOVERFLOW) {
+			fprintf(stderr, "%s: unexpected result from name_to_handle_at: %d (%m)\n", fname, ret);
+			return EXIT_FAILURE;
+		}
+		ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
+	}
+	if (ret < 0) {
+		fprintf(stderr, "%s: name_to_handle: %m\n", fname);
+		return EXIT_FAILURE;
+	}
+
+	if (checkmountid) {
+		if (mntid_short != (int) statx_mntid_short) {
+			fprintf(stderr, "%s: name_to_handle_at returned a different mount ID to STATX_MNT_ID: %u != %lu\n", fname, mntid_short, statx_mntid_short);
+			return EXIT_FAILURE;
+		}
+
+		/*
+		 * Get the unique mount ID. We don't need to get another copy of the
+		 * handle so store it in a dummy struct.
+		 */
+		dummy_fh.fh.handle_bytes = fh->handle_bytes;
+		if (name_to_handle_at(AT_FDCWD, fname, &dummy_fh.fh, (int *) &mntid_unique, AT_HANDLE_MNT_ID_UNIQUE) < 0) {
+			fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE): %m\n", fname);
+			return EXIT_FAILURE;
+		}
+
+		if (mntid_unique != statx_mntid_unique) {
+			fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) returned a different mount ID to STATX_MNT_ID_UNIQUE: %lu != %lu\n", fname, mntid_unique, statx_mntid_unique);
+			return EXIT_FAILURE;
+		}
+	}
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int	i, c;
@@ -132,19 +213,20 @@ int main(int argc, char **argv)
 	char	fname2[PATH_MAX];
 	char	*test_dir;
 	char	*mount_dir;
-	int	mount_fd, mount_id;
+	int	mount_fd;
 	char	*infile = NULL, *outfile = NULL;
 	int	in_fd = 0, out_fd = 0;
 	int	numfiles = 1;
 	int	create = 0, delete = 0, nlink = 1, move = 0;
 	int	rd = 0, wr = 0, wrafter = 0, parent = 0;
 	int	keepopen = 0, drop_caches = 1, sleep_loop = 0;
+	int	checkmountid = 0;
 	int	bufsz = MAX_HANDLE_SZ;
 
 	if (argc < 2)
 		usage();
 
-	while ((c = getopt(argc, argv, "cludmrwapknhi:o:sz")) != -1) {
+	while ((c = getopt(argc, argv, "cludMmrwapknhi:o:sz")) != -1) {
 		switch (c) {
 		case 'c':
 			create = 1;
@@ -172,6 +254,9 @@ int main(int argc, char **argv)
 			delete = 1;
 			nlink = 0;
 			break;
+		case 'M':
+			checkmountid = 1;
+			break;
 		case 'm':
 			move = 1;
 			break;
@@ -307,21 +392,9 @@ int main(int argc, char **argv)
 				return EXIT_FAILURE;
 			}
 		} else {
-			handle[i].fh.handle_bytes = bufsz;
-			ret = name_to_handle_at(AT_FDCWD, fname, &handle[i].fh, &mount_id, 0);
-			if (bufsz < handle[i].fh.handle_bytes) {
-				/* Query the filesystem required bufsz and the file handle */
-				if (ret != -1 || errno != EOVERFLOW) {
-					fprintf(stderr, "Unexpected result from name_to_handle_at(%s)\n", fname);
-					return EXIT_FAILURE;
-				}
-				ret = name_to_handle_at(AT_FDCWD, fname, &handle[i].fh, &mount_id, 0);
-			}
-			if (ret < 0) {
-				strcat(fname, ": name_to_handle");
-				perror(fname);
+			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz, checkmountid);
+			if (ret < 0)
 				return EXIT_FAILURE;
-			}
 		}
 		if (keepopen) {
 			/* Open without close to keep unlinked files around */
@@ -349,21 +422,9 @@ int main(int argc, char **argv)
 				return EXIT_FAILURE;
 			}
 		} else {
-			dir_handle.fh.handle_bytes = bufsz;
-			ret = name_to_handle_at(AT_FDCWD, test_dir, &dir_handle.fh, &mount_id, 0);
-			if (bufsz < dir_handle.fh.handle_bytes) {
-				/* Query the filesystem required bufsz and the file handle */
-				if (ret != -1 || errno != EOVERFLOW) {
-					fprintf(stderr, "Unexpected result from name_to_handle_at(%s)\n", dname);
-					return EXIT_FAILURE;
-				}
-				ret = name_to_handle_at(AT_FDCWD, test_dir, &dir_handle.fh, &mount_id, 0);
-			}
-			if (ret < 0) {
-				strcat(dname, ": name_to_handle");
-				perror(dname);
+			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz, checkmountid);
+			if (ret < 0)
 				return EXIT_FAILURE;
-			}
 		}
 		if (out_fd) {
 			ret = write(out_fd, (char *)&dir_handle, sizeof(*handle));
diff --git a/tests/generic/426 b/tests/generic/426
index 25909f220e1e..df481c58562c 100755
--- a/tests/generic/426
+++ b/tests/generic/426
@@ -51,6 +51,7 @@ test_file_handles $testdir -d
 # Check non-stale handles to linked files
 create_test_files $testdir
 test_file_handles $testdir
+test_file_handles $testdir -M
 
 # Check non-stale handles to files that were hardlinked and original deleted
 create_test_files $testdir
-- 
2.46.0


