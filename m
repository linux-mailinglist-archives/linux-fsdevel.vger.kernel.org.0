Return-Path: <linux-fsdevel+bounces-48562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9056AAB10CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2F14A2E0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D017B28EA4F;
	Fri,  9 May 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5gaGg+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7038FA3;
	Fri,  9 May 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786786; cv=none; b=r/Y2MeGCgVqWEYyTWnXix0CGSw092ngK1R9goyat8dn1PwUSwS8Lwr6Qil7GHCBbKyIWTbPexcjyOsRv12sjmBquAqdh0Nfk6a5msbT3wHmnhBI9R/lckCOnq8iP0zOMyozpxGZx+TV+3oQ8wxuj2kT1PqNn3Rov9bBnd53aj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786786; c=relaxed/simple;
	bh=KkMFDCaVIF08+RcZ8ATudO+qvG2u0TSiyy7n3UTijwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnN2tQbq8pItfKl1pkmaa353rdRIyT+9ohnZutCnREv/dJFVQ2Y3sQx95PPSSW/XrKCJV3Dxcz5cZ1hZ3FNIQ42wqI6RqHLJpOPvJtDncRtiJdYF2DlwLFFS7lyjN3CgNMlbQMVaUyYqTUicLhGnZE8J2hshbkusQmQ7Ej6gMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5gaGg+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37BFC4CEE4;
	Fri,  9 May 2025 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786785;
	bh=KkMFDCaVIF08+RcZ8ATudO+qvG2u0TSiyy7n3UTijwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5gaGg+USCmi1nsRdRmhbFwT8U4CTi64nWm2Ld6mzDZnZJmPWI75bm4l3B9mZeQj8
	 fRTIDsQTl8rGrHHmw6NKlKqmk619lgOgk3qSWekzyEu1EsX0xXNb5ySClpiGEpZImR
	 x4Y8U8nJhXU9DTHEmT6yKJCMfqaF4oYzTO1/gbHm8dXcqJ7s8MGJGS7jPe8txfxVyN
	 +/Ya9SpWx493jsmk3rCCQ53iby5UL5V/VjDDTNWoy0Tds2NLqKOUYpG2e+xfb/K/YD
	 3lWw1G6+6ybV9Xaevnu3TYRczvB1MIlH9i4YDYc5mh/djQm8WJagqpFw18mBn5nPsz
	 nDDRp0hVfwMDA==
Date: Fri, 9 May 2025 12:33:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Etienne Champetier <champetier.etienne@gmail.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Jeffrey Altman <jaltman@auristor.com>, Chet Ramey <chet.ramey@case.edu>, 
	Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org, openafs-devel@openafs.org, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
Message-ID: <20250509-deckung-glitschig-8d27cb12f09f@brauner>
References: <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
 <433928.1745944651@warthog.procyon.org.uk>
 <1209711.1746527190@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1209711.1746527190@warthog.procyon.org.uk>

On Tue, May 06, 2025 at 11:26:30AM +0100, David Howells wrote:
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > > However, the bash work around is going to be removed:
> > 
> > Why is it removed? That's a very strange comment:
> 
> Because it makes bash output redirection work differently to other programs, I
> would guess.  It's actually a simple security check to work around (just retry
> the open() with O_CREAT dropped) - however, it does expose an... error, I
> suppose, in the Linux kernel: namely that the VFS itself is treating foreign
> files as if they had local system ownership.
> 
> We have the ->permission() inode op for this reason (I presume) - but that
> only applies to certain checks.  The VFS must not assume that it can interpret
> i_uid and i_gid on an inode and must not assume that it can compare them to
> current->fsuid and current->fs_gid.
> 
> Now, in my patch, I added two inode ops because they VFS code involved makes
> two distinct evaluations and so I made an op for each and, as such, those
> evaluations may be applicable elsewhere, but I could make a combined op that
> handles that specific situation instead.

Try to make it one, please.

