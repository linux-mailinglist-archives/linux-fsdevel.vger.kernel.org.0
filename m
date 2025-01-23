Return-Path: <linux-fsdevel+bounces-39907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A32A19C6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306947A5A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AED146590;
	Thu, 23 Jan 2025 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t9ETNA/I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52889F9D9;
	Thu, 23 Jan 2025 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596807; cv=none; b=NdqqjzMkSOeFrEMVBOMELyi4hhAbjNg7YZYLikkIQCfCkY6TcfnBqCbBv2Q/Ua0mrXq2jD5b+zzltvEMWt6Ntxsf+qj6m31F0UK0Y6cGrrOeIHyOWKs5nVPm05/ODfOeAWJk7CJ8g22pdfxbsj9VMXBoj3ugY7iEcA5sCkt1Onc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596807; c=relaxed/simple;
	bh=fM8WLHNlALR/LLdSBJHnn04WHFTQgxgtPk6755PDSuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btUd0H3QNrwfoYOBuXoD9zMmqmfie9zA0b+MJvkeCkj0Ua3KT3V7bEqeD5pwYsk9kdi8osjH/CneLho7H1Aew18N/uoZTVX9YyP9V54WstGmq+SSCzOswBTEb+l90UwS7P7fcYJ3iIPf4fP8V1k3e+gljDr5X7P1I7Cg16DDgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t9ETNA/I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VsC8I1IRaODOdgwfZbw41czkSHJDCJwIYNglUO5FxZU=; b=t9ETNA/IuDkIlB46Ncy2rNi3IM
	Bg6r6QeZRdUN4DLX9ob97PmuGhrKyiGLUQVhRVhBQjoOSt/NgTHTtLgJrevvt5ZCZStZXp9C6FChX
	aqNMPj99wZMusRSvV6UI72J6bUfGB/mVc2ZupNEpr9ose2QS2gqd3mToLABfJENyHKo8C5m9vrRYU
	01+QhbfPI6WNYgzgA9PHb7zwdPIc0o+kZrM8qqmxEHmQjsukYz4nF50jk4N8+tbfe7D2TLgtJfFrs
	UL8tIg52zJh8zXTzBZ0IgsYtIrHtW+Ki8NdadVKJm21xZZTuqQ8aMdeHq6g25nDPhwxpaLDQLesPB
	Z/uS0GZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIt-00000008F1k-370O;
	Thu, 23 Jan 2025 01:46:43 +0000
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
Subject: [PATCH v3 04/20] dissolve external_name.u into separate members
Date: Thu, 23 Jan 2025 01:46:27 +0000
Message-ID: <20250123014643.1964371-4-viro@zeniv.linux.org.uk>
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

kept separate from the previous commit to keep the noise separate
from actual changes...

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f387dc97df86..6f36d3e8c739 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -296,10 +296,8 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 }
 
 struct external_name {
-	struct {
-		atomic_t count;		// ->count and ->head can't be combined
-		struct rcu_head head;	// see take_dentry_name_snapshot()
-	} u;
+	struct rcu_head head;	// ->head and ->count can't be combined
+	atomic_t count;		// see take_dentry_name_snapshot()
 	unsigned char name[];
 };
 
@@ -344,7 +342,7 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
 		struct external_name *p;
 		p = container_of(s, struct external_name, name[0]);
 		// get a valid reference
-		if (unlikely(!atomic_inc_not_zero(&p->u.count)))
+		if (unlikely(!atomic_inc_not_zero(&p->count)))
 			goto retry;
 		name->name.name = s;
 	}
@@ -361,8 +359,8 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
 	if (unlikely(name->name.name != name->inline_name.string)) {
 		struct external_name *p;
 		p = container_of(name->name.name, struct external_name, name[0]);
-		if (unlikely(atomic_dec_and_test(&p->u.count)))
-			kfree_rcu(p, u.head);
+		if (unlikely(atomic_dec_and_test(&p->count)))
+			kfree_rcu(p, head);
 	}
 }
 EXPORT_SYMBOL(release_dentry_name_snapshot);
@@ -400,7 +398,7 @@ static void dentry_free(struct dentry *dentry)
 	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
-		if (likely(atomic_dec_and_test(&p->u.count))) {
+		if (likely(atomic_dec_and_test(&p->count))) {
 			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
 			return;
 		}
@@ -1681,7 +1679,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
 		}
-		atomic_set(&p->u.count, 1);
+		atomic_set(&p->count, 1);
 		dname = p->name;
 	} else  {
 		dname = dentry->d_shortname.string;
@@ -2774,15 +2772,15 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 	if (unlikely(dname_external(dentry)))
 		old_name = external_name(dentry);
 	if (unlikely(dname_external(target))) {
-		atomic_inc(&external_name(target)->u.count);
+		atomic_inc(&external_name(target)->count);
 		dentry->d_name = target->d_name;
 	} else {
 		dentry->d_shortname = target->d_shortname;
 		dentry->d_name.name = dentry->d_shortname.string;
 		dentry->d_name.hash_len = target->d_name.hash_len;
 	}
-	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
-		kfree_rcu(old_name, u.head);
+	if (old_name && likely(atomic_dec_and_test(&old_name->count)))
+		kfree_rcu(old_name, head);
 }
 
 /*
-- 
2.39.5


