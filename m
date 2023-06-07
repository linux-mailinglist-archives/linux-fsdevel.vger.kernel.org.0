Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F156725B94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 12:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjFGK1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 06:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjFGK1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:27:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3627019AE;
        Wed,  7 Jun 2023 03:27:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b04949e5baso63006915ad.0;
        Wed, 07 Jun 2023 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686133638; x=1688725638;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Igad760DDxLTmZ4o+xA+cDylEfb2RuWnbViymTyglto=;
        b=UU0PEfbDdglX8cvxGFRM7XJMzQ71Ew7ZKxT4bukuDRiC0ogcjkuxnL/EUsZuiI23oE
         +x6EWTDffr2t1nJgRhG0gubKsz/FwLi2vm9XmLV/EIWtn1MnKCP4mLPJsvxkLK+nUenu
         FNQPGlO4ZymP8uQ2mBT73ruM42NaX7lEdWoTf8NlHuoFG4zuIYapncdCumOSghTqxTGm
         z9CCqvCzPB8AXrrdj9zv6qeJxl+w1xqK5+PS1+yvWHhItUoouU9TrInNn4zah2HfQWco
         uYjssrbA0GfWdPhCGK2xIOoGXUpkyWjmkz5utVQDenYWGbMgZRpsxIu1N6LVG84tg/Xu
         bsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686133638; x=1688725638;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Igad760DDxLTmZ4o+xA+cDylEfb2RuWnbViymTyglto=;
        b=d23cY3Uo8jJA64P/dpagavoSWP6VgdOs1Bvc3GwBNpuHJ20AIjS62gXeA2pd1EXXcG
         BgtAhc34RdG4unIR68+vZyM1Kn+V6uSjAGHMLJ5UAmWEs1LHenNA1jXiQUIKQK0/EdQp
         P1oeSeQ3yjaWo9KAS//4XJFYhKqrXS8Ohji3V8C+6jxSJwBZY2wuAxRATsb4ib1Ag8Xb
         4NkJFI2af/hmIOMHR9LzOev6d+6scPKnVQqi1ToFEC1PcMR4/1cl8hbYVDRTkYAyIukt
         /TMlfpUqGj6xAURJHXA/s6RzZOjBBRbTGx5Ciw95RmDqT7TPJbMqOUhTvN67f34z+sv9
         Zkfw==
X-Gm-Message-State: AC+VfDxfNUcwcPuMK0LGQswYgb2V9eJZlOzUeV9gH1Ryu/MDLSoAkctg
        WAL23taIquKCOcUQXDgfzgQ=
X-Google-Smtp-Source: ACHHUZ7hvJul12Neuud3+uwk706quFDSO5ovDiN+g/mbIf9EcvvgRpVbvQ0usO0TOSVjrRvhSY/qxg==
X-Received: by 2002:a17:903:248:b0:1af:a349:3f0d with SMTP id j8-20020a170903024800b001afa3493f0dmr5935724plh.23.1686133638442;
        Wed, 07 Jun 2023 03:27:18 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b001b045c9ababsm10082854pll.264.2023.06.07.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:27:17 -0700 (PDT)
