Return-Path: <linux-fsdevel+bounces-60475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AEEB48391
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 07:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528DF3B8382
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 05:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CB7223DDF;
	Mon,  8 Sep 2025 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kdiv0zTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A21DDC2A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757308796; cv=none; b=UiNNXy772pAHCxG6wXP0WI1qVIRWtMGSRWpjjEH1i5C9bGaU66xLfJV8WBhue79C2xi2WhP1DsV2QSU9EkxUzyx6rXlXINsTcI28MTQkM/ptZBR+DfFOtYJmC3dF4pEe8w0sOoh+Dgh5EE91oXA+RJjlsgRupfvR/eXEYOAD0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757308796; c=relaxed/simple;
	bh=i7lGM2C5ZLO3RKTf0IgFuO2i4te3F4RCVWphPPDEIAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCNKwq2gPqQjSjpSSDAG59NkZEMJRAqMCOnEWXm/WMlXsH4ZHqfTW0hxyK7DT5rrJknPlZ9TIpo6xS3sXuH1TFoamDObg+iGeWMn7I599wZiQuZatfcN+zTFxg1oDs+XO7GwQj4QTwyD1uiUl7v4aPyUcuHZNF0Z6cDlhqWyFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kdiv0zTd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5qpEAcM2Iw6WbkRgabf0msknguy+TbJMbv0ucsZW6rc=; b=kdiv0zTdChFmc/vM86dFysumme
	Tl1EQmRq0y0VRqY7/ct2iG+cILWU6DXiUOSK+7BX8IGU4gOnQnAek6zz1dgbezb7NgxloITcpbnEH
	neZbui/UJyUxnEGsvw178fNq1eC6j8sXcD1fp/Oif2KSv7qtVe9bsby5vB7mi/E0v+/EAmWxGylg4
	xQg4GxlGUeGm2MN1aATmZbbCmlcW8XH55halOgzOipoae6yB/wqhyZUoX34UfztAxO+FHgdNWBNii
	0FUy2tuasJ1A3YcnouEJdAsQY0jM4ypX+xbaPn4d5h03af/butIenPRPeaMg4NFuZqO1pbkAT8rQ6
	UOQVwKsQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvUIB-0000000EJRa-0mM3;
	Mon, 08 Sep 2025 05:19:51 +0000
Date: Mon, 8 Sep 2025 06:19:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250908051951.GI31600@ZenIV>
References: <20250908035708.GH31600@ZenIV>
 <175730701033.2850467.1822935583045267017@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175730701033.2850467.1822935583045267017@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 08, 2025 at 02:50:10PM +1000, NeilBrown wrote:
> On Mon, 08 Sep 2025, Al Viro wrote:
> > That way xfs hits will be down to that claim_stability() and the obscenity in
> > trace.h - until the users of the latter get wrapped into something that would
> > take snapshots and pass those instead of messing with ->d_name.  Considering
> > the fun quoted above, not having to repeat that digging is something I'd
> > count as a win...
> > 
> 
> What would you think of providing an accessor function and insisting
> everyone use it - and have some sort of lockdep_assert_held() to that
> function so that developers who test their code will see these problem?
> 
> Then a simple grep can find any unapproved uses.

Really?  Consider ->link().  Both arguments *are* stable, but the reasons
are not just different - they don't even intersect.

Old: known to be a regular file, held locked.  The former guarantees that
it can't be moved by d_splice_alias(), the latter prevents that being done
by vfs_rename(), which also locks the objects being moved.

New: has been looked up after its parent had been locked.  Note that _after_
is important here - you can't just blindly fetch ->d_parent and check if
its inode is locked (not to mention anything else, you'd need to check it
being non-NULL, do it under rcu_read_lock(), et sodding cetera - ->d_parent
stability rules are not that different from ->d_name ones).

And this "everyone use it" is not going to fly - you still have places where
it's done simply under ->d_lock.  Or ->d_lock on known parent - either would
suffice.

Besides, there's "which primitive do I use here?" - with the annotation approach
it's as simple as "if I have it as stable_dentry, just use stable_dentry_name(),
otherwise think hard - it may be tricky".

I don't believe that lockdep is an answer here - annotations (and these *are*
annotations - no code generation changes at all) give better coverage, and
bitrot tends to happen in rarely taken failure exits.

