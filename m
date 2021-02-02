Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8E30C2A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 15:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhBBO5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 09:57:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:37404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234082AbhBBO4v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:56:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE4C4AC41;
        Tue,  2 Feb 2021 14:56:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88D0EDA6FC; Tue,  2 Feb 2021 15:54:18 +0100 (CET)
Date:   Tue, 2 Feb 2021 15:54:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v14 32/42] btrfs: avoid async metadata checksum on ZONED
 mode
Message-ID: <20210202145418.GX1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <13728adcc4f433c928b00be73ea5466f62ccb4b9.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13728adcc4f433c928b00be73ea5466f62ccb4b9.1611627788.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 11:25:10AM +0900, Naohiro Aota wrote:
> In ZONED, btrfs uses per-FS zoned_meta_io_lock to serialize the metadata
> write IOs.
> 
> Even with these serialization, write bios sent from btree_write_cache_pages
> can be reordered by async checksum workers as these workers are per CPU and
> not per zone.
> 
> To preserve write BIO ordering, we can disable async metadata checksum on
> ZONED.  This does not result in lower performance with HDDs as a single CPU
> core is fast enough to do checksum for a single zone write stream with the
> maximum possible bandwidth of the device. If multiple zones are being
> written simultaneously, HDD seek overhead lowers the achievable maximum
> bandwidth, resulting again in a per zone checksum serialization not
> affecting performance.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/disk-io.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a41bdf9312d6..5d14100ecf72 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -814,6 +814,8 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
>  static int check_async_write(struct btrfs_fs_info *fs_info,
>  			     struct btrfs_inode *bi)
>  {
> +	if (btrfs_is_zoned(fs_info))
> +		return 0;

This check need to be after the other ones as zoned is a static per-fs
status, while other others depend on either current state or system
state (crypto implementation).

>  	if (atomic_read(&bi->sync_writers))
>  		return 0;
>  	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
> -- 
> 2.27.0
