Return-Path: <linux-fsdevel+bounces-14827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A878802C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 17:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53A71F232EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCCF1171C;
	Tue, 19 Mar 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxEk8weW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FE107A8;
	Tue, 19 Mar 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867261; cv=none; b=D/CqupUI+qx3NsSGe7mjQ70Rn1yBSx33exe5vUTv7yl1gLCwUgrKbJZe6orVf8U7hSK4YpaiUXy2N27XDkhTn+pl8cIHP9SKOSUfg56tQ1cHOp6CSKj0sEaxeWr57hotr+wdyf2nrPEknbmBlSlm02ATyxO7Zy4bXEPYME6PckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867261; c=relaxed/simple;
	bh=lsmWXqc/oG1VFxbUIqmk9BpXGRBnQwV/KmX9HD+0fNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=geKKnZ5SzVfZY/lDT0g88MEd7GyzJXdGOrqjYNbZ51k1Fwm+3upLRlg7szDSSVhNFjXvg3brPRGd7HWrI0NSfpvvpIAg7OU5rmFteqeLUDAd1tb8sdnM0+n1jJO9MmvkZ8JcZitZxwR7la70kvBYIjG6YtTzfsSY400XHUhHhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxEk8weW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C378C43390;
	Tue, 19 Mar 2024 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710867260;
	bh=lsmWXqc/oG1VFxbUIqmk9BpXGRBnQwV/KmX9HD+0fNg=;
	h=From:Date:Subject:To:Cc:From;
	b=GxEk8weWJTxTmRDFmrAtiD+yNaVWypG9b8AgrzDImxrX/+JFpI4JXHN9Km/9R5XQx
	 3EP7pZJdncQAJOIF2+4GafbEXAzqAyt0VCAr3rnJ1XkxuvNXG7sjxTuVj0lSvCfGB+
	 UAzP3TRy/oqKO50q1xES15ZnNCxdhqdSKae/hoaVAECPPlrCtBnmTqjiImevf8HwiR
	 jx+0Z50kPlmcY+dwv3MFoh9JOZQN2kmI8FqeemuYkjCTxxZhmSbyOhHEL9KPgAPlMg
	 P8FK/6TBpHRzuFEcUFGKe0Eoub1l0ett0FE5DuP8JgQ14q69UfsWCmuJpNjQCY9Ebg
	 RlChbzcfrBYdg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 19 Mar 2024 12:54:06 -0400
Subject: [PATCH RFC] fuse: require FUSE drivers to opt-in for local file
 leases
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-setlease-v1-1-4ce5a220e85d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC3D+WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0NL3eLUkpzUxOJU3eRUY8O0JAtzc/MkAyWg8oKi1LTMCrBR0UpBbs5
 KsbW1AMMzpSlfAAAA
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4024; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lsmWXqc/oG1VFxbUIqmk9BpXGRBnQwV/KmX9HD+0fNg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl+cM8IwbAtLw42Ucy+GwU7TzsHITwfQ3Wm6Onk
 6YHXx80r4yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfnDPAAKCRAADmhBGVaC
 FcDmD/4jgJ0rpBqYOEn92ALtNI6m8pHHu9fpJfPIuXKbxCWP9A3dmGTWpN45tRGnzrkntcq091j
 3mBIaUFllKcLjFgqkzEkCn5zdrYgY75dPLjZcyduX/Mzb5oqf1vHtE15cojIIgNNJo2qSd/xuQD
 rA78DQxhYFFreMd1a3j2bUw/CCYDADTiq+7sdrrZCt5xBmdTimuyAkbDeAvIxEwaVRYgc+IMiot
 702XQVNvEDmsq2ho3uSOa4jjc9TNQjrRYJGn024N18cHb9gSfGA4G1lSe0/xtqIC3NbmkIzR5K2
 jK64cHgj3AEuTNEKtMAWBPZVh2YS9OMKaSs4H12vP2ZLM9YErcOyhq5fpcBS7fziMnMF3C5CrN7
 wZokDOvmwDpys7IsqWMLnt7zikknJy8p/shAtOREiLkxxFkRHxiWxpH7Xetl1vCrjaeplPQHWHd
 YgpMZAOpNwViXI6BGVAy7RJbKC5gNUiFYbGpu6/LysEkCNu5y0hc5hX3lG3A1S01AsTEG79sj9C
 SCX8S1Hyi/Ac/vVg4kqmkAqpebGSqtdgvnemWrg1PWZT4SYBdsz5kbFk85ar6e+D/kjw0pbSEEj
 0QSXOg/rsewCBCJi5M3IRtk8X/CayEbOLsHzIfGOU1IVclxirZuak2rlGdTVIoQVGsv4zSVVWwh
 aa3wiid+ec2rxtg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Traditionally, we've allowed people to set leases on FUSE inodes.  Some
FUSE drivers are effectively local filesystems and should be fine with
kernel-internal lease support. But others are backed by a network server
that may have multiple clients, or may be backed by something non-file
like entirely.

Have the filesytem driver to set a fuse_conn flag to indicate whether it
wants support for local, in-kernel leases. If the flag is unset (the
default), then setlease attempts will fail with -EINVAL, indicating that
leases aren't supported on that inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This is only tested for compilation, but it's fairly straightforward.
Having the FUSE drivers opt-out of this support might be more
backward-compatible, but that is a bit more dangerous. I'd rather driver
maintainer consciously opt-in.
---
 fs/fuse/file.c            | 11 +++++++++++
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           |  4 +++-
 include/uapi/linux/fuse.h |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a56e7bffd000..3d9aef376783 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3298,6 +3298,16 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
+static int fuse_setlease(struct file *file, int arg,
+			 struct file_lease **flp, void **priv)
+{
+	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
+
+	if (fc->local_leases)
+		return generic_setlease(file, arg, flp, priv);
+	return -EINVAL;
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
@@ -3317,6 +3327,7 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+	.setlease	= fuse_setlease,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b24084b60864..2909788bf69f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -860,6 +860,9 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/** Opt-in to local kernel lease support */
+	unsigned int local_leases:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3a5d88878335..6958c7690e68 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1330,6 +1330,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+			if (flags & FUSE_LOCAL_LEASES)
+				fc->local_leases = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1377,7 +1379,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_LOCAL_LEASES;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..76322808159d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -463,6 +463,7 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH	(1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
 #define FUSE_HAS_RESEND		(1ULL << 39)
+#define FUSE_LOCAL_LEASES	(1ULL << 40)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP

---
base-commit: 0a7b0acecea273c8816f4f5b0e189989470404cf
change-id: 20240319-setlease-ce31fb8777b0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


