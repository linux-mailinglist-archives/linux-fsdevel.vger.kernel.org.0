Return-Path: <linux-fsdevel+bounces-44242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDCA667B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 04:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6D43B69E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 03:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657131EF369;
	Tue, 18 Mar 2025 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Aw0a8U0a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E31DFE0A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269344; cv=none; b=lW5V7AB13XfHOanggQcCHyCo297BWtD4vhNwsIKmA/m2jFrpQ/7ZSLExOgDXMd9ABWuzBm4mBK7+odx54V6t7sinJQcsOaXUI7LYswCZeEZd2ZPOgiDiJYDFfk2fZeG7HzZZntN+IvyKaOGZMQc9nqfWgJq2sxiRHizG6r5G/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269344; c=relaxed/simple;
	bh=fuazFHEQcwF3ZFpgNdk0JGF+/JmvYUxz6glupTYasI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krNLPsfGvWdgD3i1q7MJOPWf6RiS8eSNm8gf9tvyLM8PanZg1IZVUue50DmbkZnkfC1F+TG6JSunkHOd1zO/7W1q/YTsjwo6j3LcPQ9St24drCHy5jb2eqxxgG/VztV90s/tD6y2JvdW43q5YkuXw2/oYCeCS+OrGgNEzcoG5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Aw0a8U0a; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3018c9c6b5fso2544331a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742269342; x=1742874142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zSSvgytu1eDQ4Z7kaHEIk7BiH86TETTHZGl4HEGLn4I=;
        b=Aw0a8U0adSRGowjM+KizfPXxifdjJ2LavVC3Qf3dPdShrp6febnxV4Xfc+GgPeFqB7
         N+03OSMFrqs6is1CMHI/mQd2rn8E4sVcwNQrjE+iwaR4eXtE6qwDh/SYZaN37Fiabz53
         PeCZUZDiXM9zbHd/t0bZX7G2uSlUu9GhkuUkLJWDngxsDEFtd9NiYlB6aAzETDh5AKGS
         jHr9z2eFfjVzieivI3IST6l0iNm6u3Xph0hQBmfyJW/FOoB4A+qTSOPpWZKFMcIy28dU
         EvkUWSDuu8l3S0KMXsYlS0Qdof0x3Zsc2MOf/GE6bQDzEiaM9/1KCQ2cipsQ2BpTFrNQ
         tGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742269342; x=1742874142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSSvgytu1eDQ4Z7kaHEIk7BiH86TETTHZGl4HEGLn4I=;
        b=OtBwydT93nFGyuqWDMOCByvjZUlY+ID66qOprGvwRhvaSezkyyPGYd1bEBZMK3+mG8
         3XzUamQmh7v4Fc3qMA3pluB5Pmj91/aZCR9aIvfGKmv5BKp8bAoU5l5WfdIQOhHewYa2
         ptKNmb1kqyhVOSjemSRLKzXHF0YlNJzI2VIN6CeadI/qjZJlq1Hzz2vKpbZxLVWJG1QE
         jHDnHFuPfw1+zIUWW+ZvIsIMYnCbebqE2o+nLBHo8y2rijsNq4nL7jpTmsYd2/Ce5Jvz
         r94NMeSlZez4xP5JY/7HKmGLRI69TOuMn00mlq22a81zGHwq7WY50eLB6dlXJFKqlF8h
         OfHg==
X-Forwarded-Encrypted: i=1; AJvYcCVgAd8oQ/x9KM6KVQ+T3KITfnmBMSl7ckv67n5LAXO49bO0KHOtgXj1rH0sKFVAgfXdFxWORWfj+7PnP4iS@vger.kernel.org
X-Gm-Message-State: AOJu0YwDuthKiNmXP4ft02yxyf0BYKOjzUsYK4xi37LQLuD5FI9fncI0
	YEVGz5a2s7txqC4GbkJByqKNBvO1P2kaDwHjFzNRPQxptjGltFBS41qGbbhdZfQ=
