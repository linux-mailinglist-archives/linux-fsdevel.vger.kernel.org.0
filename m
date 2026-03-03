Return-Path: <linux-fsdevel+bounces-79225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAj0Cl3rpmnjZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:08:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EB1F112B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 974F13182FDE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1135F608;
	Tue,  3 Mar 2026 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RifPClnR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABC35C181;
	Tue,  3 Mar 2026 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545774; cv=none; b=mTaUszaynMKTARULP+hqGFDo8yQF2BLW8320Ucd2u8U9b+uab0ODBjC76vdd3FQ8wA9gMwry/rdwG5g7RH9SluRt/fTp0BpySPEIhzJoyC72MDeaKYAX7znQw0LVrgZXVh9EP+ILz8KCNoHFiicllIFi1vmaAvTrn8bkfPhF2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545774; c=relaxed/simple;
	bh=Kp7R1oLP8DpihtIuEU4nA7CAO+wMVu/giG6qsMQq6nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiFZZJ6O9HuN2guvwk/f42xHVXq2zMI1Hxirg97KmWu84uy73fjEyUe9l0ukERXJbavUkMtKq4qLiEfg6WaUbKSkwGLCO7CJDmedSzvaPDlgeVIWovCjzEHyzDBgd9174J3KxeTqP0UalFbuesqydhplOTpKVqCBw++zUAlJF5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RifPClnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4F4C116C6;
	Tue,  3 Mar 2026 13:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545773;
	bh=Kp7R1oLP8DpihtIuEU4nA7CAO+wMVu/giG6qsMQq6nY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RifPClnRKQYstvijQswg9rYEDpTcV3ujtDZ6smdNHs+WmoAychNwIIKFQtgj1x5J1
	 uylv1V9Ggt/hZYvB0vFKidjKRQ1aTlssnOa/99SCz04SPMV9pr8+Vq3ftdYWWhWmLY
	 4NO+2ObuSWEGDC2ADlBXglRJXNJLk17zK4EjoGJig4qawHlMlgEg06M3x4ZCsGn97D
	 StMDUn15GCU4beWgE3v7+gFemKdgN5ds+p+HyfHrUxpTJiDVhFmWzIEV1Eshus/zTI
	 9sJjZJXp3feF0m/NEkW3vQO8uW8nKDg9lT63Kd3CK2VvP7rjJ4X7sSyodkPW4acmhL
	 GysrsiEwjTR1w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:16 +0100
Subject: [PATCH RFC DRAFT POC 05/11] fs: add LOOKUP_IN_INIT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-5-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Kp7R1oLP8DpihtIuEU4nA7CAO+wMVu/giG6qsMQq6nY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3bvsf7cvyym0r/n13Z9n2iVLrJugegnIwaPrcocr
 zY+9p56p6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiLDsZGSZOvGz3df/m199y
 vjx4V3Qi5Iqk7u5pVzz2OvJnS4eX/7nA8IcjgGF5ne6kvjuq23Ytjfr9VyZlpcvO07fXmfRLaUf
 0ynIDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 809EB1F112B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79225-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a new LOOKUP_IN_INIT flag that causes the lookup to be performed
relative to userspace init's root or working directory. This will be
used to force kthreads to be isolated in nullfs and explicitly opt-in to
lookup stuff in init's filesystem state.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namei.c            | 17 ++++++++++++++---
 include/linux/namei.h |  3 ++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 58f715f7657e..dd2710d5f5df 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1099,7 +1099,12 @@ static int complete_walk(struct nameidata *nd)
 
 static int set_root(struct nameidata *nd)
 {
-	struct fs_struct *fs = current->fs;
+	struct fs_struct *fs;
+
+	if (nd->flags & LOOKUP_IN_INIT)
+		fs = &init_fs;
+	else
+		fs = current->fs;
 
 	/*
 	 * Jumping to the real root in a scoped-lookup is a BUG in namei, but we
@@ -2716,8 +2721,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	/* Relative pathname -- get the starting-point it is relative to. */
 	if (nd->dfd == AT_FDCWD) {
+		struct fs_struct *fs;
+
+		if (nd->flags & LOOKUP_IN_INIT)
+			fs = &init_fs;
+		else
+			fs = current->fs;
+
 		if (flags & LOOKUP_RCU) {
-			struct fs_struct *fs = current->fs;
 			unsigned seq;
 
 			do {
@@ -2727,7 +2738,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
 			} while (read_seqretry(&fs->seq, seq));
 		} else {
-			get_fs_pwd(current->fs, &nd->path);
+			get_fs_pwd(fs, &nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
 	} else {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 58600cf234bc..072533ec367b 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -46,9 +46,10 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_NO_XDEV		BIT(26) /* No mountpoint crossing. */
 #define LOOKUP_BENEATH		BIT(27) /* No escaping from starting point. */
 #define LOOKUP_IN_ROOT		BIT(28) /* Treat dirfd as fs root. */
+#define LOOKUP_IN_INIT		BIT(29) /* Lookup in init's namespace. */
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
-/* 3 spare bits for scoping */
+/* 2 spare bits for scoping */
 
 extern int path_pts(struct path *path);
 

-- 
2.47.3


