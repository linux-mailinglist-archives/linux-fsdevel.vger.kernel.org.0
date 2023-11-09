Return-Path: <linux-fsdevel+bounces-2482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D067E63BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3077B20DE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4410975;
	Thu,  9 Nov 2023 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KohcKxnM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62CCF9CA
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:03 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E012F26BB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PInzk+mI0vspPJDyiH3pEq66fnzbTjLEhHK7jQVOhfM=; b=KohcKxnMdW2h0GwnluNiLCtUb+
	0anTr4wcBDc4TXoZJ4By+9fXLxDEukQKSaQue6yIiqCWeYlum9Solw3T3Nlwu0LGJHvNvt8ufigFH
	6UVLR12AvIlm7Zd8RwdfJoYG62PGunnovWQL+SsBByXq3GHRiroxUa1GolL4mtWnwWwMgP90jA+BR
	ouYSMr1Az9MWFSd8AaKsZHPwUfp5KubixxXAGR+7igs2frR92coBkF8stqF7QIvoZZOqkMNyrLziF
	+XwTaaaJ0zUowB09W+fLZFLiEzLQJJZ8jZ7LF3D3eQ+pe/SnsBf0apuv/ZEi7PwmuiIhl4yhIKfWl
	zkDZxXSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPS-00DLkE-1P;
	Thu, 09 Nov 2023 06:20:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 14/22] dentry_kill(): don't bother with retain_dentry() on slow path
Date: Thu,  9 Nov 2023 06:20:48 +0000
Message-Id: <20231109062056.3181775-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We have already checked it and dentry used to look not worthy
of keeping.  The only hard obstacle to evicting dentry is
non-zero refcount; everything else is advisory - e.g. memory
pressure could evict any dentry found with refcount zero.
On the slow path in dentry_kill() we had dropped and regained
->d_lock; we must recheck the refcount, but everything else
is not worth bothering with.

Note that filesystem can not count upon ->d_delete() being
called for dentry - not even once.  Again, memory pressure
(as well as d_prune_aliases(), or attempted rmdir() of ancestor,
or...) will not call ->d_delete() at all.

So from the correctness point of view we are fine doing the
check only once.  And it makes things simpler down the road.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index d9466cab4884..916b978bfd98 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -739,14 +739,10 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	spin_lock(&dentry->d_lock);
 	parent = lock_parent(dentry);
 got_locks:
-	if (unlikely(dentry->d_lockref.count != 1)) {
-		dentry->d_lockref.count--;
-	} else if (likely(!retain_dentry(dentry))) {
-		dentry->d_lockref.count--;
+	dentry->d_lockref.count--;
+	if (likely(dentry->d_lockref.count == 0)) {
 		__dentry_kill(dentry);
 		return parent;
-	} else {
-		dentry->d_lockref.count--;
 	}
 	/* we are keeping it, after all */
 	if (inode)
-- 
2.39.2


