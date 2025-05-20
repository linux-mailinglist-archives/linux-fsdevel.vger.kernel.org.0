Return-Path: <linux-fsdevel+bounces-49525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE3ABDE17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF0D4E04BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740F4248F70;
	Tue, 20 May 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DzdjM/0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B024BC1A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752280; cv=none; b=Dk9cFPAtH6hSkYWEa9u/6xu1iFuZixtelTJ0l5gD4aXywD5whp47C5wh0gXcCZYAx0c4lqAW8du5ivgpvjp0a6ZRZvCvwM8BKv78hRJay5rq7cf3MeOvbPJBe/eaI2X4ngxiCyKlBsg5qlVndJgOn2djiJXWZ3cWASBwzjKtOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752280; c=relaxed/simple;
	bh=p+jrXroPVL6qpOsR5dFITAXCzZegx2eFAm+w0V1CNtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAYLeT5ikEl+yyDYoyy+Go+RGgny5TZagnH8zk3VTPY/PZvOYcgPQY4MZLUvIv5kmHjfGMrMKC98lK6gbUJgIgIlbKFKKfgoynx/MFe9hIo0xJBrcZWyVRRMkSJOC90EV4Ijy4g1juy51an4BtNlEbwJCdSAnxItd2ltoLy2yv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DzdjM/0K; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 May 2025 10:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747752275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWzatSjly2i44jJi/D2beFghePppjurv+w7saIoXdt0=;
	b=DzdjM/0KpELm9TEMex+3PTMOk9YPNySt/PFQvilqmb61LoFnmWn3UkfKZtAKhVCt/dUVT9
	axMwhx2RsyXALqpdDzxerqYpuMheuaTk+bsaYI+zGp6QTXG1BZy2wh9a+o4+W9/ev/gWSW
	k9MlSF4NPo3WnHn6dISnah8ZzN3uFe4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
Message-ID: <7sa3ouxmocenlbh3r3asraedbbr6svljroyml3dpcoerhamwmy@gb32bhm4jqvh>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 20, 2025 at 04:33:14PM +0200, Amir Goldstein wrote:
> On Tue, May 20, 2025 at 4:12 PM Kent Overstreet
> > Amir, you've got two widely used filesystem features that conflict and
> > can't be used on the same filesystem.
> >
> > That's _broken_.
> 
> Correct.
> 
> I am saying that IMO a smaller impact (and less user friendly) fix is more
> appropriate way to deal with this problem.

Less user friendly is an understatement.

Obscure errors that only get reported via overloaded standard error
codes is a massive problem today, for _developers_ - have you never had
a day of swearing over trying to track down where in a massive subsystem
an -EINVAL is coming from?

It's even worse for end users that don't know to check the dmesg log.

And I support my code, so these would turn into bug reports coming
across my desk - no thanks; I already get enough weird shit from other
subsystems that I have to look at and at least triage.

> > Users hate partitioning just for separate /boot and /home, having to
> > partition for different applications is horrible. And since overlay fs
> > is used under the hood by docker, and casefolding is used under the hood
> > for running Windows applications, this isn't something people can
> > predict in advance.
> 
> Right, I am not expecting users to partition by application,
> but my question was this:
> 
> When is overlayfs created over a subtree that is only partially case-folded?
> 
> Obviously, docker would create overlayfs on parts of the fs
> and smbd/cygwin could create a case folder subtree on another
> part of the fs.
> I just don't see a common use case when these sections overlap.

Today, you cannot user docker and casefolding on _different parts of_
the same filesystem.

So yees, today users do have to partition by application, or only use
one feature or the other.

This isn't about allowing casefolding and overlayfs to fix on the same
subtree, that would be a bigger project.

> Perhaps I am wrong (please present real world use cases),
> but my claim is that this case is not common enough and therefore,
> a suboptimal EIO error from lookup is good enough to prevert crossing
> over into the case folded zone by mistake, just as EIO on lookup is
> enough to deal with the unsupported use case of modifying
> overlayfs underlying layers with overlay is mounted.
> 
> BTW, it is not enough to claim that there is no case folding for the
> entire subtree to allow the mount.
> For overlayfs to allow d_hash()/d_compare() fs must claim that
> these implementations are the default implementation in all subtree
> or at least that all layers share the same implementation.

I honestly don't know what you're claiming here.

