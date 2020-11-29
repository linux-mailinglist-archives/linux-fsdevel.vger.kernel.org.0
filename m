Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE32C7BC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 23:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgK2WsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Nov 2020 17:48:10 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43185 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbgK2WsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Nov 2020 17:48:10 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8DFEA58DF4D;
        Mon, 30 Nov 2020 09:47:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kjVTX-00GPKX-HI; Mon, 30 Nov 2020 09:47:23 +1100
Date:   Mon, 30 Nov 2020 09:47:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com, hch@lst.de,
        song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
Message-ID: <20201129224723.GG2842436@dread.disaster.area>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8
        a=fQ8chXSYUWhFZ-3vMtIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 08:41:10AM +0800, Shiyang Ruan wrote:
> This patchset is a try to resolve the problem of tracking shared page
> for fsdax.
> 
> Change from v1:
>   - Intorduce ->block_lost() for block device
>   - Support mapped device
>   - Add 'not available' warning for realtime device in XFS
>   - Rebased to v5.10-rc1
> 
> This patchset moves owner tracking from dax_assocaite_entry() to pmem
> device, by introducing an interface ->memory_failure() of struct
> pagemap.  The interface is called by memory_failure() in mm, and
> implemented by pmem device.  Then pmem device calls its ->block_lost()
> to find the filesystem which the damaged page located in, and call
> ->storage_lost() to track files or metadata assocaited with this page.
> Finally we are able to try to fix the damaged data in filesystem and do
> other necessary processing, such as killing processes who are using the
> files affected.
> 
> The call trace is like this:
>  memory_failure()
>    pgmap->ops->memory_failure()   => pmem_pgmap_memory_failure()
>     gendisk->fops->block_lost()   => pmem_block_lost() or
>                                          md_blk_block_lost()
>      sb->s_ops->storage_lost()    => xfs_fs_storage_lost()
>       xfs_rmap_query_range()
>        xfs_storage_lost_helper()
>         mf_recover_controller->recover_fn => \ 
>                             memory_failure_dev_pagemap_kill_procs()
> 
> The collect_procs() and kill_procs() are moved into a callback which
> is passed from memory_failure() to xfs_storage_lost_helper().  So we
> can call it when a file assocaited is found, instead of creating a
> file list and iterate it.
> 
> The fsdax & reflink support for XFS is not contained in this patchset.

This looks promising - the overall architecture is a lot more
generic and less dependent on knowing about memory, dax or memory
failures. A few comments that I think would further improve
understanding the patchset and the implementation:

- the order of the patches is inverted. It should start with a
  single patch introducing the mf_recover_controller structure for
  callbacks, then introduce pgmap->ops->memory_failure, then
  ->block_lost, then the pmem and md implementations of ->block
  list, then ->storage_lost and the XFS implementations of
  ->storage_lost.

- I think the names "block_lost" and "storage_lost" are misleading.
  It's more like a "media failure" or a general "data corruption"
  event at a specific physical location. The data may not be "lost"
  but only damaged, so we might be able to recover from it without
  "losing" anything. Hence I think they could be better named,
  perhaps just "->corrupt_range"

- need to pass a {offset,len} pair through the chain, not just a
  single offset. This will allow other types of devices to report
  different ranges of failures, from a single sector to an entire
  device.

- I'm not sure that passing the mf_recover_controller structure
  through the corruption event chain is the right thing to do here.
  A block device could generate this storage failure callback if it
  detects an unrecoverable error (e.g. during a MD media scrub or
  rebuild/resilver failure) and in that case we don't have PFNs or
  memory device failure functions to perform.

  IOWs, I think the action that is taken needs to be independent of
  the source that generated the error. Even for a pmem device, we
  can be using the page cache, so it may be possible to recover the
  pmem error by writing the cached page (if it exists) back over the
  pmem.

  Hence I think that the recover function probably needs to be moved
  to the address space ops, because what we do to recover from the
  error is going to be dependent on type of mapping the filesystem
  is using. If it's a DAX mapping, we call back into a generic DAX
  function that does the vma walk and process kill functions. If it
  is a page cache mapping, then if the page is cached then we can
  try to re-write it to disk to fix the bad data, otherwise we treat
  it like a writeback error and report it on the next
  write/fsync/close operation done on that file.

  This gets rid of the mf_recover_controller altogether and allows
  the interface to be used by any sort of block device for any sort
  of bottom-up reporting of media/device failures.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
