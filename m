Return-Path: <linux-fsdevel+bounces-61897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1426B7D26D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4434821BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71634AAF2;
	Wed, 17 Sep 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSuYhjIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1598884A3E;
	Wed, 17 Sep 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102638; cv=none; b=IhFJoLDj3Abj7EB6k8YepCEXmLpc7sP2caWygZWllac7LIBvT64ff8qLdXPIB+RJnfWNtMdwMgSfwc4QTc7yaz9Yk8ht6gfgMDbtNBR74V/3IJF6fNRHUJURpI0iOibNHjtzjjp9fdC7bL4QHSPbjeQwN2zES9S7CmFdI4wdhUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102638; c=relaxed/simple;
	bh=R8bBc8E+Z3IqtxfpLmr+7QmObySQ+mWruEPNJ7MrlFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRMeF4W6ekx/PijDAcV0ISs+X7z2Fnxendp9khd5uOsLWypBXhciz274l4BSp27TOccjsthLtGBKGdXbtUbQpBt4ZhXoZWDFW7PZMzNRCyQgyMu5o0nZVERtxsGUdLsE+Nb0tDKvBgLzt4dp7fsb1xF3BMA8dCjUzHOmtm07ie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSuYhjIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A16DC4CEF0;
	Wed, 17 Sep 2025 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758102637;
	bh=R8bBc8E+Z3IqtxfpLmr+7QmObySQ+mWruEPNJ7MrlFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSuYhjIBPQXozMo1k0MYS23BlFjFflyKzb9M1olal1DqbotYr5zJO8l0sSMemANvr
	 JIZm0E5KcqWHVcq+UJR7QNrEUu2z+Rqrfyhj932a9O2x1WDTMZMU4LHeGU+0J4eyuJ
	 K4kixSlqEBJGjJYTr3gob3XKckJSRylgsFH58XOdeqYKnyayTN6YBRMdf+fctC4SK3
	 AWzPoJBDk4fWUyo6RG6EQbGarou/c5TaQLpI7f38fr8zD+Df32I8yfBtDATeVEFvmA
	 MZx+1PLSxEuhCwUODD21YBZbHLhi2AHw+SNDcQEVNHcWpClXy2uRenMP8fORyCC7zI
	 kZFU+jQ0ZIGfA==
Date: Wed, 17 Sep 2025 11:50:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 18/33] mnt: support ns lookup
Message-ID: <20250917-garten-nirgendwo-f65f951a9268@brauner>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
 <20250916035633.GM39973@ZenIV>
 <20250916035949.GO39973@ZenIV>
 <20250916044648.GP39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916044648.GP39973@ZenIV>

On Tue, Sep 16, 2025 at 05:46:48AM +0100, Al Viro wrote:
> On Tue, Sep 16, 2025 at 04:59:49AM +0100, Al Viro wrote:
> > On Tue, Sep 16, 2025 at 04:56:33AM +0100, Al Viro wrote:
> > > 	if (!RB_EMPTY_NODE(to_ns_common(ns)->ns_tree_node))
> > 
> >  	if (!RB_EMPTY_NODE(&to_ns_common(ns)->ns_tree_node))
> > 
> > obviously...
> 
> FWIW, how about the following - I put the commit below into never-rebased
> branch, pull it into #work.mount and you do the same to your branch
> just prior to 18/33?  The difference from one in #work.mount is that
> this variant checks RB_EMPTY_NODE(&ns->mnt_ns_tree_node) instead of
> list_empty(&ns->mnt_ns_list).  The reasons why it's safe lockless are
> pretty much the same...
> 
> Objections?  Does vfs/vfs.git #no-rebases-mnt_ns_tree_remove look sane
> for you?

Perfect, thank you!

> 
> mnt_ns_tree_remove(): DTRT if mnt_ns had never been added to mnt_ns_list
>     
> Actual removal is done under the lock, but for checking if need to bother
> the lockless RB_EMPTY_NODE() is safe - either that namespace had never
> been added to mnt_ns_tree, in which case the the node will stay empty, or
> whoever had allocated it has called mnt_ns_tree_add() and it has already
> run to completion.  After that point RB_EMPTY_NODE() will become false and
> will remain false, no matter what we do with other nodes in the tree.
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ae6d1312b184..39afeb521a80 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -187,7 +187,7 @@ static void mnt_ns_release_rcu(struct rcu_head *rcu)
>  static void mnt_ns_tree_remove(struct mnt_namespace *ns)
>  {
>  	/* remove from global mount namespace list */
> -	if (!is_anon_ns(ns)) {
> +	if (!RB_EMPTY_NODE(&ns->mnt_ns_tree_node)) {
>  		mnt_ns_tree_write_lock();
>  		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
>  		list_bidir_del_rcu(&ns->mnt_ns_list);

