Return-Path: <linux-fsdevel+bounces-60995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB18B5422A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 07:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC335840EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 05:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1084270EA5;
	Fri, 12 Sep 2025 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P91kpdmK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8571A38F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757656152; cv=none; b=VR9u7z6FQO8Zk+ezHl0aW2Pr3yfbrwJgirzdloyOJU1e65gwcvF2TqVanOkVouGeFKF0cnvHpbMf6qdDKNSCOhCXGjJRb+U2q5Cbr8YYFGGorwtsvUtNVWpto+rlm5+4mbqSKCZcLiAhAK5bS2NT/W0CVHqJ/Z2ATxnKdPwUcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757656152; c=relaxed/simple;
	bh=uYa3/TkBBxQmyty/eFQSeELGaVqAPBrvzm5Apn3itmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY4bvX+9zMkZvCJTahqBZPB/Cr5VPIhtiTd2yBX2L5M5dh3thKTggSog95x6wNmxHPJI7V5s0iYL5R2qSKXl60RoTSOn6JfKkCEWusy/LMa6ZtUlch4FbKTmbESDs99oHmJuswb3AV1Qap94Rzk0kP03FBiitPDIaygygTjvBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P91kpdmK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r7P7ml8IsmyOHXUohK+1pKy9CRgoauQTsJsmLq+yBiM=; b=P91kpdmKdF/4nhzYD12T9mmXhI
	7riVuHdgi4GzV3tcl3vmDa0OZg12diYs+uJGNi6MJQaSBrPtijI/UT+07Qeato8+Ob9ELxB0C4mak
	dkjeFdlZp48zmKv6cKvqIM2OjId8ZNVQEV2CXiUqQu0ZxVLRSvUDG9uLn95oO8J2jGgqsCFNYg99M
	2VntEiEHx6ewMSYB4LaTEuAe0SEXN93iDr73HBHeq6KG/CV7+PvPDdLyBXM5ef2bmRkQPckTL3Ck2
	hoGFx9gYR36n7ZBC9VS9M/5clbHCkL2INLWYFd+NjrGb8bMrgPg3g2MDHbbzNsEF9TR2qb7flb0O/
	SkAacymA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwweh-0000000Azh6-1fLc;
	Fri, 12 Sep 2025 05:49:07 +0000
Date: Fri, 12 Sep 2025 06:49:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: ->atomic_open() fun (was Re: [RFC] a possible way of reducing the
 PITA of ->d_name audits)
Message-ID: <20250912054907.GA2537338@ZenIV>
References: <>
 <20250908090557.GJ31600@ZenIV>
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910072423.GR31600@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 10, 2025 at 08:24:23AM +0100, Al Viro wrote:

> Note that these unwrap_dentry() are very likely to move into helpers - if some
> function is always called with unwrapped_dentry(something) as an argument,
> great, that's probably a candidate for struct stable_dentry.
> 
> I'll hold onto the current variant for now...

BTW, fun fallout from that experiment once I've got to ->atomic_open() - things
get nicer if we teach finish_no_open() to accept ERR_PTR() for dentry:

int finish_no_open(struct file *file, struct dentry *dentry)
{
	if (IS_ERR(dentry))
		return PTR_ERR(dentry);
        file->f_path.dentry = dentry;
	return 0;
}

For example, we get
int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
                        struct file *file, unsigned int open_flags,
                        umode_t mode)
{
	struct dentry *res;
	/* Same as look+open from lookup_open(), but with different O_TRUNC
	 * handling.
	 */
	int error = 0;

	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
		return -ENAMETOOLONG;

	if (open_flags & O_CREAT) {
		file->f_mode |= FMODE_CREATED;
		error = nfs_do_create(dir, dentry, mode, open_flags);
		if (error)
			return error;
		return finish_open(file, dentry, NULL);
	}
	if (d_in_lookup(dentry)) {
		/* The only flags nfs_lookup considers are
		 * LOOKUP_EXCL and LOOKUP_RENAME_TARGET, and
		 * we want those to be zero so the lookup isn't skipped.
		 */
		res = nfs_lookup(dir, dentry, 0);
	}
	return finish_no_open(file, res);
}

and in cifs !O_CREAT case folds into
        if (!(oflags & O_CREAT)) {
                /*
                 * Check for hashed negative dentry. We have already revalidated
                 * the dentry and it is fine. No need to perform another lookup.
                 */
                if (!d_in_lookup(direntry))
                        return -ENOENT;
 
                return finish_no_open(cifs_lookup(inode, direntry, 0));
        }

In vboxsf, and similar in 9p and fuse:
        if (d_in_lookup(dentry)) {
                struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
                if (res || d_really_is_positive(dentry))
			return finish_no_open(file, res);
        }
 
        /* Only creates */
        if (!(flags & O_CREAT))
                return finish_no_open(file, NULL);
	...

The thing is, in that form it's really clear that dentry stays stable if
we proceed past those chunks; basically, d_splice_alias() only returns
non-NULL if it's got an error or a preexisting directory alias, in which
case result will be positive.  And it's more compact and easier to follow
in that form...

While we are at it, Miklos mentioned some plans for changing ->atomic_open()
calling conventions.  Might be a good time to revisit that...  Miklos,
could you give a braindump on those plans?

