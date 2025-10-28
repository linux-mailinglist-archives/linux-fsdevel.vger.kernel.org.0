Return-Path: <linux-fsdevel+bounces-65906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D0C14204
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 11:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400634241AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D23304BDE;
	Tue, 28 Oct 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StPuP6aX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CEF2BE65E;
	Tue, 28 Oct 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647797; cv=none; b=HbiQc2wTBCml9duJZAn3WDMOi4gJZSmrfffDxYBzuCq1OvWC8R/Y1m77YksqS9oHKnXJ2/xHRqZWOgdhH8r3lGeLaot2eqvOuTGO58gaWimblkt67E6bNmXTZd9M9w4xMS/f+vy04ef1lWOTiBI4rrk6zUrG581iduxDwYWSMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647797; c=relaxed/simple;
	bh=5XbkQBaVMcIBV6/nt9qmxsvLTVz+pIg1JTzr795jX4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ2h+/aUAhwYvsy2W2S3lcTuZ5XnZlg2jxrFkh4F5IwNj1FFmu55y7yR+rJ2bkYCQBOUj+bwfopxDtYoMeuenSDcvD8OMYcJt+Joj7BTiQegpw+hO3v8BZkPueGqVM716pNMDI/stQVXcGK/K9aOzs87sDofnkLDNulCMy8YxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StPuP6aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C1CC4CEE7;
	Tue, 28 Oct 2025 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761647796;
	bh=5XbkQBaVMcIBV6/nt9qmxsvLTVz+pIg1JTzr795jX4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StPuP6aXMOhlEtXNVEXfjtdSvwQQMgKxOn5UPzz2/ZBPY5DCbjyVc88mLtzhTRmva
	 DLCObG9SHb2CYVuvAQDeFcP5AAvWaOemRd0QfBA25BC66BfmMWPjPZ9Hnh5erJBSM9
	 nPV6PV9LKK6e/g1fGhxdsP5hbIRL3gNRdt7Pg+hF8niCbLRPXvZQY9Q0jLMjoRoZo8
	 p2C8jhLQzxYaxG0SEL3lSXEQrzqkfcxldejj88fwL9rXtHhrhroNCKHX8M3j8HfOJH
	 iFaBduOdoPLHeJbC6w1E9UsdCjLZwba4jZrZ+znxQCrBOHll60j8DlbwkTvKulcNgD
	 TAOqGoYBgXstA==
Date: Tue, 28 Oct 2025 10:36:30 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>,
	Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 17/70] nstree: add listns()
Message-ID: <aQCcrqp7qxY8ew8T@horms.kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>

On Fri, Oct 24, 2025 at 12:52:46PM +0200, Christian Brauner wrote:

...

> diff --git a/kernel/nstree.c b/kernel/nstree.c

...

> +static ssize_t do_listns(struct klistns *kls)
> +{
> +	u64 *ns_ids = kls->kns_ids;
> +	size_t nr_ns_ids = kls->nr_ns_ids;
> +	struct ns_common *ns, *first_ns = NULL;
> +	struct ns_tree *ns_tree = NULL;
> +	const struct list_head *head;
> +	struct user_namespace *user_ns;
> +	u32 ns_type;
> +	ssize_t ret;
> +
> +	if (hweight32(kls->ns_type) == 1)
> +		ns_type = kls->ns_type;
> +	else
> +		ns_type = 0;
> +
> +	if (ns_type) {
> +		ns_tree = ns_tree_from_type(ns_type);
> +		if (!ns_tree)
> +			return -EINVAL;
> +	}
> +
> +	if (kls->last_ns_id) {
> +		kls->first_ns = lookup_ns_id_at(kls->last_ns_id + 1, ns_type);
> +		if (!kls->first_ns)
> +			return -ENOENT;
> +		first_ns = kls->first_ns;
> +	}
> +
> +	ret = 0;
> +	if (ns_tree)
> +		head = &ns_tree->ns_list;
> +	else
> +		head = &ns_unified_list;
> +
> +	guard(rcu)();
> +	if (!first_ns)
> +		first_ns = first_ns_common(head, ns_tree);
> +
> +	for (ns = first_ns; !ns_common_is_head(ns, head, ns_tree) && nr_ns_ids;
> +	     ns = next_ns_common(ns, ns_tree)) {
> +		if (kls->ns_type && !(kls->ns_type & ns->ns_type))
> +			continue;
> +		if (!ns_get_unless_inactive(ns))
> +			continue;
> +		/* Check permissions */
> +		if (!ns->ops)
> +			user_ns = NULL;

Hi Christian,

Here it is assumed that ns->ops may be NULL.

> +		else
> +			user_ns = ns->ops->owner(ns);
> +		if (!user_ns)
> +			user_ns = &init_user_ns;
> +		if (ns_capable_noaudit(user_ns, CAP_SYS_ADMIN) ||
> +		    is_current_namespace(ns) ||
> +		    ((ns->ns_type == CLONE_NEWUSER) && ns_capable_noaudit(to_user_ns(ns), CAP_SYS_ADMIN))) {
> +			*ns_ids++ = ns->ns_id;
> +			nr_ns_ids--;
> +			ret++;
> +		}
> +		if (need_resched())
> +			cond_resched_rcu();
> +		/* doesn't sleep */
> +		ns->ops->put(ns);

And, if so, it isn't clear to me why that wouldn't also be the case here.

Flagged by Smatch.

> +	}
> +
> +	return ret;
> +}

...

