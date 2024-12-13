Return-Path: <linux-fsdevel+bounces-37288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51C89F0CF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B52B283852
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29D19AA58;
	Fri, 13 Dec 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjvjulkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864E1B6D14
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095249; cv=none; b=ShNW4K/e8SNWjUnpRyWpBDyJjMaH+DksvpEJOjj2J7JFulcXxGn03sX5ROjkJddiVHLusrqT7l+oohBFHH+dU1D1Ed2vRW+NlQ/e/bajYfm675tkFbeY6lpTHx8FHN4opff8wYotM7GEcYoaDUu2GyHMad9XB/YL5Tle9WkYrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095249; c=relaxed/simple;
	bh=UKGk4+OKkI0VLiCqDcE+a6hJK4SfFlBmLdSF4ZH8pT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTJZrR/HMYRicMtsq6FLzoBbR2xaN+U6pXmnU88tepyuPsgUMZ5aJzqapq4UDn4Mstyqf4++l5ykMDCSWLwol/4GF4iXt8nshOZw6QlXVYXsh36XuCw0sO7HS1wAdF+UWVF61g4vxUwFtP51hMuI/Wm1PG+ZTQv10VLGRkLwEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjvjulkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECE8C4CED0;
	Fri, 13 Dec 2024 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734095247;
	bh=UKGk4+OKkI0VLiCqDcE+a6hJK4SfFlBmLdSF4ZH8pT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjvjulkXdwLY+1melSMRUPh6ZfAlFQEvctlDVECDWxz2lUEumNbzjHMwXepIs3WcV
	 DMY1L3Z5w2iXDYDheQ4repduBsl3W0JpHp315nVbp7oJbdATQYpbnHUsgNjwxYjJz4
	 h+2buqDr93ZtNQjcdLaa47jEs5KejP6QEwxaJoEDJMabSrM8qVHhRlSzWsIJurOc4t
	 2tuXKt3bIENViz67s4PWa6wI/tX4PTzLbXLig/HN5KapA+YpZEuuja+mufsXvhWPKx
	 Fh1LcNy7LYW4egcU5kUc57yBKii3P4zrXYOpepbIfrGGa1HDR8CRnHeVLHCuYnlnSt
	 8CzRSGLL+qqCQ==
Date: Fri, 13 Dec 2024 14:07:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 2/2] pidfs: use maple tree
Message-ID: <20241213-untypisch-bildmaterial-413504dd3a53@brauner>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <20241209-work-pidfs-maple_tree-v2-2-003dbf3bd96b@kernel.org>
 <CGME20241213103551eucas1p1f97e0ca298e6a9edfc75b287b4c2079e@eucas1p1.samsung.com>
 <e3b555c5-4aff-4f0d-b45b-9c46240a02da@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3b555c5-4aff-4f0d-b45b-9c46240a02da@samsung.com>

On Fri, Dec 13, 2024 at 11:35:48AM +0100, Marek Szyprowski wrote:
> On 09.12.2024 14:46, Christian Brauner wrote:
> > So far we've been using an idr to track pidfs inodes. For some time now
> > each struct pid has a unique 64bit value that is used as the inode
> > number on 64 bit. That unique inode couldn't be used for looking up a
> > specific struct pid though.
> >
> > Now that we support file handles we need this ability while avoiding to
> > leak actual pid identifiers into userspace which can be problematic in
> > containers.
> >
> > So far I had used an idr-based mechanism where the idr is used to
> > generate a 32 bit number and each time it wraps we increment an upper
> > bit value and generate a unique 64 bit value. The lower 32 bits are used
> > to lookup the pid.
> >
> > I've been looking at the maple tree because it now has
> > mas_alloc_cyclic(). Since it uses unsigned long it would simplify the
> > 64bit implementation and its dense node mode supposedly also helps to
> > mitigate fragmentation.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> This patch landed in today's linux-next as commit a2c8e88a30f7 ("pidfs: 
> use maple tree"). In my tests I found that it triggers the following 
> lockdep warning, what probably means that something has not been 
> properly initialized:

Ah, no, I think the issue that it didn't use irq{save,restore} spin lock
variants in that codepath as this is free_pid() which needs it.

I pushed a fix. Please yell if this issue persists.

