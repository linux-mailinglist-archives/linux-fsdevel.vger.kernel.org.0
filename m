Return-Path: <linux-fsdevel+bounces-34820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAE59C8E6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947BA1F2828B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384418C010;
	Thu, 14 Nov 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4KheDka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303BD183088
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598310; cv=none; b=A3mowKobt/LNbNJB/PsKB77N6JZFMpvZNSUJNq/U6UA6Vj9RYkxOEmk/btNfVzyj0mdnT5YizV2xsjBTLodCbdSyILe/UIKTbTY1wbKdUXoZiuLkBiWSeOpkKDPy1yvp2/i/3214spzy5iaiUZ3V8KHTjuS33kp9tjNSxAXy3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598310; c=relaxed/simple;
	bh=uUO2EWeEYw6Y+Q7QrTkvbC5WbCnE7mrVoWtsR3EEgN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVL9UEUemPiA1KWYhsHNSELQCK48N8fZ0b9y9bqtQPh2uHHxnI7MyI8Dp3zpyIPH+lRtIlH1K/8HB3l7kvAZmDm1NHwKTGTWFZ7DgJcGzz3dPC0j0HLL9wVpeRh1DoB+BBMqGqprKG9/3K0adg+fwUtr9J0tXLENB5PT0xbsMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4KheDka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7D8C4CED0;
	Thu, 14 Nov 2024 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731598309;
	bh=uUO2EWeEYw6Y+Q7QrTkvbC5WbCnE7mrVoWtsR3EEgN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4KheDkaEpojHari3R7WClMTv6mNp6YDRbTzEddDG2VzKQrbxC2ZR6H395Ua4TmCV
	 EElaFo/POBIOcIcHnGH2VCFJ7bBcrevkPlPCuJhtvV2C/FcPmoEIm/9mwETwk9PHoq
	 Ih38FdMjBEY7qf6ScS4iSo6cxbJduyIQc/4gHhNiOr+tcB4nVmeykihVAKdfiuhYhE
	 m090pXBgvbY4kD5jhwmy8Ky54qAV98oA+m68oQNfPLCEE8ssE9SabV23qobTzGkMzy
	 Hy+04RHSfrZhlDUCPZv8GshGxaKqlDOi0JLFp9tBXQa6A25Y8KOU89DetYCtK9HKMj
	 2biMFH47RynPg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Karel Zak <kzak@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] statmount: retrieve security mount options
Date: Thu, 14 Nov 2024 16:31:27 +0100
Message-ID: <20241114-radtour-ofenrohr-ff34b567b40a@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114-hammer-reinigen-045808e64b99@brauner>
References: <20241114-hammer-reinigen-045808e64b99@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5329; i=brauner@kernel.org; h=from:subject:message-id; bh=uUO2EWeEYw6Y+Q7QrTkvbC5WbCnE7mrVoWtsR3EEgN8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbid/c8XRX44ezhQ8r9m+fdHv6tPx9X594m9y+lV46U 3lH/ASOkI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ2Akx/FNjCfzv/GdLaoUr 1zXbW9f5l7xxqlHe8MQ6ZMf/lD9H7nAwMnR+3yF44UjAncPt/qeb7zLN2NKV9UVX7W0128nye6z rvrMDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Add the ability to retrieve security mount options. Keep them separate
from filesystem specific mount options so it's easy to tell them apart.
Also allow to retrieve them separate from other mount options as most of
the time users won't be interested in security specific mount options.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
How do we feel about including this for v6.13 or should I rather delay it?
---
 fs/namespace.c             | 74 ++++++++++++++++++++++++++++++--------
 include/uapi/linux/mount.h |  5 ++-
 2 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 4f39c4aba85d..a9065a9ab971 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5072,13 +5072,30 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static inline int statmount_opt_unescape(struct seq_file *seq, char *buf_start)
