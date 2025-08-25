Return-Path: <linux-fsdevel+bounces-59111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA60BB348B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C278B1A87AE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F7303C91;
	Mon, 25 Aug 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XRqBBAV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D203002A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143202; cv=none; b=XB85nEZOANjdxtCtbaGuk2YF8RHwo5hU4yhuw4bKjKB6mXyMnz7mTBTxFsGLvzzI++2Ph2V8S6yU93xzk9og3T6xxJG6WmmU9n4mrpxdTC+DXJSP5cp2YOnkekcNaz8pJWAejR6vo0Y3Vf7C7WmeHufHEzhNG80hE8ZduZi44Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143202; c=relaxed/simple;
	bh=0vr2oJtMb3G9ltUdxxOJ2kFN7Iff4k8eERb7aw7UCbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHX4uIZQdpHucidXqTA7fDBmGiqEEt2zKujERIbPIRTUwYjytzPMs2OZBplD9SEr1xr6Oy1hGl4fpvYXGU1Ir2O5567OUzD/lb60z4rq2O3PfdZIggRxMHUlmuAwzKe/E7iJF1snRzpEA2DIvBZBg34OW7zrSlBmTMWm8E78+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XRqBBAV/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5nD2XRhvABOLqAmoFTxvFyXvgoN/ThDNkpLunXijgHg=; b=XRqBBAV/+X/3o5qzuiYym2o7lR
	qG87AXFL/n7TKC4wHETG//Unh0NHleiRlIaEd0Z2Pmj9JFS2nrP8wbJymD7ZnvewbyzqOhzVt4lc6
	x/Y7iFb28A8zwwmsKBw4N2LYMm3lOj5b6WF9U3Wq2mOU+w9DAq4+6QaQau0E8vup8u3fl41tpiusF
	T0vvLIiem5YonMixgA8/h1gD1Jh1NNJ3YmDyzdAK96vaJdEjdgg0Yn9Vyx1GAWUVQ6F9PdHxiOV/H
	/dQk01bAj4dYWUTy2UWhPhXwb+trXPa0JZViRNxPiIB3Udb4Iq/8Th2HOMLsXnEgja4tbGBeNq26Y
	cIMgvJeQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqb4G-0000000HP3N-3D12;
	Mon, 25 Aug 2025 17:33:16 +0000
Date: Mon, 25 Aug 2025 18:33:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH 13/52] has_locked_children(): use guards
Message-ID: <20250825173316.GP39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-13-viro@zeniv.linux.org.uk>
 <CAHk-=wh9H_EQZ+RH6POYvZBuGESa63-cn5yJHUD0CKEH7-=htw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9H_EQZ+RH6POYvZBuGESa63-cn5yJHUD0CKEH7-=htw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 07:54:45AM -0400, Linus Torvalds wrote:
> [ diff edited to be just the end result ]
> 
> On Mon, 25 Aug 2025 at 00:44, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >  bool has_locked_children(struct mount *mnt, struct dentry *dentry)
> >  {
> > +       scoped_guard(mount_locked_reader)
> > +               return __has_locked_children(mnt, dentry);
> >  }
> 
> So the use of scoped_guard() looks a bit odd to me. Why create a new
> scope for when the existing scope is identical? It would seem to be
> more straightforward to just do
> 
>         guard(mount_locked_reader);
>         return __has_locked_children(mnt, dentry);
> 
> instead. Was there some code generation issue or other thing that made
> you go the 'scoped' way?
> 
> There was at least one other patch that did the same pattern (but I
> haven't gone through the whole series, maybe there are explanations
> later).

TBH, the main reason is that my mental model for that is
	with_lock: lock -> m X -> m X
pardon the pseudo-Haskell.  IOW, "wrap that sequence of operations into
this lock".

Oh, well - I can live with open-ended scope in a function that small and
that unlikely to grow more stuff in it...

