Return-Path: <linux-fsdevel+bounces-29926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC8983BE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 05:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D036B20E70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 03:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361BF2110E;
	Tue, 24 Sep 2024 03:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SkLab5xf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B581B85D6
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727150140; cv=none; b=X8LFznWiLOnLeMRNi9vrlgmCJEL6gE8PrVIjTnQsXT+Zqu41tA7hTQ5kE1bU5wE/YLDchxn6SNjXZ7MqS8KjAlJlyzfnGDv8HQtUbxspu3HtvJcskrw0mkf0BMfT8pcq7nLvFSCx/knjX8pTuC1u82ri1KK7QQjc18lactWAYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727150140; c=relaxed/simple;
	bh=2w85fNXehzBIpgPFlCIrmrS0fskKN19fBJc1YdCy0Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO65WGOCB6v1NqGXRB6MWM1CLyCd52Wz5xU6n/Cy8rDBTT1kmE+ZLUtBGQeYcdK29tBnAXHwA3FYW/bAkXlZykYG1kqBqAKV7TCs8n4HORCwcgnY7iw3MaUpAKZ2TtxKdZoCs6JUXEAy7lBlzYLJkUJL7U+ZuuyvY2cw84/79Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=SkLab5xf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so4032688a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 20:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727150138; x=1727754938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O54ZHg3JvB3+7GeDlyj5zl+vSZfugyDrKLyUq9j6AEQ=;
        b=SkLab5xfBl5v0tTIjX5lOtRxguVldIoxJr/FJzaDWtIz1T3BSKKW62vDF4S7piFq9+
         YF1eSPPCpBG6KxgB3OOOKKBxJ8jHZhJZyg/HP9XKatgJWSpoMRJhPfzzsuSACZzXUfj0
         rDN5Q2hB5FtQIycow+cezM4R4eq0HGI770DBphpQI4uiRg/xahbsW99iwW/ostsDHXjq
         jOTuA08NqZYnTPYds2PsGA2imYhvDcfRDa3skAfNe3Hti8ohwPnb31JLJPSyjZ8OmG83
         zEhcOArWS21RX/5GVzYhw8f9kmmi60w6r5JubyvFN3KgPqkPPIUBiGPeisQIFuTjLedL
         /inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727150138; x=1727754938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O54ZHg3JvB3+7GeDlyj5zl+vSZfugyDrKLyUq9j6AEQ=;
        b=O7G07yZOollBfTu4yyIRilr63JpkHLKyefqH1B0swxhmuejBojS4AiHuZeFfmubEQ9
         nbguJhYMKhLuDSuMLE0Wsx7RdwnKSB8MEpHULwjfydPrhRAnoNyIt2mhMVXshMbVgnPF
         k009YlH9k3NXanofocZvBeUfTQAxmLx2N3kcO46UDLcgxY7w6EMiDLsSikk/YuNr/ME4
         HS/gyqjz6AeyfUiDXphjmKHPalsGmr0RkldoxYeYYX7BNtCJq32HPyB6RmvGBMHAmKxO
         +bPBoIXIKY50vH+uxcOu+7SWMVMvzm9wf3+QiI/hBg6lhX2cgvqJsVdXU2dHYeA9Fiaq
         EFcw==
X-Forwarded-Encrypted: i=1; AJvYcCXf/xsJEYlbk03QOGq4F2lq9+i7mQAxiXvIFnHZtxyoFhPtoHaXDDViaC6vdWF4vtaApJhYWPW0sLHVwg60@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbwLQbEN7U2wq91muQ7s0GxPo6dbe1pULYRO0yypc3UbQiKt+
	AmfZD8KdfhiQDyy+A3z25WMoLpfMtO43t9hgyrns76LCrlJLDahhzZp5OtOwX7o=
X-Google-Smtp-Source: AGHT+IGtOlPZI7TtBV2nJJDzjtJQQ2PRG9hdBkwY0V9aZakdCFEJyEHibb4IjchJzHF7oDZoFxd+0g==
X-Received: by 2002:a17:90a:1202:b0:2dd:8097:3ced with SMTP id 98e67ed59e1d1-2dd80973cf0mr17110420a91.26.1727150138400;
        Mon, 23 Sep 2024 20:55:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058f0d5f2sm414545a91.15.2024.09.23.20.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 20:55:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ssweF-009GdZ-1d;
	Tue, 24 Sep 2024 13:55:35 +1000
Date: Tue, 24 Sep 2024 13:55:35 +1000
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <ZvI4N55fzO7kg0W/@dread.disaster.area>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>

On Mon, Sep 23, 2024 at 07:48:03PM -0700, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 19:26, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And I had missed the issue with PREEMPT_RT and the fact that right now
> > the inode hash lock is outside the inode lock, which is problematic.
> 
> .. although I guess that could be solved by just making the spinlock
> be external to the hash list, rather than part of the list like
> list_bh.

That's effectively what the patch did - it added a spinlock per hash
list.

> You wouldn't need to do one lock per list head, you could just do some
> grouping of the hash.

Yes, that's a more complex thing to do, though - it is effectively
using hashed locks for the hash table.

> That said, the vfs inode hash code really is pretty disgusting and has
> been accumulating these warts for a long time. So maybe a "filesystems
> do their own thing" together with some helper infrastructure (like
> using rhashtable) is actually the right thing to do.

Perhaps.

XFS has done it's own thing since 2007, but that was because the XFS
inode lifecycle has always existed outside the VFS inode life cycle.
i.e. the inode has to outlive evict() and ->destroy_inode because it
can still be dirty and tracked by the journal when the VFS evicts it
from the cache.

We also have internal inode lookup stuff that we don't want to go
anywhere near the VFS (e.g. inode writeback clustering from journal
item cleaning callbacks).

But this has come at a significant complexity cost, and some of the
biggest problems we've had to solve have been a result of this
architecture. e.g. memory reclaim getting blocked on dirty XFS
inodes that the VFS is unaware of via the fs specific callout in the
superblock shrinker caused all sorts of long tail memory allocation
latency issues for years. We've fixed that, but it took a long time
to work out how to avoid blocking in memory reclaim without driving
the system immediately into OOM kill frenzies....

There are also issues around RCU freeing of inodes and how the
filesysetm level cache handles that. e.g. what happens when the
filesystem doesn't immediately free the inode after memory reclaim
evicts it, but then the fs re-instantiates it moments later when a
new lookup for that inode comes in? The rest of the VFS assumes that
the inode won't reappear until a RCU grace period expires, but
having the re-instantiation code call synchronise_rcu() (or
something similar) is not an option because this sort of situation
can occur thousands of times a second under memory pressure....

We know this because there is an outstanding issue in XFS around
this situation - none of the general solutions to the problem
we've tried have been viable. I suspect that any other filesystem
that implements it's own inode cache and does VFS inode
re-instantiation on a inode cache hit will have similar issues,
and so there will be wider VFS architecture impacts as a result.

IOWs, it's not clear to me that this is a caching model we really
want to persue in general because of a) the code duplication and b)
the issues such an inode life-cycle model has interacting with the
VFS life-cycle expectations...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

