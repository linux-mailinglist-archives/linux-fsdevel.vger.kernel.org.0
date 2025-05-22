Return-Path: <linux-fsdevel+bounces-49620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FC6AC00FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB43C7B40B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBDA2914;
	Thu, 22 May 2025 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxfTuEyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D51FC3
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872367; cv=none; b=JQt/MzsNcj2AsIn+vgL32myFpvGYUGNtKEmQQhMQbLgyGGupA8QoB/R8f15M8FUXC/tSA6GF1B0kxnQ+74limeKosUPLZMqdC4SBk+EoOmRvT8twkKFwBkT993xpDwa0y0k/NSf9AgB+lCLgRvdwmckgcEU1CetrArL1rSky85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872367; c=relaxed/simple;
	bh=T0HAuzYNpTVXUTV2sc2VaFrqAgtkzkon7O7J6TLXIvk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QF83RjvJ8BiWthMa7Dy76Hkvuz5JpIcBEmiOdAg9CQPLt3K/4fENuvhSy3pz3SBZmys4VbphpDoCbxc1BTou4pGzBD2bzw6SzRH+7ea2r4N9qyt8sKb6q/s2CCaakWNlFKdEWiNLmjv6HG+1ruzvy4Wip6TJQf3NW3aTdUtZg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxfTuEyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D409AC4CEE4;
	Thu, 22 May 2025 00:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872366;
	bh=T0HAuzYNpTVXUTV2sc2VaFrqAgtkzkon7O7J6TLXIvk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LxfTuEyEdMPR6Z8cOzhZ+pv7M1c1jxhKVEg/MNbj0Z0ne5pQvKU2OzJrkpRNVTrrJ
	 xh4ejvLYXaedskvVl6iPiyEvrvEiaTfkJGY2dQu5f4qE4/mraomvrteOCCBW18Qq+A
	 hnbJ/u9PH483yzG3PmtaAS04/5jj/sO+TuVI/qBNQQwnqYvwhq5zeCuGtwSLe77YYK
	 /E+IXwO4MkfdA6Ah3bhmWbJa43IHCWywkxZuJ91XMu+wYnlB5XrGyccQyT03utSr/M
	 35kW4TlsesUeI4o6q0VGm3s5+iXEh4EVxC/pYruBx2UhESjPYSlZU62ed9+TgdnKgl
	 sX41hh13EIeng==
Date: Wed, 21 May 2025 17:06:06 -0700
Subject: [PATCH 3/8] libfuse: add upper level iomap commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, John@groves.net,
 joannelkoong@gmail.com, miklos@szeredi.hu
Message-ID: <174787196412.1483718.17504710632802880015.stgit@frogsfrogsfrogs>
In-Reply-To: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
References: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Teach the upper level fuse library about the iomap begin and end
operations, and connect it to the lower level.  This is needed for
fuse2fs to start using iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |   14 ++++++++
 lib/fuse.c     |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 4582cc7ac99271..fa5543bdf59deb 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -850,6 +850,20 @@ struct fuse_operations {
 	 * Find next data or hole after the specified offset
 	 */
 	off_t (*lseek) (const char *, off_t off, int whence, struct fuse_file_info *);
+
+#if FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 18)
+	/* Start and end an iomap operation */
+	int (*iomap_begin) (const char *path, uint64_t nodeid,
+			    uint64_t attr_ino, off_t pos_in,
+			    uint64_t length_in, uint32_t opflags_in,
+			    struct fuse_iomap *read_iomap_out,
+			    struct fuse_iomap *write_iomap_out);
+
+	int (*iomap_end) (const char *path, uint64_t nodeid, uint64_t attr_ino,
+			  off_t pos_in, uint64_t length_in,
+			  uint32_t opflags_in, ssize_t written_in,
+			  const struct fuse_iomap *iomap_in);
+#endif /* FUSE_USE_VERSION >= 318 */
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index d89655fc22c844..efec49d35043e0 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -4433,6 +4433,101 @@ static void fuse_lib_lseek(fuse_req_t req, fuse_ino_t ino, off_t off, int whence
 		reply_err(req, res);
 }
 
+static int fuse_fs_iomap_begin(struct fuse_fs *fs, const char *path,
+			       fuse_ino_t nodeid, uint64_t attr_ino, off_t pos,
+			       uint64_t count, uint32_t opflags,
+			       struct fuse_iomap *read_iomap,
+			       struct fuse_iomap *write_iomap)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_begin)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_begin[%s] nodeid %llu attr_ino %llu pos %llu count %llu opflags 0x%x\n",
+			 path, nodeid, attr_ino, pos, count, opflags);
+	}
+
+	return fs->op.iomap_begin(path, nodeid, attr_ino, pos, count, opflags,
+				  read_iomap, write_iomap);
+}
+
+static void fuse_lib_iomap_begin(fuse_req_t req, fuse_ino_t nodeid,
+				 uint64_t attr_ino, off_t pos, uint64_t count,
+				 uint32_t opflags)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_iomap read_iomap = { };
+	struct fuse_iomap write_iomap = {
+		.type = FUSE_IOMAP_TYPE_PURE_OVERWRITE,
+	};
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_begin(f->fs, path, nodeid, attr_ino, pos, count,
+				  opflags, &read_iomap, &write_iomap);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_reply_iomap_begin(req, &read_iomap, &write_iomap);
+}
+
+static int fuse_fs_iomap_end(struct fuse_fs *fs, const char *path,
+			     fuse_ino_t nodeid, uint64_t attr_ino, off_t pos,
+			     uint64_t count, uint32_t opflags, ssize_t written,
+			     const struct fuse_iomap *iomap)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_end)
+		return 0;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_end[%s] nodeid %llu attr_ino %llu pos %llu count %llu opflags 0x%x written %zd\n",
+			 path, nodeid, attr_ino, pos, count, opflags, written);
+	}
+
+	return fs->op.iomap_end(path, nodeid, attr_ino, pos, count, opflags,
+				written, iomap);
+}
+
+static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
+			       uint64_t attr_ino, off_t pos, uint64_t count,
+			       uint32_t opflags, ssize_t written,
+			       const struct fuse_iomap *iomap)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_end(f->fs, path, nodeid, attr_ino, pos, count,
+				opflags, written, iomap);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4531,6 +4626,8 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.fallocate = fuse_lib_fallocate,
 	.copy_file_range = fuse_lib_copy_file_range,
 	.lseek = fuse_lib_lseek,
+	.iomap_begin = fuse_lib_iomap_begin,
+	.iomap_end = fuse_lib_iomap_end,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


