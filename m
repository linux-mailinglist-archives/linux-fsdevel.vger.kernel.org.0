Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA52C1B5A3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgDWLQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 07:16:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgDWLQj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:16:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5D67B080;
        Thu, 23 Apr 2020 11:16:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C274F1E1293; Thu, 23 Apr 2020 13:16:36 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:16:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/5] ext4: Fix EXT4_MAX_LOGICAL_BLOCK macro
Message-ID: <20200423111636.GH3737@quack2.suse.cz>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <e31dbabc453d1f227371bed6e0cc2f3493b4955f.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31dbabc453d1f227371bed6e0cc2f3493b4955f.1587555962.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-04-20 16:17:53, Ritesh Harjani wrote:
> ext4 supports max number of logical blocks in a file to be 0xffffffff.
> (This is since ext4_extent's ee_block is __le32).
> This means that EXT4_MAX_LOGICAL_BLOCK should be 0xfffffffe (starting
> from 0 logical offset). This patch fixes this.
> 
> The issue was seen when ext4 moved to iomap_fiemap API and when
> overlayfs was mounted on top of ext4. Since overlayfs was missing
> filemap_check_ranges(), so it could pass a arbitrary huge length which
> lead to overflow of map.m_len logic.
> 
> This patch fixes that.
> 
> Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
> Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/ext4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 91eb4381cae5..ad2dbf6e4924 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -722,7 +722,7 @@ enum {
>  #define EXT4_MAX_BLOCK_FILE_PHYS	0xFFFFFFFF
>  
>  /* Max logical block we can support */
> -#define EXT4_MAX_LOGICAL_BLOCK		0xFFFFFFFF
> +#define EXT4_MAX_LOGICAL_BLOCK		0xFFFFFFFE
>  
>  /*
>   * Structure of an inode on the disk
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
