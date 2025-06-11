Return-Path: <linux-fsdevel+bounces-51296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A7DAD5332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5207416C185
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24EA2E6136;
	Wed, 11 Jun 2025 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D00KRnxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E42E612F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639956; cv=none; b=pBytkRyVSD3Pprqm5ANm+x3ptUqB5Mi844wF3ZfLun60tQwhkNqsFpXF07FskVJeNB7TP/hO43H2kKPSR+hRzj99iWxcgtIpmIdxA0a9pIwduCa6FprD1JMYigOBD14sbas9g2HYgnQl3A/eqgde8ycQ/+Z4/igJWTQINCeZR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639956; c=relaxed/simple;
	bh=iwh9SqO9i3xrxUJ1FaO5RtvNW+mgwpTYKJcBx+UgZuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktB37Bh708IZGAwOjVpxntlAoNSq5OHIjyxDdypFnSDNp9ebTWpUi02uNDhszR9ZrJkQWJTOHKul5UzwafhqYpSmkbaiPNKc/n7lCKQnBFuwu0Vw9ieiKmf46jLe0j89gAziRJIcWIAKKM8c5hVvn98TdbLRDsdA6kMIkS7DSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D00KRnxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EE6C4CEEE;
	Wed, 11 Jun 2025 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639955;
	bh=iwh9SqO9i3xrxUJ1FaO5RtvNW+mgwpTYKJcBx+UgZuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D00KRnxSOq+h3y/KW/oOUSptUBbembaUMA6/9uoEP7l8/TXn++n5nmh32Gj0oNRtS
	 R4zYyDDnBEtUAmQvyu0aB+9DDCcgcqFwzmpC1ZgMjV89zL9JgB/5lUP6kLXAnHxYA1
	 XPKFpsHqS03Vkj1KpWBuRNSsG4jVUA1xyFMZaTDLnHJ3v/0lTrpshG6vk90tyegdSz
	 qXmIXGFFNKgxsP4xw6vBMsSEDU5Q2Gt5akEA/zNOQSGI97nDYotz+96YX4BniGnAjC
	 +qZPCNQcQnvv7MUXdKDuc+MKTv+3PPHyXkvrRQeUPmILQFKaBrIgUZNXUIHrWuZOKo
	 lF0s9TgSQpohQ==
Date: Wed, 11 Jun 2025 13:05:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 17/26] attach_recursive_mnt(): unify the
 mnt_change_mountpoint() logics
Message-ID: <20250611-stottern-chipsatz-779c33c0b88e@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-17-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-17-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:39AM +0100, Al Viro wrote:
> The logics used for tucking under existing mount differs for original
> and copies; copies do a mount hash lookup to see if mountpoint to be is
> already overmounted, while the original is told explicitly.
> 
> But the same logics that is used for copies works for the original,
> at which point the only place where we get very close to eliminating
> the need of passing 'beneath' flag to attach_recursive_mnt().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/namespace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 50c46c084b13..0e43301abb91 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2675,9 +2675,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  	}
>  
>  	mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
> -	if (beneath)
> -		mnt_change_mountpoint(source_mnt, smp, top_mnt);
> -	commit_tree(source_mnt);
> +	hlist_add_head(&source_mnt->mnt_hash, &tree_list);

Please add a comment here. Right now it's easy to understand even with
your mnt_change_mountpoint() changes. Afterwards the cases are folded
and imho that leaves readers wondering why that's correct.

>  
>  	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
>  		struct mount *q;
> -- 
> 2.39.5
> 

