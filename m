Return-Path: <linux-fsdevel+bounces-51446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38CAD6FBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CC43A94A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93552356CF;
	Thu, 12 Jun 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+qcCy1Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8922173D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730141; cv=none; b=FBWMVNSn6KvEB4O+4UtxSd4h6A5Kam8y47kSgvUtxnb5HPvL4cxiq/HA89nnFZk6gi3t9qUcuhRNlBN7w7etsR/Qit0Q1qnB+Wl+SuGUyesuW//eey97QJA6mLhPLMM7Eh1oPTiZtxCyAbAh0HGJZqsPs30eg5CWZsKNMuoQ2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730141; c=relaxed/simple;
	bh=WaNHfRDBVuzrJrkcVbhivpJfG6WTkhNngz+gQT4rCBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1d0x+hNyiEGaOKfo7GxCaXU3MM5F9H4x/1g2tIs3SDvBnm42NbtuDboZ3NP8lgUf5vt9/t45OvBSen9XbY6yXEO4Ony7rdeWXlvkWbQfhXg3Si8S86IWwFAu9qM03KdjchwAL4t8TLKOWwI1v2xq3XHuh081M4XQHJVG4oujC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+qcCy1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CA7C4CEEA;
	Thu, 12 Jun 2025 12:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749730140;
	bh=WaNHfRDBVuzrJrkcVbhivpJfG6WTkhNngz+gQT4rCBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+qcCy1Y2Qm5JwaE0WeQ+ajkUhKtvGB7d6ST1cr6yAoI4tVnrQcjsaUidYeWtLDNG
	 Mn8BwjCuMu/FycWpyRBbCu1OkB6Hw3a3lDeNlb5lsWmHZKcvJ8H6/WIPrlwWr5eXXx
	 ETxvzclLnd8vs5nKzVTxGY/iLHqBjj8YVrlva1+vCKR7aAu6VdpF6t17CZhnLWJqDz
	 HxFbn+ySMgwFzCuewfqTJTc8A+hgkL/krnkUMevFyvOiRWF+r/+Z0SnFA7lTCcIQ88
	 RByx0v90McLrWez5DxCCbqXf5MFnDM0qGLbL0Y6qSuF37iyCPXTDFAb2YZLz0F7PEJ
	 gt+bAX4oSNDxA==
Date: Thu, 12 Jun 2025 14:08:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 17/26] attach_recursive_mnt(): unify the
 mnt_change_mountpoint() logics
Message-ID: <20250612-saloon-anorak-53c7d2298a94@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-17-viro@zeniv.linux.org.uk>
 <20250611-stottern-chipsatz-779c33c0b88e@brauner>
 <20250611181223.GO299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611181223.GO299672@ZenIV>

On Wed, Jun 11, 2025 at 07:12:23PM +0100, Al Viro wrote:
> On Wed, Jun 11, 2025 at 01:05:52PM +0200, Christian Brauner wrote:
> > > -	if (beneath)
> > > -		mnt_change_mountpoint(source_mnt, smp, top_mnt);
> > > -	commit_tree(source_mnt);
> > > +	hlist_add_head(&source_mnt->mnt_hash, &tree_list);
> > 
> > Please add a comment here. Right now it's easy to understand even with
> > your mnt_change_mountpoint() changes. Afterwards the cases are folded
> > and imho that leaves readers wondering why that's correct.
> 
> Hmm...  Does the incremental below look sane for you?

Yep, thanks!

> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d5a7d7da3932..15b7959b1771 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2675,6 +2675,13 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  	}
>  
>  	mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
> +	/*
> +	 * Now the original copy is in the same state as the secondaries -
> +	 * its root attached to mountpoint, but not hashed and all mounts
> +	 * in it are either in our namespace or in no namespace at all.
> +	 * Add the original to the list of copies and deal with the
> +	 * rest of work for all of them uniformly.
> +	 */
>  	hlist_add_head(&source_mnt->mnt_hash, &tree_list);
>  
>  	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {

