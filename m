Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19C358FAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 00:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhDHWMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 18:12:12 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:58221 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232675AbhDHWMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:12:12 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 93C7665D21;
        Fri,  9 Apr 2021 08:11:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lUcsU-00GYk6-Mx; Fri, 09 Apr 2021 08:11:54 +1000
Date:   Fri, 9 Apr 2021 08:11:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Message-ID: <20210408221154.GL1990290@dread.disaster.area>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=SkwiGy6gHLKnJZ6Ta9EA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:46:11PM -0700, Daniel Xu wrote:
> This commit introduces the bpf page cache iterator. This iterator allows
> users to run a bpf prog against each page in the "page cache".
> Internally, the "page cache" is extremely tied to VFS superblock + inode
> combo. Because of this, iter_pagecache will only examine pages in the
> caller's mount namespace.

No, it does not just examine pages with in the callers mount
namespace, because ....

> +static struct inode *goto_next_inode(struct bpf_iter_seq_pagecache_info *info)
> +{
> +	struct inode *prev_inode = info->cur_inode;
> +	struct inode *inode;
> +
> +retry:
> +	BUG_ON(!info->cur_sb);
> +	spin_lock(&info->cur_sb->s_inode_list_lock);
> +
> +	if (!info->cur_inode) {
> +		list_for_each_entry(inode, &info->cur_sb->s_inodes, i_sb_list) {

... this is an "all inodes on the superblock" walk.  This will also
iterate inodes in other mount namespaces that point to the same
superblock.

IOWs, if you have different parts of the same filesystem mounted
into hundreds of container mount namespaces, this script will not
just iterate the local mount name space, it will iterate every inode
in every mount namespace.

And, of course, if the same files are mounted into multiple
containers (think read-only bind mounts using idmapping) then you
have zero indication of which container is actually using them, just
that there are hundreds of paths to the same inode. And every
container will appear to be using exactly the same amount of page cache.

IOWs, the stats this generates provide no insight into page cache
usage across mount namespaces in many situations, and it leaks
information about page cache usage across mount namespace
boundaries.

And that's before I say "iterating all inodes in a superblock is
bad" because it causes lock contention and interrupts normal usage.
We avoid s_inodes lists walks as much as we possibly can, and the
last thing we want is for userspace to be able to trivially
instigate long running walks of the s_inodes list. Remember, we can
have hundreds of millions of inodes on this list....

> +			spin_lock(&inode->i_lock);
> +			if (inode_unusual(inode)) {
> +				spin_unlock(&inode->i_lock);
> +				continue;
> +			}
> +			__iget(inode);
> +			spin_unlock(&inode->i_lock);

This can spin long enough to trigger livelock warnings. Even if it's
not held that long, it can cause unexpected long tail latencies in
memory reclaim and inode instantiation. Every s_inodes list walk has
cond_resched() built into it now....

> +	info->ns = current->nsproxy->mnt_ns;
> +	get_mnt_ns(info->ns);
> +	INIT_RADIX_TREE(&info->superblocks, GFP_KERNEL);
> +
> +	spin_lock(&info->ns->ns_lock);
> +	list_for_each_entry(mnt, &info->ns->list, mnt_list) {
> +		sb = mnt->mnt.mnt_sb;
> +
> +		/* The same mount may be mounted in multiple places */
> +		if (radix_tree_lookup(&info->superblocks, (unsigned long)sb))
> +			continue;
> +
> +		err = radix_tree_insert(&info->superblocks,
> +				        (unsigned long)sb, (void *)1);

And just because nobody has pointed it out yet: radix_tree_insert()
will do GFP_KERNEL memory allocations inside the spinlock being held
here.

----

You said that you didn't take the "walk the LRUs" approach because
walking superblocks "seemed simpler". It's not. Page cache residency
and accounting is managed by memcgs, not by mount namespaces.

That is, containers usually have a memcg associated with them to control
memory usage of the container. The page cache used by a container is
accounted directly to the memcg, and memory reclaim can find all the
file-backed page cache pages associated with a memcg very quickly
(via mem_cgroup_lruvec()).  This will find pages associated directly
with the memcg, so it gives you a fairly accurate picture of the
page cache usage within the container.

This has none of the issues that arise from "sb != mnt_ns" that
walking superblocks and inode lists have, and it doesn't require you
to play games with mounts, superblocks and inode references....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
