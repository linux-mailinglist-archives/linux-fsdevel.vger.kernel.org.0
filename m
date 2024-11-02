Return-Path: <linux-fsdevel+bounces-33562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F2B9B9FFD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 13:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D51B21271
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF41F18A6A8;
	Sat,  2 Nov 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA1pol+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35528149E16;
	Sat,  2 Nov 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730550103; cv=none; b=e6woYNsd+pgVx/GvTZk6qAIF78k2IFJTR7kD2ll4Is5fcFkdJzNUEvdOt/ozA8kx7b+LVfictJmK3Vx5ZuEeqiO3eWP0UvPCrllMFGYPba2tinU8bqilVuvCqQLv6ZShpNf8slaoE5RSm74RTUqR/zvvZCUe34Ve4y9m5Md0WuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730550103; c=relaxed/simple;
	bh=EUcbs1cSrphp8pI7Q6rosjx620b4eV5z/fHgLoriit4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtR3R4tli8drkgUsrxbTM6yprme1vg2jOK5NtZL+mf6/EA+TATyxRI+TyfAVDfPRtYSVCLQM8ysCXeXoVhIo+n91IpwN2010cVYaca1fs3TkP/0vJFeNAGVcbCv4gOLBj4ylyi/oecSEuNHUkoxlcmsm1np5nVeqRmqlnXSyFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA1pol+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7F7C4CEC3;
	Sat,  2 Nov 2024 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730550102;
	bh=EUcbs1cSrphp8pI7Q6rosjx620b4eV5z/fHgLoriit4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eA1pol+o0LuK3tzs+pdYsRUx47ng/osqRkSYRBzDArN+eNs/QJXVS/WJWFU4hqVfp
	 wzXtp44VX1j8N2q3QvKziMTBI3xjlRp+Re4FSskzFkA8W2aGJ6/CPJB3FCyWN7EJKo
	 Bi74c6aEVLz2nDzu/qlCoR1AXvJ599AqO/F7cOm9Od9Y8KzyNB9gvu+tCk/FEw307a
	 1UzHi1f54zlnl0sehHIKu+RkDWsOeYExwpCm+iB7xT3upaAK20GPsL2G79UcgmV313
	 +chh/jHmYRLr6+HRzqaVUu7+JVJNBu9EEkGK1C3tlg3cc6bIMYCt8K+GT3ZIneLAIL
	 HgQTboIMoDFGA==
Date: Sat, 2 Nov 2024 12:21:32 +0000
From: Simon Horman <horms@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	cgroups@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 01/28] net/socket.c: switch to CLASS(fd)
Message-ID: <20241102122132.GH1838431@kernel.org>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>

On Sat, Nov 02, 2024 at 05:07:59AM +0000, Al Viro wrote:
> 	The important part in sockfd_lookup_light() is avoiding needless
> file refcount operations, not the marginal reduction of the register
> pressure from not keeping a struct file pointer in the caller.
> 
> 	Switch to use fdget()/fdpu(); with sane use of CLASS(fd) we can
> get a better code generation...
> 
> 	Would be nice if somebody tested it on networking test suites
> (including benchmarks)...
> 
> 	sockfd_lookup_light() does fdget(), uses sock_from_file() to
> get the associated socket and returns the struct socket reference to
> the caller, along with "do we need to fput()" flag.  No matching fdput(),
> the caller does its equivalent manually, using the fact that sock->file
> points to the struct file the socket has come from.
> 
> 	Get rid of that - have the callers do fdget()/fdput() and
> use sock_from_file() directly.  That kills sockfd_lookup_light()
> and fput_light() (no users left).
> 
> 	What's more, we can get rid of explicit fdget()/fdput() by
> switching to CLASS(fd, ...) - code generation does not suffer, since
> now fdput() inserted on "descriptor is not opened" failure exit
> is recognized to be a no-op by compiler.
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

...

> diff --git a/net/socket.c b/net/socket.c

...

> @@ -2926,16 +2900,18 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
>  
>  	datagrams = 0;
>  
> -	sock = sockfd_lookup_light(fd, &err, &fput_needed);
> -	if (!sock)
> -		return err;
> +	CLASS(fd, f)(fd);
> +
> +	if (fd_empty(f))
> +		return -EBADF;
> +	sock = sock_from_file(fd_file(f));
> +	if (unlikely(!sock))
> +		return -ENOTSOCK;

Hi Al,

There is an unconditional check on err down on line 2977.
However, with the above change err is now only conditionally
set before we reach that line. Are you sure that it will always
be initialised by the time line 2977 is reached?

...

