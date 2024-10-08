Return-Path: <linux-fsdevel+bounces-31327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D227B9949B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D91F267F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3082E1DED58;
	Tue,  8 Oct 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAnsVOU/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7CA1E485;
	Tue,  8 Oct 2024 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390304; cv=none; b=ZR0xixvidVQxAdja+0HRHmOk7Ik9gHYmR5XE7zC7dN7rEkWVhHsKXoD6d8BoGqCJO2SP3IlDu/JpXpPPvnV2tz/I02k+XBsq2qNJGKZHBwuyjkWzw34+PL22sZ9Bvw56pzQfu+Mcl0y3cWaMNKd6HCZQmurIeVEnkOOkWOUBgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390304; c=relaxed/simple;
	bh=5Y375q8ATxO/uo3+9uLQYTUtj+Wm5ldjck50UO6hkCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scx4DtahjjGAJXikAlJD1Pq6EjH5bmGqQXWyd2/0z6vYTPQNcfGiQZwmsLLbsE4+yS2Ru2uEC2WPddNBL/pHOU8mG4dP3DXr9r1KnY02NJV0a2OhWB48mY3uL8CCCNF3f/vRzhMLlMGQDWscZKUV+O9T99pPlq6cBGAeYHc2Z4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAnsVOU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8706AC4CEC7;
	Tue,  8 Oct 2024 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728390304;
	bh=5Y375q8ATxO/uo3+9uLQYTUtj+Wm5ldjck50UO6hkCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kAnsVOU/V0FHPjC+2xH9qP8phOq+80tmRFp6NDkvEoievoubAG7taRqqQBNw57Yae
	 IdeCjGqOuZm7dIFWMq0YNBo3GVhtm0apouLJt+yKr8VsqwqruRgZDIzEDSmbs6d5Qt
	 Dt2Rn6kpeg06i5CNy0i1NpIw2ONfeLWmYdp/HYvDybCfqfZmSBhAFt2uZFFOUJKEfG
	 7hvnApgcLNmeIo+gpVcCTsjl7Ae1y7LKlWdsFZ45mS/QaOI3wMK1c/hDxgvh7BRyKw
	 9tsiEpet+xjzORQm5JkWY6kQe/HxmwH4Jv/pABBu/Z9gQ4UARmZZYcz02zKt6LTJe6
	 s/pdIKE8OwJlw==
Date: Tue, 8 Oct 2024 14:25:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fcntl: make F_DUPFD_QUERY associative
Message-ID: <20241008-bohrmaschine-falter-49ebcdf42afa@brauner>
References: <20241008-duften-formel-251f967602d5@brauner>
 <bb13f7016a1184196d959c2e2421fde820dcc30a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb13f7016a1184196d959c2e2421fde820dcc30a.camel@kernel.org>

On Tue, Oct 08, 2024 at 07:42:51AM GMT, Jeff Layton wrote:
> On Tue, 2024-10-08 at 13:30 +0200, Christian Brauner wrote:
> > Currently when passing a closed file descriptor to
> > fcntl(fd, F_DUPFD_QUERY, fd_dup) the order matters:
> > 
> >     fd = open("/dev/null");
> >     fd_dup = dup(fd);
> > 
> > When we now close one of the file descriptors we get:
> > 
> >     (1) fcntl(fd, fd_dup) // -EBADF
> >     (2) fcntl(fd_dup, fd) // 0 aka not equal
> > 
> > depending on which file descriptor is passed first. That's not a huge
> > deal but it gives the api I slightly weird feel. Make it so that the
> > order doesn't matter by requiring that both file descriptors are valid:
> > 
> > (1') fcntl(fd, fd_dup) // -EBADF
> > (2') fcntl(fd_dup, fd) // -EBADF
> > 
> > Fixes: c62b758bae6a ("fcntl: add F_DUPFD_QUERY fcntl()")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Lennart Poettering <lennart@poettering.net>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/fcntl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index 22dd9dcce7ec..3d89de31066a 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -397,6 +397,9 @@ static long f_dupfd_query(int fd, struct file *filp)
> >  {
> >  	CLASS(fd_raw, f)(fd);
> >  
> > +	if (fd_empty(f))
> > +		return -EBADF;
> > +
> >  	/*
> >  	 * We can do the 'fdput()' immediately, as the only thing that
> >  	 * matters is the pointer value which isn't changed by the fdput.
> 
> Consistency is good, so:
> 
>     Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
> ...that said, we should document that -EBADF means that at least one of
> the fd's is bogus, but this API doesn't tell you which ones those are.
> To figure that out, I guess you'd need to do something like issue
> F_GETFD against each and see which ones return -EBADF?

It's actually worse because fcntl() can also give you EBADF if you have
an O_PATH file descriptor and you request an option that won't work on
an O_PATH file descriptor. It's complete nonsense.

So the most reliable way to figure out whether the fd is valid, is to
use a really really old fcntl() like idk F_GETFD and call it. Because
that should always work (ignoring really stupid things such as using
seccomp or an LSM to block F_GETFD) and if you get EBADF it must be
because the file descriptor isn't valid. Obviously that's racy if the
fdtable is shared but I don't think it's a big problem.

So if you get EBADF from F_DUPFD_QUERY and you really really need to
know whether the kernel supports it or any of the two fds was invalid
then yes, you need to follow this up with a F_GETFD. Again, racy but
won't matter most of the time.

Really, we should have returned something like EOPNOTSUPP from fcntl()
for the O_PATH case that would've meant that it's easy to detect new
flags.

