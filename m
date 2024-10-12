Return-Path: <linux-fsdevel+bounces-31792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA199B08B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 05:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF002837A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 03:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107A85656;
	Sat, 12 Oct 2024 03:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ejfdDoEp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B1224D7
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Oct 2024 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705591; cv=none; b=A6aGwnxR7pLR449eKPm1LAv4HRiup+ftXZgM8tmSDVFUGMoXu4JTt7Q2pYV3CQqbIQhtHGa8Em0xEXNr9+VVwfdH3iEtNp7lSAtGriBJEXuWLi/s1BwS44PQmFdcGeB8uVaCoI02dr/PwafXHRfkljVf0dlpthMZAdHoseM2RqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705591; c=relaxed/simple;
	bh=xTk/jgl8aLF2qBdhXrUYikHvAjALPt+gA7k/hvAjAZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRs93YZ31pwfT8do5hHjOGCFfnobq7as1vabJjFIRu+RhZMnkRcJqXVqybpc87VHt20pmdk8bg28GRnqhvuUivplO5RKAmhVYJWyRjQLyWey6ymvTkpWMxZhfhFDugIrhY+QbVSELRqSeHCJYwprZvk5uVghmpTj6/D2q0Fw8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ejfdDoEp; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728705579; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UYj35hoGtiu9zkkHRVDTINPh/FPLkegdGt99B9GNDmw=;
	b=ejfdDoEptwhUvd3owZt0aQJZAxOx5SlDQkOQ7GGAq2mW/JkOfNuxVphqhez6aOQtPXCPYojExpNiNEF89Y5n4Cqr3hHUKkUpobvulp5OEdYPNlP6rhnxipnO95ZVhnhmkE2ZyyC33pLisXIApOb3X0zXKVQq5YygieYolReAMOM=
Received: from 30.39.170.112(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGtulhJ_1728705577 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 11:59:39 +0800
Message-ID: <f29f5635-ed4d-49a6-957b-868c9d07e577@linux.alibaba.com>
Date: Sat, 12 Oct 2024 11:59:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tmpfs: don't enable large folios if not supported
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
References: <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <20241011065919.2086827-1-wangkefeng.wang@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241011065919.2086827-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/11 14:59, Kefeng Wang wrote:
> The tmpfs could support large folio, but there is some configurable
> options(mount options and runtime deny/force) to enable/disable large
> folio allocation, so there is a performance issue when perform write
> without large folio, the issue is similar to commit 4e527d5841e2
> ("iomap: fault in smaller chunks for non-large folio mappings").
> 
> Don't call mapping_set_large_folios() in __shmem_get_inode() when
> large folio is disabled to fix it.
> 
> Fixes: 9aac777aaf94 ("filemap: Convert generic_perform_write() to support large folios")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> 
> v3:
> - don't enable large folio suppport in __shmem_get_inode() if disabled,
>    suggested by Matthew.
> 
> v2:
> - Don't use IOCB flags
> 
>   mm/shmem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0a2f78c2b919..2b859ac4ddc5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2850,7 +2850,10 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>   	cache_no_acl(inode);
>   	if (sbinfo->noswap)
>   		mapping_set_unevictable(inode->i_mapping);
> -	mapping_set_large_folios(inode->i_mapping);
> +
> +	if ((sbinfo->huge && shmem_huge != SHMEM_HUGE_DENY) ||
> +	    shmem_huge == SHMEM_HUGE_FORCE)
> +		mapping_set_large_folios(inode->i_mapping);

IMHO, I'm still a little concerned about the 'shmem_huge' validation. 
Since the 'shmem_huge' can be set at runtime, that means file mapping 
with 'huge=always' option might miss the opportunity to allocate large 
folios if the 'shmem_huge' is changed from 'deny' from 'always' at runtime.

So I'd like to drop the 'shmem_huge' validation and add some comments to 
indicate 'deny' and 'force' options are only for testing purpose and 
performence issue should not be a problem in the real production 
environments.

That's just my 2 cents:)

