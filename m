Return-Path: <linux-fsdevel+bounces-17729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B1B8B1E86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C12328920F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862F8528D;
	Thu, 25 Apr 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8YA98lt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7498005B;
	Thu, 25 Apr 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038880; cv=none; b=s6lmNnML70stmfUGi3+EWRFOBOTpodZgblAltrpzyi/aocLgBlI+qhWzsBIBmDceNGlN+YE1MJkgfOgX7Mr/wr4b9vqlkMW/giEsb0bUYgi5xm721NPlpmKgfCtS6GNlnX5P2l9In1RjJyYG9OBGBHSYDB0vrtWzx5CCrIqjnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038880; c=relaxed/simple;
	bh=Hdtl/Gl5j4mz5TOTXpgnpl6AGib4dz13JCTXnJ9K0IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOiunMD/Z/D0mKrP4LChKtysgTXHPzRdrunNfj/yYRY78GmE0E6X5RYgPc/vdrU+ZF1ppFaeNsHFOm2MyDKFO8JcUrOuCn0jraE5WRmQYh5yurYMZwZZ/zyt1vnINfZf1rkVG1vQCJKkh+Trz7Zl9eTP3WfMGLXTAktLGtQKkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8YA98lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B87C113CC;
	Thu, 25 Apr 2024 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714038879;
	bh=Hdtl/Gl5j4mz5TOTXpgnpl6AGib4dz13JCTXnJ9K0IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8YA98ltaLXaJTJqkcZkD545MewKPful8f3DJvecUQ2AXDbIXGi/tNhNzJi7Cpq6q
	 TtFnRyIaTVNi7vAGNYLZSb0jbqijAMGOtFGtj+bWZA9xbG82+lRoRquboibW8RrK6Q
	 6R4CZjiCkOSqhr83X3hq0pAhj+VMq4y/tOPKKFkEmUWhrKXNG+gjKz/e3EGs+2x1YC
	 6zHP5iH5YvKvCQKyKOfCgQkpddE8DdKZCSvB5t7QLtSqkKPlN/D5wHHloGxN0vVnLH
	 JfM1RHpkNZQ6NM3+U9p/72vo7tqYi/N1l4HG8jQA8XgTnx4NVlp7PWnRQKQXJRqUde
	 ocfS5j046avvA==
Date: Thu, 25 Apr 2024 11:54:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: stsp <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH v4 0/2] implement OA2_INHERIT_CRED flag for openat2()
Message-ID: <20240425-ausfiel-beabsichtigen-a2ef9126ebda@brauner>
References: <20240424105248.189032-1-stsp2@yandex.ru>
 <20240424-schummeln-zitieren-9821df7cbd49@brauner>
 <6b46528a-965f-410a-9e6f-9654c5e9dba2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b46528a-965f-410a-9e6f-9654c5e9dba2@yandex.ru>

On Wed, Apr 24, 2024 at 08:50:30PM +0300, stsp wrote:
> 24.04.2024 19:09, Christian Brauner пишет:
> > This smells ripe enough to serve as an attack vector in non-obvious
> > ways. And in general this has the potential to confuse the hell out
> > unsuspecting userspace.
> 
> Unsuspecting user-space will simply
> not use this flag. What do you mean?
> 
> 
> >   They can now suddenly get sent such
> > special-sauce files
> 
> There are no any special files.
> This flag helps you to open a file on
> which you currently have no perms
> to open, but had those in the past.
> 
> 
> >   such as this that they have no way of recognizing as
> > there's neither an FMODE_* flag nor is the OA2_* flag recorded so it's
> > not available in F_GETFL.
> > 
> > There's not even a way to restrict that new flag because no LSM ever
> > sees it. So that behavior might break LSM assumptions as well.
> > 
> > And it is effectively usable to steal credentials. If process A opens a
> > directory with uid/gid 0 then sends that directory fd via AF_UNIX or
> > something to process B then process B can inherit the uid/gid of process
> 
> No, it doesn't inherit anything.
> The inheritance happens only for
> a duration of an open() call, helping
> open() to succeed. The creds are
> reverted when open() completed.
> 
> The only theoretically possible attack
> would be to open some file you'd never
> intended to open. Also note that a
> very minimal sed of creds is overridden:
> fsuid, fsgid, groupinfo.
> 
> > A by specifying OA2_* with no way for process A to prevent this - not
> > even through an LSM.
> 
> If process B doesn't use that flag, it
> inherits nothing, no matter what process
> A did or passed via a socket.
> So an unaware process that doesn't
> use that flag, is completely unaffected.

The point is that the original opener has no way to prevent his creds
being abused by a completely unrelated process later on. Something I've
clearly explained in my mail.

> 
> > The permission checking model that we have right now is already baroque.
> > I see zero reason to add more complexity for the sake of "lightweight
> > sandboxing". We have LSMs and namespaces for stuff like this.
> > 
> > NAK.
> 
> I don't think it is fair to say NAK
> without actually reading the patch
> or asking its author for clarifications.
> Even though you didn't ask, I provided
> my clarifications above, as I find that
> a polite action.

I'm not sure what you don't understand or why you need further
clarification. Your patch allows any opener using your new flag to steal
the uid/gid/whatever from the original opener. It was even worse in the
first version where the whole struct cred of the original opener was
used. It's obviously a glaring security hole that's opened up by this.

Let alone that the justification "It's useful for some lightweight
sandboxing" is absolutely not sufficient to justify substantial shifts
in the permission model.

The NAK stands.

