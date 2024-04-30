Return-Path: <linux-fsdevel+bounces-18288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672938B690E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C745280E11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D02C10A36;
	Tue, 30 Apr 2024 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3HKIiF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9810799;
	Tue, 30 Apr 2024 03:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448354; cv=none; b=dWakv7IDZ0kuxE4e9JL1vl7UryFRTO8ItNALtd++D0AR1/h+K8RAgZ13iMDA+OUKOIBSoGRFHgr3uGjsX3I3v5i1A2NHvBrtahYh2OW1Bn3z76HVOzAdlqXWDlc14tglnIcJl/DhjzOL28wpAZzzVYlGz6+w9DrGd/+besv0qHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448354; c=relaxed/simple;
	bh=eleAA7Z+iIcJqnWHhYYHB3OOITqoJobCSFCgmxHiyxM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdrtAka2rwtbjSMbwpBYblgSFJ83lsALj5o4hD6P/Ux2aLwnB3cS8WNd5A7xtjZz3RnySUSFuevjWb605526i7H88W9EjXs9VMLFVpIrGsGZua442lR43toqbqhFNj9sesklaXbfrKOO8X3wSAz6LKlVyuvo6lhVTtVaub62o4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3HKIiF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DCDC116B1;
	Tue, 30 Apr 2024 03:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448354;
	bh=eleAA7Z+iIcJqnWHhYYHB3OOITqoJobCSFCgmxHiyxM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=r3HKIiF/jttEjvcSfK6iKmOktzKTZopG0xotPsNj164B8x7cGDQ9KTnq1dPyUnGQp
	 9l3V8ybQ1kmqWdlIYqUYQGkLP7NB+XPlhoWocIp5J/xhqHL2L2nPLyApjN/IO/Qg5g
	 1gQze6G3jFtUFTik+MZjl5gUZ791qoYtho1tr1+28QnuW8J3Ne74uibFDyKKES4ZaF
	 aJlOdYBPleEb8wVE78zPJy64HAIX+OxBYokX7CYuS8aUJl+l48MdT6elzf4W5Bx+yT
	 JM5ofgQ/29q6eDnkyryObBYOWwDsmGOarHjYm2cfen/w6Y/F3E/fRBtewkZgktsfGe
	 ZhqL5iCoomoGg==
Date: Mon, 29 Apr 2024 20:39:14 -0700
Subject: [PATCH 32/38] xfs_scrub: check verity file metadata
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683599.960383.17074672145055040251.stgit@frogsfrogsfrogs>
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

If phase 5 encounters a fsverity file, read its metadata to see if we
encounter any errors.  The consistency of the file data vs. the hashes
in the merkle tree are checked during the media scan.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 scrub/Makefile |    4 +
 scrub/inodes.h |   22 +++++++
 scrub/phase5.c |  182 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)


diff --git a/scrub/Makefile b/scrub/Makefile
index 885b43e9948d..ad010a05249f 100644
--- a/scrub/Makefile
+++ b/scrub/Makefile
@@ -109,6 +109,10 @@ CFILES += unicrash.c
 LCFLAGS += -DHAVE_LIBICU $(LIBICU_CFLAGS)
 endif
 
+ifeq ($(HAVE_FSVERITY_DESCR),yes)
+LCFLAGS += -DHAVE_FSVERITY_DESCR
+endif
+
 # Automatically trigger a media scan once per month
 XFS_SCRUB_ALL_AUTO_MEDIA_SCAN_INTERVAL=1mo
 
