Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125461E062B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 06:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEYEjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 00:39:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:12919 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgEYEjL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 00:39:11 -0400
IronPort-SDR: 02gefz82HyRqGfp/DRwWDX50sWBfFAzDWMGuXzBsU1a73YdFMPpbQM72TATUXdRw5AdQA3eSLW
 2+0/b/HqfNPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 21:39:11 -0700
IronPort-SDR: mkPIiir/SIIp5RsIl2SkJX+dMgspH7qHmH92MoBbroHS+PWpT9tKflWqEGsybUNTzLAYcNacxR
 ymSYNh1hOXyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="269644158"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 24 May 2020 21:39:10 -0700
Date:   Sun, 24 May 2020 21:39:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 7/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200525043910.GA319107@iweiny-DESK2.sc.intel.com>
References: <20200521191313.261929-1-ira.weiny@intel.com>
 <20200521191313.261929-8-ira.weiny@intel.com>
 <20200522114848.GC14199@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522114848.GC14199@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 01:48:48PM +0200, Jan Kara wrote:
> On Thu 21-05-20 12:13:12, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> > 
> > Set the flag to be user visible and changeable.  Set the flag to be
> > inherited.  Allow applications to change the flag at any time with the
> > exception of if VERITY or ENCRYPT is set.
> > 
> > Disallow setting VERITY or ENCRYPT if DAX is set.
> > 
> > Finally, on regular files, flag the inode to not be cached to facilitate
> > changing S_DAX on the next creation of the inode.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ...
> 
> > @@ -303,6 +318,16 @@ static int ext4_ioctl_setflags(struct inode *inode,
> >  	unsigned int jflag;
> >  	struct super_block *sb = inode->i_sb;
> >  
> > +	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX)) {
> > +		if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY) ||
> > +		    ext4_test_inode_flag(inode, EXT4_INODE_ENCRYPT) ||
> > +		    ext4_test_inode_state(inode,
> > +					  EXT4_STATE_VERITY_IN_PROGRESS)) {
> > +			err = -EOPNOTSUPP;
> > +			goto flags_out;
> > +		}
> > +	}
> 
> The way this check is implemented wouldn't IMO do what we need... It
> doesn't check the flags that are being set but just the current inode
> state. I think it should rather be:

Sorry, I got confused by the flags when I wrote this.

> 
> 	if ((flags ^ oldflags) & EXT4_INODE_DAX_FL) {
> 		...
> 	}
> 
> And perhaps move this to a place in ext4_ioctl_setflags() where we check
> other similar conflicts.

Sure.  It seems like a ext4_setflags_prepare() helper would be in order.  I'll
see what I can do.

> 
> And then we should check conflicts with the journal flag as well, as I
> mentioned in reply to the first patch. There it is more complicated by the
> fact that we should disallow setting of both EXT4_INODE_DAX_FL and
> EXT4_JOURNAL_DATA_FL at the same time so the checks will be somewhat more
> complicated.

I'm confused by jflag.  Why is EXT4_JOURNAL_DATA_FL stored in jflag?

Ira

> 
> 								Honza
> 
> > +
> >  	/* Is it quota file? Do not allow user to mess with it */
> >  	if (ext4_is_quota_file(inode))
> >  		goto flags_out;
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
