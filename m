Return-Path: <linux-fsdevel+bounces-61531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46747B589A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0EB1B213A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510B042A99;
	Tue, 16 Sep 2025 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeR/8q3M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2BF1D63CD;
	Tue, 16 Sep 2025 00:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982856; cv=none; b=QSz4ti/bPQAjoyN8ND/GSYOlgxg+YTozJEc70UE3zDdDkxBgt/tr1fliDh1sya7PMA33h2Pu7S/4WpZ12MxUNBPNzgjr5OvftICNww8TDLtnrEPvNamWDpUYH2NpO/eT12wxYFLIR9s5PwKkWtgNYN9La+BqXrRb8iABmxu3pEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982856; c=relaxed/simple;
	bh=M6YDNd5uD3x5NiPMLLep+DJpPHr5Mlq7Ke37xa56Dbo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlIye3JxuDwDioM2W/fASiunHeEFFvNGnzZOUbjYqsmRmb3aEjZSv9CFn/+yC8gr+GsT6uVFjggtcnoZWduS4OMjIA3ZT6c64b4J+JwaK6Da7YVd2Jxj63L1HLlMYDsllRbCDTsECfeyGt9f/L6htkxDevaFAhiVlzJheFqzWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeR/8q3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBFDC4CEF5;
	Tue, 16 Sep 2025 00:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982854;
	bh=M6YDNd5uD3x5NiPMLLep+DJpPHr5Mlq7Ke37xa56Dbo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FeR/8q3M8EJdro4RVqesvStPEIdvnBLHMCb20nzi5I3PJvPRk0HSCLMQo9tFtiFQl
	 92ZwPdk12B89x+KY2wlN7cNTsal4q5t81byFvqGB+9D/DmxHYV2YtCx2OwKKm1EYes
	 t9V9NkXpcgWjqE0zvWqlAhSUMFfBUYDX3A0oT3BfDCmhSbZxIPS+i4kHFRQULw8R76
	 bBa3tHWc2NtrRx3D60lkZwYuE1QnarCphe78Za9l0BK6gH1jbwJ4+ZtucL8cllpQQ0
	 ZEWY8LuKN7wCLfhpfPV/Z0aB5BoP7j7YoosLzivQdkKXyu+O6fljHoJ4/Jd2o87cDz
	 rfaZAxXT3M/kg==
Date: Mon, 15 Sep 2025 17:34:13 -0700
Subject: [PATCH 24/28] fuse: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151780.382724.13061889831042777.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement inline data file IO by issuing FUSE_READ/FUSE_WRITE commands
in response to an inline data mapping.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file_iomap.c |  184 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index d2945f8071a296..8faf16f58df035 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -417,6 +417,150 @@ fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
 	return ret;
 }
 
