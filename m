Return-Path: <linux-fsdevel+bounces-51125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099EFAD2FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F3416628B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4272820D0;
	Tue, 10 Jun 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MxYcrUHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946427FD6E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543713; cv=none; b=oBmJHvKgZ1TYWdHcqSMJNic90uGwlgWHkYDX+ec5tuAUZ2mQQBKxlAmPb4QPu7nvTOg8iNkqti8x03sk86CGgNEwS/i72I1b/LtM8wceSmI+Cl1y42GMLUrE61FWc5/cVGQvsTVis9cBlKRr04BuUtIDm8J/EP/s8YjgY2p0/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543713; c=relaxed/simple;
	bh=v+8M7KvVLGJl0c9lZ4FqxGAHI0piIpFkkdMWRPWosfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJkZJ9rOnF28W8RAWAzgh6lE8fHJhBiONVv/UJ2gmlgmajfWDFFVH0bKHM3lZ2XD1+FfZie/BTu8FKPKscyQ6dwv1/Cr5rqKPTK/Lp1lVNiJ5FXun9kLxeKGWoPzCEuiWQWdH9wVhFmRuUFionauVdSSQ0e34XSM0kvsYDkCsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MxYcrUHz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LKurZre/q2Ejsn0ajXYXsl8vO1Z500wF9eI4IgkESGM=; b=MxYcrUHzsooIwq5nMYAQ4wATL+
	A2mV7g/E5Jwar1KwxJZD/c6zUo5je6cxlrTS7KUzuQQ6OGmM4UqdRfzGQwF6Csfg/mQAepc1yqp+E
	iZbgfeVAJaSoF50ii8yR1kP+FmY8pcLtfzzAdJI8TIsXHtGcqkGG/6fCNWADnHkpmYN0sATGnBjCv
	Vwp9mq30pThHqekpoYueGJcSHFcRIXadIU9OVNqc586Olkae39oyHq+M3609DLy9rBgpk0YAup4mx
	/5rlMe1sbbJacDH5R1OoOkYbkMV5OkgfQJg4eBO+Hh6jBEsF0DCYv9JPaQfIdVrmZ8MINAENtXKYt
	wcfZ1uig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEv-00000004jL2-3pRd;
	Tue, 10 Jun 2025 08:21:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 05/26] constify is_local_mountpoint()
Date: Tue, 10 Jun 2025 09:21:27 +0100
Message-ID: <20250610082148.1127550-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     | 4 ++--
 fs/namespace.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 02e5d7b34d43..9fe06e901cc8 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -146,8 +146,8 @@ struct proc_mounts {
 
 extern const struct seq_operations mounts_op;
 
-extern bool __is_local_mountpoint(struct dentry *dentry);
-static inline bool is_local_mountpoint(struct dentry *dentry)
+extern bool __is_local_mountpoint(const struct dentry *dentry);
+static inline bool is_local_mountpoint(const struct dentry *dentry)
 {
 	if (!d_mountpoint(dentry))
 		return false;
diff --git a/fs/namespace.c b/fs/namespace.c
index b60cb35aa59c..2fb5b9fcd2cd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -894,7 +894,7 @@ struct vfsmount *lookup_mnt(const struct path *path)
  * namespace not just a mount that happens to have some specified
  * parent mount.
  */
-bool __is_local_mountpoint(struct dentry *dentry)
+bool __is_local_mountpoint(const struct dentry *dentry)
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mount *mnt, *n;
-- 
2.39.5


