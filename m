Return-Path: <linux-fsdevel+bounces-10201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5A848A81
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEAEB24C1C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184EF8C1B;
	Sun,  4 Feb 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TlrDjk3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71977493;
	Sun,  4 Feb 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013064; cv=none; b=cTN3/BZ3Pl1Ao/qEDjDH4UBb7kWA/aFqFUZrYyZ3/UIe7qSKJpKVpLDIc+gz7FLIjcLq4F9nBb5oSqty+xRoVlku1SC2Ha/p3nevaW6/UK1O34j86j5XneCCnl+y1BuURwGroNZa+elNV8SD+1zAmulvJK+JXzzKvvo7iTNsCOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013064; c=relaxed/simple;
	bh=zYRFksJtbabvYcgsGO42pYWYQgwk2Gd62aTtBhPPs+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NS9U/2iTXFMxkmx3AbZBLCOh3lVGXC37JFEl4TSeWQ/oY4y1MVDv4l/PZhqTO7E40R7oUBT3ZrB61ck7WN00gBVEJruCSUip9fgo3oyYLIkPMeChUSQ4LlOpShoOparZuF0DOmCrSSB0+MOE4LidlgQhMrF3zJ4CB+Y+lefCWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TlrDjk3i; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hytpd6GUU8CfpGv7IEW9Pto33UoqqEf/lpKO/D7NPpA=; b=TlrDjk3io75QzP8iHfhoV/0Bna
	Uzb/gG6phRhbFCtrWMkk3GU49NqZTLEhhYUulAmuZwnsRab+gRCNXTmJGfmgLf8LWAiIbjnw1NU+R
	UvR738PhELzuQ4P78XLvQsuZcP2pkmotJEmPW1pvwY80SZIJpgKlR3fRPNFO+OGQgYJ3e8sMW6Qvr
	z/Dz/kqQ8xk6diRVanMZ1UUItKLlSccCHwPhGwcuO2ZEMPFRdKssA9C1gCOZIwR1u90BzAMr3X8sA
	A8kP9hr/+2wgV4iLVO6aFY5cH2by20WZrMMMrr1IdWxESkqndCKUIyIGDX0RWhncGodc9aDw9vcMj
	5A8AFptw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4j-004rDK-0V;
	Sun, 04 Feb 2024 02:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 08/13] nfs: fix UAF on pathwalk running into umount
Date: Sun,  4 Feb 2024 02:17:34 +0000
Message-Id: <20240204021739.1157830-8-viro@zeniv.linux.org.uk>
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

NFS ->d_revalidate(), ->permission() and ->get_link() need to access
some parts of nfs_server when called in RCU mode:
	server->flags
	server->caps
	*(server->io_stats)
and, worst of all, call
	server->nfs_client->rpc_ops->have_delegation
(the last one - as NFS_PROTO(inode)->have_delegation()).  We really
don't want to RCU-delay the entire nfs_free_server() (it would have
to be done with schedule_work() from RCU callback, since it can't
be made to run from interrupt context), but actual freeing of
nfs_server and ->io_stats can be done via call_rcu() just fine.
nfs_client part is handled simply by making nfs_free_client() use
kfree_rcu().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/client.c           | 13 ++++++++++---
 include/linux/nfs_fs_sb.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 44eca51b2808..fbdc9ca80f71 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -246,7 +246,7 @@ void nfs_free_client(struct nfs_client *clp)
 	put_nfs_version(clp->cl_nfs_mod);
 	kfree(clp->cl_hostname);
 	kfree(clp->cl_acceptor);
-	kfree(clp);
+	kfree_rcu(clp, rcu);
 }
 EXPORT_SYMBOL_GPL(nfs_free_client);
 
@@ -1006,6 +1006,14 @@ struct nfs_server *nfs_alloc_server(void)
 }
 EXPORT_SYMBOL_GPL(nfs_alloc_server);
 
+static void delayed_free(struct rcu_head *p)
+{
+	struct nfs_server *server = container_of(p, struct nfs_server, rcu);
+
+	nfs_free_iostats(server->io_stats);
+	kfree(server);
+}
+
 /*
  * Free up a server record
  */
@@ -1031,10 +1039,9 @@ void nfs_free_server(struct nfs_server *server)
 
 	ida_destroy(&server->lockowner_id);
 	ida_destroy(&server->openowner_id);
-	nfs_free_iostats(server->io_stats);
 	put_cred(server->cred);
-	kfree(server);
 	nfs_release_automount_timer();
+	call_rcu(&server->rcu, delayed_free);
 }
 EXPORT_SYMBOL_GPL(nfs_free_server);
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index cd797e00fe35..92de074e63b9 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -124,6 +124,7 @@ struct nfs_client {
 	char			cl_ipaddr[48];
 	struct net		*cl_net;
 	struct list_head	pending_cb_stateids;
+	struct rcu_head		rcu;
 };
 
 /*
@@ -265,6 +266,7 @@ struct nfs_server {
 	const struct cred	*cred;
 	bool			has_sec_mnt_opts;
 	struct kobject		kobj;
+	struct rcu_head		rcu;
 };
 
 /* Server capabilities */
-- 
2.39.2


