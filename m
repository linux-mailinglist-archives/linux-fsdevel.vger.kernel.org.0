Return-Path: <linux-fsdevel+bounces-36867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175489EA1D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 23:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8087A16694E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46631A0BC5;
	Mon,  9 Dec 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XTkgrBGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38651A072A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783343; cv=none; b=WdgZL5pcowkRpRFZyFhfQvv27brE2rGKUWvMiXx4jqq3M392AJVIvUGFilY5fk1fseFPLMlbnn8AZ/xv3cCBwsQnPtCCxAmkyL+vZ+lX+wgg6bvsogCNyoVVTPXpxwC5zgcF/eVzFh7BGFHeW9DkjsET9/Rj9xBuck/I0VnL9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783343; c=relaxed/simple;
	bh=eElBynqFggbIthSo8w8fimML+Sp1oz0vtgMC1mdDdb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyMGeOKAz8smy15hsf2AizNZHELZtA6Ab4PDcU7QyJsfckjKaoy1QdRtvns22Ed8tuSndZpKvQ+i0Lc5AKPTTtVuCNIxHzz0ZZhoB2NCNW4QGmnWxBlDrcHYu4ffPPrCCxrjVKOF2PLOXELXL/YAi67WLr+yLkD5mUd5f8S8Kp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XTkgrBGF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BZY5hm6vwtREonWoJSeWPhxjTiAhIBoqwDlg3IDc9Go=; b=XTkgrBGFMwsIrh86DR7ISllJIe
	00/sqQJFrQGbDmGe4g6dC+Kj7kivOBhFAzXbzTcUiWeKRoLRZDUmG1D7JQShQNGvvGNrg2mmleuYv
	cSK7KdayXJ0BhMJ6jeJASmWXf0/jj8AO0OrcvyfZLcm23Oi63uPecEpniofYbg6nB1Sn923Rhb+ZI
	3bYWACcpT3GxJlp+Qj7rA6/7zJO5xGhAfgfBhYclMs/BTuVQ+ey1VqT7bKLxJiZWzw8O+EesdDqha
	tWbGd0TchsRqZxRFWak7yIW8KTuU+IWF9/njFSrA06m398tzNfKlWcqZGUrsWrI45xqRD9bxrbOgr
	ae6Rr/lQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKmFK-00000006h04-1JLd;
	Mon, 09 Dec 2024 22:28:54 +0000
Date: Mon, 9 Dec 2024 22:28:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241209222854.GB3387508@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209211708.GA3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 09, 2024 at 09:17:08PM +0000, Al Viro wrote:

> And yes, they are aligned - d_iname follows a pointer, inline_name follows
> struct qstr, i.e. u64 + pointer.  How about we add struct inlined_name {
> unsigned char name[DNAME_INLINE_LEN];}; and turn d_iname and inline_name
> into anon unions with that?  Hell, might even make it an array of unsigned
> long and use that to deal with this
>                 } else {
>                         /*
>                          * Both are internal.
>                          */
>                         unsigned int i;
>                         BUILD_BUG_ON(!IS_ALIGNED(DNAME_INLINE_LEN, sizeof(long)));
>                         for (i = 0; i < DNAME_INLINE_LEN / sizeof(long); i++) {
>                                 swap(((long *) &dentry->d_iname)[i],
>                                      ((long *) &target->d_iname)[i]);
>                         }
>                 }
> in swap_names().  With struct assignment in the corresponding case in
> copy_name() and in take_dentry_name_snapshot() - that does generate sane
> code...

Do you have any objections to the diff below?  Completely untested and needs
to be split in two...  It does seem to generate decent code; it obviously
will need to be profiled - copy_name() in the common (short-to-short) case
copies the entire thing, all 5 words of it on 64bit, instead of memcpy()
of just the amount that needs to be copied.  That thing may cross the
cacheline boundary, but both cachelines had been freshly brought into
cache and dirtied, so...

diff --git a/fs/dcache.c b/fs/dcache.c
index b4d5e9e1e43d..687558622acf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -296,10 +296,8 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 }
 
 struct external_name {
-	union {
-		atomic_t count;
-		struct rcu_head head;
-	} u;
+	atomic_t count;		// ->count and ->head can't be combined
+	struct rcu_head head;	// see take_dentry_name_snapshot()
 	unsigned char name[];
 };
 
