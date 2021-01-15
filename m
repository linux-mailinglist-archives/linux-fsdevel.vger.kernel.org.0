Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5787E2F7390
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbhAOHPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 02:15:52 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:60732 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOHPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:15:52 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2021 02:15:49 EST
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id E32916C007D6;
        Fri, 15 Jan 2021 09:08:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1610694521; bh=GRqzfruJMHJhOS+73NqVaMpWtYx8YxcDSN1y5keLhag=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=QaQAam72yaZMt3fmkr9UHXEwWfPXatJKKEHL2GshXEutG2F7h+4jTaRgVv8jsWZLZ
         Q0vEiZZKauxN8ROBiXMyNHZJXvzyXEL3zWCLQfDkqX+OwV/SRh3RRg77LgIkyARiOv
         XKwZcJ4UfmW7Ha5dN1/8Hdjd8nZtROUu14sXiaME=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id C32666C007D2;
        Fri, 15 Jan 2021 09:08:41 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 8RqygKFhkmwG; Fri, 15 Jan 2021 09:08:41 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 2A1766C007B1;
        Fri, 15 Jan 2021 09:08:41 +0200 (EET)
Received: from nas (unknown [45.87.95.231])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 6F0921BE00B3;
        Fri, 15 Jan 2021 09:08:35 +0200 (EET)
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <e2332c7ecb8e4b1a98a769db75ceac899ab1c3c0.1608608848.git.naohiro.aota@wdc.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v11 22/40] btrfs: split ordered extent when bio is sent
In-reply-to: <e2332c7ecb8e4b1a98a769db75ceac899ab1c3c0.1608608848.git.naohiro.aota@wdc.com>
Message-ID: <eeim1xue.fsf@damenly.su>
Date:   Fri, 15 Jan 2021 15:08:25 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetdgtNzzYrL+Ds55TE3V0G3GeDUSOAe1YFVw6+mHJ0Tn2k
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Tue 22 Dec 2020 at 11:49, Naohiro Aota <naohiro.aota@wdc.com> 
wrote:

