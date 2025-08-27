Return-Path: <linux-fsdevel+bounces-59406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AABD4B38796
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01FB188CDC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB43D321F48;
	Wed, 27 Aug 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="QJxiFjho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623823C4F1
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311263; cv=none; b=hprRHBnHdaWbIldNc6UlcrENhBZXPGoQek+8B+/6r0dYifiDogHO+KbPUGzlLCSdyZfTKIcJcK3d2686P+Bl5tvoFEUg/rOhRRWFON3dTodOe9gMLYGzx+UOUPj5p5Fwp1wVCVgHOIvpyqSaMaEhMFjrEQcHcj44WDeFCtHepF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311263; c=relaxed/simple;
	bh=Gx7xU0EwwmpQsQeC++G48wZoJ0PFQt/ki3BvUcTHe2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoW6pNYLWE9wzDjL+voAnZEo/24jfINBOmona9NcFG/eFogJMGcbCQt4lOIB0gWPP1FzjmHlvs4jXPAU5ZbKmgwRK+lGGt249vxs1hdMIEhu4DoQ/GatA1tmTAWQlf8JoHue04VSsJ5brGFz3yz+JmbB3tEXi8SXn+7ns2PQqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=QJxiFjho; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f7a6baf794so12855285a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756311260; x=1756916060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oeqKXGh2k/fvZbtY7nlqP034nNJp6LLlTEXlFIX7b9M=;
        b=QJxiFjhoPgl9mUkHdMrZOQo8gf9OYKwEJxVqxA00KzULwIe8eIkaqvIS1TV6cU7/bO
         IUx3RxTGNPsnkxASRD03EBy4xEWHfh6OB2EJU6PA/r0Y7g5Utgw+aFUOUdyVvS6CBHge
         Y88LWr+sTyghogwTy+TcQQZ4WuhZLP8ARb7lKBBqGXlKFORVS+NMi5MkOKD4Vcc65J9R
         ziAgqfHmuwZpY/S6sI5pWG7QqWLeoQL8d9daog0i12s0omMHREFzS4Ef0YjRunO3nvJ4
         Mb3lsB0Kr07B2+iHaqPngJHLRJtjvpaxw9IBgs+qBjOztlHh3Syv9aAilqAI44sFZgLW
         jdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756311260; x=1756916060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeqKXGh2k/fvZbtY7nlqP034nNJp6LLlTEXlFIX7b9M=;
        b=Jl5AWUXK7cm17B2WVcvYremF4bHCR12k34FsSZTC0DMqykErbXuySwsnYDO5AbarA5
         hc65XOKvG+4QHmVPTBNOOndAIs4035yTfmjmz6EIf6iQKD62m+o90XDbPI3aR9vfuRFd
         UG+01f9xxVhXDipg7lVCjObnQibhsQZ/8k8VwoaxZwJaIhDZy0iKvj4JPDTQv37+i8JE
         HSz2zmWOoY+nX+3Ek4LlF1iqL80q5YN4cj79+oNIFHSHGhIEMO6a2dTPoK81Ka2SqcOn
         Jd9xZBLN5vfKZHZnO+wQ9MWJQWLK6woAVU4gov1I+Ejz4L5pCMLnW9kdtP7633mpMOVB
         0aYw==
X-Gm-Message-State: AOJu0YzjjfNWw6cObm6+QlEHkgRhhx2lEjxOA+h97OgR20YX5Rm+wEy+
	ppEXcX85GqK4eMKljT9JSvPFRks5LmR7wNztw95UpUGBOhE00UXxkWFJpbZJ8sJc3OfnmP3SGqB
	Qtny7
X-Gm-Gg: ASbGncsh5jZRMFEIzmc7sAiv0z3MzHgpy6258elQ6hPrEl7zRRYoBKB2rclo7oGKmR7
	dWLfmZ/Q/tRkBmsKacZRbOr/QhOoNV8d2gk/JofuxMICpHHoI74e9EDZ51Ks79Hho/ovyEht7xE
	z0Dhlbj/gIqrUJUsPvJa6DhpFJ9RlcilO9x7RXP9mCbnsPxaVF92epOdis6iIx2D0Qa0JNQeJLr
	1viXjpC0YBT/VpYdvxCovY/XBq9A/BF5GBMOLc+BeOIzoYSrP8KpUSxZ+4QcaYngBnRSSxi9ztp
	OOKp1sRTNyddmAz4+ToACB/P6kNyy4jQLAZXq4GnbTuS7Knqxm4V1LLtdUKuWyZ7qVyXNk7ooc+
	OEk/7/uWuP/h4tIB1euXFwnmzQW1MFOWmNptEZD4FN+01PWuX9QVVtF5hxOG0Hmj8Nmd1cg==
