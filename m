Return-Path: <linux-fsdevel+bounces-79528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IuMLxgSqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:30:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6952D219463
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 441623020A43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E9368282;
	Thu,  5 Mar 2026 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTQAPQCw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85535E92F;
	Thu,  5 Mar 2026 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753428; cv=none; b=Th7Cs7Muvfe5kWBY6/Sc0zt/cnf2iYgExz6PyrPz/MFbLGt5ZczmnkQr6wYhWStv9J/uUqq/Ha72hXlxyVMtTrLw7hcBvfpsodKFGXO7e87FS6W1szQE2ZPeDa+JA3umOLPOH3JpyqM+uFQ6GLalJNON+HsNcN+BeMo6eGKiIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753428; c=relaxed/simple;
	bh=jsmYqEfin/W6QXrJh5f/89X3/kJ/bACDGoIAjq0LjVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQc2AyOiA9EYjPv7nE5tHHRgCnKvVT7VBl8A9WS5aBjEYpVPBpvV/Tt95g2hEAXzhcMwEBcrz4ARfpZSaxaIqfBiHo78+s7rLjbhEN68hODNnrs2yJ7vMkdTjZ5ltz2j0ucZF3GRkwWaV1czcx1c6DDzfRFRwZF8fU0y8rf1ioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTQAPQCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A1C116C6;
	Thu,  5 Mar 2026 23:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753428;
	bh=jsmYqEfin/W6QXrJh5f/89X3/kJ/bACDGoIAjq0LjVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NTQAPQCwE7GWorbCtaq2XPX40KiiqXAO5phQMZne8DPF0ceqeg1R5PhDHPOyb/wfN
	 7djs+ZUVjODLfRGTcUQnhke+bVrl+293ECA1DNc6p75EzcGBqYgdsu4+bwy1KaXVMn
	 kPTBoSsVqRApQPIj7Qsz8LEWkl7eCFXLJwPchbTpsRV8WQ5+K6/DVtuUKTuEHFf75L
	 aS7qXRg8uw66+MHODZ7Zl5S2lJLeUWqCX67eDkSMyRR8I4kl0M9ogtBBoZWbjzY+YS
	 QvsnjvW59yNNhkI/6NXi6sGiwQ/4YbKSvqHRiOX8K1Kn/xHT5aog0XJglQmOGjfN3M
	 X8er0b+CmSIsw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:06 +0100
Subject: [PATCH RFC v2 03/23] rnbd: use scoped_with_init_fs() for block
 device open
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-3-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jsmYqEfin/W6QXrJh5f/89X3/kJ/bACDGoIAjq0LjVg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuIMVTipc2tu4JWcZHH5/fPO3ZuxKtjj8o4a1bpvz
 Mduqeu97ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIrx0jw2G10l1+atyy6ZM/
 n4nsaXIN2JpR2Hzur4eX+1PNxY2Tixn+qQkVcmsslP0j4uPP8n3Oho0Ncd1bj3hlfJurWPggct9
 nTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 6952D219463
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79528-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use scoped_with_init_fs() to temporarily override current->fs for
the bdev_file_open_by_path() call so the path lookup happens in
init's filesystem context.

process_msg_open() ← rnbd_srv_rdma_ev() ← RDMA completion callback ←
ib_cq_poll_work() ← kworker (InfiniBand completion workqueue)

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/rnbd/rnbd-srv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 10e8c438bb43..79c9a5fb418f 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/blkdev.h>
+#include <linux/fs_struct.h>
 
 #include "rnbd-srv.h"
 #include "rnbd-srv-trace.h"
@@ -734,7 +735,8 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	bdev_file = bdev_file_open_by_path(full_path, open_flags, NULL, NULL);
+	scoped_with_init_fs()
+		bdev_file = bdev_file_open_by_path(full_path, open_flags, NULL, NULL);
 	if (IS_ERR(bdev_file)) {
 		ret = PTR_ERR(bdev_file);
 		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %pe\n",

-- 
2.47.3


