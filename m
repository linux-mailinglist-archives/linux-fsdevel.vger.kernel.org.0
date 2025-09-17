Return-Path: <linux-fsdevel+bounces-61872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B653B7E029
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8261BC219F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 04:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80642472B6;
	Wed, 17 Sep 2025 04:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nkROen2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B966249F9;
	Wed, 17 Sep 2025 04:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758083035; cv=none; b=m5WESweDM8nqSLLDeVcgakzb9Oa9/goZds1jhnCEjgTR6Fj++i6jeNbsAwObkWfbIaZ58eKfO57cH2ENvVQlV4r0HxMl+/R11tZZRpE5nhQSgdKX8DjHwttPy+IVrW8DvD08VdA0PlE4avef3aVx2H0xJF2+MHc55e0iIxohtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758083035; c=relaxed/simple;
	bh=/adVylI722Ykf1cnvb0CXZ9f4lsK8b8doqg5szlR0bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQmce3E9EmOb4YrTCtQ+koF06XVWdio5JB3pX7KOuL1IjDfJgjREtP0Lo9lj0UlzIUWeY0Ip4D3qFno0ODeCSQMCufbnImkdmOAldLyaqvhFNEnLq6jtNqaq5Ok9RUm/wPiVtJgxXc3JwLOky/5kOaP1oC4ADz8knZgmqMFfSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nkROen2/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oS9XCI0Nm6KsCk1ABrQKUVzzof6lHhCkoWjiLYDRuvY=; b=nkROen2/io+53TpEOyVxPex94O
	6reEs4cQ8EwfAYOJN6C+L4gEdD9utUpr2rI3GZk2v9EdogddEjave01bTaqydR3p8yEPevvIXNiow
	TU3BXUMv2iDKQnIqa6BaLl+jX0WK5J5VeWAjgs6ztzn5TFdh4PeXmxpjKYSVp4SucFjKKDpu80l0H
	SahPIvHV2GUeoita4DkzQ3WWWtqz8iOEvBNdp/MZTzbG+JrXXwZpAOt9fnqOnylJFz7z4TJzcEXnP
	9eaWCBtGQZ62k9dISMBOpk2a8qQFCWpsgnzCNSpXcJDM0hWppTX/baLBamd7rR4IcOIP6w2I388gi
	ps8gqRIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyjhs-00000008YOY-3afK;
	Wed, 17 Sep 2025 04:23:49 +0000
Date: Wed, 17 Sep 2025 05:23:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] VFS: don't call ->atomic_open on cached negative
 without O_CREAT
Message-ID: <20250917042348.GS39973@ZenIV>
References: <20250915031134.2671907-1-neilb@ownmail.net>
 <20250915031134.2671907-3-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915031134.2671907-3-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 15, 2025 at 01:01:08PM +1000, NeilBrown wrote:

> All filesystems with ->atomic_open() currently handle the case of a
> negative dentry without O_CREAT either by returning -ENOENT or by
> calling finish_no_open(), either with NULL or with the negative dentry.

Wait a sec...  Just who is passing finish_no_open() a negative dentry?
Any such is very likely to be a bug...

> All of these have the same effect.
> 
> For filesystems without ->atomic_open(), lookup_open() will, in this
> case, also call finish_no_open().
> 
> So this patch removes the burden from filesystems by calling
> finish_no_open() early on a negative cached dentry when O_CREAT isn't
> requested.

Re "removing the burden" - it still can be called with negative cached without
O_CREAT.

O_CREAT in open(2) arguments might not survive to the call of atomic_open() -
in case when you don't have write permissions on parent.  In that case
we strip O_CREAT and call into atomic_open() (if the method is there).
In that case -ENOENT from atomic_open() is translated into -EACCES or -EROFS:
                dentry = atomic_open(nd, dentry, file, open_flag, mode);
		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
			dentry = ERR_PTR(create_error);
		return dentry;
In case when no ->atomic_open() is there the same logics is
        if (unlikely(create_error) && !dentry->d_inode) {
		error = create_error;
		goto out_dput;
	}
in the very end of lookup_open().  The point is, you might have had a call
of ->d_revalidate() with LOOKUP_CREATE|LOOKUP_OPEN and then have the damn
thing passed to ->atomic_open() with no O_CREAT in flags.

