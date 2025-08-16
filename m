Return-Path: <linux-fsdevel+bounces-58079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9CAB28F4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 17:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F0B7AC4FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952B26E6FF;
	Sat, 16 Aug 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IpLAtdXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1EE13C3F6
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Aug 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755359919; cv=none; b=ePdqcMhdTsWPFRkWX4ICvteZFVgX1+45yjJFWPXZNRA2b6CwHYxDfgc5WUUColNVGHgurHjSJZfS7mQuSNyTh2AuATUuSMGBwczcGDs5m+x+/pQWsX50G+vZiD3zR4flsrA1Jc+2U9rxXCoaB38YMts7p//pNIDx/yINvHZahIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755359919; c=relaxed/simple;
	bh=PFj9GT4mnoxkKvC51NigcQ2Ul54zKLdRwQwy5OrDO/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY1kgqyfnKCalJkaLsS2xY4P9Uw4S0dUYU4j1vQA723ivXVQqVnHz/HYdyz5uV7lsLDqZw6k1R1j65FcbOTYdwZfJNwEz51E0AEKk1rg2Ej+qQsnns+W8NVYSwLVEtyoqf0e4P0prkKeb4Fco8UF0NkkVte4/w/F1VdpByElUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IpLAtdXt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=md8KkLkCq02t0azPE9Hn7PyRESjpbhkKmCVZAbVnDWQ=; b=IpLAtdXtQKt2zuuC8e/oYTOipV
	MHRKx9lRVfZUKlwsqNwqLvJdQipkAB16WGhoh1U2/VXlOxyMc15WY66dr0eAH/rb30sjBIDdX0Pwi
	e8Tu9KCzCtBGgnoblurgFzLBrQ1DZ/3tIOTa3q1iI0QB24zjpye7XFg0d5OYjFc7iw0OgHZ/nLM30
	9KfxT8iFyaLK5PP7QRFkeMspE2XQkvZx13Kzs22FQ5gX80P+Cwtuc9WZIVjasgkCEPtcnxjXHhN9w
	ZAX0vCeTlt2hTvs79GJ3kf9/GLKKeQc27Ap4tQ/ohONPFbz+yOP4evPVTZzWz6oWScCQ0Fqz1a5OU
	ts7YQ2Sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unJIe-0000000GBKa-23nz;
	Sat, 16 Aug 2025 15:58:32 +0000
Date: Sat, 16 Aug 2025 16:58:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@google.com>,
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: Re: [PATCHES][RFC][CFT] mount fixes
Message-ID: <20250816155832.GT222315@ZenIV>
References: <20250815233316.GS222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815233316.GS222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 16, 2025 at 12:33:16AM +0100, Al Viro wrote:

> 4) change_mnt_propagation() slowdown in some cases.  On umount we want all
> victims out of propagation graph and propagation between the surviving mounts
> to be unchanged.  So if victim used to have slaves, they need to be transfered
> to its peer (if any) or master.  In case when victim had many peers, all
> taken out by that umount(), that ended up with all its slaves being gradually
> transferred between all peers until we finally ran out of those.  It can
> easily lead to quadratic time.  The patch in -rc1 switched that to "just
> find where they'll end up upfront, and move them once", which eliminated
> that... except that I hadn't noticed that on massage of change_mnt_propagation()
> we ended up calculating the place where they'd be transferred in cases
> when there had been nothing to transfer.  With obvious effects when there
> had been a large peer group entirely taken out, with not a single slave between
> them.  The minimal fix ("call propagation_source() only if we are going to
> use its return value") is enough to recover in all cases.
> Longer term we should kick all victims out of propagation graph at once
> and I have that plotted out, but that's for the next merge window; for
> now the minimal obvious fix is good enough.

FWIW, proposed longer term fix (on top of this series, completely
untested) would be the patch below.  Basically, calculate where the slaves
end up for all mounts to be removed, taking the mounts themselves out
of propagation graph, then do all transfers; duplicate work on finding
destinations is avoided that way, since if we run into a mount that
already had destination found, we don't need to trace the rest of the way.
That's guaranteed O(removed mounts) for finding destinations and removing
from propagation graph and O(surviving mounts that have master removed)
for transfers.

diff --git a/fs/namespace.c b/fs/namespace.c
index 88db58061919..5c68a05f9679 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1842,6 +1842,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 	if (how & UMOUNT_PROPAGATE)
 		propagate_umount(&tmp_list);
 
+	bulk_make_private(&tmp_list);
+
 	while (!list_empty(&tmp_list)) {
 		struct mnt_namespace *ns;
 		bool disconnect;
@@ -1866,7 +1868,6 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 				umount_mnt(p);
 			}
 		}
