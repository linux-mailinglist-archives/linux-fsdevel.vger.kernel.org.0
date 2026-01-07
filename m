Return-Path: <linux-fsdevel+bounces-72586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF5CFC55E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 08:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7DE830060C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 07:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308127FB1B;
	Wed,  7 Jan 2026 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KGtgsuZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65027464F;
	Wed,  7 Jan 2026 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770850; cv=none; b=NkspDomhQptgMG1D3M9Alml3rqwDHuFd+Hc4HmJA2Qxt27uXuQLAuO83hzb1NOdrpL55tSuSP/K2ETl7fh+CeeZ4Pl14jDNiciE1L4zqtGG+cNnrTFr4L/Lvyg9TxNZ6Zwd1Oc+J4R5x+FkFQsw3l6WCPYz0mx6l5qd67JLyxTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770850; c=relaxed/simple;
	bh=8oFAkkZZPB+e4dMao/9uF59GN//ELmwoBl/WLpytjxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOtlR8zRpFDxPbh53DbMC6DEMh99bSmRrp4GfAzE58+PYTgFVIWFOox870IlArHrNunmmBErUYR7RuYn/b7aBJQiL60ZfWf0nrLFbyh89hVfP6tnEQn/BVmyqocIj3N2FHi4GqihuQs2++9VvhstSkcjkEYAv+4TvjYi9mt3/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KGtgsuZw; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767770845; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wIhoN/2ww2lPKEHlSOgFqyKLzkhSgxbhOitTMCYTPKg=;
	b=KGtgsuZwcpF+w22mh0RVh7KT3T3hTq5xreZoO5NtJ1449tOAtADz34qkdcbyTIkZoWAXmy5le50NV6dhdNDFp4SCaclxIborWjsrsqhJfKCnLgM1OaPJ9cY1jeGQz0gt+W01LFoe7qNVIqwtZluunJnkuOOdLdOfXCQ0kEUMPu8=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwY.RhZ_1767770844 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 15:27:24 +0800
Message-ID: <9bacd58e-40be-4250-9fab-7fb8e2606ad8@linux.alibaba.com>
Date: Wed, 7 Jan 2026 15:27:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
 <b690d435-7e9c-4424-a681-d3f798176202@huawei.com>
 <df2889c0-6027-4f42-a013-b01357fd0005@linux.alibaba.com>
 <07212138-c0fc-4a64-a323-9cab978bf610@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <07212138-c0fc-4a64-a323-9cab978bf610@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/7 15:17, Hongbo Li wrote:
> Hi, Xiang
> 

...

>>>>> +
>>>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>>>> +{
>>>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>>>> +    struct erofs_inode_fingerprint fp;
>>>>> +    struct inode *sharedinode;
>>>>> +    unsigned long hash;
>>>>> +
>>>>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>>>>> +        return false;
>>>>> +    (void)erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id);
>>>>> +    if (!fp.size)
>>>>> +        return false;
>>>>
>>>> Why not just:
>>>>
>>>>      if (erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id))
>>>>          return false;
>>>>
>>>
>>> When erofs_sb_has_ishare_xattrs returns false, erofs_xattr_fill_ishare_fp also considers success.
>>
>> Then why !test_opt(&sbi->opt, INODE_SHARE) didn't return?
>>
> 
> The MOUNT_INODE_SHARE flag is passed from user's mount option. And it is controllered by CONFIG_EROFS_FS_PAGE_CACHE_SHARE. I doesn't do the check when the superblock without ishare_xattrs. (It seems the mount options is static, although it is useless for mounting with inode_share on one EROFS image without ishare_xattrs).
> So should we check that if the superblock has not ishare_xattrs feature, and we return -ENOSUPP?

I think you should just mask off the INODE_SHARE if the on-disk
compat feature is unavailable, and print a warning just like
FSDAX fallback.

Thanks,
Gao Xiang

