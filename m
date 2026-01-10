Return-Path: <linux-fsdevel+bounces-73132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD2D0D5BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 12:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8344301512D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9833F361;
	Sat, 10 Jan 2026 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gjpebjqe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7333F8B3;
	Sat, 10 Jan 2026 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768046127; cv=none; b=cM1o4uubu9sTiTMp6rSvrvU3xzif7ksujZxXy0/s2sScvXJcdBPH5xsdOFBo9Sq5B/xe20xMGHMZugTItMMMix6G5U1AxfaaiU2Kt/0oX2jMw101mE6OHTb480q+BqbEtj5riEU7K1B7QLNKPoxaY1gZGXf5qyZrbCEUW5assl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768046127; c=relaxed/simple;
	bh=Ug0l++bYTzACL7Hxtt5v9LMNdtpmsl9Ur3oAJnI/L+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPGfxdX0vH2nOWuIVthg0qboQ+i9Ez/jyVlJEEXkJpBMOXOLhW/pB+VveVQTVRY1VrryRiCvtauQP/5NRzD/Z1PwC3hE+XcA0c6Wlmglr4Yy/QooZG0HsLmQWIN1E/k9utrGOVvewmxtiscm/AB8OtjnjvCp5C8JSjWlZWXrwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gjpebjqe; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768046114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=erwwePJ+8II8k641PkE+2cYBtLxUw8inNwTyx6ghjKM=;
	b=Gjpebjqenl01BdmdKY6czBcCXunMyQcRu4sUCbFAb3xCXdfs4B0Grg1gYFQ8RV8AFZOn8F0YPJAgSXgpvMz1Azm11bgYmb/mEl0lUHBjIf7bGMHF0oOgYMA+OaeM9z1QNQXkxIAF91tJqzD9qWopeHe7IX5dW4T+kGEoC1sZZ7Q=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwjsYtx_1768046113 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 10 Jan 2026 19:55:13 +0800
Message-ID: <e3e1f6e5-c4ac-4913-a41b-20edbc1d7a46@linux.alibaba.com>
Date: Sat, 10 Jan 2026 19:55:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chao@kernel.org, brauner@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-2-lihongbo22@huawei.com>
 <20260109181442.GA15532@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109181442.GA15532@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Darrick,

On 2026/1/10 02:14, Darrick J. Wong wrote:
> On Fri, Jan 09, 2026 at 10:28:47AM +0000, Hongbo Li wrote:
>> It's useful to get filesystem-specific information using the
>> existing private field in the @iomap_iter passed to iomap_{begin,end}
>> for advanced usage for iomap buffered reads, which is much like the
>> current iomap DIO.
>>
>> For example, EROFS needs it to:
>>
>>   - implement an efficient page cache sharing feature, since iomap
>>     needs to apply to anon inode page cache but we'd like to get the
>>     backing inode/fs instead, so filesystem-specific private data is
>>     needed to keep such information;
>>
>>   - pass in both struct page * and void * for inline data to avoid
>>     kmap_to_page() usage (which is bogus).
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> This looks like a dead simple patch to allow iomap pagecache users to
> set iomap_iter::private, so no objections here:
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks for the review!

Thanks,
Gao Xiang

> 
> --D
> 

