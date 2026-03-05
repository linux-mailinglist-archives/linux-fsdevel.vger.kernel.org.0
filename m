Return-Path: <linux-fsdevel+bounces-79544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ73E4EUqmmYKwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:40:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F5B219699
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EFFE318D5AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FDE368940;
	Thu,  5 Mar 2026 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOTm2yzw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845936BCDF;
	Thu,  5 Mar 2026 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753469; cv=none; b=iYGv0qjAMe1Cr3CkzwIJzWMYdqs3ovVcFwCbr05AkSmw5f6+9Ylz3xaSGrEwEopJ73TNu84vr4Ldrt9rF3uJAa4O3DaZH+YC5WVREaIbn9gpdfW/eiDxJnXWOf/INkULjCiZgdeKkjcURR4uhyLqeYRugFN0UpwhP/vkmy+4Wzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753469; c=relaxed/simple;
	bh=OgNQ/xlwvm4M9g2zqphqbWQNReYOOt5NLqaMAeMCRPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPcgaCSkbsKQ70KvIRkg4KuTPAFuAlvVjKa8vsapjxsw4YXUDWD084DO9lfBiaP4kcLCOBiUBqxUyOIrb7aEP2qvsTciD4HrNPvJL69sJ1R/1QDiPsf7+o+GG1EupUoXNX+dN3QOt2shS31/c/1p2itIqslWw/TYB1TWL+MUkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOTm2yzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C5FC116C6;
	Thu,  5 Mar 2026 23:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753469;
	bh=OgNQ/xlwvm4M9g2zqphqbWQNReYOOt5NLqaMAeMCRPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gOTm2yzwPADPrY1li910gwFSYX7hBtLG2vw0IDW/2lPLqnSLSZ5J9lTDisy3rqd1Y
	 f/s6ivYCXvohi+xHOKXRa7slaY8/aulzql7XYucIRL3pNkBUuO73QC/tZ8mDqc7YJJ
	 URE56k8uWYIYPEVPg5cU74awB3VZzm2qpLM5D2+6LINQQ8MNc9TWxa43sbcShpN4IF
	 0ucmVjieM/hT264ZNGGSxpG1TO2kUimsvnRZzirc3EWMXZ2+FgEFYn8IOu9HDR3n8K
	 uEyRBFClTZxEnxol9bfZzMXMo3/ZbbmrYdT/A4oX8xOefVPH2o8WnpjGis4r7uQkRX
	 68YXxbs/fnkXw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:22 +0100
Subject: [PATCH RFC v2 19/23] fs: add kthread_mntns()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-19-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OgNQ/xlwvm4M9g2zqphqbWQNReYOOt5NLqaMAeMCRPE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuK6cz61xTrqXIxcTACnmFzbiRuFPrkNi4pTH+Zc5
 Qu/mr+oo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK+Hgz/FP46rDk2vSZ7tZvJ
 Sc6EHLvI4OuFa4RXpXTqZp+21mKsZ2SYvL736MJqxatWuzYaszj3hWw6wqi2Q67A64xV61veOW2
 MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: A1F5B219699
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79544-lists,linux-fsdevel=lfdr.de];
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

Allow kthreads to create a private mount namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c        | 30 ++++++++++++++++++++++++++++++
 include/linux/mount.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 854f4fc66469..668131aa5de1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6200,6 +6200,36 @@ static void __init init_mount_tree(void)
 	ns_tree_add(&init_mnt_ns);
 }
 
+/*
+ * Allow to give a specific kthread a private mount namespace that is
+ * anchored in nullfs so it can mount.
+ */
+int __init kthread_mntns(void)
+{
+	struct mount *m;
+	struct path root;
+	int ret;
+
+	/* Only allowed for kthreads in the initial mount namespace. */
+	VFS_WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
+	VFS_WARN_ON_ONCE(current->nsproxy->mnt_ns != &init_mnt_ns);
+
+	/*
+	 * TODO: switch to creating a completely empty mount namespace
+	 * once that series lands.
+	 */
+	ret = ksys_unshare(CLONE_NEWNS);
+	if (ret)
+		return ret;
+
+	m = current->nsproxy->mnt_ns->root;
+	root.mnt = &m->mnt;
+	root.dentry = root.mnt->mnt_root;
+	set_fs_pwd(current->fs, &root);
+	set_fs_root(current->fs, &root);
+	return 0;
+}
+
 void __init mnt_init(void)
 {
 	int err;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b..69d61f21b548 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -106,6 +106,7 @@ int do_mount(const char *, const char __user *,
 extern const struct path *collect_paths(const struct path *, struct path *, unsigned);
 extern void drop_collected_paths(const struct path *, const struct path *);
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
+int __init kthread_mntns(void);
 
 extern int cifs_root_data(char **dev, char **opts);
 

-- 
2.47.3


