Return-Path: <linux-fsdevel+bounces-42520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E5A42EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039293A7914
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D71EEA29;
	Mon, 24 Feb 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I7K6wl5s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2561D86E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432057; cv=none; b=hgeUbjJYDorV4b25xyzaAPTkHbL9b5I5twuPgkOpMqZ1Nb5zkttlemucFRYrLP9mkFXvb2K/h3TvQu8/uLi8IdW8why8wpa6A9zUqJCW/+sxJn08HlFGIxdQURjfeBlVezUB55IWoYIwKZXipmpl4ijjlqga3dveSyttsEOmMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432057; c=relaxed/simple;
	bh=RYmn5R972EMoW46FoCrbjfqIQ2d6weOOnxiTtGpUrjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oqin1nvqM8gs5oenOpryeetwBThkxFY7PW7y4fBhLsYyVdp1a5YJMdNXsghdZ5aztwEy2kcz4zXAYQPb66xZjo/uVg9RSA7kADndUeb34itPPs6sinfZBGj/gVxf/z6QNmDSXANC1o+AKbDmiFjATikH0TIAU5gFK/rW6l4zrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I7K6wl5s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dEwkjcQG/jmQpvWMbyrZsz6eAoqgmglkp0CU+P/pvLg=; b=I7K6wl5sXuqW8GGSg3njyN4GNA
	rIx8iFHv8gP1MFreDv0rcXYxrVBpIFzdzgSGqwJM2llDnM54hBbM2rQrINDFS8SF36OiI7QPIOrPf
	77tkUBOKf5dxywpUYEsjPuhvlYKG9wH5+DZNCv8sNc58uLnmwxS4CdOKodEspZM2QZSeZUdL/RSJr
	SntwvU23ruJYw2QeEXeXvrnvRn8dtWjzeBO3qrTSvY+JVaSlUIEXle4ex/tRSqYNtCUdlzNoOQweT
	hk7uoyos/Ep4XpNTai2NZ1xKMQx58DtJt/646K5CmbJPBcu9S0Z7C0Bwv2uY3lbHLPt7SHr/Uc9a8
	FuZklaXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsh-00000007Mx2-3tKN;
	Mon, 24 Feb 2025 21:20:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 01/21] procfs: kill ->proc_dops
Date: Mon, 24 Feb 2025 21:20:31 +0000
Message-ID: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224141444.GX1977892@ZenIV>
References: <20250224141444.GX1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It has two possible values - one for "forced lookup" entries, another
for the normal ones.  We'd be better off with that as an explicit
flag anyway and in addition to that it opens some fun possibilities
with ->d_op and ->d_flags handling.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/generic.c  | 8 +++++---
 fs/proc/internal.h | 5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 8ec90826a49e..499c2bf67488 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -254,7 +254,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
-		d_set_d_op(dentry, de->proc_dops);
+		if (de->flags & PROC_ENTRY_FORCE_LOOKUP)
+			d_set_d_op(dentry, &proc_net_dentry_ops);
+		else
+			d_set_d_op(dentry, &proc_misc_dentry_ops);
 		return d_splice_alias(inode, dentry);
 	}
 	read_unlock(&proc_subdir_lock);
@@ -448,9 +451,8 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	INIT_LIST_HEAD(&ent->pde_openers);
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
 
-	ent->proc_dops = &proc_misc_dentry_ops;
 	/* Revalidate everything under /proc/${pid}/net */
-	if ((*parent)->proc_dops == &proc_net_dentry_ops)
+	if ((*parent)->flags & PROC_ENTRY_FORCE_LOOKUP)
 		pde_force_lookup(ent);
 
 out:
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 1695509370b8..07f75c959173 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -44,7 +44,6 @@ struct proc_dir_entry {
 		const struct proc_ops *proc_ops;
 		const struct file_operations *proc_dir_ops;
 	};
-	const struct dentry_operations *proc_dops;
 	union {
 		const struct seq_operations *seq_ops;
 		int (*single_show)(struct seq_file *, void *);
@@ -67,6 +66,8 @@ struct proc_dir_entry {
 	char inline_name[];
 } __randomize_layout;
 
+#define PROC_ENTRY_FORCE_LOOKUP 2 /* same space as PROC_ENTRY_PERMANENT */
+
 #define SIZEOF_PDE	(				\
 	sizeof(struct proc_dir_entry) < 128 ? 128 :	\
 	sizeof(struct proc_dir_entry) < 192 ? 192 :	\
@@ -346,7 +347,7 @@ extern const struct dentry_operations proc_net_dentry_ops;
 static inline void pde_force_lookup(struct proc_dir_entry *pde)
 {
 	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
-	pde->proc_dops = &proc_net_dentry_ops;
+	pde->flags |= PROC_ENTRY_FORCE_LOOKUP;
 }
 
 /*
-- 
2.39.5


