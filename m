Return-Path: <linux-fsdevel+bounces-78193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAkmAWznnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:49:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FDD17FFD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43BC030CA56E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C33803C6;
	Mon, 23 Feb 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgAUy/OM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7737FF57;
	Mon, 23 Feb 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890390; cv=none; b=MrJ5U7BoURvARLEluIq/+83T8cd4SNvAsMvS26TrglyVklFYRs0v1chb3fxYt1W7nUMC9fEDVBWczNJQR+ATufHHNo/cFBSLS9r0qPDbZEOPLAA3zoKe+vFV8I9/KOZgYm371t7UIQ82E2kGY37ZUUpuu/x5mKFe19iXMyZTDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890390; c=relaxed/simple;
	bh=iKwdM78UESvRs4jkIc0G1Sl3rAUVRHF+YbD4p3gK06s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoWQK+uasRwZWe0UEt6g1AxPTCdqnMPEmOHUaNaM/qdWDagFoDGPV534Rp3/MhGP390jk7HZuC+VsfELqHmP67jUX8tYBPTnn0gIkTEsjbnqebO09kWEr6/6U6ZyC1Ce6AWL/6SiNrLVu+UVW0V6e4shI8bySA5f0tRGiNZmyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgAUy/OM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343FDC116C6;
	Mon, 23 Feb 2026 23:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890390;
	bh=iKwdM78UESvRs4jkIc0G1Sl3rAUVRHF+YbD4p3gK06s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EgAUy/OMkTa00ASSM41AE2Q4hFdEBwPmw5RY3LLUkVoMmMM2PRNFdyizqzbprKXm1
	 pL8CUBZd9loELBDqkC+X8DF5Adn7EhxpPAuXov1SQ+P1FOCkoeCbv30FPvFwCv+wDV
	 +PsIeLmZuocWCxFBAbbcsh5fKOldZPmO8haHL3MvmBEv0Gp/aBzTgjDkEQIvmUMjo/
	 Lk2oh/ZYShsYkd0DIzfudl1OeSyYrWtPs52W75+/xXZB95Hqpyjkev7bQ7BErUnoVN
	 BYe4C5+4fCjIUeJ8DwuHqt9hd6rYQeOJRzDIhBdYLGQhj4+SjPOOh8xoKC1wm8vA4q
	 mZZpjFkCT8BfA==
Date: Mon, 23 Feb 2026 15:46:29 -0800
Subject: [PATCH 1/8] libext2fs: fix MMP code to work with unixfd IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745974.3944907.4030256558441414004.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
References: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78193-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 97FDD17FFD5
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

The MMP code wants to be able to read and write the MMP block directly
to storage so that the pagecache does not get in the way.  This is
critical for correct operation of MMP, because it is guarding against
two cluster nodes trying to change the filesystem at the same time.

Unfortunately there's no convenient way to tell an IO manager to perform
a particular IO in directio mode, so the MMP code open()s the filesystem
source device a second time so that it can set O_DIRECT and maintain its
own file position independently of the IO channel.  This is a gross
layering violation.

For unprivileged containerized fuse4fs, we're going to have a privileged
mount helper pass us the fd to the block device, so we'll be using the
unixfd IO manager.  Unfortunately, if the unixfd IO manager is in use,
the filesystem "source" will be a string representation of the fd
number, and MMP breaks.

Fix this (sort of) by detecting the unixfd IO manager and duplicating
the open fd if it's in use.  This adds a requirement that the unixfd
originally be opened in O_DIRECT mode if the filesystem is on a block
device, but that's the best we can do here.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fs.h |    1 +
 lib/ext2fs/mmp.c    |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 38d6074fdbbc87..23b0695a32d150 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -229,6 +229,7 @@ typedef struct ext2_file *ext2_file_t;
  * Internal flags for use by the ext2fs library only
  */
 #define EXT2_FLAG2_USE_FAKE_TIME	0x000000001
