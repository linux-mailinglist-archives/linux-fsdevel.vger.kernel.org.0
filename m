Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F82DC850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 22:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgLPV1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 16:27:35 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:43700 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgLPV1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 16:27:35 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 66BF9D7FD6B;
        Thu, 17 Dec 2020 08:26:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kpeJs-004h5o-Hy; Thu, 17 Dec 2020 08:26:48 +1100
Date:   Thu, 17 Dec 2020 08:26:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com, hch@lst.de,
        song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [RFC PATCH v3 4/9] mm, fsdax: Refactor memory-failure handler
 for dax mapping
Message-ID: <20201216212648.GN632069@dread.disaster.area>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-5-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215121414.253660-5-ruansy.fnst@cn.fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=omOdbC7AAAAA:8 a=7-415B0cAAAA:8
        a=eyTjK9YyoW615e0u8fsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:14:09PM +0800, Shiyang Ruan wrote:
> The current memory_failure_dev_pagemap() can only handle single-mapped
> dax page for fsdax mode.  The dax page could be mapped by multiple files
> and offsets if we let reflink feature & fsdax mode work together.  So,
> we refactor current implementation to support handle memory failure on
> each file and offset.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
.....
>  static const char *action_name[] = {
> @@ -1147,6 +1148,60 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>  	return 0;
>  }
>  
> +int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
> +{
> +	const bool unmap_success = true;
> +	unsigned long pfn, size = 0;
> +	struct to_kill *tk;
> +	LIST_HEAD(to_kill);
> +	int rc = -EBUSY;
> +	loff_t start;
> +	dax_entry_t cookie;
> +
> +	/*
> +	 * Prevent the inode from being freed while we are interrogating
> +	 * the address_space, typically this would be handled by
> +	 * lock_page(), but dax pages do not use the page lock. This
> +	 * also prevents changes to the mapping of this pfn until
> +	 * poison signaling is complete.
> +	 */
> +	cookie = dax_lock(mapping, index, &pfn);
> +	if (!cookie)
> +		goto unlock;

Why do we need to prevent the inode from going away here? This
function gets called by XFS after doing an xfs_iget() call to grab
the inode that owns the block. Hence the the inode (and the mapping)
are guaranteed to be referenced and can't go away. Hence for the
filesystem based callers, this whole "dax_lock()" thing can go away.

So, AFAICT, the dax_lock() stuff is only necessary when the
filesystem can't be used to resolve the owner of physical page that
went bad....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
