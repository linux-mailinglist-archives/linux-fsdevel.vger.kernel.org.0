Return-Path: <linux-fsdevel+bounces-72039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDA0CDBE4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C755E300E970
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249933321D3;
	Wed, 24 Dec 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TAYs+v4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690E4086A;
	Wed, 24 Dec 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766570724; cv=none; b=NZ0NK7JmG2ZLWtDlCV4Ubbo8poA82Zta9tXEbPi9la6aKVRH80REsKpjOj4PlhwXi+teOYvYhh5UOM5rrM3dZ+3EYKiYOXlc83+OqaKw+y1OpgXCBkPtr31T50mwcIaQTg4mPREDdXb2/7e3INop3NYqLR/2mM/O07G+B2mgHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766570724; c=relaxed/simple;
	bh=TX/ubNdVWkQUkkvtzgPbgX08ssRvE4k3u/k/CIaO3TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hh98BVq362p8nUAtx2LM1vTYOiXfXR8r2oGFn8XvcPj11+oCA/wxXzHisHW2/SZqYYZwS2iNEOwh4zAGcWlJTgXpZHsrB3AZMo2dK0HpU1Bt27Wf7Jqb8tf+OKB3M0WERLKgX+mk177/4dbB32H81f4D1kSA/Bh6VCr0CvOMtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TAYs+v4N; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766570712; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XjvaNCV6Fp280Tqzr2xLCA4/k9qavfxoZEOqMUBS/KM=;
	b=TAYs+v4N7dqj9wPgz+DhiF3l4/8sU4E7ZhFvETFYf7y84O+qsflVGyJG3bZFQCj7bYIzHD1Se0GEy/VBCfRuxXRUb1FLKWOzF44jB7p8k8qUeDihc2KqwE7spT0ekEF35qCzIzanR+Sgcd/ck/nMjsPxj1cQSTseS3uRkNQYTKQ=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvard6C_1766570711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 18:05:12 +0800
Message-ID: <84328aa9-5b84-4433-83ce-7147c100f5d2@linux.alibaba.com>
Date: Wed, 24 Dec 2025 18:05:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-8-lihongbo22@huawei.com>
 <64b03916-7b57-4719-bb2c-8f15ae333330@linux.alibaba.com>
 <5aad8772-458d-4040-a8b6-feff924c1d30@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5aad8772-458d-4040-a8b6-feff924c1d30@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/12/24 17:26, Hongbo Li wrote:
> 
> Hi, Xiang
> On 2025/12/24 16:09, Gao Xiang wrote:
>>

...

>>
>> why return `struct erofs_inode_fingerprint` instead of:
>>
>> int erofs_xattr_get_ishare_fp(struct erofs_inode_fingerprint *fp,
>>                    struct inode *inode, const char *domain_id)
>>
>> instead?
>>
> 
> How about declaring this as void erofs_xattr_fill_ishare_fp(struct erofs_inode_fingerprint *fp, struct inode *inode, const char *domain_id)? Because the return value seems useless.

I still perfer to return different values for this helper
even the final user doesn't use this.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo

