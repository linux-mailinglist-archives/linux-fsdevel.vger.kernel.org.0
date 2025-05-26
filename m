Return-Path: <linux-fsdevel+bounces-49875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81982AC44D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 23:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DAA189D860
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D8F242917;
	Mon, 26 May 2025 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PQS0uki/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29EE242901
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748295143; cv=none; b=M2vPUEaiz5JTf96MZk2vwOnmDMXNKSjyyh18mwvLi/rlTz6Ci3K502/9e8z98rJkhTJv5n2vTQOZxwOlX3uAD2QU4bAT35yhk9M7Snn10lM2i0wY2duNJAPw6ja5a8DouLKyEioArQeO9UDee4ynTLHVmVANw2parXmmqOsji3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748295143; c=relaxed/simple;
	bh=qo4emjMnuOH7w3ORfTgpaBl/lKlyWAKILERcAszOAQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prSEwpxC+QGWPyluuryUg5P9EK9WDC6J/mMLKYduat1MmGhEJKFJMjU5dbCROcMbmb4vDWTdzFW9bOUvmpsaIORV1MzcuOn4mgwWdACnknl1pGx3mz43hxFyXXS3nzbwPqOfuQggGFPFukRHl9FBXUWW40B2vqeFeaphlqH9yq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PQS0uki/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QIZ6JdAtJ9kPtcWQk0lS5uwDVp1SryVtH32h+fTsqC8=; b=PQS0uki/4v9Zh9N+xDIwX3ICOf
	NxIioSVSb6Kzz5YZaUC4E5Fi3uO5wmU3lHM/FSg/y46YzJTlm3PNy0dOdhDUvO/F2fZfVGT+EUIUN
	NXHUV+eUpq0BhME1RfTbS2le/oqpGtHMgIrucis78pNpGelR0FfKtHRrZjKZSj8/Sx72OAMgUjBzf
	VYsRlOtyZArdDpI97LA9zGY0jzzxuVMFj8gCs7b9mKJV1kHuZzO2H8/iEOqbmrZ0FtzAeP0doE063
	p/atqQEQc2D0z7P5jLHDhqc6AWHXqW+Hff7CNU+r2imtkNL8ULRMJSqCuGbouY0bjs0sQoFEtWcP5
	OQgvMvRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJfQf-00000008TlK-3Jdj;
	Mon, 26 May 2025 21:32:17 +0000
Date: Mon, 26 May 2025 22:32:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Apparent mount behaviour change in 6.15
Message-ID: <20250526213217.GY2023217@ZenIV>
References: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
 <20250515-abhauen-geflecht-c7eb5df70b78@brauner>
 <20250523063238.GI2023217@ZenIV>
 <20250523-aufweichen-dreizehn-c69ee4529b8b@brauner>
 <20250523212958.GJ2023217@ZenIV>
 <20250523213735.GK2023217@ZenIV>
 <20250523232213.GL2023217@ZenIV>
 <20250526-kondition-genehm-84f02ccedf54@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526-kondition-genehm-84f02ccedf54@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 26, 2025 at 06:47:25AM +0200, Christian Brauner wrote:
> On Sat, May 24, 2025 at 12:22:13AM +0100, Al Viro wrote:
> > On Fri, May 23, 2025 at 10:37:35PM +0100, Al Viro wrote:
> > > On Fri, May 23, 2025 at 10:29:58PM +0100, Al Viro wrote:
> > > 
> > > > This is bogus, IMO.  I'm perfectly fine with propagate_one() returning 0
> > > > on anon_ns(m->mnt); that would refuse to propagate into *any* anon ns,
> > > > but won't screw the propagation between the mounts that are in normal, non-anon
> > > > namespaces.
> > > 
> > > IOW, I mean this variant - the only difference from what you've posted is
> > > the location of is_anon_ns() test; you do it in IS_MNT_NEW(), this variant
> > > has it in propagate_one().  Does the variant below fix regression?
> > 
> > AFAICS, it does suffice to revert the behaviour change on the reproducer
> > upthread.
> > 
> > I've replaced the top of viro/vfs.git#fixes with that; commit message there
> > is tentative - if nothing else, that's a patch from Christian with slight
> > modifications from me.  It also needs reported-by, etc.
> > 
> > Said that, could somebody (original reporter) confirm that the variant
> > in git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #fixes (head at
> > 63e90fcc1807) is OK with them?
> > 
> > And yes, it will need a proper commit message.  Christian?
> 
> Yes, that looks good to me, thank you!

OK, I went with the following for commit message:

-----
Don't propagate mounts into detached trees

All versions up to 6.14 did not propagate mount events into detached
tree.  Shortly after 6.14 a merge of vfs-6.15-rc1.mount.namespace
(130e696aa68b) has changed that.

Unfortunately, that has caused userland regressions (reported in
https://lore.kernel.org/all/CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com/)

Straight revert wouldn't be an option - in particular, the variant in 6.14
had a bug that got fixed in d1ddc6f1d9f0 ("fix IS_MNT_PROPAGATING uses")
and we don't want to bring the bug back.

This is a modification of manual revert posted by Christian, with changes
needed to avoid reintroducing the breakage in scenario described in
d1ddc6f1d9f0.

Cc: stable@vger.kernel.org
Reported-by: Allison Karlitskaya <lis@redhat.com>
Tested-by: Allison Karlitskaya <lis@redhat.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
-----

It's in viro/vfs.git #fixes; if everyone's OK with the commit message, I'm
sending a pull request tomorrow.

