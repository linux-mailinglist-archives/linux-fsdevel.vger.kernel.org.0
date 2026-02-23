Return-Path: <linux-fsdevel+bounces-78073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ2UK8TgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:20:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC8117F2F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E6BE31CB292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703637F727;
	Mon, 23 Feb 2026 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFEYQ4gQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB1283FEF;
	Mon, 23 Feb 2026 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888528; cv=none; b=eUQ1wXSnqcJDh5YDuIhavxKAsLFUDCiHPpr6VQ14PAvKStJDGYOnPCJhWEuWlrptSxGnQfMsZQ0eWCHwrDHIg/ICs8ppFXDh5mLWMzXPB8r2XrUtB225Z2IolOtgZ5KnZbvraJyAN3vRfzZ++SXMLFFt6XYyh+l7BbIpDYv1v7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888528; c=relaxed/simple;
	bh=3PPTBvYR7xM6qPTQjgrHBE9zt5HjznKDAZU2Fkp5N90=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSHS0Y+tHYIQZOGP9DmTS9J2eVydhBYTsCB7YBvMhybfbGZB4G74HVNy75WaOU5WW3H+tZD74imTmwGB8iCr6oYt5ZRLrlaqUxz9KIXfGlZRg6VxjTeVU2Tb0gn6gAiAHrv3K9kywDzjo/Q7KgVcx4B22XSaZ8LvO3NGaqahN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFEYQ4gQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56417C19421;
	Mon, 23 Feb 2026 23:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888528;
	bh=3PPTBvYR7xM6qPTQjgrHBE9zt5HjznKDAZU2Fkp5N90=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QFEYQ4gQL7/rJe05AQ7+lGpmt2GUrQnSX3r6hS+MVb7QHq8zrhBaYWidIGXjcNWVb
	 XckdprU3kz163xFI8cw1YyewfYgK1PQV9IwmLmKr5qF5DrFS9ZaR/k+eiP1dnx/CJd
	 dRMwJDUkkxvT745qXi59ZBFafaZWdV9vJSoCYb1dGXEC/AWR4Nb4FQys6LcZCWMh6o
	 FFMueFju5TfjNX6juYGAadrOe4N48ffyn4ESw4fANQqUzp9xxUuaNFyBM1KObtV0uO
	 2toR5NqFy6QlpVaRfh0c5qtkbQk+isDksb0L4VUa11/6KFYwinwWr8kNlxPVtlipuv
	 eOsdK3gANMxJg==
Date: Mon, 23 Feb 2026 15:15:27 -0800
Subject: [PATCH 26/33] fuse: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734802.3935739.13381272024060098466.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78073-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EC8117F2F0
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Implement inline data file IO by issuing FUSE_READ/FUSE_WRITE commands
in response to an inline data mapping.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.c |  205 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 197 insertions(+), 8 deletions(-)


diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index e8a0c1ceb409c4..1c3d99f11634d2 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -398,6 +398,152 @@ fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
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
+	if (BAD_DATA(!iomap_inline_data_valid(iomap))) {
+		fuse_iomap_inline_free(iomap);
+		return -EFSCORRUPTED;
+	}
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
@@ -467,12 +613,20 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		fuse_iomap_from_server(iomap, read_dev, &outarg.read);
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
@@ -511,8 +665,28 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct iomap *srcmap = &iter->srcmap;
 	int err;
 
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
@@ -1461,7 +1635,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 					  unsigned int len, u64 end_pos)
 {
 	struct inode *inode = wpc->inode;
-	struct iomap write_iomap, dontcare;
 	ssize_t ret;
 
 	if (fuse_is_bad(inode)) {
@@ -1474,23 +1647,39 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	trace_fuse_iomap_writeback_range(inode, offset, len, end_pos);
 
 	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
+		struct iomap_iter fake_iter = { };
+		struct iomap *write_iomap = &fake_iter.iomap;
+
 		ret = fuse_iomap_begin(inode, offset, len,
-				       FUSE_IOMAP_OP_WRITEBACK,
-				       &write_iomap, &dontcare);
+				       FUSE_IOMAP_OP_WRITEBACK, write_iomap,
+				       &fake_iter.srcmap);
 		if (ret)
 			goto discard_folio;
 
+		if (BAD_DATA(write_iomap->type == IOMAP_INLINE)) {
+			/*
+			 * iomap assumes that inline data writes are completed
+			 * by the time ->iomap_end completes, so it should
+			 * never mark a pagecache folio dirty.
+			 */
+			fuse_iomap_end(inode, offset, len, 0,
+				       FUSE_IOMAP_OP_WRITEBACK,
+				       write_iomap);
+			ret = -EIO;
+			goto discard_folio;
+		}
+
 		/*
 		 * Landed in a hole or beyond EOF?  Send that to iomap, it'll
 		 * skip writing back the file range.
 		 */
-		if (write_iomap.offset > offset) {
-			write_iomap.length = write_iomap.offset - offset;
-			write_iomap.offset = offset;
-			write_iomap.type = IOMAP_HOLE;
+		if (write_iomap->offset > offset) {
+			write_iomap->length = write_iomap->offset - offset;
+			write_iomap->offset = offset;
+			write_iomap->type = IOMAP_HOLE;
 		}
 
-		memcpy(&wpc->iomap, &write_iomap, sizeof(struct iomap));
+		memcpy(&wpc->iomap, write_iomap, sizeof(struct iomap));
 	}
 
 	ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);


