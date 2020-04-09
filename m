Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED371A2CCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 02:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDIAWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 20:22:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:31348 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgDIAWE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:22:04 -0400
IronPort-SDR: y3GGlKUdTIrtflzcvc7g+gNoPgcIjFjbdBj28t4XMTscClC1uDryBUwBUacq05ag5XAEIuAE5B
 u9SSw/H/7krw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 17:22:04 -0700
IronPort-SDR: LoRxrN0v7Yij4I1aWo1Li88CuPwBtFEWvt42QBqLJwvvc/HLMBKCHYdxQQFi/aS4KtY8m6ul9y
 /w19/tI52P/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,360,1580803200"; 
   d="scan'208";a="398377351"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2020 17:22:03 -0700
Date:   Wed, 8 Apr 2020 17:22:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200409002203.GE664132@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <CAPcyv4gLvMSA9BypvWbYtv3xsK8o4+db3kvxBozUGAjr_sDDFQ@mail.gmail.com>
 <20200408235836.GQ24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408235836.GQ24067@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 09:58:36AM +1000, Dave Chinner wrote:
> On Wed, Apr 08, 2020 at 02:28:30PM -0700, Dan Williams wrote:
> > On Wed, Apr 8, 2020 at 2:02 PM Dave Chinner <david@fromorbit.com> wrote:
> > > THis leads to an obvious conclusion: if we never clear the in memory
> > > S_DAX flag, we can actually clear the on-disk flag safely, so that
> > > next time the inode cycles into memory it won't be using DAX. IOWs,
> > > admins can stop the applications, clear the DAX flag and drop
> > > caches. This should result in the inode being recycled and when the
> > > app is restarted it will run without DAX. No ned for deleting files,
> > > copying large data sets, etc just to turn off an inode flag.
> > 
> > Makes sense, but is that sufficient? I recall you saying there might
> > be a multitude of other reasons that the inode is not evicted, not the
> > least of which is races [1]. Does this need another flag, lets call it
> > "dax toggle" to track the "I requested the inode to clear the flag,
> > but on cache-flush + restart the inode never got evicted" case.
> 
> You mean something like XFS_IDONTCACHE?
> 
> i.e. the functionality already exists in XFS to selectively evict an
> inode from cache when the last reference to it is dropped rather
> than let it go to the LRUs and hang around in memory.
> 
> That flag can be set when changing the on disk DAX flag, and we can
> tweak how it works so new cache hits don't clear it (as happens
> now). Hence the only thing that can prevent eviction are active
> references.
> 
> That means we'll still need to stop the application and drop_caches,
> because we need to close all the files and purge the dentries that
> hold references to the inode before it can be evicted.

That sounds like a great idea...

Jan?  Christoph?

I will reiterate though that any delayed S_DAX change be done as a follow on
series to the one proposed here.

Ira
