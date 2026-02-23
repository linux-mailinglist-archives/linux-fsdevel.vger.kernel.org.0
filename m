Return-Path: <linux-fsdevel+bounces-78059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFpvFLzenGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:11:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD58F17EF7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEC52301282D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B110D37E30D;
	Mon, 23 Feb 2026 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8yC8Q+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B137C0F1;
	Mon, 23 Feb 2026 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888308; cv=none; b=nz2NlDjWGBRRIjBEKthwjilJgbDh/gumfkNTpKcspbc0q5/4BEjTRS15CjA9Y5kIxcsNgUYdb1Foc59ozbn1owUddgwpJDw5BR+jAi/Urzb8MlB3/tEZN3Rh7yKNwD/x7dJPdCoKQLi9dSWmClWqra2mj6feXalylNFY5tXJDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888308; c=relaxed/simple;
	bh=IC3Kex+Z/HeaF+LVjuP8wX+8CxzL8Iix4QhCOvRXDCc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3FiadgqxKcvKErM6n8X1KjMdzP53Ts5pGsmY06GB7C+wypuwdVehzro5NppjmsTNC0yrVADlJVdvnRVuqGwjN39nL4QQMhDtsLTmz9mx+rLuDnnQ8fEr+iy3TsNL0LWty1SSE5D/TX8+pN4ZBIj8i1htqr20euKB0jVHVR/Ruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8yC8Q+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12565C116C6;
	Mon, 23 Feb 2026 23:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888308;
	bh=IC3Kex+Z/HeaF+LVjuP8wX+8CxzL8Iix4QhCOvRXDCc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=V8yC8Q+yY6+VJFs5LSDolzkJlGvLZ6XwzHe8rh47CxdLZ7k8C1+2GRe+JBLhsSstc
	 ZZeQb9vuZiqj+Wnkby2+FtSxF0FqjL60LCzceUPLWcHKOvIZcj95cGcYxRpJPVTnFH
	 RV/FdAQlrbMpi0ExZ5sWrOx8CFj+H5XZbTVCF6RMmKaH6a5dw/iJNGV4ac+tzZvw3P
	 dsShIyXzUBJjAEQhA9wuW2XfyVm1iagQ6fUIJi28/TXaCziRELb/MAY9eUQvkkVDRW
	 hwuicwRfK1fbCeK3YMhBslDucpd3U8U3/RZaHAFA6gwHW0wJzQdJBFNA0FubR4sIov
	 R7QZQ5IRbN0eg==
Date: Mon, 23 Feb 2026 15:11:47 -0800
Subject: [PATCH 12/33] fuse: implement basic iomap reporting such as FIEMAP
 and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734502.3935739.15405075110370570949.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78059-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD58F17EF7E
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Implement the basic file mapping reporting functions like FIEMAP, BMAP,
and SEEK_DATA/HOLE.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h |    8 ++++++
 fs/fuse/dir.c        |    1 +
 fs/fuse/file.c       |   13 ++++++++++
 fs/fuse/fuse_iomap.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 89 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 34f2c75416eb62..8ba30a496545f5 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -33,6 +33,11 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 
 	return test_bit(FUSE_I_IOMAP, &fi->state);
 }
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 length);
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -41,6 +46,9 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 # define fuse_iomap_init_inode(...)		((void)0)
 # define fuse_iomap_evict_inode(...)		((void)0)
 # define fuse_inode_has_iomap(...)		(false)
+# define fuse_iomap_fiemap			NULL
+# define fuse_iomap_lseek(...)			(-ENOSYS)
+# define fuse_iomap_bmap(...)			(-ENOSYS)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 138f8abbe42b4c..e16facbde126ef 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2501,6 +2501,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
+	.fiemap		= fuse_iomap_fiemap,
 };
 
 static const struct inode_operations fuse_symlink_inode_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c73536e29f1c96..e81571aaef15fe 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2588,6 +2588,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	struct fuse_bmap_out outarg;
 	int err;
 
+	if (fuse_inode_has_iomap(inode)) {
+		sector_t alt_sec = fuse_iomap_bmap(mapping, block);
+		if (alt_sec > 0)
+			return alt_sec;
+	}
+
 	if (!inode->i_sb->s_bdev || fm->fc->no_bmap)
 		return 0;
 
@@ -2623,6 +2629,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 	struct fuse_lseek_out outarg;
 	int err;
 
+	if (fuse_inode_has_iomap(inode)) {
+		loff_t alt_pos = fuse_iomap_lseek(file, offset, whence);
+
+		if (alt_pos != -ENOSYS)
+			return alt_pos;
+	}
+
 	if (fm->fc->no_lseek)
 		goto fallback;
 
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index dccfc9a2c9847c..32ddf2fa6bdf78 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -4,6 +4,7 @@
  * Author: Darrick J. Wong <djwong@kernel.org>
  */
 #include <linux/iomap.h>
+#include <linux/fiemap.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
@@ -539,7 +540,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	return 0;
 }
 
-const struct iomap_ops fuse_iomap_ops = {
+static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
@@ -669,3 +670,68 @@ void fuse_iomap_evict_inode(struct inode *inode)
 
 	fuse_inode_clear_iomap(inode);
 }
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 count)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	int error;
+
+	/*
+	 * We are called directly from the vfs so we need to check per-inode
+	 * support here explicitly.
+	 */
+	if (!fuse_inode_has_iomap(inode))
+		return -EOPNOTSUPP;
+
+	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)
+		return -EOPNOTSUPP;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (!fuse_allow_current_process(fc))
+		return -EACCES;
+
+	inode_lock_shared(inode);
+	error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
+	inode_unlock_shared(inode);
+
+	return error;
+}
+
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block)
+{
+	ASSERT(fuse_inode_has_iomap(mapping->host));
+
+	return iomap_bmap(mapping, block, &fuse_iomap_ops);
+}
+
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (!fuse_allow_current_process(fc))
+		return -EACCES;
+
+	switch (whence) {
+	case SEEK_HOLE:
+		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);
+		break;
+	case SEEK_DATA:
+		offset = iomap_seek_data(inode, offset, &fuse_iomap_ops);
+		break;
+	default:
+		return generic_file_llseek(file, offset, whence);
+	}
+
+	if (offset < 0)
+		return offset;
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+}


