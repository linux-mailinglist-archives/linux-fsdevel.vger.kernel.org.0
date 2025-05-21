Return-Path: <linux-fsdevel+bounces-49556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB84BABE98F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 04:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DFF3BC2F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05E22AE68;
	Wed, 21 May 2025 02:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GqjMJ+Zg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9E2563
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793466; cv=none; b=ZvXWnJWJIgPCw1uZ5MmWPXOwYuhaDc14Q4UhOpIRXPk/vCzbZexFXanUStaQBMgdZVgfbUDpiitM72bBpxKpGAalRdUC//LRSs55OBWTvNyXeIsZICqUdAkF8Ed5Fc0rLg8Wp7mn3CIgjQPkQvkuuigob0bUpHi5GmmLFyIFpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793466; c=relaxed/simple;
	bh=QJFbL2JtB1WetxZgb8FMiznGSRQafDgyTRjsNe5eRx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQAwk51egDPDHNvzYvUiqn8E6RGAnAvx9Z2BTAK8Ciyf6i+pyPqDqX9b8RRoKYLltYpJ157oFoN/UQUYUhsYHQL4oF2cYqXj0NreJCUb9294gwoMNYx4baZ+AzeSBXM3saqupr2HRqLePb0s0l+6ZVE5vwlJP0gonTD+30rFEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GqjMJ+Zg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FLk7odUN26jY5B1OlKE63rQoJFYeA+7biQgyU8Zxuek=; b=GqjMJ+ZgcK5DsmupT3IxrP5w4d
	dVugdhe57uCsvMZedysiBdSkJ1jzHlk0Xn6khdZazkbhzhy0xWhwrtRbCAR8wvLGUKy3+AteMJNx8
	TX8+XUNue0zcAjg8kkyAuj+vUQ2+XHyFF7JMJq/VS2g5oWy87v6n92S6YY4UVy5K2rKKQ27HppImE
	UWPDDrIrOdKmdbDiP6oekKGnRAZJQZH2blivGv2L2tF9igTGd2G8t1pEX/Fz5r8EZw7qtQU/JAra7
	1P4GMVxiALwulY2eqPC4n45RsrAYvGYJKv8BqJ8UK+al8djGP3PCMl9iU4ly0xa54xBv6mZGIeeKK
	XCzBzLWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHYv7-00000005UWb-1cMH;
	Wed, 21 May 2025 02:11:01 +0000
Date: Wed, 21 May 2025 03:11:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][CFT][PATCH] Rewrite of propagate_umount() (was Re: [BUG]
 propagate_umount() breakage)
Message-ID: <20250521021101.GG2023217@ZenIV>
References: <20250511232732.GC2023217@ZenIV>
 <87jz6m300v.fsf@email.froward.int.ebiederm.org>
 <20250513035622.GE2023217@ZenIV>
 <20250515114150.GA3221059@ZenIV>
 <20250515114749.GB3221059@ZenIV>
 <20250516052139.GA4080802@ZenIV>
 <20250520-umtriebe-goldkette-9d2801958e93@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520-umtriebe-goldkette-9d2801958e93@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 20, 2025 at 01:10:24PM +0200, Christian Brauner wrote:
> > +It is convenient to define several properties of sets of mounts:
> > +
> > +1) A set S of mounts is non-shifting if for any mount X belonging
> > +to S all subtrees mounted strictly inside of X (i.e. not overmounting
> > +the root of X) contain only elements of S.
> 
> I think "shifting" is misleading. I would suggest either "isolated" or
> "contained" or ideally "closed" which would mean...

Umm...  I'm not sure.  "Shifting" in a sense that pulling that set out
and reparenting everything that remains to the nearest surviving ancestor
won't change the pathnames.  "Contained" or "isolated"... what would
that be about?

> > +of that set, but only on top of stacks of root-overmounting elements
> > +of set.  They can be reparented to the place where the bottom of
> > +stack is attached to a mount that will survive.  NOTE: doing that
> > +will violate a constraint on having no more than one mount with
> > +the same parent/mountpoint pair; however, the caller (umount_tree())
> 
> I would prefer if this would insert the term "shadow mounts" since
> that's what we've traditionally used for that.

There's a bit of ambiguity - if we have done

mount -t tmpfs none /tmp/foo
touch /tmp/foo/A
mount -t tmpfs none /tmp/foo
touch /tmp/foo/B

we have two mounts, one overmounting the root of another.  Does "shadow"
apply to the lower (with A on it) or the upper (with B on it)?

> > +{
> > +	while (1) {
> > +		struct mount *master = m->mnt_master;
> > +
> > +		if (master == origin->mnt_master) {
> > +			struct mount *next = next_peer(m);
> > +			return (next == origin) ? NULL : next;
> > +		} else if (m->mnt_slave.next != &master->mnt_slave_list)
> > +			return next_slave(m);
> 
> Please add a comment to that helper that explains how it walks the
> propagation tree. I remember having to fix bugs in that code and the
> lack of comments was noticable.

Ugh...  Let's separate that - it's not specific to propagate_umount()
and the helper is the "we hadn't gone into ->mnt_slave_list" half of
propagation_next(), verbatim.

I agree that comments there would be a good thing, but it (and next_group())
belong to different layer - how do we walk the propagation graph.

FWIW, the current variant of that thing (which seems to survive the tests
so far) already has a plenty in it; let's try to keep at least some parts
in separate commits...

