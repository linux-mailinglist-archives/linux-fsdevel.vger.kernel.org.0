Return-Path: <linux-fsdevel+bounces-45651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90157A7A546
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125AF188AC17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7256524EF80;
	Thu,  3 Apr 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EdhPOjru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C324EF65
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690833; cv=none; b=VQVX82n+ehckD/rssfKPpg5akox0BuIeD8ruUa3vKTR0rvcH+d+LtTAh4fvO+zofMdjJLg/BPVjQEV8Qo1Gfu94ks2QcO6iHsyFT/vKDWR+GvOUJvPyfLHC8DTNwYXWt432p6/0QU85GAV2+5i1YDCIoBdQNyGAFUqLYIaQIOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690833; c=relaxed/simple;
	bh=2TDuYkbffUtZNscUeDutELeW6f7LQjrZgxY+nNhgpLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBRmdOOwr9ruFtsxUTfmnDc8I/P5p8KerbUpngQQvVKVmH+nVmlIh9RSL128H9DdstCyqCo0uKWcDmWvkZ7SDpJrTSkfDfaPpP1UJG/23HKuxgXQ7+57KQgN0E5nPr1u/gXp7/OJZewNwyqCJIzna04M4RrfVOrGApNd907EzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EdhPOjru; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c266c1389so689893f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743690830; x=1744295630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aVBsZKIQ13uHowU1y9quubDy59z6xGT4gKGYHYzC0SY=;
        b=EdhPOjruny9SF+Om2FL286F5rm+MuPsGFewvXHKsr+8Q/rSyyyvMMTuT8Sc1kmfwNA
         k5toU9M/MSyC2+aQrRAXqjOMwyg+iE4H/ulY6fuYFgYBOzkZclvolGeFzXKjJcYkOZHO
         ypdUolKtJHegE8S4JsZ6AvgAWRDQhDniX958Kb+ZkSQCyMI+o5oZ3PzVkv5bmEPvfDzS
         sGCzW+WRF1xSbUr+u2S9IAWLw5+XHltx1nzdPx6J+bV1Jsykv77CXnWOsKt33wYji45s
         t2Br/yaBTHrybbBkpCGlsFka3kQrFj3nIASIorLUas6Ez0Yw2vebtf411e6Pdk+bKGFn
         ecUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690830; x=1744295630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVBsZKIQ13uHowU1y9quubDy59z6xGT4gKGYHYzC0SY=;
        b=QTZAuAGgGHwENtgzShzZbzWGexTVH8yw106+T49AO+RLGopW7svH5WoEb5ZJnaMimo
         7+CACFcei1fq4gJM1Z38d9Kj47S2rZZcEMlkFxK9/Y5Xaof4ujDzBdZcDvgnemLlHGJd
         r1nyWawXrCnqoSgmh1Wx2BGpk1ie+65+RLrRgmeOVxw58JrwUtYdc7P8iyazgmyaW1qD
         3EYSDYzYde8gvc2vKGmy/2GDZU8Tfh+Hd3cmohJNexJCfM4deOCWf69DO1GKDmq0hqjW
         m7gO0EOgivdoV3e6u/YMLpw97Z99Qy00OkUybXLdOBx+ZCPu0Z9sA19+UFrhlK/f/4vU
         4BHw==
X-Forwarded-Encrypted: i=1; AJvYcCVvvK3NrNiymKQdQLC/Dsy3ZR6Fk2atbO0np7zYVLkpBC1FyCPUAKS+9nuJ4vKrmyZTrFgkcxEmiUw35+gQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzjqAukopfxHswdcx/+hj8WKOfhE3DwOWUqEMxehBMKmrhZ0Qu0
	/yx4Dh6QPO2imYauYWbJve17732CV3IbDXoQoTfuG4N/4jUd+uO70/asZInElgA=
X-Gm-Gg: ASbGnctSdiEr6KcWt0JIDDI8AFnxqQNlUcNwxge9Wazgh6QkP/bJoriLzgSnglKyVmm
	fuCefQvtqUUWCgidTixea+pNYNWI1y1kXupwJkzAe4LifTeHfvslFf1Y7j4FuH07F9GGKJ6h3HK
	1Wp50Dz4A6P7xCO+0TKk5oD2IlHGHrwbNUWq8EFhGlgPMyZqdIDHy/h7c/tAmeEJt0l2n6pqQv/
	2APdolM9g9Ry6OhZ7FMVVNNRc9BDfgC26PTZcHtvFLhajIDGH/tqnOXzEktNRnbiyZI3Mn8zg98
	dPAFnIBzh7BKR2tWnpGdqjAqORuQ/fiG8ACxWtsYaJcRkCOkQwCHmPc=
