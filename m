Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41B427E83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfEWNov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 09:44:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730081AbfEWNov (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 09:44:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6207AAC6E;
        Thu, 23 May 2019 13:44:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 010F11E3C69; Thu, 23 May 2019 15:44:49 +0200 (CEST)
Date:   Thu, 23 May 2019 15:44:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, darrick.wong@oracle.com,
        dsterba@suse.cz, nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 12/18] btrfs: allow MAP_SYNC mmap
Message-ID: <20190523134449.GC2949@quack2.suse.cz>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-13-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-13-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 29-04-19 12:26:43, Goldwyn Rodrigues wrote:
> From: Adam Borowski <kilobyte@angband.pl>
> 
> Used by userspace to detect DAX.
> [rgoldwyn@suse.com: Added CONFIG_FS_DAX around mmap_supported_flags]

Why the CONFIG_FS_DAX bit? Your mmap(2) implementation understands
implications of MAP_SYNC flag and that's all that's needed to set
.mmap_supported_flags.

								Honza

> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 9d5a3c99a6b9..362a9cf9dcb2 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -16,6 +16,7 @@
>  #include <linux/btrfs.h>
>  #include <linux/uio.h>
>  #include <linux/iversion.h>
> +#include <linux/mman.h>
>  #include "ctree.h"
>  #include "disk-io.h"
>  #include "transaction.h"
> @@ -3319,6 +3320,9 @@ const struct file_operations btrfs_file_operations = {
>  	.splice_read	= generic_file_splice_read,
>  	.write_iter	= btrfs_file_write_iter,
>  	.mmap		= btrfs_file_mmap,
> +#ifdef CONFIG_FS_DAX
> +	.mmap_supported_flags = MAP_SYNC,
> +#endif
>  	.open		= btrfs_file_open,
>  	.release	= btrfs_release_file,
>  	.fsync		= btrfs_sync_file,
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