diff --git a/scrub/inodes.h b/scrub/inodes.h
index 7a0b275e575e..aab2d721fe02 100644
--- a/scrub/inodes.h
+++ b/scrub/inodes.h
@@ -25,4 +25,26 @@ int scrub_scan_all_inodes(struct scrub_ctx *ctx, scrub_inode_iter_fn fn,
 
 int scrub_open_handle(struct xfs_handle *handle);
 
+/*
+ * Might this be a file that's missing its fsverity metadata?  When this is the
+ * case, an open() call will return ENODATA.
+ */
+static inline bool fsverity_meta_is_missing(int error)
+{
+	switch (error) {
+	case ENODATA:
+	case EMSGSIZE:
+	case EINVAL:
+	case EFSCORRUPTED:
+	case EFBIG:
+		/*
+		 * The nonzero errno codes above are the error codes that can
+		 * be returned from fsverity on metadata validation errors.
+		 */
+		return true;
+	}
+
+	return false;
+}
+
 #endif /* XFS_SCRUB_INODES_H_ */
diff --git a/scrub/phase5.c b/scrub/phase5.c
index 6fd3c6982704..6f157fa3570c 100644
--- a/scrub/phase5.c
+++ b/scrub/phase5.c
@@ -28,6 +28,7 @@
 #include "descr.h"
 #include "unicrash.h"
 #include "repair.h"
+#include "atomic.h"
 
 /* Phase 5: Full inode scans and check directory connectivity. */
 
@@ -359,6 +360,183 @@ check_dir_connection(
 	return EADDRNOTAVAIL;
 }
 
+#ifdef HAVE_FSVERITY_DESCR
+struct fsverity_object {
+	const char		*name;
+	int			type;
+};
+
+struct fsverity_object fsverity_objects[] = {
+	{
+		.name		= "descriptor",
+		.type		= FS_VERITY_METADATA_TYPE_DESCRIPTOR,
+	},
+	{
+		.name		= "merkle tree",
+		.type		= FS_VERITY_METADATA_TYPE_MERKLE_TREE,
+	},
+	{
+		.name		= "signature",
+		.type		= FS_VERITY_METADATA_TYPE_SIGNATURE,
+	},
+};
+
+static void *fsverity_buf;
+#define FSVERITY_BUFSIZE	(32768)
+
+static inline void *
+get_fsverity_buf(void)
+{
+	static pthread_mutex_t	buf_lock = PTHREAD_MUTEX_INITIALIZER;
+	void			*new_buf;
+
+	if (!fsverity_buf) {
+		new_buf = malloc(FSVERITY_BUFSIZE);
+		if (!new_buf)
+			return NULL;
+
+		pthread_mutex_lock(&buf_lock);
+		if (!fsverity_buf) {
+			fsverity_buf = new_buf;
+			new_buf = NULL;
+		}
+		pthread_mutex_unlock(&buf_lock);
+		if (new_buf)
+			free(new_buf);
+	}
+
+	return fsverity_buf;
+}
+
+static int
+read_fsverity_object(
+	struct scrub_ctx		*ctx,
+	struct descr			*dsc,
+	int				fd,
+	const struct fsverity_object	*verity_obj)
+{
+	struct fsverity_read_metadata_arg arg = {
+		.buf_ptr		= (uintptr_t)get_fsverity_buf(),
+		.metadata_type		= verity_obj->type,
+		.length			= FSVERITY_BUFSIZE,
+	};
+	int				ret;
+
+	if (!arg.buf_ptr) {
+		str_liberror(ctx, ENOMEM, descr_render(dsc));
+		return ENOMEM;
+	}
+
+	do {
+		ret = ioctl(fd, FS_IOC_READ_VERITY_METADATA, &arg);
+		if (ret < 0) {
+			ret = errno;
+			switch (ret) {
+			case ENODATA:
+				/* No fsverity metadata found.  We're done. */
+				return 0;
+			case ENOTTY:
+			case EOPNOTSUPP:
+				/* not a verity file or object doesn't exist */
+				str_error(ctx, descr_render(dsc),
+ _("fsverity %s not supported at data offset %llu length %llu?"),
+					verity_obj->name,
+					arg.offset, arg.length);
+				return ret;
+			default:
+				/* some other error */
+				str_error(ctx, descr_render(dsc),
+ _("fsverity %s read error at data offset %llu length %llu."),
+					verity_obj->name,
+					arg.offset, arg.length);
+				return ret;
+			}
+		}
+		arg.offset += ret;
+	} while (ret > 0);
+
+	return 0;
+}
+
+/* Read all the fsverity metadata. */
+static int
+check_fsverity_metadata(
+	struct scrub_ctx	*ctx,
+	struct descr		*dsc,
+	int			fd)
+{
+	unsigned int		i;
+	int			error;
+
+	for (i = 0; i < ARRAY_SIZE(fsverity_objects); i++) {
+		error = read_fsverity_object(ctx, dsc, fd,
+				&fsverity_objects[i]);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
+/* Open this verity file and check its merkle tree and verity descriptor. */
+static int
+check_verity_file(
+	struct scrub_ctx	*ctx,
+	struct xfs_handle	*handle,
+	struct xfs_bulkstat	*bstat,
+	struct descr		*dsc,
+	int			*fdp)
+{
+	int			error;
+
+	/* Only regular files can have fsverity set. */
+	if (!S_ISREG(bstat->bs_mode)) {
+		str_error(ctx, descr_render(dsc),
+				_("fsverity cannot be set on a regular file."));
+		return 0;
+	}
+
+	*fdp = scrub_open_handle(handle);
+	if (*fdp >= 0)
+		return check_fsverity_metadata(ctx, dsc, *fdp);
+
+	/* Handle is stale, try again. */
+	if (errno == ESTALE)
+		return ESTALE;
+
+	/*
+	 * If the fsverity metadata is missing, inform the user and move on to
+	 * the next file.
+	 */
+	if (fsverity_meta_is_missing(errno)) {
+		str_error(ctx, descr_render(dsc),
+				_("fsverity metadata missing."));
+		return 0;
+	}
+
+	/* Some other runtime error. */
+	error = errno;
+	str_errno(ctx, descr_render(dsc));
+	return error;
+}
+#else
+static int
+check_verity_file(
+	struct scrub_ctx	*ctx,
+	struct xfs_handle	*handle,
+	struct xfs_bulkstat	*bstat,
+	struct descr		*dsc,
+	int			*fdp)
+{
+	static atomic_t		warned;
+
+	if (!atomic_inc_return(&warned))
+		str_warn(ctx, descr_render(dsc),
+				_("fsverity metadata checking not supported\n"));
+	return 0;
+}
+#endif /* HAVE_FSVERITY_DESCR */
+
 /*
  * Verify the connectivity of the directory tree.
  * We know that the kernel's open-by-handle function will try to reconnect
@@ -422,6 +600,10 @@ check_inode_names(
 		error = check_dirent_names(ctx, &dsc, &fd, bstat);
 		if (error)
 			goto err_fd;
+	} else if (bstat->bs_xflags & FS_XFLAG_VERITY) {
+		error = check_verity_file(ctx, handle, bstat, &dsc, &fd);
+		if (error)
+			goto err_fd;
 	}
 
 	progress_add(1);


