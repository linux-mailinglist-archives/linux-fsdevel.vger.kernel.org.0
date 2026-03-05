Return-Path: <linux-fsdevel+bounces-79532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMk4HuESqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:33:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C2A219524
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5720310CC2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EAD368260;
	Thu,  5 Mar 2026 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2OUrLt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0FE367F5C;
	Thu,  5 Mar 2026 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753439; cv=none; b=BB5aN5nieTkOwCRGaG8ef90FE6S1OZyxLAPgaqWSwx6ilWudK0wu9rClgTPwQKWwtzwilEinp/BO1ndNDr9AbDfOeif9Cx2FaeU8+917Z8q5NTUU3dyWab5kfLIxQJgCuisd2ZL7Lgcsc1GAhDviwBVphKE+aibv8+ZG58IxugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753439; c=relaxed/simple;
	bh=tqh5LkBF8hJuRKX1E/HzPe/YDkw6eJT1HDZFcFDFrFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=df0lY9UlKRRxwh3wOZ6Xfdbsc1DAU56uMp8/f97C+SGFJKFa5GN0BD8AUXmVOWQ/hWIlpb05u3bEw3h8QLHQT6d3zS3MxiAVjze9fxRxly9pJRSD+2tJIGsPKuLPA11V4T5/odw57niuA4QwX2qjnTCbQPSAWGADQqtUeXYbZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2OUrLt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97513C116C6;
	Thu,  5 Mar 2026 23:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753438;
	bh=tqh5LkBF8hJuRKX1E/HzPe/YDkw6eJT1HDZFcFDFrFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m2OUrLt73UwQ/lxAfzRzhYaoDhkGrPtQPRx88GbPQHL24NApX4RUExXzLxgyKoMmI
	 WNerIxdoaZAvdY7SDfDgV4Q1u6DP3/+QNfMi1XjMkAT8KE9TXvdTxYD8b9/7aEwDHg
	 BNKEd4Oq/cv1wtj2lz/LZOZac9488yxCzjXEWjv6ltIPeH6Z8AjM/+7vo9P71SJUHj
	 ECj0H4B4IrZMhRXae1790ToaNBEUYJ+NhxFcdICEx2+LLz9dctcIeIqvJdX/uX+xjm
	 a5ukCfWDsZwjwp+x2okLtHRE1HQGqHZTqxGVYkTUloG4XseMRdnVRAE1U+bDpjcN9b
	 A9nDZo3B+SHGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:10 +0100
Subject: [PATCH RFC v2 07/23] btrfs: use scoped_with_init_fs() for
 update_dev_time()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-7-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tqh5LkBF8hJuRKX1E/HzPe/YDkw6eJT1HDZFcFDFrFw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuJ8tH650LHMx1ekNoRxbvzdl860/JBK5w7lhJgp6
 pduxz/K7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI+TcM/zNaDEWed9w94av/
 9/PK1xtfhf6Il+G1Sp4/IWSaaE+FfAcjwxp7d+NV518rCU89EWn7a6qVoc1sD/Wpept5365fsX8
 hIxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: D2C2A219524
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79532-lists,linux-fsdevel=lfdr.de];
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

update_dev_time() can be called from both kthread and process context.
Use scoped_with_init_fs() to temporarily override current->fs for
the kern_path() call when running in kthread context so the path
lookup happens in init's filesystem context.

update_dev_time() ← btrfs_scratch_superblocks() ←
btrfs_dev_replace_finishing() ← btrfs_dev_replace_kthread()
← kthread (kthread_run)

Also called from ioctl (user process).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/volumes.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 648bb09fc416..b42e93c8e5b1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -12,6 +12,7 @@
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
 #include <linux/namei.h>
+#include <linux/fs_struct.h>
 #include "misc.h"
 #include "disk-io.h"
 #include "extent-tree.h"
@@ -2119,8 +2120,16 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 static void update_dev_time(const char *device_path)
 {
 	struct path path;
+	int err;
 
-	if (!kern_path(device_path, LOOKUP_FOLLOW, &path)) {
+	if (tsk_is_kthread(current)) {
+		scoped_with_init_fs()
+			err = kern_path(device_path, LOOKUP_FOLLOW, &path);
+	} else {
+		err = kern_path(device_path, LOOKUP_FOLLOW, &path);
+	}
+
+	if (!err) {
 		vfs_utimes(&path, NULL);
 		path_put(&path);
 	}

-- 
2.47.3


