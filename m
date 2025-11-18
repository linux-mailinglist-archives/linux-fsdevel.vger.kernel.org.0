Return-Path: <linux-fsdevel+bounces-68906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66724C68056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C4434F28BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F98306B38;
	Tue, 18 Nov 2025 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a48eK1GG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291363002C5;
	Tue, 18 Nov 2025 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451358; cv=none; b=eCG1X0AlHN+Wjhm3OmgMrc3WQ7Icsd8WwqXp2zd5tDt4LFMP0Nb47IBYL94MAY95dWZPmhXrU1JuM40dzhpHB6OJlvqCjw9iU4wmXW+vVGFhudJfSaeyAsh77WMw87XL0dGGrYAdKOjMgSPJ5SEYdsDNuA+CiE+Mp65TeGznAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451358; c=relaxed/simple;
	bh=BTVGvoakackj0IObJ5XeQFZTQxv2lmYyS2m11Wbz1vc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YxyYj0wZZ8erUugrl7rpzfNTUqRH7Ot8tmN03HUE4KbJ7s/nQ8lHOXUT2oakAOuNNOpb7IF1pGPFdt42DL+I9b2EHB5XPLWGn+5Yo6JvX05JFmmLlqScBjkCiGfzKSTL2ilo2UpOllyxiQbHBOMgBMgu/oVqiyGGuQddTg127dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a48eK1GG; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763451347; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=UnsKcX6SJf5cwGhxDgVLSUzRD0ZhhZ/01A1WzVuNbgQ=;
	b=a48eK1GGuXSjhRAJZGGFwgWsXJbvUPyLAhAVL0/EmTCoRlcvAlivJV2WziS0aK+OTLpDWzNM5lwcHunTcY7EduQZ/+1XJhuLTVMaMzUSHTXkA833P3chrkkyFyDBiWMbjSz1plyu1I0bymQj2LnBbsWtH/qeFqHnUGSjXGT2BFc=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wsiew2h_1763451346 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Nov 2025 15:35:46 +0800
Message-ID: <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
Date: Tue, 18 Nov 2025 15:35:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private field
 of iomap_iter
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: brauner@kernel.org, djwong@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
 Hongbo Li <lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-2-lihongbo22@huawei.com>
 <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
In-Reply-To: <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

(... try to add Christoph..)

On 2025/11/18 01:08, Gao Xiang wrote:
> Hi Darrick, Christian,
> 
> On 2025/11/17 21:25, Hongbo Li wrote:
>> It's useful to get filesystem-specific information using the
>> existing private field in the @iomap_iter passed to iomap_{begin,end}
>> for advanced usage for iomap buffered reads, which is much like the
>> current iomap DIO.
>>
>> For example, EROFS needs it to:
>>
>>   - implement an efficient page cache sharing feature, since iomap
>>     needs to apply to anon inode page cache but we'd like to get the
>>     backing inode/fs instead, so filesystem-specific private data is
>>     needed to keep such information;
>>
>>   - pass in both struct page * and void * for inline data to avoid
>>     kmap_to_page() usage (which is bogus).
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Could you help review this iomap change, since erofs uses iomap
> and erofs page cache sharing needs this change, as I told
> Joanne months ago.
> 
> Even without the page cache sharing feature, introducing
> iomap_iter_ctx for .iomap_{begin,end}, like the current DIO
> does, is still useful for erofs, as patch 2 mentioned.

I know it could be somewhat too late to introduce the entire
feature for 6.19, but could we consider the first two patches
(patch 1 and 2) if possible? because:

  - patch 1 just adds a way to specify iter->private for buffered
    read since there was no way to pass on-stack fs-specific
    contexts from .iomap_begin() to .iomap_end() for iomap
    buffered read.

    Actually patch 1 doesn't introduce any new logic or behavior
    to iomap itself, just add a way to specify iter->private, I
    think it does no harm to the iomap stability.

  - patch 2 tries to avoid kmap_to_page() usage since previously
    there is no way to pass both `void *` and `struct page *`
    from .iomap_begin() to .iomap_end() because inline data
    handling needs both.

    Actually people would like to get rid of kmap_to_page(), for
    example:
    https://lore.kernel.org/r/Y5u+oOLkJs6jehik@iweiny-desk3

    So I wonder if patch 1 and 2 can be considered as an
    individual improvement for 6.19.

  - Currently the page cache sharing series is coupled with iomap,
    but the main change is still in erofs itself.  If the first
    two patches can be applied in advance, that would make the
    remaining part through erofs tree without treewide conflict
    like this.

Just my two cents.

Thanks,
Gao Xiang

