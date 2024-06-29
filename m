Return-Path: <linux-fsdevel+bounces-22814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1549691CE41
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5A31F21E48
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88412D76C;
	Sat, 29 Jun 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="d1fqi5qG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A891E4AF;
	Sat, 29 Jun 2024 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719681888; cv=none; b=fPAGr4yvWBZiA7YLrLVYinPt6lgzxAxfvmUX/jE6t538pnyzhhfi69iwdipR+su93zc8WKU7DxzaDYKzZeWIys2ABuu3/uZKV7VUIzGPj+iusLcNv/pW7XEh4E3j8M3fI/VoXWIW4pqki65uecUQxnYGCQPgjVb3bQP18A+Zm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719681888; c=relaxed/simple;
	bh=B+8Tehx5au6fDdI4mC/c2z++QY07BkxYemXYvLEm0DQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hh1IlKbZur3CI1BR2rfl9FBsv0DxbOc4/WyU9DQpT5t9aYbfiyMMtj9e/QTm74kbuqnyapfZvmM2i9T+O6CEtnISRvbImNJZ1mz3t3hvAqHHG3dNIoz7u6aDgZPZC0CAuLFl0eFXK9QzypYG+gPhSQqoSUGyGhU0wmSBzyqTb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=d1fqi5qG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719681880;
	bh=B+8Tehx5au6fDdI4mC/c2z++QY07BkxYemXYvLEm0DQ=;
	h=From:Date:Subject:To:Cc:From;
	b=d1fqi5qGZ5pyKd6RiSCiIUf3nsbBbPCVBSx9WgIsgcYQns+gMjHJY8vKSeJppZMwE
	 zPo+SelLIPTa/3TETGtugHPiaorXiz7+D6WUb1Dqv4ccz1GQVPuWtPXI+gfQ+K8p7k
	 QKP/tRmm1acvFUCTjq+/deZcHSLylzp/PTee1eN0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 29 Jun 2024 19:24:31 +0200
Subject: [PATCH] sysctl: Convert locking comments to lockdep assertions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240629-sysctl-lockdep-v1-1-69196ce85225@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAE5DgGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNL3eLK4uSSHN2c/OTslNQCXSOzZEuDJHPjRHMLMyWgpoKi1LTMCrC
 B0bG1tQBj7A9lYAAAAA==
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719681880; l=2577;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=B+8Tehx5au6fDdI4mC/c2z++QY07BkxYemXYvLEm0DQ=;
 b=AzQL/LcMRkovx33ydYLW22BBe5Rz7e1ZT7t8MBVKb640YT5jxD9hCCEKBtBkMIiiw6yFLud1/
 WXibCYMZ9yXC/QmQpTFH3PTX70BgdbafBFnLmE6+hOR/uajD6zkz9G0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The assertions work as well as the comment to inform developers about
locking expectations.
Additionally they are validated by lockdep at runtime, making sure the
expectations are met.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Tested against the sysctl selftests and normal desktop usage.
---
 fs/proc/proc_sysctl.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b1c2c0b82116..1d9d789fbd3e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -17,6 +17,7 @@
 #include <linux/bpf-cgroup.h>
 #include <linux/mount.h>
 #include <linux/kmemleak.h>
+#include <linux/lockdep.h>
 #include "internal.h"
 
 #define list_for_each_table_entry(entry, header)	\
@@ -104,7 +105,6 @@ static int namecmp(const char *name1, int len1, const char *name2, int len2)
 	return cmp;
 }
 
-/* Called under sysctl_lock */
 static struct ctl_table *find_entry(struct ctl_table_header **phead,
 	struct ctl_dir *dir, const char *name, int namelen)
 {
@@ -112,6 +112,8 @@ static struct ctl_table *find_entry(struct ctl_table_header **phead,
 	struct ctl_table *entry;
 	struct rb_node *node = dir->root.rb_node;
 
+	lockdep_assert_held(&sysctl_lock);
+
 	while (node)
 	{
 		struct ctl_node *ctl_node;
@@ -258,18 +260,20 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	return err;
 }
 
-/* called under sysctl_lock */
 static int use_table(struct ctl_table_header *p)
 {
+	lockdep_assert_held(&sysctl_lock);
+
 	if (unlikely(p->unregistering))
 		return 0;
 	p->used++;
 	return 1;
 }
 
-/* called under sysctl_lock */
 static void unuse_table(struct ctl_table_header *p)
 {
+	lockdep_assert_held(&sysctl_lock);
+
 	if (!--p->used)
 		if (unlikely(p->unregistering))
 			complete(p->unregistering);
@@ -280,9 +284,11 @@ static void proc_sys_invalidate_dcache(struct ctl_table_header *head)
 	proc_invalidate_siblings_dcache(&head->inodes, &sysctl_lock);
 }
 
-/* called under sysctl_lock, will reacquire if has to wait */
 static void start_unregistering(struct ctl_table_header *p)
 {
+	/* will reacquire if has to wait */
+	lockdep_assert_held(&sysctl_lock);
+
 	/*
 	 * if p->used is 0, nobody will ever touch that entry again;
 	 * we'll eliminate all paths to it before dropping sysctl_lock

---
base-commit: 27b31deb900dfcec60820d8d3e48f6de9ae9a18e
change-id: 20240629-sysctl-lockdep-26c90b73a786

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


