Return-Path: <linux-fsdevel+bounces-30827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8F198E830
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 03:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50F5B212A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CEE171CD;
	Thu,  3 Oct 2024 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ekDvryjU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3538F5C
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727919709; cv=none; b=Rh72Nb5yU+WJjsmBScPO53zIT2CHjSJB5MkGoRV4ErAk2HR/UrKtM/K7fk/3zjNOsMPRqXofqURhk6NY6JSGOv08/7E864GRRBi+2ObckdO2DAcjZntOPCW8mtRyImqROn5+wnT5c8cYzHjj1n2MGgDxNmu8J0idqnCXI2Mgwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727919709; c=relaxed/simple;
	bh=1qPpQUO5EGb1gxKYvpV+4HfOLxrvsahdpbnGPY2E/3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8h6fBH2L/nuPyhc2aRav+dESXQYiiu8gBv50Sglmm9l9HTpixV5ibLa2of0kvlbn1UYxQAUDkgy/W4TCztjLa1tCMLw9vs/cSySYm7n+s6rVo0rrV6qrerOYuRA6SNgnr+CTGPfZH/5f4D4nkUMNwpcrGxWlsalDEy0cufGp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ekDvryjU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b6458ee37so3864795ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 18:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727919707; x=1728524507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfWkvMt6wavRpacAWm941R6cOmWrmMkQwdNdNA3gCHo=;
        b=ekDvryjUjaD5R+tanTVIC2rUIyhfFTYcRdBnr0TK7g1a8yCZsf9yFNvCp9zduQf9+A
         loreglUPJfYhR+SNvtF7Le46IwXCmlpw2OhCqYi/rMUtrSXC092y8BWfJQUu03RL52Ru
         +D+2p/CSJku7jQC5IicsBYuVV5JQfragYpYVtbqo2FvQ89ls5smpLPuYXSUAJ0YV39cA
         VU5GOKT1gP60l6GpTHahpe2vWWQRDW5Q5XeZU/AV7kIJirYO3S3gO30sZzG+yBbd7bP+
         65HDo2a3seJO2PRYooDs2sUbq1+n1HNcZ1Dzki72wFeOYFqa8mYXdvHdaiocsVsiWnmi
         EMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727919707; x=1728524507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfWkvMt6wavRpacAWm941R6cOmWrmMkQwdNdNA3gCHo=;
        b=GrnXiwZK9YytmmIrj4/wtlFgg72xUPd2Nou6JTGZsO4NtkxamJGe3DRom0LBbe1B6l
         dD222joxr3LPvYwnQQzvuTNp6JyJP2MAvN2+N7iFSzfBECudH6FDfVtZTNru1idzBGYe
         iKfBSJdzfQK612AhgbyHT/nvFSyF0nXyJdK7pQY3zT9fYnAWWlL19Y+3UQHiNagJL+MI
         A38zpaT+h906MUkP0GvHAwdfgFRswMUoUhjI3Ohvyk8hy2MR/bFOZM1pwqUz5QeG29Tn
         sWR+XqF2Tj/s2Chc37/hIpppPbLQdipw8WGXPwmJJU1FcBRjq4t1o/sM1dCjvoXEXO7+
         +HRg==
X-Forwarded-Encrypted: i=1; AJvYcCW3vihhzl7pGxvNhacOyCY7vdh8ij1z1vWSlyjPIWXa6RF3RhVO0biQGraaeLHfPI0KFmPzlQAWTq1r9He3@vger.kernel.org
X-Gm-Message-State: AOJu0YynZfmZHQZ5fDQ7wFCLpnkEgjJaX47QxGh7NZ3JpTavF5iqk8ZG
	mZbuSYSvx8o+7ALCP/l4mAxPRJcAYX+gs/JrLrpPOSCYgFIFpiRngxOQI6iLV2c=
X-Google-Smtp-Source: AGHT+IGXYyMNQrTUHzKQA6pmURJzKiuRneeS7+pEo6Yu33ob/HKCKL/EXasbpgWD5MLjj8hw06CujA==
X-Received: by 2002:a17:903:22d2:b0:20b:751f:c9ca with SMTP id d9443c01a7336-20bc59ae37emr75304845ad.5.1727919706868;
        Wed, 02 Oct 2024 18:41:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bed49dbb0sm222225ad.100.2024.10.02.18.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 18:41:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1swAqc-00DBdo-23;
	Thu, 03 Oct 2024 11:41:42 +1000
