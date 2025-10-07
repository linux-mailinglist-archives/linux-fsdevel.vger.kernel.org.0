Return-Path: <linux-fsdevel+bounces-63519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE66BBFDC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 02:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2190F34C36B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 00:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B51C7012;
	Tue,  7 Oct 2025 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GxSj/ERJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041E34BA50
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797706; cv=none; b=cq8+ZjVa9JKK9HEAQJndFt06MZutjbZTS9qQ7Z/fKe/JIQm3lBKc82IdQ8jRpq4hmXHvacuJ88Nu6+wWIoR+/3hPI2vtDg3TODYEXEdKGGO7mnEVIs2MIKI2026XkFk+XkJk4ObL6245sfVcmMwqXIzOe6nd+jTMpzXfcQ3t9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797706; c=relaxed/simple;
	bh=d7FaHFc9dF0Xg5WRzkDx3qfyLmopyEqIkYcpNS8QRqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6nk21fZ3MKY0lSXsiqZ5I/I7laDrx5j09JOOGyBQVzMJj1HAkK3u/F6QJyk3Nd5UZjFWDBVvu4HfSLW9JMvkcVpGLFQJJR/7hlT5S+DP66lFGSDj4Q6/0DbghjyasO6cApiMaOaR4NNA7VxqZdnsoIsGjeHhnkOjalPNhAP1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GxSj/ERJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso3253751a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 17:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1759797703; x=1760402503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfHJDBFM16OXhnxnR4BrEwHtDm+npyaMiUzi5Qz31wo=;
        b=GxSj/ERJ1OriAfCjwhDjXvnbJ9hOdatRyaVW0L78UmHxPVWc2conJj7tlCKWa+WPrR
         +VRAfMTD4yUugvlq6KYLqIOKJcnDA7aSmFjp98pABniUCCnt5wAdOGcyIeGdLKfkkvbv
         XK6u+QATpBPss1m0rIGQX5TNO1zAmXjx9BHKPQ4dS610A/4WKUxLWs1YqI41Y3sqvPVv
         Gaz+Z2go97qgEodga93mIo0hD1eRMRgtOxswPXsd191iP7V1ANGYjPFUf7VR/k8ZUNaf
         tWkeatdtrkp2Ym/44eoI/1j3V0k/b3+sK/V1VyrndTAFnFspquOZJU2RRk4+CyVDxL+D
         msnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759797703; x=1760402503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfHJDBFM16OXhnxnR4BrEwHtDm+npyaMiUzi5Qz31wo=;
        b=f1DdAxVOPIT1wj6gDaqRh1s1TZunNLX+qbqqOAjT0bAsYoRlT2C6XMfooAzZhYJ3+8
         X9eyvWAO4/6DaC53WkgU14o1bPnziNJkpzpysiHS+aBxJkSapR+U0sUCOqwxcPOc+MPZ
         SaMzWGKBNobj7QMsmw9ZzfysI/bnHHd4ilAoUMq5OY2W36DpRnXYhyThsQO45DpBkG5a
         DB5ie8VA6eC96k2clUaKv2OIPZJIFACWqMPmnOaYe3vfhnoX5m3DUwRuvuk94hvmOv9g
         KQNZjYS1qTC6wD5PZqD/gl6IYFAnR6rUPRt3yLN97WIy6wfUebe2NnjjZIEIMqbdfYfS
         bwqw==
X-Forwarded-Encrypted: i=1; AJvYcCWV48qGCFxuD4cOeXVFmMT3UVs/mJhCvsTJtLqA+sUrxiYV8EixqYId75xARLsxq25zBWC8ZyYi+W7C6X5X@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDY8tE+l4ctSexL3SW/YHaLerbldAcXEXxauSSnz6ukeuk7Ml
	m/35ZSMEGPImgYRygqCWiCZ2ALM1pLpuaIF6R93Myrlw9W8uz1w9RyadU72fQPOGdTo=
X-Gm-Gg: ASbGncu8RK/GfHuN7RT8E5StZdLGsDEwcDrWcbgR1Llrj211CMhFICJPCRcuS3DQ+AT
	VE6E4EgC9j+fCQBhG+jFSpUarRSmIsD9rHcVA0eAz12iNCSHYnWjR+WolIqFK8MGmiSywLB7oul
	uaaUZ9/RRQFAIxDyXVKKKrLV1gdo89a/e698SOnZHogSEPB+vsbh70B1bipvYwnIv5pq527Icta
	4AJmsGjq76wPoKGVT9g+PiqppOxn9zmVLd6gdGrQAwlx/JP3jNOiJeSchWdrbQlicWs4dx2XI4b
	6NL/2YsgulGFf9TXAT7BnHCtX5s3SO/nwegugl2h7WGd/bmbaC12qsaR2XqzLw9klf/GJEKMb1L
	Hez1ouO62Yee+OUnOYHrqgTjD2swjlua8lSqs7KogXGoLEXQQ+nzmxii2j8YjSB3YoWBHaD/NM7
	aegPlD9CNzjiDqkAmk8Rt2wQ==
