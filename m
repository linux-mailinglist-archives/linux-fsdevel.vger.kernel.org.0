Return-Path: <linux-fsdevel+bounces-28271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C8A968C60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 18:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E69D283C84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849191C62C7;
	Mon,  2 Sep 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Vhj0QrJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922C1AB6CD;
	Mon,  2 Sep 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295607; cv=none; b=Y9Ur3+AtNMlueot3+ql/VIEzfSMTZr3fwCbBFW30legylVQXgSh6GAY2Cz1JkJAzEqSbsjdvg2oqZ+4J9pHJ1mz0rKmrgHv+M8dhuXD4yrCvpATyE6g5IQwGkxTZ7+cw02s0K70lMooc+6WEGwtKFkTKcOXZle9Df3d2qP0RyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295607; c=relaxed/simple;
	bh=3ySDphIri67ITu79vFNri2dq5x9q7K5fhocLgNYeNNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs8HKqu8BGObwp5Ys08PxZy+2hyK5woQC7YnFy+BDBBQ0MYriae936mif8cI7O+O/TgKpmSFE7XOcI9IRSmARbHfbKRB53EGy20TLLzQvcMnPNVOLcjNf0gvtAZhnZJvjIThbZhi0p0Lp95Cv2y1/G/vCeZhUyZHKWL/e8SDAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Vhj0QrJl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WyF5Y5ysYz9shr;
	Mon,  2 Sep 2024 18:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725295601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x66EuGGlz3pxlYhBctrJwxHVdTlDHq87kHTAxu/3p04=;
	b=Vhj0QrJlKTgnzyWL33d2kqM9VtDnDEU7zdhihvLq+hwjkTp+k4XbATKNA8DrG1TlIOAvwQ
	2+ptQzpaRowbs7XSze0NfjLLY/lDQUJe67LaHsSU3tAHi2yxTnjwp+hf5ExBwMiJO0fJbu
	K5TLXbx2++jtRv+G1B9uX63ZVVWilA+zyE+YtQiiPmwvUdSOw1eAw41LzjD2RaKJ26CEy3
	A12UT1UjLT/9Ru5uj+OzitrlqpfPIk0Uy84JbqOtRi0AZThTDU0N4U36oIbC4CvUgYeSvn
	DA8QHn8AT7kt3SBNW5LXgOCGU/juV/px+cnBj5EBKsag3hQ41URSSU+qWYhKGw==
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
Subject: [PATCH xfstests v2 2/2] open_by_handle: add tests for u64 mount ID
Date: Tue,  3 Sep 2024 02:45:54 +1000
Message-ID: <20240902164554.928371-2-cyphar@cyphar.com>
In-Reply-To: <20240902164554.928371-1-cyphar@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240902164554.928371-1-cyphar@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WyF5Y5ysYz9shr

Now that open_by_handle_at(2) can return u64 mount IDs, do some tests to
make sure they match properly as part of the regular open_by_handle
tests.

Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com/
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
v2:
- Remove -M argument and always do the mount ID tests. [Amir Goldstein]
- Do not error out if the kernel doesn't support STATX_MNT_ID_UNIQUE
  or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
- v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cyphar@cyphar.com/>

 src/open_by_handle.c | 128 +++++++++++++++++++++++++++++++++----------
 1 file changed, 99 insertions(+), 29 deletions(-)

diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index d9c802ca9bd1..0ad591da632e 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -86,10 +86,16 @@ Examples:
 #include <errno.h>
 #include <linux/limits.h>
 #include <libgen.h>
+#include <stdint.h>
+#include <stdbool.h>
 
 #include <sys/stat.h>
 #include "statx.h"
 
+#ifndef AT_HANDLE_MNT_ID_UNIQUE
+#	define AT_HANDLE_MNT_ID_UNIQUE 0x001
+#endif
+
 #define MAXFILES 1024
 
 struct handle {
@@ -120,6 +126,94 @@ void usage(void)
 	exit(EXIT_FAILURE);
 }
 
