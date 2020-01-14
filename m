Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93D713B167
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 18:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgANRxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 12:53:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:5109 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgANRxz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:53:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 09:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="225622891"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2020 09:53:54 -0800
Date:   Tue, 14 Jan 2020 09:53:54 -0800
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
Subject: Re: [RFC PATCH V2 09/12] fs: Prevent mode change if file is mmap'ed
Message-ID: <20200114175353.GA7871@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-10-ira.weiny@intel.com>
 <20200113222212.GO8247@magnolia>
 <20200114004610.GD29860@iweiny-DESK2.sc.intel.com>
 <20200114013004.GU8247@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114013004.GU8247@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 05:30:04PM -0800, Darrick J. Wong wrote:
> On Mon, Jan 13, 2020 at 04:46:10PM -0800, Ira Weiny wrote:
> > On Mon, Jan 13, 2020 at 02:22:12PM -0800, Darrick J. Wong wrote:
> > > On Fri, Jan 10, 2020 at 11:29:39AM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > 
> > [snip]
> > 
> > > >  
> > > > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > > > index bc3654fe3b5d..1ab0906c6c7f 100644
> > > > --- a/fs/xfs/xfs_ioctl.c
> > > > +++ b/fs/xfs/xfs_ioctl.c
> > > > @@ -1200,6 +1200,14 @@ xfs_ioctl_setattr_dax_invalidate(
> > > >  		goto out_unlock;
> > > >  	}
> > > >  
> > > > +	/*
> > > > +	 * If there is a mapping in place we must remain in our current mode.
> > > > +	 */
> > > > +	if (atomic64_read(&inode->i_mapped)) {
> > > 
> > > Urk, should we really be messing around with the address space
> > > internals?
> > 
> > I contemplated a function call instead of checking i_mapped directly?  Is that
> > what you mean?
> 
> Yeah.  Abstracting the details just enough that filesystems don't have
> to know that i_mapped is atomic64 etc.

Done.

> 
> > 
> > > 
> > > > +		error = -EBUSY;
> > > > +		goto out_unlock;
> > > > +	}
> > > > +
> > > >  	error = filemap_write_and_wait(inode->i_mapping);
> > > >  	if (error)
> > > >  		goto out_unlock;
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index 631f11d6246e..6e7dc626b657 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -740,6 +740,7 @@ struct inode {
> > > >  #endif
> > > >  
> > > >  	void			*i_private; /* fs or device private pointer */
> > > > +	atomic64_t               i_mapped;
> > > 
> > > I would have expected to find this in struct address_space since the
> > > mapping count is a function of the address space, right?
> > 
> > I suppose but the only external call (above) would be passing an inode.  So to
> > me it seemed better here.
> 
> But the number of memory mappings reflects the state of the address
> space, not the inode.  Or maybe put another way, if I were an mm
> developer I would not expect to look in struct inode for mm state.

This is a good point...

> 
> static inline bool inode_has_mappings(struct inode *inode)
> {
> 	return atomic64_read(&inode->i_mapping->mapcount) > 0;
> }
> 
> OTOH if there exist other mm developers who /do/ find that storing the
> mmap count in struct inode is more logical, please let me know. :)

...  My thinking was that the number of mappings does not matters to the mm
system...  However, I'm starting to think you are correct...  ;-)

I've made a note of it and we will see what others think.

Ira

> 
> --D
> 
> > Ira
> > 
> > > 
> > > --D
> > > 
