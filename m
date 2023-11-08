Return-Path: <linux-fsdevel+bounces-2357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4907E5072
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 07:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A402D281481
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 06:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E31FBA;
	Wed,  8 Nov 2023 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YVRnPWQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410426AD9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 06:47:25 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EE01B5;
	Tue,  7 Nov 2023 22:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u3nfxFHxXvJtVjsrnPcl+y4ihBxKcHpIn1mIPIW1VbQ=; b=YVRnPWQOFPuAZoS33Go0j1/02r
	BMFU5/yBugHLf1rM1Z5bXO0e5UcfFAPcElMosVDjdQreKRmIrZdsiqTZSmBi5Yr21mV1XWU1o+Xx6
	rh45Ljfa8RGCKUb2UNOg0iit0eo7tyV6TEMAXpCFVN38lEqhh4fo7GmXfrcFeefWn2AhJTU9IT4lo
	syj7mxwNUVRJBjrRj5wrjRDqOz95YfHv8CgeWs2qc+mTQL8XC/vuBUdE2RpxqKf5xK0/L5XjCCGZP
	2lLJIO8DPdCuD4LmapykaUgjJIwLpqYD61wO9M8ga+LhmjdgCO5XCmCPOmSf1I1jhfA8r1sXDd+cy
	L3nCDpmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0cLS-00CvFn-3D;
	Wed, 08 Nov 2023 06:47:23 +0000
Date: Wed, 8 Nov 2023 06:47:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	"Tobin C . Harding" <tobin@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nik Bune <n2h9z4@gmail.com>,
	Anup K Parikh <parikhanupk.foss@gmail.com>
Subject: Re: [PATCH] fs: dcache: fix dget()/dget_dlock() kernel-doc
Message-ID: <20231108064722.GX1957730@ZenIV>
References: <20231108051027.12363-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108051027.12363-1-rdunlap@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 07, 2023 at 09:10:27PM -0800, Randy Dunlap wrote:
> + *	The reference count increment in this function is not atomic.
> + *	Consider dget() if atomicity is required.

No.  dget() under ->d_lock will deadlock; dget_dlock() *not* under ->d_lock
is a bug.  There is nothing optional about that, so "consider" is seriously
misleading.

dget() is an equivalent of
	spin_lock(&dentry->d_lock);
	dentry->d_lockref.count++;
	spin_unlock(&dentry->d_lock);
with a bit of an optimization that avoids 3 stores if it can get away with
just one.  Optimization does *NOT* change the fact that it will end up
spinning if ->d_lock is held.

All changes of dentry refcount *MUST* be under ->d_lock or be equivalent
to such.  You can do that directly if you are holding ->d_lock already,
you can take it manually and do modification or you can use a function
that does an equivalent of lock/modify/unlock.

Additionally, dget() is only allowed if you are guaranteed to already
hold a reference; it will go from 0 to 1, but it's really asking for
trouble.

dget_dlock() is allowed if dentry is not dead, i.e. if you know that
it has not reached __dentry_kill() yet.  Anything with refcount >= 0
after you grabbed ->d_lock is fine, since the very first thing
__dentry_kill() does is setting refcount negative and does that before
dropping ->d_lock.  For the same reason anything found to be still
hashed after you've grabbed ->d_lock is fine.  Ditto for anything
found on inode's aliases list (under ->i_lock and ->d_lock), for
much the same reason.  The same goes for any pointer that would've
been removed by ->d_prune().  The same goes for anything with
non-NULL ->d_inode (again, under ->d_lock).  Or anything with
non-empty list of children (since that'll guarantee positive
refcount), etc.

The real predicate is "had not been passed to __dentry_kill() yet";
the rest is a bunch of criteria sufficient for that.  Shouldn't
be all that many callers - or places that play with ->d_lock, for
that matter.  <checks>  In #work.dcache2 at the moment:

	Checked simple_positive() under ->d_lock:
arch/powerpc/platforms/cell/spufs/inode.c:155:                  dget_dlock(dentry);
fs/autofs/expire.c:81:                  dget_dlock(child);
fs/configfs/inode.c:211:                        dget_dlock(dentry);
fs/libfs.c:120:                         found = dget_dlock(d);
fs/libfs.c:410:         found = dget_dlock(child);
fs/libfs.c:498:                         child = dget_dlock(d);

	Check that dentry is positive under ->d_lock:
fs/autofs/root.c:232:                   dget_dlock(expiring);

	Found in inode's list of aliases under ->i_lock and ->d_lock:
fs/ceph/mds_client.c:4277:                      dn = dget_dlock(alias);
fs/dcache.c:970:                        __dget_dlock(alias);
fs/dcache.c:2719:                       __dget_dlock(alias);
fs/ocfs2/dcache.c:165:                  dget_dlock(dentry);

	Found to be hashed under ->d_lock:
fs/dcache.c:2361:               dentry->d_lockref.count++;

	Check that refcount is greater than 0 under ->d_lock:
fs/autofs/root.c:172:                   dget_dlock(active);

	Check that refcount is not negative under ->d_lock:
fs/ceph/dir.c:1603:                             dget_dlock(dentry);

	->d_parent of live dentry, refcount must be positive:
fs/dcache.c:925:        ret->d_lockref.count++;
fs/dcache.c:2855:               dentry->d_parent->d_lockref.count++;

	Found to be a mountpoint under ->d_lock; refcount must be positive:
fs/dcache.c:1575:               __dget_dlock(dentry);

	Caller must have already held a reference:
fs/dcache.c:1721:       __dget_dlock(parent);

	The worst of the entire bunch - associated ceph_dentry_info
is found to be hashed under ->d_lock.  That thing gets hashed
by ceph_unlink(), with caller holding a reference to dentry and
it is removed from hash (either by ceph_unlink() itself or by
ceph_async_unlink_cb()) before the dentry reference gets dropped.
Ceph is really gnarly around refcounting...
fs/ceph/mds_client.c:864:               found = dget_dlock(udentry);


PS: Folks, please don't get confused by lockref; all it really does
is an optimized variant of lock/modify/unlock on architectures that
have reasonably cheap 64bit compare-and-swap and have sane spinlocks.

Eqiuvalents of these primitives:

lockref_get:
	lock
	count++
	unlock
lockref_get_not_zero:
	lock
	if (count > 0)
		count++
		unlock
		return true
	else
		unlock
		return false
lockref_put_not_zero:
	lock
	if (count > 1)
		count--
		unlock
		return true
	else
		unlock
		return false
lockref_put_or_lock:
	lock
	if count > 1
		count--
		unlock
		return true
	else
		return false	// *WITHOUT* unlock
lockref_get_not_dead:
	lock
	if (count >= 0)
		count++
		unlock
		return true
	else
		unlock
		return false
lockref_mark_dead:		// must be called under lock
	count = -128		// negative; no reason -1 wouldn't do

__lockref_is_dead:		// ought to be used under lock, or it can
	count < 0		// go from false to true under you.
				// can be used as a check before bothering
				// with lock - if true, it's going to stay
				// true.

There's also lockref_put_return, but that's really, really fastpath-only thing;
unlike the rest of them it does not have a fallback and caller must provide
one.  About the only valid use is in fast_dput(); IMO that ought to be
renamed to __lockref_put_return() to make trouble less likely.

PPS: sparc64 almost certainly should go for these tricks; riscv probably would
be fine too...

