Return-Path: <linux-fsdevel+bounces-45443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0937A77B30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A8216B12D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B708202C55;
	Tue,  1 Apr 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4QkaICZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F126AF3;
	Tue,  1 Apr 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511555; cv=none; b=YGlw0fJFLjEVySG9Hn8dxVnq06nkImjCjq8DGEfTnBCShNqrSuQhWdXv2dtUAfDbg7Y5Cye5EBykZ8fidN185G/6xD9EN2nEBuGzvrlKbeWRRGN4fikuvusVFByt+PknK4vGj5zHFeBgFkZbR+asqB15zRQYUr+KyZKgFyySqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511555; c=relaxed/simple;
	bh=5kmgdEAsQqihiNsR3taaVx0rqImbTvhfajN7gqFQAHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABZE12v6hqMYJ8F1LXGPP9hpYi3AMIgEVbcR+ZOyO+TDNtFNpf/+fGOgp4rxgtx5qKtX1plP+u3RFZejZwCvyhGd4LzYT+P1XQvT1lgdbvLl3mAFODOCadR+zprRJLFCQQyHFBlmyfdgYduHCt9GV3tQFjY6S8PoAbI32pCNVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4QkaICZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA805C4CEE4;
	Tue,  1 Apr 2025 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743511554;
	bh=5kmgdEAsQqihiNsR3taaVx0rqImbTvhfajN7gqFQAHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4QkaICZKu94q1MuFUPbbFeHr7OkoHLxG7/scJsU9qQZ+/PyIVGpKP1XKXq+6e4nc
	 1nJL4rSwMRCTBsV9mFCk+YfVoqPJrd/+EnOWJbXK9G+sQb0t9tRbNHxLTRtFQXwoRS
	 TsMs+zymEBuszTRAAsvO06yYOO1rGcgX4ek6LxtzXcthpHWCMwG9HeaOpHeMO3CZCV
	 giwYnpKnVKkfiwyrjAyxbXFIHiTtcDutO1o38Oz7uqfCTIlnqlEy2Yc8PHaw24NvZO
	 wsMlfnE3nXLHqVJC0d8AHd5a5hd0yTaQJnhaLbrznojl5SvSO+toXT3L/+GWwoEXg4
	 7tVe+K3bUlbAQ==
Date: Tue, 1 Apr 2025 14:45:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] xfs: replace kthread freezing with auto fs freezing
Message-ID: <20250401-packung-kurzfassung-696cefc2e3da@brauner>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401-work-freeze-v1-3-d000611d4ab0@kernel.org>
 <Z-s9KG-URzB9DwUb@dread.disaster.area>
 <20250401-baubeginn-ausdehnen-3a7387b756aa@brauner>
 <Z-vPnmL7wn_8cFim@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-vPnmL7wn_8cFim@dread.disaster.area>

On Tue, Apr 01, 2025 at 10:35:58PM +1100, Dave Chinner wrote:
> On Tue, Apr 01, 2025 at 09:17:12AM +0200, Christian Brauner wrote:
> > On Tue, Apr 01, 2025 at 12:11:04PM +1100, Dave Chinner wrote:
> > > On Tue, Apr 01, 2025 at 02:32:48AM +0200, Christian Brauner wrote:
> > > > diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
> > > > index c5136ea9bb1d..1875b6551ab0 100644
> > > > --- a/fs/xfs/xfs_zone_gc.c
> > > > +++ b/fs/xfs/xfs_zone_gc.c
> > > > @@ -993,7 +993,6 @@ xfs_zone_gc_handle_work(
> > > >  	}
> > > >  
> > > >  	__set_current_state(TASK_RUNNING);
> > > > -	try_to_freeze();
> > > >  
> > > >  	if (reset_list)
> > > >  		xfs_zone_gc_reset_zones(data, reset_list);
> > > > @@ -1041,7 +1040,6 @@ xfs_zoned_gcd(
> > > >  	unsigned int		nofs_flag;
> > > >  
> > > >  	nofs_flag = memalloc_nofs_save();
> > > > -	set_freezable();
> > > >  
> > > >  	for (;;) {
> > > >  		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
> > > 
> > > Same question here for this newly merged code, too...
> >
> > I'm not sure if this is supposed to be a snipe or not but just in case
> > this is a hidden question:
> 
> No, I meant that this is changing shiny new just-merged XFS code
> (part of zone device support). It only just arrived this merge
> window and is largely just doing the same thing as the older aild
> code. It is probably safe to assume that this new code has never
> been tested against hibernate...

Ah, my brain is completely fried. Apparently reading English is a skill
I've lost since coming back from Montreal. Thanks!

