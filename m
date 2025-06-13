Return-Path: <linux-fsdevel+bounces-51570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D45AAD843A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1E4189B797
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B157E2DECB2;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="woyCBUL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770B2DFA2F;
	Fri, 13 Jun 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800079; cv=none; b=baCNS7DfC/Tf0BQrZAE8y2Tt6+W/TRMlWljFZoAfhK9EyuBdPEeAvp9h7QpkDq/xTiHpw2GYtee/CEWdV76VCTtwTo3NTJb9aki1UjQiSzThu9FcOp2QOixFcTBDFuhF2HSZugkZCD2qEACDTP7+dQRvtHOo94xWkAdUk3YE3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800079; c=relaxed/simple;
	bh=i1c9negjjog2ObOwuAbSlBkE9d+gtZxNrWV/iUaPuB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MF/kUbmjCARbfI6cQs5NnCtmVjYYGBuMVHBYvWVA9ySSzeeJII1uAeQJd1W0Ru+NSVRTQa6tqbGcDN3wUnSBHiLQpdXEHUPN5duZKbjLpNUK6ffvmaLvjf3TrUdBgmdXXzma1tiM/kPAJGbq6YocTOr28sP4f8sCuvPZJpqJW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=woyCBUL/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JpDo9zqmGYaF7XNm7AWN5s25JP3BqsWROKozDiwZfDM=; b=woyCBUL/waoEc3KQs3uS8J29LJ
	ua8Km2GVVzF7AiTVlEimGUkaAXdrHJ2tzZLJ8sxK1tMKaNbabLFGlhbDtPjc09hr9emRPtNXlfQbR
	1BT5yRcd5V9LOZcxpC8JxWk/+zxIUV3ggubHPVjA7S3IB4Go7CtYP5V49GNMCaljKTv7LjxB7ZQLT
	LGgeC3Z5R0Qnj+Pu1GbB6gDo8Ms7Yp36h4z7f9kf2TN2wSBB9LKCIl8fmNTGvbZQ/+c5IMo+T3QLN
	TjPKW7WWqc+EiwQ0j6+sAvC7txzJHIHUbjfGRUeN3t4dpe0gFDAuwhEa3LcWskIwZJ3D0fMUX+NJe
	n2LG0lQQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvq-00000007qrF-3Rju;
	Fri, 13 Jun 2025 07:34:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 17/17] rpc_create_client_dir(): return 0 or -E...
Date: Fri, 13 Jun 2025 08:34:32 +0100
Message-ID: <20250613073432.1871345-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
References: <20250613073149.GI1647736@ZenIV>
 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Callers couldn't care less which dentry did we get - anything
valid is treated as success.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/sunrpc/rpc_pipe_fs.h |  2 +-
 net/sunrpc/clnt.c                  | 36 ++++++++++++------------------
 net/sunrpc/rpc_pipe.c              | 12 +++++-----
 3 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index 8cc3a5df9801..2cb406f8ff4e 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -98,7 +98,7 @@ static inline bool rpc_msg_is_inflight(const struct rpc_pipe_msg *msg) {
 }
 
 struct rpc_clnt;
-extern struct dentry *rpc_create_client_dir(struct dentry *, const char *, struct rpc_clnt *);
+extern int rpc_create_client_dir(struct dentry *, const char *, struct rpc_clnt *);
 extern int rpc_remove_client_dir(struct rpc_clnt *);
 
 extern void rpc_init_pipe_dir_head(struct rpc_pipe_dir_head *pdh);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 21426c3049d3..8ca354ecfd02 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -112,47 +112,46 @@ static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 	}
 }
 
-static struct dentry *rpc_setup_pipedir_sb(struct super_block *sb,
+static int rpc_setup_pipedir_sb(struct super_block *sb,
 				    struct rpc_clnt *clnt)
 {
 	static uint32_t clntid;
 	const char *dir_name = clnt->cl_program->pipe_dir_name;
 	char name[15];
-	struct dentry *dir, *dentry;
+	struct dentry *dir;
+	int err;
 
 	dir = rpc_d_lookup_sb(sb, dir_name);
 	if (dir == NULL) {
 		pr_info("RPC: pipefs directory doesn't exist: %s\n", dir_name);
-		return dir;
+		return -ENOENT;
 	}
 	for (;;) {
 		snprintf(name, sizeof(name), "clnt%x", (unsigned int)clntid++);
 		name[sizeof(name) - 1] = '\0';
-		dentry = rpc_create_client_dir(dir, name, clnt);
-		if (!IS_ERR(dentry))
+		err = rpc_create_client_dir(dir, name, clnt);
+		if (!err)
 			break;
-		if (dentry == ERR_PTR(-EEXIST))
+		if (err == -EEXIST)
 			continue;
 		printk(KERN_INFO "RPC: Couldn't create pipefs entry"
-				" %s/%s, error %ld\n",
-				dir_name, name, PTR_ERR(dentry));
+				" %s/%s, error %d\n",
+				dir_name, name, err);
 		break;
 	}
 	dput(dir);
-	return dentry;
+	return err;
 }
 
 static int
 rpc_setup_pipedir(struct super_block *pipefs_sb, struct rpc_clnt *clnt)
 {
-	struct dentry *dentry;
-
 	clnt->pipefs_sb = pipefs_sb;
 
 	if (clnt->cl_program->pipe_dir_name != NULL) {
-		dentry = rpc_setup_pipedir_sb(pipefs_sb, clnt);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
+		int err = rpc_setup_pipedir_sb(pipefs_sb, clnt);
+		if (err && err != -ENOENT)
+			return err;
 	}
 	return 0;
 }
@@ -180,16 +179,9 @@ static int rpc_clnt_skip_event(struct rpc_clnt *clnt, unsigned long event)
 static int __rpc_clnt_handle_event(struct rpc_clnt *clnt, unsigned long event,
 				   struct super_block *sb)
 {
-	struct dentry *dentry;
-
 	switch (event) {
 	case RPC_PIPEFS_MOUNT:
-		dentry = rpc_setup_pipedir_sb(sb, clnt);
-		if (!dentry)
-			return -ENOENT;
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
-		break;
+		return rpc_setup_pipedir_sb(sb, clnt);
 	case RPC_PIPEFS_UMOUNT:
 		__rpc_clnt_remove_pipedir(clnt);
 		break;
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index e4b53530eb1b..a12ec709c445 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -863,27 +863,27 @@ rpc_destroy_pipe_dir_objects(struct rpc_pipe_dir_head *pdh)
  * information about the client, together with any "pipes" that may
  * later be created using rpc_mkpipe().
  */
-struct dentry *rpc_create_client_dir(struct dentry *dentry,
-				   const char *name,
-				   struct rpc_clnt *rpc_client)
+int rpc_create_client_dir(struct dentry *dentry,
+			   const char *name,
+			   struct rpc_clnt *rpc_client)
 {
 	struct dentry *ret;
 	int err;
 
 	ret = rpc_new_dir(dentry, name, 0555);
 	if (IS_ERR(ret))
-		return ret;
+		return PTR_ERR(ret);
 	err = rpc_new_file(ret, "info", S_IFREG | 0400,
 			      &rpc_info_operations, rpc_client);
 	if (err) {
 		pr_warn("%s failed to populate directory %pd\n",
 				__func__, ret);
 		simple_recursive_removal(ret, NULL);
-		return ERR_PTR(err);
+		return err;
 	}
 	rpc_client->cl_pipedir_objects.pdh_dentry = ret;
 	rpc_create_pipe_dir_objects(&rpc_client->cl_pipedir_objects);
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.39.5


