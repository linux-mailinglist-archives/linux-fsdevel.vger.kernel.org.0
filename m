Return-Path: <linux-fsdevel+bounces-62687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B321B9D01A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 03:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79D41BC33A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 01:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858E2D24B3;
	Thu, 25 Sep 2025 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OtNbvNWB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYVnWK/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040B52F84F;
	Thu, 25 Sep 2025 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763331; cv=none; b=ZXH/ro4HNrgHImxghjxq6hx4vQVx3K/XeVCngVKFmy0HVx82PtyDViR/IiXA+6cSPoxzcpffkmzlU5KbTrfDNO2k4Q67gxzti89lFnHIXx5w2HM3zzHv6g1ZNfNvZOE0xvsPWmh58oKEoXpmk0eUqmLjbUS4JzNPxwiOpjfBgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763331; c=relaxed/simple;
	bh=5yrzqovVOMssdNLnE/NkjLfqD75grgdNCXGjXDE2WBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udoMJdUmB1u4WGLRQD//mJGD51G6o8n1P+Ctw6iDKhV7cRW6luB3IMQZFN4i5eGX62ygh3VmINV/0ixS4pluB9n+P1iHPO6vvDBQwDQOfiEYWuiOO9uJSPiRrgaT20SrRFdT7iEa0XzaEeRj1/11ErnArH82bBNmoopVg2ZYNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OtNbvNWB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYVnWK/2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F127EC01E2;
	Wed, 24 Sep 2025 21:22:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 24 Sep 2025 21:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758763328;
	 x=1758849728; bh=FdX0lMx9lyRpUor4JBziUvIDuLJSIiqTw5GNvaWwWwE=; b=
	OtNbvNWBhTNfivfu8lVj8ltq91mpWd7EKde/wi/TApw5Li3jGLNHCugc0UuoQqSH
	QtgvXozoLbtofh57DBV/jcS5pzawNw/aUF9pOmSlb1XqvZc0pEP8qLyYR2AkYUan
	irWoJ6wUPJYCCz3D2DYQ8xRoEPwcxXMCcF/zn8P8Laj/TUCvE/4/W2/ty3gEnIBN
	SNPbhpFWSNZ1BxhGIXJH6uxvOqsNcte8C2AFIHyFTfxTNyoZG5ll2rX1ZXH3n+Yb
	56Bb3iNGYaRsmfdUNBcOYR2Qg2+BHtcbfNJE7kEgtIrbYz15VUD4R/hx9IIVKTR7
	QA7urYjZzz6xftjHdEBzGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758763328; x=1758849728; bh=F
	dX0lMx9lyRpUor4JBziUvIDuLJSIiqTw5GNvaWwWwE=; b=mYVnWK/2TltsctQ8F
	XqkwkifLbLeEd8QPW7ZHAbEx01teqCyYGS3ku4sVmN5+bW+OxnIlIIlLwtmhf03c
	OZ7eOI552BAAz/+DmrfekDJLeCuM5EYop73cPXLkymIJkzooyqd0QGyLXo82ZSOG
	gDDGBhxuI2FXftA/w27anLMVe0hXnAjj03X3Kh3pFCA3iOFu8wd4ZotXdB4fPRUC
	oFsHBJ1b9HKmwqtCJu6WLniuzKPK/n4HZaHaTtpvWeWHdO1O89LtjJjncCr3dW3G
	fjIpHy0FUZd4C55WR4RS8F5o1N3RyK3XKTLY0jfz6JBPlEUAOMiuRJEh4HCCtPk3
	E686A==
X-ME-Sender: <xms:P5nUaCvBCJzIP3eUXT2fGl-Kze_H5ZC-UcPOgaFTM6GZQPcMwkJlMw>
    <xme:P5nUaGjcUznj3LrvdGOfnHQd8uADaJ2IHeEQ74kMzV2p55bmUAGT5H6xW_c2DETPH
    H6n99PzRZll03aAl-2D6yKccw69BLNHoCtrTTIK1k54ga1S>
