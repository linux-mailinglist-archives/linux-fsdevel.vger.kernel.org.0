Return-Path: <linux-fsdevel+bounces-25408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45B94BB5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 12:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1FAB24B83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E969E18E044;
	Thu,  8 Aug 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGcVVf0Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07218E033;
	Thu,  8 Aug 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113373; cv=none; b=n3yswPpvDt4zJfHWjPE4VpE1ZEBeTiqsOKpWwKsvOh/eRNpwHmwYwb4K/rE/i27MjsDACk7dW6kgylZfEV/Z4JT0/139+jV+db6DM7h38jiBCxd+voJ+8TWrPuAvV8exvy0cC3zruIpQWO8100hGWHlip6f1GYn7T7KpBGZZmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113373; c=relaxed/simple;
	bh=rgvGepv9NmEIkcN6LmuS9SoYsJ3TaQBysMstti68/xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV5bzOquskfu1MnVr3Nk2pDnDfOLImz2edcd3np13l+Jzs2Kbizx8JlGzQizW7mnuCczYu7sKDzoZJ3/z2Fny32FlKRI6QivkLh7OE6HQt/ZlfosAHmN1yaaX8qLdFRdFLX7AWZ4HrFHpqdJPL4YIjlKkn9fANNUbwXOAkjEK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGcVVf0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7A6C4AF0E;
	Thu,  8 Aug 2024 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113372;
	bh=rgvGepv9NmEIkcN6LmuS9SoYsJ3TaQBysMstti68/xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGcVVf0ZEPz26IGymvYDz66LCzF8kF9gswC4UiB00AY41Be7uyL72GvSbJoCDO4Bq
	 3REkTd2Wl0H668fyt6fYXUIUdFJSErC4c9H+wiZ92Ssa9+ZavLwT7HUhHortD5OhrM
	 /42xHFM9MFZW6+J7tvcwNr3eiac8vXg9xByhIEox5qhulAfUN4R1E773B5/jhuBJuN
	 j+bmMILGob/wRla2qkrBHmLzOSrxPmGSRDT+4m15rconMdpvgRMKDP4wSAZjFYjUB/
	 n3t3wA8hVzTZI62L+2/Jl8hTOOHRZA6pUni5IPVkyrecFCgXGdUsyu45SOdu/vPC17
	 AnHozfc5Lax6g==
Date: Thu, 8 Aug 2024 12:36:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <20240807-erledigen-antworten-6219caebedc0@brauner>
 <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="37h7k3p7s7sj3yhb"
Content-Disposition: inline
In-Reply-To: <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>


--37h7k3p7s7sj3yhb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Aug 07, 2024 at 10:36:58AM GMT, Jeff Layton wrote:
> On Wed, 2024-08-07 at 16:26 +0200, Christian Brauner wrote:
> > > +static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
> > > +{
> > > +	struct dentry *dentry;
> > > +
> > > +	if (open_flag & O_CREAT) {
> > > +		/* Don't bother on an O_EXCL create */
> > > +		if (open_flag & O_EXCL)
> > > +			return NULL;
> > > +
> > > +		/*
> > > +		 * FIXME: If auditing is enabled, then we'll have to unlazy to
> > > +		 * use the dentry. For now, don't do this, since it shifts
> > > +		 * contention from parent's i_rwsem to its d_lockref spinlock.
> > > +		 * Reconsider this once dentry refcounting handles heavy
> > > +		 * contention better.
> > > +		 */
> > > +		if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
> > > +			return NULL;
> > 
> > Hm, the audit_inode() on the parent is done independent of whether the
> > file was actually created or not. But the audit_inode() on the file
> > itself is only done when it was actually created. Imho, there's no need
> > to do audit_inode() on the parent when we immediately find that file
> > already existed. If we accept that then this makes the change a lot
> > simpler.
> > 
> > The inconsistency would partially remain though. When the file doesn't
> > exist audit_inode() on the parent is called but by the time we've
> > grabbed the inode lock someone else might already have created the file
> > and then again we wouldn't audit_inode() on the file but we would have
> > on the parent.
> > 
> > I think that's fine. But if that's bothersome the more aggressive thing
> > to do would be to pull that audit_inode() on the parent further down
> > after we created the file. Imho, that should be fine?...
> > 
> > See https://gitlab.com/brauner/linux/-/commits/vfs.misc.jeff/?ref_type=heads
> > for a completely untested draft of what I mean.
> 
> Yeah, that's a lot simpler. That said, my experience when I've worked
> with audit in the past is that people who are using it are _very_
> sensitive to changes of when records get emitted or not. I don't like
> this, because I think the rules here are ad-hoc and somewhat arbitrary,
> but keeping everything working exactly the same has been my MO whenever
> I have to work in there.
> 
> If a certain access pattern suddenly generates a different set of
> records (or some are missing, as would be in this case), we might get
> bug reports about this. I'm ok with simplifying this code in the way
> you suggest, but we may want to do it in a patch on top of mine, to
> make it simple to revert later if that becomes necessary.

Fwiw, even with the rearranged checks in v3 of the patch audit records
will be dropped because we may find a positive dentry but the path may
have trailing slashes. At that point we just return without audit
whereas before we always would've done that audit.

Honestly, we should move that audit event as right now it's just really
weird and see if that works. Otherwise the change is somewhat horrible
complicating the already convoluted logic even more.

So I'm appending the patches that I have on top of your patch in
vfs.misc. Can you (other as well ofc) take a look and tell me whether
that's not breaking anything completely other than later audit events?

--37h7k3p7s7sj3yhb
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-move-audit-parent-inode.patch"

From c3dd9f0e320a631bdb12ecd298cedcc43358b80f Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 8 Aug 2024 10:16:42 +0200
Subject: [PATCH 1/4] fs: move audit parent inode

During O_CREAT we unconditionally audit the parent inode. This makes it
difficult to support a fastpath for O_CREAT when the file already exists
because we have to drop out of RCU lookup needlessly.

We worked around this by checking whether audit was actually active but
that's also suboptimal. Instead, move the audit of the parent inode down
into lookup_open() at a point where it's mostly certain that the file
needs to be created.

This also reduced the inconsistency that currently exists: while audit
on the parent is done independent of whether or no the file already
existed an audit on the file is only performed if it has been created.

By moving the audit down a bit we emit the audit a little later but it
will allow us to simplify the fastpath for O_CREAT significantly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3e34f4d97d83..745415fcda57 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3535,6 +3535,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		return dentry;
 	}
 
+	if (open_flag & O_CREAT)
+		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
+
 	/*
 	 * Checking write permission is tricky, bacuse we don't know if we are
 	 * going to actually need it: O_CREAT opens should work as long as the
@@ -3691,7 +3694,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 			if (!unlazied)
 				return ERR_PTR(-ECHILD);
 		}
-		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
 		if (trailing_slashes(nd)) {
 			dput(dentry);
 			return ERR_PTR(-EISDIR);
-- 
2.43.0


--37h7k3p7s7sj3yhb
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-fs-pull-up-trailing-slashes-check-for-O_CREAT.patch"

From ac4db275670c1311fecb00145f585127c3a7e648 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 8 Aug 2024 11:12:50 +0200
Subject: [PATCH 2/4] fs: pull up trailing slashes check for O_CREAT

Perform the check for trailing slashes right in the fastpath check and
don't bother with any additional work.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namei.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 745415fcda57..08eb9a53beb7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3618,6 +3618,9 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 	struct dentry *dentry;
 
 	if (open_flag & O_CREAT) {
+		if (trailing_slashes(nd))
+			return ERR_PTR(-EISDIR);
+
 		/* Don't bother on an O_EXCL create */
 		if (open_flag & O_EXCL)
 			return NULL;
@@ -3684,20 +3687,13 @@ static const char *open_last_lookups(struct nameidata *nd,
 			bool unlazied;
 
 			/* can stay in rcuwalk if not auditing */
-			if (dentry && audit_dummy_context()) {
-				if (trailing_slashes(nd))
-					return ERR_PTR(-EISDIR);
+			if (dentry && audit_dummy_context())
 				goto finish_lookup;
-			}
 			unlazied = dentry ? try_to_unlazy_next(nd, dentry) :
 					    try_to_unlazy(nd);
 			if (!unlazied)
 				return ERR_PTR(-ECHILD);
 		}
-		if (trailing_slashes(nd)) {
-			dput(dentry);
-			return ERR_PTR(-EISDIR);
-		}
 		if (dentry)
 			goto finish_lookup;
 	}
