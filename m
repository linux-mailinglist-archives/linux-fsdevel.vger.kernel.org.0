Return-Path: <linux-fsdevel+bounces-55381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77526B09861
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B83D7BCD34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C1241667;
	Thu, 17 Jul 2025 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttGTfpiR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD5BE46;
	Thu, 17 Jul 2025 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795829; cv=none; b=MGwE77YMQJtb6kShT+ggzDKfnDpzYDQQAMgqn77tSN/k/nBvTQTHqiD1LLoR6iIkcCikL1W1uxGh0A4Bq6HPO7vmSFc/w03Q3Ik16kiyIHEznGcfPPX1YOi+jN5nrHStSIdN5RlykWNvEPX9UT21XLd4oVz2Dp1vMO5zkLdwpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795829; c=relaxed/simple;
	bh=r39/AFST8YToDzIeWDd1LyZh5pZHTJPE/Jqy6klZP9A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7yQio3bym7fYrrNKN4hPceyAfPCYT1pzkRCg4P68wfHCGIf8D2HwQYtzHKpqXCFhLu0K+UcvFz92bXTyMbkMzgaYSd2DqYNOkZ4hQHQ+QuRRIfmA4W5iW2HgDFo+n+RrekeMOKsOoXj8Ry5YdMzK6mHPWt/C1OxIIHRP0UaGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttGTfpiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EA1C4CEE3;
	Thu, 17 Jul 2025 23:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795829;
	bh=r39/AFST8YToDzIeWDd1LyZh5pZHTJPE/Jqy6klZP9A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ttGTfpiRzF60k8LcL5Gq6c1kizwGqQIzx/VFVk+gXLeXeUhesA+PgQg697HHw0XPP
	 DOA2zoHVWx1xZ0MJ1Rnt52sm1BO2eiw/e8SRYSvo/hJvzc8zNBAQ2gTF78fZsgLTCw
	 o5JiOb6DyCFBXW6s7F/PFJzbWZv6QBnyv4IYo0SsfoWC7t0DEr9aqPgKVlfEX2M8yv
	 VO+232UgulRQNNqopQXHjKTlqJUA8/NgyLEY0VrbA5338JLtVO69UU1jqJzJUabGPh
	 1nSaIm5tXDvddsW+ojJ6vWspGfZumAuwxFgARI6DXXy/V719m+//PG9DpiOmQfzVdd
	 pVA06Zg4WHoMg==
Date: Thu, 17 Jul 2025 16:43:48 -0700
Subject: [PATCH 17/22] fuse2fs: avoid fuseblk mode if fuse-iomap support is
 likely
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461340.715479.12244748944041540648.stgit@frogsfrogsfrogs>
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

Since fuse in iomap mode guarantees that op_destroy will be called
before umount returns, we don't need to use fuseblk mode to get that
guarantee.  Disable fuseblk mode, which saves us the trouble of closing
and reopening the device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9a62971f8dbba7..82b59c1ac89774 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -982,6 +982,8 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
+	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+
 	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
 			   &ff->fs);
 	if (err == EPERM) {
@@ -6333,10 +6335,24 @@ static unsigned long long default_cache_size(void)
 	return ret;
 }
 
+#ifdef HAVE_FUSE_IOMAP
+static inline bool fuse2fs_discover_iomap(const struct fuse2fs *ff)
+{
+	if (ff->iomap_want == FT_DISABLE)
+		return false;
+
+	return fuse_discover_iomap();
+}
+#else
+# define fuse2fs_discover_iomap(...)	(false)
+#endif
+
 static inline bool fuse2fs_want_fuseblk(const struct fuse2fs *ff)
 {
 	if (ff->noblkdev)
 		return false;
+	if (fuse2fs_discover_iomap(ff))
+		return false;
 
 	return fuse2fs_on_bdev(ff);
 }
@@ -6499,6 +6515,12 @@ int main(int argc, char *argv[])
 		 * device) so that unmount will wait until op_destroy
 		 * completes.  If this is not a block device, we cannot use
 		 * fuseblk mode and should leave the filesystem open.
+		 *
+		 * However, fuse+iomap guarantees that op_destroy is called
+		 * before the filesystem is unmounted, so we don't need fuseblk
+		 * mode.  This save us the trouble of reopening the filesystem
+		 * later, and means that fuse2fs itself owns the exclusive lock
+		 * on the block device.
 		 */
 		fuse2fs_unmount(&fctx);
 


