Return-Path: <linux-fsdevel+bounces-38805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F30A08712
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F9F188C023
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 05:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C942066D9;
	Fri, 10 Jan 2025 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wk+dHY8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC508347C7;
	Fri, 10 Jan 2025 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488407; cv=none; b=YJsxCtEuDew2wPOQDINa0uffwrm7xv3pH4eBvu4HPyAUNgGtghSXKEZ+NcpJBFwIVslGy+g5Bhram0u9iwt0XQdN6CE7W0bbgVB4WOIr1xZ8mQJJP/EGBs2RPEGcjGiG+Pl0Gg7Mk0gx+9D6iOHssrfIE+IyPCWU3fTr6tUVPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488407; c=relaxed/simple;
	bh=MQWrL4mI3FHsNxpP9mVShaq2xyibwQTmuRqGRPyDMUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5Ik3qa20ADqwzFFDu1YRTspyccbUHT8GQbPhoVPOLZ9DecUPrFJSXNSxILpdu877kiSTjPJGrmTMxgk03aB2shWhWGrdYziojKVa1OR8jUR6lzk2vFMaFEVjO4zpWM67Bx0UcKI2uCMKsJh5xpJWUBRNRCBu0RuiVYSFpH5JJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wk+dHY8N; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qXOr4LObb1DfxFpbCrHN4maUfTaww1DRKC318O1rvmE=; b=wk+dHY8NaMUI6hIOiLtMeDPF+4
	OqanGe1ijg+8ND/9aTSPYUI4N4hj1izBBzhmmzbgdMBvSFbXcCBcyetJDj/Eh+k7Ou3MdwbhTOHhE
	9EDA0x1flrXWTFiJf7NAyTqFZkxqcpUeuhT4SRUfJORXHwrEBCSVqI3S0Pqxif9pn5W6tFwcSIN+G
	xaFIKJQzzgG7yBc7X+cMb3PXqyx1+/a4Wo/prKRDvKcYrVsr9Z4byG6kPk+rjfiEEm/0BwZ4uNF2j
	al6hv7qD5qqTRc4O7NWRAiXTaMQOBeJ9xx9lLyWSUJNNkpXZg7QEq2OsJySzmnjFdophinmxOoHCR
	8u89M/pg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW7xR-0000000HUJs-30lr;
	Fri, 10 Jan 2025 05:53:21 +0000
Date: Fri, 10 Jan 2025 05:53:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com,
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com,
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org,
	linux-nfs@vger.kernel.org, miklos@szeredi.hu
Subject: Re: [PATCH 20/20] 9p: fix ->rename_sem exclusion
Message-ID: <20250110055321.GU1977892@ZenIV>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-20-viro@zeniv.linux.org.uk>
 <CAHk-=wh2i3j3GUYpiTBteS7Ln02endudZCqc9DRz==3p8T__yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2i3j3GUYpiTBteS7Ln02endudZCqc9DRz==3p8T__yQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 09, 2025 at 07:11:46PM -0800, Linus Torvalds wrote:
> On Thu, 9 Jan 2025 at 18:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > However, to reduce dentry_operations bloat, let's add one method instead -
> > ->d_want_unalias(alias, true) instead of ->d_unalias_trylock(alias) and
> > ->d_want_unalias(alias, false) instead of ->d_unalias_unlock(alias).
> 
> Ugh.
> 
> So of all the patches, this is the one that I hate.
> 
> I absolutely detest interfaces with random true/false arguments, and
> when it is about locking, the "detest" becomes something even darker
> and more visceral.
> 
> I think it would be a lot better as separate ops, considering that
> 
>  (a) we'll probably have only one or two actual users, so it's not
> like it complicates things on that side
> 
>  (b) we don't have *that* many "struct dentry_operations" structures:
> I think they are all statically generated constant structures
> (typically one or two per filesystem), so it's not like we're saving
> memory by merging those pointers into one.

ACK.

> Please?

Done and force-pushed; see below for updated variant of that commit

commit 1f28d77e868e63a07ab50e7fe161fc366b2fb23b
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jan 5 21:33:17 2025 -0500

    9p: fix ->rename_sem exclusion
    
    9p wants to be able to build a path from given dentry to fs root and keep
    it valid over a blocking operation.
    
    ->s_vfs_rename_mutex would be a natural candidate, but there are places
    where we need that and where we have no way to tell if ->s_vfs_rename_mutex
    is already held deeper in callchain.  Moreover, it's only held for
    cross-directory renames; name changes within the same directory happen
    without it.
    
    Solution:
            * have d_move() done in ->rename() rather than in its caller
            * maintain a 9p-private rwsem (per-filesystem)
            * hold it exclusive over the relevant part of ->rename()
            * hold it shared over the places where we want the path.
    
    That almost works.  FS_RENAME_DOES_D_MOVE is enough to put all d_move()
    and d_exchange() calls under filesystem's control.  However, there's
    also __d_unalias(), which isn't covered by any of that.
    
    If ->lookup() hits a directory inode with preexisting dentry elsewhere
    (due to e.g. rename done on server behind our back), d_splice_alias()
    called by ->lookup() will move/rename that alias.
    
    Add a couple of optional methods, so that __d_unalias() would do
            if alias->d_op->d_unalias_trylock != NULL
                    if (!alias->d_op->d_unalias_trylock(alias))
                            fail (resulting in -ESTALE from lookup)
            __d_move(...)
            if alias->d_op->d_unalias_unlock != NULL
                    alias->d_unalias_unlock(alias)
    where it currently does __d_move().  9p instances do down_write_trylock()
    and up_write() of ->rename_mutex.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 146e7d8aa736..d20a32b77b60 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -31,6 +31,8 @@ prototypes::
 	struct vfsmount *(*d_automount)(struct path *path);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
