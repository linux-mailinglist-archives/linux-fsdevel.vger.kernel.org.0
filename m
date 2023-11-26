Return-Path: <linux-fsdevel+bounces-3863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3647F94E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 19:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661721C20C37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511510A14;
	Sun, 26 Nov 2023 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HV//Ul+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B299E8;
	Sun, 26 Nov 2023 10:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SjbDkmPx2n6JHS7S/0Pm5UBLkdkT/hge08q6RFQNKe0=; b=HV//Ul+xzPA90R8NEL2txf0vbw
	Ni13I5DWfId03j1Sl/JmzbeMYNUxASAFoF3NsW5W1sRH0JfoUQO6Q5b2BQtdwb+T3gEmObsysMx5M
	rY6RX30yucyMrcvTjahz7MZewrgjTQz76FFAoi/4wOUV2DgI0dXevZ4UQwXZL2PBSmVQzfPLyMzgK
	RNXtAhvrT2WKFx4PHwzEPdAJteFz+XlbifTqWOaVfuhaCRhhEXeKR32C8ZN0t3+5804hk3xKeF0Y/
	ndYe/ymX9Lc0ebybI5KDmHi63hLm+hrhjzE2F0viydpx3/DezVGqtsT1jMsbfY8pJbzZ7zMUPfl6K
	lWKPq4FQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7K4b-003cjp-3A;
	Sun, 26 Nov 2023 18:41:42 +0000
Date: Sun, 26 Nov 2023 18:41:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
Message-ID: <20231126184141.GF38156@ZenIV>
References: <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <87leangoqe.fsf@>
 <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126045219.GD38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[folks involved into d_invalidate()/submount eviction stuff Cc'd]
On Sun, Nov 26, 2023 at 04:52:19AM +0000, Al Viro wrote:
> PS: as the matter of fact, it might be a good idea to pass the parent
> as explicit argument to ->d_revalidate(), now that we are passing the
> name as well.  Look at the boilerplate in the instances; all that
>         parent = READ_ONCE(dentry->d_parent);
> 	dir = d_inode_rcu(parent);
> 	if (!dir)
> 		return -ECHILD;
> 	...
> on the RCU side combined with
> 	parent = dget_parent(dentry);
> 	dir = d_inode(parent);
> 	...
> 	dput(dir);
> stuff.
> 
> It's needed only because the caller had not told us which directory
> is that thing supposed to be in; in non-RCU mode the parent is
> explicitly pinned down, no need to play those games.  All we need
> is
> 	dir = d_inode_rcu(parent);
> 	if (!dir) // could happen only in RCU mode
> 		return -ECHILD;
> assuming we need the parent inode, that is.
> 
> So... how about
> 	int (*d_revalidate)(struct dentry *dentry, struct dentry *parent,
> 			  const struct qstr *name, unsigned int flags);
> since we are touching all instances anyway?

OK, it's definitely a good idea for simplifying ->d_revalidate() instances
and I think we should go for it on thes grounds alone.  I'll do that.

d_invalidate() situation is more subtle - we need to sort out its interplay
with d_splice_alias().

More concise variant of the scenario in question:
* we have /mnt/foo/bar and a lot of its descendents in dcache on client
* server does a rename, after which what used to be /mnt/foo/bar is /mnt/foo/baz
* somebody on the client does a lookup of /mnt/foo/bar and gets told by
the server that there's no directory with that name anymore.
* that somebody hits d_invalidate(), unhashes /mnt/foo/bar and starts
evicting its descendents
* We try to mount something on /mnt/foo/baz/blah.  We look up baz, get
an fhandle and notice that there's a directory inode for it (/mnt/foo/bar).
d_splice_alias() picks the bugger and moves it to /mnt/foo/baz, rehashing
it in process, as it ought to.  Then we find /mnt/foo/baz/blah in dcache and 
mount on top of it.
* d_invalidate() finishes shrink_dcache_parent() and starts hunting for
submounts to dissolve.  And finds the mount we'd done.  Which mount quietly
disappears.

Note that from the server POV the thing had been moved quite a while ago.
No server-side races involved - all it seeem is a couple of LOOKUP in the
same directory, one for the old name, one for the new.

On the client on the mounter side we have an uneventful mount on /mnt/foo/baz,
which had been there on server at the time we started and which remains in
place after mount we'd created suddenly disappears.

For the thread that ended up calling d_invalidate(), they'd been doing e.g.
stat on a pathname that used to be there a while ago, but currently isn't.
They get -ENOENT and no indication that something odd might have happened.

From ->d_revalidate() point of view there's also nothing odd happening -
dentry is not a mountpoint, it stays in place until we return and there's
no directory entry with that name on in its parent.  It's as clear-cut
as it gets - dentry is stale.

The only overlap happening there is d_splice_alias() hitting in the middle
of already started d_invalidate().

For a while I thought that ff17fa561a04 "d_invalidate(): unhash immediately"
and 3a8e3611e0ba "d_walk(): kill 'finish' callback" might have something
to do with it, but the same problem existed prior to that.

FWIW, I suspect that the right answer would be along the lines of
	* if d_splice_alias() does move an exsiting (attached) alias in
place, it ought to dissolve all mountpoints in subtree being moved.
There might be subtleties, but in case when that __d_unalias() happens
due to rename on server this is definitely the right thing to do.
	* d_invalidate() should *NOT* do anything with dentry that
got moved (including moved by d_splice_alias()) from the place we'd
found it in dcache.  At least d_invalidate() done due to having
->d_revalidate() return 0.
	* d_invalidate() should dissolve all mountpoints in the
subtree that existed when it got started (and found the victim
still unmoved, that is).  It should (as it does) prevent any
new mountpoints added in that subtree, unless the mountpoint
to be had been moved (spliced) out.  What it really shouldn't
do is touch the mountpoints that are currently outside of it
due to moves.

I'm going to look around and see if we have any weird cases where
d_splice_alias() is used for things like "correct the case of
dentry name on a case-mangled filesystem" - that would presumably
not want to dissolve any submounts.  I seem to recall seeing
some shite of that sort, but that was a long time ago.

Eric, Miklos - it might be a good idea if you at least took a
look at whatever comes out of that (sub)thread; I'm trying to
reconstruct the picture, but the last round of serious reworking
of that area had been almost 10 years ago and your recollections
of the considerations back then might help.  I realize that they
are probably rather fragmentary (mine definitely are) and any
analysis will need to be redone on the current tree, but...

