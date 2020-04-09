Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC51A3B90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 22:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgDIUtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 16:49:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:43445 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgDIUtz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:49:55 -0400
IronPort-SDR: uXuWMNIRaWcJ3HWZL8ZTsRL/q4urg2weWeN1PdqnxNbjT8SlR3aEoGHjDucOfUB8ItnLhqSjB5
 C44WU4ixg5TA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 13:49:54 -0700
IronPort-SDR: uGT2DQfawKjjxTzrrboYSQ2lFlqOecSpTc00bpqC/04zZXNNxhOiDe9kG3EkErDx95QHN0t0w6
 ULbqkaHAeq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; 
   d="scan'208";a="452138957"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2020 13:49:53 -0700
Date:   Thu, 9 Apr 2020 13:49:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200409204952.GB801897@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <CAPcyv4gLvMSA9BypvWbYtv3xsK8o4+db3kvxBozUGAjr_sDDFQ@mail.gmail.com>
 <20200408235836.GQ24067@dread.disaster.area>
 <20200409002203.GE664132@iweiny-DESK2.sc.intel.com>
 <20200409124127.GB18171@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409124127.GB18171@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 02:41:27PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 08, 2020 at 05:22:03PM -0700, Ira Weiny wrote:
> > > You mean something like XFS_IDONTCACHE?
> > > 
> > > i.e. the functionality already exists in XFS to selectively evict an
> > > inode from cache when the last reference to it is dropped rather
> > > than let it go to the LRUs and hang around in memory.
> > > 
> > > That flag can be set when changing the on disk DAX flag, and we can
> > > tweak how it works so new cache hits don't clear it (as happens
> > > now). Hence the only thing that can prevent eviction are active
> > > references.
> > > 
> > > That means we'll still need to stop the application and drop_caches,
> > > because we need to close all the files and purge the dentries that
> > > hold references to the inode before it can be evicted.
> > 
> > That sounds like a great idea...
> > 
> > Jan?  Christoph?
> 
> Sounds ok.  Note that we could also pretty trivially lift
> XFS_IDONTCACHE to the VFS if we need to apply the same scheme to
> ext4.

Yes I have been slowing working on ext4 in the background.  So lifting
XXX_IDONTCACHE to VFS will be part of that series.

Thanks,
Ira
