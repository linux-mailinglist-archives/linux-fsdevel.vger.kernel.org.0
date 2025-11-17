Return-Path: <linux-fsdevel+bounces-68632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE7EC623F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 04:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 843D835CB78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07D2ED843;
	Mon, 17 Nov 2025 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RpavZrcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A079927462;
	Mon, 17 Nov 2025 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763350230; cv=none; b=fLcK74izTMDrvwkrH4aNFdT93Qh1RLT3VYb/Rrs/vznyR9ujM5zM5afTjJYoOn4KZzID0PsmDEBmJXJmfYVDOjcPyy/psoVxDE2pHWGJxxJxLfnEb10BwQA0WlGDHyn162uY24b9YNd4DUi3lCCs8bW9BOmh4QOvYMCBLFpSygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763350230; c=relaxed/simple;
	bh=7PLrZTpxEmDFj/D93h0x6TDmRzSUDm/DeDnpQbRVAxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9j0rdeq3y1XQtFKmnKgmQNZycC6JSdyx768rFN2adEZlih7HsMwymnM09U5SpFkda70gkdGZsb3BkS/Kaplp4Gkemvc1qGr6K3nB6inFR3qRYy8hYTtvNZbDVP4J+HnK+vX743A8lQBNm3sLDXse5L+XN4QnTLBu2p+b0pPA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RpavZrcw; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763350215; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=77VBZxawPoiblVroVwdi0fB2t1X1ZR/kaNSvk7n/vPE=;
	b=RpavZrcwGq7qgdoG7fzjsMcIemRUjp/jJ6cB7qCeZtJBWO0Ly8v46KXppnfNWUL7XP2HdwUh5CpK4suo1d1wI9Ih0PPzJllz3OZ6EtPHe3nRqvP6OToQyJKG1iOYS7/zF6MxZdq2kLHR83jI1A7W65Ie6sQBUvwso6BKAGgT5n4=
Received: from 30.221.131.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsTuAU5_1763350214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 11:30:14 +0800
Message-ID: <4a6164d9-7959-4ce8-97b4-5a5154a3f037@linux.alibaba.com>
Date: Mon, 17 Nov 2025 11:30:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/9] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-7-lihongbo22@huawei.com>
 <ac1b5431-e71f-430d-8309-8d007dc449b9@linux.alibaba.com>
 <cb040afb-a025-4dbb-9866-4772b24a3b8e@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <cb040afb-a025-4dbb-9866-4772b24a3b8e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/11/17 11:14, Hongbo Li wrote:
> Hi Xiang
> 
> On 2025/11/17 11:06, Gao Xiang wrote:
>>
>>
>> On 2025/11/14 17:55, Hongbo Li wrote:
>>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>>
>>> Currently, reading files with different paths (or names) but the same
>>> content will consume multiple copies of the page cache, even if the
>>> content of these page caches is the same. For example, reading
>>> identical files (e.g., *.so files) from two different minor versions of
>>> container images will cost multiple copies of the same page cache,
>>> since different containers have different mount points. Therefore,
>>> sharing the page cache for files with the same content can save memory.
>>>
>>> This introduces the page cache share feature in erofs. It allocate a
>>> deduplicated inode and use its page cache as shared. Reads for files
>>> with identical content will ultimately be routed to the page cache of
>>> the deduplicated inode. In this way, a single page cache satisfies
>>> multiple read requests for different files with the same contents.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>
>> ...
>>
>>
>>> +
>>> +static int erofs_ishare_file_open(struct inode *inode, struct file *file)
>>> +{
>>> +    struct file *realfile;
>>> +    struct inode *dedup;
>>> +
>>> +    dedup = EROFS_I(inode)->ishare;
>>> +    if (!dedup)
>>> +        return -EINVAL;
>>> +
>>> +    realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, "erofs_ishare_file",
>>> +                     O_RDONLY, &erofs_file_fops);
>>> +    if (IS_ERR(realfile))
>>> +        return PTR_ERR(realfile);
>>> +
>>> +    file_ra_state_init(&realfile->f_ra, file->f_mapping);
>>> +    realfile->private_data = EROFS_I(inode);
>>> +    file->private_data = realfile;
>>> +    return 0;
>>
> 
> My apologies, I got it wrong. The latest code wasn't synced. The most current version should be this one.
> 
> static int erofs_ishare_file_open(struct inode *inode, struct file *file)
> {
>      struct file *realfile;
>      struct inode *dedup;
>      char *buf, *filepath;
> 
>      dedup = EROFS_I(inode)->ishare;
>      if (!dedup)
>          return -EINVAL;
> 
>      buf = kmalloc(PATH_MAX, GFP_KERNEL);
>      if (!buf)
>          return -ENOMEM;
>      filepath = file_path(file, buf, PATH_MAX);
>      if (IS_ERR(filepath)) {
>          kfree(buf);
>          return -PTR_ERR(filepath);
>      }
>      realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, filepath + 1,
>                       O_RDONLY, &erofs_file_fops);
>      kfree(buf);
>      if (IS_ERR(realfile))
>          return PTR_ERR(realfile);
> 
>      file_ra_state_init(&realfile->f_ra, file->f_mapping);
>      ihold(dedup);
>      realfile->private_data = EROFS_I(inode);
>      file->private_data = realfile;
>      return 0;
> }
> 
> I changed the "erofs_ishare_file" with filepath + 1 to display the realpath of the original file.

Although it could work for file_user_path() [but it's unclean on my side],
but file_user_inode() still doesn't work.

You should adapt backing_file infrastructure instead.

Thanks,
Gao Xiang

