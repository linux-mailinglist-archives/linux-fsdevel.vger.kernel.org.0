Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BFE1AA95A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636393AbgDOODP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 10:03:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633990AbgDOODL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:03:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32C50AFB4;
        Wed, 15 Apr 2020 14:03:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E8D8F1E1250; Wed, 15 Apr 2020 16:03:08 +0200 (CEST)
Date:   Wed, 15 Apr 2020 16:03:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 7/8] fs/ext4: Only change S_DAX on inode load
Message-ID: <20200415140308.GJ6126@quack2.suse.cz>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414040030.1802884-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-04-20 21:00:29, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> To prevent complications with in memory inodes we only set S_DAX on
> inode load.  FS_XFLAG_DAX can be changed at any time and S_DAX will
> change after inode eviction and reload.
> 
> Add init bool to ext4_set_inode_flags() to indicate if the inode is
> being newly initialized.
> 
> Assert that S_DAX is not set on an inode which is just being loaded.

> @@ -4408,11 +4408,13 @@ static bool ext4_enable_dax(struct inode *inode)
>  	return (flags & EXT4_DAX_FL) == EXT4_DAX_FL;
>  }
>  
> -void ext4_set_inode_flags(struct inode *inode)
> +void ext4_set_inode_flags(struct inode *inode, bool init)
>  {
>  	unsigned int flags = EXT4_I(inode)->i_flags;
>  	unsigned int new_fl = 0;
>  
> +	J_ASSERT(!(IS_DAX(inode) && init));
> +

WARN_ON or BUG_ON here? J_ASSERT is for journalling assertions...

Otherwise the patch looks good.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