+#define EXT2_FLAG2_MMP_USE_IOCHANNEL	0x000000002
 
 /*
  * Special flag in the ext2 inode i_flag field that means that this is
diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index e2823732e2b6a2..5e7c0be5a48aeb 100644
--- a/lib/ext2fs/mmp.c
+++ b/lib/ext2fs/mmp.c
@@ -26,6 +26,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <limits.h>
 
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
@@ -48,6 +49,74 @@ errcode_t ext2fs_mmp_get_mem(ext2_filsys fs, void **ptr)
 	return ext2fs_get_memalign(fs->blocksize, align, ptr);
 }
 
+static int possibly_unixfd(ext2_filsys fs)
+{
+	char *endptr = NULL;
+
+	if (fs->io->manager == unixfd_io_manager)
+		return 1;
+
+	/*
+	 * Due to the possibility of stacking IO managers, it's possible that
+	 * there's a unixfd IO manager under all of this.  We can guess the
+	 * presence of one if the device_name is a string representation of an
+	 * integer (fd) number.
+	 */
+	errno = 0;
+	strtol(fs->device_name, &endptr, 10);
+	return !errno && endptr == fs->device_name + strlen(fs->device_name);
+}
+
+static int ext2fs_mmp_open_device(ext2_filsys fs, int flags)
+{
+	struct stat st;
+	int maybe_fd = -1;
+	int new_fd;
+	int want_directio = 1;
+	int ret;
+	errcode_t retval = 0;
+
+	/*
+	 * If the unixfd IO manager is in use, extract the fd number from the
+	 * unixfd IO manager so we can reuse it below.
+	 *
+	 * If that fails, fall back to opening the filesystem device, which is
+	 * the preferred method.
+	 */
+	if (possibly_unixfd(fs))
+		retval = io_channel_get_fd(fs->io, &maybe_fd);
+	if (retval || maybe_fd < 0)
+		return open(fs->device_name, flags);
+
+	/*
+	 * We extracted the fd from the unixfd IO manager.  Skip directio if
+	 * this is a regular file, just ext2fs_mmp_read does.
+	 */
+	ret = fstat(maybe_fd, &st);
+	if (ret == 0 && S_ISREG(st.st_mode))
+		want_directio = 0;
+
+	/* Duplicate the fd so that the MMP code can close it later */
+	new_fd = dup(maybe_fd);
+	if (new_fd < 0)
+		return -1;
+
+	/* Make sure we actually got directio if that's required */
+	if (want_directio) {
+		ret = fcntl(new_fd, F_GETFL);
+		if (ret < 0 || !(ret & O_DIRECT))
+			return -1;
+	}
+
+	/*
+	 * The MMP fd is a duplicate of the io channel fd, so we must use that
+	 * for all MMP block accesses because the two fds share the same file
+	 * position and O_DIRECT state.
+	 */
+	fs->flags2 |= EXT2_FLAG2_MMP_USE_IOCHANNEL;
+	return new_fd;
+}
+
 errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 {
 #ifdef CONFIG_MMP
@@ -77,7 +146,7 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 		    S_ISREG(st.st_mode))
 			flags &= ~O_DIRECT;
 
-		fs->mmp_fd = open(fs->device_name, flags);
+		fs->mmp_fd = ext2fs_mmp_open_device(fs, flags);
 		if (fs->mmp_fd < 0) {
 			retval = EXT2_ET_MMP_OPEN_DIRECT;
 			goto out;
@@ -90,6 +159,15 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 			return retval;
 	}
 
+	if (fs->flags2 & EXT2_FLAG2_MMP_USE_IOCHANNEL) {
+		retval = io_channel_read_blk64(fs->io, mmp_blk, -fs->blocksize,
+					       fs->mmp_cmp);
+		if (retval)
+			return retval;
+
+		goto read_compare;
+	}
+
 	if ((blk64_t) ext2fs_llseek(fs->mmp_fd, mmp_blk * fs->blocksize,
 				    SEEK_SET) !=
 	    mmp_blk * fs->blocksize) {
@@ -102,6 +180,7 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 		goto out;
 	}
 
+read_compare:
 	mmp_cmp = fs->mmp_cmp;
 
 	if (!(fs->flags & EXT2_FLAG_IGNORE_CSUM_ERRORS) &&
@@ -428,6 +507,7 @@ errcode_t ext2fs_mmp_stop(ext2_filsys fs)
 
 mmp_error:
 	if (fs->mmp_fd > 0) {
+		fs->flags2 &= ~EXT2_FLAG2_MMP_USE_IOCHANNEL;
 		close(fs->mmp_fd);
 		fs->mmp_fd = -1;
 	}