Date: Thu, 3 Oct 2024 11:41:42 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <Zv32Vow1YdYgB8KC@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <3lukwhxkfyqz5xsp4r7byjejrgvccm76azw37pmudohvxcxqld@kiwf5f5vjshk>
 <Zv3H8BxJX2GwNW2Y@dread.disaster.area>
 <lngs2n3kfwermwuadhrfq2loff3k4psydbjullhecuutthpqz3@4w6cybx7boxw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lngs2n3kfwermwuadhrfq2loff3k4psydbjullhecuutthpqz3@4w6cybx7boxw>

On Wed, Oct 02, 2024 at 07:20:16PM -0400, Kent Overstreet wrote:
> On Thu, Oct 03, 2024 at 08:23:44AM GMT, Dave Chinner wrote:
> > On Wed, Oct 02, 2024 at 03:29:10PM -0400, Kent Overstreet wrote:
> > > On Wed, Oct 02, 2024 at 10:34:58PM GMT, Dave Chinner wrote:
> > > > On Wed, Oct 02, 2024 at 12:00:01PM +0200, Christian Brauner wrote:
> > > > > On Wed, Oct 02, 2024 at 11:33:17AM GMT, Dave Chinner wrote:
> > > > > > What do people think of moving towards per-sb inode caching and
> > > > > > traversal mechanisms like this?
> > > > > 
> > > > > Patches 1-4 are great cleanups that I would like us to merge even
> > > > > independent of the rest.
> > > > 
> > > > Yes, they make it much easier to manage the iteration code.
> > > > 
> > > > > I don't have big conceptual issues with the series otherwise. The only
> > > > > thing that makes me a bit uneasy is that we are now providing an api
> > > > > that may encourage filesystems to do their own inode caching even if
> > > > > they don't really have a need for it just because it's there.  So really
> > > > > a way that would've solved this issue generically would have been my
> > > > > preference.
> > > > 
> > > > Well, that's the problem, isn't it? :/
> > > > 
> > > > There really isn't a good generic solution for global list access
> > > > and management.  The dlist stuff kinda works, but it still has
> > > > significant overhead and doesn't get rid of spinlock contention
> > > > completely because of the lack of locality between list add and
> > > > remove operations.
> > > 
> > > There is though; I haven't posted it yet because it still needs some
> > > work, but the concept works and performs about the same as dlock-list.
> > > 
> > > https://evilpiepirate.org/git/bcachefs.git/log/?h=fast_list
> > > 
> > > The thing that needs to be sorted before posting is that it can't shrink
> > > the radix tree. generic-radix-tree doesn't support shrinking, and I
> > > could add that, but then ida doesn't provide a way to query the highest
> > > id allocated (xarray doesn't support backwards iteration).
> > 
> > That's an interesting construct, but...
> > 
> > > So I'm going to try it using idr and see how that performs (idr is not
> > > really the right data structure for this, split ida and item radix tree
> > > is better, so might end up doing something else).
> > > 
> > > But - this approach with more work will work for the list_lru lock
> > > contention as well.
> > 
> > ....  it isn't a generic solution because it is dependent on
> > blocking memory allocation succeeding for list_add() operations.
> > 
> > Hence this cannot do list operations under external synchronisation
> > constructs like spinlocks or rcu_read_lock(). It also introduces
> > interesting interactions with memory reclaim - what happens we have
> > to add an object to one of these lists from memory reclaim context?
> > 
> > Taking the example of list_lru, this list construct will not work
> > for a variety of reasons. Some of them are:
> > 
> > - list_lru_add() being called from list_lru_add_obj() under RCU for
> >   memcg aware LRUs so cannot block and must not fail.
> > - list_lru_add_obj() is called under spinlocks from inode_lru_add(),
> >   the xfs buffer and dquot caches, the workingset code from under
> >   the address space mapping xarray lock, etc. Again, this must not
> >   fail.
> > - list_lru_add() operations take can place in large numbers in
> >   memory reclaim context (e.g. dentry reclaim drops inodes which
> >   adds them to the inode lru). Hence memory reclaim becomes even
> >   more dependent on PF_MEMALLOC memory allocation making forwards
> >   progress.
> > - adding long tail list latency to what are currently O(1) fast path
> >   operations (e.g.  mulitple allocations tree splits for LRUs
> >   tracking millions of objects) is not desirable.
> > 
> > So while I think this is an interesting idea that might be useful in
> > some cases, I don't think it is a viable generic scalable list
> > construct we can use in areas like list_lru or global list
> > management that run under external synchronisation mechanisms.
> 
> There are difficulties, but given the fundamental scalability and
> locking issues with linked lists, I think this is the approach we want
> if we can make it work.

