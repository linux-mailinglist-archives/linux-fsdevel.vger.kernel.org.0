Return-Path: <linux-fsdevel+bounces-3834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54B7F9157
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 05:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910251C20BC6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 04:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A003C35;
	Sun, 26 Nov 2023 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S54ui+DO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBAEC0;
	Sat, 25 Nov 2023 20:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0vkgmaq6RmcZqYJwqKvepDQztGNPwS4niJIinKsWt9o=; b=S54ui+DOGekM61RUXRboSVJ4Bb
	OpdDLrZu66DsjpksmmfB3bxsDHDvWBNolmFA1AjSfeBy/Dt5aFxcSlQfJ0T0B0uVXM9tgsIkoCc7l
	Ylrkpw8tqQYnLs3f131BcxweTc7YMwQ+OviFmejF6pNzIENK0EnDEFQlBk4kQ6zi9qEHsQ+akZumQ
	mJvy1/wm8Z+U4fToImpscGsR2mRBLId99V9RIbc1S6VYtwe3z6/dIZ9S0LfIcB8/QkBf+1k6KQtHK
	yHjzX+BUNfu6TKoMLnbs1scMXqDFj9iIbxEVGbhnS50V/GTya8hPDBlr9fvAZdlkvQ0mG5HbHj07x
	tu0PVNBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r777z-003L4j-37;
	Sun, 26 Nov 2023 04:52:20 +0000
Date: Sun, 26 Nov 2023 04:52:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231126045219.GD38156@ZenIV>
References: <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <87leangoqe.fsf@>
 <20231125220136.GB38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125220136.GB38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 25, 2023 at 10:01:36PM +0000, Al Viro wrote:
> On Fri, Nov 24, 2023 at 10:22:49AM -0500, Gabriel Krisman Bertazi wrote:
> 
> > ack. I'll base the other changes we discussed on top of your branch.
> 
> Rebased to v6.7-rc1, fixed up (ceph calls fscrypt_d_revalidate() directly,
> and D/f/porting entry had been missing), pushed out as #no-rebase-d_revalidate

FWIW, ->d_revalidate() has an old unpleasant problem we might try to solve
now.

In non-RCU mode We treat 0 as "invalidate that sucker and do a fresh lookup".
Fine, except that there's a possibility of race here - we'd hit ->d_revalidate()
while another thread was renaming object in question.  Or has just found it
by doing lookup in a place where it had been moved on server.

->d_revalidate() decides that it needs to be looked up on server and forms
a request before rename succeeds.  So NFS (e.g.) request goes out with the
old parent and name.  By the time server sees it, RENAME has been processed
and succeeded.  There's no such file in the old place anymore.

So ->d_revalidate() returns 0... and we proceed to invalidate the dentry.
Which had been moved to *new* place by now.  In that place it's perfectly
valid and does not deserve invalidation.

Scenario when rename had been done not from this client is even worse:

server:/srv/nfs/foo is mounted on /mnt/foo
we state /mnt/foo/bar
/mnt/foo/bar is in dcache
somebody on server renames /srv/nfs/foo/bar to /srv/nfs/foo/barf
process A: stat /mnt/foo/bar/baz.
process B: mount something on /mnt/foo/barf/
process B: no /mnt/foo/barf in dcache, let's look it up
	   found fhandle of /mnt/foo
	   sent LOOKUP "barf" in it
	   got an fhandle and found it matching the inode of /mnt/foo/bar
process A: has reached /mnt/foo/bar and decided to revalidate it.
	   found fhandle of /mnt/foo
	   sent a LOOKUP "bar" in that
	   got "nothing with that name there"
	   ->d_revalidate() returns 0
	   loses CPU
process B: splice the dentry of /mnt/foo/bar to /mnt/foo/barf
	   proceed to mount on top of it
process A: gets CPU back
	   calls d_invalidate() on the dentry that now is /mnt/foo/barf
	   dissolves the mount created by process B

Note that server:/srv/nfs/foo/barf has been there and perfectly valid
since before B has started doing anything.  It has no idea that the
damn thing used to be in a different place and something on the same
client had seen it at the old place once upon a time.  As far as it is
concerned, mount has succeeded and then quietly disappeared.  The mountpoint
is still there - with freshly looked up dentry, since the old one had been
invalidated, but userland doesn't see that, so... WTF?

It's not easy to hit, but I'd expect it to be feasible on SMP KVM, where instead
of A losing CPU we might've had the virtual CPU losing the timeslice on host.

IMO we should only do d_invalidate() if
	* ->d_revalidate() has returned 0
	* dentry is still hashed, still has the same parent and still matches
the name from ->d_compare() POV.
If it doesn't, we should just leave it whereever it has been moved to and
act as if we hadn't seen it in the first place.

In other words, have
d_revalidate(dentry, parent, name, flags) doing the following:
	if no ->d_revalidate
		return 1
	ret = ->d_revalidate(...)
	if (unlikely(ret == 0) && !(flags & LOOKUP_RCU)) {
		spin_lock(&dentry->d_lock);
		if (!d_same_name(dentry, parent, name))
			spin_lock(&dentry->d_lock);
		else
			d_invalidate_locked(dentry);
	}
	return ret

where d_invalidate_locked() would be d_invalidate() sans the initial
spin_lock(&dentry->d_lock);

That would solve that problem, AFAICS.  Objections, anyone?  I'm too
sleepy to put together a patch at the moment, will post after I get
some sleep...

PS: as the matter of fact, it might be a good idea to pass the parent
as explicit argument to ->d_revalidate(), now that we are passing the
name as well.  Look at the boilerplate in the instances; all that
        parent = READ_ONCE(dentry->d_parent);
	dir = d_inode_rcu(parent);
	if (!dir)
		return -ECHILD;
	...
on the RCU side combined with
	parent = dget_parent(dentry);
	dir = d_inode(parent);
	...
	dput(dir);
stuff.

It's needed only because the caller had not told us which directory
is that thing supposed to be in; in non-RCU mode the parent is
explicitly pinned down, no need to play those games.  All we need
is
	dir = d_inode_rcu(parent);
	if (!dir) // could happen only in RCU mode
		return -ECHILD;
assuming we need the parent inode, that is.

So... how about
	int (*d_revalidate)(struct dentry *dentry, struct dentry *parent,
			  const struct qstr *name, unsigned int flags);
since we are touching all instances anyway?

