Return-Path: <linux-fsdevel+bounces-60891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD3FB5289F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 08:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5E4560CB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E1A25A631;
	Thu, 11 Sep 2025 06:17:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B922580E4;
	Thu, 11 Sep 2025 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571426; cv=none; b=YddX+1ALLW6nI9iG71uv5FBqmaT0Ss0fNMdzYxKMcgDAiGhxdVltwvjasJMuJ5u/U3aTIQzAXEO6obJ+1TBS6lNTnwFphd1PBO5MWQtuxS4B2hLg0e8BoZy2SygRvrIv1EYqroKUw+lfbZaaf/7sh9BUIWSyonVGdw0IHb6Nw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571426; c=relaxed/simple;
	bh=nAaxTbC+nVd63wqm557gb2wVaWSR827hvPA4Li4sf1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOE8J23bJfaEiM+1wTloOVP/lYiuRhfhz4eTC5PYlAMezh4ExDNcG9H8X36DYbuHyYjBGiXz8HofKV1FgjiOIu2M2I6NUL2r6WSpDM6/JRhwNRl3BLK4Y+ixuze0UPgclM6A+JfKbA9zsGOSNgk9waKt7kXD4S7hOU3RL+37OhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cMnQN0GS2zKHN82;
	Thu, 11 Sep 2025 14:17:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 503B61A1692;
	Thu, 11 Sep 2025 14:17:00 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5ZacJodcd5CA--.12821S3;
	Thu, 11 Sep 2025 14:16:59 +0800 (CST)
Message-ID: <8d1ee18e-6bf4-423b-b046-16a5d55a7030@huaweicloud.com>
Date: Thu, 11 Sep 2025 14:16:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ext4: increase i_disksize to offset + len in
 ext4_update_disksize_before_punch()
To: sunyongjian1@huawei.com, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
 yangerkun@huawei.com, libaokun1@huawei.com, chengzhihao1@huawei.com
References: <20250911025412.186872-1-sunyongjian@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250911025412.186872-1-sunyongjian@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY5ZacJodcd5CA--.12821S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrXr1UZFW3XFW5Jw1fJFb_yoWrCryfpr
	W5Ga4UKr4jq34kCanag3Wjq3W0ya15JrWxGFy3Ww4Yvr9rAwn2gF1vgFyY9a1DJrs3Ar4q
	qF4YqrsF934UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 9/11/2025 10:54 AM, Yongjian Sun wrote:
> From: Yongjian Sun <sunyongjian1@huawei.com>
> 
> After running a stress test combined with fault injection,
> we performed fsck -a followed by fsck -fn on the filesystem
> image. During the second pass, fsck -fn reported:
> 
> Inode 131512, end of extent exceeds allowed value
> 	(logical block 405, physical block 1180540, len 2)
> 
> This inode was not in the orphan list. Analysis revealed the
> following call chain that leads to the inconsistency:
> 
>                              ext4_da_write_end()
>                               //does not update i_disksize
>                              ext4_punch_hole()
>                               //truncate folio, keep size
> ext4_page_mkwrite()
>  ext4_block_page_mkwrite()
>   ext4_block_write_begin()
>     ext4_get_block()
>      //insert written extent without update i_disksize
> journal commit
> echo 1 > /sys/block/xxx/device/delete
> 
> da-write path updates i_size but does not update i_disksize. Then
> ext4_punch_hole truncates the da-folio yet still leaves i_disksize
> unchanged(in the ext4_update_disksize_before_punch function, the
> condition offset + len < size is met). Then ext4_page_mkwrite sees
> ext4_nonda_switch return 1 and takes the nodioread_nolock path, the
> folio about to be written has just been punched out, and it’s offset
> sits beyond the current i_disksize. This may result in a written
> extent being inserted, but again does not update i_disksize. If the
> journal gets committed and then the block device is yanked, we might
> run into this. It should be noted that replacing ext4_punch_hole with
> ext4_zero_range in the call sequence may also trigger this issue, as
> neither will update i_disksize under these circumstances.
> 
> To fix this, we can modify ext4_update_disksize_before_punch to
> increase i_disksize to min(offset + len) when both i_size and
> (offset + len) are greater than i_disksize.
> 
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>

Looks good to me, and feel free to add:

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

BTW, since Jan has no other review comments and has allowed you to
add his review tag after improving the language, you can also add his
review tag when sending this version.

Thanks,
Yi.

> ---
> Changes in v4:
> - Make the comments simpler and clearer.
> - Link to v3: https://lore.kernel.org/all/20250910042516.3947590-1-sunyongjian@huaweicloud.com/
> Changes in v3:
> - Add a condition to avoid increasing i_disksize and include some comments.
> - Link to v2: https://lore.kernel.org/all/20250908063355.3149491-1-sunyongjian@huaweicloud.com/
> Changes in v2:
> - The modification of i_disksize should be moved into ext4_update_disksize_before_punch,
>   rather than being done in ext4_page_mkwrite.
> - Link to v1: https://lore.kernel.org/all/20250731140528.1554917-1-sunyongjian@huaweicloud.com/
> ---
>  fs/ext4/inode.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..f82f7fb84e17 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4287,7 +4287,11 @@ int ext4_can_truncate(struct inode *inode)
>   * We have to make sure i_disksize gets properly updated before we truncate
>   * page cache due to hole punching or zero range. Otherwise i_disksize update
>   * can get lost as it may have been postponed to submission of writeback but
> - * that will never happen after we truncate page cache.
> + * that will never happen if we remove the folio containing i_size from the
> + * page cache. Also if we punch hole within i_size but above i_disksize,
> + * following ext4_page_mkwrite() may mistakenly allocate written blocks over
> + * the hole and thus introduce allocated blocks beyond i_disksize which is
> + * not allowed (e2fsck would complain in case of crash).
>   */
>  int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>  				      loff_t len)
> @@ -4298,9 +4302,11 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>  	loff_t size = i_size_read(inode);
>  
>  	WARN_ON(!inode_is_locked(inode));
> -	if (offset > size || offset + len < size)
> +	if (offset > size)
>  		return 0;
>  
> +	if (offset + len < size)
> +		size = offset + len;
>  	if (EXT4_I(inode)->i_disksize >= size)
>  		return 0;
>  