@@ -329,16 +327,33 @@ static inline int dname_external(const struct dentry *dentry)
 
 void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
 {
-	spin_lock(&dentry->d_lock);
-	name->name = dentry->d_name;
-	if (unlikely(dname_external(dentry))) {
-		atomic_inc(&external_name(dentry)->u.count);
-	} else {
-		memcpy(name->inline_name, dentry->d_iname,
-		       dentry->d_name.len + 1);
+	unsigned seq;
+	const unsigned char *s;
+
+	rcu_read_lock();
+retry:
+	seq = read_seqcount_begin(&dentry->d_seq);
+	s = READ_ONCE(dentry->d_name.name);
+	name->name.hash_len = dentry->d_name.hash_len;
+	if (likely(s == dentry->d_iname)) {
 		name->name.name = name->inline_name;
+		name->__inline_name = dentry->__d_iname;
+		if (read_seqcount_retry(&dentry->d_seq, seq))
+			goto retry;
+	} else {
+		struct external_name *p;
+		p = container_of(s, struct external_name, name[0]);
+		name->name.name = s;
+		// get a valid reference
+		if (unlikely(!atomic_inc_not_zero(&p->count)))
+			goto retry;
+		if (read_seqcount_retry(&dentry->d_seq, seq)) {
+			if (unlikely(atomic_dec_and_test(&p->count)))
+				kfree_rcu(p, head);
+			goto retry;
+		}
 	}
-	spin_unlock(&dentry->d_lock);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(take_dentry_name_snapshot);
 
@@ -347,8 +362,8 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
 	if (unlikely(name->name.name != name->inline_name)) {
 		struct external_name *p;
 		p = container_of(name->name.name, struct external_name, name[0]);
-		if (unlikely(atomic_dec_and_test(&p->u.count)))
-			kfree_rcu(p, u.head);
+		if (unlikely(atomic_dec_and_test(&p->count)))
+			kfree_rcu(p, head);
 	}
 }
 EXPORT_SYMBOL(release_dentry_name_snapshot);
@@ -386,7 +401,7 @@ static void dentry_free(struct dentry *dentry)
 	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
-		if (likely(atomic_dec_and_test(&p->u.count))) {
+		if (likely(atomic_dec_and_test(&p->count))) {
 			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
 			return;
 		}
@@ -1667,7 +1682,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
 		}
-		atomic_set(&p->u.count, 1);
+		atomic_set(&p->count, 1);
 		dname = p->name;
 	} else  {
 		dname = dentry->d_iname;
@@ -2749,11 +2764,9 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			 * Both are internal.
 			 */
 			unsigned int i;
-			BUILD_BUG_ON(!IS_ALIGNED(DNAME_INLINE_LEN, sizeof(long)));
-			for (i = 0; i < DNAME_INLINE_LEN / sizeof(long); i++) {
-				swap(((long *) &dentry->d_iname)[i],
-				     ((long *) &target->d_iname)[i]);
-			}
+			for (i = 0; i < DNAME_INLINE_LEN / sizeof(long); i++)
+				swap(dentry->__d_iname.name[i],
+				     target->__d_iname.name[i]);
 		}
 	}
 	swap(dentry->d_name.hash_len, target->d_name.hash_len);
@@ -2765,16 +2778,15 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 	if (unlikely(dname_external(dentry)))
 		old_name = external_name(dentry);
 	if (unlikely(dname_external(target))) {
-		atomic_inc(&external_name(target)->u.count);
+		atomic_inc(&external_name(target)->count);
 		dentry->d_name = target->d_name;
 	} else {
-		memcpy(dentry->d_iname, target->d_name.name,
-				target->d_name.len + 1);
+		dentry->__d_iname = target->__d_iname;
 		dentry->d_name.name = dentry->d_iname;
 		dentry->d_name.hash_len = target->d_name.hash_len;
 	}
-	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
-		kfree_rcu(old_name, u.head);
+	if (old_name && likely(atomic_dec_and_test(&old_name->count)))
+		kfree_rcu(old_name, head);
 }
 
 /*
@@ -3189,6 +3201,7 @@ static void __init dcache_init_early(void)
 
 static void __init dcache_init(void)
 {
+	BUILD_BUG_ON(DNAME_INLINE_LEN != sizeof(struct short_name_store));
 	/*
 	 * A constructor could be added for stable state like the lists,
 	 * but it is probably not worth it because of the cache nature
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 1f28f56fd406..d604a4826765 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -77,6 +77,10 @@ extern const struct qstr dotdot_name;
 # endif
 #endif
 
+struct short_name_store {
+	unsigned long name[DNAME_INLINE_LEN / sizeof(unsigned long)];
+};
+
 #define d_lock	d_lockref.lock
 
 struct dentry {
@@ -88,7 +92,10 @@ struct dentry {
 	struct qstr d_name;
 	struct inode *d_inode;		/* Where the name belongs to - NULL is
 					 * negative */
-	unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
+	union {
+		unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
+		struct short_name_store __d_iname;
+	};
 	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
 
 	/* Ref lookup also touches following */
@@ -590,7 +597,10 @@ static inline struct inode *d_real_inode(const struct dentry *dentry)
 
 struct name_snapshot {
 	struct qstr name;
-	unsigned char inline_name[DNAME_INLINE_LEN];
+	union {
+		unsigned char inline_name[DNAME_INLINE_LEN];
+		struct short_name_store __inline_name;
+	};
 };
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);

