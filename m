Return-Path: <linux-fsdevel+bounces-33579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120879BA449
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 07:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C873281B59
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1304215572C;
	Sun,  3 Nov 2024 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gdFbUsp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369D12D1F1;
	Sun,  3 Nov 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730615481; cv=none; b=b7P3tIcotOoWrEdlZ93mR/FkhCNed4FF+h2/KIH8o2E99yWFYYG5jZ8hBx56lMvUAbYBD8U/dNv5hHnHxONPmE/Mnvm2FDmcroquVf73P9a5ZsmbfwdkTidfPjc7M8oYnZf7+YEgQGIyQmTBeTrbnKFcZlZOWW1UrkTXJCAo+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730615481; c=relaxed/simple;
	bh=U8JkmPM/Yrw89/VvwBbM7F/arv4hVRc3kEZU5JTCI2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl9FRNSxEEHHmwzZtZJ7s7gQVli/fgQ3lpZ87X+ZLJdalFvT4t1sRreTNhesjbGeDCGkA4848DIRO9LBF79KhqkgE8UgPgWWWF2xqkH7VFJ2YhqUMOwydeQRt2lIIDMRTth+K1OToXixK214QJtHrIp0WWl6WmZ56bzmV4gDdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gdFbUsp8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gJcPdgpPSJy7fHtN8xFJI3OHBrACzLCNACMHshAEEcw=; b=gdFbUsp8VJGzAtvRW7ihIbV3ZR
	CUBBh33o7Hl8FoUVbLeL2OM8SoltY9BzJqB9fl4UHyqSOH1d2F0PdSKfsEMXjEIHn9bQUW+wVGm1B
	ZzmL/HE8QHh103EuYyHcqYo13RSVNI1S9uKBo0kfG8D4bruWiinnsN4tm5EIHG5c61Vq9nBOh1EWa
	lI6S/DGnyzA/7M82pTyRIYV2fY1Ap9zK5Wa6S0ktR0XqzAM6qxfcBWEnqhk+agAmmMx22h8Sxjnz7
	tF+fdBQzp3KA7yBEr5vrHDtFNy/d/EWc+zjXyBUQzvBFGh+hpR/qFcbaFgCvba9dpbnRD4Bt4/r01
	bwL5n+nA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t7U8o-0000000AeBT-062a;
	Sun, 03 Nov 2024 06:31:14 +0000
Date: Sun, 3 Nov 2024 06:31:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	cgroups@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 01/28] net/socket.c: switch to CLASS(fd)
Message-ID: <20241103063113.GR1350452@ZenIV>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
 <20241102122132.GH1838431@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102122132.GH1838431@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 02, 2024 at 12:21:32PM +0000, Simon Horman wrote:

> > @@ -2926,16 +2900,18 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
> >  
> >  	datagrams = 0;
> >  
> > -	sock = sockfd_lookup_light(fd, &err, &fput_needed);
> > -	if (!sock)
> > -		return err;
> > +	CLASS(fd, f)(fd);
> > +
> > +	if (fd_empty(f))
> > +		return -EBADF;
> > +	sock = sock_from_file(fd_file(f));
> > +	if (unlikely(!sock))
> > +		return -ENOTSOCK;
> 
> Hi Al,
> 
> There is an unconditional check on err down on line 2977.
> However, with the above change err is now only conditionally
> set before we reach that line. Are you sure that it will always
> be initialised by the time line 2977 is reached?

Nice catch, thank you.  It is possible, if you call recvmmsg(2) with
zero vlen and MSG_ERRQUEUE in flags.  Which is not going to be done in
any well-behaving code, making it really nasty - nothing like a kernel
bug that shows up only when trying to narrow down a userland bug upstream
of the syscall in question ;-/

AFAICS, that's the only bug of that sort in this commit - all other
places that used to rely upon successful sockfd_lookup_light() zeroing
err have an unconditional assignment to err shortly downstream of that.

Fix folded into commit in question, branch force-pushed; incremental follows
(I would rather not spam the lists with repost of the entire patchset for
the sake of that):

diff --git a/net/socket.c b/net/socket.c
index fb3806a11f94..c3ac02d060c0 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2885,7 +2885,7 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags,
 			  struct timespec64 *timeout)
 {
-	int err, datagrams;
+	int err = 0, datagrams;
 	struct socket *sock;
 	struct mmsghdr __user *entry;
 	struct compat_mmsghdr __user *compat_entry;

