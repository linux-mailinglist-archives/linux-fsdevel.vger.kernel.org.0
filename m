Return-Path: <linux-fsdevel+bounces-79530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGGNAq0SqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:33:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400C2194F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6516E30EC56F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BD368290;
	Thu,  5 Mar 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujwOcZVf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A60346E7D;
	Thu,  5 Mar 2026 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753433; cv=none; b=dlF7FXczt13wRANubbYxrxfCrnJhuCs1G+l5qOp6ZKqCBdx+QFn72M4++aDldgTdOWImvNP/ptbRnWAZOhCmXzUMA/1qIcAeu8FXTtYJlIP5yjbr0OHjZ5wfdKgHaDUF5hPI+p1MGW9JIhxCGn3+RaBadbRXwPDloZddzQYgcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753433; c=relaxed/simple;
	bh=BkzEXSS/aDyD/0RcykK+9iDod6MNEZ0v8zFBHEaX1Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XWCbqtOoiMMVrQnDxSJzoVbcCQsv3iebqVpxugxbGR6u82CwQet3YijJdeL6bbCYb57mT7jvJOOdzw2yA2o/tUsIsmR0vQFG5s/lsvsVSvno2rzYjnpJ5qTJQDl4iL+u6z2MopMQYb5njnwD2O7O1vo2ttnwruA5FrKyLte5rAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujwOcZVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7713DC2BC9E;
	Thu,  5 Mar 2026 23:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753433;
	bh=BkzEXSS/aDyD/0RcykK+9iDod6MNEZ0v8zFBHEaX1Bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ujwOcZVfWBoUIlAjZe1ivZpLIenFzt+MmFOa4xbzisCbtwhTHAQPV5dduAZQ+NG2k
	 NqEJ8jiM7l5bzMpOc/mUGfLuxjmnS06AwY2R3+jbsa98JWV7EMOt5PQ6H0hpx1lKS/
	 06sKMzmUArqGjwgAwWrH16AilswszH7QtynePdKwQPNpnQeaKDcOLiws/QgORhV+wH
	 YKsNGXc/IPqw57tjiJ0SIJS1LMuzNk4Gx/02ZanCqpeim9h9G1yQCiIAzNcClTm78x
	 1OCDKzXVk156is46+Ku36Yn4jF/E3OcfMCf81cxmCwYESR7Fn9VK4cGpkLC67i8vYZ
	 aJ75kNMnNq3dA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:08 +0100
Subject: [PATCH RFC v2 05/23] scsi: target: use scoped_with_init_fs() for
 ALUA metadata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-5-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BkzEXSS/aDyD/0RcykK+9iDod6MNEZ0v8zFBHEaX1Bk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuKs1urKveXZKGOwKiNIQvnDLo34KyWXryntqDN7y
 dZrk9/XUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFp+gz/FHeVXJwl3hW4kP+O
 hdps83emufpJPItkV8/W9BC9pVDgx8gwNdRPtPLmOesqSYdeCcNEzsUHpjjtTFR4yFz5xGXVLEY
 eAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 6400C2194F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79530-lists,linux-fsdevel=lfdr.de];
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
the filp_open() call in core_alua_write_tpg_metadata() so the
path lookup happens in init's filesystem context.

core_alua_write_tpg_metadata() ← core_alua_update_tpg_primary_metadata()
← core_alua_do_transition_tg_pt() ← target_queued_submit_work() ←
kworker (target submission workqueue)

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/target/target_core_alua.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 10250aca5a81..fde88642a43a 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -18,6 +18,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <scsi/scsi_proto.h>
 #include <linux/unaligned.h>
 
@@ -856,10 +857,13 @@ static int core_alua_write_tpg_metadata(
 	unsigned char *md_buf,
 	u32 md_buf_len)
 {
-	struct file *file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+	struct file *file;
 	loff_t pos = 0;
 	int ret;
 
+	scoped_with_init_fs()
+		file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+
 	if (IS_ERR(file)) {
 		pr_err("filp_open(%s) for ALUA metadata failed\n", path);
 		return -ENODEV;

-- 
2.47.3


