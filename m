Return-Path: <linux-fsdevel+bounces-50537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19DBACD029
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE683A6BA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4C21129D;
	Tue,  3 Jun 2025 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TvL2eG/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E926ACC
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992633; cv=none; b=Qp64Yz4gZ9bY/2nF4C7J2tX94Mm4wgoxsp8/5OLkGnr+cAyH9Y7vD34p6Yrzox7cnnf8ZWaWtyruYrApMSeMbGD9V3u5gqGwRucUHVpZQyK4PPNwg/GI/jTAqDX5CurT8NQmqFiN+BbySnD9G3v78fdKUEK29Y2gzdoCC/J/zmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992633; c=relaxed/simple;
	bh=nBAyzrSiOhpJMHsiuKfXM+3xgM53QFzhBaxrnpCjNuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2dMANV8H0EP8PMI81WkJBkboXxGttYKbCz2TV5KWsGcF0jYlxTvVA00AWsywjvyLYqbFlFWEbU+QOYrvdWUZX6wVqMdpEcqr8j0IUI//lhtbtZkOBTY8DNwrsmdrlYCWY0ajgT6RNvBz/1jkvpEXE1NT+8i+q2Wm6mQuhFb4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TvL2eG/L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=40zKGwtytHYHqL4gOa96owCTUY5DAnKaFR749LzLcnM=; b=TvL2eG/L8JxPVHEWLbob8bM6oP
	dZFMWrqYrxR8cK2e8BUq4kK+PSp1Gg9UlY/O7OYeXW/P7GD5OmaiWRZJn6f3PaHzsDd7qbRcglhrL
	h4FS1Qkt1Ls/S59mm41bOSB1bvdFbDjzwd+fc44aPtuGrVyFA/gVJc6ai4gYr0pwGm5m6h5D2ynUi
	VkwVeOH61MN0Hr+tgir+tnUK6i2Smcuu4JNnQGzXXolnUXJp59Y0UrUQpGbN6ZLKMdr3VV7gjHdn1
	PyWPVcp6ydvfhK6RZ4n6wjeanPXaPlQn84be9PAVsDcdYWegjlsJXC2ft3nUgDIEDJXRXaXlw7Fum
	dw1YS/ww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMasX-00000000chE-3fXm;
	Tue, 03 Jun 2025 23:17:09 +0000
Date: Wed, 4 Jun 2025 00:17:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/5] path_overmount(): avoid false negatives
Message-ID: <20250603231709.GB145532@ZenIV>
References: <20250603231500.GC299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603231500.GC299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Holding namespace_sem is enough to make sure that result remains valid.
It is *not* enough to avoid false negatives from __lookup_mnt().  Mounts
can be unhashed outside of namespace_sem (stuck children getting detached
on final mntput() of lazy-umounted mount) and having an unrelated mount
removed from the hash chain while we traverse it may end up with false
negative from __lookup_mnt().  We need to sample and recheck the seqlock
component of mount_lock...

Bug predates the introduction of path_overmount() - it had come from
the code in finish_automount() that got abstracted into that helper.

Fixes: 26df6034fdb2 ("fix automount/automount race properly")
Fixes: 6ac392815628 ("fs: allow to mount beneath top mount")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a33553bc12d0..1722deadfb88 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3478,18 +3478,25 @@ static int do_set_group(struct path *from_path, struct path *to_path)
  * Check if path is overmounted, i.e., if there's a mount on top of
  * @path->mnt with @path->dentry as mountpoint.
  *
- * Context: This function expects namespace_lock() to be held.
+ * Context: namespace_sem must be held at least shared.
+ * MUST NOT be called under lock_mount_hash() (there one should just
+ * call __lookup_mnt() and check if it returns NULL).
  * Return: If path is overmounted true is returned, false if not.
  */
 static inline bool path_overmounted(const struct path *path)
 {
+	unsigned seq = read_seqbegin(&mount_lock);
+	bool no_child;
+
 	rcu_read_lock();
-	if (unlikely(__lookup_mnt(path->mnt, path->dentry))) {
-		rcu_read_unlock();
-		return true;
-	}
+	no_child = !__lookup_mnt(path->mnt, path->dentry);
 	rcu_read_unlock();
-	return false;
+	if (need_seqretry(&mount_lock, seq)) {
+		read_seqlock_excl(&mount_lock);
+		no_child = !__lookup_mnt(path->mnt, path->dentry);
+		read_sequnlock_excl(&mount_lock);
+	}
+	return unlikely(!no_child);
 }
 
 /**
-- 
2.39.5


