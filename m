Return-Path: <linux-fsdevel+bounces-28629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97FA96C7E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 21:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9162C285B4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE481E766E;
	Wed,  4 Sep 2024 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ZENjZ5lt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1940C03;
	Wed,  4 Sep 2024 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479326; cv=none; b=tc22VSQcTj9vkGOEbyyKORhncwqpxVYK5akx6ij8feIShlzhLj6Z2X10CX/0An9KOa8Z8eg0x9+/eyF+zRfw4tPffhJpriKetPi/M0yrTj//9nH1VJWBc+iZJY3l7zKY3xx8vumJaZmgTdIb5KZQttqfBI6WwkiKdwcPWQw27QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479326; c=relaxed/simple;
	bh=+BEzFkMA6X18VDv8VAVAuyHtyNyqRK56bhKY4sqG7NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ple1WRfOnY9laoNi2+Xcgzub5ELlQoVUqhSz4lhPNR6GV9ATqP7o0ePKurOENxYBakduXG4453mJBNHBBQyy36lCRigjOkI3SUNlo6X3BO3Te8fIH/heazdI/+WRTbi9WqeuEh/QKs1tM3rdyj4GiocqQwCLoDZNc/rEgkQQUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ZENjZ5lt; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WzY2c36W2z9stH;
	Wed,  4 Sep 2024 21:48:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725479320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aa3h7uu8Ajlu4C0h74xCDfvRf6u0K/78nks73Z7uTQ=;
	b=ZENjZ5ltRRW2mVE/uEP7sPhsxUMwIvZEWWx7mBubRfp3OSwfT1xNE61hjtagcumBACTR/q
	wDE2uQwLwvqroxpzhrpCuCaY9Js8VyaZ+eu9aj6DbIVCFnh+7BK+jnqhFMmZb94nPYn5Ms
	+WIDvOlFdCS2q1k6/ojBjCNRO7eDjd+eo45XnB+uECk7eewp21lm+7IfHlIz6KxnkYQV3S
	TxTvEKQSo6+qG++ZX4LvzhtVtIVZL/3pZ3nhvwQWyVCj70uKY9F1mal0y7atve1nc/9dn9
	S0c4Zt0JLU+7kCGUWc52+s8Oy80EvUguri24cUZtA+dIuPLm8UmifyOorfT/Nw==
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
Subject: [PATCH xfstests v4 1/2] open_by_handle: verify u32 and u64 mount IDs
Date: Thu,  5 Sep 2024 05:48:22 +1000
Message-ID: <20240904194823.2456471-1-cyphar@cyphar.com>
In-Reply-To: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that open_by_handle_at(2) can return u64 mount IDs, do some tests to
make sure they match properly as part of the regular open_by_handle
tests. Also, add automatic tests for the old u32 mount IDs as well.

By default, we do mount ID checks but silently skip the tests if the
syscalls are not supported by the running kernel (to ensure the tests
continue to work for old kernels). We will add some tests explicitly
checking the new features (with no silent skipping) in a future patch.

The u32 mount ID tests require STATX_MNT_ID (Linux 5.8), while the u64
mount ID tests require STATX_MNT_ID_UNIQUE (Linux 6.9) and
AT_HANDLE_MNT_ID_UNIQUE (linux-next).

Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com/
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changed in v4:
- Fix minor flub in patch split. [Amir Goldstein]
- v3: <https://lore.kernel.org/all/20240904175639.2269694-1-cyphar@cyphar.com/>
Changed in v3:
- Make skipping completely silent in regular open_by_handle mode. [Amir Goldstein]
- Re-add -M to turn skipping into errors and add a new test that uses
  -M, but is skipped on older kernels. [Amir Goldstein]
- v2: <https://lore.kernel.org/all/20240902164554.928371-1-cyphar@cyphar.com/>
Changed in v2:
- Remove -M argument and always do the mount ID tests. [Amir Goldstein]
- Do not error out if the kernel doesn't support STATX_MNT_ID_UNIQUE
  or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
- v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cyphar@cyphar.com/>
---
 src/open_by_handle.c | 131 +++++++++++++++++++++++++++++++++----------
 1 file changed, 102 insertions(+), 29 deletions(-)

diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index 0f74ed08b1f0..dcbcd35561fb 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -87,6 +87,15 @@ Examples:
 #include <errno.h>
 #include <linux/limits.h>
 #include <libgen.h>
+#include <stdint.h>
+#include <stdbool.h>
+
+#include <sys/stat.h>
+#include "statx.h"
+
+#ifndef AT_HANDLE_MNT_ID_UNIQUE
+#	define AT_HANDLE_MNT_ID_UNIQUE 0x001
+#endif
 
 #define MAXFILES 1024
 
@@ -118,6 +127,94 @@ void usage(void)
 	exit(EXIT_FAILURE);
 }
 
+static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
+				int bufsz)
+{
+	int ret;
+	int mntid_short;
+
+	static bool skip_mntid, skip_mntid_unique;
+
+	uint64_t statx_mntid_short = 0, statx_mntid_unique = 0;
+	struct statx statxbuf;
+
+	/* Get both the short and unique mount id. */
+	if (!skip_mntid) {
+		if (xfstests_statx(AT_FDCWD, fname, 0, STATX_MNT_ID, &statxbuf) < 0) {
+			fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", fname);
+			return EXIT_FAILURE;
+		}
+		if (!(statxbuf.stx_mask & STATX_MNT_ID))
+			skip_mntid = true;
+		else
+			statx_mntid_short = statxbuf.stx_mnt_id;
+	}
+
+	if (!skip_mntid_unique) {
+		if (xfstests_statx(AT_FDCWD, fname, 0, STATX_MNT_ID_UNIQUE, &statxbuf) < 0) {
+			fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE): %m\n", fname);
+			return EXIT_FAILURE;
+		}
+		/*
+		 * STATX_MNT_ID_UNIQUE was added fairly recently in Linux 6.8, so if the
+		 * kernel doesn't give us a unique mount ID just skip it.
+		 */
+		if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE))
+			skip_mntid_unique = true;
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
+	if (!skip_mntid) {
+		if (mntid_short != (int) statx_mntid_short) {
+			fprintf(stderr, "%s: name_to_handle_at returned a different mount ID to STATX_MNT_ID: %u != %lu\n", fname, mntid_short, statx_mntid_short);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (!skip_mntid_unique) {
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
+			/* EINVAL means AT_HANDLE_MNT_ID_UNIQUE is not supported */
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
@@ -130,7 +227,7 @@ int main(int argc, char **argv)
 	char	fname2[PATH_MAX];
 	char	*test_dir;
 	char	*mount_dir;
-	int	mount_fd, mount_id;
+	int	mount_fd;
 	char	*infile = NULL, *outfile = NULL;
 	int	in_fd = 0, out_fd = 0;
 	int	numfiles = 1;
@@ -305,21 +402,9 @@ int main(int argc, char **argv)
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
+			if (ret)
 				return EXIT_FAILURE;
-			}
 		}
 		if (keepopen) {
 			/* Open without close to keep unlinked files around */
@@ -347,21 +432,9 @@ int main(int argc, char **argv)
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
+			if (ret)
 				return EXIT_FAILURE;
-			}
 		}
 		if (out_fd) {
 			ret = write(out_fd, (char *)&dir_handle, sizeof(*handle));
-- 
2.46.0


