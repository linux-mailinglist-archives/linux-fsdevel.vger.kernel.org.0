Return-Path: <linux-fsdevel+bounces-33733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64E9BE372
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F91D1C20E17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408F1DC748;
	Wed,  6 Nov 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrziH8Gr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2561173;
	Wed,  6 Nov 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887422; cv=none; b=jdXdcn8ooiTeWeFbiPfXpsLtQu7qQ7Ws1fleu4+9wJGXVAhqO1Jx0UhNTfB/3OH9slmYW/KgsqcKYJeKZpx0qbKahKHvoFyw1/wWWQKKESVXaq1gWxHcoZRPy9vsFRACCi1pQxbZBN+SkG5Qp5IBLh+jAaZ0uZD37525aEmy02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887422; c=relaxed/simple;
	bh=RqW/PLYszbKVRbzKd1XTwtY3NTuWYNXvgeKpbxrXWKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Elz7SJyqf699C/UjfelaMLDxU1R3HRREdbH0m0NzTpPtxEVGYqiyC20rTpnrEuhXLQg+5Ig+YujJbhxORJtjj0EHqbV2LDr+EgSxRDRkfRJfiC2fc0q7tH3gWogTKGCFSj2Dp00g+uYA2+bX8dueu1u6iEUWbRYV/YbNmNG7xXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrziH8Gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0E7C4CECD;
	Wed,  6 Nov 2024 10:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730887421;
	bh=RqW/PLYszbKVRbzKd1XTwtY3NTuWYNXvgeKpbxrXWKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrziH8Gr2qx7PhK64n3kricgJW7FsJKQwaBwhqReMzhugV2UA9XidDWUEjP+gZWBs
	 Q9RrMg0w+Qkj2BTmfN1z38DpY1qaZkHXpFvnuyiw5kEMSjlAbVjL4kbfPDi7M8wnzU
	 C/hxJNSHi7+84Rc+jIHCnkkN46BoDi3mvzxH1U2fTBmyFPXm5RainWHvd/iAvj1g2j
	 armhe52ryvOBcqACfZSmvCJoXivytmsJfZnWAKq6XIfVicjYbJAt14IC0f+uTHqEmg
	 rTY0mId8wxcuf1SKun4SQYhc0gmh+NF4G4DF71OE5DmNJYAG5RTmTYmLvTSxyjdDQk
	 7u1v9v69e58Jw==
Date: Wed, 6 Nov 2024 10:03:37 +0000
From: Simon Horman <horms@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	cgroups@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 01/28] net/socket.c: switch to CLASS(fd)
Message-ID: <20241106100337.GL4507@kernel.org>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
 <20241102122132.GH1838431@kernel.org>
 <20241103063113.GR1350452@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103063113.GR1350452@ZenIV>

On Sun, Nov 03, 2024 at 06:31:13AM +0000, Al Viro wrote:
> On Sat, Nov 02, 2024 at 12:21:32PM +0000, Simon Horman wrote:
> 
> > > @@ -2926,16 +2900,18 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
> > >  
> > >  	datagrams = 0;
> > >  
> > > -	sock = sockfd_lookup_light(fd, &err, &fput_needed);
> > > -	if (!sock)
> > > -		return err;
> > > +	CLASS(fd, f)(fd);
> > > +
> > > +	if (fd_empty(f))
> > > +		return -EBADF;
> > > +	sock = sock_from_file(fd_file(f));
> > > +	if (unlikely(!sock))
> > > +		return -ENOTSOCK;
> > 
> > Hi Al,
> > 
> > There is an unconditional check on err down on line 2977.
> > However, with the above change err is now only conditionally
> > set before we reach that line. Are you sure that it will always
> > be initialised by the time line 2977 is reached?
> 
> Nice catch, thank you.  It is possible, if you call recvmmsg(2) with
> zero vlen and MSG_ERRQUEUE in flags.  Which is not going to be done in
> any well-behaving code, making it really nasty - nothing like a kernel
> bug that shows up only when trying to narrow down a userland bug upstream
> of the syscall in question ;-/

Ouch.

> AFAICS, that's the only bug of that sort in this commit - all other
> places that used to rely upon successful sockfd_lookup_light() zeroing
> err have an unconditional assignment to err shortly downstream of that.

Yes, I was unable to find any others either.

> 
> Fix folded into commit in question, branch force-pushed; incremental follows
> (I would rather not spam the lists with repost of the entire patchset for
> the sake of that):

Thanks, will run some checks for good measure.
But the fix below looks good to me.

> diff --git a/net/socket.c b/net/socket.c
> index fb3806a11f94..c3ac02d060c0 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2885,7 +2885,7 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
>  			  unsigned int vlen, unsigned int flags,
>  			  struct timespec64 *timeout)
>  {
> -	int err, datagrams;
> +	int err = 0, datagrams;
>  	struct socket *sock;
>  	struct mmsghdr __user *entry;
>  	struct compat_mmsghdr __user *compat_entry;
> 

