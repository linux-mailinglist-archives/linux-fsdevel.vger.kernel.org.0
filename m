Return-Path: <linux-fsdevel+bounces-66120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57781C17D04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55BB24FA4BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0CD2DA75C;
	Wed, 29 Oct 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8fRyteY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3526CE02;
	Wed, 29 Oct 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700545; cv=none; b=fiseV+htSUPSPF4+/gjb/dmGFvhic7d55mXHGUvFHdPA2bSxiSrOji/daaCPvT4LbsherEAehiwVEfZSEu6AhCtIXk5bh3BLgKH6I2aFFaUWp+zehYNsACRBKDAkpXpBWEC6UHcd4iYw50OxadxJ8TCq/tx9veT5oqlaMuj1o0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700545; c=relaxed/simple;
	bh=bCycYQj7wjDYLi/0ss9Q/QEDoGgg7SCtfh3XnDbAAxM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8VkJ88XULntvyPzu8hf9KINLtmtZMcd1q0nNLE/ABOfUthNofoUrjqcfL0EgVQMouI6hGP3d5ObbHLeVg8UaKLmiH0IOI6o7/2/i3oEZ1+62kwi3apyAtjdl6dK4nWy1HpKh67hrJ+rHOF5LvkyFdAxY20bvtjbg47PnIkv7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8fRyteY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9E7C4CEE7;
	Wed, 29 Oct 2025 01:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700544;
	bh=bCycYQj7wjDYLi/0ss9Q/QEDoGgg7SCtfh3XnDbAAxM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=M8fRyteY6BGN1TE6hUhWOfwktnycwLNEsGQsGT7jkGOrItmP464SbnjEdiFrip5tT
	 Fk79DlGEdeaWFgPMMtrWEkKk79OnazPYm0H4t47kY1y3mBoNN+Bfoe7zPI+HIN0qoT
	 MoprAOwBYvjj8NDp5QIJLsEFoco9eZyBAR4Pa5N0ElovKbG8i3gilv3nVkfD+9gA4T
	 CQkruBIDYsNI3+dKszfeN5rdv3mijraoZDzMVfgqkD7mXDUOacrM+h8BOAuJgV29t+
	 nQOz5gUsBpuiuI2B0WYDUN6HVPsur22wzjuVDumwaKNDAaF/yU3CvyF+O0MBhpPmr0
	 SDM5SaQOuxSqQ==
Date: Tue, 28 Oct 2025 18:15:44 -0700
Subject: [PATCH 09/11] fuse2fs: skip the gdt write in op_destroy if syncfs is
 working
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818387.1430380.2413109895614955629.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
References: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

As an umount-time performance enhancement, don't bother to write the
group descriptor tables in op_destroy if we know that op_syncfs will do
it for us.  That only happens if iomap is enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   19 ++++++++++++++++---
 misc/fuse2fs.c    |   19 ++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index ac8696aab65af4..e6a96717dfe415 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -275,6 +275,7 @@ struct fuse4fs {
 	int dirsync;
 	int translate_inums;
 	int iomap_passthrough_options;
+	int write_gdt_on_destroy;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -1840,9 +1841,11 @@ static void op_destroy(void *userdata)
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_set_gdt_csum(fs);
-		if (err)
-			translate_error(fs, 0, err);
+		if (ff->write_gdt_on_destroy) {
+			err = ext2fs_set_gdt_csum(fs);
+			if (err)
+				translate_error(fs, 0, err);
+		}
 
 		err = ext2fs_flush2(fs, 0);
 		if (err)
@@ -6301,6 +6304,15 @@ static void op_syncfs(fuse_req_t req, fuse_ino_t ino)
 		}
 	}
 
+	/*
+	 * When iomap is enabled, the kernel will call syncfs right before
+	 * calling the destroy method.  If any syncfs succeeds, then we know
+	 * that there will be a last syncfs and that it will write the GDT, so
+	 * destroy doesn't need to waste time doing that.
+	 */
+	if (fuse4fs_iomap_enabled(ff))
+		ff->write_gdt_on_destroy = 0;
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	fuse_reply_err(req, -ret);
@@ -8051,6 +8063,7 @@ int main(int argc, char *argv[])
 		.loop_fd = -1,
 #endif
 		.translate_inums = 1,
+		.write_gdt_on_destroy = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b6ede4bcb32c27..91b48f5d68b0db 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -268,6 +268,7 @@ struct fuse2fs {
 	int acl;
 	int dirsync;
 	int iomap_passthrough_options;
+	int write_gdt_on_destroy;
 
 	enum fuse2fs_opstate opstate;
 	int logfd;
@@ -1667,9 +1668,11 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_set_gdt_csum(fs);
-		if (err)
-			translate_error(fs, 0, err);
+		if (ff->write_gdt_on_destroy) {
+			err = ext2fs_set_gdt_csum(fs);
+			if (err)
+				translate_error(fs, 0, err);
+		}
 
 		err = ext2fs_flush2(fs, 0);
 		if (err)
@@ -5858,6 +5861,15 @@ static int op_syncfs(const char *path)
 		}
 	}
 
+	/*
+	 * When iomap is enabled, the kernel will call syncfs right before
+	 * calling the destroy method.  If any syncfs succeeds, then we know
+	 * that there will be a last syncfs and that it will write the GDT, so
+	 * destroy doesn't need to waste time doing that.
+	 */
+	if (fuse2fs_iomap_enabled(ff))
+		ff->write_gdt_on_destroy = 0;
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -7494,6 +7506,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_LOOPDEV
 		.loop_fd = -1,
 #endif
+		.write_gdt_on_destroy = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;


