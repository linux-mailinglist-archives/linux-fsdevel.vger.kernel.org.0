Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E601B69E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 01:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgDWXd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 19:33:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:18988 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDWXd7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:33:59 -0400
IronPort-SDR: igTssZu1bpifgD9I6sehjx3li8Zj9Myif2JFx3LC6aTcJIIAgzJVXNerbL4V7ckrqpVw4Tw9vA
 5IqIa8aTre4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 16:33:57 -0700
IronPort-SDR: xWJ4hmjX67bO7BINmkd4fMp2yXZYK2Es0hmS1z7ob7sRT3VbReAG3HJc2rsLTv4PrAoWEHoPlB
 NFCEq06Ufzaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,309,1583222400"; 
   d="scan'208";a="403105064"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga004.jf.intel.com with ESMTP; 23 Apr 2020 16:33:56 -0700
Date:   Thu, 23 Apr 2020 16:33:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V10 06/11] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200423233356.GB4088835@iweiny-DESK2.sc.intel.com>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-7-ira.weiny@intel.com>
 <20200423223531.GU27860@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423223531.GU27860@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 08:35:31AM +1000, Dave Chinner wrote:
> On Wed, Apr 22, 2020 at 02:20:57PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
> > continues to operate the same.  We add 'always', 'never', and 'inode'
> > (default).
> > 
> > [1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ....
> > @@ -129,7 +163,6 @@ xfs_fs_show_options(
> >  		{ XFS_MOUNT_GRPID,		",grpid" },
> >  		{ XFS_MOUNT_DISCARD,		",discard" },
> >  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> > -		{ XFS_MOUNT_DAX_ALWAYS,		",dax" },
> >  		{ 0, NULL }
> >  	};
> >  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> > @@ -185,6 +218,11 @@ xfs_fs_show_options(
> >  	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
> >  		seq_puts(m, ",noquota");
> >  
> > +	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS)
> > +		seq_puts(m, ",dax=always");
> > +	else if (mp->m_flags & XFS_MOUNT_DAX_NEVER)
> > +		seq_puts(m, ",dax=never");
> 
> These can never be set at the same time, so please put these in the
> m_flags options table as XFS_MOUNT_DAX_ALWAYS already is.  i.e.
> 
> @@ -129,7 +163,8 @@ xfs_fs_show_options(
>  		{ XFS_MOUNT_GRPID,		",grpid" },
>  		{ XFS_MOUNT_DISCARD,		",discard" },
>  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> -		{ XFS_MOUNT_DAX_ALWAYS,		",dax" },
> +		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> +		{ XFS_MOUNT_DAX_NEVER,		",dax=never" },
>  		{ 0, NULL }
>  	};
>  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> 
> Otherwise looks OK.

Done.

Ira

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
