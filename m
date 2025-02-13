Return-Path: <linux-fsdevel+bounces-41627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD08A336A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 05:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E43168DF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 04:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C14205E0A;
	Thu, 13 Feb 2025 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qP2gGj9T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB841EA84;
	Thu, 13 Feb 2025 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419776; cv=none; b=ELpPgB7eQXNpDHzpVt5r/lRo7a+/2G/MqIT4RblKIWe7Xqww+IekE7f6t3FEDVfCaCtjFkor8IHNlmElulZgELyCmyfxnxPDlsuINbBY/3UCLutepAayuT5pobcnpDOpnPcIw7B5XTvWCTlB8CHI1K8Y2l9t/7VDEmgkuLzIWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419776; c=relaxed/simple;
	bh=Vu1hdB6sAQ/ZEPKuBnxx14OA4oc/gBW/ght14YZxFqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Trwtiry1BVgo8X3uCB8PBXJWQ/Q9HtwgE6LvbmjuovsJONTEyfEwZ7Ryt/TQWoiSWCHwNU864dNQdX4v7mT55mp8zJaXNHScqUq3bBkHoWT1kvTnX+8ijbe0kxjQ07jYxFHPkpwNXwSYgpcV0w9muqzGxCuLYL5EJX5yqQIGWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qP2gGj9T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7xYKvL/4eIqDcYKwZsggORcTcfd4KIZ9CC7qacZwf7U=; b=qP2gGj9TGvBJVVVl3uhLwitPzd
	DR8zAFoOTQX1/+Afh0D7dgn74eleW8UWciDdX1OQKgIkYs/ma9KIfCmoNwyTjCLEaj4QLKGAVYbF9
	WLBGK/g42ShS0lAOWBdcjmu2hTNxIYlCL18JeqJn2nrGd4+s9REi6dhv/DsnLHoWk/FeCa8uBsQPT
	NxHe6KNxF2IoXXaPMfM+2f8jiWkLkISRC6gfkOjIHJNK9mWeBuunsqkiWLh3pVeo636PL2tTozOwf
	QtPPTz3HArUosIvOcrQsGxt0a9sLO+J7O5WMTPhfx6J9Kw0BpavzlRGPyFlXgzz/d2Rywy3nOV4mw
	+m1puGFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiQXb-0000000CQwA-0kAL;
	Thu, 13 Feb 2025 04:09:31 +0000
Date: Thu, 13 Feb 2025 04:09:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] nfs: switch to _async for all directory ops.
Message-ID: <20250213040931.GU1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-20-neilb@suse.de>
 <20250213035116.GT1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213035116.GT1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 13, 2025 at 03:51:16AM +0000, Al Viro wrote:
> On Thu, Feb 06, 2025 at 04:42:56PM +1100, NeilBrown wrote:
> >  nfs_sillyrename(struct inode *dir, struct dentry *dentry)
> >  {
> >  	static unsigned int sillycounter;
> > @@ -447,7 +451,8 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
> >  	struct dentry *sdentry;
> >  	struct inode *inode = d_inode(dentry);
> >  	struct rpc_task *task;
> > -	int            error = -EBUSY;
> > +	struct dentry *base;
> > +	int error = -EBUSY;
> >  
> >  	dfprintk(VFS, "NFS: silly-rename(%pd2, ct=%d)\n",
> >  		dentry, d_count(dentry));
> > @@ -461,10 +466,11 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
> >  
> >  	fileid = NFS_FILEID(d_inode(dentry));
> >  
> > +	base = d_find_alias(dir);
> 
> Huh?  That would better be dentry->d_parent and all operations are in
> that directory, so you don't even need to grab a reference...
> 
> >  	sdentry = NULL;
> >  	do {
> >  		int slen;
> > -		dput(sdentry);
> > +
> >  		sillycounter++;
> >  		slen = scnprintf(silly, sizeof(silly),
> >  				SILLYNAME_PREFIX "%0*llx%0*x",
> > @@ -474,14 +480,19 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
> >  		dfprintk(VFS, "NFS: trying to rename %pd to %s\n",
> >  				dentry, silly);
> >  
> > -		sdentry = lookup_one_len(silly, dentry->d_parent, slen);
> > -		/*
> > -		 * N.B. Better to return EBUSY here ... it could be
> > -		 * dangerous to delete the file while it's in use.
> > -		 */
> > -		if (IS_ERR(sdentry))
> > -			goto out;
> > -	} while (d_inode(sdentry) != NULL); /* need negative lookup */
> > +		sdentry = lookup_and_lock_one(NULL, silly, slen,
> > +					      base,
> > +					      LOOKUP_CREATE | LOOKUP_EXCL
> > +					      | LOOKUP_RENAME_TARGET
> > +					      | LOOKUP_PARENT_LOCKED);
> > +	} while (PTR_ERR_OR_ZERO(sdentry) == -EEXIST); /* need negative lookup */
> 
> What's wrong with sdentry == ERR_PTR(-EEXIST)?

BTW, do you need to mess with NFS_DATA_BLOCKED with that thing in place?

