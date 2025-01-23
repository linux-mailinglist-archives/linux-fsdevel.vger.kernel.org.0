Return-Path: <linux-fsdevel+bounces-39914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48CA19C7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B9C3ADB39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD315746F;
	Thu, 23 Jan 2025 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N+jEqESd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAC1F5F6;
	Thu, 23 Jan 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596809; cv=none; b=dqda7gv4QSRggLKHO2gH7u1lsg5uVlrDfJPx2FPy+0BQ98iUnLl5bBG8WNkjiVzlIBblj9Bxs7scf9Rg6ZJmCM/6VCfKY2P860HmmkhuzXhYiCXyrMyO5lZGamhDimG0UthtiQK83+ynT27xw95BX/6ua4sVewgb616mQsWeJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596809; c=relaxed/simple;
	bh=FOWyASKlDeQ25FCHrKulnZho+7EMmjSH5VzxVdKEtuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY/yB8QxaoUpD5dCUhSYvsSfmRxIiXfKgqaeOxY0U46XtdkbsgEltf86kvhdGzh6yKB93rSW9JKDJWAeR8XWl1myi7Vd3vmMIwFrQ3OFPFNCOWFY8J1eeQLcg0Ncs1aRtCLQMnhfYIiE/Zv4THj+wkQWn7oxQK0bw6KK7LY48YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=N+jEqESd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Px7n9/8ruWBDxweNxfqhKb97oBOawSKfHkYfEcvqVmI=; b=N+jEqESdzCiIcfDVY9GcfHf9bG
	jN23kGgYVr9ebHV2ZUORJjsfUzY2q1deBdjo6gNjKlgLbucbrrDRBJbuekShPSy1PvPltY2TV8sSa
	LfWtxJQHNBaSoQ0ZJU18fSD8gYlOzckvpBnGaZfQO52ZxHIjNGPuUGCxZ/h6XquvHuwlO+cpIhuaH
	bnpTOHRng53+uJhC/oPE/4PX+ZA7CGuaRJmSD0HjjLog9PBIEBoBaJCiZBKqHsKDa739FWVmHeBq9
	sB2WxQ/uvHR9ZwQOwpS7/xwZWLUQNA6h0fcfUQFQkKcYaJWXD5tjx92xn+Xzsr8pwR1VAXajshb5h
	HDNrjOVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIv-00000008F36-0gE2;
	Thu, 23 Jan 2025 01:46:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v3 14/20] fuse_dentry_revalidate(): use stable parent inode and name passed by caller
Date: Thu, 23 Jan 2025 01:46:37 +0000
Message-ID: <20250123014643.1964371-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
References: <20250123014511.GA1962481@ZenIV>
 <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

No need to mess with dget_parent() for the former; for the latter we really should
not rely upon ->d_name.name remaining stable - it's a real-life UAF.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/dir.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d9e9f26917eb..3019bc1d9f9d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -175,9 +175,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	memset(outarg, 0, sizeof(struct fuse_entry_out));
 	args->opcode = FUSE_LOOKUP;
 	args->nodeid = nodeid;
-	args->in_numargs = 1;
-	args->in_args[0].size = name->len + 1;
+	args->in_numargs = 2;
+	args->in_args[0].size = name->len;
 	args->in_args[0].value = name->name;
+	args->in_args[1].size = 1;
+	args->in_args[1].value = "";
 	args->out_numargs = 1;
 	args->out_args[0].size = sizeof(struct fuse_entry_out);
 	args->out_args[0].value = outarg;
@@ -196,7 +198,6 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 				  struct dentry *entry, unsigned int flags)
 {
 	struct inode *inode;
-	struct dentry *parent;
 	struct fuse_mount *fm;
 	struct fuse_inode *fi;
 	int ret;
@@ -228,11 +229,9 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 
 		attr_version = fuse_get_attr_version(fm->fc);
 
-		parent = dget_parent(entry);
-		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
-				 &entry->d_name, &outarg);
+		fuse_lookup_init(fm->fc, &args, get_node_id(dir),
+				 name, &outarg);
 		ret = fuse_simple_request(fm, &args);
-		dput(parent);
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
 			ret = -ENOENT;
@@ -266,9 +265,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 			if (test_bit(FUSE_I_INIT_RDPLUS, &fi->state))
 				return -ECHILD;
 		} else if (test_and_clear_bit(FUSE_I_INIT_RDPLUS, &fi->state)) {
-			parent = dget_parent(entry);
-			fuse_advise_use_readdirplus(d_inode(parent));
-			dput(parent);
+			fuse_advise_use_readdirplus(dir);
 		}
 	}
 	ret = 1;
-- 
2.39.5


