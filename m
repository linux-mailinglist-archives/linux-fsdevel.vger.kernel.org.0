Return-Path: <linux-fsdevel+bounces-78158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGbNG8zknGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:37:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D411417FA79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01B083035E3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422037FF65;
	Mon, 23 Feb 2026 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By9tZMB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108637FF53;
	Mon, 23 Feb 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889856; cv=none; b=AX2YmZfdn80hAws0XOWkRFazwgjCQvQ211NG1YPaBtOgFLT4jzF8RvsmOKFL1QtrYRALdZ8JzMD4H/aGCwVYOhrX15WPOPRRQqQHOOU3SlrlB0CrUOcXrpncw3rJLGYKFa791EZVWpmKnFNww7tuCr/X7Q9BgakJCSAqTs73mAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889856; c=relaxed/simple;
	bh=TmfdLdJ90U+0Xz+6VAwAI3ZPGFylW87DWQJtRz6o0v8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNvxZRRV1Jm1DAtc2REBrR6o0glyQBzjChnGWpnbgccKleJQWiwudc4qgT6rhFJRRpG7+4PQe1PaPLeYAvzys2gvy3UBLjp8Clw+RORe6v5xjIBdTmOSx/p8MN3UM4swoagiZ5p5q1GLJ8YWcM8ykeDaFlHvx1DOAtr16MDneyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By9tZMB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962A2C2BC9E;
	Mon, 23 Feb 2026 23:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889856;
	bh=TmfdLdJ90U+0Xz+6VAwAI3ZPGFylW87DWQJtRz6o0v8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=By9tZMB3NjKnOD23ECHCgumAnOktX+QftrohxQNpbk5eYEMtyBeudpq33Dk8MzX10
	 UcE4yImcrSkGytlA/AIRxTigzM4J9WGmcyhFDzPLr+zZGNiuVbXWn1RJc9k4DH84H4
	 fn+TbTQ3aW5Gt80YsNPELPQSlql89IlDRXmz89DnSmdPdlTsTHxn0N5z5BOJmJi9Ea
	 7Ghf4RbWtjh57odqu2USq7RsWmon8XnPLUGUjnQxUJwoFuox9hiUOJnbbeAvm26m/y
	 Mj9C5Ppti+PsHfssTxnsow7BFW8yW/9UG7P39ukQ+iroDKtUqDn+JxOZMNJTZjTdrk
	 cbNqaQBdQQ03w==
Date: Mon, 23 Feb 2026 15:37:36 -0800
Subject: [PATCH 06/19] fuse2fs: add extent dump function for debugging
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744588.3943178.5688826507033111017.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78158-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: D411417FA79
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add a function to dump an inode's extent map for debugging purposes.
This helped debug a problem with generic/299 failing on 1k fsblock
filesystems:

 --- a/tests/generic/299.out	2025-07-15 14:45:15.030113607 -0700
 +++ b/tests/generic/299.out.bad	2025-07-16 19:33:50.889344998 -0700
 @@ -3,3 +3,4 @@ QA output created by 299
  Run fio with random aio-dio pattern

  Start fallocate/truncate loop
 +fio: io_u error on file /opt/direct_aio.0.0: Input/output error: write offset=2602827776, buflen=131072

(The cause of this was misuse of the libext2fs extent code)

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 9fa875d1d99ae8..9d434294613d0d 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -889,6 +889,74 @@ static inline int fuse4fs_iomap_enabled(const struct fuse4fs *ff)
 # define fuse4fs_iomap_enabled(...)	(0)
 #endif
 