+{
+	char *buf_end, *opt_start, *opt_end;
+	int count = 0;
+
+	buf_end = seq->buf + seq->count;
+	*buf_end = '\0';
+	for (opt_start = buf_start + 1; opt_start < buf_end; opt_start = opt_end + 1) {
+		opt_end = strchrnul(opt_start, ',');
+		*opt_end = '\0';
+		buf_start += string_unescape(opt_start, buf_start, 0, UNESCAPE_OCTAL) + 1;
+		if (WARN_ON_ONCE(++count == INT_MAX))
+			return -EOVERFLOW;
+	}
+	seq->count = buf_start - 1 - seq->buf;
+	return count;
+}
+
 static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
 	struct super_block *sb = mnt->mnt_sb;
 	size_t start = seq->count;
-	char *buf_start, *buf_end, *opt_start, *opt_end;
-	u32 count = 0;
+	char *buf_start;
 	int err;
 
 	if (!sb->s_op->show_options)
@@ -5095,17 +5112,39 @@ static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
 	if (seq->count == start)
 		return 0;
 
-	buf_end = seq->buf + seq->count;
-	*buf_end = '\0';
-	for (opt_start = buf_start + 1; opt_start < buf_end; opt_start = opt_end + 1) {
-		opt_end = strchrnul(opt_start, ',');
-		*opt_end = '\0';
-		buf_start += string_unescape(opt_start, buf_start, 0, UNESCAPE_OCTAL) + 1;
-		if (WARN_ON_ONCE(++count == 0))
-			return -EOVERFLOW;
-	}
-	seq->count = buf_start - 1 - seq->buf;
-	s->sm.opt_num = count;
+	err = statmount_opt_unescape(seq, buf_start);
+	if (err < 0)
+		return err;
+
+	s->sm.opt_num = err;
+	return 0;
+}
+
+static int statmount_opt_sec_array(struct kstatmount *s, struct seq_file *seq)
+{
+	struct vfsmount *mnt = s->mnt;
+	struct super_block *sb = mnt->mnt_sb;
+	size_t start = seq->count;
+	char *buf_start;
+	int err;
+
+	buf_start = seq->buf + start;
+
+	err = security_sb_show_options(seq, sb);
+	if (!err)
+		return err;
+
+	if (unlikely(seq_has_overflowed(seq)))
+		return -EAGAIN;
+
+	if (seq->count == start)
+		return 0;
+
+	err = statmount_opt_unescape(seq, buf_start);
+	if (err < 0)
+		return err;
+
+	s->sm.opt_sec_num = err;
 	return 0;
 }
 
@@ -5138,6 +5177,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->opt_array = start;
 		ret = statmount_opt_array(s, seq);
 		break;
+	case STATMOUNT_OPT_SEC_ARRAY:
+		sm->opt_sec_array = start;
+		ret = statmount_opt_sec_array(s, seq);
+		break;
 	case STATMOUNT_FS_SUBTYPE:
 		sm->fs_subtype = start;
 		statmount_fs_subtype(s, seq);
@@ -5294,6 +5337,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_OPT_ARRAY)
 		err = statmount_string(s, STATMOUNT_OPT_ARRAY);
 
+	if (!err && s->mask & STATMOUNT_OPT_SEC_ARRAY)
+		err = statmount_string(s, STATMOUNT_OPT_SEC_ARRAY);
+
 	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
 		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
 
@@ -5323,7 +5369,7 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
 			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
 			      STATMOUNT_FS_SUBTYPE | STATMOUNT_SB_SOURCE | \
-			      STATMOUNT_OPT_ARRAY)
+			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index c0fda4604187..c07008816aca 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -177,7 +177,9 @@ struct statmount {
 	__u32 sb_source;	/* [str] Source string of the mount */
 	__u32 opt_num;		/* Number of fs options */
 	__u32 opt_array;	/* [str] Array of nul terminated fs options */
-	__u64 __spare2[47];
+	__u32 opt_sec_num;	/* Number of security options */
+	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
+	__u64 __spare2[46];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -214,6 +216,7 @@ struct mnt_id_req {
 #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
 #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
 #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
+#define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
 
 /*
  * Special @mnt_id values that can be passed to listmount
-- 
2.45.2


