Return-Path: <linux-fsdevel+bounces-73024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFDD089B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 11:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1165830167B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8923385B1;
	Fri,  9 Jan 2026 10:34:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CD330B0E;
	Fri,  9 Jan 2026 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954847; cv=none; b=C7g3qs+Gyl4wMoc2n49wem17F96y4eGjv6Rrd5XYWzKxfShrxppDVJUQwmZsqEXKC29V6Yg08Kv0U27X/c12WoVoJgDd5BfEEL8rDgnJbNAXL/bolpavxeCUxavg880RWvNO9n4aB+WMayqw3nqvCKCiBzu4A1xNnszLMVVntfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954847; c=relaxed/simple;
	bh=4yidhpVrLttkP1Yv0UturrZunK9twHG3UONxSxi1kL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ho8MR/NLMU8X211cbRSZRkhcr0EUNi9tuv0vhvuCFLPQs1f8rysz3HJcpw6+PKYEWobhXHMYjj+m8PfHB+v3yE85AUtXt7Zob+bWLvB33xHAuVwrZXYYALgXO/482FFRSYRkAA8Mdya/qDhohj/W2JLFoGYf8jUtMnJfoE13flU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dndRR328YzYQv6P;
	Fri,  9 Jan 2026 18:33:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8A8614057D;
	Fri,  9 Jan 2026 18:34:00 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgBXuPiW2WBpX7G2DA--.8776S3;
	Fri, 09 Jan 2026 18:34:00 +0800 (CST)
Message-ID: <f41e3837-93a6-495c-93cd-0ecccf3ca62d@huaweicloud.com>
Date: Fri, 9 Jan 2026 18:33:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ext4: fix e4b bitmap inconsistency reports
To: sunyongjian1@huawei.com, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
 yangerkun@huawei.com, libaokun1@huawei.com, chengzhihao1@huawei.com
References: <20260106090820.836242-1-sunyongjian@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20260106090820.836242-1-sunyongjian@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXuPiW2WBpX7G2DA--.8776S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw17JFy5Gw1DZFy5ur1fXrb_yoWrur1rpr
	43Kw1DKFWrW3W3uw42ya4FgF10k348ur43Ca1fWr1fZFs0qa4IkFW7K3Z8WF45Jrs2yw1S
	qw4j9ryDWa4DAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 1/6/2026 5:08 PM, Yongjian Sun wrote:
> From: Yongjian Sun <sunyongjian1@huawei.com>
> 
> A bitmap inconsistency issue was observed during stress tests under
> mixed huge-page workloads. Ext4 reported multiple e4b bitmap check
> failures like:
> 
> ext4_mb_complex_scan_group:2508: group 350, 8179 free clusters as
> per group info. But got 8192 blocks
> 
> Analysis and experimentation confirmed that the issue is caused by a
> race condition between page migration and bitmap modification. Although
> this timing window is extremely narrow, it is still hit in practice:
> 
> folio_lock                        ext4_mb_load_buddy
> __migrate_folio
>   check ref count
>   folio_mc_copy                     __filemap_get_folio
>                                       folio_try_get(folio)
>                                   ......
>                                   mb_mark_used
>                                   ext4_mb_unload_buddy
>   __folio_migrate_mapping
>     folio_ref_freeze
> folio_unlock
> 
> The root cause of this issue is that the fast path of load_buddy only
> increments the folio's reference count, which is insufficient to prevent
> concurrent folio migration. We observed that the folio migration process
> acquires the folio lock. Therefore, we can determine whether to take the
> fast path in load_buddy by checking the lock status. If the folio is
> locked, we opt for the slow path (which acquires the lock) to close this
> concurrency window.
> 
> Additionally, this change addresses the following issues:
> 
> When the DOUBLE_CHECK macro is enabled to inspect bitmap-related
> issues, the following error may be triggered:
> 
> corruption in group 324 at byte 784(6272): f in copy != ff on
> disk/prealloc
> 
> Analysis reveals that this is a false positive. There is a specific race
> window where the bitmap and the group descriptor become momentarily
> inconsistent, leading to this error report:
> 
> ext4_mb_load_buddy                   ext4_mb_load_buddy
>   __filemap_get_folio(create|lock)
>     folio_lock
>   ext4_mb_init_cache
>     folio_mark_uptodate
>                                      __filemap_get_folio(no lock)
>                                      ......
>                                      mb_mark_used
>                                        mb_mark_used_double
>   mb_cmp_bitmaps
>                                        mb_set_bits(e4b->bd_bitmap)
>   folio_unlock
> 
> The original logic assumed that since mb_cmp_bitmaps is called when the
> bitmap is newly loaded from disk, the folio lock would be sufficient to
> prevent concurrent access. However, this overlooks a specific race
> condition: if another process attempts to load buddy and finds the folio
> is already in an uptodate state, it will immediately begin using it without
> holding folio lock.
> 
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>

Well done! This is a problem that has been hidden for a long time.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/mballoc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..de4cacb740b3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1706,16 +1706,17 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
>  
>  	/* Avoid locking the folio in the fast path ... */
>  	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +	if (IS_ERR(folio) || !folio_test_uptodate(folio) || folio_test_locked(folio)) {
> +		/*
> +		 * folio_test_locked is employed to detect ongoing folio
> +		 * migrations, since concurrent migrations can lead to
> +		 * bitmap inconsistency. And if we are not uptodate that
> +		 * implies somebody just created the folio but is yet to
> +		 * initialize it. We can drop the folio reference and
> +		 * try to get the folio with lock in both cases to avoid
> +		 * concurrency.
> +		 */
>  		if (!IS_ERR(folio))
> -			/*
> -			 * drop the folio reference and try
> -			 * to get the folio with lock. If we
> -			 * are not uptodate that implies
> -			 * somebody just created the folio but
> -			 * is yet to initialize it. So
> -			 * wait for it to initialize.
> -			 */
>  			folio_put(folio);
>  		folio = __filemap_get_folio(inode->i_mapping, pnum,
>  				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
> @@ -1764,7 +1765,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
>  
>  	/* we need another folio for the buddy */
>  	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +	if (IS_ERR(folio) || !folio_test_uptodate(folio) || folio_test_locked(folio)) {
>  		if (!IS_ERR(folio))
>  			folio_put(folio);
>  		folio = __filemap_get_folio(inode->i_mapping, pnum,


