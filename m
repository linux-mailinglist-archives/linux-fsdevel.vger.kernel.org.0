Return-Path: <linux-fsdevel+bounces-78084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FOpLlPgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:18:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9D117F24A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 724FA3064105
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE637F739;
	Mon, 23 Feb 2026 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7PCqs54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799C2749CF;
	Mon, 23 Feb 2026 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888700; cv=none; b=ITkjn2cXkULTAGKJR0gn/iJ5GQgB/+q0M37kGtRz2UNPR5qfLd3i4ciwMj+wlCqvG3wXM2yCOJmn2LpoOQFbflBct8BrxB3NPTenJ6Hk1k75ESyecy7Y3N5zmkMmwnWaE0IXlfWJLPzMJqymeQC3fQipnUhzQJJrG2zUyfGlGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888700; c=relaxed/simple;
	bh=XhcIIhQABJbqGYmyvvLPqMsMry5juFX3xihWMxv08WQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P89nrAb7+T5YMv9HDmBssaswH3xPzRZqXd4AmAPywI/SvnlGqKgVEeOn7N/kc2DSL4RCV6FGMRDVmHm9b1ixeNd3ZC5F3ILX36htXlZzY8j0qZHEbie6rSHPrAJU0UL/gEdSNjE5ap85EZsmUa2K87C5UXvwd10QtKwTq/o83UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7PCqs54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581AEC116C6;
	Mon, 23 Feb 2026 23:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888700;
	bh=XhcIIhQABJbqGYmyvvLPqMsMry5juFX3xihWMxv08WQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=B7PCqs54ydfc375v9X6T63oJOe+sBPSRgq7jMBYe0qF5WprRXJ8DEedjWZgjw95gI
	 VybaLrhVX2WaIkk3LintrrMAMUnWbY+xy4xoyGBowfyYexSkPMksz7/8AFdgnCoFBs
	 9h32Dkc66JVl0RxR0t7IiyoWgNxXtnYTP8JhMgikz0cZIP8QZKdtYJZsHJUsMTiZRR
	 wRLWNznIceJrR19yBMEKkE7zYFfmPilLXhCelRZgJWq4y/Qx8E1RBx+TC9SW9xU+Ik
	 o4a3Tbv3Ggc/G4MYMH77+/Gc1N8SmRPRwrBa299NLrCqeZ+yDlHwoQ1HZnJfziECxM
	 GRADq23pw5v2A==
Date: Mon, 23 Feb 2026 15:18:19 -0800
Subject: [PATCH 1/9] fuse: enable caching of timestamps
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735548.3937167.6814770148746394467.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
References: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78084-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C9D117F24A
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Cache the timestamps in the kernel so that the kernel sends FUSE_SETATTR
calls to the fuse server after writes, because the iomap infrastructure
won't do that for us.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c        |    5 ++++-
 fs/fuse/file.c       |   18 ++++++++++++------
 fs/fuse/fuse_iomap.c |    6 ++++++
 fs/fuse/inode.c      |   13 +++++++------
 4 files changed, 29 insertions(+), 13 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ff678f26e9cd79..5ae6c5639f6d2c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2261,7 +2261,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct fuse_attr_out outarg;
 	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = false;
-	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
+	bool is_wb = (is_iomap || fc->writeback_cache) &&
+		     S_ISREG(inode->i_mode);
 	loff_t oldsize;
 	int err;
 	bool trust_local_cmtime = is_wb;
@@ -2401,6 +2402,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	spin_lock(&fi->lock);
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
+		if ((attr->ia_valid & ATTR_ATIME) && is_iomap)
+			inode_set_atime_to_ts(inode, attr->ia_atime);
 		if (attr->ia_valid & ATTR_MTIME)
 			inode_set_mtime_to_ts(inode, attr->ia_mtime);
 		if (attr->ia_valid & ATTR_CTIME)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1243d0eea22a37..0b21fcdefffeb7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -256,7 +256,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	int err;
 	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
