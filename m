Return-Path: <linux-fsdevel+bounces-33970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AD9C1098
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 22:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A134B1C223E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22922802E;
	Thu,  7 Nov 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5NtMwQT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9F227BBB;
	Thu,  7 Nov 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013220; cv=none; b=sQEoiQb4MQQmMN4nbA1inO22LclhzHvQPpvODUx/IkWRJ7gEFIj9CX5eusULV70GiO6U9a3tqeLklYD2uisUtBCIAwqmnFzijm+wGk9E7Egu5XghWiUtlyU2XciA1LITrGyvlgGQWz1jRXQP2DfuoJHiibYQLFOsJR397fDIHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013220; c=relaxed/simple;
	bh=fFV4+prDlDx7/xm+7DYBnLH7Y9242fu/tFlQKE+ZzNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9KAgxPAN8BnoZqGQYzDHVdS1qHFltHXQb+aTwmm4r4iFqKiTsxtxguNL6UWBHpLBRMyBgcjSfZI8KY/YDbOoO2zcEx7v2W6rtIXhaFF8FqXuBLKHJXnNYuBoxbFwTrbknP3dATGmKFH+NYxbTQb6q6GjvjR4Vvioq+6QQGuBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5NtMwQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A1CC4CED4;
	Thu,  7 Nov 2024 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731013219;
	bh=fFV4+prDlDx7/xm+7DYBnLH7Y9242fu/tFlQKE+ZzNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h5NtMwQTMeVw5jnN0sF52dxAw6Ljx9QJaB0RsshTORI3o1FJABNSajKu3IxtHfbp7
	 cjZWuhHi7NCdYYu7DK39ZAMii3Xr4x9+Cgjq0uOlh8XgBXGuh+Bio8m72Bc21ErZ7H
	 aIBft6Sy5L4F+lPA36WGsjVvefA0dSdmmLePE7VpYbLi7VDykKNBjNddzFMublFKKo
	 acwuaDJBS/G8wbmkodc0rKkoyOwXJAdFhm8GMSJD4TXB/g5uy2o4v4w6ypPRayd4zJ
	 XA31nxQj713gFVk4Le9vlE9jZFPEAFiGjW2vsjVGLyKL1E7C0/3p/YhwBXbHVSeggk
	 S5iAhosq2PamA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 07 Nov 2024 16:00:07 -0500
Subject: [PATCH v3 2/2] fs: add the ability for statmount() to report the
 mnt_devname
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-statmount-v3-2-da5b9744c121@kernel.org>
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
In-Reply-To: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3899; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fFV4+prDlDx7/xm+7DYBnLH7Y9242fu/tFlQKE+ZzNg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnLSpgu+dQtyWXLsC8tfCTuaArcNvBOte92SNN6
 qtC/2NUO3eJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZy0qYAAKCRAADmhBGVaC
 FXysD/97HnQ/uSr74GpOmLPZQPEwa3xrTdqIkL/H+zMzpaGQlZl7iahTdelIxungZ6Khni9mcSs
 X7tifNInv7M+NeYrC6BJ1WkPXfH5IgHrQ+K7oadsRWWc0aJ+k7kjqW4BZGw3Rgp2wFsid/C7pQ5
 ER5NtUQ+H6kPcqZi05fyvki4U+iTCz9MIRXpT9TCeRnad91XEvjRepBX3w8LYGoL94umHyf66dz
 9pXSkrSw3fM4VUhNkO9wA/OgfsDAnIYHw/Q90fTtMI/IFQS1YX8ejs4wNS3hehUzT5vJeaSlSOL
 8AHMn/x2nBKnUcbQaD5SUSFBAj2r80nF4gCpV1vaYqWRwISgjOwqfZ6L4Aas3N+BOMvTysaeXOH
 /xc6ixRRXGO59PwJz9YAYFrDhti9heuAts6ZpGrbBtKNPS6dHiQHD0ZrVf4yT7yH/k8EZAxEyAJ
 +ino2zDVxQixPlyf+pUlLYnj7qZXxcvM9W3uXIF3tzFRP4fy9WNgCO/1La7A8nZ7N5C4BigJOBt
 K+nmFuzJSQb0oIaf6pxWBuXA+IgKwzgy54P50ZTjwiQF8mOYvj1KyZjJWFEcFLCUxwbuI18lLHK
 0LezOK2YtG8Jzs16iPKFB4cqLMuiqPR0AeIlfHPCjQHQdk7OMhIg/rC0kcnO9Vz9aAcYQ/iNZsT
 mORw5Nw/kIbsP/Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

/proc/self/mountinfo displays the devicename for the mount, but
statmount() doesn't yet have a way to return it. Add a new
STATMOUNT_MNT_DEVNAME flag, claim the 32-bit __spare1 field to hold the
offset into the str[] array. STATMOUNT_MNT_DEVNAME will only be set in
the return mask if there is a device string.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namespace.c             | 36 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  3 ++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fc4f81891d544305caf863904c0a6e16562fab49..56750fcc890271e22b3b722dc0b4af445686bb86 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5014,6 +5014,32 @@ static void statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
 		seq_puts(seq, sb->s_subtype);
 }
 
+static int statmount_mnt_devname(struct kstatmount *s, struct seq_file *seq)
+{
+	struct super_block *sb = s->mnt->mnt_sb;
+	struct mount *r = real_mount(s->mnt);
+
+	if (sb->s_op->show_devname) {
+		size_t start = seq->count;
+		int ret;
+
+		ret = sb->s_op->show_devname(seq, s->mnt->mnt_root);
+		if (ret)
+			return ret;
+
+		if (unlikely(seq_has_overflowed(seq)))
+			return -EAGAIN;
+
+		/* Unescape the result */
+		seq->buf[seq->count] = '\0';
+		seq->count = start;
+		seq_commit(seq, string_unescape_inplace(seq->buf + start, UNESCAPE_OCTAL));
+	} else if (r->mnt_devname) {
+		seq_puts(seq, r->mnt_devname);
+	}
+	return 0;
+}
+
 static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 {
 	s->sm.mask |= STATMOUNT_MNT_NS_ID;
@@ -5077,6 +5103,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->fs_subtype = start;
 		statmount_fs_subtype(s, seq);
 		break;
+	case STATMOUNT_MNT_DEVNAME:
+		sm->mnt_devname = seq->count;
+		ret = statmount_mnt_devname(s, seq);
+		break;
 	default:
 		WARN_ON_ONCE(true);
 		return -EINVAL;
@@ -5225,6 +5255,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
 		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
 
+	if (!err && s->mask & STATMOUNT_MNT_DEVNAME)
+		err = statmount_string(s, STATMOUNT_MNT_DEVNAME);
+
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
@@ -5246,7 +5279,8 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 }
 
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
-			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE)
+			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
+			      STATMOUNT_FS_SUBTYPE | STATMOUNT_MNT_DEVNAME)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 2e939dddf9cbabe574dafdb6cff9ad4cf9298a74..3de1b0231b639fb8ed739d65b5b5406021f74196 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -174,7 +174,7 @@ struct statmount {
 	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
 	__u64 mnt_ns_id;	/* ID of the mount namespace */
 	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
-	__u32 __spare1[1];
+	__u32 mnt_devname;	/* [str] Device string for the mount */
 	__u64 __spare2[48];
 	char str[];		/* Variable size part containing strings */
 };
@@ -210,6 +210,7 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
 #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
 #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
+#define STATMOUNT_MNT_DEVNAME		0x00000200U	/* Want/got mnt_devname */
 
 /*
  * Special @mnt_id values that can be passed to listmount

-- 
2.47.0


