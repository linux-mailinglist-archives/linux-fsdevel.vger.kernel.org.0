Return-Path: <linux-fsdevel+bounces-78162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKLvIgjlnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A05417FAE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28DD23027E37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AFE37FF4C;
	Mon, 23 Feb 2026 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyvrZA7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AF37F8B7;
	Mon, 23 Feb 2026 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889921; cv=none; b=j+SHeeQzek3IyQqyjEFEisXGZ2yTx113mtOQ4fEXXpfVKUlDqEctIxr+XIOG5t4O56r5N/3lU/XvJMXeUPs+nItvQAD0DeCdKt613Mi1A4ILatYX48m2ly47tlNdUaEG67j76Qfb3EWtUSU52dygQc550QIHU8nQFzn0COkR4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889921; c=relaxed/simple;
	bh=XqmoU7fehS1lnBpZtg6uey15yz7pgou5P3st2MW4hq8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZvaGloNu42STKvKQYQsFY1O83uHOHaD2gOGB3QnMTpkceHOV0voPb6wv4Mw2v7azpN708eN3OeoOMH6HODli5X6pEgIRn/STcyoGQoSDDfmcOucf7bu/px+NrPglUDomQLQr3AVke7MlE/phfZT4lGbh44JczPnKdJPbN6l0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyvrZA7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22288C116C6;
	Mon, 23 Feb 2026 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889921;
	bh=XqmoU7fehS1lnBpZtg6uey15yz7pgou5P3st2MW4hq8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WyvrZA7E8I86yvLidnJB/QhM2U4IKV74i2kAIZ57lQeKQfM0fHQkiAAkWHt3kS8gi
	 ++OKUMGj8dUXHm/pRMnW3inYm7hL9PPAwpfFXeP63vVNZhmEZJtth/Rni4FQv1I2nZ
	 Fe6H4EF1vSJaIfa1e8ueJbpqkp1o9mZikei4T5vJwvCj13UKrnHC888eHwLB8FVdRP
	 YdVraVvI85T1fdwbEqR8LeR3KZpahj+4hmXs8Cys75fvvv1DU105HpjZ0EJHSxEbB7
	 mq89yOby7VXNAemCBP4lL+6g0IBfBwlcXLQ28kJlrjh1BUqcNiwAVStouyw5ceKEEg
	 TeD6ngjlD8GTA==
Date: Mon, 23 Feb 2026 15:38:40 -0800
Subject: [PATCH 10/19] fuse2fs: don't do file data block IO when iomap is
 enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744660.3943178.13882187001214125157.stgit@frogsfrogsfrogs>
In-Reply-To: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
References: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78162-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A05417FAE3
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

When iomap is in use for the page cache, the kernel will take care of
all the file data block IO for us, including zeroing of punched ranges
and post-EOF bytes.  fuse2fs only needs to do IO for inline data.

Therefore, set the NOBLOCKIO ext2_file flag so that libext2fs will not
do any regular file IO to or from disk blocks at all.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   11 +++++++-
 misc/fuse2fs.c    |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index b28e92ed5f2e65..b95ff73b7d9d8e 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -3714,9 +3714,14 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
 	ext2_file_t file;
 	__u64 old_isize;
 	errcode_t err;
+	int flags = EXT2_FILE_WRITE;
 	int ret = 0;
 
-	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &file);
+	/* the kernel handles all eof zeroing for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		flags |= EXT2_FILE_NOBLOCKIO;
+
+	err = ext2fs_file_open(fs, ino, flags, &file);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -3811,6 +3816,10 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (linked)
 		check |= L_OK;
 
+	/* the kernel handles all block IO for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		file->open_flags |= EXT2_FILE_NOBLOCKIO;
+
 	/*
 	 * If the caller wants to truncate the file, we need to ask for full
 	 * write access even if the caller claims to be appending.
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index be7004bb95cb8f..5731da1cbae7e5 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3455,15 +3455,72 @@ static int fuse2fs_punch_posteof(struct fuse2fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+/*
+ * Decide if file IO for this inode can use iomap.
+ *
+ * It turns out that libfuse creates internal node ids that have nothing to do
+ * with the ext2_ino_t that we give it.  These internal node ids are what
+ * actually gets igetted in the kernel, which means that there can be multiple
+ * fuse_inode objects in the kernel for a single hardlinked ondisk ext2 inode.
+ *
+ * What this means, horrifyingly, is that on a fuse filesystem that supports
+ * hard links, the in-kernel i_rwsem does not protect against concurrent writes
+ * between files that point to the same inode.  That in turn means that the
+ * file mode and size can get desynchronized between the multiple fuse_inode
+ * objects.  This also means that we cannot cache iomaps in the kernel AT ALL
+ * because the caches will get out of sync, leading to WARN_ONs from the iomap
+ * zeroing code and probably data corruption after that.
+ *
+ * Therefore, libfuse won't let us create hardlinks of iomap files, and we must
+ * never turn on iomap for existing hardlinked files.  Long term it means we
+ * have to find a way around this loss of functionality.  fuse4fs gets around
+ * this by being a low level fuse driver and controlling the nodeids itself.
+ *
+ * Returns 0 for no, 1 for yes, or a negative errno.
+ */
+#ifdef HAVE_FUSE_IOMAP
+static int fuse2fs_file_uses_iomap(struct fuse2fs *ff, ext2_ino_t ino)
+{
+	struct stat statbuf;
+	int ret;
+
+	if (!fuse2fs_iomap_enabled(ff))
+		return 0;
+
+	ret = stat_inode(ff->fs, ino, &statbuf);
+	if (ret)
+		return ret;
+
+	/* the kernel handles all block IO for us in iomap mode */
+	return fuse_fs_can_enable_iomap(&statbuf);
+}
+#else
+# define fuse2fs_file_uses_iomap(...)	(0)
+#endif
+
 static int fuse2fs_truncate(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 {
 	ext2_filsys fs = ff->fs;
 	ext2_file_t file;
 	__u64 old_isize;
 	errcode_t err;
+	int flags = EXT2_FILE_WRITE;
 	int ret = 0;
 
-	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &file);
+	/* the kernel handles all eof zeroing for us in iomap mode */
+	ret = fuse2fs_file_uses_iomap(ff, ino);
+	switch (ret) {
+	case 0:
+		break;
+	case 1:
+		flags |= EXT2_FILE_NOBLOCKIO;
+		ret = 0;
+		break;
+	default:
+		return ret;
+	}
+
+	err = ext2fs_file_open(fs, ino, flags, &file);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -3618,6 +3675,19 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 			goto out;
 	}
 
+	/* the kernel handles all block IO for us in iomap mode */
+	ret = fuse2fs_file_uses_iomap(ff, file->ino);
+	switch (ret) {
+	case 0:
+		break;
+	case 1:
+		file->open_flags |= EXT2_FILE_NOBLOCKIO;
+		ret = 0;
+		break;
+	default:
+		goto out;
+	}
+
 	if (fp->flags & O_TRUNC) {
 		ret = fuse2fs_truncate(ff, file->ino, 0);
 		if (ret)