+	bool (*d_unalias_trylock)(const struct dentry *);
+	void (*d_unalias_unlock)(const struct dentry *);
 
 locking rules:
 
@@ -50,6 +52,8 @@ d_dname:	   no		no		no		no
 d_automount:	   no		no		yes		no
 d_manage:	   no		no		yes (ref-walk)	maybe
 d_real		   no		no		yes 		no
+d_unalias_trylock  yes		no		no 		no
+d_unalias_unlock   yes		no		no 		no
 ================== ===========	========	==============	========
 
 inode_operations
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7c352ebaae98..31eea688609a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1265,6 +1265,8 @@ defined:
 		struct vfsmount *(*d_automount)(struct path *);
 		int (*d_manage)(const struct path *, bool);
 		struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
+		bool (*d_unalias_trylock)(const struct dentry *);
+		void (*d_unalias_unlock)(const struct dentry *);
 	};
 
 ``d_revalidate``
@@ -1428,6 +1430,25 @@ defined:
 
 	For non-regular files, the 'dentry' argument is returned.
 
+``d_unalias_trylock``
+	if present, will be called by d_splice_alias() before moving a
+	preexisting attached alias.  Returning false prevents __d_move(),
+	making d_splice_alias() fail with -ESTALE.
+
+	Rationale: setting FS_RENAME_DOES_D_MOVE will prevent d_move()
+	and d_exchange() calls from the outside of filesystem methods;
+	however, it does not guarantee that attached dentries won't
+	be renamed or moved by d_splice_alias() finding a preexisting
+	alias for a directory inode.  Normally we would not care;
+	however, something that wants to stabilize the entire path to
+	root over a blocking operation might need that.  See 9p for one
+	(and hopefully only) example.
+
+``d_unalias_unlock``
+	should be paired with ``d_unalias_trylock``; that one is called after
+	__d_move() call in __d_unalias().
+
+
 Each dentry has a pointer to its parent dentry, as well as a hash list
 of child dentries.  Child dentries are basically like files in a
 directory.
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 698c43dd5dc8..f28bc763847a 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -202,7 +202,7 @@ static inline struct v9fs_session_info *v9fs_inode2v9ses(struct inode *inode)
 	return inode->i_sb->s_fs_info;
 }
 
-static inline struct v9fs_session_info *v9fs_dentry2v9ses(struct dentry *dentry)
+static inline struct v9fs_session_info *v9fs_dentry2v9ses(const struct dentry *dentry)
 {
 	return dentry->d_sb->s_fs_info;
 }
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 872c1abe3295..5061f192eafd 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -105,14 +105,30 @@ static int v9fs_lookup_revalidate(struct inode *dir, const struct qstr *name,
 	return __v9fs_lookup_revalidate(dentry, flags);
 }
 
+static bool v9fs_dentry_unalias_trylock(const struct dentry *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	return down_write_trylock(&v9ses->rename_sem);
+}
+
+static void v9fs_dentry_unalias_unlock(const struct dentry *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	up_write(&v9ses->rename_sem);
+}
+
 const struct dentry_operations v9fs_cached_dentry_operations = {
 	.d_revalidate = v9fs_lookup_revalidate,
 	.d_weak_revalidate = __v9fs_lookup_revalidate,
 	.d_delete = v9fs_cached_dentry_delete,
 	.d_release = v9fs_dentry_release,
+	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
+	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
 };
 
 const struct dentry_operations v9fs_dentry_operations = {
 	.d_delete = always_delete_dentry,
 	.d_release = v9fs_dentry_release,
+	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
+	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
 };
diff --git a/fs/dcache.c b/fs/dcache.c
index 7d42ca367522..2ac614fc8bba 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2961,7 +2961,12 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 		goto out_err;
 	m2 = &alias->d_parent->d_inode->i_rwsem;
 out_unalias:
+	if (alias->d_op->d_unalias_trylock &&
+	    !alias->d_op->d_unalias_trylock(alias))
+		goto out_err;
 	__d_move(alias, dentry, false);
+	if (alias->d_op->d_unalias_unlock)
+		alias->d_op->d_unalias_unlock(alias);
 	ret = 0;
 out_err:
 	if (m2)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4a6bdadf2f29..9a1a30857763 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -159,6 +159,8 @@ struct dentry_operations {
 	struct vfsmount *(*d_automount)(struct path *);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
+	bool (*d_unalias_trylock)(const struct dentry *);
+	void (*d_unalias_unlock)(const struct dentry *);
 } ____cacheline_aligned;
 
 /*

