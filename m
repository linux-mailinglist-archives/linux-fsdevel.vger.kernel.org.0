Return-Path: <linux-fsdevel+bounces-79537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKeJCHISqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5662194B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CCCB305D49E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F6369962;
	Thu,  5 Mar 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpTTaJvC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C8368282;
	Thu,  5 Mar 2026 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753451; cv=none; b=LvQRuPb5/JHtR95mHTHCW7r/q5KOCleZBwK8jSD0Ecql/CUCq6n8/26bRScsClASvip1Oy5VTDD+G4rSX4ZV8IwR/u4xPZzcPugNS8JtuJuPf4EJ1NOPpQD/VqhvY69HvKVzfld8xKIW1pOYxulxtuYhesg0GViESlEbC7J6/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753451; c=relaxed/simple;
	bh=wU9SxeJzZju+/xFBYvuJFjoOiP1dhPkfgSD6zYZdtUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRBdN3MiSt12PuBoiUgndR/Ef9AKLZ0S+ZLVaocyS8XbcvyhKy/FSDbFqWtwZ2eQGx5w/l69PAmt0k3OqXqZHgJyh9vVgBCXH0QOzeHAaybssKEKEy7UZZ/hzOfoYMPXw1Jz00sFEKVI/DjxFS/O4WYnEvqKYNPgW3k/ZiksY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpTTaJvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153ADC2BCB3;
	Thu,  5 Mar 2026 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753451;
	bh=wU9SxeJzZju+/xFBYvuJFjoOiP1dhPkfgSD6zYZdtUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hpTTaJvCzvmBI8ssoPzuRY9gbFvqoPmO9B/oDaz+8Cgtu0MPT9K0Drx5V95uIpPot
	 BJFpm4v4Ac5mFB8qh3sKXDPawBh9ycBNedZr7ALbI4k9wwm9NMH9U0on7u5mZ0uIYn
	 sAUNu1eQ3GfhfKVAgyULEQTF4K+FEfikUJmGeowuPVOmZY032whsc05AU4QNVqn89w
	 b0PqDVC6hrlG2LLt2Auc1o6mlBl4FVHdm/XBxbRnyFz40vW91Sr+SjOhg13gaFumIN
	 EGMKplnJPYU+g8WbDNj2GQdkzkvZDMICO9RuYELJbClN0TCKnCi6T6e+Sum94/PWk4
	 TDir8VAKB4vLg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:15 +0100
Subject: [PATCH RFC v2 12/23] ksmbd: use scoped_with_init_fs() for VFS path
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-12-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wU9SxeJzZju+/xFBYvuJFjoOiP1dhPkfgSD6zYZdtUQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuLcVyCtW7/r4B4/Q8UTiRlfxKZPKLZy9/5U/cD/z
 PQzWtZnO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyQYrhf1J30e+s/M+ZJ+QV
 ahry5kcvMHI7U+NzKnvLkX6Pj2xeIgz/VBy9gjb9dr7+4NuasvmHrY4Y8h59V1n1IGnTz0j53/s
 buAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 9A5662194B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79537-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use scoped_with_init_fs() to temporarily override current->fs for
path lookups in ksmbd VFS helpers:
- ksmbd_vfs_path_lookup(): wrap vfs_path_parent_lookup()
- ksmbd_vfs_link(): wrap kern_path() for old path resolution
- ksmbd_vfs_kern_path_create(): wrap start_creating_path()

This ensures path lookups happen in init's filesystem context.

All ksmbd paths ← SMB command handlers ← handle_ksmbd_work() ← workqueue
← ksmbd_conn_handler_loop() ← kthread

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/server/vfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index d08973b288e5..4b537e169160 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -7,6 +7,7 @@
 #include <crypto/sha2.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/filelock.h>
 #include <linux/uaccess.h>
 #include <linux/backing-dev.h>
@@ -67,9 +68,10 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 	}
 
 	CLASS(filename_kernel, filename)(pathname);
-	err = vfs_path_parent_lookup(filename, flags,
-				     path, &last, &type,
-				     root_share_path);
+	scoped_with_init_fs()
+		err = vfs_path_parent_lookup(filename, flags,
+					     path, &last, &type,
+					     root_share_path);
 	if (err)
 		return err;
 
@@ -622,7 +624,8 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
 
-	err = kern_path(oldname, LOOKUP_NO_SYMLINKS, &oldpath);
+	scoped_with_init_fs()
+		err = kern_path(oldname, LOOKUP_NO_SYMLINKS, &oldpath);
 	if (err) {
 		pr_err("cannot get linux path for %s, err = %d\n",
 		       oldname, err);
@@ -1258,7 +1261,8 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 	if (!abs_name)
 		return ERR_PTR(-ENOMEM);
 
-	dent = start_creating_path(AT_FDCWD, abs_name, path, flags);
+	scoped_with_init_fs()
+		dent = start_creating_path(AT_FDCWD, abs_name, path, flags);
 	kfree(abs_name);
 	return dent;
 }

-- 
2.47.3


