Return-Path: <linux-fsdevel+bounces-51450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99DAAD702B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50061BC69E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134119DF66;
	Thu, 12 Jun 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSQ7XtNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E492F431E;
	Thu, 12 Jun 2025 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730902; cv=none; b=tpYqieJMYuFNYir8kB8Ehj1SfznRjiaCX7AXQVVyis5OqVEtAmj2q2PGQNaYNg4ayECqlA0jlzFbkPwAhHx9Yf0VHlJxSdmjL2sYJyD0aYKmIAAHd3a2zAQPQoWnyb1VcJend9zsXb2OsveVYpgr/vnD63M707cHgrmiigSRhWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730902; c=relaxed/simple;
	bh=jMub8+Ya8ghmQ/qCgFJGnUqLLospMFuG9+31wf0sbCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuICM4Ju+KJD1exFKruSpjvmA0toFERieB2/LRMR90QnIloN9iZ7+/cZ4XiHd54H8ELadQ5vlwvFHGtZo/9xGIQtTfI1gqgiG+Af6uLYeTRUO3vIQEzMFbfoaIJUyGDfByynZtwzpIF5hSCL3jDmMbrBypK0LTY39KvHg8rViyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSQ7XtNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C41DC4CEEA;
	Thu, 12 Jun 2025 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749730901;
	bh=jMub8+Ya8ghmQ/qCgFJGnUqLLospMFuG9+31wf0sbCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSQ7XtNButpwRWlSCeexUlrkuwXlubRyrDfeMKJA9fBlTkM3Ad9Ccl005rArhX9D9
	 fgCacDWxNDYKL9w3px2yevqe/EBIgtsSf9gUrP9pAk8qBgLnjr1Wr0p+eKzfWLzh+v
	 40UiLmpPjUmlqahBbDqWZQ69CEMDkHwv70UFCsbUeUDdkWPToaByss2jKBlV/6CioN
	 lGL8isf9TgsGlTJyy3FuyTns0I+YXTDpEaxbB8Vf2MfWuom0yfsBiIgX8lRyCVdK72
	 MV5jlhNt0wK+NtmdZ7VijgK/saXEibw4HgWNl9D28v7kKXdV/XMy2IM/f+kC9QjE1x
	 iyEnGsi+l9DfA==
Date: Thu, 12 Jun 2025 14:21:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Collin Funk <collin.funk1@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	eggert@cs.ucla.edu, bug-gnulib@gnu.org
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
Message-ID: <20250612-trabant-erbost-3c1983e42085@brauner>
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
 <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
 <87plfhsa2r.fsf@gmail.com>
 <CAHC9VhRSAaENMnEYXrPTY4Z4sPO_s4fSXF=rEUFuEEUg6Lz21Q@mail.gmail.com>
 <20250611-gepunktet-umkurven-5482b6f39958@brauner>
 <CAHC9VhQYi2k3eamrn+kPkooZQpQ4cdsjs=nvntRVbz4=wz1rzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQYi2k3eamrn+kPkooZQpQ4cdsjs=nvntRVbz4=wz1rzA@mail.gmail.com>

On Wed, Jun 11, 2025 at 11:45:03AM -0400, Paul Moore wrote:
> On Wed, Jun 11, 2025 at 6:05 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jun 10, 2025 at 07:50:10PM -0400, Paul Moore wrote:
> > > On Fri, Jun 6, 2025 at 1:39 AM Collin Funk <collin.funk1@gmail.com> wrote:
> > > > Paul Moore <paul@paul-moore.com> writes:
> > > > >> <stephen.smalley.work@gmail.com> wrote:
> > > > >> >
> > > > >> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
> > > > >> > include security.* xattrs") failed to reset err after the call to
> > > > >> > security_inode_listsecurity(), which returns the length of the
> > > > >> > returned xattr name. This results in simple_xattr_list() incorrectly
> > > > >> > returning this length even if a POSIX acl is also set on the inode.
> > > > >> >
> > > > >> > Reported-by: Collin Funk <collin.funk1@gmail.com>
> > > > >> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
> > > > >> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> > > > >> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2369561
> > > > >> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always include security.* xattrs")
> > > > >> >
> > > > >> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > >> > ---
> > > > >> >  fs/xattr.c | 1 +
> > > > >> >  1 file changed, 1 insertion(+)
> > > > >>
> > > > >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > > >
> > > > > Resending this as it appears that Stephen's original posting had a
> > > > > typo in the VFS mailing list.  The original post can be found in the
> > > > > SELinux archives:
> > > > >
> > > > > https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@gmail.com/
> > > >
> > > > Hi, responding to this message since it has the correct lists.
> > > >
> > > > I just booted into a kernel with this patch applied and confirm that it
> > > > fixes the Gnulib tests that were failing.
> > > >
> > > > Reviewed-by: Collin Funk <collin.funk1@gmail.com>
> > > > Tested-by: Collin Funk <collin.funk1@gmail.com>
> > > >
> > > > Thanks for the fix.
> > >
> > > Al, Christian, are either of you going to pick up this fix to send to
> > > Linus?  If not, any objection if I send this up?
> >
> > It's been in vfs.fixes for some time already and it'll go out with the
> > first round of post -rc1 fixes this week.
> 
> Great, thanks.  I didn't see any replies on-list indicating that the
> patch had been picked up, so I just wanted to make sure someone was

Hm, odd. I did send a b4 ty I'm pretty sure.

