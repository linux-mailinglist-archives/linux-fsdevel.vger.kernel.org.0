Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285BB1AE3A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 19:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgDQRSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 13:18:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:38317 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbgDQRSs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:18:48 -0400
IronPort-SDR: C2J0PciOyiK58RXrasEPG5UQyk3plNVx4XvVx2LWZtsYUFilLl1ixnlRS7kPrnuwJ8qPqfNrAl
 RfB1CAWy/NcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 10:18:47 -0700
IronPort-SDR: 8BvyzJZTTPxZq1JMzqv0ShOHKYfE+9w47rynvb46vdYJ0tmejNjAMCCmNGpIlM33VFRMuy9mET
 WT5vc+Nm5SEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="272484852"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 17 Apr 2020 10:18:46 -0700
Date:   Fri, 17 Apr 2020 10:18:46 -0700
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
Subject: Re: [PATCH RFC 7/8] fs/ext4: Only change S_DAX on inode load
Message-ID: <20200417171846.GS2309605@iweiny-DESK2.sc.intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-8-ira.weiny@intel.com>
 <20200415140308.GJ6126@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415140308.GJ6126@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 04:03:08PM +0200, Jan Kara wrote:
> On Mon 13-04-20 21:00:29, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > To prevent complications with in memory inodes we only set S_DAX on
> > inode load.  FS_XFLAG_DAX can be changed at any time and S_DAX will
> > change after inode eviction and reload.
> > 
> > Add init bool to ext4_set_inode_flags() to indicate if the inode is
> > being newly initialized.
> > 
> > Assert that S_DAX is not set on an inode which is just being loaded.
> 
> > @@ -4408,11 +4408,13 @@ static bool ext4_enable_dax(struct inode *inode)
> >  	return (flags & EXT4_DAX_FL) == EXT4_DAX_FL;
> >  }
> >  
> > -void ext4_set_inode_flags(struct inode *inode)
> > +void ext4_set_inode_flags(struct inode *inode, bool init)
> >  {
> >  	unsigned int flags = EXT4_I(inode)->i_flags;
> >  	unsigned int new_fl = 0;
> >  
> > +	J_ASSERT(!(IS_DAX(inode) && init));
> > +
> 
> WARN_ON or BUG_ON here? J_ASSERT is for journalling assertions...

Ah sorry, did not realize that J_ was specific.

Changed to WARN_ON_ONCE()

Ira

> 
> Otherwise the patch looks good.
> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
