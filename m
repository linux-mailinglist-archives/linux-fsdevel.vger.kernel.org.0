Return-Path: <linux-fsdevel+bounces-32289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC79A323E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 03:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A141F2407A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 01:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F384D02;
	Fri, 18 Oct 2024 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="THXb7t26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA52383B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216099; cv=none; b=XzIQogJp/fDtPWp3gcGnslKNZvy2+h8IHCjApl2RWOAsfuYweiG+yd0eneC6zhhODcaBPrmf6TEF7p/dweR6S4Bvft2tsi7qGQ+wukQXfevqg8HteH0YWSNejM734q8CnzTcwU1XG5UVWhOLMUopS7WbtNssh7IdZCyROKGop/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216099; c=relaxed/simple;
	bh=/LK3K43yOwvnDWpaQ9ijkKS5ejp07ilYIiBcRUn2Tlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xa6vdPMrF7HIPsYPeEQeTKwW/lmHx8aFKqSbf0fH3bqFSdjfZydFNiAAr+CfYmrxPGXYZGzh3N4KYG8HZ6lRbk8OyVCwLHApaBwqLWSQqNN+2i6J78UQQfHntmBKLtCRuWheEicVsVslqPU1icynWrqUM6dZdJvLjMjXRZJFb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=THXb7t26; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729216095; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LMzFQJ+MQxsjiVBgPQeSZnqWNsIE1T32XgixNluk0VQ=;
	b=THXb7t26ShfW6EXhfZi738Nn1E2J/gYp8d9ZJ0ZciPwPnHliFnC1TzJOopWp7RguyTmzb8dYsA01qO3T+EuLHhbVKqFsviSmr1l1PkocgCJyfd8oNsNgTeFLYGjwpEEsWyXqssUCPNrCp0QaH+/cPajTPFmMHYBe/8LEfkRxnRY=
Received: from 30.74.144.131(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHMOE-A_1729216094 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 09:48:14 +0800
Message-ID: <16ad1436-1a97-493c-84df-d82208e547f4@linux.alibaba.com>
Date: Fri, 18 Oct 2024 09:48:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tmpfs: don't enable large folios if not supported
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
References: <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <20241017141742.1169404-1-wangkefeng.wang@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241017141742.1169404-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/17 22:17, Kefeng Wang wrote:
> The tmpfs could support large folio, but there is some configurable
> options(mount options and runtime deny/force) to enable/disable large
> folio allocation, so there is a performance issue when perform write
> without large folio, the issue is similar to commit 4e527d5841e2
> ("iomap: fault in smaller chunks for non-large folio mappings").
> 
> Since 'deny' for emergencies and 'force' for testing, performence issue
> should not be a problem in the real production environments, so only
> don't call mapping_set_large_folios() in __shmem_get_inode() when
> large folio is disabled with mount huge=never option(default policy).
> 
> Fixes: 9aac777aaf94 ("filemap: Convert generic_perform_write() to support large folios")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> v4:
> - only fix mount huge=never since runtime deny/force just for
>    emergencies/testing, suggested by Baolin
> v3:
> - don't enable large folio suppport in __shmem_get_inode() if disabled,
>    suggested by Matthew.
> v2:
> - Don't use IOCB flags
> 
>   mm/shmem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e933327d8dac..74ef214dc1a7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2827,7 +2827,10 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>   	cache_no_acl(inode);
>   	if (sbinfo->noswap)
>   		mapping_set_unevictable(inode->i_mapping);
> -	mapping_set_large_folios(inode->i_mapping);
> +
> +	/* Don't consider 'deny' for emergencies and 'force' for testing */
> +	if (sbinfo->huge)
> +		mapping_set_large_folios(inode->i_mapping);
>   
>   	switch (mode & S_IFMT) {
>   	default:

