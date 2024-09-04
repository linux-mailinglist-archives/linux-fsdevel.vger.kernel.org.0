Return-Path: <linux-fsdevel+bounces-28609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A8596C5DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629B91F2218C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6841E1A33;
	Wed,  4 Sep 2024 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="mnlocwHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059C1D88BF;
	Wed,  4 Sep 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472648; cv=none; b=J4EkL5S9VvQGQZbrLYEMlpaAmSWwehl27+XwThtCZRJogyFQEo9t5+z1kaX1R/elUE/5DYUk+sSiMaXJUayvOp7ZQMAw9gKuP6qwJjATrJwCCaRKe/GbNGTU2BpXJgEggGSxPTEPDuO3tNiJTRcEZCrA2GoQaIXcuBgliJ99qhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472648; c=relaxed/simple;
	bh=f0rWgWl3Jbp67vtePZy9hnee39Eahoe856cAV6S3LSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wz69aRGKKCLlBUpbhR0/OFKlWWI0lGrgGNQ+wBlKcJjyPAbCmi9wsEyc/TgNO2I4W7+WDwckvXWNmei1pdp9ci5Tog3k6FnwZv6i5G+hdUtJEI71XA7lQwqOBdZMAqHk323Aq3ay+VyVrFpu+NewjKQhtABIBOBMcTcZEQ/qFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=mnlocwHO; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WzVZ81MZzz9sdW;
	Wed,  4 Sep 2024 19:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725472640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ybZuNM9wO8duPmiRVKL3f0gGJvGPSGKvN0cowgJxlI=;
	b=mnlocwHO8KlVsvYz9JsdPbgkYAQao0Vlb9GCFJB4oIhTP8UA8Du2vhgelNPk84xZh6SdQl
	iMz9b6Ia9CTdAvqU3tGBMt1zbeCTBAWm5e7210bwjabWQYWhBxCiQz2jSKNc7fYrm6r7kT
	M4jpDiZFZgPcR97DS9z2RDFTEM4Jbw+syLmTKif55L4KEm+Zvb7PnIvhDC6d101cQqD2nX
	17KFMLxAm56djjw9IfsNK5lh+CuPTnnAlT/pyRBe5KxMsWhN9nYqiDCG2a7oboXxgpfojp
	baKL2vlmXo0vF2pocgNtjugiw7D+J9bMM2MFR6UNXF2ySV5USRODeVaaK/OMUA==
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
Subject: [PATCH xfstests v3 1/2] open_by_handle: verify u32 and u64 mount IDs
Date: Thu,  5 Sep 2024 03:56:37 +1000
Message-ID: <20240904175639.2269694-1-cyphar@cyphar.com>
In-Reply-To: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WzVZ81MZzz9sdW

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
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
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
 src/open_by_handle.c | 132 +++++++++++++++++++++++++++++++++----------
 1 file changed, 103 insertions(+), 29 deletions(-)

diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index 0f74ed08b1f0..920ec7d9170b 100644
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
 
@@ -108,6 +117,7 @@ void usage(void)
 	fprintf(stderr, "open_by_handle -a <test_dir> [N] - write data to test files after open by handle\n");
 	fprintf(stderr, "open_by_handle -l <test_dir> [N] - create hardlinks to test files, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -u <test_dir> [N] - unlink (hardlinked) test files, drop caches and try to open by handle\n");
+	fprintf(stderr, "open_by_handle -U <test_dir> [N] - verify the mount ID returned with AT_HANDLE_MNT_ID_UNIQUE is correct\n");
 	fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test files and hardlinks, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test files, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -p <test_dir>     - create/delete and try to open by handle also test_dir itself\n");
@@ -118,6 +128,94 @@ void usage(void)
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
@@ -130,7 +228,7 @@ int main(int argc, char **argv)
 	char	fname2[PATH_MAX];
 	char	*test_dir;
 	char	*mount_dir;
-	int	mount_fd, mount_id;
+	int	mount_fd;
 	char	*infile = NULL, *outfile = NULL;
 	int	in_fd = 0, out_fd = 0;
 	int	numfiles = 1;
@@ -305,21 +403,9 @@ int main(int argc, char **argv)
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
@@ -347,21 +433,9 @@ int main(int argc, char **argv)
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