-- 
2.43.0


--37h7k3p7s7sj3yhb
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0003-fs-remove-audit-dummy-context-check.patch"

From 155a11570398943dcb623a2390ac27f9eae3d8b3 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 8 Aug 2024 11:15:41 +0200
Subject: [PATCH 3/4] fs: remove audit dummy context check

Now that we audit later during lookup_open() we can remove the audit
dummy context check. This simplifies things a lot.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namei.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 08eb9a53beb7..96c79dec7184 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3624,16 +3624,6 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 		/* Don't bother on an O_EXCL create */
 		if (open_flag & O_EXCL)
 			return NULL;
-
-		/*
-		 * FIXME: If auditing is enabled, then we'll have to unlazy to
-		 * use the dentry. For now, don't do this, since it shifts
-		 * contention from parent's i_rwsem to its d_lockref spinlock.
-		 * Reconsider this once dentry refcounting handles heavy
-		 * contention better.
-		 */
-		if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
-			return NULL;
 	}
 
 	if (trailing_slashes(nd))
@@ -3687,7 +3677,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 			bool unlazied;
 
 			/* can stay in rcuwalk if not auditing */
-			if (dentry && audit_dummy_context())
+			if (dentry)
 				goto finish_lookup;
 			unlazied = dentry ? try_to_unlazy_next(nd, dentry) :
 					    try_to_unlazy(nd);
-- 
2.43.0


--37h7k3p7s7sj3yhb
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0004-fs-rearrange-general-fastpath-check-now-that-O_CREAT.patch"

From a2e0e55a57f88e08745cbd7bcdf8de8692306284 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 8 Aug 2024 11:16:42 +0200
Subject: [PATCH 4/4] fs: rearrange general fastpath check now that O_CREAT
 uses it

If we find a positive dentry we can now simply try and open it. All
prelimiary checks are already done with or without O_CREAT.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namei.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 96c79dec7184..2699601bf8e9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3666,26 +3666,17 @@ static const char *open_last_lookups(struct nameidata *nd,
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
-	if (!(open_flag & O_CREAT)) {
-		if (likely(dentry))
-			goto finish_lookup;
+	if (likely(dentry))
+		goto finish_lookup;
 
+	if (!(open_flag & O_CREAT)) {
 		if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU))
 			return ERR_PTR(-ECHILD);
 	} else {
 		if (nd->flags & LOOKUP_RCU) {
-			bool unlazied;
-
-			/* can stay in rcuwalk if not auditing */
-			if (dentry)
-				goto finish_lookup;
-			unlazied = dentry ? try_to_unlazy_next(nd, dentry) :
-					    try_to_unlazy(nd);
-			if (!unlazied)
+			if (!try_to_unlazy(nd))
 				return ERR_PTR(-ECHILD);
 		}
-		if (dentry)
-			goto finish_lookup;
 	}
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
-- 
2.43.0


--37h7k3p7s7sj3yhb--

