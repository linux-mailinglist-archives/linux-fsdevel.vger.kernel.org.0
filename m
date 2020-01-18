Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2830B1416B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 10:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgARJLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 04:11:12 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41699 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgARJLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 04:11:12 -0500
Received: from dread.disaster.area (pa49-181-172-170.pa.nsw.optusnet.com.au [49.181.172.170])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 17D1F7EB72C;
        Sat, 18 Jan 2020 20:11:07 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1isk8H-0003Ey-Eq; Sat, 18 Jan 2020 20:11:05 +1100
Date:   Sat, 18 Jan 2020 20:11:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Message-ID: <20200118091105.GA9407@dread.disaster.area>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz>
 <20200115173834.GD8247@magnolia>
 <20200115194512.GF23311@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hwefzruFj02YHYiy8nOpHJFGLKksjiXoRUGpT3C2rDag@mail.gmail.com>
 <20200115223821.GG23311@iweiny-DESK2.sc.intel.com>
 <20200116053935.GB8235@magnolia>
 <CAPcyv4jDMsPj_vZwDOgPkfHLELZWqeJugKgKNVKbpiZ9th683g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jDMsPj_vZwDOgPkfHLELZWqeJugKgKNVKbpiZ9th683g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=IIEU8dkfCNxGYurWsojP/w==:117 a=IIEU8dkfCNxGYurWsojP/w==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=Ei6hhWl3_lwP0hYN7Z4A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:05:00PM -0800, Dan Williams wrote:
> On Wed, Jan 15, 2020 at 9:39 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> [..]
> > >         attempts to minimize software cache effects for both I/O and
> > >         memory mappings of this file.  It requires a file system which
> > >         has been configured to support DAX.
> > >
> > >         DAX generally assumes all accesses are via cpu load / store
> > >         instructions which can minimize overhead for small accesses, but
> > >         may adversely affect cpu utilization for large transfers.
> > >
> > >         File I/O is done directly to/from user-space buffers and memory
> > >         mapped I/O may be performed with direct memory mappings that
> > >         bypass kernel page cache.
> > >
> > >         While the DAX property tends to result in data being transferred
> > >         synchronously, it does not give the same guarantees of
> > >         synchronous I/O where data and the necessary metadata are
> > >         transferred together.
> >
> > (I'm frankly not sure that synchronous I/O actually guarantees that the
> > metadata has hit stable storage...)
> 
> Oh? That text was motivated by the open(2) man page description of O_SYNC.

Ugh. "synchronous I/O" means two different things, depending on
context. In the AIO context, it means "process context waits for operation
completion direct", but in the O_SYNC context, it means "we guarantee
data integrity for each I/O submitted".

Indeed, O_SYNC AIO is a thing. i.e. we can do an "async sync
write" to guarantee data integrity without directly waiting for
it. Now try describing that only using the words "synchronous
write" to describe both behaviours. :)

IOWs, if you are talking about data integrity, you need to
explicitly say "O_SYNC semantics", not "synchronous write", because
"synchronous write" is totally ambiguous without the O_SYNC context
of the open(2) man page...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
