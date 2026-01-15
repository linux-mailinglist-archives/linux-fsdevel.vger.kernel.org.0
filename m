Return-Path: <linux-fsdevel+bounces-73855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEFAD2200B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE7D030050AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FC023F42D;
	Thu, 15 Jan 2026 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gHnYkgCx";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gHnYkgCx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0D212549;
	Thu, 15 Jan 2026 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768440138; cv=none; b=BO//pvtazC5YhC8H5VAAEU/yOeyYq0CoEJleO0FKy6rXwR2QWt4p1FgTzFhIwhjhwFHMwNDh0Q4hycIpZMvzD5AfGxfxu8PJc9c1chWO5Wf+XCDUavJVftd3KNvJogH8Qj+hSfTydAKl0123PaO1Mss6Kd4qP3nSeYzYn3v7W6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768440138; c=relaxed/simple;
	bh=Vvm29cA8Fa0pdQL/6hhBXqrAxbcPAg/c+7vocFq2Ihs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JKzjoGUgKyH1qK902LvY2kR8L7nZyxZ0PoZRL/9s3QNZ83dRqVQ9WiRH9bxL4u3fzLwEtlYwXpBtHLI9WkGxwOpHtd5ZdrxiCHhNfbYGoqZ5XCxTS7OraMM7N416j7vN5n4bQ8qbqY7avYWbnZ7fHuNrp9zJY8sXOuZXiH4oL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gHnYkgCx; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gHnYkgCx; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uGwfILC7yHCpfCV76sUs7dT+L7RgNEA3D9D+1vlxiww=;
	b=gHnYkgCxwlBBoAYob9FSaT1+YTZn8STnXamh4VOEEaAOi7+M4Bw1zFaFrS7TMk+eAbDhIzSNF
	00l0QYkO6y6tO28NeXmVD6aZycI5IIZEUE2OvDvh+5zE9bMQDgdF3tYKCWXlgrvZo4m7h0/lhUI
	CV+W2m4DtCi932MlzTOFNGo=
Received: from canpmsgout11.his.huawei.com (unknown [172.19.92.148])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4ds4vj3fpQz1BFn5;
	Thu, 15 Jan 2026 09:21:53 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uGwfILC7yHCpfCV76sUs7dT+L7RgNEA3D9D+1vlxiww=;
	b=gHnYkgCxwlBBoAYob9FSaT1+YTZn8STnXamh4VOEEaAOi7+M4Bw1zFaFrS7TMk+eAbDhIzSNF
	00l0QYkO6y6tO28NeXmVD6aZycI5IIZEUE2OvDvh+5zE9bMQDgdF3tYKCWXlgrvZo4m7h0/lhUI
	CV+W2m4DtCi932MlzTOFNGo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ds4qz2KtlzKmSg;
	Thu, 15 Jan 2026 09:18:39 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id F04FF40536;
	Thu, 15 Jan 2026 09:21:59 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 09:21:59 +0800
Message-ID: <6ccc0f3f-56a5-4edb-a4c9-72d6e5090b7b@huawei.com>
Date: Thu, 15 Jan 2026 09:21:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/10] erofs: introduce the page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-8-lihongbo22@huawei.com>
 <6defede0-2d2f-4193-8eb1-a1e1d842a8e3@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <6defede0-2d2f-4193-8eb1-a1e1d842a8e3@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi,Xiang

On 2026/1/14 18:18, Gao Xiang wrote:
> 
> 
> On 2026/1/9 18:28, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
...

