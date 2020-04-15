Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C259A1A9E9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 14:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898012AbgDOL6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 07:58:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897999AbgDOL6L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:58:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A8D2AB64;
        Wed, 15 Apr 2020 11:58:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 800DE1E1250; Wed, 15 Apr 2020 13:58:07 +0200 (CEST)
Date:   Wed, 15 Apr 2020 13:58:07 +0200
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
Subject: Re: [PATCH RFC 2/8] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200415115807.GD6126@quack2.suse.cz>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414040030.1802884-3-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-04-20 21:00:24, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Verity and DAX are incompatible.  Changing the DAX mode due to a verity
> flag change is wrong without a corresponding address_space_operations
> update.
> 
> Make the 2 options mutually exclusive by returning an error if DAX was
> set first.
> 
> (Setting DAX is already disabled if Verity is set first.)
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/verity.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index dc5ec724d889..ce3f9a198d3b 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -113,6 +113,9 @@ static int ext4_begin_enable_verity(struct file *filp)
>  	handle_t *handle;
>  	int err;
>  
> +	if (WARN_ON_ONCE(IS_DAX(inode)))
> +		return -EINVAL;
> +
>  	if (ext4_verity_in_progress(inode))
>  		return -EBUSY;
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
