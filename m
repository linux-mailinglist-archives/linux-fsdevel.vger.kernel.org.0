Return-Path: <linux-fsdevel+bounces-37357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CC9F1549
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFF528481C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB021EBFFD;
	Fri, 13 Dec 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ5kJZ+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797831EBFE1
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115914; cv=none; b=tPuRzsk8MUeBIGqNJjrHowZA4ViLDC3QbBkHB4UFqiwzC7Rr3d3cQLiRdcjFhQDl0GcoNfWD60Oz5EwI3VoxSDoJWhMAtTjr1yhyOjgRdtxjUr5og5AuY2y/x7hMoWcgtGeE3nRAtGrPN8LxpFtO1xYu6TGpqRp4tNNtvWh3BHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115914; c=relaxed/simple;
	bh=nuENH1SOuth3l2+gbA2o8Hr4R+633dFNAtDHmlEYbCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH8mOEx/yqfEABFEeAzYGpMIavcALPO0Vn/EqkppU0iRzZisvcagIsZkZpOGE/Bl1zjPiG2PD3uXAFRG5Lnw2DNoKEpPwt58cbYnvbzh+8tVH9e3MIUTxaifF8nTZgUCdUJYWf+WbijXjQDjDxH0VRjnvIy5y/yqwOZFU4Y+MAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ5kJZ+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9652C4CED0;
	Fri, 13 Dec 2024 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734115913;
	bh=nuENH1SOuth3l2+gbA2o8Hr4R+633dFNAtDHmlEYbCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQ5kJZ+T7jaXiO47UV99cwlFOQgJCus7hmI+wikbSkUfuWSMceqYZGOJ15X6YXUjV
	 hRYjkkaLcimf1//2EK2WBvMwHpKi+rF8ph1CCb5PKZ8Fl4s9TIZLSHogxGR875BzGA
	 jYB12GozAbug1n4OEPUqdCP37dqXU/wos8teLpVsqP0W14QzV2PCzaAX3Eivqzvvfj
	 3mNEFBHs5DX0oYElty4ZmDpAetxYxi1c8s+tgD3wfwKO/KDjNPGFcdRgEej3vRW+wI
	 hfHpMj3EM3XHRYrDIvLhHZpdCrNi0Rns40iypBinNFYaKoHhsUdG64iulKcIdJz2TJ
	 gkQXqcbYxGnqg==
Date: Fri, 13 Dec 2024 19:51:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>

On Fri, Dec 13, 2024 at 09:40:49AM -0500, Liam R. Howlett wrote:
> * Christian Brauner <brauner@kernel.org> [241209 08:47]:
> > Hey,
> > 
> > Ok, I wanted to give this another try as I'd really like to rely on the
> > maple tree supporting ULONG_MAX when BITS_PER_LONG is 64 as it makes
> > things a lot simpler overall.
> > 
> > As Willy didn't want additional users relying on an external lock I made
> > it so that we don't have to and can just use the mtree lock.
> > 
> > However, I need an irq safe variant which is why I added support for
> > this into the maple tree.
> > 
> > This is pullable from
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git work.pidfs.maple_tree
> 
> 
> I've been meaning to respond to this thread.
> 
> I believe the flag is to tell the internal code what lock to use.  If
> you look at mas_nomem(), there is a retry loop that will drop the lock
> to allocate and retry the operation.  That function needs to support the
> flag and use the correct lock/unlock.
> 
> The mas_lock()/mas_unlock() needs a mas_lock_irq()/mas_unlock_irq()
> variant, which would be used in the correct context.

Yeah, it does. Did you see the patch that is included in the series?
I've replaced the macro with always inline functions that select the
lock based on the flag:

static __always_inline void mtree_lock(struct maple_tree *mt)
{
        if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
                spin_lock_irq(&mt->ma_lock);
        else
                spin_lock(&mt->ma_lock);
}
static __always_inline void mtree_unlock(struct maple_tree *mt)
{
        if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
                spin_unlock_irq(&mt->ma_lock);
        else
                spin_unlock(&mt->ma_lock);
}

Does that work for you?

