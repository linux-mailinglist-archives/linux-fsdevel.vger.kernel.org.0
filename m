Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA913D0CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 00:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbgAOXws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 18:52:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:54823 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbgAOXws (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 18:52:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 15:52:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="373102555"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 15 Jan 2020 15:52:38 -0800
Date:   Wed, 15 Jan 2020 15:52:37 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 08/12] fs/xfs: Add lock/unlock mode to xfs
Message-ID: <20200115235237.GA24522@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-9-ira.weiny@intel.com>
 <20200113221957.GN8247@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113221957.GN8247@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:19:57PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 10, 2020 at 11:29:38AM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> >  
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 401da197f012..e8fd95b75e5b 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
> >   *
> >   * Basic locking order:
> >   *
> > - * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> > + * i_rwsem -> i_dax_sem -> i_mmap_lock -> page_lock -> i_ilock
> 
> Mmmmmm, more locks.  Can we skip the extra lock if CONFIG_FSDAX=n or if
> the filesystem devices don't support DAX at all?

I've looked into this a bit more and I think skipping on CONFIG_FSDAX=n is ok
but doing so on individual devices is not going to be possible because we don't
have that information at the vfs layer.

I'll continue to think about how to mitigate this more while I add CONFIG_FSDAX
checks before rolling out a new patch set.

> 
> Also, I don't think we're actually following the i_rwsem -> i_daxsem
> order in fallocate, and possibly elsewhere too?
> 
> Does the vfs have to take the i_dax_sem to do remapping things like
> reflink?  (Pretend that reflink and dax are compatible for the moment)
> 

I spoke with Dan today about this and we believe the answer is going to be yes.
However, not until the code is added to support DAX in reflink.  Because
currently this is only required for places which use "IS_DAX()" to see the
state of the inode.

Currently the vfs layer does not have any IS_DAX() checks in the reflink path.
But when they are added they will be required to take this sem.

Ira

