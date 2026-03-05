Return-Path: <linux-fsdevel+bounces-79547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLPMJJkUqmmYKwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:41:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349AE2196B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4374C30D6D1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C3036D50A;
	Thu,  5 Mar 2026 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMtVEnfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1DB36D4E2;
	Thu,  5 Mar 2026 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753477; cv=none; b=F6C1tNYs2ngoPLdRPrU6VUUg3r0k1efwI9T7akIEMnHadav+VTQfu2O5u0QYcq3EaBJiOLqaikthOUfTcsn0MtuWND9qJdamkYduQA2Dj9YaaI4dupv2eXiKO2Q+OCcgnT6LmYcDqcSGBC17/coV/4PIpnnY8H+0leYyGIVAKdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753477; c=relaxed/simple;
	bh=XeqX3QrUV4KI7Elsw6ZcveYXCtC1JO/XPb2z64xgwOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PG/LaGDzZ9bQpmTuVgC2q9Fj4AZo5rOZRN4Hi6Ek6o2jIRBhk54Q5B3FUOrlN+tXnvzRqch7vnV4jYxGjEeUfT86q9/fEAlDHMBCOGhIidIK7pz0y9q5kwELTpFkpJVH7UmPcgrpOD6YKKGTYVLEdw3TbHzg2ftAMcv5LKI8Af8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMtVEnfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F068FC2BC87;
	Thu,  5 Mar 2026 23:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753476;
	bh=XeqX3QrUV4KI7Elsw6ZcveYXCtC1JO/XPb2z64xgwOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pMtVEnfEH4590Wd0+8vGienC6LVlQWzL5D5c1eNuCP8294VcItsYYcK4cNfQSxtrR
	 V9szetLWv3W19RIyhTN1LYrY3eAabAOxWPUKnjkkwMEhnO9zFf3qEEAQVDHE9PAxXv
	 R6xs30pu594612yY9uW79rx4T4dXyaR3fId0oiyU4Bs5aESlM2ZwpeFk87gLsnIY5d
	 RIT1+RM1OyQe6li9s1fWAxJxnYwu0LQXcRtkg806s+VRWEIF/2FmEpnDzEtiT98RLb
	 1uT1Ix9MxpArf/xdoZHfK2VbtUisDAtXuNDInSD5pE7N1QUy89J3Kv873Fn5DzNcTA
	 DsyXaLAHrllRQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:25 +0100
Subject: [PATCH RFC v2 22/23] fs: start all kthreads in nullfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-22-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XeqX3QrUV4KI7Elsw6ZcveYXCtC1JO/XPb2z64xgwOU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuJaf+dRTOCPxulfLslOv2oklmf1fP6yJD9Xb1s+U
 zNXIQPPjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMlWBkWCFzrDuKP39mawzD
 zyu5iwsml+frLricuGvzFyfOOwoVeowMjbazeH8HSvyeuEbVMyp6t75zCe/unTMXel2tmxgYcvo
 xMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 349AE2196B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79547-lists,linux-fsdevel=lfdr.de];
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

Point init_task's fs_struct (root and pwd) at a private nullfs instance
instead of the mutable rootfs. All kthreads now start isolated in nullfs
and must use scoped_with_init_fs() for any path resolution.

PID 1 is moved from nullfs into the initramfs by init_userspace_fs().
Usermodehelper threads use userspace_init_fs via the umh flag in
copy_fs(). All subsystems that need init's filesystem state for path
resolution already use scoped_with_init_fs() from earlier commits in
this series.

This isolates kthreads from userspace filesystem state and makes it
hard to perform filesystem operations from kthread context.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 668131aa5de1..2a530109eb36 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6188,12 +6188,14 @@ static void __init init_mount_tree(void)
 		init_mnt_ns.nr_mounts++;
 	}
 
+	nullfs_mnt = kern_mount(&nullfs_fs_type);
+	if (IS_ERR(nullfs_mnt))
+		panic("VFS: Failed to create private nullfs instance");
+	root.mnt	= nullfs_mnt;
+	root.dentry	= nullfs_mnt->mnt_root;
+
 	init_task.nsproxy->mnt_ns = &init_mnt_ns;
 	get_mnt_ns(&init_mnt_ns);
-
-	/* The root and pwd always point to the mutable rootfs. */
-	root.mnt	= mnt;
-	root.dentry	= mnt->mnt_root;
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
 

-- 
2.47.3


