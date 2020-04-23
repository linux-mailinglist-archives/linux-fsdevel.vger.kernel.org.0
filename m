Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E601B572B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgDWIY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 04:24:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:60024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWIYZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:24:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 614CFAF79;
        Thu, 23 Apr 2020 08:24:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 731811E0E61; Thu, 23 Apr 2020 10:24:22 +0200 (CEST)
Date:   Thu, 23 Apr 2020 10:24:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 03/11] fs/stat: Define DAX statx attribute
Message-ID: <20200423082422.GA3737@quack2.suse.cz>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-4-ira.weiny@intel.com>
 <20200422162951.GE6733@magnolia>
 <20200422185121.GL3372712@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422185121.GL3372712@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-04-20 11:51:21, Ira Weiny wrote:
> On Wed, Apr 22, 2020 at 09:29:51AM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 21, 2020 at 12:17:45PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > In order for users to determine if a file is currently operating in DAX
> > > state (effective DAX).  Define a statx attribute value and set that
> > > attribute if the effective DAX flag is set.
> > > 
> > > To go along with this we propose the following addition to the statx man
> > > page:
> > > 
> > > STATX_ATTR_DAX
> > > 
> > > 	The file is in the DAX (cpu direct access) state.  DAX state
> > > 	attempts to minimize software cache effects for both I/O and
> > > 	memory mappings of this file.  It requires a file system which
> > > 	has been configured to support DAX.
> > > 
> > > 	DAX generally assumes all accesses are via cpu load / store
> > > 	instructions which can minimize overhead for small accesses, but
> > > 	may adversely affect cpu utilization for large transfers.
> > > 
> > > 	File I/O is done directly to/from user-space buffers and memory
> > > 	mapped I/O may be performed with direct memory mappings that
> > > 	bypass kernel page cache.
> > > 
> > > 	While the DAX property tends to result in data being transferred
> > > 	synchronously, it does not give the same guarantees of O_SYNC
> > > 	where data and the necessary metadata are transferred together.
> > > 
> > > 	A DAX file may support being mapped with the MAP_SYNC flag,
> > > 	which enables a program to use CPU cache flush instructions to
> > > 	persist CPU store operations without an explicit fsync(2).  See
> > > 	mmap(2) for more information.
> > 
> > One thing I hadn't noticed before -- this is a change to userspace API,
> > so please cc this series to linux-api@vger.kernel.org when you send V10.
> 
> Right!  Glad you caught me on this because I was just preparing to send V10.
> 
> Is there someone I could directly mail who needs to look at this?  I guess I
> thought we had the important FS people involved for this type of API change.
> :-/

I believe we have all the important people here. But linux-api is a general
fallback list where people reviewing API changes linger. So when changing
user facing API, it is good to CC this list.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
