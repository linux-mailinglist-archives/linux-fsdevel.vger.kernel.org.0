Return-Path: <linux-fsdevel+bounces-25853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 580B295124A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5471F247FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0881C694;
	Wed, 14 Aug 2024 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u3HBsvkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9E1CD31;
	Wed, 14 Aug 2024 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601902; cv=none; b=p6c/UkR3d1nEcYKdV8L9OmOvZxQQ4KSCK9bCgIFE8PEUGywdEbdJGwdLgAMzLTljbdZEpvu2mAEhj0ZYUcRSV7aGS5EkikNcADLF8LpLdoXYDQdOgyOLnBKEKWkzKxLDBHIzlb98UJq2wTltIyYu4wO37JA2N2z1aeukV8HhoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601902; c=relaxed/simple;
	bh=nA6UxXiujvxSFnNeSvgiILf4WW8LZvvaIFl7hB21qf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uljHNQwuvBoP0dcEBqlS9Su1kgnm8lbcdnesf0pe18/MSCAUyYW+ThkjzcRy6AiSzmPWYXlsbhcoQ+6SlwXvQ8UW5Oqy9Oky805SwQ6TA/W36+phyjHCOb92xSa7Sz4ctyA9nz/XaZlUUKbGVu+Oum0IAj+LHEneCjxFEMCyonY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u3HBsvkM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q8M9VFnTo721A/GaQMu/ptKzt9bsSKNvxU7i0Y8y6/0=; b=u3HBsvkMkekX42LhLvvmEnD1Dq
	XePLEqR4fxTwT6ip7u/VWTS7qLqQtCLiMV/szNIVqCNdAjC5k9M/DKdeldVWMV3uI1WGn7KP/dnT3
	zqacKx77YuJwJxKyxPXZZLCIXeFgGGYtnU0MOmCt3pWNE+eZKwmUVCFJrQ6pKtNBByI0KMBfhaGDZ
	AgGYYzL3CfFYhU86X1ggjYG1MplxOr192HOGH9KbBdEQLAD2DBen0lPOR1Z30LY5DzCpbglaDHEFM
	UgfRuH1bNmsgC/cQuc8toLIo32yRL4AlxxwrOOnBYUR8B+KXt+Xf07WBduC7mBOLME8UYo6NBQG+b
	CgfD/jcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1se3ab-00000001Uge-0Q3n;
	Wed, 14 Aug 2024 02:18:17 +0000
Date: Wed, 14 Aug 2024 03:18:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240814021817.GO13701@ZenIV>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <6e5bfb627a91f308a8c10a343fe918d511a2a1c1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5bfb627a91f308a8c10a343fe918d511a2a1c1.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 06, 2024 at 03:51:35PM -0400, Jeff Layton wrote:

> > +static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
> > +{
> > +	struct dentry *dentry;
> > +
> > +	if (open_flag & O_CREAT) {
> > +		/* Don't bother on an O_EXCL create */
> > +		if (open_flag & O_EXCL)
> > +			return NULL;
> > +
> > +		/*
> > +		 * FIXME: If auditing is enabled, then we'll have to unlazy to
> > +		 * use the dentry. For now, don't do this, since it shifts
> > +		 * contention from parent's i_rwsem to its d_lockref spinlock.
> > +		 * Reconsider this once dentry refcounting handles heavy
> > +		 * contention better.
> > +		 */
> > +		if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
> > +			return NULL;
> > +	}
> > +
> > +	if (trailing_slashes(nd))
> > +		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> > +
> > +	dentry = lookup_fast(nd);
> 
> Self-NAK on this patch. We have to test for IS_ERR on the returned
> dentry here. I'll send a v3 along after I've retested it.

That's not the only problem; your "is it negative" test is inherently
racy in RCU mode.  IOW, what is positive at the time you get here can
bloody well go negative immediately afterwards.  Hit that with
O_CREAT and you've got a bogus ENOENT...

