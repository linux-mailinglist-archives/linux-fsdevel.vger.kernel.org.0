Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEAD13BEB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgAOLmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 06:42:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:41998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgAOLmK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 06:42:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 641C1AEEE;
        Wed, 15 Jan 2020 11:42:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9817D1E0CBC; Wed, 15 Jan 2020 12:34:55 +0100 (CET)
Date:   Wed, 15 Jan 2020 12:34:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 09/12] fs: Prevent mode change if file is mmap'ed
Message-ID: <20200115113455.GA2595@quack2.suse.cz>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-10-ira.weiny@intel.com>
 <20200113222212.GO8247@magnolia>
 <20200114004610.GD29860@iweiny-DESK2.sc.intel.com>
 <20200114013004.GU8247@magnolia>
 <20200114175353.GA7871@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114175353.GA7871@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-01-20 09:53:54, Ira Weiny wrote:
> On Mon, Jan 13, 2020 at 05:30:04PM -0800, Darrick J. Wong wrote:
> > > > > +		error = -EBUSY;
> > > > > +		goto out_unlock;
> > > > > +	}
> > > > > +
> > > > >  	error = filemap_write_and_wait(inode->i_mapping);
> > > > >  	if (error)
> > > > >  		goto out_unlock;
> > > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > > index 631f11d6246e..6e7dc626b657 100644
> > > > > --- a/include/linux/fs.h
> > > > > +++ b/include/linux/fs.h
> > > > > @@ -740,6 +740,7 @@ struct inode {
> > > > >  #endif
> > > > >  
> > > > >  	void			*i_private; /* fs or device private pointer */
> > > > > +	atomic64_t               i_mapped;
> > > > 
> > > > I would have expected to find this in struct address_space since the
> > > > mapping count is a function of the address space, right?
> > > 
> > > I suppose but the only external call (above) would be passing an inode.  So to
> > > me it seemed better here.
> > 
> > But the number of memory mappings reflects the state of the address
> > space, not the inode.  Or maybe put another way, if I were an mm
> > developer I would not expect to look in struct inode for mm state.
> 
> This is a good point...
> 
> > 
> > static inline bool inode_has_mappings(struct inode *inode)
> > {
> > 	return atomic64_read(&inode->i_mapping->mapcount) > 0;
> > }
> > 
> > OTOH if there exist other mm developers who /do/ find that storing the
> > mmap count in struct inode is more logical, please let me know. :)
> 
> ...  My thinking was that the number of mappings does not matters to the mm
> system...  However, I'm starting to think you are correct...  ;-)
> 
> I've made a note of it and we will see what others think.

Well, more importantly mapping != inode. There can be multiple inodes
pointing to the same mapping (struct address_space) as is the case for
example for block devices. So this counter definitely belongs into struct
address_space.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
