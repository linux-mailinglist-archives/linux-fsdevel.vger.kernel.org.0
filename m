Return-Path: <linux-fsdevel+bounces-41558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDF5A31CB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 04:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9443A72AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 03:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6FA1DD9AB;
	Wed, 12 Feb 2025 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YXMLl4GY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE01D9A54;
	Wed, 12 Feb 2025 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330713; cv=none; b=k9BLxILL0sTWhLsq7biOSt0cglTJoVoG51pqxG0Scnl/iO7FJCMeL+cfJ54dJ6lG08dx6GhaIuvOPkhjxEWQL+8SPkzy4p0RGNZjPioypJObcmwQjriNuPpJn2Jx1JqbXrRlydGVv62b/lUoobdDLak/0YMcOYZ/DDU5R/B1jDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330713; c=relaxed/simple;
	bh=oBqFxJ/IScaPEd2V9emiVuW0ODEwBamFQjsLuYJ82sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvC5e4RQxgGAbIGOQOC1cUPtsz9RdHF1nZn9O2hmTvn8t+2YOu0+YjrQRR5i42QmcU5UHSIRWmQsr/31ZR/cWn6siNZ5ZmOp/gfZ88i9qjCIDNKg8OXff4ONyw/IpmwfPFlm3WbZoW/GD0WGOpcgHJ4oxFeRDHQGePed61oNzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YXMLl4GY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lLC7AFgOunmEewG7K+OmZfWPFiFshg2hwlmHaIvQ1KM=; b=YXMLl4GYYmSnSLBYjvMyCwPLOG
	AAR4acYkWYRE1AgGUpIcxpd4O3qZ1HDLAJKbprWMgvhZVQK73DQgqcS1IzVwEjGOXNmF72XkvSbkr
	nW1TPrs9SzqcMeX2RP4Nbk9oZ55oIh58TjA6Y2DYcSu+Rs5rLRqiDZqkC9kwCyF+53BnCVXFmaKcs
	E/7EVLGZHB05iqqd94c1Kz+DWtPBr6NWUCnu19xFKJZJPR/LRbub5hMy7gvi06OYvYCMKETd+BwbP
	ClUmbqPbP0ZbSuMPEqDCiz8wPiqK3i0rQtNdBEUFtcDLXZDsKhroME5ooCbqK6x5hh39djPTPCUeJ
	aMGveBag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ti3N3-0000000BCxt-0jik;
	Wed, 12 Feb 2025 03:25:05 +0000
Date: Wed, 12 Feb 2025 03:25:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	audit@vger.kernel.org
Subject: Re: [PATCH 2/2] VFS: add common error checks to
 lookup_one_qstr_excl()
Message-ID: <20250212032505.GM1977892@ZenIV>
References: <20250207034040.3402438-1-neilb@suse.de>
 <20250207034040.3402438-3-neilb@suse.de>
 <20250212031608.GL1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212031608.GL1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 12, 2025 at 03:16:08AM +0000, Al Viro wrote:
> On Fri, Feb 07, 2025 at 02:36:48PM +1100, NeilBrown wrote:
> > @@ -1690,6 +1692,15 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
> >  		dput(dentry);
> >  		dentry = old;
> >  	}
> > +found:
> 
> ... and if ->lookup() returns an error, this will blow up (as bot has just
> reported).
> 
> > +	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
> > +		dput(dentry);
> > +		return ERR_PTR(-ENOENT);
> > +	}
> > +	if (d_is_positive(dentry) && (flags & LOOKUP_EXCL)) {
> > +		dput(dentry);
> > +		return ERR_PTR(-EEXIST);
> > +	}
> 
> 
> > @@ -4077,27 +4084,13 @@ static struct dentry *filename_create(int dfd, struct filename *name,
> >  	 * '/', and a directory wasn't requested.
> >  	 */
> >  	if (last.name[last.len] && !want_dir)
> > -		create_flags = 0;
> > +		create_flags &= ~LOOKUP_CREATE;
> 
> See the patch I've posted in earlier thread; the entire "strip LOOKUP_CREATE"
> thing is wrong.

On top of mainline that's

filename_create(): don't force handling trailing slashes into the common path

Only mkdir accepts pathnames that end with / - anything like mknod() (symlink(),
etc.) always fails on those.  Don't try to force that the common codepath -
all we are doing is a lookup and check for existence to determine which
error should it be.  Do that before bothering with mnt_want_write(), etc.;
as far as underlying filesystem is concerned it's just a lookup.  Simplifies
the normal codepath and kills the lookup intent dependency on more than
the call site.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namei.c b/fs/namei.c
index 3ab9440c5b93..6189e54f767a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4054,13 +4054,13 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	struct dentry *dentry = ERR_PTR(-EEXIST);
 	struct qstr last;
 	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
-	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
-	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
 	int err2;
 	int error;
 
-	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
+	lookup_flags &= LOOKUP_REVAL;
+
+	error = filename_parentat(dfd, name, lookup_flags, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
 
@@ -4070,18 +4070,28 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 */
 	if (unlikely(type != LAST_NORM))
 		goto out;
+	/*
+	 * mkdir foo/bar/ is OK, but for anything else a slash in the end
+	 * is always an error; the only question is which one.
+	 */
+	if (unlikely(last.name[last.len] && !want_dir)) {
+		dentry = lookup_dcache(&last, path->dentry, lookup_flags);
+		if (!dentry)
+			dentry = lookup_slow(&last, path->dentry, lookup_flags);
+		if (!IS_ERR(dentry)) {
+			error = d_is_positive(dentry) ? -EEXIST : -ENOENT;
+			dput(dentry);
+			dentry = ERR_PTR(error);
+		}
+		goto out;
+	}
 
 	/* don't fail immediately if it's r/o, at least try to report other errors */
 	err2 = mnt_want_write(path->mnt);
-	/*
-	 * Do the final lookup.  Suppress 'create' if there is a trailing
-	 * '/', and a directory wasn't requested.
-	 */
-	if (last.name[last.len] && !want_dir)
-		create_flags = 0;
+	/* do the final lookup */
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	dentry = lookup_one_qstr_excl(&last, path->dentry,
-				      reval_flag | create_flags);
+				lookup_flags | LOOKUP_CREATE | LOOKUP_EXCL);
 	if (IS_ERR(dentry))
 		goto unlock;
 
@@ -4089,16 +4099,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	if (d_is_positive(dentry))
 		goto fail;
 
-	/*
-	 * Special case - lookup gave negative, but... we had foo/bar/
-	 * From the vfs_mknod() POV we just have a negative dentry -
-	 * all is fine. Let's be bastards - you had / on the end, you've
-	 * been asking for (non-existent) directory. -ENOENT for you.
-	 */
-	if (unlikely(!create_flags)) {
-		error = -ENOENT;
-		goto fail;
-	}
 	if (unlikely(err2)) {
 		error = err2;
 		goto fail;

