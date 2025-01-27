Return-Path: <linux-fsdevel+bounces-40167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE18A200C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003D93A6FFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95E1DC98C;
	Mon, 27 Jan 2025 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QCoHocwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A8194091;
	Mon, 27 Jan 2025 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017663; cv=none; b=lQ2p47V6dbgYxgYAUEn5UDN3Xc4jZHkL4pbxpNPc11CcknLpskS7EZWTJZHkTSZ0g70O8OI7Mv/tm22SZO8xZbdCrL3YxzoNx2CFCoHnwsPr5dY5J+C80t6LeRX1fA3S9nIGFnv9p46WbQaSE9nQ6aEEF/dj/cJCOZ7qJP+mIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017663; c=relaxed/simple;
	bh=1OtAS/M6QSFyW/4xMpYhb4lZn0l3hMGoLtTKNx/NBxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2q/mIQFX5Fo5p0pOnU9OuE3mo0ZMfMOwF6R20vU5yqyrO9e1T42g2w7Cv6VSCEN1LnXrBBDxLftWMoiSNzV29YlaCe/k+0pjUKaMtxTW8VYyUvEeg6NALey+DtLesTQo/3V+BUuSXti/WHeP+qcyVhWLiIv/ovtvsuCsPFy4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QCoHocwp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hFXPlPCQJCKkcL+gorBEqLvwOPh+eAAK9yXs414tvxw=; b=QCoHocwpPn9VhFgaSC14JoKxEA
	boQtZ/X9xfVpn4k8Pc8dQRMYipvpW40kqbvLlBQ/g4fTv47gP8HKdJ5JAuGOCaOncdGtjlt1Q9Pl3
	R/lCazEFmfaiGsrK2n/J+DXfpBCDRtqx0ddSUAy1W+fIl7uC9U3w07nhnblor1I3/i0ZqZlhOEBEP
	a3ploe5TqyyeoumLIHh6xd00F5N/Pz6Nm++hnxpIvjAe8hQDzC+BaZRR22vizVNNF3AWBnQKvqSxl
	shtjgqYymhkCao6rCk09YF17O5yOoKK+A8JECG/Dd7tOXunnW5nchVvXf860cDKXYmTagG15nEGDl
	gPzWlesw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcXmt-0000000Dk5r-1Q3B;
	Mon, 27 Jan 2025 22:40:59 +0000
Date: Mon, 27 Jan 2025 22:40:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <20250127224059.GI1977892@ZenIV>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
 <20250127213456.GH1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127213456.GH1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 27, 2025 at 09:34:56PM +0000, Al Viro wrote:

> If so, then
> 	a) it's a false positive (and IIRC, it's not the first time
> kfence gets confused by that)
> 	b) your bisection will probably converge to bdd9951f60f9
> "dissolve external_name.u into separate members" which is where we'd
> ended up with offsetof(struct external_name, name) being 4 modulo 8.
> 
> As a quick test, try to flip the order of head and count in
> struct external_name and see if that makes the warning go away.
> If it does, I'm pretty certain that theory above is correct.

Not quite...   dentry_string_cmp() assumes that ->d_name.name is
word-aligned, so load_unaligned_zeropad() is done only to the
second string (the one we compare against).

Linus, does the following look sane to you as replacement for
bdd9951f60f9?  I'd rather have explicit __aligned(), along
with the comment spelling the constraints out...


diff --git a/fs/dcache.c b/fs/dcache.c
index f387dc97df86..f8d6a2557736 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -295,12 +295,16 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 	return dentry_string_cmp(cs, ct, tcount);
 }
 
+/*
+ * long names are allocated separately from dentry and never modified.
+ * Refcounted, freeing is RCU-delayed.  See take_dentry_name_snapshot()
+ * for the reason why ->count and ->head can't be combined into a union.
+ * dentry_string_cmp() relies upon ->name[] being word-aligned.
+ */
 struct external_name {
-	struct {
-		atomic_t count;		// ->count and ->head can't be combined
-		struct rcu_head head;	// see take_dentry_name_snapshot()
-	} u;
-	unsigned char name[];
+	atomic_t count;
+	struct rcu_head head;
+	unsigned char name[] __aligned(sizeof(unsigned long));
 };
 
 static inline struct external_name *external_name(struct dentry *dentry)
@@ -344,7 +348,7 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
 		struct external_name *p;
 		p = container_of(s, struct external_name, name[0]);
 		// get a valid reference
-		if (unlikely(!atomic_inc_not_zero(&p->u.count)))
+		if (unlikely(!atomic_inc_not_zero(&p->count)))
 			goto retry;
 		name->name.name = s;
 	}
@@ -361,8 +365,8 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
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
@@ -400,7 +404,7 @@ static void dentry_free(struct dentry *dentry)
 	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
-		if (likely(atomic_dec_and_test(&p->u.count))) {
+		if (likely(atomic_dec_and_test(&p->count))) {
 			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
 			return;
 		}
@@ -1681,7 +1685,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
 		}
-		atomic_set(&p->u.count, 1);
+		atomic_set(&p->count, 1);
 		dname = p->name;
 	} else  {
 		dname = dentry->d_shortname.string;
@@ -2774,15 +2778,15 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
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

