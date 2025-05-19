Return-Path: <linux-fsdevel+bounces-49325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3CBABB372
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 04:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF081749C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 02:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1856D1DBB13;
	Mon, 19 May 2025 02:48:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6713AA20;
	Mon, 19 May 2025 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622919; cv=none; b=HH/37S21QcY0KjI9ylDI5wj7nic1vyBXh7BrqJbYSduV5uzGHaS8Ax+NCMPSB5OW3zTxZydDHL/ScKuB34D4yCqshSkjigL605XYIq57Uq1jaOXVL/wKSIu67HNQUNR1y4b9qGiNoNS8F1JuYqG9B//BLu8McMfvKsc25vjXmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622919; c=relaxed/simple;
	bh=mUL/ZZ3rsvI1Ffg4jQr5dzjyOi46UH6tDEvpyrnBYUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KK7PYQdvkg2c6jgJPp7ARyDKLlV3kd2RN/usn8D0yCBhAJNK3YFfFz2B6FgB0w60PvlGVV2cgDRe4vcGtgTpNm+EFgVS/qDBscwOLLv8uzwF7np77TyOJmmja1VdMUE4LUIeELaRZ5Ss+caKOzi+KewtGCpQLUuTrn/M9HCvj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b12Dw6Dk1zYQtsn;
	Mon, 19 May 2025 10:48:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 183121A1C19;
	Mon, 19 May 2025 10:48:32 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXul78mypoXqlaMw--.27476S3;
	Mon, 19 May 2025 10:48:30 +0800 (CST)
Message-ID: <2e127ed8-20a2-4610-8fd8-e2095bde0577@huaweicloud.com>
Date: Mon, 19 May 2025 10:48:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] ext4: correct the journal credits calculations of
 allocating blocks
To: tytso@mit.edu, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, adilger.kernel@dilger.ca, jack@suse.cz,
 yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-6-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250512063319.3539411-6-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXul78mypoXqlaMw--.27476S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy7GrWkGw1fWw1xuF1Utrb_yoWrXrW5pF
	nxCF1rKr18Xw1UuFWIga1UZr18Wa1xGa13ur4rJr45XF98XryxKrn5t3WrCFyYqFZ3Aw4j
	vF4rK347G3W3A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi Ted.

On 2025/5/12 14:33, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The journal credits calculation in ext4_ext_index_trans_blocks() is
> currently inadequate. It only multiplies the depth of the extents tree
> and doesn't account for the blocks that may be required for adding the
> leaf extents themselves.
> 
> After enabling large folios, we can easily run out of handle credits,
> triggering a warning in jbd2_journal_dirty_metadata() on filesystems
> with a 1KB block size. This occurs because we may need more extents when
> iterating through each large folio in
> ext4_do_writepages()->mpage_map_and_submit_extent(). Therefore, we
> should modify ext4_ext_index_trans_blocks() to include a count of the
> leaf extents in the worst case as well.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/extents.c |  5 +++--
>  fs/ext4/inode.c   | 10 ++++------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c616a16a9f36..e759941bd262 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2405,9 +2405,10 @@ int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
>  	depth = ext_depth(inode);
>  
>  	if (extents <= 1)
> -		index = depth * 2;
> +		index = depth * 2 + extents;
>  	else
> -		index = depth * 3;
> +		index = depth * 3 +
> +			DIV_ROUND_UP(extents, ext4_ext_space_block(inode, 0));
>  
>  	return index;
>  }

This patch conflicts with Jan's patch e18d4f11d240 ("ext4: fix
calculation of credits for extent tree modification") in
ext4_ext_index_trans_blocks(), the conflict should be resolved when
merging this patch. However, I checked the merged commit of this patch
in your dev branch[1], and the changes in ext4_ext_index_trans_blocks()
seem to be incorrect, which could result in insufficient credit
reservations on 1K block size filesystems.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=d80af138eb8873eb13f5fece1adabb3ca4325134

I think the correct conflict resolution in ext4_ext_index_trans_blocks()
should be:

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9053fe68ee4c..431d66181721 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2409,9 +2409,10 @@ int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
         * the time we actually modify the tree. Assume the worst case.
         */
        if (extents <= 1)
-               index = EXT4_MAX_EXTENT_DEPTH * 2;
+               index = EXT4_MAX_EXTENT_DEPTH * 2 + extents;
        else
-               index = EXT4_MAX_EXTENT_DEPTH * 3;
+               index = EXT4_MAX_EXTENT_DEPTH * 3 +
+                       DIV_ROUND_UP(extents, ext4_ext_space_block(inode, 0));

        return index;

Best Regards,
Yi.


> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ffbf444b56d4..3e962a760d71 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5792,18 +5792,16 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
>  	int ret;
>  
>  	/*
> -	 * How many index blocks need to touch to map @lblocks logical blocks
> -	 * to @pextents physical extents?
> +	 * How many index and lead blocks need to touch to map @lblocks
> +	 * logical blocks to @pextents physical extents?
>  	 */
>  	idxblocks = ext4_index_trans_blocks(inode, lblocks, pextents);
>  
> -	ret = idxblocks;
> -
>  	/*
>  	 * Now let's see how many group bitmaps and group descriptors need
>  	 * to account
>  	 */
> -	groups = idxblocks + pextents;
> +	groups = idxblocks;
>  	gdpblocks = groups;
>  	if (groups > ngroups)
>  		groups = ngroups;
> @@ -5811,7 +5809,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
>  		gdpblocks = EXT4_SB(inode->i_sb)->s_gdb_count;
>  
>  	/* bitmaps and block group descriptor blocks */
> -	ret += groups + gdpblocks;
> +	ret = idxblocks + groups + gdpblocks;
>  
>  	/* Blocks for super block, inode, quota and xattr blocks */
>  	ret += EXT4_META_TRANS_BLOCKS(inode->i_sb);


