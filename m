Return-Path: <linux-fsdevel+bounces-18290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 214B58B6913
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C7CB23600
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6510A3F;
	Tue, 30 Apr 2024 03:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa0lR+B4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB310799;
	Tue, 30 Apr 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448386; cv=none; b=n67EziUvCA0t2pr6wfCcrHYAqH755oqWsuntF/ATAl1kuy2dBb8w+DqyGG4k2IJ6Qb/Js43y2nJGqw2sgrdIUWeKoNHmHDwWbEKKuYRAcJ+4E8BHoiLgIaDcFMo7X3+gHAvQNXEMgv1I1mNAu8Y1mRow5rV2e7cqU9AgV0B2SzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448386; c=relaxed/simple;
	bh=KcSzKWAujvfauQW3Rt1k36M4l5A14EnE/YGTTmeqX58=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+Qt2KMkrhW1a+EGxsURP9KUQqsWS8Tms1a70IKjnaz63Hj1EbzPAajp7+BOvhWYB3crJLIYn/IbgrMXwoEZKTxvSK2DNzLRfr100WDGnSAgbTCp1nOGdslZSx2Zd6HYzCdISSPal9qdY5ZronX13PfKsMbrDXcwBob0+u8epnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa0lR+B4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44D2C116B1;
	Tue, 30 Apr 2024 03:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448385;
	bh=KcSzKWAujvfauQW3Rt1k36M4l5A14EnE/YGTTmeqX58=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Sa0lR+B4A766PvRxEU48iW4e6k2Fw7aFevaewBcHeJKBO0HXS47BmSMvsHnLflEYu
	 azIoSACQobW5P6TICLuPbKqLwfCLQdvaX5wFJC5oDKSeYa0YuQpw0qfjAfUmV6GS93
	 hQXcPfGx1T64Z8+rccdlZFfiACtBxFR596soUBiqjMadmbdoET/k9MCQIzCjj9Dh0O
	 h0/rmwX5kzCkTDOIATl6RFv2lo7h5FPAAVpVJ3PbvpVCe0zVGUuEEoBiYz/nzUcTp9
	 kMwoG0LJ4dqn2ta8c9GY5EpIpLa6MBfY8xSX0vQtRKluhQml874z8bdJVncNyqlX9P
	 76PoAuhyibiZA==
Date: Mon, 29 Apr 2024 20:39:45 -0700
Subject: [PATCH 34/38] xfs_scrub: use MADV_POPULATE_READ to check verity files
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683629.960383.17431859183948881831.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use madvise to pull a large number of pages into the pagecache with a
single system call.  For the common case that everything is consistent,
this amortizes syscall overhead over a large amount of data.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 scrub/phase6.c |  133 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 115 insertions(+), 18 deletions(-)


diff --git a/scrub/phase6.c b/scrub/phase6.c
index 983470b7bece..7bb11510d332 100644
--- a/scrub/phase6.c
+++ b/scrub/phase6.c
@@ -25,6 +25,7 @@
 #include "libfrog/bulkstat.h"
 #include "descr.h"
 #include "progress.h"