+static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
+					struct ext2_inode_large *inode,
+					const char *why)
+{
+	ext2_filsys fs = ff->fs;
+	unsigned int nr = 0;
+	blk64_t blockcount = 0;
+	struct ext2_inode_large xinode;
+	struct ext2fs_extent extent;
+	ext2_extent_handle_t extents;
+	int op = EXT2_EXTENT_ROOT;
+	errcode_t retval;
+
+	if (!inode) {
+		inode = &xinode;
+
+		retval = fuse4fs_read_inode(fs, ino, inode);
+		if (retval) {
+			com_err(__func__, retval, _("reading ino %u"), ino);
+			return;
+		}
+	}
+
+	if (!(inode->i_flags & EXT4_EXTENTS_FL))
+		return;
+
+	printf("%s: %s ino=%u isize %llu iblocks %llu\n", __func__, why, ino,
+	       EXT2_I_SIZE(inode),
+	       (ext2fs_get_stat_i_blocks(fs, EXT2_INODE(inode)) * 512) /
+	        fs->blocksize);
+	fflush(stdout);
+
+	retval = ext2fs_extent_open(fs, ino, &extents);
+	if (retval) {
+		com_err(__func__, retval, _("opening extents of ino \"%u\""),
+			ino);
+		return;
+	}
+
+	while ((retval = ext2fs_extent_get(extents, op, &extent)) == 0) {
+		op = EXT2_EXTENT_NEXT;
+
+		if (extent.e_flags & EXT2_EXTENT_FLAGS_SECOND_VISIT)
+			continue;
+
+		printf("[%u]: %s ino=%u lblk 0x%llx pblk 0x%llx len 0x%x flags 0x%x\n",
+		       nr++, why, ino, extent.e_lblk, extent.e_pblk,
+		       extent.e_len, extent.e_flags);
+		fflush(stdout);
+		if (extent.e_flags & EXT2_EXTENT_FLAGS_LEAF)
+			blockcount += extent.e_len;
+		else
+			blockcount++;
+	}
+	if (retval == EXT2_ET_EXTENT_NO_NEXT)
+		retval = 0;
+	if (retval) {
+		com_err(__func__, retval, ("getting extents of ino %u"),
+			ino);
+	}
+	if (inode->i_file_acl)
+		blockcount++;
+	printf("%s: %s sum(e_len) %llu\n", __func__, why, blockcount);
+	fflush(stdout);
+
+	ext2fs_extent_free(extents);
+}
+
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME
@@ -6225,6 +6293,8 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 
 	/* Not filling even the first byte will make the kernel unhappy. */
 	if (read.offset > pos || read.offset + read.length <= pos) {
+		if (ff->debug)
+			fuse4fs_dump_extents(ff, ino, &inode, "BAD DATA");
 		ret = translate_error(fs, ino, EXT2_ET_INODE_CORRUPTED);
 		goto out_unlock;
 	}
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a5105855f1669a..a039d2af0201ff 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -728,6 +728,74 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
 # define fuse2fs_iomap_enabled(...)	(0)
 #endif
 
+static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
+					struct ext2_inode_large *inode,
+					const char *why)
+{
+	ext2_filsys fs = ff->fs;
+	unsigned int nr = 0;
+	blk64_t blockcount = 0;
+	struct ext2_inode_large xinode;
+	struct ext2fs_extent extent;
+	ext2_extent_handle_t extents;
+	int op = EXT2_EXTENT_ROOT;
+	errcode_t retval;
+
+	if (!inode) {
+		inode = &xinode;
+
+		retval = fuse2fs_read_inode(fs, ino, inode);
+		if (retval) {
+			com_err(__func__, retval, _("reading ino %u"), ino);
+			return;
+		}
+	}
+
+	if (!(inode->i_flags & EXT4_EXTENTS_FL))
+		return;
+
+	printf("%s: %s ino=%u isize %llu iblocks %llu\n", __func__, why, ino,
+	       EXT2_I_SIZE(inode),
+	       (ext2fs_get_stat_i_blocks(fs, EXT2_INODE(inode)) * 512) /
+	        fs->blocksize);
+	fflush(stdout);
+
+	retval = ext2fs_extent_open(fs, ino, &extents);
+	if (retval) {
+		com_err(__func__, retval, _("opening extents of ino \"%u\""),
+			ino);
+		return;
+	}
+
+	while ((retval = ext2fs_extent_get(extents, op, &extent)) == 0) {
+		op = EXT2_EXTENT_NEXT;
+
+		if (extent.e_flags & EXT2_EXTENT_FLAGS_SECOND_VISIT)
+			continue;
+
+		printf("[%u]: %s ino=%u lblk 0x%llx pblk 0x%llx len 0x%x flags 0x%x\n",
+		       nr++, why, ino, extent.e_lblk, extent.e_pblk,
+		       extent.e_len, extent.e_flags);
+		fflush(stdout);
+		if (extent.e_flags & EXT2_EXTENT_FLAGS_LEAF)
+			blockcount += extent.e_len;
+		else
+			blockcount++;
+	}
+	if (retval == EXT2_ET_EXTENT_NO_NEXT)
+		retval = 0;
+	if (retval) {
+		com_err(__func__, retval, ("getting extents of ino %u"),
+			ino);
+	}
+	if (inode->i_file_acl)
+		blockcount++;
+	printf("%s: %s sum(e_len) %llu\n", __func__, why, blockcount);
+	fflush(stdout);
+
+	ext2fs_extent_free(extents);
+}
+
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME
@@ -5673,6 +5741,8 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 
 	/* Not filling even the first byte will make the kernel unhappy. */
 	if (read->offset > pos || read->offset + read->length <= pos) {
+		if (ff->debug)
+			fuse2fs_dump_extents(ff, attr_ino, &inode, "BAD DATA");
 		ret = translate_error(fs, attr_ino, EXT2_ET_INODE_CORRUPTED);
 		goto out_unlock;
 	}


