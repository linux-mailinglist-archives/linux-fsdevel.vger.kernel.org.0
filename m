Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7126D7E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgIQJlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 05:41:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:49702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgIQJlU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:41:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6C92AFE5;
        Thu, 17 Sep 2020 09:41:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B26A41E12E1; Thu, 17 Sep 2020 11:41:13 +0200 (CEST)
Date:   Thu, 17 Sep 2020 11:41:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/12] fs: remove the unused SB_I_MULTIROOT flag
Message-ID: <20200917094113.GH7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
 <20200910144833.742260-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-09-20 16:48:21, Christoph Hellwig wrote:
> The last user of SB_I_MULTIROOT is disappeared with commit f2aedb713c28
> ("NFS: Add fs_context support.")
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Nice. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/namei.c         | 4 ++--
>  include/linux/fs.h | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index e99e2a9da0f7de..f1eb8ccd2be958 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -568,8 +568,8 @@ static bool path_connected(struct vfsmount *mnt, struct dentry *dentry)
>  {
>  	struct super_block *sb = mnt->mnt_sb;
>  
> -	/* Bind mounts and multi-root filesystems can have disconnected paths */
> -	if (!(sb->s_iflags & SB_I_MULTIROOT) && (mnt->mnt_root == sb->s_root))
> +	/* Bind mounts can have disconnected paths */
> +	if (mnt->mnt_root == sb->s_root)
>  		return true;
>  
>  	return is_subdir(dentry, mnt->mnt_root);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7519ae003a082c..fbd74df5ce5f34 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1385,7 +1385,6 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_I_CGROUPWB	0x00000001	/* cgroup-aware writeback enabled */
>  #define SB_I_NOEXEC	0x00000002	/* Ignore executables on this fs */
>  #define SB_I_NODEV	0x00000004	/* Ignore devices on this fs */
> -#define SB_I_MULTIROOT	0x00000008	/* Multiple roots to the dentry tree */
>  
>  /* sb->s_iflags to limit user namespace mounts */
>  #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
