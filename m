Return-Path: <linux-fsdevel+bounces-3897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E47F9A04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9932F1C20921
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E060FBEF;
	Mon, 27 Nov 2023 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vt7kL11J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369D5113;
	Sun, 26 Nov 2023 22:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DAXqvp1jxKr5GdoY4JDYJxBS5AksnO7Y0YFlaU0RtX8=; b=vt7kL11J4i2RFx8wiWuweYZcHq
	Bo5I8BpVHL/r3TyGCwKffJc385hRdud5YfVv2I7U9XS/PAm+INRTzPu4VQ9eaECOqoRZg4FIpIQby
	4cDnDz8ijakvjhZ4MqhQ/7i83Dfh9uwr7h0QYX21x4yoSLM2AjfRkRuXHfJ8Kox5b8EVwpurGeSsj
	nnX/16NeObj4JUNcqO3/IvskG8I1zXxvDqIb6+fysD2v9fLuD3V+jOO2AGxhGSpp5OXYiO5037EXl
	jbDi9a3Ix5K+s4GhjFYgwuz0HBcuF/1hR5JghiS8wCSO71mmD5QxOhtpcGbQXGlEiUHECCwsWUEWD
	KOW7FSAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7VGU-003qvs-2P;
	Mon, 27 Nov 2023 06:38:43 +0000
Date: Mon, 27 Nov 2023 06:38:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
Message-ID: <20231127063842.GG38156@ZenIV>
References: <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <87leangoqe.fsf@>
 <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV>
 <20231126184141.GF38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126184141.GF38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 26, 2023 at 06:41:41PM +0000, Al Viro wrote:

> d_invalidate() situation is more subtle - we need to sort out its interplay
> with d_splice_alias().
> 
> More concise variant of the scenario in question:
> * we have /mnt/foo/bar and a lot of its descendents in dcache on client
> * server does a rename, after which what used to be /mnt/foo/bar is /mnt/foo/baz
> * somebody on the client does a lookup of /mnt/foo/bar and gets told by
> the server that there's no directory with that name anymore.
> * that somebody hits d_invalidate(), unhashes /mnt/foo/bar and starts
> evicting its descendents
> * We try to mount something on /mnt/foo/baz/blah.  We look up baz, get
> an fhandle and notice that there's a directory inode for it (/mnt/foo/bar).
> d_splice_alias() picks the bugger and moves it to /mnt/foo/baz, rehashing
> it in process, as it ought to.  Then we find /mnt/foo/baz/blah in dcache and 
> mount on top of it.
> * d_invalidate() finishes shrink_dcache_parent() and starts hunting for
> submounts to dissolve.  And finds the mount we'd done.  Which mount quietly
> disappears.
> 
> Note that from the server POV the thing had been moved quite a while ago.
> No server-side races involved - all it seeem is a couple of LOOKUP in the
> same directory, one for the old name, one for the new.
> 
> On the client on the mounter side we have an uneventful mount on /mnt/foo/baz,
> which had been there on server at the time we started and which remains in
> place after mount we'd created suddenly disappears.
> 
> For the thread that ended up calling d_invalidate(), they'd been doing e.g.
> stat on a pathname that used to be there a while ago, but currently isn't.
> They get -ENOENT and no indication that something odd might have happened.
> 
> >From ->d_revalidate() point of view there's also nothing odd happening -
> dentry is not a mountpoint, it stays in place until we return and there's
> no directory entry with that name on in its parent.  It's as clear-cut
> as it gets - dentry is stale.
> 
> The only overlap happening there is d_splice_alias() hitting in the middle
> of already started d_invalidate().
> 
> For a while I thought that ff17fa561a04 "d_invalidate(): unhash immediately"
> and 3a8e3611e0ba "d_walk(): kill 'finish' callback" might have something
> to do with it, but the same problem existed prior to that.
> 
> FWIW, I suspect that the right answer would be along the lines of
> 	* if d_splice_alias() does move an exsiting (attached) alias in
> place, it ought to dissolve all mountpoints in subtree being moved.
> There might be subtleties, but in case when that __d_unalias() happens
> due to rename on server this is definitely the right thing to do.
> 	* d_invalidate() should *NOT* do anything with dentry that
> got moved (including moved by d_splice_alias()) from the place we'd
> found it in dcache.  At least d_invalidate() done due to having
> ->d_revalidate() return 0.
> 	* d_invalidate() should dissolve all mountpoints in the
> subtree that existed when it got started (and found the victim
> still unmoved, that is).  It should (as it does) prevent any
> new mountpoints added in that subtree, unless the mountpoint
> to be had been moved (spliced) out.  What it really shouldn't
> do is touch the mountpoints that are currently outside of it
> due to moves.
> 
> I'm going to look around and see if we have any weird cases where
> d_splice_alias() is used for things like "correct the case of
> dentry name on a case-mangled filesystem" - that would presumably
> not want to dissolve any submounts.  I seem to recall seeing
> some shite of that sort, but that was a long time ago.
> 
> Eric, Miklos - it might be a good idea if you at least took a
> look at whatever comes out of that (sub)thread; I'm trying to
> reconstruct the picture, but the last round of serious reworking
> of that area had been almost 10 years ago and your recollections
> of the considerations back then might help.  I realize that they
> are probably rather fragmentary (mine definitely are) and any
> analysis will need to be redone on the current tree, but...

