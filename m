Return-Path: <linux-fsdevel+bounces-55382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91193B09863
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C13B0855
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B7241667;
	Thu, 17 Jul 2025 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE/B6oG7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53643BE46;
	Thu, 17 Jul 2025 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795845; cv=none; b=lGyPg8dJkiInwHZBKmdArOlzRZnaEEluDRt6D3GV49Dw7X6wI0/9j2U/8mKXX3IZ/evh3fBgiuu+jL9DJ6wCc1ZdOAvXuQsodHdNakfzV6DaTZOZjmOW+bSMrlIlJfs7K/JI32lwkfF7O6BGGTEDh9KkctIRs+6CIvO3A9mVDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795845; c=relaxed/simple;
	bh=Xdx0GgNTbTY06uuNTy56eDCF2iE60pc0JME4m9FV9Cg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSjIW11LzGcigIJQZlSob8pMFx8gvjtQJZJVkpdiA75QcMPOvO/L02BD8DHb34cBnPAe3H9wfSSbIw+Olht3sdVit7bncx/2GNtX2BsPvOLTHbC76ZyEvwrDRh3gExCDflnZvQVYrjR+6qHH1rM+1uRlFnwI5fiVnRwU4bIUfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE/B6oG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202FCC4CEE3;
	Thu, 17 Jul 2025 23:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795845;
	bh=Xdx0GgNTbTY06uuNTy56eDCF2iE60pc0JME4m9FV9Cg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YE/B6oG73tbLPmLyeCUNWwp+WZthrK498ByTTgsw9MiXFyXaA1dg6UHzE4WAR2dMB
	 JHZ8BEru539w+lnR8SUAfdDcZQDmI7WmgnmoqimqF/3fhNLvNhL8qVFTOvum3w7HHN
	 g8ZeaZ5I89hZAqOe3zkQ4zVaoPUB8MkR4fA4rtiGXvk8kjDnt0xywiri3eFh7BX90I
	 q1HN/U2JoWDb1T8MqZOuq/9bmDY/kMoL/HLTVcLMAtWZXLItG3Ci1ldR/MC5aWypOg
	 xJIJc3jkGemRrzsz4rQmmUbocoG1txuj1YzRpictah9xHPIIrrBkRcxLlxUSsAcJr9
	 kkQhKy7OaZJ4g==
Date: Thu, 17 Jul 2025 16:44:04 -0700
Subject: [PATCH 18/22] fuse2fs: don't allow hardlinks for now
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461359.715479.1220608915548013053.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

XXX see the comment for why we have to do this bellicosely stupid thing.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 82b59c1ac89774..e281b5fc589d82 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -261,6 +261,7 @@ struct fuse2fs {
 	uint8_t dirsync;
 	uint8_t unmount_in_destroy;
 	uint8_t noblkdev;
+	uint8_t can_hardlink;
 
 	enum fuse2fs_opstate opstate;
 	int blocklog;
@@ -1382,9 +1383,31 @@ static void *op_init(struct fuse_conn_info *conn
 	/*
 	 * If we're mounting in iomap mode, we need to unmount in op_destroy
 	 * so that the block device will be released before umount(2) returns.
+	 *
+	 * XXX: It turns out that fuse2fs creates internal node ids that have
+	 * nothing to do with the ext2_ino_t that we give it.  These internal
+	 * node ids are what actually gets igetted in the kernel, which means
+	 * that there can be multiple fuse_inode objects for the same fuse2fs
+	 * inode.
+	 *
+	 * What this means, horrifyingly, is that on a fuse filesystem that
+	 * supports hard links, the in-kernel i_rwsem does not protect against
+	 * concurrent writes between files that point to the same inode.  That
+	 * in turn means that the file mode and size can get desynchronized
+	 * between the multiple fuse_inode objects.  This also means that we
+	 * cannot cache iomaps in the kernel AT ALL because the caches will
+	 * get out of sync, leading to WARN_ONs from the iomap zeroing code and
+	 * probably data corruption after that.
+	 *
+	 * So for now we just disable hardlinking on iomap to see if the weird
+	 * fstests failures (particularly g/476) go away.  Long term it means
+	 * we probably have to find a way around this, like porting fuse2fs
+	 * to be a low level fuse driver.
 	 */
-	if (fuse2fs_iomap_enabled(ff))
+	if (fuse2fs_iomap_enabled(ff)) {
 		ff->unmount_in_destroy = 1;
+		ff->can_hardlink = 0;
+	}
 
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
 	if (ff->opstate == F2OP_WRITABLE) {
@@ -2751,6 +2774,10 @@ static int op_link(const char *src, const char *dest)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+
+	if (!ff->can_hardlink)
+		return -ENOSYS;
+
 	dbg_printf(ff, "%s: src=%s dest=%s\n", __func__, src, dest);
 	temp_path = strdup(dest);
 	if (!temp_path) {
@@ -6380,6 +6407,7 @@ int main(int argc, char *argv[])
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
+		.can_hardlink = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;


