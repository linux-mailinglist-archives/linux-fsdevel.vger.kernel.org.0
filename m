Return-Path: <linux-fsdevel+bounces-14132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F68780E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 14:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFB41F223B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F33E46D;
	Mon, 11 Mar 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq47LWFT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294763DB89
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165090; cv=none; b=VpXaKACQQtZ88EboCnD1cgrPpnnDZ3A+aQjI1X+oWO3SmITvw2Uw3t6083s02mqS21MCf4Sy7YkLHPmOb+JhJAmszZ6DE6ax6qRwQj1WLzVJNy9LN7VWW5Px4K88SHmrn5YRs+Gg3AraFGNyLvOw9HgoTkUA9lYm20xW6/A55YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165090; c=relaxed/simple;
	bh=2pr/8xSfiRk3Q9Kb9Dy++iUKh8pYt8fv8FbkIKsE7Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWCzGKVQ1V4XeDFOX2aOkb43xcG0WpwAsLtJa/dsfcjrqdebbwCKTQ7NEEO0npJKGxtTQ3/G6zqT3fdJy+2fXN7ph8TPeWxeTKrKcF0pk139rLxwJWpy+XjQ6qu8PRUy6C3P0TVSQ4cRyhoQH8mEu7Ko8N1L9SfGxNGLZZ36bKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq47LWFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBE8C43390;
	Mon, 11 Mar 2024 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710165089;
	bh=2pr/8xSfiRk3Q9Kb9Dy++iUKh8pYt8fv8FbkIKsE7Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mq47LWFT3eD5IHQmIqR1FPfhwFoBzFxCDsEX9NVY3WideHt97c5h6DUajquG8/NiJ
	 Sc8u7VMJsH8EjJEtnqqjx66qrtBWB0u5rdGNi2fEHuYW3rS7iM/DQowXt/PKUtKIRr
	 3NyPwxHlQaG7ELYwi/9u9uGLi4a6z8JKTABdFfqSIs/6iP5uXG0+IQ9TRvr1gwQ+na
	 BClGVXpL2z1Ibau+aQ1Q6789nz9yE1bdFfIDXTU6KaLXhRAYmt3ZaWnhFP65zykKFJ
	 dPha+5fI6ibrfdBuw48bcoMJywcY8UVRAU2Su0gntEaqccCuYlIEmVMn5U8n2xodg6
	 V+TsOUKnkRGNg==
Date: Mon, 11 Mar 2024 14:51:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
Message-ID: <20240311-ensemble-bislang-0bed3f0e780b@brauner>
References: <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
 <20240124160758.zodsoxuzfjoancly@quack3>
 <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
 <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com>
 <20240214112310.ovg2w3p6wztuslnw@quack3>
 <CAOQ4uxjS1NNJY0tQXRC3qo3_J4CB4xZpxJc7OCGp1236G6yNFw@mail.gmail.com>
 <20240215083648.dhjgdj43npgkoe7p@quack3>
 <CAOQ4uxjDndJr8oTGyWhLSebFsBcRQ4g=GwYZvdWQmRpXXdmx5A@mail.gmail.com>
 <20240308160058.eu7thhohy2d3xtcz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240308160058.eu7thhohy2d3xtcz@quack3>

