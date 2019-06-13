Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42E9437EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbfFMPB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:01:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34053 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbfFMOd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:33:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so22805028qtu.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0BRU3dqqy6s0BgRmHroD92cvMT3xBvdMouvBj//NjQ=;
        b=jwfykhPEHp2zA3zN3PapEE5CBrYWwvoLScWqftQfoS0bkS4ZzhtLfcR8BLCo2T1iRP
         guqc2WaY0ZIWfNII5WUa9VTISaEgeDv0pXl1q+S8HkktoqGkgOtmQ32GFPxGDEjy9KFQ
         quMPLMXsjJAHTfFnLlcO76CjviArKvDOnmIKX583CCWQTOIo4Erbrd6xoRmXbVm0gJuy
         QR504cXAcuiJq6HPVPX6c5Nap3XXpS/eQaWK9iJEzxDJiARkVhPjuaYFvL919NUi7Vif
         8y1X0aicXyQ2EZ2wotUp9tOvTL/0SlmaiXbE1hjEKzmwAm9Kav6qac0Li+limHEs/d7c
         D6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0BRU3dqqy6s0BgRmHroD92cvMT3xBvdMouvBj//NjQ=;
        b=tUDbIEx121rdm3914J5IOvNMiUSG2g8+Bli1tnvTf1SChDO30IpDQTbqsSenOKOMNS
         ODv4dURpbTKZrf5YMSout8m08PwwFk5WA69xEPmJdi2eftiuxuZof2UFHXiBt3q4Ob1U
         KwDzEzP0egxGZLuswVF0uF+NABFloJvwwkBCwVNIFwfxpTng+mWL2jzpaR2ufkk4WfWs
         eUeTZBICaIQFT6TcdK2/bcKdJfrZtJ/mv3bAo41vGgJXmMe//SwQBLJ2su7cLyXqPL4I
         WzHz7vDlQsQ/BNhh8Vwy5kVMoEmuWJsZVZmdGd9smbwAfQ79c+fN5e5YPsS4RMWX0y4K
         hirw==
X-Gm-Message-State: APjAAAVcnpSXGiHX+uzcK8Iu4HivXi+NyIgTbQfIWqddMFS+AVe0XFwO
        GZToeCKh/W62LW5US55ApYWgfw==
X-Google-Smtp-Source: APXvYqxdQgoSA422ayCmjEKzjzuRUO+lo5MIbD9rb3kEteQPPipbhA3D5vzV8Xf3EefJLoWjb7pQUg==
X-Received: by 2002:ac8:2906:: with SMTP id y6mr54187982qty.138.1560436408154;
        Thu, 13 Jun 2019 07:33:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id w19sm548604qkj.66.2019.06.13.07.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:33:27 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:33:26 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 18/19] btrfs: support dev-replace in HMZONED mode