-	bool is_wb_truncate = is_truncate && fc->writeback_cache;
+	bool is_wb_truncate = is_truncate && (is_iomap || fc->writeback_cache);
 	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
 
 	if (fuse_is_bad(inode))
@@ -471,12 +471,14 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_flush_in inarg;
 	FUSE_ARGS(args);
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int err;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
+	if ((ff->open_flags & FOPEN_NOFLUSH) &&
+	    !fm->fc->writeback_cache && !is_iomap)
 		return 0;
 
 	err = write_inode_now(inode, 1);
@@ -512,7 +514,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	 * In memory i_blocks is not maintained by fuse, if writeback cache is
 	 * enabled, i_blocks from cached attr may not be accurate.
 	 */
-	if (!err && fm->fc->writeback_cache)
+	if (!err && (is_iomap || fm->fc->writeback_cache))
 		fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
 	return err;
 }
@@ -814,8 +816,10 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	 * If writeback_cache is enabled, a short read means there's a hole in
 	 * the file.  Some data after the hole is in page cache, but has not
 	 * reached the client fs yet.  So the hole is not present there.
+	 * If iomap is enabled, a short read means we hit EOF so there's
+	 * nothing to adjust.
 	 */
-	if (!fc->writeback_cache) {
+	if (!fc->writeback_cache && !fuse_inode_has_iomap(inode)) {
 		loff_t pos = folio_pos(ap->folios[0]) + num_read;
 		fuse_read_update_size(inode, pos, attr_ver);
 	}
@@ -864,6 +868,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned int flags, struct iomap *iomap,
 			    struct iomap *srcmap)
 {
+	WARN_ON(fuse_inode_has_iomap(inode));
+
 	iomap->type = IOMAP_MAPPED;
 	iomap->length = length;
 	iomap->offset = offset;
@@ -2016,7 +2022,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 	 * Do this only if writeback_cache is not enabled.  If writeback_cache
 	 * is enabled, we trust local ctime/mtime.
 	 */
-	if (!fc->writeback_cache)
+	if (!fc->writeback_cache && !fuse_inode_has_iomap(inode))
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
 	spin_lock(&fi->lock);
 	fi->writectr--;
@@ -3109,7 +3115,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
 	const bool is_iomap = fuse_inode_has_iomap(inode_out);
-	bool is_unstable = (!fc->writeback_cache) &&
+	bool is_unstable = (!fc->writeback_cache && !is_iomap) &&
 			   ((pos_out + len) > inode_out->i_size);
 
 	if (fc->no_copy_file_range)
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 9a3703b2d65bbd..65c8e06fdd653a 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1864,6 +1864,12 @@ static inline void fuse_inode_set_iomap(struct inode *inode)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	unsigned int min_order = 0;
 
+	/*
+	 * Manage timestamps ourselves, don't make the fuse server do it.  This
+	 * is critical for mtime updates to work correctly with page_mkwrite.
+	 */
+	inode->i_flags &= ~S_NOCMTIME;
+	inode->i_flags &= ~S_NOATIME;
 	inode->i_data.a_ops = &fuse_iomap_aops;
 
 	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9185b3b922559a..94355977904068 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -331,10 +331,11 @@ u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
-		return 0;
+	if (S_ISREG(inode->i_mode) &&
+	    (fuse_inode_has_iomap(inode) || fc->writeback_cache))
+		return STATX_MTIME | STATX_CTIME | STATX_SIZE;
 
-	return STATX_MTIME | STATX_CTIME | STATX_SIZE;
+	return 0;
 }
 
 static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr,
@@ -349,9 +350,9 @@ static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr
 
 	spin_lock(&fi->lock);
 	/*
-	 * In case of writeback_cache enabled, writes update mtime, ctime and
-	 * may update i_size.  In these cases trust the cached value in the
-	 * inode.
+	 * In case of writeback_cache or iomap enabled, writes update mtime,
+	 * ctime and may update i_size.  In these cases trust the cached value
+	 * in the inode.
 	 */
 	cache_mask = fuse_get_cache_mask(inode);
 	fuse_iomap_set_disk_size(fi, attr->size);


