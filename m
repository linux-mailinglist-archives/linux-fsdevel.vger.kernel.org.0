Return-Path: <linux-fsdevel+bounces-41303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBD4A2D99D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 00:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0989E166114
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 23:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2A13D28F;
	Sat,  8 Feb 2025 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OIoK96+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EE2243385;
	Sat,  8 Feb 2025 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739056704; cv=none; b=utBR0d4HV+B8fjw1akd8gXu0JWY5e2X+if1e6ldK+ibQjLAiHpvL5L3Updx4O/AI/pZtFLtP/3tdL0G53LwR0qpH6/ZvBBI3BrYGdmnNVQ54E3Jo4fpgFFkOiRB+gEKT1bd0KA/KYAM6VjKZJSlD6Pwi2yEFRowUn40Rc5o1TKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739056704; c=relaxed/simple;
	bh=k2KSyPkGepwheBwVWUi0wTo4TnPkA6wfYpQHzJErXkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7Rb0oMesySnE37rD3VSiFiJAJXQUuupBveN8ydtASz3ro24XARbwKh0G5W9cC9ndM73a0vbyhZkCoNo2okVoCA7yQQlx7LSTDUCo0mYiyMfgVFrApRHPk/FOhCv4bCqXPRFxhFpmcBxMzkjt2bMSl21T8UuB8B9DCGwV0Wj05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OIoK96+j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l+662iGsoypQZ+YZiaQg3l5f43ZUU/yKVAnTerPQ3yA=; b=OIoK96+jcxaIdkX9OzxRq4aOQN
	JX9Nuzb5SykA/kELSkxxraCp8JhGaVHcIAIukjZjCW8QIpNjpysCCIFkKFOO0n/sNRdxshojacJ3h
	NrkqZ9u0+HePQV7iW3v/hiWfbyTyWNKT4cNkpePkjmE8zOVpInwTUrQy6CQKAcD81xxZtYXDcW+7A
	g9Rjuob3HGgr+2OZGF8v8rK430HrwnJkpysnX0sfFDscslYqoJwNvxrkWxzPR+IFYIyFVxbcNg6zK
	fjPaVl+y0RMtFOaOAv6h4leDbaipZS9TOseiUomBaRPRq/0IODBSRbhDzpg9jfLjlQ1BBs9GVdltC
	A/EQz8CA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgu5b-00000007uKr-0hlk;
	Sat, 08 Feb 2025 23:18:19 +0000
Date: Sat, 8 Feb 2025 23:18:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
Message-ID: <20250208231819.GR1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-9-neilb@suse.de>
 <20250207202235.GH1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207202235.GH1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 07, 2025 at 08:22:35PM +0000, Al Viro wrote:
> On Thu, Feb 06, 2025 at 04:42:45PM +1100, NeilBrown wrote:
> > lookup_and_lock() combines locking the directory and performing a lookup
> > prior to a change to the directory.
> > Abstracting this prepares for changing the locking requirements.
> > 
> > done_lookup_and_lock() provides the inverse of putting the dentry and
> > unlocking.
> > 
> > For "silly_rename" we will need to lookup_and_lock() in a directory that
> > is already locked.  For this purpose we add LOOKUP_PARENT_LOCKED.
> 
> Ewww...  I do realize that such things might appear in intermediate
> stages of locking massage, but they'd better be _GONE_ by the end of it.
> Conditional locking of that sort is really asking for trouble.
> 
> If nothing else, better split the function in two variants and document
> the differences; that kind of stuff really does not belong in arguments.
> If you need it to exist through the series, that is - if not, you should
> just leave lookup_one_qstr() for the "locked" case from the very beginning.

The same, BTW, applies to more than LOOKUP_PARENT_LOCKED part.

One general observation: if the locking behaviour of a function depends
upon the flags passed to it, it's going to cause massive headache afterwards.

If you need to bother with data flow analysis to tell what given call will
do, expect trouble.

If anything, I would rather have separate lookup_for_removal(), etc., each
with its locking effects explicitly spelled out.  Incidentally, looking
through that I would say that your "VFS: filename_create(): fix incorrect
intent" is not the right solution.  If we hit that condition (no LOOKUP_DIRECTORY
and last component ending with slash), we are going to fail anyway, the only
question is which error to return.  Rules:
	* if the last component lookup fails, return the error from lookup
	* if it yields positive, return -EEXIST
	* if it yields negative, return -ENOENT
Correct?  So how about this:

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