-		change_mnt_propagation(p, MS_PRIVATE);
 		if (disconnect)
 			hlist_add_head(&p->mnt_umount, &unmounted);
 
diff --git a/fs/pnode.c b/fs/pnode.c
index 6f7d02f3fa98..9fe2ddaf52db 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -70,19 +70,6 @@ static inline bool will_be_unmounted(struct mount *m)
 	return m->mnt.mnt_flags & MNT_UMOUNT;
 }
 
-static struct mount *propagation_source(struct mount *mnt)
-{
-	do {
-		struct mount *m;
-		for (m = next_peer(mnt); m != mnt; m = next_peer(m)) {
-			if (!will_be_unmounted(m))
-				return m;
-		}
-		mnt = mnt->mnt_master;
-	} while (mnt && will_be_unmounted(mnt));
-	return mnt;
-}
-
 static void transfer_propagation(struct mount *mnt, struct mount *to)
 {
 	struct hlist_node *p = NULL, *n;
@@ -111,11 +98,10 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		return;
 	}
 	if (IS_MNT_SHARED(mnt)) {
-		if (type == MS_SLAVE || !hlist_empty(&mnt->mnt_slave_list))
-			m = propagation_source(mnt);
 		if (list_empty(&mnt->mnt_share)) {
 			mnt_release_group_id(mnt);
 		} else {
+			m = next_peer(mnt);
 			list_del_init(&mnt->mnt_share);
 			mnt->mnt_group_id = 0;
 		}
@@ -136,6 +122,57 @@ void change_mnt_propagation(struct mount *mnt, int type)
 	}
 }
 
+static struct mount *trace_transfers(struct mount *m)
+{
+	while (1) {
+		struct mount *next = next_peer(m);
+
+		if (next != m) {
+			list_del_init(&m->mnt_share);
+			m->mnt_group_id = 0;
+			m->mnt_master = next;
+		} else {
+			if (IS_MNT_SHARED(m))
+				mnt_release_group_id(m);
+			next = m->mnt_master;
+		}
+		hlist_del_init(&m->mnt_slave);
+		CLEAR_MNT_SHARED(m);
+		SET_MNT_MARK(m);
+
+		if (!next || !will_be_unmounted(next))
+			return next;
+		if (IS_MNT_MARKED(next))
+			return next->mnt_master;
+		m = next;
+	}
+}
+
+static void set_destinations(struct mount *m, struct mount *master)
+{
+	struct mount *next;
+
+	while ((next = m->mnt_master) != master) {
+		m->mnt_master = master;
+		m = next;
+	}
+}
+
+void bulk_make_private(struct list_head *set)
+{
+	struct mount *m;
+
+	list_for_each_entry(m, set, mnt_list)
+		if (!IS_MNT_MARKED(m))
+			set_destinations(m, trace_transfers(m));
+
+	list_for_each_entry(m, set, mnt_list) {
+		transfer_propagation(m, m->mnt_master);
+		m->mnt_master = NULL;
+		CLEAR_MNT_MARK(m);
+	}
+}
+
 static struct mount *__propagation_next(struct mount *m,
 					 struct mount *origin)
 {
diff --git a/fs/pnode.h b/fs/pnode.h
index 00ab153e3e9d..b029db225f33 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -42,6 +42,7 @@ static inline bool peers(const struct mount *m1, const struct mount *m2)
 }
 
 void change_mnt_propagation(struct mount *, int);
+void bulk_make_private(struct list_head *);
 int propagate_mnt(struct mount *, struct mountpoint *, struct mount *,
 		struct hlist_head *);
 void propagate_umount(struct list_head *);

