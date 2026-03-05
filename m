Return-Path: <linux-fsdevel+bounces-79535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ABwLVASqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:31:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667221949F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4C6E3043AE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90E369211;
	Thu,  5 Mar 2026 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ3tLrvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34086368976;
	Thu,  5 Mar 2026 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753446; cv=none; b=qs5Bh3vvQUWzYByBHfrX3fj/I43rl34V7coV4DjNH/C2dsUkbxRto6XMms8Kj6yzuaV1hLqDgGMpYpyNYjfQ5l3tQ1r7fM1N9W/wfjNDykwPMgMJfRB0SgE1M+jRoWsJxPqZZrGmNE6ewqlQ0oNo4O/FRK4MfO2Z+PadUJoFKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753446; c=relaxed/simple;
	bh=2kDcoaN93XMP+vh/JKpvMv+7AMIQDdbFl8rAi3BOMms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZtUF9Q9kYyzRvQYqxG2GsXGDFz9Krr4UY1tb/s569yF2/0RyqJZq8J9qKuQG1MPpT5XFvkKjTp114wBpVe+TCUjA+YesaBTZeMh5Dh6hlZ3vhIoFQ7R9vWtBD9f4zJPValy2+XLSFsbwOqG40T1v7ysGEl0H0VLG2sxG3NTuuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ3tLrvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DECC19423;
	Thu,  5 Mar 2026 23:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753446;
	bh=2kDcoaN93XMP+vh/JKpvMv+7AMIQDdbFl8rAi3BOMms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hQ3tLrvENvt2R972Z9RbkxkNsJ6twwB1LIxphNjAm+YxjlOtkgaZx7Fl94Z4aMedg
	 KcVflawvRCfuFZHmtBr5e7jVcVH3Du4NTXokW8UKmfHleA6DCEcS3h4PhiS5nds4VE
	 Eao/vE/8L3uQyGtO73MYqILHeez4mXgTnyw7P0i7fhd0jgMyq8ciM3CUzEhtwTwMqm
	 PL0rHi5yKDKI0Ee9Pu/sQ1Er4f8Zy3WT809UTzAUUgo2YHpcpK/6/wvgxVmzL5Ak/W
	 2mu5qA37FRzxXtycGbPBCL5nEakzLikzfrkpHXoO68KT+27PcRAIuJ+fGXxjw0KxgS
	 0sF7DIYQwnA2w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:13 +0100
Subject: [PATCH RFC v2 10/23] ksmbd: use scoped_with_init_fs() for share
 path resolution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-10-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2kDcoaN93XMP+vh/JKpvMv+7AMIQDdbFl8rAi3BOMms=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuK89aZl8Z22TW2Ns5fXv+tNDWOK/HjR5NG1yY8Xb
 Zz++GeCS0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEfogyMjyVNmwPDv/4bsXK
 /Mkz+gWObJgV0H9wxZ3UkvX2rsvKebYyMnxSCwsI0ugwvl4896dP2LzU5HecWupaTAHKHMfixVf
 HMAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 3667221949F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79535-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use scoped_with_init_fs() to temporarily override current->fs for
the kern_path() call in share_config_request() so the share path
lookup happens in init's filesystem context.

All ksmbd paths ← SMB command handlers ← handle_ksmbd_work() ← workqueue
← ksmbd_conn_handler_loop() ← kthread

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/server/mgmt/share_config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index 53f44ff4d376..4535566abef2 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -9,6 +9,7 @@
 #include <linux/rwsem.h>
 #include <linux/parser.h>
 #include <linux/namei.h>
+#include <linux/fs_struct.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 
@@ -189,7 +190,8 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 				goto out;
 			}
 
-			ret = kern_path(share->path, 0, &share->vfs_path);
+			scoped_with_init_fs()
+				ret = kern_path(share->path, 0, &share->vfs_path);
 			ksmbd_revert_fsids(work);
 			if (ret) {
 				ksmbd_debug(SMB, "failed to access '%s'\n",

-- 
2.47.3


