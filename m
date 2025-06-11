Return-Path: <linux-fsdevel+bounces-51275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A14AD513C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C196B1BC0237
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C5267AF0;
	Wed, 11 Jun 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz9x0vgP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229292620E5;
	Wed, 11 Jun 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636312; cv=none; b=m6Gpm+eL+n3qevxqZprAFL15hMOJIex+HV8ikoE/V2OiMrzBmD4ibEjiEnaQ5XdOtAf7h/r9seQFc4TqmwRzBxRtSmo38Q5F5soeufVsgcvG2ImDy7YAViqlAf3wI5Le/T6fYu//gBHOVcb+Lhtukp90eaFXOqseGvnQPWROxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636312; c=relaxed/simple;
	bh=gPaP3WMO/RLExljCqXnu0HKGZ3gE4EOR9JfvXxizfI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGYJ4yvM/SvAA1x3onnDLBBuHSUxN7BBSG6iwBXEzRqf087NHJkflbes3JUFGVMu8HCHGdyQvurNYoU8jxTmd/kwGLKBjYszTNQHlW5pNRONJmToG6V20VK1bB9hE9SpQPaq2rCbQeRqQmzUN8kIvIWIiYBYMvDqTiCJ6WB0Ixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz9x0vgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A8AC4CEEE;
	Wed, 11 Jun 2025 10:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636312;
	bh=gPaP3WMO/RLExljCqXnu0HKGZ3gE4EOR9JfvXxizfI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mz9x0vgPlloUBypKgcgmt2mjSkqPYSOoGHVjZmP7Yv8KIOEI6Eu3meYJucSkiN13d
	 +8V3DlRC9nacOJMZqzHsQCHTCp6KbTrO8nSIYykx5Rsl/yGzsF7K6Zcu8gi6ZpF4Cr
	 3vC6SaTgwqIiCM3txQRb4OukbNP6lkAxKBpBjiaf7Wke5Fdq4EeKCmHU+EXmYJ8+XT
	 hrINlG12Fn27HOZayF3IO7QaEcZzdqc6fK8eyoL37aiEi3ygI6ZT77nGQtgVJz4lDN
	 rZuAuAOBl/eIXAyikuRsApL7TK0rhxiyaUNikxIGnUGKGmI5m90nqT+1EIVo0ow2C3
	 cw8qWT9nCvgZQ==
Date: Wed, 11 Jun 2025 12:05:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Collin Funk <collin.funk1@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	eggert@cs.ucla.edu, bug-gnulib@gnu.org
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
Message-ID: <20250611-gepunktet-umkurven-5482b6f39958@brauner>
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
 <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
 <87plfhsa2r.fsf@gmail.com>
 <CAHC9VhRSAaENMnEYXrPTY4Z4sPO_s4fSXF=rEUFuEEUg6Lz21Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRSAaENMnEYXrPTY4Z4sPO_s4fSXF=rEUFuEEUg6Lz21Q@mail.gmail.com>

On Tue, Jun 10, 2025 at 07:50:10PM -0400, Paul Moore wrote:
> On Fri, Jun 6, 2025 at 1:39 AM Collin Funk <collin.funk1@gmail.com> wrote:
> > Paul Moore <paul@paul-moore.com> writes:
> > >> <stephen.smalley.work@gmail.com> wrote:
> > >> >
> > >> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
> > >> > include security.* xattrs") failed to reset err after the call to
> > >> > security_inode_listsecurity(), which returns the length of the
> > >> > returned xattr name. This results in simple_xattr_list() incorrectly
> > >> > returning this length even if a POSIX acl is also set on the inode.
> > >> >
> > >> > Reported-by: Collin Funk <collin.funk1@gmail.com>
> > >> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
> > >> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> > >> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2369561
> > >> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always include security.* xattrs")
> > >> >
> > >> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >> > ---
> > >> >  fs/xattr.c | 1 +
> > >> >  1 file changed, 1 insertion(+)
> > >>
> > >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Resending this as it appears that Stephen's original posting had a
> > > typo in the VFS mailing list.  The original post can be found in the
> > > SELinux archives:
> > >
> > > https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@gmail.com/
> >
> > Hi, responding to this message since it has the correct lists.
> >
> > I just booted into a kernel with this patch applied and confirm that it
> > fixes the Gnulib tests that were failing.
> >
> > Reviewed-by: Collin Funk <collin.funk1@gmail.com>
> > Tested-by: Collin Funk <collin.funk1@gmail.com>
> >
> > Thanks for the fix.
> 
> Al, Christian, are either of you going to pick up this fix to send to
> Linus?  If not, any objection if I send this up?

It's been in vfs.fixes for some time already and it'll go out with the
first round of post -rc1 fixes this week.

