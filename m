Return-Path: <linux-fsdevel+bounces-65623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A9C08C82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 09:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2AF54E357E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7AD2D3EDD;
	Sat, 25 Oct 2025 07:01:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A96747F;
	Sat, 25 Oct 2025 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375688; cv=none; b=kYOZS8ZP3dqNvp1eCZ+A1+KLK9SX9mojULf3/iT57L8BaVKPZC4rV1rZmcriUUzWHVtoQOh4rvYKY9Qc6tBHl+xWnkPO8kPHITQ3rGrZAXiRNwtbNE7yKENr0zfyH2uJh9EbEStD3UExs3Aj0TCgbagauHx96kE7S2G2gbohC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375688; c=relaxed/simple;
	bh=FQz9P+xUpr9A3LkYjSdmWc3Lh5lgl2cfI8kE+e/p4SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRvFNFXzZmCpK+d5h7sUXdXYQ5n3Qhgm9PENmaIwz+fefe1lreMeN/bbhKm/1Suu2adN6qv5zSbUNHO9Q2l0jrBzxR4qWcDIySz6juvMX34Vet05B2Fc8MBwM9NDU4qge8WSk8LPnV4eBkKPg/e3iGrg8OaHMq10kZUO45jJCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrJ76Wg0zYQtsr;
	Sat, 25 Oct 2025 15:00:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C43CE1A0D86;
	Sat, 25 Oct 2025 15:01:22 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBXrETAdfxomP4rBg--.46683S3;
	Sat, 25 Oct 2025 15:01:22 +0800 (CST)
Message-ID: <9e963efb-fe5b-477c-afaf-f0b0677648f8@huaweicloud.com>
Date: Sat, 25 Oct 2025 15:01:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
To: Baokun Li <libaokun@huaweicloud.com>, Matthew Wilcox
 <willy@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
 mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-23-libaokun@huaweicloud.com>
 <aPxV6QnXu-OufSDH@casper.infradead.org>
 <adccaa99-ffbc-4fbf-9210-47932724c184@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <adccaa99-ffbc-4fbf-9210-47932724c184@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXrETAdfxomP4rBg--.46683S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWkCFWDXrW8JrWfCr17Jrb_yoW8Xw4UpF
	WkCF4xKFykJr1Du3W8Z3W5tFyaka1rWF4UCF4xt34fCF1qg343W39Fk3WFkFyayFW5A340
	qrWxtFZru3ZxA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/25/2025 2:32 PM, Baokun Li wrote:
> On 2025-10-25 12:45, Matthew Wilcox wrote:
>> On Sat, Oct 25, 2025 at 11:22:18AM +0800, libaokun@huaweicloud.com wrote:
>>> +	while (1) {
>>> +		folio = __filemap_get_folio(mapping, index, fgp_flags,
>>> +					    gfp & ~__GFP_NOFAIL);
>>> +		if (!IS_ERR(folio) || !(gfp & __GFP_NOFAIL))
>>> +			return folio;
>>> +
>>> +		if (PTR_ERR(folio) != -ENOMEM && PTR_ERR(folio) != -EAGAIN)
>>> +			return folio;
>>> +
>>> +		memalloc_retry_wait(gfp);
>>> +	}
>> No, absolutely not.  We're not having open-coded GFP_NOFAIL semantics.
>> The right way forward is for ext4 to use iomap, not for buffer heads
>> to support large block sizes.
> 
> ext4 only calls getblk_unmovable or __getblk when reading critical
> metadata. Both of these functions set __GFP_NOFAIL to ensure that
> metadata reads do not fail due to memory pressure.
> 
> Both functions eventually call grow_dev_folio(), which is why we
> handle the __GFP_NOFAIL logic there. xfs_buf_alloc_backing_mem()
> has similar logic, but XFS manages its own metadata, allowing it
> to use vmalloc for memory allocation.
> 
> ext4 Direct I/O has already switched to iomap, and patches to
> support iomap for Buffered I/O are currently under iteration.
> 
> But as far as I know, iomap does not support metadata, and XFS does not
> use iomap to read metadata either.
> 
> Am I missing something here?
> 

AFAIK, Unless ext4 also manages metadata on its own, like XFS does,
instead of using the bdev buffer head interface. However, this is
currently difficult to achieve.

Best Regards,
Yi.