+static inline int fuse_iomap_inline_alloc(struct iomap *iomap)
+{
+	ASSERT(iomap->inline_data == NULL);
+	ASSERT(iomap->length > 0);
+
+	iomap->inline_data = kvzalloc(iomap->length, GFP_KERNEL);
+	return iomap->inline_data ? 0 : -ENOMEM;
+}
+
+static inline void fuse_iomap_inline_free(struct iomap *iomap)
+{
+	kvfree(iomap->inline_data);
+	iomap->inline_data = NULL;
+}
+
+/*
+ * Use the FUSE_READ command to read inline file data from the fuse server.
+ * Note that there's no file handle attached, so the fuse server must be able
+ * to reconnect to the inode via the nodeid.
+ */
+static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
+				  loff_t count, struct iomap *iomap)
+{
+	struct fuse_read_in in = {
+		.offset = pos,
+		.size = count,
+	};
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
+		return -EFSCORRUPTED;
+
+	args.opcode = FUSE_READ;
+	args.nodeid = fi->nodeid;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(in);
+	args.in_args[0].value = &in;
+	args.out_argvar = true;
+	args.out_numargs = 1;
+	args.out_args[0].size = count;
+	args.out_args[0].value = iomap_inline_data(iomap, pos);
+
+	ret = fuse_simple_request(fm, &args);
+	if (ret < 0) {
+		fuse_iomap_inline_free(iomap);
+		return ret;
+	}
+	/* no readahead means something bad happened */
+	if (ret == 0) {
+		fuse_iomap_inline_free(iomap);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Use the FUSE_WRITE command to write inline file data from the fuse server.
+ * Note that there's no file handle attached, so the fuse server must be able
+ * to reconnect to the inode via the nodeid.
+ */
+static int fuse_iomap_inline_write(struct inode *inode, loff_t pos,
+				   loff_t count, struct iomap *iomap)
+{
+	struct fuse_write_in in = {
+		.offset = pos,
+		.size = count,
+	};
+	struct fuse_write_out out = { };
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
+		return -EFSCORRUPTED;
+
+	args.opcode = FUSE_WRITE;
+	args.nodeid = fi->nodeid;
+	args.in_numargs = 2;
+	args.in_args[0].size = sizeof(in);
+	args.in_args[0].value = &in;
+	args.in_args[1].size = count;
+	args.in_args[1].value = iomap_inline_data(iomap, pos);
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(out);
+	args.out_args[0].value = &out;
+
+	ret = fuse_simple_request(fm, &args);
+	if (ret < 0) {
+		fuse_iomap_inline_free(iomap);
+		return ret;
+	}
+	/* short write means something bad happened */
+	if (out.size < count) {
+		fuse_iomap_inline_free(iomap);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Set up inline data buffers for iomap_begin */
+static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
+				 loff_t pos, loff_t count,
+				 struct iomap *iomap, struct iomap *srcmap)
+{
+	int err;
+
+	if (opflags & IOMAP_REPORT)
+		return 0;
+
+	if (fuse_is_iomap_file_write(opflags)) {
+		if (iomap->type == IOMAP_INLINE) {
+			err = fuse_iomap_inline_alloc(iomap);
+			if (err)
+				return err;
+		}
+
+		if (srcmap->type == IOMAP_INLINE) {
+			err = fuse_iomap_inline_alloc(srcmap);
+			if (!err)
+				err = fuse_iomap_inline_read(inode, pos, count,
+							     srcmap);
+			if (err) {
+				fuse_iomap_inline_free(iomap);
+				return err;
+			}
+		}
+	} else if (iomap->type == IOMAP_INLINE) {
+		/* inline data read */
+		err = fuse_iomap_inline_alloc(iomap);
+		if (!err)
+			err = fuse_iomap_inline_read(inode, pos, count, iomap);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -486,12 +630,20 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		fuse_iomap_from_server(inode, iomap, read_dev, &outarg.read);
 	}
 
+	if (iomap->type == IOMAP_INLINE || srcmap->type == IOMAP_INLINE) {
+		err = fuse_iomap_set_inline(inode, opflags, pos, count, iomap,
+					    srcmap);
+		if (err)
+			goto out_write_dev;
+	}
+
 	/*
 	 * XXX: if we ever want to support closing devices, we need a way to
 	 * track the fuse_backing refcount all the way through bio endios.
 	 * For now we put the refcount here because you can't remove an iomap
 	 * device until unmount time.
 	 */
+out_write_dev:
 	fuse_backing_put(write_dev);
 out_read_dev:
 	fuse_backing_put(read_dev);
@@ -530,8 +682,28 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct iomap *srcmap = &iter->srcmap;
 	int err = 0;
 
+	if (srcmap->inline_data)
+		fuse_iomap_inline_free(srcmap);
+
+	if (iomap->inline_data) {
+		if (fuse_is_iomap_file_write(opflags) && written > 0) {
+			err = fuse_iomap_inline_write(inode, pos, written,
+						      iomap);
+			fuse_iomap_inline_free(iomap);
+			if (err)
+				return err;
+		} else {
+			fuse_iomap_inline_free(iomap);
+		}
+
+		/* fuse server should already be aware of what happened */
+		return 0;
+	}
+
 	if (fuse_should_send_iomap_end(fm, iomap, opflags, count, written)) {
 		struct fuse_iomap_end_in inarg = {
 			.opflags = fuse_iomap_op_to_server(opflags),
@@ -1431,6 +1603,18 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		if (ret)
 			goto discard_folio;
 
+		if (BAD_DATA(write_iomap.type == IOMAP_INLINE)) {
+			/*
+			 * iomap assumes that inline data writes are completed
+			 * by the time ->iomap_end completes, so it should
+			 * never mark a pagecache folio dirty.
+			 */
+			fuse_iomap_end(inode, offset, len, 0,
+				       FUSE_IOMAP_OP_WRITEBACK, &write_iomap);
+			ret = -EIO;
+			goto discard_folio;
+		}
+
 		/*
 		 * Landed in a hole or beyond EOF?  Send that to iomap, it'll
 		 * skip writing back the file range.


