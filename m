Return-Path: <linux-fsdevel+bounces-48115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7C1AA9A82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 19:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252CD189E634
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103F26D4C1;
	Mon,  5 May 2025 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UlZtkvnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42C26C399;
	Mon,  5 May 2025 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466146; cv=none; b=rshaLRXmYN6yNbEaGJFTGOfM/RJYrUlDea6qSKNdkjFd7rw/3IfOYEyQxLYUNge7DPLSrAvbDKTm4JbhTwujFnOw0myTaWw03ASUv9gUouw0kbwaSgpzWR8FMrZjHJC3+C0wrPOxO2PKGZaCQJhpeWAJKtEfiI4maLmqITjghXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466146; c=relaxed/simple;
	bh=517tCt+4y32+StBHGXKC3F5fRWlvqrcqUDxzwPhDLt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOSbedQ82L8wqcwjdCowXegdscCKnVDl6q1nSdz2A7zFKAs3Ydmz31NEqkQQKU04mRfg6GoS621aDzfQPPatA1M3Tzegq2gyXud0re3LL4SeCx6VMMKGAkBrhFua7hk2BqIGCrmGCIM7HLTxfMmLbs8JXvqR7eyN/U129/hioaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UlZtkvnZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ALYKobARIVdOoVSElhtdcJQIThvSSsg2/RhisxHxYpo=; b=UlZtkvnZv8nMGGuetNe/Abykbh
	6mC/eJAkrZL19puRDu//TY3crqwdOWvvm9frbqFrCbxMrlr+gbuWuCJvoU8sZZ1sBZQrtSRcZZ9NW
	eKBLm/Mg2yniQQn7mStoNYLz4/MkMMVUSGyW3J7cG8F3GYv6pp/y3BXdCYvZ0RPTdJ0fxBvhUNy3G
	cYors0yZVPWk2UQPrWBE09vIcj4H5K5pqkQPEZGdnmWIIpP4weP+anwNpeV1JniAgZYf3RNwBWEUq
	W8Lp6At5KmUnYAgMSmVS7zPuxzICWNvMfhov7gbSBf6b6lndl/rJMeID+tTZvarOSkyAnxLguxEyQ
	YVYJFISw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBzci-00000005Xwk-1z9W;
	Mon, 05 May 2025 17:29:00 +0000
Date: Mon, 5 May 2025 18:29:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	John Schoenick <johns@valvesoftware.com>
Subject: Re: [PATCH] vfs: change 'struct file *' argument to 'const struct
 file *' where possible
Message-ID: <20250505172900.GF2023217@ZenIV>
References: <20250505154149.301235-1-mszeredi@redhat.com>
 <aBjm9khhIBOUTFcV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBjm9khhIBOUTFcV@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 05, 2025 at 05:27:34PM +0100, Matthew Wilcox wrote:
> On Mon, May 05, 2025 at 05:41:47PM +0200, Miklos Szeredi wrote:
> > -static inline struct backing_file *backing_file(struct file *f)
> > +#define backing_file(f) container_of(f, struct backing_file, file)
> > +
> > +struct path *backing_file_user_path(struct file *f)
> >  {
> > -	return container_of(f, struct backing_file, file);
> > +	return &backing_file(f)->user_path;
> >  }
> >  
> > -struct path *backing_file_user_path(struct file *f)
> > +const struct path *backing_file_user_path_c(const struct file *f)
> >  {
> >  	return &backing_file(f)->user_path;
> >  }
> > -EXPORT_SYMBOL_GPL(backing_file_user_path);
> > +EXPORT_SYMBOL_GPL(backing_file_user_path_c);
> 
> May I suggest:
> 
> #define backing_file_user_path(f)	(_Generic((f),		\
> 	const struct file *:	(const struct path *)&backing_file(f)->user_path,  \
> 	struct file *:		(struct path *)&backing_file(f)->user_path)))

Um...  You do realize that backing_file_user_path() has users in places
that do *NOT* see the definition of struct backing_file?

