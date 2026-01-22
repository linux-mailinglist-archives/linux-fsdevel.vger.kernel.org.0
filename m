Return-Path: <linux-fsdevel+bounces-75150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLBxHfyLcmlJmAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:43:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 701026D7EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1963041BB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF783A2AE2;
	Thu, 22 Jan 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l0eX+9fE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF43A6402
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114513; cv=none; b=qLDabokwk9Nc8Sa6A2BXZa868I8TAv+b0UvRnLA7+JCDDlhbjTD6lQne+Pt87qK46Zch0HgquTNVOVifiXhZyD7FuaJYELQxUFOfMJf6yWG4KXGOPGIeeySzJaPszyJrsN5ow7p1a+TN5MtP1s99LKmV91OHDIr2nkdjqNWzNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114513; c=relaxed/simple;
	bh=SyoD74S8RQOlJ8H8Ihh7DjOqfBQCsA1myDlyuBwaC1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EOrB/gLNEGSU01/kgkZajvnds2H/5+9rMXf8cBn5MEGM8J1gSAcWuVPa2t676XaN8uC07AXEcQa5vxR+6KoeIFNcaxRdsui32BvMZQXZ7Lm/NKaN+OKdnhuh8IhyWtz507N/aMfik1tSYahI9q6cDpbchmVI5jAqLBC9+5Mca7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l0eX+9fE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OJ20mFQ66vl/qJyX8i3fS2ENYZWM6NABfeT4cML/nMw=; b=l0eX+9fEGoenF4znIvpmt63URR
	rGkdQRXogi881wbNHYhXJgxKaXt+7kJkkYVhtk5pT+IvzcPDUnWPMTvzqVvpd/YSgSoU2/Ookg3yd
	WSCcQXXVbkIX3p3KgLht1Xv9KSi7DG599R+VuBXzKSD2l05ghMYYwGq4ScHqk6RV7rXec/yr83pv+
	ABj+lv+pyyZUwU4dSPziVLqNIf1D/ObB1Cs4EEIRZHGEh8wTVdAfNOYkD786nARbQfaRVqix1YqoL
	/g6rVgxaftIyJx188mm7YqZyg/P1+jdQ7Pa4gWTsCuRsEZ/WmYce0DwcgKP5jNIDc+Hc8f2Naqumh
	RiIhpVNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vj1AH-0000000FYrq-1B5L;
	Thu, 22 Jan 2026 20:20:25 +0000
Date: Thu, 22 Jan 2026 20:20:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
Message-ID: <20260122202025.GG3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75150-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.org.uk:email,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 701026D7EB
X-Rspamd-Action: no action

There's a case in which shrink_dcache_tree() ends up busy-waiting: if some
dentry in the subtree in question is found to be in process of being evicted
by another thread.  We need to wait for that to finish so that parent would
no longer be pinned, to avoid the situations when nothing in the tree is
busy, but shrink_dcache_tree() fails to evict some directory only because
memory pressure initiated eviction of some of its children before we got to
evicting those ourselves.  That would be bogus both for shrink_dcache_parent()
and for shrink_dcache_for_umount().

Unfortunately, we have nothing to wait on.  That had led to the possibility
of busy-waiting - getting through the iteration of shrink_dcache_tree() main
loop without having made any progress.  That's Not Nice(tm) and that had been
discussed quite a few times since at least 2018.  Recently it became obvious
that this goes beyond "not nice" - on sufficiently contrieved setup it's
possible to get a livelock there, with both threads involved tied to the same
CPU, shrink_dcache_tree() one with higher priority than the thread that has
given CPU up on may_sleep() in the very beginning of iput() during eviction
of the dentry in the tree shrink_dcache_tree() is busy-waiting for.

Let's get rid of that busy-waiting.  Constraints are
        * don't grow struct dentry
        * don't slow the normal case of __dentry_kill() down
and it turns out to be doable.

Dentries in question are
        * already marked dead (negative ->d_count)
        * already negative
        * already unhashed
        * already not in in-lookup hash
        * yet to get removed from ->d_sib and get DCACHE_DENTRY_KILLED in
flags.

Neither ->d_alias nor the fields overlapping it (->d_rcu and ->d_in_lookup_hash)
are going to be accessed for these dentries until after dentry_unlist().  What's
more, ->d_alias.next is guaranteed to be NULL.

So we can embed struct completion into struct select_data and (ab)use
->d_alias.next for linked list of struct select_data instances.

