Return-Path: <linux-fsdevel+bounces-36660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2B9E768A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A3416628C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C851F4E22;
	Fri,  6 Dec 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dht08pvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148551F3D39
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504255; cv=none; b=iYi3HNDRF69MGnf73PGvsr5lEfGSP1Vi1zm/RkjgH8XxdG+unK/6Vc39nPz2YEtKosAKz3GyPATztY6un9+NWwfiu7tdRXPpVFkLRRwWEBlZeT2nHKuVCSSQ93tkSJnazad+YWqkInbPLIyGKz1Nk8ptRBy2jvGmnMve6wGwavg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504255; c=relaxed/simple;
	bh=OsuUncSgygCcrw1zGkw9rc6EJArUxEmZEOXz4tbN5jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J682Yxwc7zx3ZXVhFNr0pMJTMUApt3HN+PD5eRoGCeDvdhzMw/+d9KlNNJG4vr2VC+g2rJoaPhRtNCzX6gDQ3CNMRcctAgzJgnox12Wc85U6ZyZkBZtZypjWQmbQ75VgEofO8Y+J4n/h/A7FblWDIrxGDyMNRTPePmx5hh4JYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dht08pvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39ACC4CED1;
	Fri,  6 Dec 2024 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733504254;
	bh=OsuUncSgygCcrw1zGkw9rc6EJArUxEmZEOXz4tbN5jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dht08pvSidguukpnxhRgvICmKAEi7F0lW8AO/qztlf8ea+8rN6lXHDHpcUI5q9ZyT
	 EwQeUKfMfIiVslH2kN0TjeSJrrvgmp30PJ7GuTvcMr2bMzUPwTxK/DqKPWk/kV6aFl
	 73TpKzqbp+N+2RJIt4UqptpzR/3v9sHbJ65crmdi+ed3efoI6IEzeVG1/HFq7LSz9n
	 RSyx1U8u5p2GzToK3oTtzRwPTs4TjYAqZnScUbXeFpbJIXBudG0EPQBXplMpMvFUPp
	 et+AvESCelKeIDZd0uJvkUg1RVckcWZ/1iUqkTiMRqeGApfPS1x465Pmq/dwElriZY
	 KWV1HBewifR6A==
Date: Fri, 6 Dec 2024 17:57:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC] pidfs: use maple tree
Message-ID: <20241206-unabsehbar-feucht-326c23fbedb0@brauner>
References: <20241206-work-pidfs-maple_tree-v1-1-1cca6731b67f@kernel.org>
 <Z1McXVVPJf4HztHU@casper.infradead.org>
 <20241206-experiment-ablegen-c88218942355@brauner>
 <Z1MhDcijeMwrP9fu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1MhDcijeMwrP9fu@casper.infradead.org>

On Fri, Dec 06, 2024 at 04:06:37PM +0000, Matthew Wilcox wrote:
> On Fri, Dec 06, 2024 at 05:03:03PM +0100, Christian Brauner wrote:
> > On Fri, Dec 06, 2024 at 03:46:37PM +0000, Matthew Wilcox wrote:
> > > On Fri, Dec 06, 2024 at 04:25:13PM +0100, Christian Brauner wrote:
> > > > For the pidfs inode maple tree we use an external lock for add and
> > > 
> > > Please don't.  We want to get rid of it.  That's a hack that only exists
> > > for the VMA tree.
> > 
> > Hm, ok. Then I'll stick with idr for now because we can simply use
> > pidmap_lock. Otherwise we'd have to introduce more locking.
> 
> Why can you not delete pidmap_lock and use the maple tree lock
> everywhere that you currently use pidmap_lock?  That's the intended
> way to use it.

Each pid namespace has it's own idr (as each pid namespace gets its own
pid number space) and the whole pid allocation across all pid namespaces
idrs is protected by pidname_lock.

All pid numbers in all pid namespaces idrs are allocated (acquiring and
dropping pidmap_lock) but storing a NULL so that find_pid_ns() isn't
able to find a half-initialized struct pid. The pidmap_lock is taken
again to publish all pid numbers once its finalized. It also protects
each pid namespaces's pid number allocation indicator
pid_ns->pid_allocated.

So in short, I'm pretty sure that it's possible to port this to the
maple tree overall and rely on the maple tree locks but I'm not sure how
straightforward it would be and I don't want to tie this work into the
pidfs file handle work as a preliminary as well.

