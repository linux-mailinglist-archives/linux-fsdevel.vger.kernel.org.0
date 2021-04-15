Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C213602C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 08:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhDOGzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 02:55:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhDOGzI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:55:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618469684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/VjSYO1zorqpOQ4YycM3fmnEbt1KvREwl3ylHFycHU=;
        b=g7/4fTEIxZhyajLVOgkJMP3lwGZMq9VRALcEHWWBXpLVvpeJUslhn+FtURU6S8+fjWcyp1
        w7Gkq5F2/9qtbghqXrsvKOxyn7JVDtY6nbMlr+Er+Kdq/HATCSRZOCzLtjLpcYLK9kB8Ok
        6r7bW/HMVTbK7lgjbIx2TmANl/W4L7E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D09BCAFF8;
        Thu, 15 Apr 2021 06:54:43 +0000 (UTC)
Date:   Thu, 15 Apr 2021 08:54:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <YHfjMyJuvXzJsg6T@dhcp22.suse.cz>
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
 <20210415052300.GA1662898@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415052300.GA1662898@in.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-04-21 10:53:00, Bharata B Rao wrote:
> On Wed, Apr 07, 2021 at 08:28:07AM +1000, Dave Chinner wrote:
> > 
> > Another approach may be to identify filesystem types that do not
> > need memcg awareness and feed that into alloc_super() to set/clear
> > the SHRINKER_MEMCG_AWARE flag. This could be based on fstype - most
> > virtual filesystems that expose system information do not really
> > need full memcg awareness because they are generally only visible to
> > a single memcg instance...
> 
> Would something like below be appropriate?

No. First of all you are defining yet another way to say
SHRINKER_MEMCG_AWARE which is messy. And secondly why would shmem, proc
and ramfs be any special and they would be ok to opt out? There is no
single word about that reasoning in your changelog.

> >From f314083ad69fde2a420a1b74febd6d3f7a25085f Mon Sep 17 00:00:00 2001
> From: Bharata B Rao <bharata@linux.ibm.com>
> Date: Wed, 14 Apr 2021 11:21:24 +0530
> Subject: [PATCH 1/1] fs: Let filesystems opt out of memcg awareness
> 
> All filesystem mounts by default are memcg aware and end hence
> end up creating shrinker list_lrus for all the memcgs. Due to
> the way the memcg_nr_cache_ids grow and the list_lru heads are
> allocated for all memcgs, huge amount of memory gets consumed
> by kmalloc-32 slab cache when running thousands of containers.
> 
> Improve this situation by allowing filesystems to opt out
> of memcg awareness. In this patch, tmpfs, proc and ramfs
> opt out of memcg awareness. This leads to considerable memory
> savings when running 10k containers.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> ---
>  fs/proc/root.c             |  1 +
>  fs/ramfs/inode.c           |  1 +
>  fs/super.c                 | 27 +++++++++++++++++++--------
>  include/linux/fs_context.h |  2 ++
>  mm/shmem.c                 |  1 +
>  5 files changed, 24 insertions(+), 8 deletions(-)

[...]
-- 
Michal Hocko
SUSE Labs
