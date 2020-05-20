Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC71DBE29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 21:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgETTkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 15:40:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:10555 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETTkv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 15:40:51 -0400
IronPort-SDR: i199y7XT3y75vPZAv3dVOhQe6MgxJboCXdkOlmKrC1TuUgbrowYksG6I/Xivybs19sd7XkqZq+
 vGgvOBCKRu7A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 12:40:51 -0700
IronPort-SDR: 0UdC0Tm/rggWF0VKDIH29th3oEr8q+29E63n9FBqDINHenmY5OhrM0IHVCDJ+TNF0kMWOHYcKa
 azNczIypjZaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="466508115"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2020 12:40:50 -0700
Date:   Wed, 20 May 2020 12:40:50 -0700
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
Subject: Re: [PATCH V3 4/8] fs/ext4: Update ext4_should_use_dax()
Message-ID: <20200520194050.GF3660833@iweiny-DESK2.sc.intel.com>
References: <20200520055753.3733520-1-ira.weiny@intel.com>
 <20200520055753.3733520-5-ira.weiny@intel.com>
 <20200520133728.GD30597@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520133728.GD30597@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 03:37:28PM +0200, Jan Kara wrote:
> On Tue 19-05-20 22:57:49, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > S_DAX should only be enabled when the underlying block device supports
> > dax.
> > 
> > Change ext4_should_use_dax() to check for device support prior to the
> > over riding mount option.
> > 
> > While we are at it change the function to ext4_should_enable_dax() as
> > this better reflects the ask as well as matches xfs.
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ...
> 
> > @@ -4412,7 +4410,13 @@ static bool ext4_should_use_dax(struct inode *inode)
> >  		return false;
> >  	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
> >  		return false;
> > -	return true;
> > +	if (!bdev_dax_supported(inode->i_sb->s_bdev,
> > +				inode->i_sb->s_blocksize))
> > +		return false;
> > +	if (test_opt(inode->i_sb, DAX_ALWAYS))
> > +		return true;
> > +
> > +	return false;
> >  }
> 
> Now that I think about it - shouldn't we rather cache the result of
> bdev_dax_supported() in sb on mount and then just check the flag here?
> Because bdev_dax_supported() isn't exactly cheap (it does a lot of checks
> and mappings, tries to read from the pmem, ...).

Sounds reasonable.

Not sure which flags are appropriate.  So add it here?

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1a3daf2d18ef..0b4db9ce7756 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1979,6 +1979,7 @@ static inline bool ext4_has_incompat_features(struct super_block *sb)
  */
 #define EXT4_FLAGS_RESIZING    0
 #define EXT4_FLAGS_SHUTDOWN    1
+#define EXT4_FLAGS_BDEV_IS_DAX 2
 
 static inline int ext4_forced_shutdown(struct ext4_sb_info *sbi)
 {

