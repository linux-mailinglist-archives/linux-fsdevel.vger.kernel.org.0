Return-Path: <linux-fsdevel+bounces-61201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA29B55E8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 07:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC404A03752
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 05:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019A2E1F14;
	Sat, 13 Sep 2025 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DqXAkdH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5418E20
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757740046; cv=none; b=JvIVH6Dmw3U+dtUTbo+4fmiUCKnuHjuEFcedizEyZE/v1ftz+PBAe0YRmQMLqTIOZWZwDSxWBvTWT7+lHyVOx/HamIOkQqMPSfMdqrV18D3oEUzQ8rmUQq8vitu2oWxQFNn/GxNHP50d/ZJk056lnXh8Cfi3JnAP2we0DRefLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757740046; c=relaxed/simple;
	bh=af1ItDeWwFKxGBwvBgfSrV6SS2gwmbEXdr2ViaTZoks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6TABihdvvmFEdRFF5jlM7HRB6usjfL+JT/rFPjQsbkhRs8ldiBkuLXIj4kbQNJ/bsxy0KuEzUQHlEvrG5HXU18ZInv5UC3Qx114pYQAocAQiTyQaBQIfqgwuFOeIQ/UK7RJOe0TPjo/r+1g96Of5csuLMWd8B4apCkAV0rF0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DqXAkdH4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=beo6RQLiLjOP6O7spgEXMANJWQdZ0pPfHSJxCP2MCqM=; b=DqXAkdH4Byh8Tl/ZZEEEkhdZSY
	tB7Th9qmQEzD02e839aSYQ5ZRRr0PGQjVUhEBs7g+/IoAzYugWiKNvzHHk35vm2v4sA9nirDLX2qT
	1OAhBwK6rsOykLrXiNQdih8KgWsANcEgDOf/TiIRiBQPqGC880ORg0F1fSmuG/37wKThWzNcfWCNL
	GUK9HkGFPNa9M2uYC/VcKj31noWr4kqTHAHvrpkVEa8ppaDovv27p2p0pZGbtm7ywMC48bk4c3Yzq
	DbbMukqc2kSSWfbGnnf2PDLrI3RlDGARs+9PUem0/Y1xu9BOR2K4l5Z5Qim0SS9wxZckFome2Y+9O
	wtUJ6dVQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxITn-00000008De1-1Esg;
	Sat, 13 Sep 2025 05:07:19 +0000
Date: Sat, 13 Sep 2025 06:07:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing
 the PITA of ->d_name audits)
Message-ID: <20250913050719.GD39973@ZenIV>
References: <20250908090557.GJ31600@ZenIV>
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV>
 <20250912054907.GA2537338@ZenIV>
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
 <20250912182936.GY39973@ZenIV>
 <175773460967.1696783.15803928091939003441@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175773460967.1696783.15803928091939003441@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Sep 13, 2025 at 01:36:49PM +1000, NeilBrown wrote:

> > 	Umm...	Unless I'm misunderstanding you, that *would* change the
> > calling conventions - dentry could bloody well be positive, couldn't it?
> > And that changes quite a bit - without O_CREAT in flags you could get
> > parent locked only shared and pass a positive hashed dentry attached
> > to a directory inode to ->atomic_open().  The thing is, in that case it
> > can be moved by d_splice_alias()...
> 
> Once we get per-dentry locking for dirops this will cease to be a
> problem.  The dentry would be locked exclusively whether we create or
> not and the lock would prevent the d_splice_alias() rename.

Umm...  Interesting, but... what would happen in such case, really?

You have one thread with allegedly directory dentry it had skipped
verification for.  It tries to combine open with revalidation, and
sends such request.  In the meanwhile, another thread has found the
same thing in a different place - possibly because of fs corruption,
possibly because the damn thing got moved on server, right after it has
sent "OK, I've opened it" reply to the first thread.  What would you do?
Have the second thread spin/fail with some error/something else?

Alternatively, move succeeds first, the lookup in the new place arrives,
then revalidate+open.  The first thread gets a nodeid mismatch, and...?

How would that combined revalidate+open work for fuse, anyway?  The former
is basically a lookup - you send nodeid of parent + name, get nodeid +
attributes of child.  The latter goes strictly by nodeid of child and
gets a 64bit number that apparently tells one opened file from another
(not to be confused with fhandle).  Combined request of some sort?

I think we need Bernd to bring a fresh braindump on the plans in that
area.  And we'd damn better *NOT* make it another "this filesystem is
special, the locking works for it because $REASONS (half missing from
the discussion) and nobody else returns that special ->d_revalidate()
return value (at the moment)" - every time something of that sort had
been kludged in we ended up paying for that later.

