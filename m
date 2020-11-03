Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554DB2A46A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgKCNeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:34:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:46550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbgKCNeE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:34:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7420ABF4;
        Tue,  3 Nov 2020 13:34:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05A7ADA7D2; Tue,  3 Nov 2020 14:32:23 +0100 (CET)
Date:   Tue, 3 Nov 2020 14:32:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 15/41] btrfs: emulate write pointer for conventional
 zones
Message-ID: <20201103133223.GY6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <af1830174f9dd9e2651dab213c0b984d90811138.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1830174f9dd9e2651dab213c0b984d90811138.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:22PM +0900, Naohiro Aota wrote:
> +	struct btrfs_key found_key;
> +	int slot;
> +	int ret;
> +	u64 length;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	search_key.objectid = cache->start + cache->length;
> +	search_key.type = 0;
> +	search_key.offset = 0;
> +
> +	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
> +	if (ret < 0)
> +		goto out;
> +	ASSERT(ret != 0);

This should be a runtime check not an assert, if this happens it's
likely a corruption

> +	slot = path->slots[0];
> +	leaf = path->nodes[0];
> +	ASSERT(slot != 0);

Same

> +	slot--;
> +	btrfs_item_key_to_cpu(leaf, &found_key, slot);
> +
> +	if (found_key.objectid < cache->start) {
> +		*offset_ret = 0;
> +	} else if (found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
> +		struct btrfs_key extent_item_key;
> +
> +		if (found_key.objectid != cache->start) {
> +			ret = -EUCLEAN;
> +			goto out;
> +		}
> +
> +		length = 0;
> +
> +		/* metadata may have METADATA_ITEM_KEY */

		/* Metadata ... */

> +		if (slot == 0) {
> +			btrfs_set_path_blocking(path);
> +			ret = btrfs_prev_leaf(root, path);
> +			if (ret < 0)
> +				goto out;
> +			if (ret == 0) {
> +				slot = btrfs_header_nritems(leaf) - 1;
> +				btrfs_item_key_to_cpu(leaf, &extent_item_key,
> +						      slot);
> +			}
> +		} else {
> +			btrfs_item_key_to_cpu(leaf, &extent_item_key, slot - 1);
> +			ret = 0;
> +		}
> +
> +		if (ret == 0 &&
> +		    extent_item_key.objectid == cache->start) {
> +			if (extent_item_key.type == BTRFS_METADATA_ITEM_KEY)

			if (...) {

> +				length = fs_info->nodesize;

			} else if (...) {

> +			else if (extent_item_key.type == BTRFS_EXTENT_ITEM_KEY)
> +				length = extent_item_key.offset;

			} else {

> +			else {
> +				ret = -EUCLEAN;
> +				goto out;
> +			}
> +		}
> +
> +		*offset_ret = length;
> +	} else if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||
> +		   found_key.type == BTRFS_METADATA_ITEM_KEY) {
> +
> +		if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
> +			length = found_key.offset;
> +		else
> +			length = fs_info->nodesize;
> +
> +		if (!(found_key.objectid >= cache->start &&
> +		       found_key.objectid + length <=
> +		       cache->start + cache->length)) {
> +			ret = -EUCLEAN;
> +			goto out;
> +		}
> +		*offset_ret = found_key.objectid + length - cache->start;
> +	} else {
> +		ret = -EUCLEAN;
> +		goto out;
> +	}
> +	ret = 0;
> +
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
>  int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_fs_info *fs_info = cache->fs_info;
> @@ -754,6 +852,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>  	int i;
>  	unsigned int nofs_flag;
>  	u64 *alloc_offsets = NULL;
> +	u64 emulated_offset = 0;
>  	u32 num_sequential = 0, num_conventional = 0;
>  
>  	if (!btrfs_is_zoned(fs_info))
> @@ -854,12 +953,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>  	}
>  
>  	if (num_conventional > 0) {
> -		/*
> -		 * Since conventional zones does not have write pointer, we
> -		 * cannot determine alloc_offset from the pointer
> -		 */
> -		ret = -EINVAL;
> -		goto out;
> +		ret = emulate_write_pointer(cache, &emulated_offset);
> +		if (ret || map->num_stripes == num_conventional) {
> +			if (!ret)
> +				cache->alloc_offset = emulated_offset;
> +			goto out;
> +		}
>  	}
>  
>  	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> @@ -881,6 +980,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>  	}
>  
>  out:
> +	/* an extent is allocated after the write pointer */

	/* An ... */

> +	if (num_conventional && emulated_offset > cache->alloc_offset) {
> +		btrfs_err(fs_info,
> +			  "got wrong write pointer in BG %llu: %llu > %llu",

		"zoned: got wrong write pointer in block group %llu found %llu emulated %llu"

> +			  logical, emulated_offset, cache->alloc_offset);
> +		ret = -EIO;
> +	}
> +
>  	kfree(alloc_offsets);
>  	free_extent_map(em);
>  
> -- 
> 2.27.0
