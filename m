Return-Path: <linux-fsdevel+bounces-30021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035CD984F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 02:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829D51F24450
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC0DDA0;
	Wed, 25 Sep 2024 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ScGRUpX5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93AE947A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223472; cv=none; b=M15Lq9jp9tndUh8MS0UICi0xjEhrm5wlIgjz/JLmoefSOG+fpBeFnGLzND37df7f277kOPq+69EgLXOWe+napkYlgVyK1Qscw6EzEolx4a/OUZN+14+GqnRHSFTo0CavI6mp7i9Kkjyt7TKxLTpbuW+2R8GBwNG2YnJ80+V4tDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223472; c=relaxed/simple;
	bh=XjwV7ooouV4mXp4zpORY+QsAa1Fc9zhXXncoNiqLpRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHwTAxbjJJn3UPHhpGMgV7Ux9NMDvtg8jwmV35hR+KiwmBurMgRB8rDWedCkEcmmI28CyMoR4IqSNJ5d9L1cFDjyHI7x/FpQbOlxqhrRtGuzvGovQYepMCGcKkHnnHr9r7dM1yzLaEp4nzC7xr65Pk+qL1yl1W2EjzqqaKnX6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ScGRUpX5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20792913262so72951555ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 17:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727223470; x=1727828270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxBCf5uNQNAL3k3Wxpn0q6ae9NteRJmyEjICcWBnEX8=;
        b=ScGRUpX5pBE2+MCXfETE0Y26bpnqqn0amUvNiHlHZ5mgA3uOLeeblbW6IbTNZxwTwW
         7yhQb0LRRFsMnx58NicmyN39Q//+lHhLhR05PXIvwC6qOUxiSz18IAtixQkMbPlo/QuZ
         3ZXMkcyY26TsNkRm2w54sCK/VBM+ZA+OuNjoFt90+uEbfD5u9M3gWMhtaogh8+rdpBsh
         FJ3aNKzTRKfvo7HOec4ALwb1L9tNX5XGG420BWx3Vep3fiMkhBXaIWtWgM0f8U7Ex/mj
         n7gR+6HYwlzVhAOpbJlg/E/IbmDWKzmM6BshUPNJVNsxUufe65ekd9I0/9KQs19ZyNGA
         mtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727223470; x=1727828270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxBCf5uNQNAL3k3Wxpn0q6ae9NteRJmyEjICcWBnEX8=;
        b=mH+cCqByHqRVLKOv92ibC9B7FgZ5eTcpvLhBLGfb13yxwzI90m0OJ52cZ5l2IQOi+x
         dLCtnv53A4UeKBiO+EL1+BffIH0xLMiT7AXs8b9gXWS2ehHcbf4U17Odz4azt8y32PTi
         ZZ4B4tUUM2IOYZpYnt7gtZY9WWZoqrFdkhyAZ9v+7Wp69kx+J1lVbTxPVL5ZYBqlf636
         skHjNOOllbhlLF/D0QZK0w8T47AXl9KdRXB8HXLlVW7rlgZ/LWF+TqjDTc6G2HW1/ofA
         YNElfVvDVtAq0YP7NNU/GVMQHYVB3pFh9xEBMpTR3G2o4Uyogsl95tQJuyqZdL0N+e6g
         fSag==
X-Forwarded-Encrypted: i=1; AJvYcCU/sRFE93oKMP1DZbrtfV4HDvDnep7q/9tgT5t3uGY86OzDY/wJ6p9yZJT7dMGuJzZvHDIDY3hvqtb2obEY@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCA/Gj2h9+6UXfQbOe2BZ7Td+UTeZBj5MffGq5PtKVoA1lyQM
	YXJP7fsa4sri1Co86RQ8/vzMgKbQsCMT1IsLRidS+XWhG7GjXuwQc54igtwp9aI=
X-Google-Smtp-Source: AGHT+IHeVKhbsatOw7Qx2kKg+qV81P7Ump5pcTq+XicBjALOlKzXHaZhf4/0ryeV1aZtpLdVW+Bq1g==
X-Received: by 2002:a17:902:ce86:b0:205:5eaf:99e7 with SMTP id d9443c01a7336-20afc4c6c7emr12552095ad.38.1727223470033;
        Tue, 24 Sep 2024 17:17:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1720b00sm14779125ad.64.2024.09.24.17.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 17:17:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1stFj0-009di0-1N;
	Wed, 25 Sep 2024 10:17:46 +1000
Date: Wed, 25 Sep 2024 10:17:46 +1000
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <ZvNWqhnUgqk5BlS4@dread.disaster.area>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
 <ZvI4N55fzO7kg0W/@dread.disaster.area>
 <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>

On Tue, Sep 24, 2024 at 09:57:13AM -0700, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 20:55, Dave Chinner <david@fromorbit.com> wrote:
> >
> > That's effectively what the patch did - it added a spinlock per hash
> > list.
> 
> Yeah, no, I like your patches, they all seem to be doing sane things
> and improve the code.
> 
> The part I don't like is how the basic model that your patches improve
> seems quite a bit broken.
> 
> For example, that whole superblock list lock contention just makes me
> go "Christ, that's stupid". Not because your patches to fix it with
> Waiman's fancy list would be wrong or bad, but because the whole pain
> is self-inflicted garbage.

