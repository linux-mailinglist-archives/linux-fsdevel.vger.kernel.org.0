Return-Path: <linux-fsdevel+bounces-49500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D77ABD85E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A58D173BE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA4B1A3A80;
	Tue, 20 May 2025 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E3NJTIyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9E1A0731
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747745039; cv=none; b=O8fuKPhz4IrGyAioTQkmekFAznj5KoQDqm/lkzc0zlCJaK69mooiwQj/LybM6YMqu1CoMjJ/aBwML3ouKEo1RR76FJksvhbvkYmNI/hHyRd3x+F5Pn2Sk/i1CG+A8rxcIs9hhV0th/yEqLPwV1BNQO1fDazR+dmRE5be/jwROQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747745039; c=relaxed/simple;
	bh=bQs2TS4LPEr8WtgwzfQ7lEcvHvSlnCr21QVr4ndNmdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nptct4oqhD9uadtUKAsQto7pYrYlMc8sFqxIGFHWCTmTggI+P60AFIWwcn44q81b4loW1wbjYohw2b58BjrN5FPa/r3G3Wz0gBg9mtTL0mAAciaECfHox2NcrFJ2ieuX3DeUR98yUCvNEJPHxtJuK271ZaQcBOLc5+Rc7E/q90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E3NJTIyN; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 May 2025 08:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747745025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlzUwipsgVlhh6jWRN3VNzJZUIXouswKqdaADWLb+qA=;
	b=E3NJTIyNU0rWA5+i8XfNlcvvAZTzIHAxLCdO4dPdrLjZUjNU6P6iBfgNaHoYLUnRW56Q47
	uq5XhqaqeXxgFxwJdwz2bgMu/p8TuTUqo9k3fA4OH8Mn4FI/5Ajb3UcOeLI40pQBJlA+b4
	zoDdfhYZ+aj+nKKcXOVtLCsi2QwOoUI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
Message-ID: <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 20, 2025 at 02:40:07PM +0200, Amir Goldstein wrote:
> On Tue, May 20, 2025 at 2:25 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Tue, May 20, 2025 at 10:05:14AM +0200, Amir Goldstein wrote:
> > > On Tue, May 20, 2025 at 7:16 AM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > This series allows overlayfs and casefolding to safely be used on the
> > > > same filesystem by providing exclusion to ensure that overlayfs never
> > > > has to deal with casefolded directories.
> > > >
> > > > Currently, overlayfs can't be used _at all_ if a filesystem even
> > > > supports casefolding, which is really nasty for users.
> > > >
> > > > Components:
> > > >
> > > > - filesystem has to track, for each directory, "does any _descendent_
> > > >   have casefolding enabled"
> > > >
> > > > - new inode flag to pass this to VFS layer
> > > >
> > > > - new dcache methods for providing refs for overlayfs, and filesystem
> > > >   methods for safely clearing this flag
> > > >
> > > > - new superblock flag for indicating to overlayfs & dcache "filesystem
> > > >   supports casefolding, it's safe to use provided new dcache methods are
> > > >   used"
> > > >
> > >
> > > I don't think that this is really needed.
> > >
> > > Too bad you did not ask before going through the trouble of this implementation.
> > >
> > > I think it is enough for overlayfs to know the THIS directory has no
> > > casefolding.
> >
> > overlayfs works on trees, not directories...
> 
> I know how overlayfs works...
> 
> I've explained why I don't think that sanitizing the entire tree is needed
> for creating overlayfs over a filesystem that may enable casefolding
> on some of its directories.

So, you want to move error checking from mount time, where we _just_
did a massive API rework so that we can return errors in a way that
users will actually see them - to open/lookup, where all we have are a
small fixed set of error codes?

