Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310C413B28C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 20:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgANTA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 14:00:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:52152 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgANTA6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:00:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 11:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="219689462"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jan 2020 11:00:57 -0800
Date:   Tue, 14 Jan 2020 11:00:57 -0800
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
Message-ID: <20200114190057.GB7871@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-11-ira.weiny@intel.com>
 <20200113222755.GP8247@magnolia>
 <20200114004047.GC29860@iweiny-DESK2.sc.intel.com>
 <20200114011407.GT8247@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114011407.GT8247@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 05:14:07PM -0800, Darrick J. Wong wrote:
> On Mon, Jan 13, 2020 at 04:40:47PM -0800, Ira Weiny wrote:
> > On Mon, Jan 13, 2020 at 02:27:55PM -0800, Darrick J. Wong wrote:
> > > On Fri, Jan 10, 2020 at 11:29:40AM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > When zeroing the end of a file we must account for bytes contained in
> > > > the final page which are past EOF.
> > > > 
> > > > Extend the range passed to iomap_zero_range() to reach LLONG_MAX which
> > > > will include all bytes of the final page.
> > > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > ---
> > > >  fs/xfs/xfs_iops.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > > index a2f2604c3187..a34b04e8ac9c 100644
> > > > --- a/fs/xfs/xfs_iops.c
> > > > +++ b/fs/xfs/xfs_iops.c
> > > > @@ -910,7 +910,7 @@ xfs_setattr_size(
> > > >  	 */
> > > >  	if (newsize > oldsize) {
> > > >  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
> > > > -		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
> > > > +		error = iomap_zero_range(inode, oldsize, LLONG_MAX - oldsize,
> > > 
> > > Huh?  Won't this cause the file size to be set to LLONG_MAX?
> > 
> > Not as I understand the code.
> 
> iomap_zero_range uses the standard iomap_write_{begin,end} functions,
> which means that if you pass it an (offset, length) that extend beyond
> EOF it will change isize to offset+length.

I don't see that but I'll take your word for it...  That is unfortunate because
I would have thought that the full page would have been zero'ed by something
already.

I found code in xfs_free_file_space() with this comment:

        /*
         * If we zeroed right up to EOF and EOF straddles a page boundary we
         * must make sure that the post-EOF area is also zeroed because the
         * page could be mmap'd and iomap_zero_range doesn't do that for us.
         * Writeback of the eof page will do this, albeit clumsily.
         */

But that just calls filemap_write_and_wait_range()...  :-/

> 
> > But as I said in the cover I am not 100% sure of
> > this fix.
> 
> > From what I can tell xfs_ioctl_setattr_dax_invalidate() should invalidate the
> > mappings and the page cache and the traces I have indicate that the DAX mode
> > is not changing or was properly held off.
> 
> Hmm, that implies the invalidation didn't work.  Can you find a way to
> report the contents of the page cache after the dax mode change
> invalidation fails?  I wonder if this is something dorky like rounding
> down such that the EOF page doesn't actually get invalidated?
> 
> Hmm, no, xfs_ioctl_setattr_dax_invalidate should be nuking all the
> pages... do you have a quick reproducer?

I thought I did...

What I have done is take this patch:

https://www.spinics.net/lists/fstests/msg13313.html

and put [run_fsx ""] in a loop... (diff below) And without this truncate fix
patch it was failing in about 5 - 10 iterations.  But I'm running it right now
and it has gone for 30+...  :-(

I am 90% confident that this series works for 100% of the use cases we have.  I
think this is an existing bug which I've just managed to find.  And again I'm
not comfortable with this patch either.  So I'm not trying to argue for it but
I just don't know what could be wrong...

Ira

diff --git a/tests/generic/999 b/tests/generic/999
index 6dd5529dbc65..929c20c6db04 100755
--- a/tests/generic/999
+++ b/tests/generic/999
@@ -274,7 +274,9 @@ function run_fsx {
        pid=""
 }
 
-run_fsx ""
+while [ 1 ]; do
+       run_fsx ""
+done
 run_fsx "-A"
 run_fsx "-Z -r 4096 -w 4096"

