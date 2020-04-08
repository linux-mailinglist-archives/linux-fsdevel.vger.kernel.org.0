Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506E31A2BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 00:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDHWLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 18:11:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:56607 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgDHWLB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 18:11:01 -0400
IronPort-SDR: t51Rzghmik65uG5BBbNzrZzKjaMC1mM9moLJJfe7Gb4KIuA1YdeHdhkyGGMRzAaLzFrmYuvWse
 vFepmLU0jsSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 15:11:00 -0700
IronPort-SDR: HpDApRLuGuakuVVDxGql4LJ8QoRNSswYqXGAto8C6w6PP4UXAKsVCFtO1m6A+8WFPqoMNN7r51
 KYew19Pz4IhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,360,1580803200"; 
   d="scan'208";a="330665433"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2020 15:10:59 -0700
Date:   Wed, 8 Apr 2020 15:10:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20200408221059.GB664132@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <CAPcyv4gLvMSA9BypvWbYtv3xsK8o4+db3kvxBozUGAjr_sDDFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gLvMSA9BypvWbYtv3xsK8o4+db3kvxBozUGAjr_sDDFQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:28:30PM -0700, Dan Williams wrote:
> On Wed, Apr 8, 2020 at 2:02 PM Dave Chinner <david@fromorbit.com> wrote:
> >

[snip]

> > >
> > > void
> > > xfs_diflags_to_iflags(
> > >         struct xfs_inode        *ip,
> > >         bool init)
> > > {
> > >         struct inode            *inode = VFS_I(ip);
> > >         unsigned int            xflags = xfs_ip2xflags(ip);
> > >         unsigned int            flags = 0;
> > >
> > >         inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME |
> > >                             S_DAX);
> >
> > We don't want to clear the dax flag here, ever, if it is already
> > set. That is an externally visible change and opens us up (again) to
> > races where IS_DAX() changes half way through a fault path. IOWs, avoiding
> > clearing the DAX flag was something I did explicitly in the above
> > code fragment.
> >
> > And it makes the logic clearer by pre-calculating the new flags,
> > then clearing and setting the inode flags together, rather than
> > having the spearated at the top and bottom of the function.
> >
> > THis leads to an obvious conclusion: if we never clear the in memory
> > S_DAX flag, we can actually clear the on-disk flag safely, so that
> > next time the inode cycles into memory it won't be using DAX. IOWs,
> > admins can stop the applications, clear the DAX flag and drop
> > caches. This should result in the inode being recycled and when the
> > app is restarted it will run without DAX. No ned for deleting files,
> > copying large data sets, etc just to turn off an inode flag.
> 
> Makes sense, but is that sufficient? I recall you saying there might
> be a multitude of other reasons that the inode is not evicted, not the
> least of which is races [1]. Does this need another flag, lets call it
> "dax toggle" to track the "I requested the inode to clear the flag,
> but on cache-flush + restart the inode never got evicted" case. S_DAX
> almost plays this role, but it loses the ability to audit which files
> are pending an inode eviction event. So the dax-toggle flag indicates
> to the kernel to xor the toggle value with the inode flag on inode
> instantiation and the dax inode flag is never directly manipulated by
> the ioctl path.
> 
> [1]: http://lore.kernel.org/r/20191025003603.GE4614@dread.disaster.area

FWIW I think we should continue down this simplified interface and get this
done for 5.8.  If we can come up with a way for delayed mode change I'm all for
looking into that.  But there has been too much controversy/difficulty about
changing the bit on a file.

So let's table this idea until >= 5.9

Ira