I'm not about to disagree with that assessment.

> And it's all historically very very understandable. It wasn't broken
> when it was written.
> 
> That singly linked list is 100% sane in the historical context of "we
> really don't want anything fancy for this". The whole list of inodes
> for a superblock is basically unimportant, and it's main use (only
> use?) is for the final "check that we don't have busy inodes at umount
> time, remove any pending stuff".
> 
> So using a stupid linked list was absolutely the right thing to do,
> but now that just the *locking* for that list is a pain, it turns out
> that we probably shouldn't use a list at all. Not because the list was
> wrong, but because a flat list is such a pain for locking, since
> there's no hierarchy to spread the locking out over.

Right, that's effectively what the dlist infrastructure has taught
us - we need some kind of heirarchy to spread the locking over. But
what that heirachy is for a "iterate every object" list looks like
isn't really clear cut...

Another option I'd considered was to offload the iteration to
filesystems that have internal tracking mechanisms. e.g. use a
superblock method (say ->for_all_cached_inodes()) that gets passed a
callback function for the operation to perform on a stabilised
inode.

This would work for XFS - we already have such an internal callback
based cache-walking infrastructure - xfs_iwalk() - that is used
extensively for internal admin, gc and scrub/repair functions.
If we could use this for VFS icache traversals, then
we wouldn't need to maintain the sb->s_inodes list at all in XFS.

But I didn't go down that route because I didn't think we wanted to
encourage each major filesysetm to have their own unique internal
inode caching implementations with there own special subtle
differences. The XFS icache code is pretty complex and really
requires a lot of XFS expertise to understand - that makes changing
global inode caching behaviour or life cycle semantics much more
difficult than it already is.

That said, if we do decide that a model where filesystems will
provide their own inode caches is acceptible, then as a first step
we could convert the generic s_inodes list iteration to the callback
model fairly easily....

> (We used to have that kind of "flat lock" for the dcache too, but
> "dcache_lock" went away many moons ago, and good riddance - but the
> only reason it could go away is that the dcache has a hierarchy, so
> that you can always lock just the local dentry (or the parent dentry)
> if you are just careful).

> 
> > [ filesystems doing their own optimized thing ]
> >
> > IOWs, it's not clear to me that this is a caching model we really
> > want to persue in general because of a) the code duplication and b)
> > the issues such an inode life-cycle model has interacting with the
> > VFS life-cycle expectations...
> 
> No, I'm sure you are right, and I'm just frustrated with this code
> that probably _should_ look a lot more like the dcache code, but
> doesn't.
> 
> I get the very strong feeling that we should have a per-superblock
> hash table that we could also traverse the entries of. That way the
> superblock inode list would get some structure (the hash buckets) that
> would allow the locking to be distributed (and we'd only need one lock
> and just share it between the "hash inode" and "add it to the
> superblock list").

The only problem with this is the size of the per-sb hash tables
needed for scalability - we can't allocate system sized hash tables
for every superblock just in case a superblock might be asked to
cache 100 million inodes. That's why Kent used rhashtables for the
bcachefs implementation - they resize according to how many objects
are being indexed, and hence scale both up and down.

That is also why XFS uses multiple radix trees per-sb in it's icache
implementation - they scale up efficiently, yet have a small
memory footprint when only a few inodes are in cache in a little
used filesystem.

> But that would require something much more involved than "improve the
> current code".

Yup.

FWIW, I think all this "how do we cache inodes better" discussion is
somehwat glossing over a more important question we need to think
about first: do we even need a fully fledged inode cache anymore?

Every inode brought into cache is pinned by a dentry. The dentry
cache has an LRU and cache aging, and so by the time a dentry is
aged out of the dentry cache and the inode is finally dropped, it
has not been in use for some time. It has aged out of the current
working set.

Given that we've already aged the inode out of the working set.  why
do we then need to dump the inode into another LRU and age that out
again before we reclaim the inode? What does this double caching
actually gaining us?

I've done experiments on XFS marking all inodes with I_DONT_CACHE,
which means it gets removed from the inode cache the moment the
reference count goes to zero (i.e. when the dentry is dropped from
cache). This leaves the inode life cycle mirroring the dentry
life-cycle. i.e. the inode is evicted when the dentry is aged out as
per normal.

On SSD based systems, I really don't see any performance degradation
for my typical workstation workloads like git tree operations and
kernel compiles. I don't see any noticable impact on streaming
inode/data workloads, either. IOWs, the dentry cache appears to be
handling the workings set maintenance duties pretty well for most
common workloads. Hence I question the need for LRU based inode
cache aging being needed at all.

So: should we be looking towards gutting the inode cache and so the
in-memory VFS inode lifecycle tracks actively referenced inodes? If
so, then the management of the VFS inodes becomes a lot simpler as
the LRU lock, maintenance and shrinker-based reclaim goes away
entirely. Lots of code gets simpler if we trim down the VFS inode
life cycle to remove the caching of unreferenced inodes...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

