Return-Path: <linux-fsdevel+bounces-73857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BEAD220E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF99306B787
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 01:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A925BF13;
	Thu, 15 Jan 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XFvKan/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D027456;
	Thu, 15 Jan 2026 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768441434; cv=none; b=q1egvIPYtN6aYpfCNRvvE1m0Ak0aP4C2YvIDEsdl72iHwQRlNu8ZqewRh06HOEBuTMHbZxYdHfQWs1fy3oPV5siaY4wHA3iFhhnpnb9YHHTFbr41Vnxq9yiLI3bvX2waF/vP76nZWDCsSGKqIxpT8ouaBdMLtoAyitAuEbeWc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768441434; c=relaxed/simple;
	bh=U2oQyKelXBRdvp4rwjd/UwBcJoT/KPgH3btBzVrCZLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rt1Er/NuLCoK2QFkPcYnpY+yjVDtdEN1hGaGxRdZmKeuyZR2l2i3o+ga5jjEbITXoBvjTWKIPxtcguzOpGnOwZ4RNeMtgd+IFx88QaWy7mOsoC09ukyq+W2jykuEo0AXQe6msxKynqoBJax2DW9DzbPli1Z/LY0gssfwlq6DiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XFvKan/B; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768441429; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VOr47FbS0wDXn2jkEdscUYJCk7XAlkjlew+1NUKh7yE=;
	b=XFvKan/BejbRUI0Y57sC1I+XnObqSZyQ/xp5xfaWQ2QNhqgpx8O40kiVBw45eVJmCEaS1M4QfWigTjES3wAbHxsupggZOaHqzsnrdGchu63s5vzpUltBz3v5ex9y7rVCPhNSiOigLkx96oqdRqYEsHOOZAAV0hmIFMijNROKgYg=
Received: from 30.221.132.28(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx4jmrW_1768441428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 09:43:49 +0800
Message-ID: <2f378658-ec10-4091-9f8d-02b19351cd44@linux.alibaba.com>
Date: Thu, 15 Jan 2026 09:43:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-8-lihongbo22@huawei.com>
 <6defede0-2d2f-4193-8eb1-a1e1d842a8e3@linux.alibaba.com>
 <6ccc0f3f-56a5-4edb-a4c9-72d6e5090b7b@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6ccc0f3f-56a5-4edb-a4c9-72d6e5090b7b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/15 09:21, Hongbo Li wrote:
> Hi,Xiang
> 
> On 2026/1/14 18:18, Gao Xiang wrote:
>>
>>
>> On 2026/1/9 18:28, Hongbo Li wrote:
>>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>>
> ...
> 
>>> +
>>> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>>> +{
>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>> +
>>> +    vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
>>> +    INIT_LIST_HEAD(&vi->ishare_list);
>>> +    spin_lock_init(&vi->ishare_lock);
>>> +    return 0;
>>> +}
>>> +
>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>> +{
>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>> +    struct erofs_inode_fingerprint fp;
>>> +    struct inode *sharedinode;
>>> +    unsigned long hash;
>>> +
>>> +    if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
>>> +        return false;
>>> +    hash = xxh32(fp.opaque, fp.size, 0);
>>> +    sharedinode = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
>>> +                   erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
>>> +                   &fp);
>>> +    if (!sharedinode) {
>>> +        kfree(fp.opaque);
>>> +        return false;
>>> +    }
>>> +
>>> +    vi->sharedinode = sharedinode;
>>> +    if (inode_state_read_once(sharedinode) & I_NEW) {
>>> +        if (erofs_inode_is_data_compressed(vi->datalayout)) {
>>> +            sharedinode->i_mapping->a_ops = &z_erofs_aops;
>>
>> It seems that it caused a build warning:
>> https://lore.kernel.org/r/202601130827.dHbGXL3Y-lkp@intel.com
>>
>>> +        } else {
>>> +            sharedinode->i_mapping->a_ops = &erofs_aops;
>>> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
>>> +            if (erofs_is_fileio_mode(sbi))
>>> +                sharedinode->i_mapping->a_ops = &erofs_fileio_aops;
>>> +#endif
>>> +        }
>>
>> Can we introduce a new helper for those aops setting? such as:
>>
>> void erofs_inode_set_aops(struct erofs_inode *inode,
>>                struct erofs_inode *realinode, bool no_fscache)
> 
> Yeah, good idea. So it also can be reuse in erofs_fill_inode.
> 
> And how about declearing it as "int erofs_iode_set_aops(struct erofs_inode *inode, struct erofs_inode *realinode, bool no_fscache)"; because the compressed case may return -EOPNOTSUPP and it seems we cannot break this in advance.

yes, `int` return is good.

>  And can we mark it inline?

you could move this one to internal.h.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo

