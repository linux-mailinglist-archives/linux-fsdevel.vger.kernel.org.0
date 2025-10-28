Return-Path: <linux-fsdevel+bounces-65914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C107C14E40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 692C950790D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239D3375DF;
	Tue, 28 Oct 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmEwP7kC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460B335063;
	Tue, 28 Oct 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658391; cv=none; b=ZkV7gpEPfR9pH/ktFfXtcN9rsAzmO9BjzrYaj6WmTZqewe9EwVwid+7g6Z5OI/Hme6ZiaiaMVqWQLEHEeXPBlI3uuyc2QuzRtMMGSvjhsa7LRyf4kIy4B8MOcVjhtSbpMkN/jPNHQwjrNsC4e40FobMZ0NJVzGmlM9vu8/mOFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658391; c=relaxed/simple;
	bh=zHgFOuY5SFOlmk5HuLBk82BmMu84ypaw7kIZB0Jb67g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDYzFO+0hQwTB4OtoiFLwXIKBFzD5Wpun20rJFfBYpUzFzjfs1XL5s85+MNyJieF7hpEOIDjByu7ve0Rg/ATjEvqXNljIdgiAJWIL+JVkrfWC+0De5ylVtcN8mTQv6eeblWl14e4oqorPgA55D1CGIs4S345nDVDnBV9dSXdvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmEwP7kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C9FC4CEFD;
	Tue, 28 Oct 2025 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761658389;
	bh=zHgFOuY5SFOlmk5HuLBk82BmMu84ypaw7kIZB0Jb67g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmEwP7kCXosfzQMpvMsWAoDgsyCyr9vumhoiyjhDQSMhSj//+fr3N8ViVDH/1DqCg
	 iAMw0x2GF3UG7huzPYCoPAkfzimdyOxCJhjb5mf05XfiEQVYhCFA+4QAFPtts3IlXB
	 lPdUPauefx0LtL5fiP4/Mj2+61oLsJl41mmeNNYpba65hCxz3HEel+JqqHudtWIHKo
	 jgkirCJx9EF8ri80XldJOfj3NU3a5MJ7wL09fNTco1ScemLB3nG9W9WRJNRWMeelew
	 kkwy/5o3D12FZKSUQ+CpGyeYWNpXg5lEx26xNf8uLQm98HShqQbOzn2XDomyCTGTbR
	 MNaHUqpecxTiQ==
Date: Tue, 28 Oct 2025 14:33:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 17/70] nstree: add listns()
Message-ID: <20251028-fenchel-roman-75c1c7e13c93@brauner>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
 <aQCcrqp7qxY8ew8T@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQCcrqp7qxY8ew8T@horms.kernel.org>

On Tue, Oct 28, 2025 at 10:36:30AM +0000, Simon Horman wrote:
> On Fri, Oct 24, 2025 at 12:52:46PM +0200, Christian Brauner wrote:
> 
> ...
> 
> > diff --git a/kernel/nstree.c b/kernel/nstree.c
> 
> ...
> 
> > +static ssize_t do_listns(struct klistns *kls)
> > +{
> > +	u64 *ns_ids = kls->kns_ids;
> > +	size_t nr_ns_ids = kls->nr_ns_ids;
> > +	struct ns_common *ns, *first_ns = NULL;
> > +	struct ns_tree *ns_tree = NULL;
> > +	const struct list_head *head;
> > +	struct user_namespace *user_ns;
> > +	u32 ns_type;
> > +	ssize_t ret;
> > +
> > +	if (hweight32(kls->ns_type) == 1)
> > +		ns_type = kls->ns_type;
> > +	else
> > +		ns_type = 0;
> > +
> > +	if (ns_type) {
> > +		ns_tree = ns_tree_from_type(ns_type);
> > +		if (!ns_tree)
> > +			return -EINVAL;
> > +	}
> > +
> > +	if (kls->last_ns_id) {
> > +		kls->first_ns = lookup_ns_id_at(kls->last_ns_id + 1, ns_type);
> > +		if (!kls->first_ns)
> > +			return -ENOENT;
> > +		first_ns = kls->first_ns;
> > +	}
> > +
> > +	ret = 0;
> > +	if (ns_tree)
> > +		head = &ns_tree->ns_list;
> > +	else
> > +		head = &ns_unified_list;
> > +
> > +	guard(rcu)();
> > +	if (!first_ns)
> > +		first_ns = first_ns_common(head, ns_tree);
> > +
> > +	for (ns = first_ns; !ns_common_is_head(ns, head, ns_tree) && nr_ns_ids;
> > +	     ns = next_ns_common(ns, ns_tree)) {
> > +		if (kls->ns_type && !(kls->ns_type & ns->ns_type))
> > +			continue;
> > +		if (!ns_get_unless_inactive(ns))
> > +			continue;
> > +		/* Check permissions */
> > +		if (!ns->ops)
> > +			user_ns = NULL;
> 
> Hi Christian,
> 
> Here it is assumed that ns->ops may be NULL.
> 
> > +		else
> > +			user_ns = ns->ops->owner(ns);
> > +		if (!user_ns)
> > +			user_ns = &init_user_ns;
> > +		if (ns_capable_noaudit(user_ns, CAP_SYS_ADMIN) ||
> > +		    is_current_namespace(ns) ||
> > +		    ((ns->ns_type == CLONE_NEWUSER) && ns_capable_noaudit(to_user_ns(ns), CAP_SYS_ADMIN))) {
> > +			*ns_ids++ = ns->ns_id;
> > +			nr_ns_ids--;
> > +			ret++;
> > +		}
> > +		if (need_resched())
> > +			cond_resched_rcu();
> > +		/* doesn't sleep */
> > +		ns->ops->put(ns);
> 
> And, if so, it isn't clear to me why that wouldn't also be the case here.

Right you are. Fixed.

