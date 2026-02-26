Return-Path: <linux-fsdevel+bounces-78493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HLVGcJSoGlLiQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:03:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D01A72BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9613E303DDEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F9D3A1CF9;
	Thu, 26 Feb 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moe0Emux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF33A1A40;
	Thu, 26 Feb 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113875; cv=none; b=VNl+q++6b5xkv7sZCQq8jPlyaHTa+PtJscLAFLbxeiEPDfSYXOCcne3cspfpbBRkTJexLKjYYkWzAt9kp9Kw5PfHjXfkOH2nEXxY4VdKxUpcUdoXRQLDkFBzurKVp88mly/GvwKTYETe31yWEMkMtz98U48HAnCwSDP8fDHPQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113875; c=relaxed/simple;
	bh=Pe64i0mVb0l9+hOUVgaR7FNAmTnQLfrD7A8hMzslM0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phwyWstex9otPEhNxjsInCfIBH2ZbahGDcXFWyGJN5IDhlSM09AdkCsDTe2ajvv9wgIiq7vrGDnyPbgmqrrC94L6nTGSAhOc5XTmole2YK0AIWcwfznlODx711gjiHUR+ioBOJc8wA4E6aCrraunNzhVSBwMLVhqRxB6DeI4+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moe0Emux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BA1C2BC87;
	Thu, 26 Feb 2026 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113874;
	bh=Pe64i0mVb0l9+hOUVgaR7FNAmTnQLfrD7A8hMzslM0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=moe0EmuxsBzegZtcPXiLwvocIH/bqfru1Wf4t08Mf/GulV2gjzALhXXmnwe56IRil
	 fw9UG7H/J3vAqqAlJKwYmHG16mhsIdqCcmJArerKHYeAtl9oAGiaZBSrwNyhggOi24
	 yY+7jm7tFdoHDjMEmTP5pGYQA6j2ZoL7pul3wMe36ttSVTjp5wZX7SZr6jJujxsZjN
	 byAfKtzofrCElPP6Ew4b8wGvanIIcD4B/yAucLLJ5FcS+QrS9VlXcr4ZtSsqHRTCUK
	 9oao82LRDRFE9874yI/Pkya0jiLCv7F7+nhure/bjzgYllxnG5whSqSea+EEqvZYtv
	 6ktQDxOpaf+tA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:51:00 +0100
Subject: [PATCH v5 2/6] clone: add CLONE_NNP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-work-pidfs-autoreap-v5-2-d148b984a989@kernel.org>
References: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
In-Reply-To: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Pe64i0mVb0l9+hOUVgaR7FNAmTnQLfrD7A8hMzslM0Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8D+dI1esbn1DVeKF72VbnvcMVaZZszY4Ht1l6lX7r
 optq//LjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMEmFkmPP0y+ZU1nU88sc2
 FjRWMC/ImdEaX1gW3LLjTYXob95dKxn+h29ZJHTIZffXA9+/OZ7p3ON/fdHNqE9XNi43XLHfTSd
 vGysA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78493-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 107D01A72BC
X-Rspamd-Action: no action

Add a new clone3() flag CLONE_NNP that sets no_new_privs on the child
process at clone time. This is analogous to prctl(PR_SET_NO_NEW_PRIVS)
but applied at process creation rather than requiring a separate step
after the child starts running.

CLONE_NNP is rejected with CLONE_THREAD. It's conceptually a lot simpler
if the whole thread-group is forced into NNP and not have single threads
running around with NNP.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/sched.h |  1 +
 kernel/fork.c              | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 8a22ea640817..7b1b87473ebb 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -37,6 +37,7 @@
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
 #define CLONE_AUTOREAP 0x400000000ULL /* Auto-reap child on exit. */
+#define CLONE_NNP 0x1000000000ULL /* Set no_new_privs on child. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/kernel/fork.c b/kernel/fork.c
index 0dedf2999f0c..a3202ee278d8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2037,6 +2037,11 @@ __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
+	if (clone_flags & CLONE_NNP) {
+		if (clone_flags & CLONE_THREAD)
+			return ERR_PTR(-EINVAL);
+	}
+
 	/*
 	 * Force any signals received before this point to be delivered
 	 * before the fork happens.  Collect up signals sent to multiple
@@ -2421,6 +2426,9 @@ __latent_entropy struct task_struct *copy_process(
 	 */
 	copy_seccomp(p);
 
+	if (clone_flags & CLONE_NNP)
+		task_set_no_new_privs(p);
+
 	init_task_pid_links(p);
 	if (likely(p->pid)) {
 		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
@@ -2909,7 +2917,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
 	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP |
-	      CLONE_AUTOREAP))
+	      CLONE_AUTOREAP | CLONE_NNP))
 		return false;
 
 	/*

-- 
2.47.3


