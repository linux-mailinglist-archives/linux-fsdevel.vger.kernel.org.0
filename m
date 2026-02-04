Return-Path: <linux-fsdevel+bounces-76240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEYiO8e8gmk4ZgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 04:28:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8405DE13FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 04:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2F1630C3D08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 03:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D432E22BA;
	Wed,  4 Feb 2026 03:28:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F63BB48;
	Wed,  4 Feb 2026 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175684; cv=none; b=FJd7AJg59INcTgV5reLg3J0CSavdE4uSoDuvKzqqUnHBIh5FYuFpsNM/gujnD9m4s7g5n33qqV7CSlwd9W2jh17/WJcH4j4pJstKd2lD4PWxN4Zs6N/DrLvqnRJPTzLzxIlLTzQEaONDVwGycdfiQSp3FaPdDmPGN4hU/DVQvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175684; c=relaxed/simple;
	bh=Kx0Xsx6OVQM7onpJtBNqFldxby+LrFH2z+tVYjsh9AE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=q5iAgmgl1Uxuyp794si2rIIicCev9jIbeSHSC/s3Qbcvx7zdTcBccaT5uO/eiXLDY48jceeShtj/ur3diXewcBnSJ0dob1YPhHFV8teJcFuyXA+eM4/Lz5fY9AN6JinN/MHnzmFQ/jcSo37zSU39a7YHOWdtk7aJX0NgFInWNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f5Ql12MTdzYQtkM;
	Wed,  4 Feb 2026 11:27:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B65124058A;
	Wed,  4 Feb 2026 11:27:57 +0800 (CST)
Received: from [10.174.178.46] (unknown [10.174.178.46])
	by APP4 (Coremail) with SMTP id gCh0CgBnFPW8vIJp7gfEGA--.60535S3;
	Wed, 04 Feb 2026 11:27:57 +0800 (CST)
Subject: Re: [PATCH] dcache: Limit the minimal number of bucket to two
To: Zhihao Cheng <chengzhihao1@huawei.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com
References: <20260130034853.215819-1-chengzhihao1@huawei.com>
From: Zhihao Cheng <chengzhihao@huaweicloud.com>
Message-ID: <e3a58914-4e7d-8ce9-a813-e09a87cf1bf5@huaweicloud.com>
Date: Wed, 4 Feb 2026 11:27:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260130034853.215819-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnFPW8vIJp7gfEGA--.60535S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw48ZFykKF4xuFWxWr4kJFb_yoW8trWDpr
	WxWF1Ykr95Aa97ua1fuw1DGFykWa9rC3W7WFyIkw1rA3y5Crn8KFnrC3yfZFyDArWrZa47
	tF1Iqw15Ww4Fq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: xfkh0wx2klxt3r6k3tpzhluzxrxghudrp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.976];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengzhihao@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76240-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8405DE13FB
X-Rspamd-Action: no action

friendly ping...

ÔÚ 2026/1/30 11:48, Zhihao Cheng Ð´µÀ:
> There is an OOB read problem on dentry_hashtable when user sets
> 'dhash_entries=1':
>    BUG: unable to handle page fault for address: ffff888b30b774b0
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    Oops: Oops: 0000 [#1] SMP PTI
>    RIP: 0010:__d_lookup+0x56/0x120
>     Call Trace:
>      d_lookup.cold+0x16/0x5d
>      lookup_dcache+0x27/0xf0
>      lookup_one_qstr_excl+0x2a/0x180
>      start_dirop+0x55/0xa0
>      simple_start_creating+0x8d/0xa0
>      debugfs_start_creating+0x8c/0x180
>      debugfs_create_dir+0x1d/0x1c0
>      pinctrl_init+0x6d/0x140
>      do_one_initcall+0x6d/0x3d0
>      kernel_init_freeable+0x39f/0x460
>      kernel_init+0x2a/0x260
> 
> There will be only one bucket in dentry_hashtable when dhash_entries is
> set as one, and d_hash_shift is calculated as 32 by dcache_init(). Then,
> following process will access more than one buckets(which memory region
> is not allocated) in dentry_hashtable:
>   d_lookup
>    b = d_hash(hash)
>      dentry_hashtable + ((u32)hashlen >> d_hash_shift)
>      // The C standard defines the behavior of right shift amounts
>      // exceeding the bit width of the operand as undefined. The
>      // result of '(u32)hashlen >> d_hash_shift' becomes 'hashlen',
>      // so 'b' will point to an unallocated memory region.
>    hlist_bl_for_each_entry_rcu(b)
>     hlist_bl_first_rcu(head)
>      h->first  // read OOB!
> 
> Fix it by limiting the minimal number of dentry_hashtable bucket to two,
> so that 'd_hash_shift' won't exceeds the bit width of type u32.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   fs/dcache.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 66dd1bb830d1..957a44d2c44a 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -3260,7 +3260,7 @@ static void __init dcache_init_early(void)
>   					HASH_EARLY | HASH_ZERO,
>   					&d_hash_shift,
>   					NULL,
> -					0,
> +					2,
>   					0);
>   	d_hash_shift = 32 - d_hash_shift;
>   
> @@ -3292,7 +3292,7 @@ static void __init dcache_init(void)
>   					HASH_ZERO,
>   					&d_hash_shift,
>   					NULL,
> -					0,
> +					2,
>   					0);
>   	d_hash_shift = 32 - d_hash_shift;
>   
> 


