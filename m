Return-Path: <linux-fsdevel+bounces-61212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C1B5633C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 23:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90B87AC083
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 21:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0611E281358;
	Sat, 13 Sep 2025 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KN2GWZlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00D25D208
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798901; cv=none; b=kYtKBYiMy51NatzALdoDVOLN9Ehv6jBZ3EweJa5yTD3EassDUAP+r621I4p3ubSp0QO/eC/RldhEPwfumidm+7YbXrTzKiC+TbWC5G7cMlCrnUErmDTYR3COmVG440cBd6UbfLLC0F6zPW88KN9KPHyKhgi4DHC7SkD+3THGq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798901; c=relaxed/simple;
	bh=OOwYFhpmGoG/wxLDyagcYcU5FBxLEPjVda2wIkppMSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEQZu0rdaNXADLTtx3gH0WH0E+O2A7xvDVC+gbhYvNdjCayRs0aMtIqYREN2H4vBBa65/yce8krID2TQI5tfMcHsTwqFQh9/SSWSK5pYGo8XPB2fQJ0kUiH1mGjFN0+H33FLPmnWxs5pqUUHurpW9KnGfdLyHwppxK9X2Uk4Nhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KN2GWZlI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rH+iZWE/pfOMgONDQedXM9ek1RMgFNsirxF0NallFiw=; b=KN2GWZlIOlZkgSjF3+zc0yMPTw
	GU35qJ8KohCmb5XHDDYYUkXsjej+FyuCtAZ0qfGNQCva1L85fvubSWKjLCxC3z3QleG6z4LDL8biY
	HXuZw5tUqNPJdKDS4AQ76PQagbMQ0Q59TMDGUltRGTOvaWd1De2lJPxROIuEntUj2ojRryaiwdHOT
	FD5neMkRCj020JAzpuS5IJHx6zGd+NLHq2OCsMtK+/ys+eR9axO1tYEb0TR5uILy6w/bSooQ8kZj5
	I7pAqgW68fYtfWn0OwI3xNum7/gO9GdAsb8wiiIJu/c6qxYTUnDDOUaVIgz9Izw01A7CNGKDlKs/8
	5e5xrXtw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxXn5-00000001DRc-2sKa;
	Sat, 13 Sep 2025 21:28:15 +0000
Date: Sat, 13 Sep 2025 22:28:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250913212815.GE39973@ZenIV>
References: <>
 <20250908051951.GI31600@ZenIV>
 <175731272688.2850467.5386978241813293277@noble.neil.brown.name>
 <20250908090557.GJ31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908090557.GJ31600@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 08, 2025 at 10:05:57AM +0100, Al Viro wrote:

> > Fudging some type-state with C may well be useful but I suspect it is at
> > most part of a solution.  Simplification, documentation, run-time checks
> > might also be important parts.  As the type-state flag-day is a big
> > thing, maybe it shouldn't be first.
> 
> All of that requires being able to answer questions about what's there in
> the existing filesystems.  Which is pretty much the same problem as
> those audits, obviously.  And static annotations are way easier to
> reason about.

Speaking of annoyances, d_exact_alias() is gone, and good riddance, but there's
another fun issue in the same area - environment for d_splice_alias() call *and*
for one of those d_drop()-just-in-case.

The call tree is still the same:
_nfs4_open_and_get_state()
	<- _nfs4_do_open()
		<- nfs4_do_open()
			<- nfs4_atomic_open()
				== nfs_rpc_ops:open_context
					<- nfs_atomic_open()
						== ->atomic_open
					<- nfs4_file_open()
						== ->open
			<- nfs4_proc_create()
				== nfs_rpc_ops:create
					<- nfs_do_create()
						<- nfs_create()
							== ->create
						<- nfs_atomic_open_v23(), with O_CREAT
							== ->atomic_open
							# won't reach nfs4 stuff?

->create() and ->atomic_open() have the parent held at least shared;
->open() does not, but the chunk in question is hit only if dentry
is negative, which won't happen in case of ->open().

Additional complication comes from the possibility for _nfs4_open_and_get_state()
to fail after that d_splice_alias().  In that case we have _nfs4_do_open()
return an error; its caller is inside a do-while loop in nfs4_do_open() and
I think we can't end up going around the loop after such late failure (the
only error possible after that is -EACCES/-NFS4ERR_ACCESS and that's not one
of those that can lead to more iterations.

	However, looking at that late failure, that's the only call of
nfs4_opendata_access(), and that function seems to expect the possibility
of state->inode being a directory; can that really happen?

	Because if it can, we have a problem:
                alias = d_splice_alias(igrab(state->inode), dentry);
                /* d_splice_alias() can't fail here - it's a non-directory */
                if (alias) {
                        dput(ctx->dentry);
                        ctx->dentry = dentry = alias;
                }
very much *can* fail if it's reached with state->inode being a directory -
we can get ERR_PTR() out of that d_splice_alias() and that will oops at

        if (d_inode(dentry) == state->inode)
                nfs_inode_attach_open_context(ctx);
shortly afterwards (incidentally, what is that check about?  It can only
fail in case of nfs4_file_open(); should we have open(2) succeed in such
situation?)

Sigh...