Date:   Wed, 07 Jun 2023 15:57:13 +0530
Message-Id: <873533k1oe.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv8 5/5] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <20230606150636.GL1325469@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Tue, Jun 06, 2023 at 05:13:52PM +0530, Ritesh Harjani (IBM) wrote:
>> When filesystem blocksize is less than folio size (either with
>> mapping_large_folio_support() or with blocksize < pagesize) and when the
>> folio is uptodate in pagecache, then even a byte write can cause
>> an entire folio to be written to disk during writeback. This happens
>> because we currently don't have a mechanism to track per-block dirty
>> state within struct iomap_folio. We currently only track uptodate state.
>>
>> This patch implements support for tracking per-block dirty state in
>> iomap_folio->state bitmap. This should help improve the filesystem write
>> performance and help reduce write amplification.
>>
>> Performance testing of below fio workload reveals ~16x performance
>> improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
>> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
>>
>> 1. <test_randwrite.fio>
>> [global]
>> 	ioengine=psync
>> 	rw=randwrite
>> 	overwrite=1
>> 	pre_read=1
>> 	direct=0
>> 	bs=4k
>> 	size=1G
>> 	dir=./
>> 	numjobs=8
>> 	fdatasync=1
>> 	runtime=60
>> 	iodepth=64
>> 	group_reporting=1
>>
>> [fio-run]
>>
>> 2. Also our internal performance team reported that this patch improves
>>    their database workload performance by around ~83% (with XFS on Power)
>>
>> Reported-by: Aravinda Herle <araherle@in.ibm.com>
>> Reported-by: Brian Foster <bfoster@redhat.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/gfs2/aops.c         |   2 +-
>>  fs/iomap/buffered-io.c | 126 +++++++++++++++++++++++++++++++++++++++--
>>  fs/xfs/xfs_aops.c      |   2 +-
>>  fs/zonefs/file.c       |   2 +-
>>  include/linux/iomap.h  |   1 +
>>  5 files changed, 126 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
>> index a5f4be6b9213..75efec3c3b71 100644
>> --- a/fs/gfs2/aops.c
>> +++ b/fs/gfs2/aops.c
>> @@ -746,7 +746,7 @@ static const struct address_space_operations gfs2_aops = {
>>  	.writepages = gfs2_writepages,
>>  	.read_folio = gfs2_read_folio,
>>  	.readahead = gfs2_readahead,
>> -	.dirty_folio = filemap_dirty_folio,
>> +	.dirty_folio = iomap_dirty_folio,
>>  	.release_folio = iomap_release_folio,
>>  	.invalidate_folio = iomap_invalidate_folio,
>>  	.bmap = gfs2_bmap,
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 2b72ca3ba37a..b99d611f1cd5 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -84,6 +84,70 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>>  		folio_mark_uptodate(folio);
>>  }
>>
>> +static inline bool iomap_iof_is_block_dirty(struct folio *folio,
>> +			struct iomap_folio *iof, int block)
>> +{
>> +	struct inode *inode = folio->mapping->host;
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +
>> +	return test_bit(block + blks_per_folio, iof->state);
>> +}
>> +
>> +static void iomap_iof_clear_range_dirty(struct folio *folio,
>> +			struct iomap_folio *iof, size_t off, size_t len)
>> +{
>> +	struct inode *inode = folio->mapping->host;
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int first_blk = off >> inode->i_blkbits;
>> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&iof->state_lock, flags);
>> +	bitmap_clear(iof->state, first_blk + blks_per_folio, nr_blks);
>> +	spin_unlock_irqrestore(&iof->state_lock, flags);
>> +}
>> +
>> +static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
>> +{
>> +	struct iomap_folio *iof = iomap_get_iof(folio);
>> +
>> +	if (!iof)
>> +		return;
>> +	iomap_iof_clear_range_dirty(folio, iof, off, len);
>> +}
>> +
>> +static void iomap_iof_set_range_dirty(struct inode *inode, struct folio *folio,
>> +			struct iomap_folio *iof, size_t off, size_t len)
>> +{
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int first_blk = off >> inode->i_blkbits;
>> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&iof->state_lock, flags);
>> +	bitmap_set(iof->state, first_blk + blks_per_folio, nr_blks);
>> +	spin_unlock_irqrestore(&iof->state_lock, flags);
>> +}
>> +
>> +/*
>> + * The reason we pass inode explicitly here is to avoid any race with truncate
>> + * when iomap_set_range_dirty() gets called from iomap_dirty_folio().
>> + * Check filemap_dirty_folio() & __folio_mark_dirty() for more details.
>> + * Hence we explicitly pass mapping->host to iomap_set_range_dirty() from
>> + * iomap_dirty_folio().
>> + */
>> +static void iomap_set_range_dirty(struct inode *inode, struct folio *folio,
>> +				  size_t off, size_t len)
>> +{
>> +	struct iomap_folio *iof = iomap_get_iof(folio);
>> +
>> +	if (!iof)
>> +		return;
>> +	iomap_iof_set_range_dirty(inode, folio, iof, off, len);
>> +}
>> +
>>  static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
>>  				struct folio *folio, unsigned int flags)
>>  {
>> @@ -99,12 +163,20 @@ static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
>>  	else
>>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>>
>> -	iof = kzalloc(struct_size(iof, state, BITS_TO_LONGS(nr_blocks)),
>> +	/*
>> +	 * iof->state tracks two sets of state flags when the
>> +	 * filesystem block size is smaller than the folio size.
>> +	 * The first state tracks per-block uptodate and the
>> +	 * second tracks per-block dirty state.
>> +	 */
>> +	iof = kzalloc(struct_size(iof, state, BITS_TO_LONGS(2 * nr_blocks)),
>>  		      gfp);
>>  	if (iof) {
>>  		spin_lock_init(&iof->state_lock);
>>  		if (folio_test_uptodate(folio))
>> -			bitmap_fill(iof->state, nr_blocks);
>> +			bitmap_set(iof->state, 0, nr_blocks);
>> +		if (folio_test_dirty(folio))
>> +			bitmap_set(iof->state, nr_blocks, nr_blocks);
>>  		folio_attach_private(folio, iof);
>>  	}
>>  	return iof;
>> @@ -529,6 +601,17 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
>>  }
>>  EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
>>
>> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
>> +{
>> +	struct inode *inode = mapping->host;
>> +	size_t len = folio_size(folio);
>> +
>> +	iomap_iof_alloc(inode, folio, 0);
>> +	iomap_set_range_dirty(inode, folio, 0, len);
>> +	return filemap_dirty_folio(mapping, folio);
>> +}
>> +EXPORT_SYMBOL_GPL(iomap_dirty_folio);
>> +
>>  static void
>>  iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>>  {
>> @@ -733,6 +816,8 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>>  		return 0;
>>  	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
>> +	iomap_set_range_dirty(inode, folio, offset_in_folio(folio, pos),
>> +			      copied);
>>  	filemap_dirty_folio(inode->i_mapping, folio);
>>  	return copied;
>>  }
>> @@ -902,6 +987,10 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>>  		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
>>  {
>>  	int ret = 0;
>> +	struct iomap_folio *iof;
>> +	unsigned int first_blk, last_blk, i;
>> +	loff_t last_byte;
>> +	u8 blkbits = inode->i_blkbits;
>>
>>  	if (!folio_test_dirty(folio))
>>  		return ret;
>> @@ -913,6 +1002,29 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>>  		if (ret)
>>  			goto out;
>>  	}
>> +	/*
>> +	 * When we have per-block dirty tracking, there can be
>> +	 * blocks within a folio which are marked uptodate
>> +	 * but not dirty. In that case it is necessary to punch
>> +	 * out such blocks to avoid leaking any delalloc blocks.
>> +	 */
>> +	iof = iomap_get_iof(folio);
>> +	if (!iof)
>> +		goto skip_iof_punch;
>> +
>> +	last_byte = min_t(loff_t, end_byte - 1,
>> +		(folio_next_index(folio) << PAGE_SHIFT) - 1);
>> +	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
>> +	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
>> +	for (i = first_blk; i <= last_blk; i++) {
>> +		if (!iomap_iof_is_block_dirty(folio, iof, i)) {
>> +			ret = punch(inode, i << blkbits, 1 << blkbits);
>
> Isn't the second argument to punch() supposed to be the offset within
> the file, not the offset within the folio?
>

Thanks for spotting this. Somehow got missed.
Yes, it should be byte position within file. Will fix in the next rev.

    punch(inode, folio_pos(folio) + (i << blkbits), 1 << blkbits);

> I /almost/ wonder if this chunk should be its own static inline
> iomap_iof_delalloc_punch function, but ... eh.  My enthusiasm for
> slicing and dicing is weak today.
>

umm, I felt having all punch logic in one function would be better.
Hence iomap_write_delalloc_punch().

-ritesh