Sure, but this is a completely different problem to what I'm trying
to address here. I want infrastructure that does not need global
lists or list_lru for inode cache maintenance at all. So talking
about how to make the lists I am trying to remove scale better is
kinda missing the point....

> A couple things that help - we've already determined that the inode LRU
> can go away for most filesystems,

We haven't determined that yet. I *think* it is possible, but there
is a really nasty inode LRU dependencies that has been driven deep
down into the mm page cache writeback code.  We have to fix that
awful layering violation before we can get rid of the inode LRU.

I *think* we can do it by requiring dirty inodes to hold an explicit
inode reference, thereby keeping the inode pinned in memory whilst
it is being tracked for writeback. That would also get rid of the
nasty hacks needed in evict() to wait on writeback to complete on
unreferenced inodes.

However, this isn't simple to do, and so getting rid of the inode
LRU is not going to happen in the near term.

> and we can preallocate slots without
> actually adding objects. Iteration will see NULLs that they skip over,
> so we can't simply preallocate a slot for everything if nr_live_objects
> / nr_lru_objects is too big. But, we can certainly preallocate slots on
> a given code path and then release them back to the percpu buffer if
> they're not used.

I'm not really that interested in spending time trying to optimise
away list_lru contention at this point in time.

It's not a performance limiting factor because inode and
dentry LRU scalability is controllable by NUMA configuration. i.e.
if you have severe list_lru lock contention on inode and dentry
caches, then either turn on Sub-NUMA Clustering in your bios,
configure your VM with more discrete nodes, or use the fake-numa=N
boot parameter to increase the number of nodes the kernel sets up.
This will increase the number of list_lru instances for NUMA aware
shrinkers and the contention will go away.

This is trivial to do and I use the "configure your VM with more
discrete nodes" method for benchmarking purposes. I've run my perf
testing VMs with 4 nodes for the past decade and the list_lru
contention has never got above the threshold of concern. There's
always been something else causing worse problems, and even with
the sb->s_inodes list out of the way, it still isn't a problem on
64-way cache-hammering workloads...

> > - LRU lists are -ordered- (it's right there in the name!) and this
> >   appears to be an unordered list construct.
> 
> Yes, it is. But in actual practice cache replacement policy tends not to
> matter nearly as much as people think; there's many papers showing real
> world hit ratio of common algorithms is only a fudge factor from random
> replacement - the main thing you want is an accessed bit (or counter, if
> you want the analagous version of n-lru for n > 2), and we'll still have
> that.

Sure.  But I can cherry-pick many papers showing exactly the opposite.
i.e. that LRU and LFU algorithms are far superior at maintaining a
working set compared to random cache shootdown, especially when
there is significant latency for cache replacement.

What matters is whether there are any behavioural regressions as a
result of changing the current algorithm. We've used quasi-LRU
working set management for so long that this is the behaviour that
people have tuned their systems and applications to work well with.
Fundamental changes to working set maintenance behaviour is not
something I'm considering doing, nor something I *want* to do.

And, really, this is way outside the scope of this patch set. It's
even outside of the scope of "remove the inode cache LRU" proposal
because that proposal is based on the existing dentry cache LRU
working set management making the inode cache LRU completely
redundant. i.e.  it's not a change of working set management
algorithms at all....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

