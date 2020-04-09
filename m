Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2391A3688
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 17:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDIPDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 11:03:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:52337 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgDIPDc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:03:32 -0400
IronPort-SDR: annczlKFyVnqL1wSRbelpu7w/MpvLEdyS/n56wyFiuZCsNORaLiAkMVUsgfwvpPTiNChki6SpX
 wGn4Ht/IwhZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 08:03:32 -0700
IronPort-SDR: 1uivUO33XXiZpc5osXMM9HihbKx8rKlq3h8GMA35BEj9CDpG/l9FMkUfzs1NB4o9VaF+pcLjod
 Wg43rbKGpFMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; 
   d="scan'208";a="286914865"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2020 08:03:32 -0700
Date:   Thu, 9 Apr 2020 08:03:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 4/8] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200409150331.GG664132@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-5-ira.weiny@intel.com>
 <20200407235909.GF24067@dread.disaster.area>
 <20200408000903.GA569068@iweiny-DESK2.sc.intel.com>
 <20200408004801.GH24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408004801.GH24067@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:48:01AM +1000, Dave Chinner wrote:
> On Tue, Apr 07, 2020 at 05:09:04PM -0700, Ira Weiny wrote:
> > On Wed, Apr 08, 2020 at 09:59:09AM +1000, Dave Chinner wrote:
> > > 
> > > This is overly complex. Just use 2 flags:
> > 
> > LOL...  I was afraid someone would say that.  At first I used 2 flags with
> > fsparam_string, but then I realized Darrick suggested fsparam_enum:
> 
> Well, I'm not concerned about the fsparam enum, it's just that
> encoding an integer into a flags bit field is just ... messy.
> Especially when encoding that state can be done with just 2 flags.
> 
> If you want to keep the xfs_mount_dax_mode() wrapper, then:
> 
> static inline uint32_t xfs_mount_dax_mode(struct xfs_mount *mp)
> {
> 	if (mp->m_flags & XFS_MOUNT_DAX_NEVER)
> 		return XFS_DAX_NEVER;
> 	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS)
> 		return XFS_DAX_ALWAYS;
> 	return XFS_DAX_IFLAG;
> }
> 
> but once it's encoded in flags like this, the wrapper really isn't
> necessary...

Done for v7

> 
> Also, while I think of it, can we change "iflag" to "inode". i.e.
> the DAX state is held on the inode. Saying it comes from an "inode
> flag" encodes the implementation into the user interface. i.e. it
> could well be held in an xattr on the inode on another filesystem,
> so we shouldn't mention "flag" in the user API....

Sure "inode" is fine with me.  Easy change, done for v7

Ira

