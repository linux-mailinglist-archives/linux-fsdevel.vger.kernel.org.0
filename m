Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B332A13EC36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406460AbgAPRzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 12:55:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:13777 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406025AbgAPRzF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:55:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 09:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="214168129"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2020 09:55:02 -0800
Date:   Thu, 16 Jan 2020 09:55:02 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Message-ID: <20200116175501.GC24522@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz>
 <20200115173834.GD8247@magnolia>
 <20200115194512.GF23311@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hwefzruFj02YHYiy8nOpHJFGLKksjiXoRUGpT3C2rDag@mail.gmail.com>
 <20200115223821.GG23311@iweiny-DESK2.sc.intel.com>
 <20200116053935.GB8235@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116053935.GB8235@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:39:35PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 15, 2020 at 02:38:21PM -0800, Ira Weiny wrote:
> > On Wed, Jan 15, 2020 at 12:10:50PM -0800, Dan Williams wrote:
> > > On Wed, Jan 15, 2020 at 11:45 AM Ira Weiny <ira.weiny@intel.com> wrote:
> > > >
> > > > On Wed, Jan 15, 2020 at 09:38:34AM -0800, Darrick J. Wong wrote:
> > > > > On Wed, Jan 15, 2020 at 12:37:15PM +0100, Jan Kara wrote:
> > > > > > On Fri 10-01-20 11:29:31, ira.weiny@intel.com wrote:
> > > > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > > >
> > 

[snip]

> > 
> > Sure, but for now I think referencing mmap for details on MAP_SYNC works.
> > 
> > I suspect that we may have some word smithing once I get this series in and we
> > submit a change to the statx man page itself.  Can I move forward with the
> > following for this patch?
> > 
> > <quote>
> > STATX_ATTR_DAX
> > 
> >         The file is in the DAX (cpu direct access) state.  DAX state
> 
> Hmm, now that I see it written out, I <cough> kind of like "DAX mode"
> better now. :/
> 
> "The file is in DAX (CPU direct access) mode.  DAX mode attempts..."

Sure...  now you tell me...  ;-)

Seriously, we could use mode here in the man page as this is less confusing to
say "DAX mode".

But I think the code should still use 'state' because mode is just too
overloaded.  You were not the only one who was thrown by my use of mode and I
don't want that confusion when we look at this code 2 weeks from now...

https://www.reddit.com/r/ProgrammerHumor/comments/852og2/only_god_knows/

;-)

> 
> >         attempts to minimize software cache effects for both I/O and
> >         memory mappings of this file.  It requires a file system which
> >         has been configured to support DAX.
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
> >         transferred together.
> 
> (I'm frankly not sure that synchronous I/O actually guarantees that the
> metadata has hit stable storage...)

I'll let you and Dan work this one out...  ;-)

Ira