X-ME-Received: <xmr:P5nUaD8GJ7SLHjNE5xiIy_3sMTt-PsI9IMQDJ1K8GWoiAe0Ru54aEHA7RYFVJrh7yiQc07XzSipUbgWdGMV6Tl45CwSo9eUK4csCaMiwkm9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhrohhnughmhieskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:P5nUaJtgN52fQ70tU5vuPaby3JLWIvFeVKkQkbKT8gnmOg83TVauLA>
    <xmx:P5nUaHrygVIACMejUp1vvoN60XKv84N-nW1EpK2lJrAsxBK7Xj5WpA>
    <xmx:P5nUaNrXXRYaJVVeMP8Z7BF8e3Ol1K9ew7dCCi3KbUvpnjbY0FGiPA>
    <xmx:P5nUaGYUnmHjQAKAkvn_VApK4hmSGDMoT6Jg9AbxfRKAUAmx79J1kQ>
    <xmx:QJnUaGDmKOv0xMApQ6QsGisHKFpH7MSRmZl-j5oi1HXPINdPgnpRi-2U>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 21:22:05 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFS: remove d_drop()/d_alloc_parallel() from nfs_atomic_open()
Date: Thu, 25 Sep 2025 11:17:52 +1000
Message-ID: <20250925012129.1340971-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250925012129.1340971-1-neilb@ownmail.net>
References: <20250925012129.1340971-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

It is important that two non-create NFS "open"s of a negative dentry
don't race.  They both have a shared lock on i_rwsem and so could run
concurrently, but they might both try to call d_exact_alias() or
d_splice_alias() at the same time which is confusing at best.

nfs_atomic_open() currently avoids this by discarding the negative
dentry and creating a new one with d_alloc_parallel().  Only one thread
can successfully get the d_in_lookup() dentry, the other will wait for
the first to finish, and can use the result of that first lookup.

Dropping the dentry like this will defeat a proposed new locking scheme
which locks the dentry and requires it to remain hashed.  Calling
d_alloc_parallel() here when the parent is locked interferes with
proposed changes to invert the lock ordering between the parent inode
and DCACHE_PAR_LOOKUP on a child.

We can achieve the same effect by causing ->d_revalidate to invalidate a
negative dentry when LOOKUP_OPEN is set.  Doing this is consistent with
the "close to open" caching semantics of NFS which requires the server
to be queried whenever opening a file - cached information must not be
trusted.

With this change to ->d_revaliate (implemented in nfs_neg_need_reval) we
can be sure that we have exclusive access to any dentry that reaches
nfs_atomic_open().  Either O_CREAT was requested and so the parent is
locked exclusively, or the dentry will have DCACHE_PAR_LOOKUP set.

This means that the d_drop() and d_alloc_parallel() calls in
nfs_atomic_lookup() are no longer needed to provide exclusion

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5f7d9be6f022..c7c746ae377c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1615,6 +1615,13 @@ int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 {
 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
 		return 0;
+	if (flags & LOOKUP_OPEN)
+		/* close-to-open semantics require we go to server
+		 * on each open.  By invalidating the dentry we
+		 * also ensure nfs_atomic_open() always has exclusive
+		 * access to the dentry.
+		 */
+		return 0;
 	if (NFS_SERVER(dir)->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG)
 		return 1;
 	/* Case insensitive server? Revalidate negative dentries */
@@ -2060,14 +2067,12 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
 	struct inode *inode;
 	unsigned int lookup_flags = 0;
 	unsigned long dir_verifier;
-	bool switched = false;
 	int created = 0;
 	int err;
 
@@ -2112,17 +2117,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		attr.ia_size = 0;
 	}
 
-	if (!(open_flags & O_CREAT) && !d_in_lookup(dentry)) {
-		d_drop(dentry);
-		switched = true;
-		dentry = d_alloc_parallel(dentry->d_parent,
-					  &dentry->d_name, &wq);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
-		if (unlikely(!d_in_lookup(dentry)))
-			return finish_no_open(file, dentry);
-	}
-
 	ctx = create_nfs_open_context(dentry, open_flags, file);
 	err = PTR_ERR(ctx);
 	if (IS_ERR(ctx))
@@ -2165,10 +2159,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 	put_nfs_open_context(ctx);
 out:
-	if (unlikely(switched)) {
-		d_lookup_done(dentry);
-		dput(dentry);
-	}
 	return err;
 
 no_open:
@@ -2191,13 +2181,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			res = ERR_PTR(-EOPENSTALE);
 		}
 	}
-	if (switched) {
-		d_lookup_done(dentry);
-		if (!res)
-			res = dentry;
-		else
-			dput(dentry);
-	}
 	return finish_no_open(file, res);
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
-- 
2.50.0.107.gf914562f5916.dirty


