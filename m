Return-Path: <linux-fsdevel+bounces-5158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B03808AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E267281A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0578744388
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:37:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BA10CF;
	Thu,  7 Dec 2023 05:39:49 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SmFkT1jFdz4f3jMB;
	Thu,  7 Dec 2023 21:39:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 51BDC1A0960;
	Thu,  7 Dec 2023 21:39:46 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA4gy3FlieX6Cw--.40476S3;
	Thu, 07 Dec 2023 21:39:46 +0800 (CST)
Subject: Re: [PATCH 13/14] iomap: map multiple blocks at a time
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Chandan Babu R <chandan.babu@oracle.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 gfs2@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 linux-ext4@vger.kernel.org
References: <20231207072710.176093-1-hch@lst.de>
 <20231207072710.176093-14-hch@lst.de>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <4e4a86a0-5681-210f-0c94-263126967082@huaweicloud.com>
Date: Thu, 7 Dec 2023 21:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231207072710.176093-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgA3iA4gy3FlieX6Cw--.40476S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1UJFWfAr18XFy7Cr4fGrg_yoW5Kr1fpr
	yvkws8Crs8Jw47uFn3Aayqvr1Fkay8ZFWUtF13Ww43Zas8Jr1xKFy0g3WjvF45Gr9rGwna
	qFWFkFykW3W7A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, Christoph.

On 2023/12/7 15:27, Christoph Hellwig wrote:
> The ->map_blocks interface returns a valid range for writeback, but we
> still call back into it for every block, which is a bit inefficient.
> 
> Change iomap_writepage_map to use the valid range in the map until the
> end of the folio or the dirty range inside the folio instead of calling
> back into every block.
> 
> Note that the range is not used over folio boundaries as we need to be
> able to check the mapping sequence count under the folio lock.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 116 ++++++++++++++++++++++++++++-------------
>  include/linux/iomap.h  |   7 +++
>  2 files changed, 88 insertions(+), 35 deletions(-)
> 
[..]
> @@ -1738,29 +1775,41 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  
>  static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct folio *folio,
> -		struct inode *inode, u64 pos, unsigned *count)
> +		struct inode *inode, u64 pos, unsigned dirty_len,
> +		unsigned *count)
>  {
>  	int error;
>  
> -	error = wpc->ops->map_blocks(wpc, inode, pos);
> -	if (error)
> -		goto fail;
> -	trace_iomap_writepage_map(inode, &wpc->iomap);
> -
> -	switch (wpc->iomap.type) {
> -	case IOMAP_INLINE:
> -		WARN_ON_ONCE(1);
> -		error = -EIO;
> -		break;
> -	case IOMAP_HOLE:
> -		break;
> -	default:
> -		error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos);
> -		if (!error)
> -			(*count)++;
> -	}
> +	do {
> +		unsigned map_len;
> +
> +		error = wpc->ops->map_blocks(wpc, inode, pos);
> +		if (error)
> +			break;
> +		trace_iomap_writepage_map(inode, &wpc->iomap);
> +
> +		map_len = min_t(u64, dirty_len,
> +			wpc->iomap.offset + wpc->iomap.length - pos);
> +		WARN_ON_ONCE(!folio->private && map_len < dirty_len);

While I was debugging this series on ext4, I would suggest try to add map_len
or dirty_len into this trace point could be more convenient.

> +
> +		switch (wpc->iomap.type) {
> +		case IOMAP_INLINE:
> +			WARN_ON_ONCE(1);
> +			error = -EIO;
> +			break;
> +		case IOMAP_HOLE:
> +			break;

BTW, I want to ask an unrelated question of this patch series. Do you
agree with me to add a IOMAP_DELAYED case and re-dirty folio here? The
background is that on ext4, jbd2 thread call ext4_normal_submit_inode_data_buffers()
submit data blocks in data=ordered mode, but it can only submit mapped
blocks, now we skip unmapped blocks and re-dirty folios in
ext4_do_writepages()->mpage_prepare_extent_to_map()->..->ext4_bio_write_folio().
So we have to inherit this logic when convert to iomap, I suppose ext4's
->map_blocks() return IOMAP_DELALLOC for this case, and iomap do something
like:

+               case IOMAP_DELALLOC:
+                       iomap_set_range_dirty(folio, offset_in_folio(folio, pos),
+                                             map_len);
+                       folio_redirty_for_writepage(wbc, folio);
+                       break;

Thanks,
Yi.

> +		default:
> +			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
> +					map_len);
> +			if (!error)
> +				(*count)++;
> +			break;
> +		}
> +		dirty_len -= map_len;
> +		pos += map_len;
> +	} while (dirty_len && !error);
>  
> -fail:
>  	/*
>  	 * We cannot cancel the ioend directly here on error.  We may have
>  	 * already set other pages under writeback and hence we have to run I/O
> @@ -1827,7 +1876,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
>  		 * beyond i_size.
>  		 */
>  		folio_zero_segment(folio, poff, folio_size(folio));
> -		*end_pos = isize;
> +		*end_pos = round_up(isize, i_blocksize(inode));
>  	}
>  
>  	return true;


