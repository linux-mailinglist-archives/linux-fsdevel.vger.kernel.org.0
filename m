Return-Path: <linux-fsdevel+bounces-15876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE08954DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CD1B2461F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BF84FB8;
	Tue,  2 Apr 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ra5rTJra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03E84FA0;
	Tue,  2 Apr 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063464; cv=none; b=X84UypSy5Rf8PdNtsHs3pXY3OvPUC08Up3tljtGgUXxHAgLf2zJCmLaGCl8K014DOupLnq/YqsGe25fxQ8kW4HsPvcYuUjAoeyOoiTkGcrUpCvEaNRsj/rWOo7QOab1ndWVjfhBJwkXzS8s9g2WCXbkZNVPM3tqJkAnjfteaIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063464; c=relaxed/simple;
	bh=z5ftgWu8Ra0zpOJ1b9c3WKlj8qgG1oMSVZZQwaE7zsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rkE2Tm7fTTalJBGasUU9B/AVVDVXBT7dMIp1gnAAjYLR2gT6T1E88DvpB+nEhiPiRWIYqZPdArG9SoIG2GdINMaW/VNwpGKLPgb6CLDM6XqiqyFKGKSn8nHoRgoNDaF5mf+S0fsEuHpMc6src1hFusX+/kjjqmJlVSY22i2XCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ra5rTJra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DBAC433C7;
	Tue,  2 Apr 2024 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712063464;
	bh=z5ftgWu8Ra0zpOJ1b9c3WKlj8qgG1oMSVZZQwaE7zsU=;
	h=From:Date:Subject:To:Cc:From;
	b=ra5rTJraG+89L9ZWvJvdB3sz4/wSDPqC2yO9IyYSCCLiVVqrLyZ7bztknKfHGM4wB
	 Pihv6dT2oXClDocCbTNwkUWw/pgKH1Pjc/BUe8YICVBboQEiEYIoD20chIMvRNFyL5
	 n63+A3hvrxI2GTTHzjlsSGKiDRKbGTK95ERrccH4oeRWfYd+LYQOTCOR+HD8e54ihI
	 baUKCwAfjIxbdd2FuI/Ue9VGyWgk8kSJTZPoSscz1gFXUQqtDat9Sfvup1Ymug3OBO
	 TuIOM8ioidwlanbp7eQl+KWQU7eIiDAfn/FheZmRixfZxW971raFR+bNrral/q3SGt
	 L8buvO5K02nvw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 02 Apr 2024 09:10:59 -0400
Subject: [PATCH v2] fuse: allow FUSE drivers to declare themselves free
 from outside changes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOIDDGYC/23MQQ6DIBSE4auYty4NoAbbVe/RuEAcldSAAUPaG
 O5e6rrLfzL5DooIFpHu1UEByUbrXQl5qcgs2s1gdixNksuG1+LGIvYVOoIZ1GIaOqXUwKnct4D
 Jvk/q2ZdebNx9+JxyEr/1D5IEE6wxaLWUHF07Pl4IDuvVh5n6nPMXJU0/BaEAAAA=
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4466; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=z5ftgWu8Ra0zpOJ1b9c3WKlj8qgG1oMSVZZQwaE7zsU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmDAPnXJvae21imEUXw9IWkX/IlcYgW2n9bbmh8
 oVoswE2n62JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZgwD5wAKCRAADmhBGVaC
 FQUEEACgR+cPI6gQDVV2g2uLq3sQMUiJZ9WN1lXUi71fPAfcYQuVNdzX2DzvA9QimmAMhD7TL3n
 oEM9oXNh6DerUHXiXjVAHswIs8nOAMb52t4mBglzBmKaGnxGkiBx0DPJg9GIFNWWdCIkYWQzQ1a
 RG0MVGo0tKCybBe6VR0f6JycPBC4Cd2vyiRvWISICWVyBiDYwvh3rnViyvb2n4cCufejLMyvdl0
 azVzW3PUWKrYra9oITvj8WYvVos73tOqpInUcn6ukPLeGb82/cyikKGP8lxEG4PoO72jtV0HWK+
 3eB3C96vudLDKnSV9MoOorhYxGdOlVm9DtLPTNae/BpeV9SCsB39dtXGg4+ns02s1SPNOQV3Fi0
 7O0RYoAvI9BrhFvszwyo3rQGNWKqjB0LDfbKD/DXFk4k6ppp+n0Lr8EebZyNyYNnAYuy35SDC9c
 C66I/JbMrQoFwZRJ6/xBiXGARtW6Nc5FudpdJZdYRwMOO+8877VH+pwEDjKDt1v3BtoDR8atyTE
 lsgV75VsaY/mALD2mdvM7QedCXtHs9xNb9PltM4ZHnd8RILcXpC08H3HfIQZU4yojJgnz/N2Znx
 9eGt6iWoMv28ghNhwKx6NV6dG8LWdj4rNVmjGJvbQrYvzBEW2vaW/NtmBl47MpqJRpQLyPjb4qc
 qihsHoB6aXduPUw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Traditionally, we've allowed people to set leases on FUSE inodes.  Some
FUSE drivers are effectively local filesystems and should be fine with
kernel-internal lease support. Others are backed by a network server
that may have multiple clients, or may be backed by something non-file
like entirely. On those, we don't want to allow leases.

Have the filesytem driver to set a fuse_conn flag to indicate whether
the inodes are subject to outside changes, not done via kernel APIs.  If
the flag is unset (the default), then setlease attempts will fail with
-EINVAL, indicating that leases aren't supported on that inode.

Local-ish filesystems may want to start setting this value to true to
preserve the ability to set leases.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This is only tested for compilation, but it's fairly straightforward.

I've left the default the "safe" value of false, so that we assume that
outside changes are possible unless told otherwise.
---
Changes in v2:
- renamed flag to FUSE_NO_OUTSIDE_CHANGES
- flesh out comment describing the new flag
---
 fs/fuse/file.c            | 11 +++++++++++
 fs/fuse/fuse_i.h          |  5 +++++
 fs/fuse/inode.c           |  4 +++-
 include/uapi/linux/fuse.h |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a56e7bffd000..79c7152c0d12 100644
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
+	if (fc->no_outside_changes)
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
index b24084b60864..49d44a07b0db 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -860,6 +860,11 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/** Can we assume that the only changes will be done via the local
+	 *  kernel? If the driver represents a network filesystem or is a front
+	 *  for data that can change on its own, set this to false. */
+	unsigned int no_outside_changes:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3a5d88878335..f33aedccdb26 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1330,6 +1330,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+			if (flags & FUSE_NO_OUTSIDE_CHANGES)
+				fc->no_outside_changes = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1377,7 +1379,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_NO_OUTSIDE_CHANGES;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..703d149d45ff 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -463,6 +463,7 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH	(1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
 #define FUSE_HAS_RESEND		(1ULL << 39)
+#define FUSE_NO_OUTSIDE_CHANGES	(1ULL << 40)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP

---
base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
change-id: 20240319-setlease-ce31fb8777b0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


