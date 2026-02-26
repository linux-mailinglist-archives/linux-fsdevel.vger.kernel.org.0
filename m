Return-Path: <linux-fsdevel+bounces-78487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFn3NlhRoGnriAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:57:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE7B1A71AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89FA03165E01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A9E37AA71;
	Thu, 26 Feb 2026 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABJnvzQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C238757E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113818; cv=none; b=DNZnfGCj40kRoRXvLHNFfFaktUp9hvzI9Q7sgBRkrusN8kRTF2FsyssFSRjDVm3h1+m1OV6rcLq+K3R+B+6UUI7ljgqYXr8Jo0XRenbSJjyfX+LnDbn9rbiuTmmwwH/XjfSlrMQDdUNk9ZS8M2ppQ5lpLv7/Gc7qZKl7BNxsv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113818; c=relaxed/simple;
	bh=z5hAm2m6ROKXrnfoFPIyBxSpLoMtR23g9+K3WiB8Gr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MABpEcwW36DzqoQ2HoOJyiVSSKfVnBaz8o64MACTA4iPfvh+UKKQn36ZHUMRGr6uOM8o17QmIu0vUyBdc9q+BRwQ+s5dehn1YaF7c/l28+VPre24GU6HwyLOxCp/Urzln9sGZuGP3sbieR8veP4JIes3KJAWilveN7VuDsbSc7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABJnvzQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F88AC116C6;
	Thu, 26 Feb 2026 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113817;
	bh=z5hAm2m6ROKXrnfoFPIyBxSpLoMtR23g9+K3WiB8Gr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ABJnvzQ6Rnhg9wfubDIPRXM/rLAWXQPFBsOX5x6BjMNe8Z7m/hJp//NdHG45AmSPT
	 EClZrAoT+hQxRKq3UmoI/Zc+pp0uPXganU6PjpWsHNJFt30OTvl/ysJr7fKTWnQJbI
	 qMjynCCPNpdJTliCbFBt46Qcw1NHyNMecU/R4QDdyT/TokdDI1WKff1UXdHnudhOWc
	 xLpbeCsOVqyv+P81LLjDXkrnD0DMijpYgVqa5H3MsbhIklqQoJ7jbHk510HSXuuICg
	 qgIba6xA4S0QoT9xs+MRsnzuBGqM3KpCaiTQW9KoU4FFZeVUGwiZmPrb8w8ztQr2/f
	 X1shCWBdbggdQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:50:09 +0100
Subject: [PATCH 1/4] nsfs: tighten permission checks for ns iteration
 ioctls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-work-visibility-fixes-v1-1-d2c2853313bd@kernel.org>
References: <20260226-work-visibility-fixes-v1-0-d2c2853313bd@kernel.org>
In-Reply-To: <20260226-work-visibility-fixes-v1-0-d2c2853313bd@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284; i=brauner@kernel.org;
 h=from:subject:message-id; bh=z5hAm2m6ROKXrnfoFPIyBxSpLoMtR23g9+K3WiB8Gr0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8J/q5Cy3bc3Fsi/NXofOJ2Xlrd7/4OVO07j1hccK3
 2/XlL7q0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRAycZ/oq2Vustmqx9aJbm
 ZV7hgElz195i12fWE3q3Z9YZJWWLWSsZ/vuxrWBKds5genH4XNjKQ6sf+79dvft6a7HgwYpd3Vd
 WfGAEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78487-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CE7B1A71AD
X-Rspamd-Action: no action

Even privileged services should not necessarily be able to see other
privileged service's namespaces so they can't leak information to each
other. Use may_see_all_namespaces() helper that centralizes this policy
until the nstree adapts.

Fixes: a1d220d9dafa ("nsfs: iterate through mount namespaces")
Cc: stable@kernel.org # v6.12+
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c                 | 13 +++++++++++++
 include/linux/ns_common.h |  2 ++
 kernel/nscommon.c         |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index db91de208645..be36c10c38cf 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -199,6 +199,17 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
 	return false;
 }
 
+static bool may_use_nsfs_ioctl(unsigned int cmd)
+{
+	switch (_IOC_NR(cmd)) {
+	case _IOC_NR(NS_MNT_GET_NEXT):
+		fallthrough;
+	case _IOC_NR(NS_MNT_GET_PREV):
+		return may_see_all_namespaces();
+	}
+	return true;
+}
+
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			unsigned long arg)
 {
@@ -214,6 +225,8 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 
 	if (!nsfs_ioctl_valid(ioctl))
 		return -ENOIOCTLCMD;
+	if (!may_use_nsfs_ioctl(ioctl))
+		return -EPERM;
 
 	ns = get_proc_ns(file_inode(filp));
 	switch (ioctl) {
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 825f5865bfc5..c8e227a3f9e2 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -55,6 +55,8 @@ static __always_inline bool is_ns_init_id(const struct ns_common *ns)
 
 #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
 
+bool may_see_all_namespaces(void);
+
 static __always_inline __must_check int __ns_ref_active_read(const struct ns_common *ns)
 {
 	return atomic_read(&ns->__ns_ref_active);
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index bdc3c86231d3..3166c1fd844a 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -309,3 +309,9 @@ void __ns_ref_active_get(struct ns_common *ns)
 			return;
 	}
 }
+
+bool may_see_all_namespaces(void)
+{
+	return (task_active_pid_ns(current) == &init_pid_ns) &&
+	       ns_capable_noaudit(init_pid_ns.user_ns, CAP_SYS_ADMIN);
+}

-- 
2.47.3


