Return-Path: <linux-fsdevel+bounces-79527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA5tDU8SqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:31:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF9A219498
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E6E3079C6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DED72882C5;
	Thu,  5 Mar 2026 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLnjzF4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29628281503;
	Thu,  5 Mar 2026 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753426; cv=none; b=E1lkP0AqnzwDo1zSIbrYoEGXmhJ67V6BCPb0AbXPp1Fj5qaoBcworQkdiPRJIyArqRLZsINnKmZT55N2cJ8Py8Prloko3FxdwvbEX9efFVQ9LRPWxD5nXpqAKiJUkeVeKzvKuTdpQALJpHGNpX+Dw15ucsV4KoNxyDqT/RdhQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753426; c=relaxed/simple;
	bh=/qBXsoeacZyljyu4IKg9RdZ+fbB4bK3kFcvfUbshqKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwjlQhdIPCYno1uBPw+c41nMGIRg6iRP8wtsYPMbJdIUKyWI9LEWY90vmZmaotf0Y+mrGcihs9X8RYMWn25rfMNGAUfDO8rhwXpiqXEEAdWEq/W5hrtdm1DtTXNEMDI9/J6FFIln+x17+u48DXobzBBiDI1wfR8aOa582hrPMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLnjzF4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A400C2BCAF;
	Thu,  5 Mar 2026 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753426;
	bh=/qBXsoeacZyljyu4IKg9RdZ+fbB4bK3kFcvfUbshqKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lLnjzF4KGOeujLgiD3MMflNaVmOY5XkQlmQkaiWd5YwyG0Sv4lgSjBC5Om2GLRSMT
	 B/ApSrxqDPxm5bewODr0B9gDqFH2FtnS3ebovcPvKqyourTxD05BvV52pWS4l0RTvr
	 PerRHtsFwpracj2tsP4QimcuZSq2oxUOrcYLmMN0ktI2Og4BgJa82AtTatpMo32RPb
	 vH1GTPjvkD05zRH9ZwF07VZgRLlZdPC6ac+9IA6eXKpP9DCqtetM+7y06iz8Zr2I76
	 8wtws3BWNjehiq2nYHlkQe94jtr/RXyZu0Mvu9w+Kidn0w2o3wo0HOJ2x/mpyboV8z
	 WLFEushOw28GQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:05 +0100
Subject: [PATCH RFC v2 02/23] fs: add scoped_with_init_fs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-2-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/qBXsoeacZyljyu4IKg9RdZ+fbB4bK3kFcvfUbshqKA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuJU4uypnfHpifSsdRM7XW0KrP5W3peblrS4Yr6Yh
 L9t9LM1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNR4mVkWL6xu9QuOOuYFsfh
 qS5/J373XM145t5imZ/WUSsOeF36b8nIcHdWH2uffbToxgizznXFTC2uU5ZKHrZY4fuV+e6dZbs
 PcwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 9BF9A219498
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79527-lists,linux-fsdevel=lfdr.de];
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

Similar to scoped_with_kernel_creds() allow a temporary override of
current->fs to serve the few places where lookup is performed from
kthread context or needs init's filesytem state.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs_struct.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index ade459383f92..ff525a1e45d4 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -6,6 +6,7 @@
 #include <linux/path.h>
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
+#include <linux/vfsdebug.h>
 
 struct fs_struct {
 	int users;
@@ -49,4 +50,34 @@ static inline int current_umask(void)
 	return current->fs->umask;
 }
 
+/*
+ * Temporarily use userspace_init_fs for path resolution in kthreads.
+ * Callers should use scoped_with_init_fs() which automatically
+ * restores the original fs_struct at scope exit.
+ */
+static inline struct fs_struct *__override_init_fs(void)
+{
+	struct fs_struct *fs;
+
+	fs = current->fs;
+	smp_store_release(&current->fs, current->fs);
+	return fs;
+}
+
+static inline void __revert_init_fs(struct fs_struct *revert_fs)
+{
+	VFS_WARN_ON_ONCE(current->fs != current->fs);
+	smp_store_release(&current->fs, revert_fs);
+}
+
+DEFINE_CLASS(__override_init_fs,
+	     struct fs_struct *,
+	     __revert_init_fs(_T),
+	     __override_init_fs(), void)
+
+#define scoped_with_init_fs() \
+	scoped_class(__override_init_fs, __UNIQUE_ID(label))
+
+void __init init_userspace_fs(void);
+
 #endif /* _LINUX_FS_STRUCT_H */

-- 
2.47.3