If dentry_unlist() finds ->d_alias.next non-NULL, it carefully goes over that
list and calls complete() for each of those.

That way select_collect2() can treat negative ->d_count the same way it deals
with dentries on other thread's shrink list - grab rcu_read_lock(), stash the
dentry into data.victim and tell d_walk() to stop.

If shrink_dcache_parent() runs into that case, it should attach its select_data
to victim dentry, evict whatever normal eviction candidates it has gathered
and wait for completion.  Voila...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/dcache.c b/fs/dcache.c
index dc2fff4811d1..6db72a684d8d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -605,6 +605,54 @@ void d_drop(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_drop);
 
+struct select_data {
+	struct dentry *start;
+	union {
+		long found;
+		struct {
+			struct dentry *victim;
+			struct select_data *next;
+			struct completion completion;
+		};
+	};
+	struct list_head dispose;
+};
+
+/*
+ *  shrink_dcache_parent() needs to be notified when dentry in process of
+ *  being evicted finally gets unlisted.  Such dentries are
+ *	already with negative ->d_count
+ *	already negative
+ *	already not in in-lookup hash
+ *	reachable only via ->d_sib.
+ *
+ *  Neither ->d_alias, nor ->d_rcu, nor ->d_in_lookup_hash are going to be
+ *  accessed for those, so we can (ab)use ->d_alias.next for list of
+ *  select_data of waiters.  Initially it's going to be NULL and as long
+ *  as dentry_unlist() returns it to that state we are fine.
+ */
+static inline void d_add_waiter(struct dentry *dentry, struct select_data *p)
+{
+	struct select_data *v = (void *)dentry->d_u.d_alias.next;
+	init_completion(&p->completion);
+	p->next = v;
+	dentry->d_u.d_alias.next = (void *)p;
+}
+
+static inline void d_complete_waiters(struct dentry *dentry)
+{
+	struct select_data *v = (void *)dentry->d_u.d_alias.next;
+	if (unlikely(v)) {
+		/* some shrink_dcache_tree() instances are waiting */
+		dentry->d_u.d_alias.next = NULL;
+		while (v) {
+			struct completion *r = &v->completion;
+			v = v->next;
+			complete(r);
+		}
+	}
+}
+
 static inline void dentry_unlist(struct dentry *dentry)
 {
 	struct dentry *next;
@@ -613,6 +661,7 @@ static inline void dentry_unlist(struct dentry *dentry)
 	 * attached to the dentry tree
 	 */
 	dentry->d_flags |= DCACHE_DENTRY_KILLED;
+	d_complete_waiters(dentry);
 	if (unlikely(hlist_unhashed(&dentry->d_sib)))
 		return;
 	__hlist_del(&dentry->d_sib);
@@ -1499,15 +1548,6 @@ int d_set_mounted(struct dentry *dentry)
  * constraints.
  */
 
-struct select_data {
-	struct dentry *start;
-	union {
-		long found;
-		struct dentry *victim;
-	};
-	struct list_head dispose;
-};
-
 static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 {
 	struct select_data *data = _data;
@@ -1559,6 +1599,10 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 			return D_WALK_QUIT;
 		}
 		to_shrink_list(dentry, &data->dispose);
+	} else if (dentry->d_lockref.count < 0) {
+		rcu_read_lock();
+		data->victim = dentry;
+		return D_WALK_QUIT;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
@@ -1598,12 +1642,26 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 		data.victim = NULL;
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
-			spin_lock(&data.victim->d_lock);
-			if (!lock_for_kill(data.victim)) {
-				spin_unlock(&data.victim->d_lock);
+			struct dentry *v = data.victim;
+
+			spin_lock(&v->d_lock);
+			if (v->d_lockref.count < 0 &&
+			    !(v->d_flags & DCACHE_DENTRY_KILLED)) {
+				// It's busy dying; have it notify us once
+				// it becomes invisible to d_walk().
+				d_add_waiter(v, &data);
+				spin_unlock(&v->d_lock);
+				rcu_read_unlock();
+				if (!list_empty(&data.dispose))
+					shrink_dentry_list(&data.dispose);
+				wait_for_completion(&data.completion);
+				continue;
+			}
+			if (!lock_for_kill(v)) {
+				spin_unlock(&v->d_lock);
 				rcu_read_unlock();
 			} else {
-				shrink_kill(data.victim);
+				shrink_kill(v);
 			}
 		}
 		if (!list_empty(&data.dispose))