TBH, I wonder if we ought to have d_invalidate() variant that would
unhash the dentry in question, do a variant of shrink_dcache_parent()
that would report if there had been any mountpoints and if there
had been any, do namespace_lock() and go hunting for mounts in that
subtree, moving corresponding struct mountpoint to a private list
as we go (removing them from mountpoint hash chains, that it).  Then
have them all evicted after we'd finished walking the subtree...

The tricky part will be lock ordering - right now we have the
mountpoint hash protected by mount_lock (same as mount hash, probably
worth splitting anyway) and that nests outside of ->d_lock.

Note that we don't do mountpoint hash lookups on mountpoint crossing
- it's nowhere near the really hot paths.  What we have is
	lookup_mountpoint() - plain hash lookup.  Always
under namespace_lock() and mount_lock.
	get_mountpoint() - there's an insertion into hash chain,
with dentry passed through the d_set_mounted(), which would
fail if we have d_invalidate() on the subtree.
Also always under namespace_lock() and mount_lock.
	__put_mountpoint() - removal from the hash chain.
We remove from hash chain after having cleared DCACHE_MOUNTED.
_That_ can happen under mount_lock alone (taking out the stuck
submounts on final mntput()).

So convert the mountpoint hash chains to hlist_bl, bitlocks nesting under
->d_lock.  Introduce a new dentry flag (DCHACE_MOUNT_INVALIDATION?)
In d_walk() callback we would
	* do nothing if DCACHE_MOUNT is not set or DCACHE_MOUNT_INVALIDATION
is.
	* otherwise set DCACHE_MOUNT_INVALIDATION, grab the bitlock on the
mountpoint hash chain matching that dentry, find struct mountpoint in it,
remove it from the chain and insert into a separate "collector" chain, all
without messing with refcount.
In lookup_mountpoint() and get_mountpoint() take the bitlock on chain.
In __put_mountpoint(), once it has grabbed ->d_lock
	* check if it has DCACHE_MOUNT_INVALIDATION, use that to
decide which chain we are locking - the normal one or the collector
	* clear both DCACHE_MOUNT and DCACHE_MOUNT_INVALIDATION
	* remove from chain
	* unlock the chain
	* drop ->d_lock.

Once we are finished walking the tree, go over the collector list
and do what __detach_mount() guts do.  We are no longer under
any ->d_lock, so locking is not a problem.  namespace_unlock() will
flush them all, same as it does for __detach_mount().

In __d_unalias() case do that d_invalidate() analogues of the alias.
Yes, it might do final mntput() of other filesystems, while under
->i_rwsem on our parent.  Not a problem, fs shutdown will go
either through task_work or schedule_delayed_work(); in any
case, it won't happen under ->i_rwsem.  We obviously can't do
that under rename_lock, though, so we'll need to massage that
path in d_splice_alias() a bit.

So, something like d_invalidate_locked(victim) called with
victim->d_lock held.  d_splice_alias() would use that (see above)
and places where we do d_invalidate() after ->d_revalidate() having
returned 0 would do this:
	lock dentry
	if it still has the same parent and name
		d_invalidate_locked()
	else
		unlock dentry
probably folded into fs/namei.c:d_revalidate()...  Not tonight,
though - I'd rather do that while properly awake ;-/

