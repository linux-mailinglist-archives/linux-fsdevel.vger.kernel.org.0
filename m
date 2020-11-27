Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A362C6BB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 19:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgK0SsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 13:48:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:56176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgK0SrZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:47:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 056F6AC0C;
        Fri, 27 Nov 2020 18:46:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A1CF7DA7D9; Fri, 27 Nov 2020 19:44:39 +0100 (CET)
Date:   Fri, 27 Nov 2020 19:44:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 05/41] btrfs: check and enable ZONED mode
Message-ID: <20201127184439.GB6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 07:29:20PM +0800, Anand Jain wrote:
> On 10/11/20 7:26 pm, Naohiro Aota wrote:
> > This commit introduces the function btrfs_check_zoned_mode() to check if
> > ZONED flag is enabled on the file system and if the file system consists of
> > zoned devices with equal zone size.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   fs/btrfs/ctree.h       | 11 ++++++
> >   fs/btrfs/dev-replace.c |  7 ++++
> >   fs/btrfs/disk-io.c     | 11 ++++++
> >   fs/btrfs/super.c       |  1 +
> >   fs/btrfs/volumes.c     |  5 +++
> >   fs/btrfs/zoned.c       | 81 ++++++++++++++++++++++++++++++++++++++++++
> >   fs/btrfs/zoned.h       | 26 ++++++++++++++
> >   7 files changed, 142 insertions(+)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index aac3d6f4e35b..453f41ca024e 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -948,6 +948,12 @@ struct btrfs_fs_info {
> >   	/* Type of exclusive operation running */
> >   	unsigned long exclusive_operation;
> >   
> > +	/* Zone size when in ZONED mode */
> > +	union {
> > +		u64 zone_size;
> > +		u64 zoned;
> > +	};
> > +
> >   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
> >   	spinlock_t ref_verify_lock;
> >   	struct rb_root block_tree;
> > @@ -3595,4 +3601,9 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
> >   }
> >   #endif
> >   
> > +static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)
> > +{
> > +	return fs_info->zoned != 0;
> > +}
> > +
> >   #endif
> > diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> > index 6f6d77224c2b..db87f1aa604b 100644
> > --- a/fs/btrfs/dev-replace.c
> > +++ b/fs/btrfs/dev-replace.c
> > @@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
> >   		return PTR_ERR(bdev);
> >   	}
> >   
> > +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
> > +		btrfs_err(fs_info,
> > +			  "dev-replace: zoned type of target device mismatch with filesystem");
> > +		ret = -EINVAL;
> > +		goto error;
> > +	}
> > +
> >   	sync_blockdev(bdev);
> >   
> >   	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
> 
>   I am not sure if it is done in some other patch. But we still have to
>   check for
> 
>   (model == BLK_ZONED_HA && incompat_zoned))

Do you really mean BLK_ZONED_HA, ie. host-aware (HA)?
btrfs_check_device_zone_type checks for _HM.

> right? What if in a non-zoned FS, a zoned device is added through the
> replace. No?

The types of devices cannot mix, yeah. So I'd like to know the answer as
well.

> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -2518,6 +2518,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >   	if (IS_ERR(bdev))
> >   		return PTR_ERR(bdev);
> >   
> > +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
> > +		ret = -EINVAL;
> > +		goto error;
> > +	}
> > +
> >   	if (fs_devices->seeding) {
> >   		seeding_dev = 1;
> >   		down_write(&sb->s_umount);
> 
> Same here too. It can also happen that a zone device is added to a non 
> zoned fs.
