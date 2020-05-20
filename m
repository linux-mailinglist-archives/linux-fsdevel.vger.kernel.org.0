Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B101DBFDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgETUCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 16:02:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:8428 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgETUCn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 16:02:43 -0400
IronPort-SDR: En7TE4pC35+FsL0O09GAitU4+sdrIHfIoMomojKG3Eak4OdySbhQRzLJBPesusjYt+K2xDWlrI
 Qgi90tMh9pGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 13:02:42 -0700
IronPort-SDR: WGQiCEpS+JLoSUye2jjBRzzaU2aCBC9y335dAGm4Yvf+0DsM2Hro8uzHZ9fCeX36P9ZVeV2cR3
 LKkGrLFBJVxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="289471916"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2020 13:02:42 -0700
Date:   Wed, 20 May 2020 13:02:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Xi <lixi@ddn.com>
Subject: Re: [PATCH V3 7/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200520200242.GG3660833@iweiny-DESK2.sc.intel.com>
References: <20200520055753.3733520-1-ira.weiny@intel.com>
 <20200520055753.3733520-8-ira.weiny@intel.com>
 <34ECB1DE-9F2F-4365-BBBC-DFACF703E7D4@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34ECB1DE-9F2F-4365-BBBC-DFACF703E7D4@dilger.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 01:26:44PM -0600, Andreas Dilger wrote:
> On May 19, 2020, at 11:57 PM, ira.weiny@intel.com wrote:
> > 
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
> > 
> > ---
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 6235440e4c39..467c30a789b6 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -415,13 +415,16 @@ struct flex_groups {
> > #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
> > #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
> > /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
> > +
> > +#define EXT4_DAX_FL			0x01000000 /* Inode is DAX */
> > +
> > #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
> > #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> > #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
> > #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
> 
> Hi Ira,
> This flag value conflicts with the reserved flag in e2fsprogs for snapshots:
> 
> #define EXT4_SNAPFILE_FL                0x01000000  /* Inode is a snapshot */

Sure NP but is that new?  I'm building off of 5.7-rc4.

Just curious if I completely missed something.

> 
> Please change EXT4_DAX_FL and FS_DAX_FL to use 0x02000000, which is not used
> for anything in either case.

NP, thanks!
Ira

> 
> Cheers, Andreas
> 
> 
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 379a612f8f1d..7c5f6eb51e2d 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -262,6 +262,7 @@ struct fsxattr {
> > #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
> > #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
> > #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
> > +#define FS_DAX_FL			0x01000000 /* Inode is DAX */
> > #define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 */
> > #define FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> > #define FS_CASEFOLD_FL			0x40000000 /* Folder is case insensitive */
> > --
> > 2.25.1
> > 
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


