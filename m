Return-Path: <linux-fsdevel+bounces-53307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB491AED56E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A953A966E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C211FBCAA;
	Mon, 30 Jun 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HzjA6Fqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530001FDD
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268064; cv=none; b=rbUHgInDH/rWGw6BVxZLmrShepk53NE/M5jiXVmzC5sV8g9Rb2zVPScBZJrw8+BZvJQZ1zu6FkdSb49uEq/i+0403LJlxrkLQE8QtErgwKOAsXdv0gB5FC/z6GYUCVVwxJdNcKsIdJJ5Eg+/VE/0z6xB/JAy1syb668eNuKEDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268064; c=relaxed/simple;
	bh=Mm3XYrRMpoL4bdfh9i9EfrGhRRIVWdZU2XPq0iW8iZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KLFpzKre0zyXAG3qhK99JoSVgU4LUT2FMlNSVwFu+++0Ub/pQiKBfPPJCvIqA9klKfRwR28PVdPPkkhV0YV71R7wzmnrz3jyxvp0WZs8fyn0Eo4DsadxMds1KM46p3E3GaNAt8re31MUBFOdfwsldPvanf0bAq63c7kV/LDBkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HzjA6Fqp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kLi2/lD++rdIbyKEtQoNLPRIVuLdp2qI4m3mzl4qp84=; b=HzjA6Fqp3FbkcI9udaJQvgY3A7
	pCHhjH3ubuUqV41rMgXJ8smIo7dGjW1h/szPVuimJR26UoLBhUIotc+ariteY+T61r8/9UTarARxH
	Hnvm0p2DmrRQ0fNw0eh+0AC8ebNKMZd0eX/asoBj0KCz63ztlbxJeH25Hageq0tzRgwr+zaJDirbV
	GpdasVH4XLx0lGPlpkkGy/VOpjDiS/6UbiuAVifN7AxJIu2bG9j2eHQGNjzRSPKVS1kf3cXdQ8mz2
	tUj2o6woIF3BJUITALznYQw21xekR8OXK9tJ5hUtGcPqXYtN5REf0hFP8RKOxhydf5r33uzBYCloE
	no3SlSUw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8p1-00000007syz-139g;
	Mon, 30 Jun 2025 07:20:59 +0000
Date: Mon, 30 Jun 2025 08:20:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH] fix proc_sys_compare() handling of in-lookup dentries
Message-ID: <20250630072059.GY1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[In #fixes, I'll send a pull request in a few days unless anybody objects]

There's one case where ->d_compare() can be called for an in-lookup
dentry; usually that's nothing special from ->d_compare() point of
view, but proc_sys_compare() is... unique.

The thing is, /proc/sys subdirectories can look differently for
different processes.  Up to and including having the same name
resolve to different dentries - all of them hashed.

The way it's done is ->d_compare() refusing to admit a match unless
this dentry is supposed to be visible to this caller.  The information
needed to discriminate between them is stored in inode; it is set
during proc_sys_lookup() and until it's done d_splice_alias() we really
can't tell who should that dentry be visible for.

Normally there's no negative dentries in /proc/sys; we can run into
a dying dentry in RCU dcache lookup, but those can be safely rejected.

However, ->d_compare() is also called for in-lookup dentries, before
they get positive - or hashed, for that matter.  In case of match
we will wait until dentry leaves in-lookup state and repeat ->d_compare()
afterwards.  In other words, the right behaviour is to treat the
name match as sufficient for in-lookup dentries; if dentry is not
for us, we'll see that when we recheck once proc_sys_lookup() is
done with it.

Fixes: d9171b934526 ("parallel lookups machinery, part 4 (and last)")
Reported-by: NeilBrown <neilb@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index cc9d74a06ff0..b0ff2d21a3d9 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -918,16 +918,20 @@ static int proc_sys_compare(const struct dentry *dentry,
 	struct ctl_table_header *head;
 	struct inode *inode;
 
-	/* Although proc doesn't have negative dentries, rcu-walk means
-	 * that inode here can be NULL */
-	/* AV: can it, indeed? */
-	inode = d_inode_rcu(dentry);
-	if (!inode)
-		return 1;
 	if (name->len != len)
 		return 1;
 	if (memcmp(name->name, str, len))
 		return 1;
+
+	// false positive is fine here - we'll recheck anyway
+	if (d_in_lookup(dentry))
+		return 0;
+
+	inode = d_inode_rcu(dentry);
+	// we just might have run into dentry in the middle of __dentry_kill()
+	if (!inode)
+		return 1;
+
 	head = rcu_dereference(PROC_I(inode)->sysctl);
 	return !head || !sysctl_is_seen(head);
 }

