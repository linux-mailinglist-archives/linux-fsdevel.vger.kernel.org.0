Return-Path: <linux-fsdevel+bounces-46879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04827A95C8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 05:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B056A1897F2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 03:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261CC19DF66;
	Tue, 22 Apr 2025 03:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Jt8s7PoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E88635C
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291693; cv=none; b=hSaQIBk48nmelUy/cqueJFJR3XqSyknHv60gh1V/erl5khbQJDm4iTgEDjdSINOXaCweS1SPwi5h5Aspsq/alQt1AuLxpye9U8WwIvee2cl/5eSGMicWYXZRp5r1mVEa33zIoKyvVn77p5aOfsM4TM04nhBDqNGX0CyhSBJzpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291693; c=relaxed/simple;
	bh=zBxzd90gpN4sN0wOGGrYWVWgU90IvoHNml2GIzqKy3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6kKGy8QN5OQTfybt5OkrSp+LkVF0J98nwVnjXwKuM5kN1+cd34o6V3iVTrQZbl+mnkXk3sKKW5ISmJVwlQ433zPX0EY+WTtjbscasdmH2n68LDcL9ownYHhyNMZ/osnCY9Ta9I3LqKkrfViB++PWL6Z8i1vvE9yuVoC4SWf34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Jt8s7PoW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tqbsd12eKjn6xC/9RVTFNWfCwtFqI806Xl7DDC8dDfo=; b=Jt8s7PoWtyyE7UyyJOWpmuHs6O
	BOEMlblhyWZmUHNi1pJ5yxALaJpLqvNvo70g2OohsIVZXPf3ZsrSMQgfyK4ne051PMg6WiAegoced
	RFsJwBnYXb5E3NoZmDGiPa9fU6vMEetZZijkEedFFrRlgVNIf9tYoQJdTsWPBiMHcwgXdNhs1xSxO
	MLnIY6oCi63MTQFzOuP6wancGvctM8b7sSwgoRW7LYMG5TSjROOOm0lVHYAIadFEQJZzN9AkbcRH+
	NgtZKnj3SZ5WehEJcbiQLb8RF/da6bsEVKa8jM5xsUIvF131TwDJsGrLtstz+OhSABaSmv7hpKJxO
	iAx1G+Mg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u745w-000000049Ac-0ITR;
	Tue, 22 Apr 2025 03:14:48 +0000
Date: Tue, 22 Apr 2025 04:14:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH][RFC] do_lock_mount() races in 'beneath' case
Message-ID: <20250422031448.GY2023217@ZenIV>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
 <20250421170319.GX2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421170319.GX2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 21, 2025 at 06:03:19PM +0100, Al Viro wrote:
> On Mon, Apr 21, 2025 at 05:29:47PM +0100, Al Viro wrote:
> 
> > What's to prevent the 'beneath' case from getting mnt mount --move'd
> > away *AND* the ex-parent from getting unmounted while we are blocked
> > in inode_lock?  At this point we are not holding any locks whatsoever
> > (and all mount-related locks nest inside inode_lock(), so we couldn't
> > hold them there anyway).
> > 
> > Hit that race and watch a very unhappy umount...
> 
> While we are at it, in normal case inode_unlock() in unlock_mount()
> is safe since we have dentry (and associated mount) pinned by
> struct path we'd fed to matching lock_mount().  No longer true for
> the 'beneath' case, AFAICS...

Completely untested patch follows; 'beneath' case in do_lock_mount() is made
to grab mount reference to match the dentry one (same lifetime; dropped
simultaneously), unlock_mount() unlocks the inode *before* namespace_unlock(),
so we don't depend upon the externally held references.

Comments?

diff --git a/fs/namespace.c b/fs/namespace.c
index fa17762268f5..91d28f283f1c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2827,56 +2827,62 @@ static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
 	struct vfsmount *mnt = path->mnt;
 	struct dentry *dentry;
 	struct mountpoint *mp = ERR_PTR(-ENOENT);
+	struct path under = {};
 
 	for (;;) {
-		struct mount *m;
+		struct mount *m = real_mount(mnt);
 
 		if (beneath) {
-			m = real_mount(mnt);
+			path_put(&under);
 			read_seqlock_excl(&mount_lock);
-			dentry = dget(m->mnt_mountpoint);
+			under.mnt = mntget(&m->mnt_parent->mnt);
+			under.dentry = dget(m->mnt_mountpoint);
 			read_sequnlock_excl(&mount_lock);
+			dentry = under.dentry;
 		} else {
 			dentry = path->dentry;
 		}
 
 		inode_lock(dentry->d_inode);
-		if (unlikely(cant_mount(dentry))) {
-			inode_unlock(dentry->d_inode);
-			goto out;
-		}
-
 		namespace_lock();
 
-		if (beneath && (!is_mounted(mnt) || m->mnt_mountpoint != dentry)) {
+		if (unlikely(cant_mount(dentry) || !is_mounted(mnt)))
+			break;		// not to be mounted on
+
+		if (beneath && unlikely(m->mnt_mountpoint != dentry ||
+				        &m->mnt_parent->mnt != under.mnt)) {
 			namespace_unlock();
 			inode_unlock(dentry->d_inode);
-			goto out;
+			continue;	// got moved
 		}
 
 		mnt = lookup_mnt(path);
-		if (likely(!mnt))
+		if (unlikely(mnt)) {
+			namespace_unlock();
+			inode_unlock(dentry->d_inode);
+			path_put(path);
+			path->mnt = mnt;
+			path->dentry = dget(mnt->mnt_root);
+			continue;	// got overmounted
+		}
+		mp = get_mountpoint(dentry);
+		if (IS_ERR(mp))
 			break;
-
-		namespace_unlock();
-		inode_unlock(dentry->d_inode);
-		if (beneath)
-			dput(dentry);
-		path_put(path);
-		path->mnt = mnt;
-		path->dentry = dget(mnt->mnt_root);
-	}
-
-	mp = get_mountpoint(dentry);
-	if (IS_ERR(mp)) {
-		namespace_unlock();
-		inode_unlock(dentry->d_inode);
+		if (beneath) {
+			/*
+			 * @under duplicates the references that will stay
+			 * at least until namespace_unlock(), so the path_put()
+			 * below is safe (and OK to do under namespace_lock -
+			 * we are not dropping the final references here).
+			 */
+			path_put(&under);
+		}
+		return mp;
 	}
-
-out:
+	namespace_unlock();
+	inode_unlock(dentry->d_inode);
 	if (beneath)
-		dput(dentry);
-
+		path_put(&under);
 	return mp;
 }
 
@@ -2892,9 +2898,9 @@ static void unlock_mount(struct mountpoint *where)
 	read_seqlock_excl(&mount_lock);
 	put_mountpoint(where);
 	read_sequnlock_excl(&mount_lock);
+	inode_unlock(dentry->d_inode);
 
 	namespace_unlock();
-	inode_unlock(dentry->d_inode);
 }
 
 static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)