On Fri, Mar 08, 2024 at 05:00:58PM +0100, Jan Kara wrote:
> On Wed 06-03-24 16:51:06, Amir Goldstein wrote:
> > On Thu, Feb 15, 2024 at 10:36 AM Jan Kara <jack@suse.cz> wrote:
> > > On Wed 14-02-24 15:40:31, Amir Goldstein wrote:
> > > > > > > > Merged your improvement now (and I've split off the cleanup into a separate
> > > > > > > > change and dropped the creation of fsnotify_path() which seemed a bit
> > > > > > > > pointless with a single caller). All pushed out.
> > > > > > > >
> > > > > > >
> > > > > >
> > > > > > Jan & Jens,
> > > > > >
> > > > > > Although Jan has already queued this v3 patch with sufficient performance
> > > > > > improvement for Jens' workloads, I got a performance regression report from
> > > > > > kernel robot on will-it-scale microbenchmark (buffered write loop)
> > > > > > on my fan_pre_content patches, so I tried to improve on the existing solution.
> > > > > >
> > > > > > I tried something similar to v1/v2 patches, where the sb keeps accounting
> > > > > > of the number of watchers for specific sub-classes of events.
> > > > > >
> > > > > > I've made two major changes:
> > > > > > 1. moved to counters into a per-sb state object fsnotify_sb_connector
> > > > > >     as Christian requested
> > > > > > 2. The counters are by fanotify classes, not by specific events, so they
> > > > > >     can be used to answer the questions:
> > > > > > a) Are there any fsnotify watchers on this sb?
> > > > > > b) Are there any fanotify permission class listeners on this sb?
> > > > > > c) Are there any fanotify pre-content (a.k.a HSM) class listeners on this sb?
> > > > > >
> > > > > > I think that those questions are very relevant in the real world, because
> > > > > > a positive answer to (b) and (c) is quite rare in the real world, so the
> > > > > > overhead on the permission hooks could be completely eliminated in
> > > > > > the common case.
> > > > > >
> > > > > > If needed, we can further bisect the class counters per specific painful
> > > > > > events (e.g. FAN_ACCESS*), but there is no need to do that before
> > > > > > we see concrete benchmark results.
> > > ...
> > >
> > > > > Then I dislike how we have to specialcase superblock in quite a few places
> > > > > and add these wrappers and what not. This seems to be mostly caused by the
> > > > > fact that you directly embed fsnotify_mark_connector into fsnotify_sb_info.
> > > > > What if we just put fsnotify_connp_t there? I understand that this will
> > > > > mean one more pointer fetch if there are actually marks attached to the
> > > > > superblock and the event mask matches s_fsnotify_mask. But in that case we
> > > > > are likely to generate the event anyway so the cost of that compared to
> > > > > event generation is negligible?
> > > > >
> > > >
> > > > I guess that can work.
> > > > I can try it and see if there are any other complications.
> > > >
> > > > > And I'd allocate fsnotify_sb_info on demand from fsnotify_add_mark_locked()
> > > > > which means that we need to pass object pointer (in the form of void *)
> > > > > instead of fsnotify_connp_t to various mark adding functions (and transform
> > > > > it to fsnotify_connp_t only in fsnotify_add_mark_locked() after possibly
> > > > > setting up fsnotify_sb_info). Passing void * around is not great but it
> > > > > should be fairly limited (and actually reduces the knowledge of fsnotify
> > > > > internals outside of the fsnotify core).
> > > >
> > > > Unless I am missing something, I think we only need to pass an extra sb
> > > > arg to fsnotify_add_mark_locked()? and it does not sound like a big deal.
> > > > For adding an sb mark, connp arg could be NULL, and then we get connp
> > > > from sb->fsnotify_sb_info after making sure that it is allocated.
> > >
> > > Yes that would be another possibility but frankly I like passing the
> > > 'object' pointer instead of connp pointer a bit more. But we can see how
> > > the code looks like.
> > 
> > Ok, here it is:
> > 
> > https://github.com/amir73il/linux/commits/fsnotify-sbinfo/
> > 
> > I agree that the interface does end up looking better this way.
> 
> Yep, the interface looks fine. I have left some comments on github
> regarding typos and some suspicious things.
> 
> > I've requested to re-test performance on fsnotify-sbinfo.
> > 
> > You can use this rebased branch to look at the diff from the
> > the previous patches that were tested by 0day:
> > 
> > https://github.com/amir73il/linux/commits/fsnotify-sbconn/
> > 
> > If you have the bandwidth to consider those patches as candidates
> > for (the second half of?) 6.9 merge window, I can post them for review.
> 
> Well, unless Linus does rc8, I don't think we should queue these for the
> merge window as it is too late by now. But please post them for review,
> I'll have a look. I can then push them to my tree early into a stable
> branch and you can base your patches on my branch. If the patches then need
> to go through VFS tree, Christian is fine with pulling my tree...

I'm absolutely opposed to touching anything that you do. I'm joking of
course, I'm very happy to pull from you!

