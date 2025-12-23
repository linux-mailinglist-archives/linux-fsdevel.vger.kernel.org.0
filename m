Return-Path: <linux-fsdevel+bounces-71966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26788CD8747
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 09:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBF130255BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F531ED62;
	Tue, 23 Dec 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZnnDLibg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7C31D744;
	Tue, 23 Dec 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766478903; cv=none; b=H7o3YZX9ZYyfVLwf9x92ZI2EryuMpr0M6Bdw6zpfYWj4mfgRBQPMiJbFUvA/DVuGIpT2bHG1diS5qxt37z/fX5Z9eTeOoUZ7UAr+3cI2qviTBDJDhMAPoHz1+ADAndc2rLe/lQf4ZHLxIcPTa4CtlLJNV2UhTRpfUOWhn6+5gg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766478903; c=relaxed/simple;
	bh=Hj3h5TOiOglj4xiIZGsTSghi175Gi5OvIIGUXLTsLn8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S3iaj3aMb41qyV4vCmRydIyp6KGcwG6hGdAjxYLni0OVSSBFweO3FaLavGFUQi9V1xr6Cp1bpzM+ok6mkZOcgfqYs2ycs2VrpUTfe/CKokitW2oMXW9brHh5Aj9KFr3uula6F9cAo96CBtW0jwOzhaNvbSSnJ5p154pw/l8P0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZnnDLibg; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766478897; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=5n5OK+w8gxWpMj71tDuhpwqNAOAZ1mzZmlORbv1RSSE=;
	b=ZnnDLibgp1o2AVfqBYPZ8PY3bLCjO7KkHN/fBcQdWWFB+sKcbzdglvWGfcgt17JuvLVkuz3WErD0kOHCQByzHZQon+o/tkgimzySAecB1k1DuVBfO0p05iQ+SPKbjP8X5/UfGozhAeNpObpmA0L+8T1TO8KqfNSVJ8fni6n69/k=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX7w8h_1766478896 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:34:56 +0800
Message-ID: <7f03a68f-1831-4158-899c-06ef3317cf67@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:34:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/10] erofs: support unencoded inodes for page cache
 share
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-9-lihongbo22@huawei.com>
 <b2bb83da-8b76-40eb-b563-a0aa9c5436dc@linux.alibaba.com>
In-Reply-To: <b2bb83da-8b76-40eb-b563-a0aa9c5436dc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/12/23 16:15, Gao Xiang wrote:
> 
> 
> On 2025/12/23 09:56, Hongbo Li wrote:
>> This patch adds inode page cache sharing functionality for unencoded
>> files.
>>
>> I conducted experiments in the container environment. Below is the
>> memory usage for reading all files in two different minor versions
>> of container images:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     241     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     872     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     2771    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     926     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     390     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     924     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |     474     |      49%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Additionally, the table below shows the runtime memory usage of the
>> container:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      35     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     149     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     1028    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     155     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      25     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     186     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |      98     |      48%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
> 
> ...
> 
>> index 4b46016bcd03..269b53b3ed79 100644
>> --- a/fs/erofs/ishare.c
>> +++ b/fs/erofs/ishare.c
>> @@ -197,6 +197,37 @@ const struct file_operations erofs_ishare_fops = {
>>       .splice_read    = filemap_splice_read,
>>   };
>> +/*
>> + * erofs_ishare_iget - find the backing inode.
>> + */
>> +struct inode *erofs_ishare_iget(struct inode *inode)
> 
> Just:
> 
> struct inode *erofs_get_real_inode(struct inode *inode)
> 
> `ishare_` prefix seems useless here.
> 
>> +{
>> +    struct erofs_inode *vi, *vi_dedup;
>> +    struct inode *realinode;
>> +
>> +    if (!erofs_is_ishare_inode(inode))
>> +        return igrab(inode);

Also please `return inode;` directly if `erofs_is_ishare_inode`
is off.

No need to bump the inode reference unnecessarily if ishare is off;

>> +
>> +    vi_dedup = EROFS_I(inode);
>> +    spin_lock(&vi_dedup->lock);
>> +    /* fall back to all backing inodes */
>> +    DBG_BUGON(list_empty(&vi_dedup->backing_head));
>> +    list_for_each_entry(vi, &vi_dedup->backing_head, backing_link) {
>> +        realinode = igrab(&vi->vfs_inode);
>> +        if (realinode)
>> +            break;
>> +    }
>> +    spin_unlock(&vi_dedup->lock);
>> +
>> +    DBG_BUGON(!realinode);
>> +    return realinode;
>> +}
>> +
>> +void erofs_ishare_iput(struct inode *realinode)
> 
> Just:
> 
> erofs_put_real_inode().
> 
> Thanks,
> Gao Xiang


