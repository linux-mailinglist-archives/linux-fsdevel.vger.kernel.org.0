Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADF2E09B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbfJVQvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 12:51:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:31181 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbfJVQvb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:51:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 09:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,216,1569308400"; 
   d="scan'208";a="201737358"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2019 09:51:29 -0700
Date:   Tue, 22 Oct 2019 09:51:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fs/stat: Define DAX statx attribute
Message-ID: <20191022165128.GA5432@iweiny-DESK2.sc.intel.com>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-2-ira.weiny@intel.com>
 <119b57ed-2799-c499-00df-50da80d23612@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119b57ed-2799-c499-00df-50da80d23612@plexistor.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 02:32:04PM +0300, Boaz Harrosh wrote:
> On 20/10/2019 18:59, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > In order for users to determine if a file is currently operating in DAX
> > mode (effective DAX).  Define a statx attribute value and set that
> > attribute if the effective DAX flag is set.
> > 
> > To go along with this we propose the following addition to the statx man
> > page:
> > 
> > STATX_ATTR_DAX
> > 
> > 	DAX (cpu direct access) is a file mode that attempts to minimize
> > 	software cache effects for both I/O and memory mappings of this
> > 	file.  It requires a capable device, a compatible filesystem
> > 	block size, and filesystem opt-in. It generally assumes all
> > 	accesses are via cpu load / store instructions which can
> > 	minimize overhead for small accesses, but adversely affect cpu
> > 	utilization for large transfers. File I/O is done directly
> > 	to/from user-space buffers. While the DAX property tends to
> > 	result in data being transferred synchronously it does not give
> > 	the guarantees of synchronous I/O that data and necessary
> > 	metadata are transferred. Memory mapped I/O may be performed
> > 	with direct mappings that bypass system memory buffering. Again
> > 	while memory-mapped I/O tends to result in data being
> > 	transferred synchronously it does not guarantee synchronous
> > 	metadata updates. A dax file may optionally support being mapped
> > 	with the MAP_SYNC flag which does allow cpu store operations to
> > 	be considered synchronous modulo cpu cache effects.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/stat.c                 | 3 +++
> >  include/uapi/linux/stat.h | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/fs/stat.c b/fs/stat.c
> > index c38e4c2e1221..59ca360c1ffb 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -77,6 +77,9 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
> >  	if (IS_AUTOMOUNT(inode))
> >  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
> >  
> > +	if (inode->i_flags & S_DAX)
> 
> Is there a reason not to use IS_DAX(inode) ?

No, just forgot there was a macro when this was written.  Changed.

Thanks,
Ira

> 
> > +		stat->attributes |= STATX_ATTR_DAX;
> > +
> >  	if (inode->i_op->getattr)
> >  		return inode->i_op->getattr(path, stat, request_mask,
> >  					    query_flags);
> > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > index 7b35e98d3c58..5b0962121ef7 100644
> > --- a/include/uapi/linux/stat.h
> > +++ b/include/uapi/linux/stat.h
> > @@ -169,6 +169,7 @@ struct statx {
> >  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
> >  
> >  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> > +#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
> >  
> >  
> >  #endif /* _UAPI_LINUX_STAT_H */
> > 
> 
