Return-Path: <linux-fsdevel+bounces-59542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2A5B3AE01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9761F1C27D5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB222E2F1D;
	Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ELq2o+f8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA92D0C8E
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422491; cv=none; b=mEA+LsUc/5GPc0hafZBAg4XLhsg874S8JEc6j7s3vbtitGYAU5jX2TAZRrxobvIw6OXFFE0JkzmdRYE0zr3cuCrAy+e5oCyEVesRHE+27N5U+o2qgzdhUdhrvxtD4k2BombsmIpyzpX22oLplpJ2rZ8XGfdTDLRtQns3fuaJ5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422491; c=relaxed/simple;
	bh=ZA/I6ATUJ7gTqfB91VBuX9UsKaI5P/qtUzDaQzfS3gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqxZNaF02ce3lhAl4rGQJdDhmnp28adJ01JHvTTuT2hvOLlYTPhnj+PVhRfl2CdNPjTcm/T8xJX2LzhYyFE4eq17odatYSkChicRzQUOgZ96s6DEonMikpa6efg4G7QATxAZCstfgdGtE+5KdFhZ6z5Pe9iu18kyO0k3PY2f+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ELq2o+f8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RXRYMxHMtTYO2oUNtftckV8ygh0YBhFf1p5sPdf4LnA=; b=ELq2o+f8EOHBZ4GNYBUruUBO3n
	vAdkvfy2V6wTJOJeosC4RLIC19OLSslFnN9CZ+lJfsWPGKbbovM5ZR6PSbZF9+KCUxTe1sGig1W2n
	2zpZtWCLIaznx8vXyRry3aRuJpGBgOjahn2bTh/a0y7nuWgRVon6/CEn2eYQIb99aSuqg/qx8I4fX
	17007DdL6S61oCUwJhpUAzcIGNlHp/U/dQN/f976Dyoq8eIIR1ixoU5M1NQrKZbFpO3pA6ZFwsewG
	Ej6hTBizfpwVJdb2YhIfhb5MUtEHKVNwanYOn1WrGS2wF5nf8PfbDbsN7Jc/plr4WLKaBonhNtA/2
	DwFJfUOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F22c-1SqS;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 14/63] mnt_set_expiry(): use guards
Date: Fri, 29 Aug 2025 00:07:17 +0100
Message-ID: <20250828230806.3582485-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

The reason why it needs only mount_locked_reader is that there's no lockless
accesses of expiry lists.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2cb3cb8307ca..db25c81d7f68 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3858,9 +3858,8 @@ int finish_automount(struct vfsmount *m, const struct path *path)
  */
 void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list)
 {
-	read_seqlock_excl(&mount_lock);
+	guard(mount_locked_reader)();
 	list_add_tail(&real_mount(mnt)->mnt_expire, expiry_list);
-	read_sequnlock_excl(&mount_lock);
 }
 EXPORT_SYMBOL(mnt_set_expiry);
 
-- 
2.47.2


