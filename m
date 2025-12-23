Return-Path: <linux-fsdevel+bounces-71948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8980CD7E10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 03:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62023030D8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437F125F994;
	Tue, 23 Dec 2025 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HZ3ATcnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A61238C23;
	Tue, 23 Dec 2025 02:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457173; cv=none; b=PXEcuOopKZ+3fltxcKrJ46MWDYX2Q2/6lOKZCHWmvZuY/8WfbtDkB6Q2NRj6HTBDXC3OboO/T52KDgs7luaqkPhTGFoTtxgASsWlVZnhXU2a0EAtsZWxBfYfp1D8eYxXRtV92WObUyIPr7b2VREJ/Ee2N6zZBVNzIdVOH+Hh658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457173; c=relaxed/simple;
	bh=zdCVb9dsqLqB0unk2n7IZNXWmQkfEMayacYldJsDPsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orrNLhlma9KGWRiwd3plESGwMxFH7gNdOCwtRWe6UNg3YBD2PArNTV15r4vJAO32INa6+nls3GuYKyD90DD9MFJwjiOhu0HXhomQYD52XWRvGlja6iK26o81IFKXopQuAbgZ2Dqw0uXUl2jMqpEKQx3/oVGGp64tZnzhC2mu9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HZ3ATcnV; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766457167; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LafoTpYEo1plUM3lq+PWv9KVMIu0u9uxFJf3gdwcn2s=;
	b=HZ3ATcnVPc6foLiadTcmiPlF52U/6xh+m0NCOb7myVL8HOxGfKupd8x+HbgQHI0BaEw4vm2oWtDbdW8KZNdqdDWDQvA0P2/qiyTQ0O9HB/vgjozL09hxcjsY7chdjLnv8k+UOwM4AO+aemLDRXFliq4vShbyiyg4x+uYIXbpKCs=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvVyoMz_1766457166 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 10:32:47 +0800
Message-ID: <65cf64e7-c395-4508-9bac-5a8dc08e8f3c@linux.alibaba.com>
Date: Tue, 23 Dec 2025 10:32:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/10] erofs: hold read context in iomap_iter if
 needed
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-3-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-3-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/23 09:56, Hongbo Li wrote:
> Introduce `struct erofs_iomap_iter_ctx` to hold both `struct page *`
> and `void *base`, avoiding bogus use of `kmap_to_page()` in
> `erofs_iomap_end()`.
> 
> With this change, fiemap and bmap no longer need to read inline data.
> 
> Additionally, the upcoming page cache sharing mechanism requires
> passing the backing inode pointer to `erofs_iomap_{begin,end}()`, as
> I/O accesses must apply to backing inodes rather than anon inodes.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

