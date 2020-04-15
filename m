Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE271AA072
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409886AbgDOM1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 08:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409161AbgDOLpW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:45:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79949ACD8;
        Wed, 15 Apr 2020 11:45:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5DB121E1250; Wed, 15 Apr 2020 13:45:18 +0200 (CEST)
Date:   Wed, 15 Apr 2020 13:45:18 +0200
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
Subject: Re: [PATCH RFC 1/8] fs/ext4: Narrow scope of DAX check in setflags
Message-ID: <20200415114518.GC6126@quack2.suse.cz>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414040030.1802884-2-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-04-20 21:00:23, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> When preventing DAX and journaling on an inode.  Use the effective DAX
> check rather than the mount option.
> 
> This will be required to support per inode DAX flags.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index a0ec750018dd..ee3401a32e79 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -405,9 +405,9 @@ static int ext4_ioctl_setflags(struct inode *inode,
>  	if ((jflag ^ oldflags) & (EXT4_JOURNAL_DATA_FL)) {
>  		/*
>  		 * Changes to the journaling mode can cause unsafe changes to
> -		 * S_DAX if we are using the DAX mount option.
> +		 * S_DAX if the inode is DAX
>  		 */
> -		if (test_opt(inode->i_sb, DAX)) {
> +		if (IS_DAX(inode)) {
>  			err = -EBUSY;
>  			goto flags_out;
>  		}
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
