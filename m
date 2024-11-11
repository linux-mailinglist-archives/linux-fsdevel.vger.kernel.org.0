Return-Path: <linux-fsdevel+bounces-34247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661529C4195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C22283F82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4B1A2C04;
	Mon, 11 Nov 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0vxevoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC01A2574;
	Mon, 11 Nov 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337823; cv=none; b=hi5qRJy5rDpgLT838+l/xmDMJAdTLum9cQbe9K+cfks0jfSIrQkUJ8mFVGoiPLWYZxWJzUR3B3tOMWJGVwJ1b1DX1sThVlmwEPLtwqkJmOfYFFd/accIjJc/ghkBeI6ZuiM5L4AwiXQx5J3FOTsVJHFxHcmuewSNAKC9+ekCE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337823; c=relaxed/simple;
	bh=xzZstM9rrNdRWFzLRzn/IgGA24psf+YZc9e31THx3tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jF5mbwnfGGe0LHgxtlRs3EtH47gjpYhHFPL7sCN03Z/R0Rc9AhGwA6g3kq7PljRquX/bIAGz8FkWB/r6zw7G7n4cJWvEXubb650QvvCszoNdZvFMJcif04q5MzlZpVY5gdUTz+p0h4O0VIdR7eP9fDNgJHNS2NCTPSyFdICa8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0vxevoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3053DC4CED8;
	Mon, 11 Nov 2024 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731337822;
	bh=xzZstM9rrNdRWFzLRzn/IgGA24psf+YZc9e31THx3tU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d0vxevoL0sFrmbm6iiPcWv8xBAYWMs+wZR+SMQkeR4MjTsG8KBNeR400cRGoDkm4m
	 rosFj471Ku8TnUTF1+Ks3qMpejqDGhvG68OQDBuQ3DAHfAV2c8BGWZm6OyHydQMhp0
	 guEwiO25jep5Pjx0xIVatT6Iohj9/FYuhGDCj3uWekBlHdb6SNJEv6tEDeHHLeiAZX
	 /azRfQyjHOQ/f6h6pjIVsFz3cUdM4VQaSe1VKbc1wReK6r4DqLCOB+SItfTphYKIpU
	 NQRG3hbeubzrN/KQXaW675di9GkjyazyX5Oex40wQbnmHXTNVkHHGmdh4fdjkCORsp
	 +gnd5CNsEidTA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 11 Nov 2024 10:09:56 -0500
Subject: [PATCH v4 2/3] fs: add the ability for statmount() to report the
 fs_subtype
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-statmount-v4-2-2eaf35d07a80@kernel.org>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
In-Reply-To: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3670; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xzZstM9rrNdRWFzLRzn/IgGA24psf+YZc9e31THx3tU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnMh5bKuHay+6NBy6slkGZMmD2akFNDgU8Siygz
 5kZtwFxHWiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzIeWwAKCRAADmhBGVaC
 FUk1D/90TCQbHLDKPd1twJ0sTsEOzqZfsxsUrbhh5ypOtykGdEt4ucHv2BkizGA4hQ4Xl8C3isl
 mDFBRPhvXGlC9z5Kv7HbVGe9IxvXAk9rg/6zYN+/9xlOD+NeFAjVuUfjgdBfWFoPRHtGI8oZFSw
 DVMSNpc1r6QZZZEfwWdHsWQ662bCrkditr7Il+L8OvBkWV7ppDZz0hGfxAf5WiF8NKKW1jed+2P
 q2q4z6iaqXUNY6FaHzsUSCRK/XvsrzBaXQGc/vvfxUBsBrsZhKJx89cn52CjYDDaEdq32fSJpEo
 lmJrgyF171514f9f6TkiI/F8nlhKiKYbi00hmmwz5bTE3Txhj/pflxNAQkuXLR4oOwqKT+h9wed
 h+cTVamgJ5oYjKAn4HlXEOheW3fTe7I//Jc/SfR9ltL5aCGVLhc+Hx+t+/L71KvV76WVbtzgcXs
 ezxeTsFlLh9OdEgdaX5lHdbnG6RKLWqmETySrqhLYC2GYIzmA7ztytngoujzjXG/LDZMqyhdVg1
 Z8FEJ7T9aTzh2u4trGpDU8zJaNGOG6wH27CDGU9RT78Xci0MZ80jJ2Y0RRa4CgN4bpZIDfacKOI
 V5Sv20lZjT2zgIgZrmC8kWdXtuYySKiT97qC7mXSdbqqVwyHi2QoaQ8qnsEH2t1tD3MyMv9LUBX
 uk60arePSEUO5KA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

/proc/self/mountinfo prints out the sb->s_subtype after the type. This
is particularly useful for disambiguating FUSE mounts (at least when the
userland driver bothers to set it). Add STATMOUNT_FS_SUBTYPE and claim
one of the __spare2 fields to point to the offset into the str[] array.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ian Kent <raven@themaw.net>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namespace.c             | 19 +++++++++++++++++--
 include/uapi/linux/mount.h |  5 ++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 28ad153b1fb6f49653c0a85d12da457c4650a87e..fc4f81891d544305caf863904c0a6e16562fab49 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5006,6 +5006,14 @@ static int statmount_fs_type(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static void statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
+{
+	struct super_block *sb = s->mnt->mnt_sb;
+
+	if (sb->s_subtype)
+		seq_puts(seq, sb->s_subtype);
+}
+
 static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 {
 	s->sm.mask |= STATMOUNT_MNT_NS_ID;
@@ -5042,7 +5050,7 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 
 static int statmount_string(struct kstatmount *s, u64 flag)
 {
-	int ret;
+	int ret = 0;
 	size_t kbufsize;
 	struct seq_file *seq = &s->seq;
 	struct statmount *sm = &s->sm;
@@ -5065,6 +5073,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->mnt_opts = start;
 		ret = statmount_mnt_opts(s, seq);
 		break;
+	case STATMOUNT_FS_SUBTYPE:
+		sm->fs_subtype = start;
+		statmount_fs_subtype(s, seq);
+		break;
 	default:
 		WARN_ON_ONCE(true);
 		return -EINVAL;
@@ -5210,6 +5222,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_MNT_OPTS)
 		err = statmount_string(s, STATMOUNT_MNT_OPTS);
 
+	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
+		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
+
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
@@ -5231,7 +5246,7 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 }
 
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
-			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS)
+			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 225bc366ffcbf0319929e2f55f1fbea88e4d7b81..2e939dddf9cbabe574dafdb6cff9ad4cf9298a74 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -173,7 +173,9 @@ struct statmount {
 	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
 	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
 	__u64 mnt_ns_id;	/* ID of the mount namespace */
-	__u64 __spare2[49];
+	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
+	__u32 __spare1[1];
+	__u64 __spare2[48];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -207,6 +209,7 @@ struct mnt_id_req {
 #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
 #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
 #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
+#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
 
 /*
  * Special @mnt_id values that can be passed to listmount

-- 
2.47.0


