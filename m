Return-Path: <linux-fsdevel+bounces-41257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BCBA2CE0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B483A5C6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270411A254C;
	Fri,  7 Feb 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qtEjRBAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACB23C8C7;
	Fri,  7 Feb 2025 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959759; cv=none; b=s3nYKcvQECbOdPPaYNpv4FBNSAb+ImOhRvntY8f68LRe2+kF36Mnntc8Za1qIrK2n0rqnSwcDHooKvDMIlTUKTHkgi17eFNRl4f0SJXcVWcGb3+VSDL93KDQLYRp/2QVlVLuGRVKwiWCv90Rh50JxaOBiiKInCGuCl/3/c/6AhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959759; c=relaxed/simple;
	bh=moEspTzMBeC3GRmr12QcUjPsbDVtlrjncgcdBExzf4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTqg5SVZTFygIrF28uoe0HIjbxOmOkX1PGfbzUcVtWMuLwQK/2krR5e9GJYi2S3kPUQsdSJevKHdojRueL7ZK8wHYFQZLt4+vhJfhCNifzMGLIOktsR4hDf8CZowQYI06NqfeVAFzHmbNu6xKue0YDL0TmqxrQGhDGKyO3Mk3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qtEjRBAp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JW3jy6gOkX6wQNbQBxB9VV/h5htkmTQXc3fLdHPiZtk=; b=qtEjRBApffm2m7iku127VMNgCe
	3Ilk5/YZJ+3+BixghfrPmkES5uFJYJmco3hjjJzsKL33nEIjCW9y2RMBV3Qoqe4P8GLhNZFtBGvNE
	vjDften1HHNFFS7ilrOE3L34qP2LZE+htUNBxow1sEORxfUOQukNhMar4Z60TN6WDf7UXyOkVF7bq
	ns3RaY+nY2DgFP1tJc4EwcavQVd/R1Op+WTJJ3bBpGCzTxTSeUo6pNa+nsZWXMtxuDivlCVD8r9rY
	WkofJG6MSl1Lx4uwOIH1rRmvRNnEZ44Vew3masC5v5pA8um0mS/KYwzgV6NRG46AO9jJ7o0TvZss9
	iKs9maCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgUrz-00000006YJ0-1DbR;
	Fri, 07 Feb 2025 20:22:35 +0000
Date: Fri, 7 Feb 2025 20:22:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
Message-ID: <20250207202235.GH1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-9-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-9-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:45PM +1100, NeilBrown wrote:
> lookup_and_lock() combines locking the directory and performing a lookup
> prior to a change to the directory.
> Abstracting this prepares for changing the locking requirements.
> 
> done_lookup_and_lock() provides the inverse of putting the dentry and
> unlocking.
> 
> For "silly_rename" we will need to lookup_and_lock() in a directory that
> is already locked.  For this purpose we add LOOKUP_PARENT_LOCKED.

Ewww...  I do realize that such things might appear in intermediate
stages of locking massage, but they'd better be _GONE_ by the end of it.
Conditional locking of that sort is really asking for trouble.

If nothing else, better split the function in two variants and document
the differences; that kind of stuff really does not belong in arguments.
If you need it to exist through the series, that is - if not, you should
just leave lookup_one_qstr() for the "locked" case from the very beginning.

> This functionality is exported as lookup_and_lock_one() which takes a
> name and len rather than a qstr.

... for the sake of ...?

