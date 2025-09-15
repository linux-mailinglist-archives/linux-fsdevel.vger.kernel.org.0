Return-Path: <linux-fsdevel+bounces-61412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B044B57E29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBB23B7D0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AC230FC38;
	Mon, 15 Sep 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxUofNG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BD1F7910;
	Mon, 15 Sep 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944474; cv=none; b=l15np8ccCmCGcssWnCiS+6EFBOcHx/tA6cy1lefj4RMoQH5oPT1twOZRuYsHiyl/17oDbPGZ4JW4V2dbKAPu21ZCCK0oasMC0egxw0qcvpbtghCkAbBZADeswuKdUcJttZ0uHH3YtkBIVcpZANTFjqVO37i6ikstaUzxlx+0C/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944474; c=relaxed/simple;
	bh=HlyWj7wt3G/O8kXE8DXxOimD0KBx5rX/DKJek5mx8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AomYwNElh4B0oXdeqz9ryF/zWG9hJRE8FZru50nxevCpEsQgBVFaSE3K6H+TETRCkv0momi9z6nG7H/vZTdTT+92tVWR46ezLOxTAQcQ/Oih2/MkhcmnYBp9+oPuI9K9QO7TG+Ig7wBDM2yhNRR6lFheu5TANx9vn2SDl1IEhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxUofNG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FE9C4CEF1;
	Mon, 15 Sep 2025 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944473;
	bh=HlyWj7wt3G/O8kXE8DXxOimD0KBx5rX/DKJek5mx8Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxUofNG38crXyA2xkXwr025vxmP1ete1AVZG2AiK8A3cAmkl8dXgQif81lT16cHGB
	 DcBKfaDz5uYAmQuD42pgJDeXGovvCT7mPiQsje38BdIdeZyD0n61AQ177/GBRfwhbk
	 Tf95q4Lrgu8dAUWRU30mk2F3ifKANN4Y/1GsIv9fzubZfjph3NuJfwVO2TZhNWrk8o
	 6NY2FRkrFFdy+DMX9VreISSNkxAJMlYfKc3KZrua4rH8rgZnPBjWhRc2yh+72wXfe9
	 +4HVjfT7FidyhU4OgddVNpDxbR2j7d5py8B75/Ryj4/u8nPezTN6Myyq1Tk9CWbZl4
	 glNopAjRJkffw==
Date: Mon, 15 Sep 2025 15:54:26 +0200
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
Subject: Re: [PATCH v2 24/33] user: support ns lookup
Message-ID: <20250915-faken-rufen-db3c29188501@brauner>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-24-1a247645cef5@kernel.org>
 <bh6wllwygal6hfdjbv3amgok2yxzjgmemyvzriqf2wos6b3plp@tvhvgz47mll3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bh6wllwygal6hfdjbv3amgok2yxzjgmemyvzriqf2wos6b3plp@tvhvgz47mll3>

On Mon, Sep 15, 2025 at 02:11:55PM +0200, Jan Kara wrote:
> On Fri 12-09-25 13:52:47, Christian Brauner wrote:
> > Support the generic ns lookup infrastructure to support file handles for
> > namespaces.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> ...
> > @@ -200,6 +202,7 @@ static void free_user_ns(struct work_struct *work)
> >  	do {
> >  		struct ucounts *ucounts = ns->ucounts;
> >  		parent = ns->parent;
> > +		ns_tree_remove(ns);
> >  		if (ns->gid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
> >  			kfree(ns->gid_map.forward);
> >  			kfree(ns->gid_map.reverse);
> > @@ -218,7 +221,8 @@ static void free_user_ns(struct work_struct *work)
> >  		retire_userns_sysctls(ns);
> >  		key_free_user_ns(ns);
> >  		ns_free_inum(&ns->ns);
> > -		kmem_cache_free(user_ns_cachep, ns);
> > +		/* Concurrent nstree traversal depends on a grace period. */
> > +		kfree_rcu(ns, ns.ns_rcu);
> 
> So this is correct for now but it's a bit of a landmine. A lot of stuff
> that ns references is kfreed before the RCU expires. Thus if you lookup ns
> using id, then even if you're under RCU protection you have to be very
> careful about what you can and cannot dereference. IMHO this deserves a
> careful documentation at least or, preferably, split free_user_ns() into
> pre and post-RCU period parts...

Right, the thing is that you cannot touch anything in any namespace
structure without having an actual reference to it. IOW, the only thing
that's valid under rcu is to access the reference count. That's the only
guarantee that the _generic_ infrastructure gives _and_ expects. IOW, if
one can get a live reference (inc_not_zero) that thing better be valid.

Individual namespace implementers may ofc provide additional guarantees
but they are not transparent to the generic infrastructure.

Otherwise I fully agree.

