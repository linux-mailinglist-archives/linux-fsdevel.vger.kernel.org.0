Return-Path: <linux-fsdevel+bounces-42619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7201A450F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 00:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06363B06AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23424235374;
	Tue, 25 Feb 2025 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YNR3E5vq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDE19DF8B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526565; cv=none; b=ksOS+GH/8pKNrPazrRjL9FS87VscOiuaLGzfRM10xSh0xRLZvJzI5yS4IrTjGdNqOr4+F4lFC6h1km2QcYNpwdf6FyiDqBJ3/MmGds1a5UNmtPM2hnK79siTJ6H1LDjpnQWkuDuORi9z1o6PKqKWyc0B0bOOa4w5CeEKGGLjQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526565; c=relaxed/simple;
	bh=jpxbFuUPQiib2nVxFth+toV+ziNp6p4WEMlYe8UnJHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amWFbZTzhPmF4+efpbEg7ZmTsgnEbHGn6nEZ1TgsRWoKJpdwfsnA0HXI+eu+RCfJiIv9nANOxLlCE45KE/zb5dQxmtIUaUM25nxjQtF+Q7x8coK3ARSUeZxLB/kH1bcsbDfPRtzqiXm8w8lV6GAR/hF+guHvh1BWQxL2qWBi+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YNR3E5vq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y1SEhEh6l9+kAgM4M0tqdN8Nj7XjEpup3DZmmssdGSE=; b=YNR3E5vq7mj06kbha5UgKxs+UL
	6M/lotLqd5vCkLD+ATIwmMXvWRMusuNK5CqoIZjfw21dxdv4vZ9E1JZCPKZClN21zBBHkTFVKOkW+
	ASAKBGemgbVVwKCDS9DjNsmq7xbt+UDwCkiBv9UuQjLm5ho4LqeiGEgRBYgatULH/LifxosuK07OK
	oQ8Zywznbw7ckIt5kaZfn8VfmqKdLherBXojnJW8pBheujjwlhsF3n4grYlo4Z8neNnFp+DYUbdOn
	bepTH4hJqtbwDrjoggkt+sY6Y7Td2K5oosP5V0vNHJVoJmk7bNbJJnznOO3zGwmsvEqKI6aRczEnL
	qaE+Ldcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tn4T2-00000008a9K-1RbT;
	Tue, 25 Feb 2025 23:36:00 +0000
Date: Tue, 25 Feb 2025 23:36:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 16/21] ramfs, hugetlbfs, mqueue: set DCACHE_DONTCACHE
Message-ID: <20250225233600.GB2023217@ZenIV>
References: <>
 <20250224212051.1756517-16-viro@zeniv.linux.org.uk>
 <174052591233.102979.4456239839821136530@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174052591233.102979.4456239839821136530@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 26, 2025 at 10:25:12AM +1100, NeilBrown wrote:
> On Tue, 25 Feb 2025, Al Viro wrote:
> > makes simple_lookup() slightly cheaper there.
> 
> I think the patch make sense because there is no point keeping negative
> dentries for these filesystems - and positive dentries get an extra
> refcount so DCACHE_DONTCACHE doesn't apply.
> 
> But I don't see how this makes simple_lookup() cheaper.  It means that
> if someone repeatedly looks up the same non-existent name then
> simple_lookup() will be called more often (because we didn't cache the
> result of the previous time) but otherwise I don't see the relevance to
> simple_lookup().  Am I missing something?

This:
        if (!(dentry->d_flags & DCACHE_DONTCACHE)) {
		spin_lock(&dentry->d_lock);
		dentry->d_flags |= DCACHE_DONTCACHE;
		spin_unlock(&dentry->d_lock);
	}

IOW, no need to mark that sucker as "don't retain past the moment when
its refcount drops to zero" - they'll all be marked that way since
they'd been created.

Note that we used to switch then to ->d_op that had ->d_delete always
returning true.  That had been replaced with setting DCACHE_DONTCACHE;
that was an equivalent transformation.  So retention rules have not changed;
the only change here is that this flag doesn't need to be set.

