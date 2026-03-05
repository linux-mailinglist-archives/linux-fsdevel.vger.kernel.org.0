Return-Path: <linux-fsdevel+bounces-79536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOYzETIUqmlWKwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:39:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA6A219664
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82BAD315534B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3533C368948;
	Thu,  5 Mar 2026 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOK3xPhB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B086836827E;
	Thu,  5 Mar 2026 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753448; cv=none; b=lLtr/EpbrwEIDuxFIT9KkdBfR31VP8j6RtxEkBN+VL5kRFXl/RQh86KaAjboQes5IhZi+ecP8ccvjBQQc7/HNDRzDfHz77ObZPiZJJS9wGtil2ISaRGPtEnRNxRuP9soR8TT1t5FLStPTI3O76fWeBqABE2/U31L4xK6H/1BFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753448; c=relaxed/simple;
	bh=l6PdqSMlvF3b2b9R+GwUvIJev9lUgXCwT4zIDcHSxvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OansQhRADFEl7MEG4D2hcoM28zo4cdIuwt3xtl8bhEUhwBQhTrSOy0KALDLF5SNiIhCayHXJEYvfOUF+pjtTmVLqalj2MMdtDIS2H5oBUFvrFauRlGy+xRWZnBvcJ3bleu5PewklJXrOWraKO4yHCenx+2za03x3XkF0bbD1J/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOK3xPhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8048FC19423;
	Thu,  5 Mar 2026 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753448;
	bh=l6PdqSMlvF3b2b9R+GwUvIJev9lUgXCwT4zIDcHSxvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hOK3xPhBYSMcN4s6Wol/7FqBx0biZqvOYEs6j7CEYTFExMNRF8BudzEGnZ1YGJFU1
	 +mheRURchbLM39lVCax8esxTDYjh8J9AYUYCQpyXbqFmgw2O8Kra0dOHl6e2uzHFtu
	 UltDYGOGK9jVX2TAQyMG4fLlJn9slhtUgr2QJd1+XputTrNv0idTYnPwx1hnerBKvc
	 GSqDeCpzyg4rUwCuU59R6XfS9ZrJbPjrXXXXg0VU7kfaPranmiRWWOlxAYQrTcId/k
	 6e6A5Wf770efd5LXp3WdFrvEJY+WHnUNlNZxy/plDWuYamnNvMsflEZBmsMye1mttM
	 4HVkybOIpKCCA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:14 +0100
Subject: [PATCH RFC v2 11/23] ksmbd: use scoped_with_init_fs() for
 filesystem info path lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-11-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l6PdqSMlvF3b2b9R+GwUvIJev9lUgXCwT4zIDcHSxvE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuIUuVhymlmdLctFlsl/zmP7VQt7DtVes+OYuNrAY
 /vGXevZOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSeIPhr1xin64s455js3d+
 qVvGHH/Votn+jpbRXYYwe/5Pm6QSqxgZ9n95cimCScI3b+kswwsnLmzNM/V+ULDSavohw7rXs95
 d5gUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 8CA6A219664
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79536-lists,linux-fsdevel=lfdr.de];
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

Use scoped_with_init_fs() to temporarily override current->fs for
the kern_path() call in smb2_get_info_filesystem() so the share
path lookup happens in init's filesystem context.

All ksmbd paths ← SMB command handlers ← handle_ksmbd_work() ← workqueue
← ksmbd_conn_handler_loop() ← kthread

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/server/smb2pdu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 743c629fe7ec..0667b0b663cd 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -9,6 +9,7 @@
 #include <net/addrconf.h>
 #include <linux/syscalls.h>
 #include <linux/namei.h>
+#include <linux/fs_struct.h>
 #include <linux/statfs.h>
 #include <linux/ethtool.h>
 #include <linux/falloc.h>
@@ -5463,7 +5464,8 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	if (!share->path)
 		return -EIO;
 
-	rc = kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
+	scoped_with_init_fs()
+		rc = kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
 	if (rc) {
 		pr_err("cannot create vfs path\n");
 		return -EIO;

-- 
2.47.3


