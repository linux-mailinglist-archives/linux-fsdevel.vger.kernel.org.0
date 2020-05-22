Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A31DE16A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 09:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgEVH6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 03:58:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:48506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgEVH6W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 03:58:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E296BBA0;
        Fri, 22 May 2020 07:58:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 997881E126B; Fri, 22 May 2020 09:58:19 +0200 (CEST)
Date:   Fri, 22 May 2020 09:58:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/8] fs/ext4: Narrow scope of DAX check in setflags
Message-ID: <20200522075819.GA14199@quack2.suse.cz>
References: <20200521191313.261929-1-ira.weiny@intel.com>
 <20200521191313.261929-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521191313.261929-2-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-05-20 12:13:06, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> When preventing DAX and journaling on an inode.  Use the effective DAX
> check rather than the mount option.
> 
> This will be required to support per inode DAX flags.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
...
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index bfc1281fc4cb..5813e5e73eab 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -393,9 +393,9 @@ static int ext4_ioctl_setflags(struct inode *inode,
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

Now one problem popped up in my mind: We should also make EXT4_JOURNAL_DATA_FL
and EXT4_DAX_FL exclusive so that both cannot be turned on at the same
time. And IS_DAX() check isn't enough for that. Sorry for not noticing
earlier... it's like peeling an onion...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