X-Google-Smtp-Source: AGHT+IFzHhtXCD2skH+tWaB8BGegnWhznjZj3Bc5XPaIgwMcr+0hlMXtbXQAuSTYsvHabZ4Yhwl6kQ==
X-Received: by 2002:a17:903:2b0f:b0:28e:7f4e:d694 with SMTP id d9443c01a7336-28e9a61a8cfmr200799645ad.28.1759797703175;
        Mon, 06 Oct 2025 17:41:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d2278sm145088885ad.92.2025.10.06.17.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 17:41:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v5vlr-0000000BU30-2SkC;
	Tue, 07 Oct 2025 11:41:39 +1100
Date: Tue, 7 Oct 2025 11:41:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Defer evicting inodes to a workqueue
Message-ID: <aORhw7xJXi5EgORC@dread.disaster.area>
References: <20250924091000.2987157-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924091000.2987157-1-willy@infradead.org>

[sorry I'm late on this, been working on other things]

On Wed, Sep 24, 2025 at 10:09:55AM +0100, Matthew Wilcox (Oracle) wrote:
> Evicting an inode is a complex process which may require allocating
> memory, running a transaction, etc, etc.  Doing it as part of reclaim
> is a bad idea and leads to hard-to-reproduce bug reports.  This pair of
> patches defers it to a workqueue if we're in reclaim.
> 
> Bugs:
> https://lore.kernel.org/all/CALm_T+3j+dyK02UgPiv9z0f1oj-HM63oxhsB0JF9gVAjeVfm1Q@mail.gmail.com/
> https://lore.kernel.org/all/CALm_T+2cEDUJvjh6Lv+6Mg9QJxGBVAHu-CY+okQgh-emWa7-1A@mail.gmail.com/
> https://lore.kernel.org/all/20250326105914.3803197-1-matt@readmodwrite.com/

So eviction running filesystem shrinkers that then do blocking IO,
folio operations and/or memory allocation and triggering warnings?

Seems like a problem GFP_NOFS was invented to solve, yes?

> I don't know if this is a good idea, to be honest.  We're kind of lying
> to reclaim by pretending that we've freed N inodes when actually we've
> just queued them for eviction.  On the other hand, XFS has been doing
> it for years, so perhaps it's not important.

tl;dr: we aren't lying, but because most people don't understand how
shrinker-based reclaim work is accounted for it can appear that way.

Long story:

memory relcaim (vmscan.c) does not track reclaim progress via the
number of objects the shrinkers report as freed. It tracks reclaim
progress via the amount of memory freed by the shrinker task. This
is what mm_account_reclaimed_pages() does, and it is implicit in
freeing operations as it is called from the slab code when it frees
the backing memory for a slab cache.

For other shrinkers that manually free memory, they have direct
calls to this function to record memory freeing. e.g. in the XFS
buffer cache when the shrinker disposes of a buffer and calls
xfs_buf_free().

This is a completely separate mechanism to the shrinker work
equalisation mechanism that uses object counts to apply the same
pressure to all shrinkable caches in the system. The shrinkers need
to scan a specific number of objects, and return a count based on
the progress they made. This returned count is ignored by the memory
reclaim code, it is only used as measure of progress being made
in certain siutations (e.g. drop_caches) and so is meaningless in
the course of this discussion.

IOWs, all the shrinker has to do is scan that number of objects for
freeing. It does not have to free them, nor does the returned
"objects freed" imply that any memory was actually freed.

Indeed, the VFS does lazy LRU removal, so it's common for the inode
cache shrinker to remove referenced objects from the LRU and not
free them. In that case, the reclaimable object count goes down, but
the freed count does not go up. The cache got "smaller", but we
didn't free anything. This is perfectly fine.

Indeed, in the case of the superblock shrinker, the "freed" count
tracks how many objects had their VFS lifecycle terminated (e.g.
indoes that were evicted), but this does not imply that the objects
were actually freed. They are simply no longer tracked as freeable
cached objects by the VFS caches.

Why is this distinction important? Remember what I said above about
mm_account_reclaimed_pages() accounting actually freed memory? Now
consider that dentries and inodes are RCU freed.

What does that imply about the superblock shrinker actually freeing
memory?

What this means is that the superblock shrinker -never- frees inodes
or dentry objects directly. The memory being freed is -never-
accounted to the shrinker, because the shrinker task has to schedule
before an RCU grace period can expire and run the RCU callbacks to
free the objects.

IOWs, shrinkers are intended to terminate the life cycle of cached
objects, but the life cycle of the allocated object can (and does)
extend beyond the shrinker that terminates the life cycle.

In the case of XFS, the VFS inode is embedded in the XFS inode, and
the VFS lifecycle is a subset of the XFS inode lifecycle. When
the VFS inode is evicted, it's lifecycle is terminated, but it still
a valid, tracked object at the XFS level. Indeed, XFs puts clean
inodes straight back on the internal reclaim list and accounts for
it as reclaimable. So the number of objects the superblock shrinker
is tracking does not actually go down - it is now tracked via the
sb->s_op->nr_cached_objects(sb, sc) callouts in the superblock
shrinker as a reclaimable object.

If the inode needs eviction work, (i.e. inodegc) it doesn't
immediately get re-accounted as a reclaimable object. We do the
work, then once the inode is in a reclaimable state, we put it on
the reclaim queue and account for it at that point.

Put simply: XFS is not "lying" about anything to the
mm/reclaim/shrinker subystems. We are simply taking advantage of the
fact that the superblock shrinker always frees the VFS inodes
asynchronously via RCU. Hence there is always a disconnect between
between VFS object life cycle termination and the object being
freed. XFS inserts it's own "disconnection processing" into that
gap, and actually lets the superblock shrinker track those objects.

> I think the real solution here is to convert the Linux VFS to use the
> same inode lifecycle as IRIX,

This has nothing to do with Irix. I introduced background inode
freeing to XFS in 2011 to avoid the problems of having to wait for
the inode to be fully clean in evict() context. This introduced some
other issues that I solved in ~2020 with non-blocking inode reclaim
processing. And in 2021, we finally moved all the transactional
modifications out of the evict() path with the background inodegc
infrastructure I wrote.

All of this is possible because shrinkers are simply a mechanism for
terminating the life cycle of a given object and there is absolutely
no requirement for life cycle termination to free any memory.
Indeed, they may release references to other resources that pin
memory (e.g. dentries pin inodes) and so memory being freed might
actually be several steps removed...

> but I don't fully understand the downsides
> of that approach.  One major pro of course is that XFS wouldn't have to
> work around the Linux VFS any more.

Not true - this stuff is way, way more complex than you imply.

On of the key factors in Josef's active/passive inode reference
infrastructure is that it could allow us to bring the "unreferenced"
part of the XFS inode lifecycle (i.e. everything that happens after
eviction) up into the VFS via passive VFS inode object references.

And at that point, could bring VFS active reference eviction
processing up into the VFS as an async deferal mechanism. But it
would also require us to bring the XFS inode cache VFS inode
recycling code as we could now get cache hits on a passively
referenced VFS inode which then needs the active VFS inodes state
reinstantiated.

There's other interactions as we'd need to lift as well, because
experience has proven that pushing eviction off to a workqueue will
create performance regressions.  e.g. Try pushing hundreds of
thousands of inodes a second across dozens of CPUs through a single
workqueue (e.g. highly concurrent find across dozens of directories
under memory pressure).

Then we have to throttle the number of inodes you defer for
eviction. Once you have many thousands deferred, it can take a long
time for the workqueue to catch up, especially if each inode has to
free many, many extents. Unbounded queues are bad, especially when
each unit of queued work can largely be unbounded, too. (e.g.
eviction processing after an unlink of a file with tens of millions
of extents).

IOWs, there's a reason the XFS inodegc queuing is complex - it uses
bound depth per-cpu lockless lists and workqueues for the eviction
processing deferral queue. Avoiding performance impacts due to adding
two context switches to every inode eviction is not simple.

Async inode eviction also has interactions with freeze - what
happens when you have dirty inodes or inodes that require dirtying
to evict queued for eviction and then the fs is frozen? We can't
process those evictions whilst the fs is frozen - we can't modify
anything. Hence there is the possibility that every eviction worker
task can get stuck waiting for thaw, and now inode cache reclaim is
effectively stuck until a thaw occurs....

There is also user visible interactions with space usage (e.g. df vs
rm). Half of the unlink work is done on eviction (i.e. when the last
ref is dropped) and so space isn't freed until eviction processing
is complete. Hence if you run a large rm -rf, it queues all the
inode and extent freeing work to the background queues. From the
user perspective, when the rm -rf completes the directory structure
is gone, but the space hasn't been completely freed yet. It may take
minutes for the space to be freed.

So, yeah, async inode eviction is anything but simple, and from
previous attempts to lift this stuff out of XFS to the VFS, I came
to the conclusion the only way to do it sanely was to convert the
VFS inodes to use active/passive reference counting so that the VFS
could guarantee that the inode was truly unreferenced by the VFS
before cache eviction occurs....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com