>> +
>> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +    vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
>> +    INIT_LIST_HEAD(&vi->ishare_list);
>> +    spin_lock_init(&vi->ishare_lock);
>> +    return 0;
>> +}
>> +
>> +bool erofs_ishare_fill_inode(struct inode *inode)
>> +{
>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct erofs_inode_fingerprint fp;
>> +    struct inode *sharedinode;
>> +    unsigned long hash;
>> +
>> +    if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
>> +        return false;
>> +    hash = xxh32(fp.opaque, fp.size, 0);
>> +    sharedinode = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
>> +                   erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
>> +                   &fp);
>> +    if (!sharedinode) {
>> +        kfree(fp.opaque);
>> +        return false;
>> +    }
>> +
>> +    vi->sharedinode = sharedinode;
>> +    if (inode_state_read_once(sharedinode) & I_NEW) {
>> +        if (erofs_inode_is_data_compressed(vi->datalayout)) {
>> +            sharedinode->i_mapping->a_ops = &z_erofs_aops;
> 
> It seems that it caused a build warning:
> https://lore.kernel.org/r/202601130827.dHbGXL3Y-lkp@intel.com
> 
>> +        } else {
>> +            sharedinode->i_mapping->a_ops = &erofs_aops;
>> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
>> +            if (erofs_is_fileio_mode(sbi))
>> +                sharedinode->i_mapping->a_ops = &erofs_fileio_aops;
>> +#endif
>> +        }
> 
> Can we introduce a new helper for those aops setting? such as:
> 
> void erofs_inode_set_aops(struct erofs_inode *inode,
>                struct erofs_inode *realinode, bool no_fscache)

Yeah, good idea. So it also can be reuse in erofs_fill_inode.

And how about declearing it as "int erofs_iode_set_aops(struct 
erofs_inode *inode, struct erofs_inode *realinode, bool no_fscache)"; 
because the compressed case may return -EOPNOTSUPP and it seems we 
cannot break this in advance. And can we mark it inline?

Thanks,
Hongbo

> {
>      if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
> #ifdef CONFIG_EROFS_FS_ZIP
>          DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>                  erofs_info, realinode->i_sb,
>                                "EXPERIMENTAL EROFS subpage compressed 
> block support in use. Use at your own risk!");
>          inode->i_mapping->a_ops = &z_erofs_aops;
> #else
>          err = -EOPNOTSUPP;
> #endif
>          } else {
>                  inode->i_mapping->a_ops = &erofs_aops;
> #ifdef CONFIG_EROFS_FS_ONDEMAND
>                  if (!nofscache && erofs_is_fscache_mode(realinode->i_sb))
>                          inode->i_mapping->a_ops = 
> &erofs_fscache_access_aops;
> #endif
> #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
>                  if (erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
>                          inode->i_mapping->a_ops = &erofs_fileio_aops;
> #endif
>          }
> }
> 
> 
> 
>> +        sharedinode->i_mode = vi->vfs_inode.i_mode;
>> +        sharedinode->i_size = vi->vfs_inode.i_size;
>> +        unlock_new_inode(sharedinode);
>> +    } else {
>> +        kfree(fp.opaque);
>> +    }
>> +    INIT_LIST_HEAD(&vi->ishare_list);
>> +    spin_lock(&EROFS_I(sharedinode)->ishare_lock);
>> +    list_add(&vi->ishare_list, &EROFS_I(sharedinode)->ishare_list);
>> +    spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
>> +    return true;
>> +}
>> +
>> +void erofs_ishare_free_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct inode *sharedinode = vi->sharedinode;
>> +
>> +    if (!sharedinode)
>> +        return;
>> +    spin_lock(&EROFS_I(sharedinode)->ishare_lock);
>> +    list_del(&vi->ishare_list);
>> +    spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
>> +    iput(sharedinode);
>> +    vi->sharedinode = NULL;
>> +}
>> +

...
>>           /*
>> @@ -719,6 +733,10 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>           erofs_info(sb, "unsupported blocksize for DAX");
>>           clear_opt(&sbi->opt, DAX_ALWAYS);
>>       }
>> +    if (test_opt(&sbi->opt, INODE_SHARE) && 
>> !erofs_sb_has_ishare_xattrs(sbi)) {
>> +        erofs_info(sb, "on-disk ishare xattrs not found. Turning off 
>> inode_share.");
>> +        clear_opt(&sbi->opt, INODE_SHARE);
>> +    }
> 
> It would be better to add a message like:
> 
>      if (test_opt(&sbi->opt, INODE_SHARE))
>          erofs_info(sb, "EXPERIMENTAL EROFS page cache share support in 
> use. Use at your own risk!");
> 
> At the end of erofs_read_superblock().
> 

Ok, I will add in next version.

Thanks,
Hongbo

> Thanks,
> Gao Xiang

