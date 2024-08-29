Return-Path: <linux-fsdevel+bounces-27830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F76964660
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF48B2A1C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5F41AAE1E;
	Thu, 29 Aug 2024 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XVPUdueT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA9219005B;
	Thu, 29 Aug 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937754; cv=none; b=P8vfQD6TbohZRiI3JYfso/OImIXuzTi4MQtdxaqOXJ6eSUDrwwGWJlbqVQ6XHOnGEmgbHwp1mlYv3rCzAPQTp+yXV4FubT/D5Jy3q+rGD6iMZew/3adOR3wGZi9AxJuiKvLibbqcBtcgpoR/dxYlmU/NqCJ95sZmOWZIo0Sbj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937754; c=relaxed/simple;
	bh=U7Uj34iBOjQIBL8+79QqBquW11A3bDevTr4B/urbcY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/Gp1yHIgnJ4IZLQObib1zZDHo4JyHsct6pMdxGOttYmkXxFHuyfKXw5qfnzp3yo2xYgYvdzXoLdy47Y71O+CwcVpIxyvcZorRuzzZgi2uKtywAkwyo7mTccgWmYyG5XWpW11QwQCqCCgoPfoJXa0rdmcWhLSeL9RAj4AH/vJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XVPUdueT; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 09:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724937750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj903jW2TKogKU1SK5gHYnTDCZ4LBZZEeqojtBImNhA=;
	b=XVPUdueTCc06z491GnDzWivlRjmdKoWWAkMdowwA4gngYbWqqd1X6LEGoWcNjSo64SlLE1
	4dnZxSnYvS/GENkr+38UeUoF+3xU8b9ajFn9urUVP+g5kVCiSJU+bTfSQ5Zy5Z6eF/REV3
	BFxDTcbSJQKSJ0WCgwmjsWNsSxKtI9I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <a53xyedoraogetttff7e2afxx3bcomjh4j2r5qaxxl2v66adlx@4fexbinton3g>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBzstXltxowPOhR@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 11:12:18PM GMT, Dave Chinner wrote:
> On Thu, Aug 29, 2024 at 06:02:32AM -0400, Kent Overstreet wrote:
> > On Wed, Aug 28, 2024 at 02:09:57PM GMT, Dave Chinner wrote:
> > > On Tue, Aug 27, 2024 at 08:15:43AM +0200, Michal Hocko wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > > > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > > > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > > > 
> > > > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > > > dangerous to use if the caller doesn't control the full call chain with
> > > > this flag set. E.g. if any of the function down the chain needed
> > > > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > > > cause unexpected failure.
> > > > 
> > > > While this is not the case in this particular case using the scoped gfp
> > > > semantic is not really needed bacause we can easily pus the allocation
> > > > context down the chain without too much clutter.
> > > > 
> > > > Acked-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > 
> > > Looks good to me.
> > > 
> > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > 
> > Reposting what I wrote in the other thread:
> 
> I've read the thread. I've heard what you have had to say. Like
> several other people, I think your position is just not practical or
> reasonable.
> 
> I don't care about the purity or the safety of the API - the
> practical result of PF_MEMALLOC_NORECLAIM is that __GFP_NOFAIL
> allocation can now fail and that will cause unexpected kernel
> crashes.  Keeping existing code and API semantics working correctly
> (i.e. regression free) takes precedence over new functionality or
> API features that people want to introduce.
> 
> That's all there is to it. This is not a hill you need to die on.

If you use GFP_NOFAIL in a context where you're not allowed to sleep,
that's a bug, same as any other bug where you get the gfp flags wrong
(e.g. GFP_KERNEL in non sleepable context).

This isn't going to affect you unless you start going around inserting
PF_MEMALLOC_NORECLAIM where it doesn't need to be. Why would you do
that?

But the lack of gfp flags for pte allocation means that this actually is
a serious gap we need to be fixing.

