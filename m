Return-Path: <linux-fsdevel+bounces-79542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OuHD3YSqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0492194BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51AE33031206
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176336B055;
	Thu,  5 Mar 2026 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIB7Z1ev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEEE36AB7D;
	Thu,  5 Mar 2026 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753464; cv=none; b=Ar22Yf5Qx5Gk279u4MLThRZ0thP3olnrS6elhYNDKS9+I2zVCrkIqmn1/d+LGtVJnisAUCn6ODG72v+sM0aB8InGem2MAmN5VSNg5NSKPrchT1fwRTPg92RG9LhZfxNqhg/wEBiFynDqSAIg4YF3m8qGQAgNGkbMnZalyW57soA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753464; c=relaxed/simple;
	bh=cEPoxGsNVeZpiXD7WHSwi6VwLjjrPPIdV4amCA7QCoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iG/2I4IFlrXzEqw7cL/h8rZ3XmxSL0bYPEBFJQBSGbIDlsTPFYTojXjG+a3FRAtFDvrXdYZ3Gyc6a8TU5LtLfVQ1bTS5MsU44adUYZQYFWN37enowYBzGU/kx34GbESFzbl4+2+6YwbxjsNAR0006HclpAvu5eGyfV9SZEIsUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIB7Z1ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4EEC2BCB5;
	Thu,  5 Mar 2026 23:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753464;
	bh=cEPoxGsNVeZpiXD7WHSwi6VwLjjrPPIdV4amCA7QCoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KIB7Z1evOY0WoqgIkwpMcntDF/poLiogO+/Vq2d9DVVU5YQw+dRXYBprykI4QnTe/
	 T+SaRyC4Qqa/KN0+kUDedtkcnKHxiFk0q4ZUqRegUMnF/LLpKR1EstkRh17ViHUe8q
	 G9lRjrDHH4jbXcbQCP2SVqlz1lx9H5NKyhaw3foTUdvap2GM552SDzBHRJ34OkAu4t
	 eIQbdUKBUQ/pQVv/kPK1wKTc/M8B95c2apHMw8gO67B/bJY6qsSMZdlhE23Q84i6id
	 YQvzrCoEhFaK4aoESbxjz9c2PVIWkVylfBiZZm+XQSJ+xOjeIgpB+SG99/XWL6szuj
	 uTsMiG+keS5PQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:20 +0100
Subject: [PATCH RFC v2 17/23] fs: stop sharing fs_struct between init_task
 and pid 1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-17-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cEPoxGsNVeZpiXD7WHSwi6VwLjjrPPIdV4amCA7QCoA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuJyuTX5zxGlXs0Tv461ayz1aOAtqu4VuCp5cnvlp
 gPPjf1ndJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEqoHhf+X+o+XWs/5ZqS6X
 6bxhZFNa7yTbuuiXsePxpToFZXM/H2X4H+5yWs3qxtSOXf2KVlbVaxoWny71ed3nmNET6z6v6EU
 kFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: EA0492194BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79542-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Spawn kernel_init (PID 1) via kernel_clone() directly instead of
user_mode_thread(), without CLONE_FS. This gives PID 1 its own private
copy of init_task's fs_struct rather than sharing it.

This is a prerequisite for isolating kthreads in nullfs: when
init_task's fs is later pointed at nullfs, PID 1 must not share it
or init_userspace_fs() would modify init_task's fs as well, defeating
the isolation.

At this stage PID 1 still gets rootfs (a private copy rather than a
shared reference), so there is no functional change.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 init/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 5ccc642a5aa7..6633d4bea52b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -714,6 +714,11 @@ static __initdata DECLARE_COMPLETION(kthreadd_done);
 
 static noinline void __ref __noreturn rest_init(void)
 {
+	struct kernel_clone_args init_args = {
+		.flags		= (CLONE_VM | CLONE_UNTRACED),
+		.fn		= kernel_init,
+		.fn_arg		= NULL,
+	};
 	struct task_struct *tsk;
 	int pid;
 
@@ -723,7 +728,7 @@ static noinline void __ref __noreturn rest_init(void)
 	 * the init task will end up wanting to create kthreads, which, if
 	 * we schedule it before we create kthreadd, will OOPS.
 	 */
-	pid = user_mode_thread(kernel_init, NULL, CLONE_FS);
+	pid = kernel_clone(&init_args);
 	/*
 	 * Pin init on the boot CPU. Task migration is not properly working
 	 * until sched_init_smp() has been run. It will set the allowed

-- 
2.47.3