X-Gm-Gg: ASbGnctVUUlxLPlm7kvT8CfJ7WCFadG4cg1yRmpZZIYyRl19y1fsyVF1Y7BuDhujb6Q
	ubiqPdbfb/fp7Qkn/t7ROLO/CMj3CP8aLrkCgoiNxacjsDcoSwxH4DCu0K6fNuTo0gsokhjxcLI
	viWi/l/9tm9raiLERDo5CgjJ01qSh8hiL1/ZErtwtntcV2BDgdD8aY3IuAdAUJdjxkqTCVUjJgD
	cOH3IfjJlJ78ERJ7lUkDaAU2NwpCgDhLF9TjkvvPv+jZPNtpgxkZzeNxIVE4AL99DOR98C2LA+V
	77fNnbaPPZUWAFXHSNUO2NYk4kDs5z2ZTT9513k9Hw5+kaJ9uH5aXtNXdPd1O+JNMucVskXjqGA
	k+KeqLjFOJVrLdp52ukur4ed7vHOIAqo=
X-Google-Smtp-Source: AGHT+IEWmUHqI3LkHzRMAEboE/DFznWKVdldkidyKUOQb4aGW13BLaNqii80L80JKoJnJjuk3PXpRg==
X-Received: by 2002:a17:90b:3d86:b0:2ee:8e75:4aeb with SMTP id 98e67ed59e1d1-301a5b24315mr1225738a91.17.1742269341895;
        Mon, 17 Mar 2025 20:42:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301539ee99fsm6979796a91.20.2025.03.17.20.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 20:42:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tuNqM-0000000EYDI-1Aci;
	Tue, 18 Mar 2025 14:42:18 +1100
Date: Tue, 18 Mar 2025 14:42:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, Christoph Hellwig <hch@lst.de>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, willy@infradead.org,
	gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <Z9jrmu9dXMUaNYba@dread.disaster.area>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
 <Z6GAYFN3foyBlUxK@dread.disaster.area>
 <20250204050642.GF28103@lst.de>
 <s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
 <Z6qkLjSj1K047yPt@dread.disaster.area>
 <20250220141824.ju5va75s3xp472cd@green245>
 <qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>

On Thu, Mar 13, 2025 at 09:22:00PM +0100, Jan Kara wrote:
> On Thu 20-02-25 19:49:22, Kundan Kumar wrote:
> > > Well, that's currently selected by __inode_attach_wb() based on
> > > whether there is a memcg attached to the folio/task being dirtied or
> > > not. If there isn't a cgroup based writeback task, then it uses the
> > > bdi->wb as the wb context.
> > 
> > We have created a proof of concept for per-AG context-based writeback, as
> > described in [1]. The AG is mapped to a writeback context (wb_ctx). Using
> > the filesystem handler, __mark_inode_dirty() selects writeback context
> > corresponding to the inode.
> > 
> > We attempted to handle memcg and bdi based writeback in a similar manner.
> > This approach aims to maintain the original writeback semantics while
> > providing parallelism. This helps in pushing more data early to the
> > device, trying to ease the write pressure faster.
> > [1] https://lore.kernel.org/all/20250212103634.448437-1-kundan.kumar@samsung.com/
> 
> Yeah, I've seen the patches. Sorry for not getting to you earlier.
>  
> > > Then selecting inodes for writeback becomes a list_lru_walk()
> > > variant depending on what needs to be written back (e.g. physical
> > > node, memcg, both, everything that is dirty everywhere, etc).
> > 
> > We considered using list_lru to track inodes within a writeback context.
> > This can be implemented as:
> > struct bdi_writeback {
> >  struct list_lru b_dirty_inodes_lru; // instead of a single b_dirty list
> >  struct list_lru b_io_dirty_inodes_lru;
> >  ...
> >  ...
> > };
> > By doing this, we would obtain a sharded list of inodes per NUMA node.
> 
> I think you've misunderstood Dave's suggestion here. list_lru was given as
> an example of a structure for inspiration. We cannot take it directly as is
> for writeback purposes because we don't want to be sharding based on NUMA
> nodes but rather based on some other (likely FS driven) criteria.

Well, you might say that, but.....

... I was actually thinking of taking the list_lru and abstracting
it's N-way parallelism away from the numa infrastructure.

The NUMA awareness of the list_lru is largely in external APIs. Th
eonly implicit NUMA awareness is in the list_lru_add() function
where it converts the object being added to the list to a node ID
based on where it is physically located in memory.

The only other thing that is NUMA specific is that the list is set
up with N-way concurrency when N = the number of NUMA nodes in the
machine.

