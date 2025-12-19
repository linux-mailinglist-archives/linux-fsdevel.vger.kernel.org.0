Return-Path: <linux-fsdevel+bounces-71787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D107CD2168
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 23:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7512330699F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 22:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EA8319855;
	Fri, 19 Dec 2025 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aKxfdvpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED962FF653;
	Fri, 19 Dec 2025 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766182427; cv=none; b=hGFG7r/pw2eOy8I/SeiR9ynyYVNOGgZKZ9RNtX2wyKq+Z/BV6GEyck9ARH3SCZLZLPuliSA7c/AOEHzbqPuNW+2sqT+q9gTT0CCgMi4fb+l/VmVRAOLgj4Qq7G4ACRQjBQwF1KfWZ6qqLFk7aNfgcEZhCxsRkiNwXgZuMT8bjV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766182427; c=relaxed/simple;
	bh=5H3TTJIWg1r2yzK+HKeENEgClNlEiAroR+3RAgnfw+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4uRSAFd1Bx46ZT4eH2uWqQ4UOS1uLSpD4rAh7QJ3zDWOjBCB/Pc35ToNS2wEys8CZ5ezOrCQKG4wtQnz0uF8ob7UJQVvUJ0FhZ0FC7oRBvoAphjx4ziUQoGqeDgLFQkefeUMd5FlPTLTh/9pCP2EhHISPW77qU/5iM/5yDreBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aKxfdvpl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Fp9u5dYdcwSEA3F5yo9ZeAX/jzGhYGVQH9lBzGRzyxs=; b=aKxfdvplyz+IqUqM6BwI3IrVM4
	Y7aWbD8HBHk9yZFASGZF3j2Enejz0+fU9C3VR93OjrXUkmWNoShkRs9gRnjrj5p2KbgBixhDPdfCE
	UZfzVo8OAdxFv9UT1CPTbby6YtPpHJWAsUrCpb+q0M/5EEdJGqjFmT9tVH96MMC2DEiCA2QHaTBkW
	GOeJHk2nW78+qKfu2Kw5bCSqbLEYocdP5n8yZEhqQfUb71YbE7UL6yfYIqULAfX6CCt+MnJs2pYth
	HcEkhx3qhvheGUj7k3mgj/T40SpX5I4NBPkQqmsrGyvQe4PcyFDFiIw8B3oVkbTj08lztjjcLqrX8
	cVKWRiGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vWijy-00000009Zjo-3QNr;
	Fri, 19 Dec 2025 22:14:26 +0000
Date: Fri, 19 Dec 2025 22:14:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, mszeredi@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] fuse: add missing iput() in fuse_lookup() error path
Message-ID: <20251219221426.GA1712166@ZenIV>
References: <20251219174310.41703-1-luis@igalia.com>
 <20251219221031.GZ1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219221031.GZ1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 19, 2025 at 10:10:31PM +0000, Al Viro wrote:
> On Fri, Dec 19, 2025 at 05:43:09PM +0000, Luis Henriques wrote:
> > The inode use count needs to be dropped in the fuse_lookup() error path,
> > when there's an error returned by d_splice_alias().
> > 
> > (While there, remove extra white spaces before labels.)
> > 
> > Fixes: 5835f3390e35 ("fuse: use d_materialise_unique()")
> > Signed-off-by: Luis Henriques <luis@igalia.com>
> 
> Have you actually looked at d_splice_alias()?
> 
> It does consume inode reference in all cases, success or error.  On success
> it gets transferred to dentry; on failure it is dropped.  That's quite
> deliberate, since it makes life much simplier for failure handling in the
> callers.
> 
> If you can reproduce a leak there, I would like to see a reproducer.
> If not, I would say that your patch introduces a double-iput.
> 
> NAK.

PS: out_iput in there is needed only on one failure exit - after we'd
found an inode and before we'd passed it to d_splice_alias().

FWIW, I would rather replace that with
	if (inode && get_node_id(inode) == FUSE_ROOT_ID) {
		iput(inode);
		return ERR_PTR(-EIO);
	}
and turned all goto out_err; into direct returns.