+#include <sys/mman.h>
 
 /*
  * Phase 6: Verify data file integrity.
@@ -759,6 +760,97 @@ record_verity_success(
 	*fail_len = 0;
 }
 
+/* Map at most this many bytes at a time. */
+#define MMAP_LENGTH		(4194304)
+
+/*
+ * Use MADV_POPULATE_READ to validate verity file contents.  Returns @length if
+ * the entire region validated ok; 0 to signal to the caller that they should
+ * fall back to regular reads; or a negative errno if some other error
+ * happened.
+ */
+static ssize_t
+validate_mmap(
+	int		fd,
+	off_t		pos,
+	size_t		length)
+{
+	void		*addr;
+	int		ret;
+
+	/*
+	 * Try to map this file into the address space.  If that fails, we can
+	 * fall back to reading the file contents with read(), so collapse all
+	 * error codes to EFAULT.
+	 */
+	addr = mmap(NULL, length, PROT_READ, MAP_SHARED, fd, pos);
+	if (addr == MAP_FAILED)
+		return 0;
+
+	/* Returns EFAULT for read IO errors. */
+	ret = madvise(addr, length, MADV_POPULATE_READ);
+	if (ret) {
+		munmap(addr, length);
+		if (errno == EFAULT)
+			return 0;
+		return -errno;
+	}
+
+	ret = munmap(addr, length);
+	if (ret)
+		return -errno;
+
+	return length;
+}
+
+/*
+ * Use pread to validate verity file contents.  Returns the number of bytes
+ * validated; 0 to signal to the caller that EOF was encountered; or a negative
+ * errno if some other error happened.
+ */
+static ssize_t
+validate_pread(
+	struct scrub_ctx	*ctx,
+	struct descr		*dsc,
+	int			fd,
+	const struct stat	*statbuf,
+	off_t			pos,
+	size_t			length,
+	off_t			*fail_pos,
+	off_t			*fail_len)
+{
+	ssize_t			validated;
+
+	for (validated = 0;
+	     validated < length;
+	     validated += statbuf->st_blksize, pos += statbuf->st_blksize) {
+		char	c;
+		ssize_t	bytes_read;
+
+		bytes_read = pread(fd, &c, 1, pos);
+		if (!bytes_read)
+			break;
+		if (bytes_read > 0) {
+			record_verity_success(ctx, dsc, fail_pos, fail_len);
+			continue;
+		}
+
+		if (errno == EIO) {
+			size_t	length = min(statbuf->st_size - pos,
+					     statbuf->st_blksize);
+
+			record_verity_error(ctx, dsc, pos, length, fail_pos,
+					fail_len);
+			continue;
+		}
+
+		str_errno(ctx, descr_render(dsc));
+		return -errno;
+	}
+
+	return validated;
+}
+
 /* Scan a verity file's data looking for validation errors. */
 static void
 scan_verity_file(
@@ -770,10 +862,15 @@ scan_verity_file(
 	struct verity_file_ctx	*vf = arg;
 	struct scrub_ctx	*ctx = vf->vc->ctx;
 	off_t			pos;
+	off_t			max_map_pos;
 	off_t			fail_pos = -1, fail_len = 0;
 	int			fd;
 	int			ret;
 	DEFINE_DESCR(dsc, ctx, render_ino_from_handle);
+	static long		pagesize;
+
+	if (!pagesize)
+		pagesize = sysconf(_SC_PAGESIZE);
 
 	descr_set(&dsc, &vf->handle);
 
@@ -818,30 +915,30 @@ scan_verity_file(
 		goto out_fd;
 	}
 
-	/* Read a single byte from each block in the file to validate. */
-	for (pos = 0; pos < sb.st_size; pos += sb.st_blksize) {
-		char	c;
-		ssize_t	bytes_read;
+	/* Validate the file contents with MADV_POPULATE_READ and pread */
+	max_map_pos = roundup(sb.st_size, pagesize);
+	for (pos = 0; pos < max_map_pos; pos += MMAP_LENGTH) {
+		size_t	length = min(max_map_pos - pos, MMAP_LENGTH);
+		ssize_t	validated;
 
-		bytes_read = pread(fd, &c, 1, pos);
-		if (!bytes_read)
-			break;
-		if (bytes_read > 0) {
+		validated = validate_mmap(fd, pos, length);
+		if (validated > 0) {
 			record_verity_success(ctx, &dsc, &fail_pos, &fail_len);
-			progress_add(sb.st_blksize);
+			progress_add(validated);
 			continue;
 		}
-
-		if (errno == EIO) {
-			size_t	length = min(sb.st_size - pos, sb.st_blksize);
-
-			record_verity_error(ctx, &dsc, pos, length, &fail_pos,
-					&fail_len);
-			continue;
+		if (validated < 0) {
+			errno = -validated;
+			str_errno(ctx, descr_render(&dsc));
+			goto out_fd;
 		}
 
-		str_errno(ctx, descr_render(&dsc));
-		break;
+		validated = validate_pread(ctx, &dsc, fd, &sb, pos, length,
+				&fail_pos, &fail_len);
+		if (validated <= 0)
+			break;
+
+		progress_add(validated);
 	}
 	report_verity_error(ctx, &dsc, fail_pos, fail_len);
 


