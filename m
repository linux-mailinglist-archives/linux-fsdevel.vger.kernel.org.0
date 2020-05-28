Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726231E5C3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgE1Jlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 05:41:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgE1Jlr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 05:41:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 037BFAD81;
        Thu, 28 May 2020 09:41:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D71171E1283; Thu, 28 May 2020 11:41:44 +0200 (CEST)
Date:   Thu, 28 May 2020 11:41:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 6/8] fs/ext4: Make DAX mount option a tri-state
Message-ID: <20200528094144.GD14550@quack2.suse.cz>
References: <20200521191313.261929-1-ira.weiny@intel.com>
 <20200521191313.261929-7-ira.weiny@intel.com>
 <5ECE00AE.3010802@cn.fujitsu.com>
 <20200527235002.GA725853@iweiny-DESK2.sc.intel.com>
 <5ECF7CD3.20409@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ECF7CD3.20409@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 28-05-20 16:56:51, Xiao Yang wrote:
> On 2020/5/28 7:50, Ira Weiny wrote:
> > On Wed, May 27, 2020 at 01:54:54PM +0800, Xiao Yang wrote:
> > > On 2020/5/22 3:13, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny<ira.weiny@intel.com>
> > > > 
> > > > We add 'always', 'never', and 'inode' (default).  '-o dax' continues to
> > > > operate the same which is equivalent to 'always'.  This new
> > > > functionality is limited to ext4 only.
> > > > 
> > > > Specifically we introduce a 2nd DAX mount flag EXT4_MOUNT2_DAX_NEVER and set
> > > > it and EXT4_MOUNT_DAX_ALWAYS appropriately for the mode.
> > > > 
> > > > We also force EXT4_MOUNT2_DAX_NEVER if !CONFIG_FS_DAX.
> > > > 
> > > > Finally, EXT4_MOUNT2_DAX_INODE is used solely to detect if the user
> > > > specified that option for printing.
> > > Hi Ira,
> > > 
> > > I have two questions when reviewing this patch:
> > > 1) After doing mount with the same dax=inode option, ext4/xfs shows
> > > differnt output(i.e. xfs doesn't print 'dax=inode'):
> > > ---------------------------------------------------
> > > # mount -o dax=inode /dev/pmem0 /mnt/xfstests/test/
> > > # mount | grep pmem0
> > > /dev/pmem0 on /mnt/xfstests/test type ext4 (rw,relatime,seclabel,dax=inode)
> > > 
> > > # mount -odax=inode /dev/pmem1 /mnt/xfstests/scratch/
> > > # mount | grep pmem1
> > > /dev/pmem1 on /mnt/xfstests/scratch type xfs
> > > (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> > > ----------------------------------------------------
> > > Is this expected output? why don't unify the output?
> > 
> > Correct. dax=inode is the default.  xfs treats that default the same whether
> > you specify it on the command line or not.
> > 
> > For ext4 Jan specifically asked that if the user specified dax=inode on the
> > command line that it be printed on the mount options.  If you don't specify
> > anything then dax=inode is in effect but ext4 will not print anything.
> > 
> > I had the behavior the same as XFS originally but Jan wanted it this way.  The
> > XFS behavior is IMO better and is what the new mount infrastructure gives by
> > default.
> 
> Could we unify the output?  It is strange for me to use differnt output on
> ext4 and xfs.

If we'd unify the output with XFS, it would be inconsistent with all the
other ext4 mount options. So I disagree with that. I agree it is not ideal
to have different behavior between xfs and ext4 but such is the historical
behavior. If we want to change that, we need to change the handling for all
the ext4 mount options. I'm open for that discussion but it is a problem
unrelated to this patch set.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
