Return-Path: <linux-fsdevel+bounces-31559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2DE998756
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047031C2409D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783B51C8FCA;
	Thu, 10 Oct 2024 13:15:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1411DA5E;
	Thu, 10 Oct 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566156; cv=none; b=hhC3DJZD6ZhiboUC7I+xkY1doKGG/6SV1M79+VlmC7gJTta5hFs/NAO1yX33NsqWHl7BGeGfCZvgxDBlJ1fQ95Tg/YAbll+FZZJhiFc3ULq+XEPPj1OLqsYQbEEuuJnYr+di+m7LlUnMtc3H4FyddNeXVzuwzpBtC4e1u/ERGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566156; c=relaxed/simple;
	bh=j9rvBLK5DNkaG0SsQhJKznK+8rXaTNDvib029k1ChZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fuCj/fi1AT9eSU1E70F9JU1EIQ64uETipzYU77XjEhGZMgTIrzi3czo//hyKNIZHq/k7cYk2xAbjm7N84ywIiiKGKUnRc0DnTtihOqegK1Yx+0Tn8H7Tdx/6oEgEpHIq/PNyyKejp2UMAUeI/Rjz8dC0WzFYyY5CqZ4pOd4i9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XPVcr1KgGz2KXwr;
	Thu, 10 Oct 2024 21:15:56 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BA30180041;
	Thu, 10 Oct 2024 21:15:51 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 21:15:50 +0800
Message-ID: <14905d87-9fc4-45c8-b845-d3f4badecf46@huawei.com>
Date: Thu, 10 Oct 2024 21:15:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] cachefiles: Fix incorrect block calculations in
 __cachefiles_prepare_write()
To: David Howells <dhowells@redhat.com>
CC: <netfs@lists.linux.dev>, <jlayton@kernel.org>,
	<hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<libaokun1@huawei.com>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>
References: <e94a52d9-ded4-4a22-90d5-18cb7665607b@huawei.com>
 <20240821024301.1058918-2-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <302546.1728556499@warthog.procyon.org.uk>
 <304311.1728560215@warthog.procyon.org.uk>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <304311.1728560215@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2024/10/10 19:36, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> For scenarios such as nfs/cifs, the corresponding bsize is PAGE_SIZE aligned
> 
> cache->bsize is a property of the cache device, not the network filesystems
> that might be making use of it (and it might be shared between multiple
> volumes from multiple network filesystems, all of which could, in theory, have
> different 'block sizes', inasmuch as network filesystems have block sizes).
> 
> David
> 

Sorry, I might have a slightly different idea now. The EROFS process
based on fscache is similar to NFS and others, supporting only
PAGE_SIZE-granularity reads/writes, which is fine. The issue now lies in
the __cachefiles_prepare_write() function, specifically in the block
count calculation when calling cachefiles_has_space(). By default, the
block size used there is PAGE_SIZE.

If the block size of the underlying cache filesystem is not PAGE_SIZE
(for example, smaller than PAGE_SIZE), it leads to an incorrect
calculation of the required block count, which makes the system think
there is enough space when there might not be. This should be the same
problem for all network file systems that specify the back-end cache
file system mode.

For example, assume len=12k, pagesize=4k, and the underlying cache
filesystem block size is 1k. The currently available blocks are 4, with
4k of space remaining. However, cachefiles_has_space() calculates the
block count as 12k/4k=3, and since 4 > 3, it incorrectly returns that
there is enough space.

Therefore, I believe this could be a general issue. If
cachefiles_add_cache() is part of a common workflow, then using
cache->bsize here might be more appropriate? Looking forward to your
reply.

Thanks,
Zizhi Wo

> 

