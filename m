Return-Path: <linux-fsdevel+bounces-33824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BEC9BF79C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67F4281959
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A77209F47;
	Wed,  6 Nov 2024 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da0uugc4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C211206E92;
	Wed,  6 Nov 2024 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922790; cv=none; b=lBHii0g1YZuo3bk+UMXCjndS5DtIUdfrJxB6cFQf2ePHpa4gDITwZ5KnPJW6ROvZ8yGLmIfMl0FFTh+gr9gsQaTYMOVxA3vGQMm+djxt2fG5KwW+JyAAQiDD4aABFlV44dueO6EhfvM92YiIj0oPL1RgS8Eq9hOzVzk7i0FavPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922790; c=relaxed/simple;
	bh=S99XA7AgZ9d2AueEW12kJQDhWH2cMia53cdtSAxsIQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLSkp+j/1z7Hdej3WR7Ln+Kn+YnM/YGMT7QiMgLZW8pWfDdSD3hYgc9AJVZXPdlEsitz+xyVyJ2PGFyEx5MirJCWAWm7YRUMMFCjEih7UNCwpLXS5+cX6NEsYVmphWcMjj6XuG71Vc3Ir4SPkVleQZOkAPcMrV4YNv0ikTmUSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da0uugc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7539CC4CED0;
	Wed,  6 Nov 2024 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730922790;
	bh=S99XA7AgZ9d2AueEW12kJQDhWH2cMia53cdtSAxsIQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Da0uugc4+beHteMZxgVBv4QoLbWO8a/jPUmA0joB+KMm+rbQndmPNR7sEPKynuff7
	 A2p4jOULwO/D+kZZoStk1541RpBxIE4mx5CPMGAd0+e+ujV/bnRpEymRQLE5WZVYso
	 9Qc+GvfVNNwMQUdX9EsEj526EZdld/t4j0b9qH4mpNt1hDajAvCAnkJPHx/yKcx2fF
	 fiS1TN1SA0z2Po2uCebkOXxni5sT5pgc5G191bAInYw5QdtPUFX48HztR4t5/0vej2
	 Qo13OepzmNMOUPQVWIXyM1zPO1ne9aYrZv1VxtFJhKMstzrC3hbV4y/nXkWm7efOhb
	 6k/J+mI+okRBg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 06 Nov 2024 14:53:05 -0500
Subject: [PATCH v2 1/2] fs: add the ability for statmount() to report the
 fs_subtype
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-statmount-v2-1-93ba2aad38d1@kernel.org>
References: <20241106-statmount-v2-0-93ba2aad38d1@kernel.org>
In-Reply-To: <20241106-statmount-v2-0-93ba2aad38d1@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3515; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=S99XA7AgZ9d2AueEW12kJQDhWH2cMia53cdtSAxsIQU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnK8kkR/jaPoQoF4sQRd/s38if4a9yYG/xTAr05
 ACb6zytjquJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZyvJJAAKCRAADmhBGVaC
 FdBgD/4h/83rA3CxDQ05ageJCFggZk8COaeND3HPgINacUYCXfGC21GnNs+i7aN8Q3ml+8mPoqz
 34rWrWunTAIQm4X42at5Gpsd6JxAj7Xue54gOV6AbqlR5MeOtbfc09vt6FO68tYkONcu0SgU6pA
 gsMwItwPsyxpFIA9WjvfxjG4K4vCFjcf/8qItbTfPSTiWTIUwsESQnjUALSO1rXRQFsRSwYKAxP
 38jDsiG+Tk7UhMnucyJybjUprEa/6ohcaQJ9rvSIuhcVYLH7Q/OAtrjTdoCcHzhz3jVvvQh4cJC
 dhYJbYRomU3QpxU3VfunUOEzMblqo2VOcca6M30QOYRfeHqiMSgd6d5hFXHU6/Be4xIKXYunv+E
 ZDUTnArnkXSfbWMPiZqO5f1ViqR3bFH48dykWEgSn9lW2Wlo80hfxJw9BCfV88s2GAgsq48sv5+
 r2+E9H9JoIDW55mR4xz0WqKibpuxtTukdZxiV5aEeOFx8gdP9mYsnefKBcgjHWVTxa53YudRGMu
 EOnMbcUpxFK1RtQJg6/UC2YrugpJQbXagJrzVTwQ/oXLyFqbOetc3gsLGQJtpMTbREu0fFnSyTV
 GA4RrOEtw8ZLmiUxeAH5n0uYUTPHtqChgPdYbNuuef2PY11ffXTqzzzZa5C4YICDWB68coEYyRw
 57Bac3v6wH2QJyg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

/proc/self/mountinfo prints out the sb->s_subtype after the type. This
is particularly useful for disambiguating FUSE mounts (at least when the
userland driver bothers to set it).

Add STATMOUNT_FS_SUBTYPE and claim one of the __spare2 fields to point
to the offset into the str[] array. STATMOUNT_FS_SUBTYPE will only be
set in the return mask if there is a subtype associated with the mount.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namespace.c             | 19 ++++++++++++++++++-
 include/uapi/linux/mount.h |  5 ++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ba77ce1c6788dfe461814b5826fcbb3aab68fad4..52ab892088f08ad71647eff533dd6f3025bbae03 100644
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
@@ -5064,6 +5072,12 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->mnt_opts = seq->count;
 		ret = statmount_mnt_opts(s, seq);
 		break;
+	case STATMOUNT_FS_SUBTYPE:
+		sm->fs_subtype = seq->count;
+		statmount_fs_subtype(s, seq);
+		if (seq->count == sm->fs_subtype)
+			return 0;
+		break;
 	default:
 		WARN_ON_ONCE(true);
 		return -EINVAL;
@@ -5203,6 +5217,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_MNT_OPTS)
 		err = statmount_string(s, STATMOUNT_MNT_OPTS);
 
+	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
+		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
+
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
@@ -5224,7 +5241,7 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 }
 
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
-			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS)
+			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 225bc366ffcbf0319929e2f55f1fbea88e4d7b81..fa206fb56b3b25cf80f7d430e1b6bab19c3220e4 100644
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
+#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got subtype */
 
 /*
  * Special @mnt_id values that can be passed to listmount

-- 
2.47.0


