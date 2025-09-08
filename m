Return-Path: <linux-fsdevel+bounces-60480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA6DB4862C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B9916285C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF91A2E7BCC;
	Mon,  8 Sep 2025 07:58:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F549443;
	Mon,  8 Sep 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318320; cv=none; b=OxbAonuQFdVbbmqNZkT4WM6XJFdR/hV8By01XiCyAhFAHnAMnRxz9GC+mOA/4PbG1Dj6yl354vHARs3yQHGCTJ/9fcgdDudlLiMdIBkQjfW+u/TIXIjUUt2jerFHjIPf4OU9TBLU48hu2hM0HNJs35CO7A7+dIv2OMuYE0+a5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318320; c=relaxed/simple;
	bh=PKqnTs1+PmTX+I9bAfCbUFEjPeLlkzprqYlYJfuTyPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYbGZwwr4g3b89SO6mO0NmeAlMUNzp/fDO3PRaw+rxkGJ7tWp96AVZH3PPb4/ip3YmTAWv89dBGEK56yMz6ZrVACIIVWgR1e4CazXbMWK4vxZEkMevz/qSK010NfR3qgh5VFqd2OOfkTPFfbDwjqZ1oNlqN8KyvS7fJkS86WTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cKzpy2W68zKHMsp;
	Mon,  8 Sep 2025 15:58:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7229A1A1125;
	Mon,  8 Sep 2025 15:58:34 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY2mjL5oUOoqBw--.63170S3;
	Mon, 08 Sep 2025 15:58:32 +0800 (CST)
Message-ID: <ce8aab6c-fcea-4692-ad75-e51fa9448276@huaweicloud.com>
Date: Mon, 8 Sep 2025 15:58:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: increase i_disksize to offset + len in
 ext4_update_disksize_before_punch()
To: sunyongjian1@huawei.com, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
 yangerkun@huawei.com, libaokun1@huawei.com, chengzhihao1@huawei.com
References: <20250908063355.3149491-1-sunyongjian@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250908063355.3149491-1-sunyongjian@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY2mjL5oUOoqBw--.63170S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrXr1UZFW3XFW5Jw1fJFb_yoW5trWfp3
	yYkF1Utwn0ga4Dua1SgF4jqrWjva15Jr47GFy7GrWYqrW5Aws2qF18KFySga1kJrs3ur4j
	qF4YqrsrX348Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 9/8/2025 2:33 PM, Yongjian Sun wrote:
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
> To fix this, we can modify ext4_update_disksize_before_punch to always
> increase i_disksize to offset + len.
> 
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> ---
> Changes in v2:
> - The modification of i_disksize should be moved into ext4_update_disksize_before_punch,
>   rather than being done in ext4_page_mkwrite.
> - Link to v1: https://lore.kernel.org/all/20250731140528.1554917-1-sunyongjian@huaweicloud.com/
> ---
>  fs/ext4/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..2b1ed729a0f0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4298,7 +4298,7 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>  	loff_t size = i_size_read(inode);
>  
>  	WARN_ON(!inode_is_locked(inode));
> -	if (offset > size || offset + len < size)
> +	if (offset > size)
>  		return 0;
>  
>  	if (EXT4_I(inode)->i_disksize >= size)

Hi, Yongjian!

I think this check also needs to be updated; otherwise, the limitation
will be too lenient. If the end position of the punch hole
is <= i_disksize, we should also avoid updating the i_disksize (this is
a more general use case). Besides, I'd suggested updating the comment
of ext4_update_disksize_before_punch() together.

Regards,
Yi.

> @@ -4307,7 +4307,7 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>  	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
> -	ext4_update_i_disksize(inode, size);
> +	ext4_update_i_disksize(inode, min_t(loff_t, size, offset + len));
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	ext4_journal_stop(handle);
>  


