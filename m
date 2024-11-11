Return-Path: <linux-fsdevel+bounces-34248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2069C4198
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6091C21CED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C431A3AAD;
	Mon, 11 Nov 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoauzZUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462561A302E;
	Mon, 11 Nov 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337824; cv=none; b=IgbqyrFGw1H8RD/b1hPwgki/DmlFtqPiM8HIU04i6xLjyw0cg5Y7suvCKyJR/Z1y4iH3KVn62bX47v1GX0J63Kgz9tEGXGJUFInLtHzB+PaV4IcLP6EAy4XyhuXWdsafFdIb/+M/l24hgOFs68kxv/LkTcKCuF1V1Y9eRYX8S+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337824; c=relaxed/simple;
	bh=gPPD2BzNbmDa/kJNcw+8GmA/BYpbtW9RM+xKs4INiH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZtwrlwWAsEmJ+iimVB5RLdv1P3IGjOzNUxlf4mH3i8sP/radjMa32UZGaxlNtV52ZRfe/0zSw6fdiw9nHhhxGU2urlh5U6g9GMGg8TCxU62/7JMjgTeyc3OTzbfgly0wMYJmRqMBy9x2oU2BCzWMe1N18DVjLxZXB2B1RKwDfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoauzZUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB85C4CED5;
	Mon, 11 Nov 2024 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731337823;
	bh=gPPD2BzNbmDa/kJNcw+8GmA/BYpbtW9RM+xKs4INiH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HoauzZUb+Az66CkddaEXEDshdWfDHM4Rlb/24Vvglq1yDr6MqkPut/z7sWd1a2aq6
	 0tuG+aepmB3Ihnf/WHWmTK3v8PMUBHKPzZf/wZ4avKh47/kLwvtH8ljKV5xsDRcODa
	 +P3n32Rq6fx4liNCKMDxaDlFMOLPI7V482n3P06SWisy5BMXNoivFYwmgXBVY6NPXe
	 hGj7snJnfhvvaJG/11fuPCHSPGw9r6h3QR72N/3YGRAa3NhtSp2W/93DwgtluJi5Um
	 KwOXf2L6gn6rK/rEMi5Hxzqxy7wgE+FV3E6jH185qoApSaa6OMYFu2Eg6kWJM9zMcf
	 9Y6gcP60TbDLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 11 Nov 2024 10:09:57 -0500
Subject: [PATCH v4 3/3] fs: add the ability for statmount() to report the
 sb_source
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-statmount-v4-3-2eaf35d07a80@kernel.org>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
In-Reply-To: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3821; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gPPD2BzNbmDa/kJNcw+8GmA/BYpbtW9RM+xKs4INiH8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnMh5bC+36IFMy/IY4fO1U7YQ3Z2X80uXPRqNmn
 aWSzELY6u+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzIeWwAKCRAADmhBGVaC
 FdMrD/9WjfGM+KT3BQKEN/XQbKKdz9LFvJGdDNs3A0E/h+uRXyCfJ7n0Q3xq7WbLkeHg1JU6qZF
 Adb43CjW+Pe1GSa7UYMSBKNNtE0ocgwyDB8oNzMxwR9h2yS7DCztrjG7ilHSMkjA27Uk7i+/nYv
 ZCKYuocjrbNsMGrgRLRc5ZmxdOJ6oF1XMBGWEFyyOTi1mcgiNd8G5dB4U2Tbdw4WINRa5aj/YS2
 jP9AdGr3f53mLgaqD//gERSXvOyt1W9YdFMKFFxV8c5a+xc7uU8qJIysEuhf335FL3wgpIHobi7
 IrfEmGigBdX+HdWcylTMuDwxbHpAyNdLmVtZZRO4JCm55mTmcQJf/gAoi3A5t10+ynzLjf7qXsd
 zbq3H3Da7vFQ06j5Qz1uPn9rFIatNvCXWaxEBC96hH0J3lqB7YF/OzZ4TOpG0TPYfRxEEV57EFb
 2+meIWYy7A3ed61kx/EcPmFhwKzrQY0R8Z3nnYE8bBmLwyFYHTFX2/UdK3jRMRRVneqdC+dyuBr
 J3A//TBeDxkXxYvcCQtnivJQHuV6SPZ7saY+zle+mdM+GtTe16ZjO5jlp2pedImhxNQW5vImFOO
 JoKGxYVmGLphv+85fMLg62Tedzl0Yd3Z0MxjfjF6z03HHAT8m1avl6d6w/jg67Q4cYsW0jcjK/A
 skdPHKCQAoxQtwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

/proc/self/mountinfo displays the source for the mount, but statmount()
doesn't yet have a way to return it. Add a new STATMOUNT_SB_SOURCE flag,
claim the 32-bit __spare1 field to hold the offset into the str[] array.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namespace.c             | 36 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  3 ++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fc4f81891d544305caf863904c0a6e16562fab49..4f034dba5884ce3641b8e4048e21879e4bda896c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5014,6 +5014,32 @@ static void statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
 		seq_puts(seq, sb->s_subtype);
 }
 
+static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
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
+	case STATMOUNT_SB_SOURCE:
+		sm->sb_source = seq->count;
+		ret = statmount_sb_source(s, seq);
+		break;
 	default:
 		WARN_ON_ONCE(true);
 		return -EINVAL;
@@ -5225,6 +5255,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
 		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
 
+	if (!err && s->mask & STATMOUNT_SB_SOURCE)
+		err = statmount_string(s, STATMOUNT_SB_SOURCE);
+
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
@@ -5246,7 +5279,8 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 }
 
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
-			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE)
+			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
+			      STATMOUNT_FS_SUBTYPE | STATMOUNT_SB_SOURCE)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 2e939dddf9cbabe574dafdb6cff9ad4cf9298a74..2b49e9131d77165899d8e3c17366c6afaa8b7795 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -174,7 +174,7 @@ struct statmount {
 	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
 	__u64 mnt_ns_id;	/* ID of the mount namespace */
 	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
-	__u32 __spare1[1];
+	__u32 sb_source;	/* [str] Source string of the mount */
 	__u64 __spare2[48];
 	char str[];		/* Variable size part containing strings */
 };
@@ -210,6 +210,7 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
 #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
 #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
+#define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
 
 /*
  * Special @mnt_id values that can be passed to listmount

-- 
2.47.0


