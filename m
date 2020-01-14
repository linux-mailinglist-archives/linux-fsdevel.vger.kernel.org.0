Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A1139E65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 01:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgANAkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 19:40:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:49386 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgANAks (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:40:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 16:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="219440214"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jan 2020 16:40:47 -0800
Date:   Mon, 13 Jan 2020 16:40:47 -0800
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
Subject: Re: [RFC PATCH V2 10/12] fs/xfs: Fix truncate up
Message-ID: <20200114004047.GC29860@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-11-ira.weiny@intel.com>
 <20200113222755.GP8247@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113222755.GP8247@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:27:55PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 10, 2020 at 11:29:40AM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > When zeroing the end of a file we must account for bytes contained in
> > the final page which are past EOF.
> > 
> > Extend the range passed to iomap_zero_range() to reach LLONG_MAX which
> > will include all bytes of the final page.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/xfs/xfs_iops.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index a2f2604c3187..a34b04e8ac9c 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -910,7 +910,7 @@ xfs_setattr_size(
> >  	 */
> >  	if (newsize > oldsize) {
> >  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
> > -		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
> > +		error = iomap_zero_range(inode, oldsize, LLONG_MAX - oldsize,
> 
> Huh?  Won't this cause the file size to be set to LLONG_MAX?

Not as I understand the code.  But as I said in the cover I am not 100% sure of
this fix.

From what I can tell xfs_ioctl_setattr_dax_invalidate() should invalidate the
mappings and the page cache and the traces I have indicate that the DAX mode
is not changing or was properly held off.

Any other suggestions as to the problem are welcome.

Ira


> 
> --D
> 
> >  				&did_zeroing, &xfs_buffered_write_iomap_ops);
> >  	} else {
> >  		error = iomap_truncate_page(inode, newsize, &did_zeroing,
> > -- 
> > 2.21.0
> > 
