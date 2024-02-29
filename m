Return-Path: <linux-fsdevel+bounces-13177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4D386C4D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6013BB24114
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35B59B66;
	Thu, 29 Feb 2024 09:20:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DDE59167;
	Thu, 29 Feb 2024 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198412; cv=none; b=l9bI09sc8Di4ZFkKZQrcnfk3icHA90p+dMkGZq4n666FyBk7tsmkPXPXw+hl1N0bi6FXCSs0RrbU8qZwJ6I1G3u3QNxjucuhn5/hL1T6LUuDCH4QCaO6Q5nQ1kmSUBxBKcGWcD/moc0m88iW5cL3b7u/Rwtw2YcmMbvh3QPaHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198412; c=relaxed/simple;
	bh=iGHP7pwpeOVDDFpZ0noQ898rYHBuWLE3gLeIZkVM71E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aiDzo7P3A4GhJGuqlczsZ/MSdeg33AebzehUaCDn0LjtGBn/5knAN/8rKWKCBEpgMO4lls6T2KU8WwlzSdKlbXkcsRsJRRF58dcgwbilD9RCsEOm5VhryTInY1eKSfrz/3AXYWm6jfek+IqH1v6v3IqNN5QSpF+srZb6A9bRWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tllzz1psXz4f3jHd;
	Thu, 29 Feb 2024 17:19:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7E5281A0F7F;
	Thu, 29 Feb 2024 17:20:04 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ5BTOBl5aoEFg--.45042S3;
	Thu, 29 Feb 2024 17:20:04 +0800 (CST)
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
To: Christoph Hellwig <hch@infradead.org>
Cc: djwong@kernel.org, Dave Chinner <david@fromorbit.com>,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 ritesh.list@gmail.com, willy@infradead.org, zokeefe@google.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
 <9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com>
 <Zd-v_25DKYI1hn-l@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <9c9f1831-a772-299b-072b-1c8116c3fb35@huaweicloud.com>
Date: Thu, 29 Feb 2024 17:20:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zd-v_25DKYI1hn-l@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHZQ5BTOBl5aoEFg--.45042S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1UWFy7tF1xCryxKw15urg_yoW8GF1Dpr
	WF9FykKr1qg3y5ur1kuay7Jw10kw1fZrW8Aryjgw45Gan3XFyxZryjgay09FWqgrZ7Zw1Y
	qF4UWaySyry0vaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUFDGOUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hello Christoph!

On 2024/2/29 6:13, Christoph Hellwig wrote:
> On Wed, Feb 28, 2024 at 04:53:32PM +0800, Zhang Yi wrote:
>> So, we have to handle above case for xfs. I suppose we could keep
>> increasing i_size if the zeroed folio is entirely outside of i_size,
>> make sure we could write back and allocate blocks for the
>> zeroed & delayed extent, something like below, any suggestions ?
> 
> Sorry for being dumb, but what was the problem solved by not updating
> the size for ext4 again?  (for unshare I can't see any reason to
> ever update the inode size)
> 

The problem I want to slove by not updating the size for ext4 is
truncate. Now ext4 use iomap_zero_range() for the case of zero
partial blocks, and ext4's truncate is different from xfs.

Let's think about a simple case, we have a reg file with size 3K,
then truncate it to 1K. ext4 first set i_size to 1K and then call
ext4_block_truncate_page() to zero out data after 1K(EOF) through
iomap_zero_range(). But now it will update i_size in
iomap_write_end(), so the size of the file will increase to 4K,
this is wrong. xfs first zero out data through iomap_truncate_page()
and then set file size to 1K, so the file size is 3K->4K->1K.
Although the result is correct, but the increasing in
iomap_zero_range() is also not necessary, so so I'm just gonna
delete the i_size updating in iomap_zero_range(). It's not for
unhare.

Thanks,
Yi.



