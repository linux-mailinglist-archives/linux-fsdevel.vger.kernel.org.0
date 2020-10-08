Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422FC2879A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgJHQE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 12:04:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:44214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgJHQE0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:04:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 064D4AC85;
        Thu,  8 Oct 2020 16:04:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A3C181E1305; Thu,  8 Oct 2020 18:04:24 +0200 (CEST)
Date:   Thu, 8 Oct 2020 18:04:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jack@suse.cz, anju@linux.vnet.ibm.com,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/1] ext4: Fix bs < ps issue reported with dioread_nolock
 mount opt
Message-ID: <20201008160424.GA14976@quack2.suse.cz>
References: <af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 08-10-20 20:32:48, Ritesh Harjani wrote:
> left shifting m_lblk by blkbits was causing value overflow and hence
> it was not able to convert unwritten to written extent.
> So, make sure we typecast it to loff_t before do left shift operation.
> Also in func ext4_convert_unwritten_io_end_vec(), make sure to initialize
> ret variable to avoid accidentally returning an uninitialized ret.
> 
> This patch fixes the issue reported in ext4 for bs < ps with
> dioread_nolock mount option.
> 
> Fixes: c8cc88163f40df39e50c ("ext4: Add support for blocksize < pagesize in dioread_nolock")
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Ah, good spotting! The patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 2 +-
>  fs/ext4/inode.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a0481582187a..32d610cc896d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4769,7 +4769,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
>  
>  int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
>  {
> -	int ret, err = 0;
> +	int ret = 0, err = 0;
>  	struct ext4_io_end_vec *io_end_vec;
>  
>  	/*
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf596467c234..3021235deaa1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2254,7 +2254,7 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
>  					err = PTR_ERR(io_end_vec);
>  					goto out;
>  				}
> -				io_end_vec->offset = mpd->map.m_lblk << blkbits;
> +				io_end_vec->offset = (loff_t)mpd->map.m_lblk << blkbits;
>  			}
>  			*map_bh = true;
>  			goto out;
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
