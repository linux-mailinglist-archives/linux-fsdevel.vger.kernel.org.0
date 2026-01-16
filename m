Return-Path: <linux-fsdevel+bounces-74180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F931D33782
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4230330C0481
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDBF344031;
	Fri, 16 Jan 2026 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VqwA8GIS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162326E165;
	Fri, 16 Jan 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580490; cv=none; b=aDqM1UWuWKeneLkecaWwJqfQQ7+AOAupcEJi/oe1ypgEaIKeWifYpAT538XSh71CMsW6gO4/4brVQ3ivZHNZhXyNGkH8j1gld2jLwkN9En9n6eTB/2tRexKmN90zPufX1IpoQQGu3FyQh5Ys5zA+yti/V57Hc3A/5nSHkABqmC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580490; c=relaxed/simple;
	bh=l8DlgSza08bqGYKKlV41P2GV4BRoEqqBH119gTKsQ0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gz5bbnmeIZOxa1v0aWz4wdJQ/wc1Bnh86FSg5/U3yOh9suXDl56a7tWms1DY9xIZO90fETWR6RUgMMDl+D1A4N1zHKldIfuB9JArOk0BbfmXHT9aZPwQWv+u74OjMc7J764FDpDBzvKFph6IQpN73qDlBejudMSB7aqVCJhH4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VqwA8GIS; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768580477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZpOJQ6ooa0mcia/fcatFm9psF59FZgaxBeQaFIs6dr4=;
	b=VqwA8GISAkQT4xMmtXRLK0IuFjmDhvJq0YXI6VMGtMBj62xxRx26q+MO/sHCBAqDC1zzVwJPelpoVixAEZwnDdRn2+YDsUOnwdL3yf7ZC8Clvp3CI9ny1+FlmHesSGAgeV8A+wHgHw8GAKFu1TSUecbvrRnD/mC7XIJp6wsHdOM=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxAgkQR_1768580476 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Jan 2026 00:21:17 +0800
Message-ID: <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
Date: Sat, 17 Jan 2026 00:21:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>
Cc: chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260116154623.GC21174@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2026/1/16 23:46, Christoph Hellwig wrote:
> I don't really understand the fingerprint idea.  Files with the
> same content will point to the same physical disk blocks, so that
> should be a much better indicator than a finger print?  Also how does

Page cache sharing should apply to different EROFS
filesystem images on the same machine too, so the
physical disk block number idea cannot be applied
to this.

> the fingerprint guarantee uniqueness?  Is it a cryptographically
> secure hash?  In here it just seems like an opaque blob.

Yes, typically it can be a secure hash like sha256,
but it really depends on the users how to use it.

This feature is enabled _only_ when a dedicated mount
option is used, and should be enabled by the priviledged
mounters, and it's up to the priviledged mounters to
guarantee the fingerprint is correct (usually guaranteed
by signatures by image builders since images will be
signed).

Also different signatures also can be isolated by domain
ids, so that different domain ids cannot be shared.

> 
>> +static inline int erofs_inode_set_aops(struct inode *inode,
>> +				       struct inode *realinode, bool no_fscache)
> 
> Factoring this out first would be a nice little prep patch.
> Also it would probably be much cleaner using IS_ENABLED.
> 
>> +static int erofs_ishare_file_open(struct inode *inode, struct file *file)
>> +{
>> +	struct inode *sharedinode = EROFS_I(inode)->sharedinode;
> 
> Ok, it looks like this allocates a separate backing file and inode.

Yes.

Thanks,
Gao Xiang

