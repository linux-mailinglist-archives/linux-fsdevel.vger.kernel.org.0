Return-Path: <linux-fsdevel+bounces-36884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6466E9EA5FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 03:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7272C161C65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3481C1D5CE8;
	Tue, 10 Dec 2024 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W1FtGqkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275641A2554;
	Tue, 10 Dec 2024 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798912; cv=none; b=lXQsAiESWNvMlxr9mMtx7R02ilR1/N0uUZgjHUYlmgbjKufCsEb7KqXjpVYZQQL7kruqbqAl2wO0x9gpbpsOG3fE53Zmut5Wqnmf56MTbTtQkphBOEYiDFEjPr/2iKuiH9XtuXCA5e1VrKOO/pu9792/xoIWXCFNPNEPQTUgmxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798912; c=relaxed/simple;
	bh=AWcZYexTjmt6S+cfUq+ksXQumblz26xuxvK0tmTDgaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qjqn2moAchMEIPL1gk6OMcC2hPnpqXZDZQ3ySaLMfSBEbrk/ZO81yyLyqfbbRItY5zCFlX1WOyrnyY7jB/aVvkpisHeojJ+eqIeSdUm/16Cm+7i03sq+yrzZecNZlj3e91P1TcH8kFhOrcP2UNbGfjRP4jf/zASVGwVs4jyQk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W1FtGqkb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zs/1MAvhqT4o0Poecm2Da1zk8cYfon5BiqshWlcSZOs=; b=W1FtGqkb0mh8s+raSTxO2d7weo
	buF08FLPq2LZYZkkyC8/OLdbr9wsb4zC8hz1YadEyA1mjgvNaDgKdGwMG/8a2Vrz8zazfBgG5+4b2
	e0sNzk3aZ4drX+98KUOeJx3/Awt+pn8RkDctscZqVNDCuX0Oe4hrtE3IgKRWS9R5gzuzpGFV8CdHL
	6KYNFMTnf/KCaDHafg0acE0LMR6C+/MXLJOdE3vK8to2lW/RLudEeTpNd3d2Eb6+TocZbtv2xFmGc
	k1uKYDGtsYDmYjchrqiVNPEur+aiUt5ucntSPyt2eNIc5TCWxFnGa6gEh8zCW8VC17jDXKp45Z+Ma
	aJYM+lhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKqIV-00000006lRs-2ILo;
	Tue, 10 Dec 2024 02:48:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/5] dcache: back inline names with a struct-wrapped array of unsigned long
Date: Tue, 10 Dec 2024 02:48:24 +0000
Message-ID: <20241210024827.1612355-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210024827.1612355-1-viro@zeniv.linux.org.uk>
References: <20241210024523.GD3387508@ZenIV>
 <20241210024827.1612355-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... so that they can be copied with struct assignment (which generates
better code) and accessed word-by-word.  swap_names() used to do the
latter already, using casts, etc.; now that can be done cleanly.

Both dentry->d_iname and name_snapshot->inline_name got such treatment.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 19 +++++++------------
 include/linux/dcache.h | 14 ++++++++++++--
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea0f0bea511b..007e582c3e68 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -334,8 +334,7 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
 	if (unlikely(dname_external(dentry))) {
 		atomic_inc(&external_name(dentry)->u.count);
 	} else {
-		memcpy(name->inline_name, dentry->d_iname,
-		       dentry->d_name.len + 1);
+		name->inline_name_words = dentry->d_iname_words;
 		name->name.name = name->inline_name;
 	}
 	spin_unlock(&dentry->d_lock);
@@ -2729,9 +2728,8 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			 * dentry:internal, target:external.  Steal target's
 			 * storage and make target internal.
 			 */
-			memcpy(target->d_iname, dentry->d_name.name,
-					dentry->d_name.len + 1);
 			dentry->d_name.name = target->d_name.name;
+			target->d_iname_words = dentry->d_iname_words;
 			target->d_name.name = target->d_iname;
 		}
 	} else {
@@ -2740,18 +2738,16 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			 * dentry:external, target:internal.  Give dentry's
 			 * storage to target and make dentry internal
 			 */
-			memcpy(dentry->d_iname, target->d_name.name,
-					target->d_name.len + 1);
 			target->d_name.name = dentry->d_name.name;
+			dentry->d_iname_words = target->d_iname_words;
 			dentry->d_name.name = dentry->d_iname;
 		} else {
 			/*
 			 * Both are internal.
 			 */
-			for (int i = 0; i < DNAME_INLINE_WORDS; i++) {
-				swap(((long *) &dentry->d_iname)[i],
-				     ((long *) &target->d_iname)[i]);
-			}
+			for (int i = 0; i < DNAME_INLINE_WORDS; i++)
+				swap(dentry->d_iname_words.words[i],
+				     target->d_iname_words.words[i]);
 		}
 	}
 	swap(dentry->d_name.hash_len, target->d_name.hash_len);
@@ -2766,8 +2762,7 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 		atomic_inc(&external_name(target)->u.count);
 		dentry->d_name = target->d_name;
 	} else {
-		memcpy(dentry->d_iname, target->d_name.name,
-				target->d_name.len + 1);
+		dentry->d_iname_words = target->d_iname_words;
 		dentry->d_name.name = dentry->d_iname;
 		dentry->d_name.hash_len = target->d_name.hash_len;
 	}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 42dd89beaf4e..766a9156836e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -79,6 +79,10 @@ extern const struct qstr dotdot_name;
 
 #define DNAME_INLINE_LEN (DNAME_INLINE_WORDS*sizeof(unsigned long))
 
+struct shortname_store {
+	unsigned long words[DNAME_INLINE_WORDS];
+};
+
 #define d_lock	d_lockref.lock
 
 struct dentry {
@@ -90,7 +94,10 @@ struct dentry {
 	struct qstr d_name;
 	struct inode *d_inode;		/* Where the name belongs to - NULL is
 					 * negative */
-	unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
+	union {
+		unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
+		struct shortname_store d_iname_words;
+	};
 	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
 
 	/* Ref lookup also touches following */
@@ -591,7 +598,10 @@ static inline struct inode *d_real_inode(const struct dentry *dentry)
 
 struct name_snapshot {
 	struct qstr name;
-	unsigned char inline_name[DNAME_INLINE_LEN];
+	union {
+		unsigned char inline_name[DNAME_INLINE_LEN];
+		struct shortname_store inline_name_words;
+	};
 };
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);
-- 
2.39.5


