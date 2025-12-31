Return-Path: <linux-fsdevel+bounces-72262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B91CEB184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 03:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3B33014D93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F81F2459C6;
	Wed, 31 Dec 2025 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QuvkP2Nz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807421A840A;
	Wed, 31 Dec 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767148548; cv=none; b=NdjuKIbHKoNeg45l1xqiNPgL1+3QRDoxXspMcydftzSxTFi2pLsvNME75IVozs2viqyoAbgwqUxWewpolXa5Pkfh+GtaubZP6ngigGX6/svFrv2f6DrkAbkHeKGqZRH1fOFrNwjLkI4eOs2w2sw+QoMHXn2AAJ1R0kk8osJZsiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767148548; c=relaxed/simple;
	bh=5kAEtgp3AUCLgViqiEmswnVoFXKmx932NIMVJQGVUI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OF0prS3WeM0Gy6bncUT0aoiLcSeuNenwqwELXYYj7m0oycJuGsSKJez4iPSZdWY9UZy6ae0ASZ2p0tcVku/6aj7089X8IsByMAOsrI6DWKYeTaepeGDI0JsqI80OAjsVssFH/GC5KCK3Zl2TZLrzPHkIxDBKtRnyaIlH52btFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QuvkP2Nz; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=43lfbCdG1iPweBSVVwVAKkHG4CimAzus/9X0K+CoqzA=;
	b=QuvkP2NzcNV56R7dOfFodpasqHj4ExaCawQ6Re5Y0Qu6BHPFmd3Jm2KDvawEZ1
	WFz8xvtNusOl3MXhqy5zQ374LpbzHhTDwdL0GZ6nVgGeKirnA9ucPNCmpUX4yJzT
	ZhWhy1owYU6P8xfYnRrOcMPfXC3L2Dcvq0gem9zTuciZA=
Received: from [10.42.20.201] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3D+ffi1RpbbH0Kg--.12976S2;
	Wed, 31 Dec 2025 10:35:11 +0800 (CST)
Message-ID: <d832364d-02e6-458d-9eb2-442e1452a0f9@163.com>
Date: Wed, 31 Dec 2025 10:35:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] exfat: support multi-cluster for exfat_get_cluster
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "chizhiling@kylinos.cn" <chizhiling@kylinos.cn>, "jack@suse.cz"
 <jack@suse.cz>, "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "willy@infradead.org" <willy@infradead.org>
References: <PUZPR04MB6316194114D39A6505BA45A381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB6316194114D39A6505BA45A381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgD3D+ffi1RpbbH0Kg--.12976S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xZry7Xw4xAFW7AF45Awb_yoW8ZF15pr
	WxKa48trsrJasFkwn2yw4kZr4Ska4kJF15Ja1YqFWUCr98ArnYgF98Kr9xAF18CrsYvanF
	vw1Ygw17u3ZxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEF4EJUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3B+JJ2lUi99ZbwAA3y

On 12/30/25 17:06, Yuezhang.Mo@sony.com wrote:
>> @@ -243,6 +244,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
>>        struct buffer_head *bh = NULL;
>>        struct exfat_cache_id cid;
>>        unsigned int content, fclus;
>> +     unsigned int end = (*count <= 1) ? cluster : cluster + *count - 1;
> 
> In exfat_get_block,  count is set as follows:
> 
> count = EXFAT_B_TO_CLU_ROUND_UP(bh_result->b_size, sbi);
> 
> So '*count' is always greater than or equal to 1, the above condition seems unnecessary.


Yes, it is unnecessary.

> 
>> --- a/fs/exfat/inode.c
>> +++ b/fs/exfat/inode.c
>> @@ -134,6 +134,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>>        struct exfat_inode_info *ei = EXFAT_I(inode);
>>        unsigned int local_clu_offset = clu_offset;
>>        unsigned int num_to_be_allocated = 0, num_clusters;
>> +     unsigned int hint_count = max(*count, 1);
> 
> Same as above, hint_count seems unnecessary.
> 
>> +     /*
>> +      * Return on cache hit to keep the code simple.
>> +      */
>> +     if (fclus == cluster) {
>> +             *count = cid.fcluster + cid.nr_contig - fclus + 1;
>>                return 0;
> 
> If 'cid.fcluster + cid.nr_contig - fclus + 1 < *count', how about continuing to collect clusters?
> The following clusters may be continuous.

I'm glad you noticed this detail. It is necessary to explain this and 
update it in the code comments.

The main reason why I didn't continue the collection was that the 
subsequent clusters might also exist in the cache. This requires us to 
search the cache again to confirm this, and this action might introduce 
additional performance overhead.

I think we can continue to collect, but we need to check the cache 
before doing so.

> 
>> +             while (fclus < end) {
>> +                     if (exfat_ent_get(sb, clu, &content, &bh))
>> +                             goto err;
>> +                     if (++clu != content) {
>> +                             /* TODO: read ahead if content valid */
>> +                             break;
> 
> The next cluster index has been read and will definitely be used.
> How about add it to the cache?

Good idea!
will add it in v2,

thanks,

> 


