Return-Path: <linux-fsdevel+bounces-62073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638FFB837CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116D87B86A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 08:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D272EFD8C;
	Thu, 18 Sep 2025 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPNBBT4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B22F0C76;
	Thu, 18 Sep 2025 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183309; cv=none; b=FLQ/O9SiI6n5UMA21wPD+6vOvdXg90bJsaJtj+KwzfSogdxQXWbsHCxaEFLQ4s2uh5K5QXNhrTkP9Y7oANEXboWW0LXvNbANIueKH5fxHxRehVUQ2HgTHPFaN2tWSGkQLzKYhffix7X9rfPtf695KXtXYkCYz9EEdEXBqslniv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183309; c=relaxed/simple;
	bh=vdNAbb1sIIBLM6HtkjMhLcE3NH/r58ees6Ez8F2vCiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtHOeO4hI3VPDYqWXXfe/FbG7jK3zEqZos4fUFwp3gQXkiKaVmjUBsaNtS7bj9vU0xxroX8UO43mAR5rPHlr4fsrXM7/8A+u4tZ0moxNJJghA1FcKH9wgOrpqj59d4pJncbQ5sXyWub4kOpFU6gSqZoZYYJkMbQb5Ptf1bEmKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPNBBT4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51227C4CEE7;
	Thu, 18 Sep 2025 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758183308;
	bh=vdNAbb1sIIBLM6HtkjMhLcE3NH/r58ees6Ez8F2vCiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPNBBT4VfvEjampafLChuGkfcIo7W80cRAun8skTvwuWPSuA6SW1PDpwGNFQ9B27h
	 g5vWv0WJHVuWB4cYEjdK3TkrOerkWdpPzQBw3bltLoNg99I5o6HLO9HxaeR+w0tWnt
	 BsFeAux5nt1orkkV054ygo3MhoBPd7WIBxhm6hNf5EH538ENoo11J4HZQqd5b65eFG
	 JqBlpK7M5ZiR4PmxPSjTXKMXW7N5lttMaqM4fZs5n8HLPxprCCkx/Ifbb794SBGsuj
	 EqBhADGeH9LYu0CYO/A4P3g4spTK6aIFdhv4m+3ZfU8FGojlT8vyxiPZ/y5vrlKjqp
	 lqkRt+XaNt1Xw==
Date: Thu, 18 Sep 2025 10:15:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 6/9] mnt: simplify ns_common_init() handling
Message-ID: <20250918-quizfragen-deutung-82bd9d83c7ad@brauner>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-6-1b3bda8ef8f2@kernel.org>
 <syskz2nr23sqc27swfxwbvlbnnf7tgglrbn52vjoxd2bn3ryyv@id7hurupxcuy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <syskz2nr23sqc27swfxwbvlbnnf7tgglrbn52vjoxd2bn3ryyv@id7hurupxcuy>

On Wed, Sep 17, 2025 at 06:45:11PM +0200, Jan Kara wrote:
> On Wed 17-09-25 12:28:05, Christian Brauner wrote:
> > Assign the reserved MNT_NS_ANON_INO sentinel to anonymous mount
> > namespaces and cleanup the initial mount ns allocation. This is just a
> > preparatory patch and the ns->inum check in ns_common_init() will be
> > dropped in the next patch.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> ...
> > ---
> >  fs/namespace.c    | 7 ++++---
> >  kernel/nscommon.c | 2 +-
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index c8251545d57e..09e4ecd44972 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -4104,6 +4104,8 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
> >  		return ERR_PTR(-ENOMEM);
> >  	}
> >  
> > +	if (anon)
> > +		new_ns->ns.inum = MNT_NS_ANON_INO;
> >  	ret = ns_common_init(&new_ns->ns, &mntns_operations, !anon);
> >  	if (ret) {
> >  		kfree(new_ns);
> > @@ -6020,10 +6022,9 @@ static void __init init_mount_tree(void)
> >  	if (IS_ERR(mnt))
> >  		panic("Can't create rootfs");
> >  
> > -	ns = alloc_mnt_ns(&init_user_ns, true);
> > +	ns = alloc_mnt_ns(&init_user_ns, false);
> >  	if (IS_ERR(ns))
> >  		panic("Can't allocate initial namespace");
> > -	ns->ns.inum = PROC_MNT_INIT_INO;
> >  	m = real_mount(mnt);
> >  	ns->root = m;
> >  	ns->nr_mounts = 1;
> > @@ -6037,7 +6038,7 @@ static void __init init_mount_tree(void)
> >  	set_fs_pwd(current->fs, &root);
> >  	set_fs_root(current->fs, &root);
> >  
> > -	ns_tree_add(ns);
> > +	ns_tree_add_raw(ns);
> 
> But we don't have ns->ns_id set by anything now? Or am I missing something?

It is set in alloc_mnt_ns() via ns_tree_gen_id(). :)
Unless I'm missing something.
But we still need to add PROC_MNT_INIT_INTO until the final conversion.
I'm fixing that in-tree.