X-Google-Smtp-Source: AGHT+IEGiE0x1PAaWMGoC9ZFiaYEPiaIq/uegZ4wpDRjLqos6a0KnKZou0W0iioyFZ8bH2QBAeGB+w==
X-Received: by 2002:a05:6000:2407:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39c142432d7mr17623759f8f.2.1743690829940;
        Thu, 03 Apr 2025 07:33:49 -0700 (PDT)
Received: from localhost (109-81-82-69.rct.o2.cz. [109.81.82.69])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c30096b9csm1987759f8f.13.2025.04.03.07.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:33:49 -0700 (PDT)
Date: Thu, 3 Apr 2025 16:33:47 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matt Fleming <matt@readmodwrite.com>, willy@infradead.org,
	adilger.kernel@dilger.ca, akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	luka.2016.cs@gmail.com, tytso@mit.edu,
	Barry Song <baohua@kernel.org>, kernel-team@cloudflare.com,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux
 kernel v6.13-rc5
Message-ID: <Z-6cS9Cg1eN0w6XL@tiehlicka>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
 <20250326105914.3803197-1-matt@readmodwrite.com>
 <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>
 <a751498e-0bde-4114-a9f3-9d3c755d8835@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a751498e-0bde-4114-a9f3-9d3c755d8835@suse.cz>

On Thu 03-04-25 14:58:25, Vlastimil Babka wrote:
> On 4/3/25 14:29, Matt Fleming wrote:
> > On Wed, Mar 26, 2025 at 10:59 AM Matt Fleming <matt@readmodwrite.com> wrote:
> >>
> >> Hi there,
> 
> + Cc also Michal
> 
> >> I'm also seeing this PF_MEMALLOC WARN triggered from kswapd in 6.12.19.
> 
> We're talking about __alloc_pages_slowpath() doing WARN_ON_ONCE(current-
> >flags & PF_MEMALLOC); for __GFP_NOFAIL allocations.
> 
> kswapd() sets:
> 
> tsk->flags |= PF_MEMALLOC | PF_KSWAPD;
> 
> so any __GFP_NOFAIL allocation done in the kswapd context risks this
> warning. It's also objectively bad IMHO because for direct reclaim we can
> loop and hope kswapd rescues us, but kswapd would then have to rely on
> direct reclaimers to get unstuck. I don't see an easy generic solution?

Right. I do not think NOFAIL request from the reclaim context is really
something we can commit to support. This really needs to be addressed on
the shrinker side.

> >> Does overlayfs need some kind of background inode reclaim support?
> > 
> > Hey everyone, I know there was some off-list discussion last week at
> > LSFMM, but I don't think a definite solution has been proposed for the
> > below stacktrace.
> > 
> > What is the shrinker API policy wrt memory allocation and I/O? Should
> > overlayfs do something more like XFS and background reclaim to avoid
> > GFP_NOFAIL
> > allocations when kswapd is shrinking caches?
> > 
> >>   Call Trace:
> >>    <TASK>
> >>    __alloc_pages_noprof+0x31c/0x330
> >>    alloc_pages_mpol_noprof+0xe3/0x1d0
> >>    folio_alloc_noprof+0x5b/0xa0
> >>    __filemap_get_folio+0x1f3/0x380
> >>    __getblk_slow+0xa3/0x1e0
> >>    __ext4_get_inode_loc+0x121/0x4b0
> >>    ext4_get_inode_loc+0x40/0xa0
> >>    ext4_reserve_inode_write+0x39/0xc0
> >>    __ext4_mark_inode_dirty+0x5b/0x220
> >>    ext4_evict_inode+0x26d/0x690
> >>    evict+0x112/0x2a0
> >>    __dentry_kill+0x71/0x180
> >>    dput+0xeb/0x1b0
> >>    ovl_stack_put+0x2e/0x50 [overlay]
> >>    ovl_destroy_inode+0x3a/0x60 [overlay]
> >>    destroy_inode+0x3b/0x70
> >>    __dentry_kill+0x71/0x180
> >>    shrink_dentry_list+0x6b/0xe0
> >>    prune_dcache_sb+0x56/0x80
> >>    super_cache_scan+0x12c/0x1e0
> >>    do_shrink_slab+0x13b/0x350
> >>    shrink_slab+0x278/0x3a0
> >>    shrink_node+0x328/0x880
> >>    balance_pgdat+0x36d/0x740
> >>    kswapd+0x1f0/0x380
> >>    kthread+0xd2/0x100
> >>    ret_from_fork+0x34/0x50
> >>    ret_from_fork_asm+0x1a/0x30
> >>    </TASK>
> > 

-- 
Michal Hocko
SUSE Labs

