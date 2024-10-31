Return-Path: <linux-fsdevel+bounces-33381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339AD9B861A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 23:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F6B1F227C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FEF1CF7D8;
	Thu, 31 Oct 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bTJ9KSYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999813AD32
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730413726; cv=none; b=lAJxBACcRWTVuRpuWkBF1yc53YQkjDgjVCEHGIOecGsMu7ZV8SD7g3L/TqJMTEUCLPvD2ghPn1MHA1qJRT81d/j1Yzv9ZAw7npGc5ggkPfWqqFksnqbi36QjhvMzHqEpoeFBr3ns5WJg6+kXoh5xIDdC+A2PcwPKP/EFDJAgq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730413726; c=relaxed/simple;
	bh=LvKoIHCsCvgYesGGOiaSa6NeCXPNG3fGPMi90MNprX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB391+IkelDc4x6NZvYCVXP8z6HbvJJaEybieVl0ER3gCDqTJS77HQndr74dNamTw7eqX77+noMs1yFt/oJj8gy3oEZAECcHxhplbPo0AjmUkQTJdCkyqm3/fRdhxqu2PlhCmovsfGWUCMK/owbvTgZgIdY/tbzBtqVxFfrpZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bTJ9KSYb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iQmtlwpjoBuhDIKrVX2ROSacAEL4zQOlW3vjcGcm8YA=; b=bTJ9KSYbbWYhngnYaOIi9Ke/sq
	XIpXgKyjuVpJ/TZsiM1ma0xDntrTflaRdOn0TTY6WO0g+rOEOKX9Z3ZaI3xPd4UoxziYPhf2jGaX8
	+7Ij34UZjoy7meHhCLDjphY9ueTQOdqpg99/+0MrHRT9Aclixp4D6zOQO3WUeoRZvWGPX7rhNXyiV
	N6Pu3pi1tnSni1wQJOeHcqfiYqRiVlrKSU7dM1+LPVTuOlPGPlHlzTpL2v1r0c0I5xz5rk6pNSf0p
	b/JpAYfGwyaMxthsJx8ZyEBavPZtulG7RYd43nGB7uy/fDFKyCNF6yKsrGqUnZ+UfLksKYbnrMbE5
	2xUTEnEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6def-00000009uCi-3drG;
	Thu, 31 Oct 2024 22:28:37 +0000
Date: Thu, 31 Oct 2024 22:28:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20241031222837.GM1350452@ZenIV>
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031060507.GJ1350452@ZenIV>
 <CAHk-=wh-Bom_pGKK+-=6FAnJXNZapNnd334bVcEsK2FSFKthhg@mail.gmail.com>
 <CAHk-=wj16HKdgiBJyDnuHvTbiU-uROc3A26wdBnNSrMkde5u0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj16HKdgiBJyDnuHvTbiU-uROc3A26wdBnNSrMkde5u0w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 31, 2024 at 08:14:59AM -1000, Linus Torvalds wrote:
> On Wed, 30 Oct 2024 at 20:42, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I was kind of hoping that such cases would use 'cache_no_acl()' which
> > makes that inode->i_acl be NULL. Wouldn't that be the right model
> > anyway for !IS_POSIXACL()?
> 
> Alternatively, just initialize it to NULL in inode_init_always_gfp(), eg like
> 
> -       inode->i_acl = inode->i_default_acl = ACL_NOT_CACHED;
> +       inode->i_acl = inode->i_default_acl =
> +               (sb->s_flags & SB_POSIXACL) ? ACL_NOT_CACHED : NULL;

IIRC, the reason we do not do that was the possibility of mount -o remount,acl
Not that it makes much sense, but it's currently supported and POSIX ACLs
don't make much sense to start with...

Anyway, patch looks sane; I still think that adding || !IS_POSIXACL(inode)
wouldn't hurt (yes, it's a dereference of ->i_sb in case when ->i_acl
is ACL_NOT_CACHED, but we are going to dereference it shortly after
in case we don't take the fast path.  OTOH, that probably matters only
for fairly specific loads - massive accesses to procfs and sysfs, mostly.

