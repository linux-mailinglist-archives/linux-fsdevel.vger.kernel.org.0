Return-Path: <linux-fsdevel+bounces-10210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712C5848A9D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A5287AF6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7508111701;
	Sun,  4 Feb 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nEh+Ap5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E37491;
	Sun,  4 Feb 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013065; cv=none; b=jMYy2hl+3uZdOuwvF69f1Jm+2xZj2pEruRZFW/SdBUZxcc8iNlH8tIspLHT5oegwxwLK7LONgL5qi0sV4mDd6ROFhWKk0UB4SkAR6b/EEdR6x5RTMmGX53GDYsKS4jjGf6cnmA9QQhPD9dKpcsAKWNJvT8JOaAhEJGlWJ072o1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013065; c=relaxed/simple;
	bh=f7WEO3vbtoP9xl5yKOL2rLQXCDxPEAWsYtSBPxBzmF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhw0H2n78TqGLB/fBUN03sKVM7fWJ4umDjdyu2T1z4mUc2dbS5JPRTEw3mbn5f4L4+w2s6th3E0siYPJlM6tKh0z55kNR3IKx6qOrNrbNOCu4Q+sY4Jtfc9Ixn6JHniuOySxLrbu0x0DcrFDtRaB9PpbQ+cPsfJxlaWNGHusm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nEh+Ap5r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JeJspV0xyM95jRaGyJ36cYe2kvImon+4d20qpFr9x+A=; b=nEh+Ap5rp0DyclGgaHmmPb4tpl
	fYMd75Kdb5+ly9NAyH0EIZei/nUWPlhEb40rTLYJXdvEpbU8anWIM76zFjhV9pA0RoWDvAsvcFc1+
	RDPHGcXPeiIECmX8iw5k6jcvsWTx4zCfKY2yKHfDSHKQdGtVw1YF3CHTjR5MKwyImrULNq1ncM1rF
	on5cBOXR4VmxJ0MapNHfUuC+518+Bvkla/luqlMd/QB3xxNPZMkcqgs7LANUZ6AT9J/1Y7gw5C81d
	Db/DQjvNN0U4GKvYJ6Hu7K86zY9KeISiyc82CJdRFCMLn74Ui95sVtAp8q/IXKNPBoj6qeNaPMYCw
	pONA1S5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4j-004rDS-1B;
	Sun, 04 Feb 2024 02:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 09/13] procfs: move dropping pde and pid from ->evict_inode() to ->free_inode()
Date: Sun,  4 Feb 2024 02:17:35 +0000
Message-Id: <20240204021739.1157830-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

that keeps both around until struct inode is freed, making access
to them safe from rcu-pathwalk

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/base.c  |  2 --
 fs/proc/inode.c | 19 ++++++++-----------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 98a031ac2648..18550c071d71 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1878,8 +1878,6 @@ void proc_pid_evict_inode(struct proc_inode *ei)
 		hlist_del_init_rcu(&ei->sibling_inodes);
 		spin_unlock(&pid->lock);
 	}
-
-	put_pid(pid);
 }
 
 struct inode *proc_pid_make_inode(struct super_block *sb,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index b33e490e3fd9..05350f3c2812 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -30,7 +30,6 @@
 
 static void proc_evict_inode(struct inode *inode)
 {
-	struct proc_dir_entry *de;
 	struct ctl_table_header *head;
 	struct proc_inode *ei = PROC_I(inode);
 
@@ -38,17 +37,8 @@ static void proc_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	/* Stop tracking associated processes */
-	if (ei->pid) {
+	if (ei->pid)
 		proc_pid_evict_inode(ei);
-		ei->pid = NULL;
-	}
-
-	/* Let go of any associated proc directory entry */
-	de = ei->pde;
-	if (de) {
-		pde_put(de);
-		ei->pde = NULL;
-	}
 
 	head = ei->sysctl;
 	if (head) {
@@ -80,6 +70,13 @@ static struct inode *proc_alloc_inode(struct super_block *sb)
 
 static void proc_free_inode(struct inode *inode)
 {
+	struct proc_inode *ei = PROC_I(inode);
+
+	if (ei->pid)
+		put_pid(ei->pid);
+	/* Let go of any associated proc directory entry */
+	if (ei->pde)
+		pde_put(ei->pde);
 	kmem_cache_free(proc_inode_cachep, PROC_I(inode));
 }
 
-- 
2.39.2