Message-ID: <20190613143325.bxcbsx5y44upgqle@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-19-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-19-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:24PM +0900, Naohiro Aota wrote:
> Currently, dev-replace copy all the device extents on source device to the
> target device, and it also clones new incoming write I/Os from users to the
> source device into the target device.
> 
> Cloning incoming IOs can break the sequential write rule in the target
> device. When write is mapped in the middle of block group, that I/O is
> directed in the middle of a zone of target device, which breaks the
> sequential write rule.
> 
> However, the cloning function cannot be simply disabled since incoming I/Os
> targeting already copied device extents must be cloned so that the I/O is
> executed on the target device.
> 
> We cannot use dev_replace->cursor_{left,right} to determine whether bio
> is going to not yet copied region.  Since we have time gap between
> finishing btrfs_scrub_dev() and rewriting the mapping tree in
> btrfs_dev_replace_finishing(), we can have newly allocated device extent
> which is never cloned (by handle_ops_on_dev_replace) nor copied (by the
> dev-replace process).
> 
> So the point is to copy only already existing device extents. This patch
> introduce mark_block_group_to_copy() to mark existing block group as a
> target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
> check the flag to do their job.
> 
> This patch also handles empty region between used extents. Since
> dev-replace is smart to copy only used extents on source device, we have to
> fill the gap to honor the sequential write rule in the target device.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/ctree.h       |   1 +
>  fs/btrfs/dev-replace.c |  96 +++++++++++++++++++++++
>  fs/btrfs/extent-tree.c |  32 +++++++-
>  fs/btrfs/scrub.c       | 169 +++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.c     |  27 ++++++-
>  5 files changed, 319 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index dad8ea5c3b99..a0be2b96117a 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -639,6 +639,7 @@ struct btrfs_block_group_cache {
>  	unsigned int has_caching_ctl:1;
>  	unsigned int removed:1;
>  	unsigned int wp_broken:1;
> +	unsigned int to_copy:1;
>  
>  	int disk_cache_state;
>  
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index fbe5ea2a04ed..5011b5ce0e75 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -263,6 +263,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  	device->dev_stats_valid = 1;
>  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>  	device->fs_devices = fs_info->fs_devices;
> +	if (bdev_is_zoned(bdev)) {
> +		ret = btrfs_get_dev_zonetypes(device);
> +		if (ret) {
> +			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> +			goto error;
> +		}
> +	}
>  	list_add(&device->dev_list, &fs_info->fs_devices->devices);
>  	fs_info->fs_devices->num_devices++;
>  	fs_info->fs_devices->open_devices++;
> @@ -396,6 +403,88 @@ static char* btrfs_dev_name(struct btrfs_device *device)
>  		return rcu_str_deref(device->name);
>  }
>  
> +static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
> +				    struct btrfs_device *src_dev)
> +{
> +	struct btrfs_path *path;
> +	struct btrfs_key key;
> +	struct btrfs_key found_key;
> +	struct btrfs_root *root = fs_info->dev_root;
> +	struct btrfs_dev_extent *dev_extent = NULL;
> +	struct btrfs_block_group_cache *cache;
> +	struct extent_buffer *l;
> +	int slot;
> +	int ret;
> +	u64 chunk_offset, length;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	path->reada = READA_FORWARD;
> +	path->search_commit_root = 1;
> +	path->skip_locking = 1;
> +
> +	key.objectid = src_dev->devid;
> +	key.offset = 0ull;
> +	key.type = BTRFS_DEV_EXTENT_KEY;
> +
> +	while (1) {
> +		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +		if (ret < 0)
> +			break;
> +		if (ret > 0) {
> +			if (path->slots[0] >=
> +			    btrfs_header_nritems(path->nodes[0])) {
> +				ret = btrfs_next_leaf(root, path);
> +				if (ret < 0)
> +					break;
> +				if (ret > 0) {
> +					ret = 0;
> +					break;
> +				}
> +			} else {
> +				ret = 0;
> +			}
> +		}
> +
> +		l = path->nodes[0];
> +		slot = path->slots[0];
> +
> +		btrfs_item_key_to_cpu(l, &found_key, slot);
> +
> +		if (found_key.objectid != src_dev->devid)
> +			break;
> +
> +		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
> +			break;
> +
> +		if (found_key.offset < key.offset)
> +			break;
> +
> +		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
> +		length = btrfs_dev_extent_length(l, dev_extent);
> +
> +		chunk_offset = btrfs_dev_extent_chunk_offset(l, dev_extent);
> +
> +		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
> +		if (!cache)
> +			goto skip;
> +
> +		cache->to_copy = 1;
> +
> +		btrfs_put_block_group(cache);
> +
> +skip:
> +		key.offset = found_key.offset + length;
> +		btrfs_release_path(path);
> +	}
> +
> +	btrfs_free_path(path);
> +
> +	return ret;
> +}
> +
>  static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
>  		const char *tgtdev_name, u64 srcdevid, const char *srcdev_name,
>  		int read_src)
> @@ -439,6 +528,13 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
>  	}
>  
>  	need_unlock = true;
> +
> +	mutex_lock(&fs_info->chunk_mutex);
> +	ret = mark_block_group_to_copy(fs_info, src_device);
> +	mutex_unlock(&fs_info->chunk_mutex);
> +	if (ret)
> +		return ret;
> +
>  	down_write(&dev_replace->rwsem);
>  	switch (dev_replace->replace_state) {
>  	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index ff4d55d6ef04..268365dd9a5d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -29,6 +29,7 @@
>  #include "qgroup.h"
>  #include "ref-verify.h"
>  #include "rcu-string.h"
> +#include "dev-replace.h"
>  
>  #undef SCRAMBLE_DELAYED_REFS
>  
> @@ -2022,7 +2023,31 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>  			if (btrfs_dev_is_sequential(stripe->dev,
>  						    stripe->physical) &&
>  			    stripe->length == stripe->dev->zone_size) {
> -				ret = blkdev_reset_zones(stripe->dev->bdev,
> +				struct btrfs_device *dev = stripe->dev;
> +
> +				ret = blkdev_reset_zones(dev->bdev,
> +							 stripe->physical >>
> +								 SECTOR_SHIFT,
> +							 stripe->length >>
> +								 SECTOR_SHIFT,
> +							 GFP_NOFS);
> +				if (!ret)
> +					discarded_bytes += stripe->length;
> +				else
> +					break;
> +				set_bit(stripe->physical >>
> +					dev->zone_size_shift,
> +					dev->empty_zones);
> +
> +				if (!btrfs_dev_replace_is_ongoing(
> +					    &fs_info->dev_replace) ||
> +				    stripe->dev != fs_info->dev_replace.srcdev)
> +					continue;
> +
> +				/* send to target as well */
> +				dev = fs_info->dev_replace.tgtdev;
> +
> +				ret = blkdev_reset_zones(dev->bdev,

This is unrelated to dev replace isn't it?  Please make this it's own patch, and
it's own helper while you are at it.  Thanks,

Josef
