Return-Path: <linux-fsdevel+bounces-33782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7439A9BEF07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B3A286BBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841D1DFE31;
	Wed,  6 Nov 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGHs3fA2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25BB1DB37C;
	Wed,  6 Nov 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899768; cv=none; b=CQXE69+voTGgQ7jKio6ySoJEMkfUO6sGrF7ga6wSVp35v3D3n5Jlfei36194mSgzfXHrxyn6VW25RzN+J2xjAr7jTIZqXnubo1OUb9c8dLBBt5NJm0vNwLPPr5KGwx9jm6Ya7qcHy51LXc9xIeuP2b2O1t7Wz3gwrn6uz3Kl/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899768; c=relaxed/simple;
	bh=qLoantZZPHrbJnCSNBUn4OTPj0732u5vIdVyCMxVYGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ew3lC5cBG2Wt2T3XY636shvqzCue2+lgWCcy108W+rRl3AF3RIghYJRJAvThHSXGQLdpQ008JiZ9gBiicvh8V3pQYKy/iLMgcPjoy+kM/aFzgGA7quHpCZ4Y59ewsdCcpeXBdcSL8DaHXHwR53ZgWpHkSDf8/ba/oEX31ItffcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGHs3fA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4D2C4CED3;
	Wed,  6 Nov 2024 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730899767;
	bh=qLoantZZPHrbJnCSNBUn4OTPj0732u5vIdVyCMxVYGI=;
	h=From:Date:Subject:To:Cc:From;
	b=WGHs3fA2TJP3R7VtYkapsjGtrsI0RUib0Nr+GNgqQV72BgIBsUq2YhrJBuiVj7KlR
	 ArRnzRgrCrhSQw+SeccfVP9q66vdJgG5eEOlsjGzOHTLjjIZmt4dQyKckFn+jbRQVB
	 sZ9CKBb9dqaozpKHCFP9HcbO5F2O55hUDrIfii/wMoHXfBFtMer5ZI971VQiqLRUp7
	 bySo3orbC2bpwnHEHyd0dv4SHg8cWSFy0uzdZZQjbXN6bQSpcAedfVpMHeDgoTLLlQ
	 rdiNlzsSdTwVDsWY7eG/EB3Xg+xaGmmFngbe52Tc2jV5YkQLhkRdbw+j/gmBa7f1ty
	 kGXYcBK6dTzcw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 06 Nov 2024 08:29:19 -0500
Subject: [PATCH] fs: add the ability for statmount() to report the
 fs_subtype
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-statmount-v1-1-b93bafd97621@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC5vK2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwMz3eKSxJLc/NK8El3jNEvDRPPUFHPTtEQloPqCotS0zAqwWdGxtbU
 AkPuL4VsAAAA=
X-Change-ID: 20241106-statmount-3f91a7ed75fa
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qLoantZZPHrbJnCSNBUn4OTPj0732u5vIdVyCMxVYGI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnK282S/roz15eGMUd7udzATG+mPVEs+cqwxlW9
 r29itiWcECJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZytvNgAKCRAADmhBGVaC
 FYGFD/9NutuYORMdrfcn5fUGaEt9mnz3GhtoknbXQ/bxX/7hE0onr2A0n2mGC8+TZXeXP1B112q
 zJfCoWXMlRiVlVKweOtRsu3a8Z/iGtaRBRg7sVb2b5IIF3UVcUMhsr7gAJeStaGYT+f0JV3E+s+
 ukOA82qI8YHG3zVtTG6EJGQ+zPnQfbs7kH4V5/6+78hvyw3sfcSsobPzoYVAo06WOTSzY4uAXDT
 fre8L/vs4CTlVOZYoD6OzpejXNmKtUUTCPdz/baUwh9Vfw8YGCOF1iokZwS8Wk7x3HhWe1c7BqE
 1l9H7Enuhvyw0NomWfTSHgCw9J7MCpgnp2KiW/qqgPm8UkD4ZbQtQqbnmQjGMD/GWE+G9u1/v/R
 fHI2AFJXoMgrquu6YqRXD4M3zb/TLgOq/jygSuFCku53WgNTGC8JxEltDvgkJ2nATi1HfphqCwu
 J1nbHNofRUFwwPJWPdeYXmzAiAAPYdM4QC87XdaSYyLd0KVBVOjzE1THHYdKqXwKKiyem1WDUjC
 rxDBw6oYfPRHWKk4uscjhIQrtaqv7eu/uAPubfOL3lvNASQZOnz088O7mOh1Vi6p6aXhsyRdgUd
 yXki9pZptAgO3FhcXDH8qWfGCGEhacpzffM4SXMtPCXkbwqvcSaI1TgetSIE/QLOtVFIWEaSTgV
 8EqmZ7ummOI5yWQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

/proc/self/mountinfo prints out the sb->s_subtype after the type. In
particular, FUSE makes use of this to display the fstype as
fuse.<subtype>.

Add STATMOUNT_FS_SUBTYPE and claim one of the __spare2 fields to point
to the offset into the str[] array. The STATMOUNT_FS_SUBTYPE will only
be set in the return mask if there is a subtype associated with the
mount.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namespace.c             | 20 +++++++++++++++++++-
 include/uapi/linux/mount.h |  5 ++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ba77ce1c6788dfe461814b5826fcbb3aab68fad4..5f2fb692449a9c0a15b60549fb9f7bedd10f1f3d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5006,6 +5006,14 @@ static int statmount_fs_type(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static int statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
+{
+	struct super_block *sb = s->mnt->mnt_sb;
+
+	seq_puts(seq, sb->s_subtype);
+	return 0;
+}
+
 static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 {
 	s->sm.mask |= STATMOUNT_MNT_NS_ID;
@@ -5064,6 +5072,13 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->mnt_opts = seq->count;
 		ret = statmount_mnt_opts(s, seq);
 		break;
+	case STATMOUNT_FS_SUBTYPE:
+		/* ignore if no s_subtype */
+		if (!s->mnt->mnt_sb->s_subtype)
+			return 0;
+		sm->fs_subtype = seq->count;
+		ret = statmount_fs_subtype(s, seq);
+		break;
 	default:
 		WARN_ON_ONCE(true);
 		return -EINVAL;
@@ -5203,6 +5218,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_MNT_OPTS)
 		err = statmount_string(s, STATMOUNT_MNT_OPTS);
 
+	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
+		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
+
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
@@ -5224,7 +5242,7 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
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

---
base-commit: 26213e1a6caa5a7f508b919059b0122b451f4dfe
change-id: 20241106-statmount-3f91a7ed75fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


