Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F21413D030
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 23:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgAOWiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 17:38:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:62536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgAOWiW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:38:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 14:38:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="423770541"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jan 2020 14:38:21 -0800
Date:   Wed, 15 Jan 2020 14:38:21 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Message-ID: <20200115223821.GG23311@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz>
 <20200115173834.GD8247@magnolia>
 <20200115194512.GF23311@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hwefzruFj02YHYiy8nOpHJFGLKksjiXoRUGpT3C2rDag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hwefzruFj02YHYiy8nOpHJFGLKksjiXoRUGpT3C2rDag@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 12:10:50PM -0800, Dan Williams wrote:
> On Wed, Jan 15, 2020 at 11:45 AM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Wed, Jan 15, 2020 at 09:38:34AM -0800, Darrick J. Wong wrote:
> > > On Wed, Jan 15, 2020 at 12:37:15PM +0100, Jan Kara wrote:
> > > > On Fri 10-01-20 11:29:31, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > >

[snip]

> > Ok I changed a couple of things as well.  How does this sound?
> >
> >
> > STATX_ATTR_DAX
> >
> >         DAX (cpu direct access) is a file mode that attempts to minimize
> 
> s/mode/state/?

DOH!  yes state...  ;-)

> 
> >         software cache effects for both I/O and memory mappings of this
> >         file.  It requires a block device and file system which have
> >         been configured to support DAX.
> 
> It may not require a block device in the future.

Ok:

"It requires a file system which has been configured to support DAX." ?

I'm trying to separate the user of the individual STATX DAX flag from the Admin
details of configuring the file system and/or devices which supports it.

Also, I just realized that we should follow the format of the other STATX_*
attributes.  They all read something like "the file is..."

So I'm adding that text as well.

> 
> >
> >         DAX generally assumes all accesses are via cpu load / store
> >         instructions which can minimize overhead for small accesses, but
> >         may adversely affect cpu utilization for large transfers.
> >
> >         File I/O is done directly to/from user-space buffers and memory
> >         mapped I/O may be performed with direct memory mappings that
> >         bypass kernel page cache.
> >
> >         While the DAX property tends to result in data being transferred
> >         synchronously, it does not give the same guarantees of
> >         synchronous I/O where data and the necessary metadata are
> 
> Maybe use "O_SYNC I/O" explicitly to further differentiate the 2
> meanings of "synchronous" in this sentence?

Done.

> 
> >         transferred together.
> >
> >         A DAX file may support being mapped with the MAP_SYNC flag,
> >         which enables a program to use CPU cache flush operations to
> 
> s/operations/instructions/

Done.

> 
> >         persist CPU store operations without an explicit fsync(2).  See
> >         mmap(2) for more information.
> 
> I think this also wants a reference to the Linux interpretation of
> platform "persistence domains" we were discussing that here [1], but
> maybe it should be part of a "pmem" manpage that can be referenced
> from this man page.

Sure, but for now I think referencing mmap for details on MAP_SYNC works.

I suspect that we may have some word smithing once I get this series in and we
submit a change to the statx man page itself.  Can I move forward with the
following for this patch?

<quote>
STATX_ATTR_DAX

        The file is in the DAX (cpu direct access) state.  DAX state
        attempts to minimize software cache effects for both I/O and
        memory mappings of this file.  It requires a file system which
        has been configured to support DAX.

        DAX generally assumes all accesses are via cpu load / store
        instructions which can minimize overhead for small accesses, but
        may adversely affect cpu utilization for large transfers.

        File I/O is done directly to/from user-space buffers and memory
        mapped I/O may be performed with direct memory mappings that
        bypass kernel page cache.

        While the DAX property tends to result in data being transferred
        synchronously, it does not give the same guarantees of
        synchronous I/O where data and the necessary metadata are
        transferred together.

        A DAX file may support being mapped with the MAP_SYNC flag,
        which enables a program to use CPU cache flush instructions to
        persist CPU store operations without an explicit fsync(2).  See
        mmap(2) for more information.
</quote>

Ira

> 
> [1]: http://lore.kernel.org/r/20200108064905.170394-1-aneesh.kumar@linux.ibm.com
