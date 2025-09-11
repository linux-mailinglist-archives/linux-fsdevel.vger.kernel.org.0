Return-Path: <linux-fsdevel+bounces-60902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A37B52C26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 10:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B13E1892AA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E952E6CD9;
	Thu, 11 Sep 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNKQj+MK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA8293B73;
	Thu, 11 Sep 2025 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580380; cv=none; b=NdX6u4702E7s1yiSzAMAmA8Uu8O13NFkORfHJLQEeazm+ABIVTgCkZIjDOPfqT+W1JQxPXc2oFoAMJyeYqTO9AJNlktnWKo77+BHVM8frCndUhapnXGAQe7/nednAmUiLDEOh+xp1ZJuKqK22TY0/2CjRAFqZmboPziP/sl9ioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580380; c=relaxed/simple;
	bh=8Ym8Woe5hOM4hKQJ3h72aXmX/3Bn6+fBeFRICNNUriU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip7Uw9JDujS5PFMdJW5cKMJlYR7EKRw/UFftljF1ZTupw1f6ZS9Yg82Szabb6pqMwbTm4bfaXummcNGP2xP55OkCXF1uGzfbbrXs4jaVt1x5fOTkCJu7vAw5NtUHmgGezPAf7KH7iVr9Ok8DomCqsXKqf594KqNbZFWu64Ph/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNKQj+MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036C2C4CEF1;
	Thu, 11 Sep 2025 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757580379;
	bh=8Ym8Woe5hOM4hKQJ3h72aXmX/3Bn6+fBeFRICNNUriU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNKQj+MK6MwyfQZyz8HLmtdJMtrihNwJB8IJcJER62Z0upJkVALyYVyg/EmzMo3Qv
	 LKrgFDBrxI7WF7P7641MCl/BCVewQOfkTV2tu2Ta/B2/tErQnzE4oBuAYQNcG7AB1v
	 iscmbPGOuQZdZAHOq8v9l17HWsDu+ra93FdsKYhfF3n4JDwKVCaHzCsdIu/6rq+r+A
	 30XXUL2Fo69ziqWdfFEmB1Mbw6+/MRfSH1wNzuM7yu/89/UWy7sEci+rD7Es/fsOzJ
	 LpSi2sN8UMvmYx9xLjc1HucW2G755MN7KNte4DAMNXbLtzxA7EBVGLMA+2UBZeXQ5S
	 JP9arkaqAzbzQ==
Date: Thu, 11 Sep 2025 10:46:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/32] net: use ns_common_init()
Message-ID: <20250911-unqualifiziert-widmen-03b0c271aa69@brauner>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-14-4dd56e7359d8@kernel.org>
 <vgfnpdvwiji7bbg7yb5fbymp6f6q5f66rywkjyrxtdejdgoi37@ghpon5czjtkm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vgfnpdvwiji7bbg7yb5fbymp6f6q5f66rywkjyrxtdejdgoi37@ghpon5czjtkm>

On Wed, Sep 10, 2025 at 05:57:52PM +0200, Jan Kara wrote:
> On Wed 10-09-25 16:36:59, Christian Brauner wrote:
> > Don't cargo-cult the same thing over and over.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> One comment below.
> 
> > @@ -812,17 +828,14 @@ static void net_ns_net_debugfs(struct net *net)
> >  
> >  static __net_init int net_ns_net_init(struct net *net)
> >  {
> > -#ifdef CONFIG_NET_NS
> > -	net->ns.ops = &netns_operations;
> > -#endif
> > -	net->ns.inum = PROC_NET_INIT_INO;
> > -	if (net != &init_net) {
> > -		int ret = ns_alloc_inum(&net->ns);
> > -		if (ret)
> > -			return ret;
> > -	}
> > +	int ret = 0;
> > +
> > +	if (net == &init_net)
> > +		net->ns.inum = PROC_NET_INIT_INO;
> > +	else
> > +		ret = proc_alloc_inum(&to_ns_common(net)->inum);
> >  	net_ns_net_debugfs(net);
> 
> Here you're calling net_ns_net_debugfs() even if proc_alloc_inum() failed
> which looks like a bug to me...

Yes, good catch!

Fyi, I have been out properly sick this week and that's why I haven't
been very active on-list. I hope to be back in a more functional state
tomorrow and will process the backlog.

