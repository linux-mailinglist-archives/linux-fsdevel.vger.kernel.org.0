Return-Path: <linux-fsdevel+bounces-18289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDCD8B6911
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932401C21B1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339910A36;
	Tue, 30 Apr 2024 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deC0I+1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A4DDA6;
	Tue, 30 Apr 2024 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448371; cv=none; b=Or7D70qJHmqVXogChBl3Fcw/8UIyqLS7maHPstiXhjb/JQXsHJkZCGZYneAVhsgWMpvXtcLQKLKDVoReReg1g4r9aiRq/rXrVXw71fdmv85cdncIQE2mIYKiyV/NG3mrCTkeaSBCBWLa42yVPd6K8ra0InQdGvbNlEaqE1DntOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448371; c=relaxed/simple;
	bh=cTbykhDLnR4c1cnrmCzZrdQTHUSD8m9a0dezxLky73o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrXePuntuHC02JwOMxoiJN2AnIszHVQA6UpAvMdFtwYl8YfeeuQAZi53BWm4IKcmxK+A1wGYtpR5V0Fsfe19WTmQGG+3VBFycFUOLkY8Xkm31phn7QxAcnu3jDWwtfMZlMudZluIhYLzCi30srX91QZhWdAuNeoDxCtL6QhAob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deC0I+1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17029C116B1;
	Tue, 30 Apr 2024 03:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448370;
	bh=cTbykhDLnR4c1cnrmCzZrdQTHUSD8m9a0dezxLky73o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=deC0I+1C9BF1S5a2J8HP2DIarjQLGRyEt3Wa7bfEugKglUD5OllXUQ/luy5bbE2jE
	 fZybGfVbALkXcqEZqqBB6ygoiTGsUiBEv+Oxtu5bVGuMdMcgcqUKakWne1TdJXeQUB
	 qllGEpLRnSw8vb+etCNOZxs1vLGCamlYwuNn+KSCZe8OTPYuUMVjbIdPDDZdWGh++k
	 AMHuP/8sbMzq2oK88E17EcVIJ6ipZCWzUtZJvt2xP1u5lteyGOb/64gPxCC4cumuYO
	 6VeV8XiJl5AV9ag+JafsA5YItYvjhv2Tb9xN/mWnmzrGgyG+d4hcsuOj5Jl6QwQjGm
	 Bbzq3fgimKLow==
Date: Mon, 29 Apr 2024 20:39:29 -0700
Subject: [PATCH 33/38] xfs_scrub: validate verity file contents when doing a
 media scan
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683613.960383.9616089814402935985.stgit@frogsfrogsfrogs>
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

Augment the media scan when verity files are detected by reading those
files' pagecache to force verity to compare the hash and (optional)
signatures.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 scrub/phase6.c |  305 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 305 insertions(+)


diff --git a/scrub/phase6.c b/scrub/phase6.c
index de7fcb548fe6..983470b7bece 100644
--- a/scrub/phase6.c
+++ b/scrub/phase6.c
@@ -23,6 +23,8 @@
 #include "vfs.h"
 #include "common.h"
 #include "libfrog/bulkstat.h"
+#include "descr.h"
+#include "progress.h"
 
 /*
  * Phase 6: Verify data file integrity.
@@ -34,6 +36,9 @@
  * to tell us if metadata are now corrupt.  Otherwise, we'll scan the
  * whole directory tree looking for files that overlap the bad regions
  * and report the paths of the now corrupt files.
+ *
+ * If the filesystem supports verity, read the contents of each verity file to
+ * force it to validate the file contents.
  */
 
 /* Verify disk blocks with GETFSMAP */
@@ -674,6 +679,285 @@ remember_ioerr(
 		str_liberror(ctx, ret, _("setting bad block bitmap"));
 }
 
