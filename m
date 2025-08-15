Return-Path: <linux-fsdevel+bounces-58057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80EB288CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E045B638B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 23:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030522836B4;
	Fri, 15 Aug 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CqgqpMJF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE8165F16
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300860; cv=none; b=PdZ4dWZ+mZriaSGSM004oSRmEJ/sfX9/GNyegyP6OzjTJc/Rwatz526BNl99+ZSSw6MrLBNpykDWDBRwsBjV4TpCqzhQKQAXVMNcB1RDIgyJbBcGrygnfQ6bQ1Ur+q+ur42c4/RNIQhCThu6s3/z2yNRn+22EvNaWh5TFXVzl4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300860; c=relaxed/simple;
	bh=6tz8s6KSLuXt3N3QbyJS0aJQm9pRXVe3ayOMQMf4/zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WA/rgrFv8H+oIvGZfoq05DGQ46saFMkGiB62VFWUVZMSihWbnSgmPRso/ToK0IqcltB/5rZMTAoZzPSGo1qCAIsY0PGgDD8Kidpsevlf5GDwiogF6eZO/mNlq7xmvFyMOOUTsgEwJOP+oEzCshLMLBcmqH4rHpGXKTLs/81Y65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CqgqpMJF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OoU2MWvtIxxk7QL+VprX57oprk9XoTEuLPD7IXER5eU=; b=CqgqpMJFBIp2C7/b/kjVD8rGCx
	zRLp9+KlYyuR0UKHNbJc/EzdBnL+OZVSwxq1/GbP1DhC1nZYfCEB//OJJZJiOLoIh5lV58x1UUktb
	YhDFfIDT7kXXBoLU96Ne7gsSrpJcJrrnzs5hIZkf+JvKRhpnhUA+ioJMLUIPJ83ZmzVekf+huQbU3
	BHSE1AjzxO9nGAcsNQeEV6tnVnc3lRT06nu51xIOURJ7yot/mbMvIk6oPyGFVUu4FlrDIT8C7VK57
	4cMcGbhB0QFSsQSg0H9noBNlM1poj6/be80Tr/FPz5MXcU/IeLBdlkGgy6ifJDTaDXjV7CSUAF3UG
	RVEr61OQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un3w6-00000008tX9-0RNc;
	Fri, 15 Aug 2025 23:34:14 +0000
Date: Sat, 16 Aug 2025 00:34:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@google.com>,
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: [PATCH 1/4] fix the softlockups in attach_recursive_mnt()
Message-ID: <20250815233414.GA2117906@ZenIV>
References: <20250815233316.GS222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815233316.GS222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

In case when we mounting something on top of a large stack of overmounts,
all of them being peers of each other, we get quadratic time by the
depth of overmount stack.  Easily fixed by doing commit_tree() before
reparenting the overmount; simplifies commit_tree() as well - it doesn't
need to skip the already mounted stuff that had been reparented on top
of the new mounts.

Since we are holding mount_lock through both reparenting and call of
commit_tree(), the order does not matter from the mount hash point
of view.

Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Tested-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Fixes: 663206854f02 "copy_tree(): don't link the mounts via mnt_list"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..1c97f93d1865 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1197,10 +1197,7 @@ static void commit_tree(struct mount *mnt)
 
 	if (!mnt_ns_attached(mnt)) {
 		for (struct mount *m = mnt; m; m = next_mnt(m, mnt))
-			if (unlikely(mnt_ns_attached(m)))
-				m = skip_mnt_tree(m);
-			else
-				mnt_add_to_ns(n, m);
+			mnt_add_to_ns(n, m);
 		n->nr_mounts += n->pending_mounts;
 		n->pending_mounts = 0;
 	}
@@ -2704,6 +2701,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			lock_mnt_tree(child);
 		q = __lookup_mnt(&child->mnt_parent->mnt,
 				 child->mnt_mountpoint);
+		commit_tree(child);
 		if (q) {
 			struct mountpoint *mp = root.mp;
 			struct mount *r = child;
@@ -2713,7 +2711,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 				mp = shorter;
 			mnt_change_mountpoint(r, mp, q);
 		}
-		commit_tree(child);
 	}
 	unpin_mountpoint(&root);
 	unlock_mount_hash();
-- 
2.47.2