So, really, it is just thin veneer of NUMA wrapped around the
inherent concurrency built into the structure.

IOWs, when we create a list_lru for a numa aware shrinker, we simply
use the number of nodes as the N-way parallelism for the list,
and the existing per-node infrastructure simply feeds the right
numa node ID as the "list index" for it to function as is.

In the case of writeback parallelism, we could create a list_lru
with the number of AGs as the N-way parallism for the list, and then
have the concurrent BDI writeback context (1 per AG) simply provide
the AG number as the "list index" for writeback....

> > However, we would also need per-NUMA writeback contexts. Otherwise,
> > even if inodes are NUMA-sharded, a single writeback context would stil
> > process them sequentially, limiting parallelism. But there’s a concern:
> > NUMA-based writeback contexts are not aligned with filesystem geometry,
> > which could negatively impact delayed allocation and writeback efficiency,
> > as you pointed out in your previous reply [2].
> > 
> > Would it be better to let the filesystem dictate the number of writeback
> > threads, rather than enforcing a per-NUMA model?
> 
> I was thinking about how to best parallelize the writeback and I think
> there are two quite different demands for which we probably want two
> different levels of parallelism.
> 
> One case is the situation when the filesystem for example has multiple
> underlying devices (like btrfs or bcachefs) or for other reasons writeback
> to different parts is fairly independent (like for different XFS AGs). Here
> we want parallelism at rather high level I think including separate
> dirty throttling, tracking of writeback bandwidth etc.. It is *almost* like
> separate bdis (struct backing_dev_info) but I think it would be technically
> and also conceptually somewhat easier to do the multiplexing by factoring
> out:
> 
>         struct bdi_writeback wb;  /* the root writeback info for this bdi */
>         struct list_head wb_list; /* list of all wbs */
> #ifdef CONFIG_CGROUP_WRITEBACK
>         struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
>         struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
> #endif
>         wait_queue_head_t wb_waitq;
> 
> into a new structure (looking for a good name - bdi_writeback_context???)
> that can get multiplied (filesystem can create its own bdi on mount and
> configure there number of bdi_writeback_contexts it wants). We also need to
> add a hook sb->s_ops->get_inode_wb_context() called from __inode_attach_wb()
> which will return appropriate bdi_writeback_context (or perhaps just it's
> index?) for an inode. This will be used by the filesystem to direct
> writeback code where the inode should go. This is kind of what Kundan did
> in the last revision of his patches but I hope this approach should
> somewhat limit the changes necessary to writeback infrastructure - the
> patch 2 in his series is really unreviewably large...

Yes, this is the equivalent of the SHRINKER_NUMA_AWARE flag that
triggers the shrinker infrastructure to track work in a NUMA aware
way when the subsystem shrinker callbacks are using the NUMA aware
list_lru to back it....

> Then another case is a situation where either the amount of CPU work is
> rather high for IO submission (cases like Christoph mentioned where
> filesystem needs to do checksumming on submission or similar) or simply the
> device is rather fast for a single submission thread and the FS doesn't
> have a sensible way to partition inodes (e.g. for ext4 there's no
> meaningful way of partitioning inodes into independent groups - ext4
> allocation groups are small and inodes often span multiple groups and the
> sets of groups used by different inodes randomly overlap). In this case I
> think we want single dirty throttling instance, single writeback throughput
> estimation, single set of dirty inode lists etc. The level where the
> parallelism needs to happen is fairly low - I'd say duplicate:
> 
> 	struct delayed_work dwork;      /* work item used for writeback */
> 
> in struct bdi_writeback. Again, the number of dworks should be configurable
> when creating bdi for the filesystem. 

Right - this is what I described early on in the discussion as a
need for both scaling out across bdi contexts as well as scaling up
within a single bdi context.

That is, even within the context of a BDI writeback context per AG
in XFS, we can hav eneed for multiple IO submissions to be in flight
at once. e.g. one IO submission gets blocked doing allocation, but
there are a heap of pure overwrites queued up behind it. We can
submit the pure overwrites without getting blocked on the
allocation, but if we don't have IO submission concurrency within a
BDI, we cannot do that at all.

IOWs, these aren't exclusive optimisations to writeback; there are
situations were only one of the two mechanisms can solve the
concurrency problem. i.e. we need both high level and low level
concurrency mechanisms in filesystems like XFS....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

