Return-Path: <linux-fsdevel+bounces-79533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E5nGggTqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:34:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F2321954B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B3E031246A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F584368285;
	Thu,  5 Mar 2026 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ05O+3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1B368267;
	Thu,  5 Mar 2026 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753443; cv=none; b=Gtzs6aO4ahdtJ1BT0zoF8v5kZ5txUZXRpo6i9RF+ipXOumh/YgQimJba8fAl2psRN8xg57nWv+ZWKTgEx/vephRgWZZB7QhE999nfB7f4/3OqAXMIBYKTHEHpk35LVTm0aEjp/4AFWNz5JeuDN88LQ1a6foixO8Y9I2h0lYLSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753443; c=relaxed/simple;
	bh=aJXunCWUMwo/RoSO3Pr5eSrF9qPQim1AZ9jP0b2ptO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXBVUa6iSfisYGWieRkyMraGi5sVDe4Ecd9d5sGETq4F2XCJtoGs7eVK2VVCzMucEG4pTwn9TUSn2cG+8J8J6NOJglS1g0NRdkir3FWXr8n99LnDek9FaDJvrb4yyzTj/c7ffZHgIgQfNkiGDAuRozKqFHGfMiitruRAXrkj7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ05O+3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22490C19423;
	Thu,  5 Mar 2026 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753441;
	bh=aJXunCWUMwo/RoSO3Pr5eSrF9qPQim1AZ9jP0b2ptO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QZ05O+3t19KWOR/73tKgMKp92iqIxqpmljYy0Gu/wKH3RtMwyvAJAdz6u+ZIcEu1b
	 l1es0uvjgOyS7hTNcvQNx3+4+76tgzZck3+3a23HEXgp5S+Ez2kywP9rii84Nfi53V
	 v5Q8fk2dgwu2QUvuk5nYgeIbwS/PhRSnWDPUcN/IYd+2CcKov1N+XMtg84RfVXb18i
	 2gu6chUX1lCncm9yRIOnt4hl+WiyrEhyAcYLgljlnaEI3w6sRBeTwSAwjiozW1qQG8
	 tiJ0edrsTyqAtafjhtxj9qV8XNxjHByZVOGh0YfBMqB9CAGkDiq6EKaQEOzPVoNChn
	 t0el9zp+SmFCg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:11 +0100
Subject: [PATCH RFC v2 08/23] coredump: use scoped_with_init_fs() for
 coredump path resolution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-8-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aJXunCWUMwo/RoSO3Pr5eSrF9qPQim1AZ9jP0b2ptO0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuIMPbbrwIwTB6eKhN/fdm6W9qa03vvGHDKPuXj4v
 GYoyYbVdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk1ERGhkf3dr7ze79v9lIu
 aeUAPt/HVzrYtG4wvZ0+p+33hP8auRIM/2tOPvLbfkd/8pLJVwwXcmZs0/EJEa533LpacbuZuLD
 mdV4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: E7F2321954B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79533-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use scoped_with_init_fs() to temporarily override current->fs for
the filp_open() call so the coredump path lookup happens in init's
filesystem context. This replaces the init_root() + file_open_root()
pattern with the simpler scoped override.

coredump_file() ← do_coredump() ← vfs_coredump() ← get_signal() — runs
as the crashing userspace process

Uses init's root to prevent a chrooted/user-namespaced process from
controlling where suid coredumps land. Not a kthread, but intentionally
needs init's fs for security.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 29df8aa19e2e..7428349f10bf 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -919,15 +919,10 @@ static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
 		 * with a fully qualified path" rule is to control where
 		 * coredumps may be placed using root privileges,
 		 * current->fs->root must not be used. Instead, use the
-		 * root directory of init_task.
+		 * root directory of PID 1.
 		 */
-		struct path root;
-
-		task_lock(&init_task);
-		get_fs_root(init_task.fs, &root);
-		task_unlock(&init_task);
-		file = file_open_root(&root, cn->corename, open_flags, 0600);
-		path_put(&root);
+		scoped_with_init_fs()
+			file = filp_open(cn->corename, open_flags, 0600);
 	} else {
 		file = filp_open(cn->corename, open_flags, 0600);
 	}

-- 
2.47.3