+struct verity_ctx {
+	struct scrub_ctx	*ctx;
+	struct workqueue	wq_ddev;
+	struct workqueue	wq_rtdev;
+	bool			aborted;
+};
+
+struct verity_file_ctx {
+	struct xfs_handle	handle;
+	struct verity_ctx	*vc;
+};
+
+static int
+render_ino_from_handle(
+	struct scrub_ctx	*ctx,
+	char			*buf,
+	size_t			buflen,
+	void			*data)
+{
+	struct xfs_handle	*han = data;
+
+	return scrub_render_ino_descr(ctx, buf, buflen, han->ha_fid.fid_ino,
+			han->ha_fid.fid_gen, NULL);
+}
+
+static inline void
+report_verity_error(
+	struct scrub_ctx	*ctx,
+	struct descr		*dsc,
+	off_t			fail_pos,
+	off_t			fail_len)
+{
+	if (fail_pos < 0)
+		return;
+
+	str_unfixable_error(ctx, descr_render(dsc),
+ _("verity error at offsets %llu-%llu"),
+			(unsigned long long)fail_pos,
+			(unsigned long long)(fail_pos + fail_len - 1));
+}
+
+/* Record a verity validation error and maybe log an old error. */
+static inline void
+record_verity_error(
+	struct scrub_ctx	*ctx,
+	struct descr		*dsc,
+	off_t			pos,
+	size_t			len,
+	off_t			*fail_pos,
+	off_t			*fail_len)
+{
+	if (*fail_pos < 0)
+		goto record;
+
+	if (pos == *fail_pos + *fail_len) {
+		*fail_len += len;
+		return;
+	}
+
+	report_verity_error(ctx, dsc, *fail_pos, *fail_len);
+record:
+	*fail_pos = pos;
+	*fail_len = len;
+}
+
+/* Record a verity validation success and maybe log an old error. */
+static inline void
+record_verity_success(
+	struct scrub_ctx	*ctx,
+	struct descr		*dsc,
+	off_t			*fail_pos,
+	off_t			*fail_len)
+{
+	if (*fail_pos >= 0)
+		report_verity_error(ctx, dsc, *fail_pos, *fail_len);
+
+	*fail_pos = -1;
+	*fail_len = 0;
+}
+
+/* Scan a verity file's data looking for validation errors. */
+static void
+scan_verity_file(
+	struct workqueue	*wq,
+	uint32_t		index,
+	void			*arg)
+{
+	struct stat		sb;
+	struct verity_file_ctx	*vf = arg;
+	struct scrub_ctx	*ctx = vf->vc->ctx;
+	off_t			pos;
+	off_t			fail_pos = -1, fail_len = 0;
+	int			fd;
+	int			ret;
+	DEFINE_DESCR(dsc, ctx, render_ino_from_handle);
+
+	descr_set(&dsc, &vf->handle);
+
+	if (vf->vc->aborted) {
+		ret = ECANCELED;
+		goto out_vf;
+	}
+
+	fd = scrub_open_handle(&vf->handle);
+	if (fd < 0) {
+		/*
+		 * Stale file handle means that the verity file is gone.
+		 *
+		 * Even if there's a replacement file, its contents have been
+		 * freshly written and checked.  Either way, we can skip
+		 * scanning this file.
+		 */
+		if (errno == ESTALE) {
+			ret = 0;
+			goto out_vf;
+		}
+
+		/*
+		 * If the fsverity metadata is missing, inform the user and
+		 * move on to the next file.
+		 */
+		if (fsverity_meta_is_missing(errno)) {
+			str_error(ctx, descr_render(&dsc),
+ _("fsverity metadata missing."));
+			ret = 0;
+			goto out_vf;
+		}
+
+		ret = -errno;
+		str_errno(ctx, descr_render(&dsc));
+		goto out_vf;
+	}
+
+	ret = fstat(fd, &sb);
+	if (ret) {
+		str_errno(ctx, descr_render(&dsc));
+		goto out_fd;
+	}
+
+	/* Read a single byte from each block in the file to validate. */
+	for (pos = 0; pos < sb.st_size; pos += sb.st_blksize) {
+		char	c;
+		ssize_t	bytes_read;
+
+		bytes_read = pread(fd, &c, 1, pos);
+		if (!bytes_read)
+			break;
+		if (bytes_read > 0) {
+			record_verity_success(ctx, &dsc, &fail_pos, &fail_len);
+			progress_add(sb.st_blksize);
+			continue;
+		}
+
+		if (errno == EIO) {
+			size_t	length = min(sb.st_size - pos, sb.st_blksize);
+
+			record_verity_error(ctx, &dsc, pos, length, &fail_pos,
+					&fail_len);
+			continue;
+		}
+
+		str_errno(ctx, descr_render(&dsc));
+		break;
+	}
+	report_verity_error(ctx, &dsc, fail_pos, fail_len);
+
+	ret = close(fd);
+	if (ret) {
+		str_errno(ctx, descr_render(&dsc));
+		goto out_vf;
+	}
+	fd = -1;
+
+out_fd:
+	if (fd >= 0)
+		close(fd);
+out_vf:
+	if (ret)
+		vf->vc->aborted = true;
+	free(vf);
+	return;
+}
+
+/* If this is a verity file, queue it for scanning. */
+static int
+schedule_verity_file(
+	struct scrub_ctx	*ctx,
+	struct xfs_handle	*handle,
+	struct xfs_bulkstat	*bs,
+	void			*arg)
+{
+	struct verity_ctx	*vc = arg;
+	struct verity_file_ctx	*vf;
+	int			ret;
+
+	if (vc->aborted)
+		return ECANCELED;
+
+	if (!(bs->bs_xflags & FS_XFLAG_VERITY)) {
+		progress_add(bs->bs_size);
+		return 0;
+	}
+
+	vf = malloc(sizeof(struct verity_file_ctx));
+	if (!vf) {
+		str_errno(ctx, _("could not allocate fsverity scan context"));
+		vc->aborted = true;
+		return ENOMEM;
+	}
+
+	/* Queue the validation work. */
+	vf->handle = *handle; /* struct copy */
+	vf->vc = vc;
+
+	if (bs->bs_xflags & FS_XFLAG_REALTIME)
+		ret = -workqueue_add(&vc->wq_rtdev, scan_verity_file, 0, vf);
+	else
+		ret = -workqueue_add(&vc->wq_ddev, scan_verity_file, 0, vf);
+	if (ret) {
+		str_liberror(ctx, ret, _("could not schedule fsverity scan"));
+		vc->aborted = true;
+		return ECANCELED;
+	}
+
+	return 0;
+}
+
+static int
+scan_verity_files(
+	struct scrub_ctx	*ctx)
+{
+	struct verity_ctx	vc = {
+		.ctx		= ctx,
+	};
+	unsigned int		verifier_threads;
+	int			ret;
+
+	/* Create thread pool for data dev fsverity processing. */
+	verifier_threads = disk_heads(ctx->datadev);
+	if (verifier_threads == 1)
+		verifier_threads = 0;
+	ret = -workqueue_create_bound(&vc.wq_ddev, ctx, verifier_threads, 500);
+	if (ret) {
+		str_liberror(ctx, ret, _("creating data dev fsverity workqueue"));
+		return ret;
+	}
+
+	/* Create thread pool for rtdev fsverity processing. */
+	if (ctx->rtdev) {
+		verifier_threads = disk_heads(ctx->rtdev);
+		if (verifier_threads == 1)
+			verifier_threads = 0;
+		ret = -workqueue_create_bound(&vc.wq_rtdev, ctx,
+				verifier_threads, 500);
+		if (ret) {
+			str_liberror(ctx, ret,
+					_("creating rt dev fsverity workqueue"));
+			goto out_ddev;
+		}
+	}
+
+	/* Find all the verity inodes. */
+	ret = scrub_scan_all_inodes(ctx, schedule_verity_file, 0, &vc);
+	if (ret)
+		goto out_rtdev;
+	if (vc.aborted) {
+		ret = ECANCELED;
+		goto out_rtdev;
+	}
+
+out_rtdev:
+	workqueue_terminate(&vc.wq_rtdev);
+	workqueue_destroy(&vc.wq_rtdev);
+out_ddev:
+	workqueue_terminate(&vc.wq_ddev);
+	workqueue_destroy(&vc.wq_ddev);
+	return ret;
+}
+
 /*
  * Read verify all the file data blocks in a filesystem.  Since XFS doesn't
  * do data checksums, we trust that the underlying storage will pass back
@@ -689,6 +973,12 @@ phase6_func(
 	struct media_verify_state	vs = { NULL };
 	int				ret, ret2, ret3;
 
+	if (ctx->mnt.fsgeom.flags & XFS_FSOP_GEOM_FLAGS_VERITY) {
+		ret = scan_verity_files(ctx);
+		if (ret)
+			return ret;
+	}
+
 	ret = -bitmap_alloc(&vs.d_bad);
 	if (ret) {
 		str_liberror(ctx, ret, _("creating datadev badblock bitmap"));
@@ -816,5 +1106,20 @@ phase6_estimate(
 	if (ctx->logdev)
 		*nr_threads += disk_heads(ctx->logdev);
 	*rshift = 20;
+
+	/*
+	 * If fsverity is active, double the amount of progress items because
+	 * we will want to validate individual files' data with fsverity.
+	 * Bump the thread counts for the separate verity thread pools and the
+	 * inode scanner.
+	 */
+	if (ctx->mnt.fsgeom.flags & XFS_FSOP_GEOM_FLAGS_VERITY) {
+		*items *= 2;
+		*nr_threads += disk_heads(ctx->datadev);
+		*nr_threads += scrub_nproc_workqueue(ctx);
+		if (ctx->rtdev)
+			*nr_threads += disk_heads(ctx->rtdev);
+	}
+
 	return 0;
 }


