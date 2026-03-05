Return-Path: <linux-fsdevel+bounces-79538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDg/FnwSqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1039A2194C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8C58305E38D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BCC369998;
	Thu,  5 Mar 2026 23:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJn2ywop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509F369209;
	Thu,  5 Mar 2026 23:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753454; cv=none; b=WGJY77gdV42SLUWAbx8/f5NualFgz892mrMbzGtzBV8oIF1hi7Jh/bECAg6MXWYZYATerDNQkeYl4zv4LWnwWhdt+nh9m6MMCBKquvEAooFYCP5nTKzfJa2Yg95fe1BsMF4sYiTtl/oERl3E1PaMzsbUhK61C4AAC/H3ONP/fBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753454; c=relaxed/simple;
	bh=NMdeYCQo1GHzMKmmqiJ3TF42UZ8RhEoUp+v0qV5T3nQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tj7MzgCNzheyShigYPMnw0PWDCAdB6aLnE+G5oP2SPDlAAFD7H/Zl7HCc88RMzkXJISJp/oNFw5uNPA2xcK9VgKYhxP4OL5DtylV8aHJQkSH/nJJIDpgVPYwKUfsVr5tP7mruIglU6l9XMGgyPDHG815jKF1tvSH9wOb92lCgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJn2ywop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01010C2BC87;
	Thu,  5 Mar 2026 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753454;
	bh=NMdeYCQo1GHzMKmmqiJ3TF42UZ8RhEoUp+v0qV5T3nQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BJn2ywop1YP0R/jxv9DMqY/Qb5YIephmyBNzdIXU1q6oiNX2Jxdjr7u6ykkt5FWVD
	 xLW1/brpvaTAPvXAOeqJ4qqcfh1PTiulRCcS2Lsxa4ORCBsL0gdpYPEwV4SrxyGqLS
	 EsesZd3SvSoImKFR/KQRiYRODwxz/+tA6KNRcNYuzdzDeM1l0S661oIRdHOlT3o/jj
	 OpUHnTCFO4dvbQrmTrjOx5w0Z3cFYHqK0MixTEId+YojGNfVz7UniTcC72Sb/N+xIa
	 ZD63879NnLp2PP+Vv3nxRWbOFihaVAHHKDjaudsZc5eageym2EtpL5q8IRCU+IabSV
	 uvZve5y0u1jbQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:16 +0100
Subject: [PATCH RFC v2 13/23] initramfs: use scoped_with_init_fs() for
 rootfs unpacking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-13-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NMdeYCQo1GHzMKmmqiJ3TF42UZ8RhEoUp+v0qV5T3nQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuJaf7DdJjn627qIklquYNeAxTwMv+p0Tuok+PJNf
 vOQtcGno5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL37jAyrNQPt+VfWNv9yGr7
 66MfUtMu7RPbzc0X5CARUZp7YebLBwz/M72ayxOFWOZ1fT8skmVqJuSwYOlUGfmfs8pvLN9k1VL
 MAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 1039A2194C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79538-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Extract the initramfs unpacking code into a separate
unpack_initramfs() function and wrap its invocation from
do_populate_rootfs() with scoped_with_init_fs(). This ensures all
file operations during initramfs unpacking (including filp_open()
calls in do_name() and populate_initrd_image()) happen in init's
filesystem context.

do_populate_rootfs() ← async_schedule_domain() ← kworker (async
workqueue)

May also run synchronously from PID 1 in case async workqueue is
considered full. Overriding in that case is fine as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 init/initramfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 139baed06589..045e2b9d6716 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -3,6 +3,7 @@
 #include <linux/async.h>
 #include <linux/export.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
@@ -715,7 +716,7 @@ static void __init populate_initrd_image(char *err)
 }
 #endif /* CONFIG_BLK_DEV_RAM */
 
-static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
+static void __init unpack_initramfs(async_cookie_t cookie)
 {
 	/* Load the built in initramfs */
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
@@ -723,7 +724,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 		panic_show_mem("%s", err); /* Failed to decompress INTERNAL initramfs */
 
 	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
-		goto done;
+		return;
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
@@ -738,8 +739,13 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 #endif
 	}
+}
+
+static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
+{
+	scoped_with_init_fs()
+		unpack_initramfs(cookie);
 
-done:
 	security_initramfs_populated();
 
 	/*

-- 
2.47.3