> For a zone append write, the device decides the location the 
> data is
> written to. Therefore we cannot ensure that two bios are written
> consecutively on the device. In order to ensure that a ordered 
> extent maps
> to a contiguous region on disk, we need to maintain a "one bio 
> == one
> ordered extent" rule.
>
> This commit implements the splitting of an ordered extent and 
> extent map
> on bio submission to adhere to the rule.
>
> [testbot] made extract_ordered_extent static
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/inode.c        | 89 
>  +++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/ordered-data.c | 76 
>  +++++++++++++++++++++++++++++++++++
>  fs/btrfs/ordered-data.h |  2 +
>  3 files changed, 167 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 37782b4cfd28..15e0c7714c7f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2217,6 +2217,86 @@ static blk_status_t 
> btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
>  	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
>  }
>
> +static int extract_ordered_extent(struct inode *inode, struct 
> bio *bio,
> +				  loff_t file_offset)
> +{
> +	struct btrfs_ordered_extent *ordered;
> +	struct extent_map *em = NULL, *em_new = NULL;
> +	struct extent_map_tree *em_tree = 
> &BTRFS_I(inode)->extent_tree;
> +	u64 start = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +	u64 len = bio->bi_iter.bi_size;
> +	u64 end = start + len;
> +	u64 ordered_end;
> +	u64 pre, post;
> +	int ret = 0;
> +
> +	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), 
> file_offset);
> +	if (WARN_ON_ONCE(!ordered))
> +		return -EIO;
> +
> +	/* No need to split */
> +	if (ordered->disk_num_bytes == len)
> +		goto out;
> +
> +	/* We cannot split once end_bio'd ordered extent */
> +	if (WARN_ON_ONCE(ordered->bytes_left != 
> ordered->disk_num_bytes)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* We cannot split a compressed ordered extent */
> +	if (WARN_ON_ONCE(ordered->disk_num_bytes != 
> ordered->num_bytes)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* We cannot split a waited ordered extent */
> +	if (WARN_ON_ONCE(wq_has_sleeper(&ordered->wait))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
> +	/* bio must be in one ordered extent */
> +	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > 
> ordered_end)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Checksum list should be empty */
> +	if (WARN_ON_ONCE(!list_empty(&ordered->list))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	pre = start - ordered->disk_bytenr;
> +	post = ordered_end - end;
> +
> +	btrfs_split_ordered_extent(ordered, pre, post);
> +
> +	read_lock(&em_tree->lock);
> +	em = lookup_extent_mapping(em_tree, ordered->file_offset, 
> len);
> +	if (!em) {
> +		read_unlock(&em_tree->lock);
> +		ret = -EIO;
> +		goto out;
> +	}
> +	read_unlock(&em_tree->lock);
> +
> +	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
> +	em_new = create_io_em(BTRFS_I(inode), em->start + pre, len,
> +			      em->start + pre, em->block_start + pre, len,
> +			      len, len, BTRFS_COMPRESS_NONE,
> +			      BTRFS_ORDERED_REGULAR);
>
"if (IS_ERR(em_new)) ..." is lost.


> +	free_extent_map(em_new);
> +
> +out:
> +	free_extent_map(em);
> +	btrfs_put_ordered_extent(ordered);
> +
> +	return ret;
> +}
> +
>  /*
>   * extent_io.c submission hook. This does the right thing for 
>   csum calculation
>   * on write, or reading the csums from the tree before a read.
> @@ -2252,6 +2332,15 @@ blk_status_t btrfs_submit_data_bio(struct 
> inode *inode, struct bio *bio,
>  	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
>  		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
>
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		struct page *page = bio_first_bvec_all(bio)->bv_page;
> +		loff_t file_offset = page_offset(page);
> +
> +		ret = extract_ordered_extent(inode, bio, file_offset);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
>  		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
>  		if (ret)
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 79d366a36223..4f8f48e7a482 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -898,6 +898,82 @@ void 
> btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, 
> u64 start,
>  	}
>  }
>
> +static void clone_ordered_extent(struct btrfs_ordered_extent 
> *ordered, u64 pos,
> +				 u64 len)
> +{
> +	struct inode *inode = ordered->inode;
> +	u64 file_offset = ordered->file_offset + pos;
> +	u64 disk_bytenr = ordered->disk_bytenr + pos;
> +	u64 num_bytes = len;
> +	u64 disk_num_bytes = len;
> +	int type;
> +	unsigned long flags_masked =
> +		ordered->flags & ~(1 << BTRFS_ORDERED_DIRECT);
> +	int compress_type = ordered->compress_type;
> +	unsigned long weight;
> +
> +	weight = hweight_long(flags_masked);
> +	WARN_ON_ONCE(weight > 1);
> +	if (!weight)
> +		type = 0;
> +	else
> +		type = __ffs(flags_masked);
> +
> +	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered->flags)) {
> +		WARN_ON_ONCE(1);
> +		btrfs_add_ordered_extent_compress(BTRFS_I(inode), 
> file_offset,
> +						  disk_bytenr, num_bytes,
> +						  disk_num_bytes, type,
> +						  compress_type);
> +	} else if (test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags)) {
> +		btrfs_add_ordered_extent_dio(BTRFS_I(inode), file_offset,
> +					     disk_bytenr, num_bytes,
> +					     disk_num_bytes, type);
> +	} else {
> +		btrfs_add_ordered_extent(BTRFS_I(inode), file_offset,
> +					 disk_bytenr, num_bytes, disk_num_bytes,
> +					 type);
> +	}
> +}
> +
> +void btrfs_split_ordered_extent(struct btrfs_ordered_extent 
> *ordered, u64 pre,
> +				u64 post)
> +{
> +	struct inode *inode = ordered->inode;
> +	struct btrfs_ordered_inode_tree *tree = 
> &BTRFS_I(inode)->ordered_tree;
> +	struct rb_node *node;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +
> +	spin_lock_irq(&tree->lock);
> +	/* Remove from tree once */
> +	node = &ordered->rb_node;
> +	rb_erase(node, &tree->tree);
> +	RB_CLEAR_NODE(node);
> +	if (tree->last == node)
> +		tree->last = NULL;
> +
> +	ordered->file_offset += pre;
> +	ordered->disk_bytenr += pre;
> +	ordered->num_bytes -= (pre + post);
> +	ordered->disk_num_bytes -= (pre + post);
> +	ordered->bytes_left -= (pre + post);
> +
> +	/* Re-insert the node */
> +	node = tree_insert(&tree->tree, ordered->file_offset,
> +			   &ordered->rb_node);
> +	if (node)
> +		btrfs_panic(fs_info, -EEXIST,
> +				"zoned: inconsistency in ordered tree at offset 
> %llu",
> +				ordered->file_offset);
> +
> +	spin_unlock_irq(&tree->lock);
> +
> +	if (pre)
> +		clone_ordered_extent(ordered, 0, pre);
> +	if (post)
> +		clone_ordered_extent(ordered, pre + 
> ordered->disk_num_bytes, post);
> +}
> +
>  int __init ordered_data_init(void)
>  {
>  	btrfs_ordered_extent_cache = 
>  kmem_cache_create("btrfs_ordered_extent",
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 0bfa82b58e23..f9964276f85f 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -190,6 +190,8 @@ void btrfs_wait_ordered_roots(struct 
> btrfs_fs_info *fs_info, u64 nr,
>  void btrfs_lock_and_flush_ordered_range(struct btrfs_inode 
>  *inode, u64 start,
>  					u64 end,
>  					struct extent_state **cached_state);
> +void btrfs_split_ordered_extent(struct btrfs_ordered_extent 
> *ordered, u64 pre,
> +				u64 post);
>  int __init ordered_data_init(void);
>  void __cold ordered_data_exit(void);

