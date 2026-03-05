Return-Path: <linux-fsdevel+bounces-79529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEXDH4MSqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB26B2194D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9013030C7EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAAE36827E;
	Thu,  5 Mar 2026 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+WSp9HB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833D30C35C;
	Thu,  5 Mar 2026 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753431; cv=none; b=umDDayKleE5oIgpadI0xZmbZOg9JcrjZMwmMotnToKnDvY8xVf7DiXstyvjtr+WzhTGPW6kRh2Sxrl7Y522ZsX4gS4VW0/XLJ1mrmMpe+T7n5eNMGVCq8C83vYTDAyrj8Yq6rfoNxdfWpv4lZOdFoqaX7Ay0OTUHJmWQqcxTl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753431; c=relaxed/simple;
	bh=GZsbB5/oS0c6lwFJZSOuaHi3hJ1zBvMulcElef7p9ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEbLeDD18quc8nFX9imlI/LUY9UaSLtIvLWeCioTBQn4M5pL+jQbtldwIYWFAJMprDJZUULEwNFZXbgtpVt11CTPTkDrYI2ulgxXiMltlh9VnQXUXzRfy8wPxsqBRNZ0PIZ9hdn3u8pQeCueh8Jv9Cl5984SRVly/C0wR/86jxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+WSp9HB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED34DC2BCAF;
	Thu,  5 Mar 2026 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753431;
	bh=GZsbB5/oS0c6lwFJZSOuaHi3hJ1zBvMulcElef7p9ak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H+WSp9HBLcJEoo8qEvE0WuHJImxdXCE8ZgJ8caPYMyUJMFzb1jTsOS4wLA5flFg8V
	 mAFxumNB5tQY3PcNAGfztfNpMMHtQkLridjuFqKnlpShJAlkN/bndcsr8X1f1I/kCP
	 nqWoAyBrLkifZXZzf/F+gLWv/2KEN1+TuNo8qnBMhX9jzXEVMJZlVbJRMl3Oshzezi
	 578xmsTIS9gZS5f3R9T5xESK9anU24oEdLD4m/FYn2VI3DyC5gqPosBofK0YrTtha3
	 YwDZNVTh06PSoZGSdsTiRekDUL7l/sZ4wp7v1D27D/KdJfbEA9ZbY/e13m8cpIq4HA
	 s2J/K85BH539w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:07 +0100
Subject: [PATCH RFC v2 04/23] crypto: ccp: use scoped_with_init_fs() for
 SEV file access
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-4-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GZsbB5/oS0c6lwFJZSOuaHi3hJ1zBvMulcElef7p9ak=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuI8baaxrvvpnqku04XTEuau7Jsbv8jLSdRzF8eZR
 AVR+3lHO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaia8zIMJXvW2XqkmPyEQGB
 RxPm7Ft85IfYt4sCqkdaDGdvd0pu+cbIsMj6/MvF26rz3E4u3y68OtlpRmy65V/DFp5X2ckC+/d
 b8AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: DB26B2194D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79529-lists,linux-fsdevel=lfdr.de];
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

Replace the manual init_task root retrieval with scoped_with_init_fs()
to temporarily override current->fs. This allows using the simpler
filp_open() instead of the init_root() + file_open_root() pattern.

open_file_as_root() ← sev_read_init_ex_file() / sev_write_init_ex_file()
← sev_platform_init() ← __sev_guest_init() ← KVM ioctl — user process context

Needs init's root because the SEV init_ex file path should resolve
against the real root, not a KVM user's chroot.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 096f993974d1..4320054da0f6 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -260,20 +260,16 @@ static int sev_cmd_buffer_len(int cmd)
 
 static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
 {
-	struct path root __free(path_put) = {};
-
-	task_lock(&init_task);
-	get_fs_root(init_task.fs, &root);
-	task_unlock(&init_task);
-
 	CLASS(prepare_creds, cred)();
 	if (!cred)
 		return ERR_PTR(-ENOMEM);
 
 	cred->fsuid = GLOBAL_ROOT_UID;
 
-	scoped_with_creds(cred)
-		return file_open_root(&root, filename, flags, mode);
+	scoped_with_init_fs() {
+		scoped_with_creds(cred)
+			return filp_open(filename, flags, mode);
+	}
 }
 
 static int sev_read_init_ex_file(void)

-- 
2.47.3


