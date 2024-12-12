Return-Path: <linux-fsdevel+bounces-37198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EF09EF85D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C6D17CF24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F3223C46;
	Thu, 12 Dec 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtbRdKAP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06566222D75
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024822; cv=none; b=k33rUqJOFMbNg42/BNB+X9xi3D9nd10MpCoCLoV3/fHBDItWjcDVWOkKZWJLf27S6X5XM4runkGHFnfaEd9IhA9rBv50o/wUkpKSYME0bAA0CARoOm0bcxu3ajWuzR5XNT4pj62amJlfMxOh2QozIjMXC5ptsRO62rdpCohzM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024822; c=relaxed/simple;
	bh=5cAzL+RlnBbC4hAq1mKdxFlMo07WLuWLM+hfUkE7r84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSAGSwFNBAmKlT5IaknHWx1KaOB+QXELdzmAa7SWqopvFkLU/9vX/XYy7RL20XHaBf9vHQOmrnt2Bc9R75CFGOnsLbeCCu8/K+V5WKexOMuCibyukhlLe8DDdoq4IcRFScTdKEKhSu8J/DQHk8VuK4dzZVBd2ccFUdoCsGNHG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtbRdKAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6581AC4CECE;
	Thu, 12 Dec 2024 17:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734024820;
	bh=5cAzL+RlnBbC4hAq1mKdxFlMo07WLuWLM+hfUkE7r84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtbRdKAPrdM+d+jwixnkz34ftKKIOMsdQwDbpl6rtR1Bvn9HuJ8Xg4S5wpluiLTob
	 laTXP7pamfKDpLzdUzEvgS0WS782p2TzfgTSekACN6LGHCWRyEtb2R8bq6ZhOjjt5g
	 IrzNfxYuW66mamEekCDVyFhW4xDJjf+yiUwXYeoCXBsx7kxzbIbSZ9bu4coVIQo0kr
	 YTf22QDNtKTwiWCIG3EQezbRZRbvAQggscd/X57aStp1ixdWnOT6EYei0pBdk90V3c
	 coQ95exfDjQONCLSC+z0Hq7POki7NKMhg/uStA4rsf+Jy7rKlPFRCHwZP+ZlC6UU0C
	 FLTjnh2iGDoKA==
Date: Thu, 12 Dec 2024 18:33:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] fs: lockless mntns lookup for nsfs
Message-ID: <20241212-rhythmisch-seelenruhig-5a5ed7d0ba10@brauner>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
 <20241212-work-mount-rbtree-lockless-v2-5-4fe6cef02534@kernel.org>
 <20241212124817.GZ21636@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212124817.GZ21636@noisy.programming.kicks-ass.net>

On Thu, Dec 12, 2024 at 01:48:17PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 12, 2024 at 12:56:04PM +0100, Christian Brauner wrote:
> 
> > @@ -146,6 +147,7 @@ static void mnt_ns_tree_add(struct mnt_namespace *ns)
> >  
> >  	mnt_ns_tree_write_lock();
> >  	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
> > +	list_add_tail_rcu(&ns->mnt_ns_list, &mnt_ns_list);
> >  	mnt_ns_tree_write_unlock();
> 
> This only works if the entries are inserted in order -- if not, you can
> do something like:

If I understand your concern correctly then the entries should always be
inserted in order. Mount namespaces are sequentially allocated
serialized on the namespace semaphore "namespace_sem. So each mount
namespace receives a unique 64bit sequence number. If ten mount
namespaces are created with 1, 2, 3, ..., 10 then they are inserted into
the rbtree in that order. And so they should be added to that list in
the same order. That's why I kept it that simple.

Although I need to drop "fs: add mount namespace to rbtree late" to keep
that guarantee. Did I understand you correctly?

> 
>   prev = rb_prev(&ns->mnt_ns_tree_node);
>   if (!prev) {
>     // no previous, add to head
>     list_add(&ns->mnt_ns_list, &mnt_ns_list); 
>   } else {
>     // add after the previous tree node
>     prev_ns = container_of(prev, struct mnt_namespace, mnt_ns_tree_node);
>     list_add_tail(&ns->mnt_ns_list, &prev_ns->mnt_ns_list);
>   }