X-Google-Smtp-Source: AGHT+IHS9aTsbVkGsXkV8bfMPkBsYYqHVpKIqvIIEtcl6YxbxzkP6i6xFIvHd3ui1H2CD+Mz60vqoQ==
X-Received: by 2002:a05:690c:6702:b0:721:370e:2756 with SMTP id 00721157ae682-721370e2aafmr64643697b3.45.1756310877727;
        Wed, 27 Aug 2025 09:07:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b1b7dsm31881287b3.62.2025.08.27.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:07:56 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:07:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	amir73il@gmail.com
Subject: Re: [PATCH v2 15/54] fs: maintain a list of pinned inodes
Message-ID: <20250827160756.GA2272053@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <35dc849a851470e2a31375ecdfdf70424844c871.1756222465.git.josef@toxicpanda.com>
 <20250827-gelandet-heizt-1f250f77bfc8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-gelandet-heizt-1f250f77bfc8@brauner>

On Wed, Aug 27, 2025 at 05:20:17PM +0200, Christian Brauner wrote:
> On Tue, Aug 26, 2025 at 11:39:15AM -0400, Josef Bacik wrote:
> > Currently we have relied on dirty inodes and inodes with cache on them
> > to simply be left hanging around on the system outside of an LRU. The
> > only way to make sure these inodes are eventually reclaimed is because
> > dirty writeback will grab a reference on the inode and then iput it when
> > it's done, potentially getting it on the LRU. For the cached case the
> > page cache deletion path will call inode_add_lru when the inode no
> > longer has cached pages in order to make sure the inode object can be
> > freed eventually.  In the unmount case we walk all inodes and free them
> > so this all works out fine.
> > 
> > But we want to eliminate 0 i_count objects as a concept, so we need a
> > mechanism to hold a reference on these pinned inodes. To that end, add a
> > list to the super block that contains any inodes that are cached for one
> > reason or another.
> > 
> > When we call inode_add_lru(), if the inode falls into one of these
> > categories, we will add it to the cached inode list and hold an
> > i_obj_count reference.  If the inode does not fall into one of these
> > categories it will be moved to the normal LRU, which is already holds an
> > i_obj_count reference.
> > 
> > The dirty case we will delete it from the LRU if it is on one, and then
> > the iput after the writeout will make sure it's placed onto the correct
> > list at that point.
> > 
> > The page cache case will migrate it when it calls inode_add_lru() when
> > deleting pages from the page cache.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> 
> Ok, I'm trying to wrap my head around the justification for this new
> list. Currently we have inodes with a zero reference counts that aren't
> on any LRU. They just appear on sb->i_sb_list and are e.g., dealt with
> during umount (sync_filesystem() followed by evict_inodes()).
> 
> So they're either dealt with by writeback or by the page cache and are
> eventually put on the regular LRU or the filesystem shuts down before
> that happens.
> 
> They're easy to handle and recognize because their inode->i_count is
> zero.
> 
> Now you make the LRUs hold a full reference so it can be grabbed from
> the LRU again avoiding the zombie resurrection from zero. So to
> recognize inodes that are pinned internally due to being dirty or having
> pagecache pages attached to it you need to track them in a new list
> otherwise you can't really differentiate them and when to move them onto
> the LRU after writeback and pagecache is done with them.
> 

Exactly. We need to put them somewhere so we can account for their reference.

We could technically just use a flag and not have a list for this, and just use
the flag to indicate that the inode is pinned and the flag has a full reference
associated with it.

I did it this way because if I had a nickel for every time I needed to figure
out where a zombie inode was and had to do the most grotesque drgn magic to find
it, I'd have like 15 cents, which isn't a lot but weird that it's happened 3
times. Having a list makes it easier from a debugging perspective.

But again, we have ->s_inodes, and I can just scan that list and look for
I_LRU_CACHED. We'd still need to hold a full reference for that, but it would
eliminate the need for another list if that's more preferable?  Thanks,

Josef