+int do_name_to_handle_at(const char *fname, struct file_handle *fh, int bufsz)
+{
+	int ret;
+	int mntid_short;
+
+	static bool skip_mntid_unique;
+
+	uint64_t statx_mntid_short = 0, statx_mntid_unique = 0;
+	struct statx statxbuf;
+
+	/* Get both the short and unique mount id. */
+	if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID, &statxbuf) < 0) {
+		fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", fname);
+		return EXIT_FAILURE;
+	}
+	if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
+		fprintf(stderr, "%s: no STATX_MNT_ID in stx_mask\n", fname);
+		return EXIT_FAILURE;
+	}
+	statx_mntid_short = statxbuf.stx_mnt_id;
+
+	if (!skip_mntid_unique) {
+		if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID_UNIQUE, &statxbuf) < 0) {
+			fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE): %m\n", fname);
+			return EXIT_FAILURE;
+		}
+		/*
+		 * STATX_MNT_ID_UNIQUE was added fairly recently in Linux 6.8, so if the
+		 * kernel doesn't give us a unique mount ID just skip it.
+		 */
+		if ((skip_mntid_unique |= !(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE)))
+			printf("statx(STATX_MNT_ID_UNIQUE) not supported by running kernel -- skipping unique mount ID test\n");
+		else
+			statx_mntid_unique = statxbuf.stx_mnt_id;
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
+	if (mntid_short != (int) statx_mntid_short) {
+		fprintf(stderr, "%s: name_to_handle_at returned a different mount ID to STATX_MNT_ID: %u != %lu\n", fname, mntid_short, statx_mntid_short);
+		return EXIT_FAILURE;
+	}
+
+	if (!skip_mntid_unique && statx_mntid_unique != 0) {
+		struct handle dummy_fh;
+		uint64_t mntid_unique = 0;
+
+		/*
+		 * Get the unique mount ID. We don't need to get another copy of the
+		 * handle so store it in a dummy struct.
+		 */
+		dummy_fh.fh.handle_bytes = fh->handle_bytes;
+		ret = name_to_handle_at(AT_FDCWD, fname, &dummy_fh.fh, (int *) &mntid_unique, AT_HANDLE_MNT_ID_UNIQUE);
+		if (ret < 0) {
+			if (errno != EINVAL) {
+				fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE): %m\n", fname);
+				return EXIT_FAILURE;
+			}
+			/*
+			 * EINVAL means AT_HANDLE_MNT_ID_UNIQUE is not supported, so skip
+			 * the check in that case.
+			 */
+			printf("name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) not supported by running kernel -- skipping unique mount ID test\n");
+			skip_mntid_unique = true;
+		} else {
+			if (mntid_unique != statx_mntid_unique) {
+				fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) returned a different mount ID to STATX_MNT_ID_UNIQUE: %lu != %lu\n", fname, mntid_unique, statx_mntid_unique);
+				return EXIT_FAILURE;
+			}
+		}
+	}
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int	i, c;
@@ -132,7 +226,7 @@ int main(int argc, char **argv)
 	char	fname2[PATH_MAX];
 	char	*test_dir;
 	char	*mount_dir;
-	int	mount_fd, mount_id;
+	int	mount_fd;
 	char	*infile = NULL, *outfile = NULL;
 	int	in_fd = 0, out_fd = 0;
 	int	numfiles = 1;
@@ -307,21 +401,9 @@ int main(int argc, char **argv)
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
+			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz);
+			if (ret < 0)
 				return EXIT_FAILURE;
-			}
 		}
 		if (keepopen) {
 			/* Open without close to keep unlinked files around */
@@ -349,21 +431,9 @@ int main(int argc, char **argv)
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
+			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz);
+			if (ret < 0)
 				return EXIT_FAILURE;
-			}
 		}
 		if (out_fd) {
 			ret = write(out_fd, (char *)&dir_handle, sizeof(*handle));
-- 
2.46.0


