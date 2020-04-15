Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97091AB2D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 22:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442089AbgDOUj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 16:39:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:5824 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438376AbgDOUj0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:39:26 -0400
IronPort-SDR: YXdlE5sGDTE2nXHPYp4kFm1d1ULAFC95iW/NGpKO3KD8QEyQse0Epkx0/tVgBFWUMZY0e+c20+
 1BMw/cYLxkGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 13:39:25 -0700
IronPort-SDR: SCt4dNj4WEUs8M1Y/+OmMuJVAREuUDMSfkTCsNZ/iC/VnmW7zYxANvKOU14AxwPNRx9l6aKLI2
 fIpf58+6za0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="245783322"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 13:39:25 -0700
Date:   Wed, 15 Apr 2020 13:39:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200415203924.GD2309605@iweiny-DESK2.sc.intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-5-ira.weiny@intel.com>
 <20200415120846.GG6126@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415120846.GG6126@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:08:46PM +0200, Jan Kara wrote:
> On Mon 13-04-20 21:00:26, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> > 
> > Set the flag to be user visible and changeable.  Set the flag to be
> > inherited.  Allow applications to change the flag at any time.
> > 
> > Finally, on regular files, flag the inode to not be cached to facilitate
> > changing S_DAX on the next creation of the inode.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/ext4/ext4.h  | 13 +++++++++----
> >  fs/ext4/ioctl.c | 21 ++++++++++++++++++++-
> >  2 files changed, 29 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 61b37a052052..434021fcec88 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -415,13 +415,16 @@ struct flex_groups {
> >  #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
> >  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
> >  #define EXT4_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
> > +
> > +#define EXT4_DAX_FL			0x00800000 /* Inode is DAX */
> > +
> 
> You seem to be using somewhat older kernel... EXT4_EOFBLOCKS_FL doesn't
> exist anymore (but still it's good to leave it reserved for some time so
> the value you've chosen is OK).

I'm on top of 5.6 released.  Did this get removed for 5.7?  I've heard there are
some boot issues with 5.7-rc1 so I'm holding out for rc2.

> 
> > @@ -813,6 +818,17 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
> >  	return error;
> >  }
> >  
> > +static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
> > +{
> > +	struct ext4_inode_info *ei = EXT4_I(inode);
> > +
> > +	if (S_ISDIR(inode->i_mode))
> > +		return;
> > +
> > +	if ((ei->i_flags ^ flags) == EXT4_DAX_FL)
> > +		inode->i_state |= I_DONTCACHE;
> > +}
> > +
> 
> You probably want to use the function you've introduced in the XFS series
> here...

you mean:

flag_inode_dontcache()
???

Yes that is done.  I sent this prior to v8 (where that was added) of the other
series...

Ira

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
