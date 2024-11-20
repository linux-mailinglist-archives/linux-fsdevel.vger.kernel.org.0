Return-Path: <linux-fsdevel+bounces-35290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0A9D36F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D72B1F27001
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90619CC36;
	Wed, 20 Nov 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVJLRAQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D684192D6E;
	Wed, 20 Nov 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094390; cv=none; b=ld1zgzQKswOp2XVg8uNHDZ7RD335t3CEhkGKqTQl8qMTD42C8uymGTmqvYbQ4YAE6VckxiJZZl548DeX/nZO+uKuNEHT++ayVZFgI+udag5ws9Twd1Ji8jxXAxaDofBzmVc1XgBhXKWcgVSJ9PXeruJs4sI0Fi9Or/MbNywf2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094390; c=relaxed/simple;
	bh=nQQ9E5OjrzMfAy1wCqrR6wpgwymrPIzfYqGlLEyqR1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9s/OgcZM+iz9VP3Nh8xRzPvAsUjbUjSc6O/lyiNZKWaR+remF/OqGe3FlYPMFkSPPNjtjuC6Z9EE5a3PoVx2+j9ghBeU6WZY4vBszEr2fkbvv505MhVYzmHDyMEprc2+XfWHYBpRyppAgx3owPr6DBFS2zschaHxUVryl3Sc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVJLRAQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E80C4CECD;
	Wed, 20 Nov 2024 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732094390;
	bh=nQQ9E5OjrzMfAy1wCqrR6wpgwymrPIzfYqGlLEyqR1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVJLRAQitgOJjEZdzAmGkZpBDtwm/QicEhZ6gcn2y80XPDiuKlrfUNgTOIeOF3kN3
	 3P3eHB9csIMwHbJc+3eyToRkizzeR7ws5TT2IVxbFIBF1RD7aeo1VXAZT2WAT/TPC5
	 oFJ47bamw4vmwi+U+Jhj8D5t6DQQIpxion3Ph2nk9USoPEWPaRbo+FOKjXjS7bKm1Z
	 Tc8HTzyK4F83uX1pkEpQSMpSYSUsvzTyRiBSHjN+EuFQtekEoEsuOee6EpGoJYHOBn
	 8ns2QYluAP9kI13FDwQ3DSgM+nhBE+jqXbnVTKnvyLwPtIf+3gJRa9gkxgCxwch0ZO
	 vgs6duuz5TIgw==
Date: Wed, 20 Nov 2024 10:19:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeongjun Park <aha310510@gmail.com>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: prevent data-race due to missing inode_lock when
 calling vfs_getattr
Message-ID: <20241120-platzen-mundart-8de12841abfc@brauner>
References: <20241117165540.GF3387508@ZenIV>
 <E79FF080-A233-42F6-80EB-543384A0C3AC@gmail.com>
 <20241118070330.GG3387508@ZenIV>
 <3pgol63eo77aourqigop3wrub7i3m5rvubusbwb4iy5twldfww@4lhilngahtxg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3pgol63eo77aourqigop3wrub7i3m5rvubusbwb4iy5twldfww@4lhilngahtxg>

On Wed, Nov 20, 2024 at 02:44:17AM +0100, Mateusz Guzik wrote:
> On Mon, Nov 18, 2024 at 07:03:30AM +0000, Al Viro wrote:
> > On Mon, Nov 18, 2024 at 03:00:39PM +0900, Jeongjun Park wrote:
> > > All the functions that added lock in this patch are called only via syscall,
> > > so in most cases there will be no noticeable performance issue.
> > 
> > Pardon me, but I am unable to follow your reasoning.
> > 
> 
> I suspect the argument is that the overhead of issuing a syscall is big
> enough that the extra cost of taking the lock trip wont be visible, but
> that's not accurate -- atomics are measurable when added to syscalls,
> even on modern CPUs.
> 
> > > And
> > > this data-race is not a problem that only occurs in theory. It is
> > > a bug that syzbot has been reporting for years. Many file systems that
> > > exist in the kernel lock inode_lock before calling vfs_getattr, so
> > > data-race does not occur, but only fs/stat.c has had a data-race
> > > for years. This alone shows that adding inode_lock to some
> > > functions is a good way to solve the problem without much 
> > > performance degradation.
> > 
> > Explain.  First of all, these are, by far, the most frequent callers
> > of vfs_getattr(); what "many filesystems" are doing around their calls
> > of the same is irrelevant.  Which filesystems, BTW?  And which call
> > chains are you talking about?  Most of the filesystems never call it
> > at all.
> > 
> > Furthermore, on a lot of userland loads stat(2) is a very hot path -
> > it is called a lot.  And the rwsem in question has a plenty of takers -
> > both shared and exclusive.  The effect of piling a lot of threads
> > that grab it shared on top of the existing mix is not something
> > I am ready to predict without experiments - not beyond "likely to be
> > unpleasant, possibly very much so".
> > 
> > Finally, you have not offered any explanations of the reasons why
> > that data race matters - and "syzbot reporting" is not one.  It is
> > possible that actual observable bugs exist, but it would be useful
> > to have at least one of those described in details.
> > 
> [snip]
> 
> On the stock kernel it is at least theoretically possible to transiently
> observe a state which is mid-update (as in not valid), but I was under
> the impression this was known and considered not a problem.

Exactly.

> 
> Nonetheless, as an example say an inode is owned by 0:0 and is being
> chowned to 1:1 and this is handled by setattr_copy.
> 
> The ids are updated one after another:
> [snip]
>         i_uid_update(idmap, attr, inode);
>         i_gid_update(idmap, attr, inode);
> [/snip]
> 
> So at least in principle it may be someone issuing getattr in parallel
> will happen to spot 1:0 (as opposed to 0:0 or 1:1), which was never set
> on the inode and is merely an artifact of hitting the timing.
> 
> This would be a bug, but I don't believe this is serious enough to
> justify taking the inode lock to get out of. 

I don't think this is a serious issue. We don't guarantee consistent
snapshots and I don't see a reason why we should complicate setattr()
for that.

