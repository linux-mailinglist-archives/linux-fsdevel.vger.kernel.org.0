Return-Path: <linux-fsdevel+bounces-65621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC25FC08C40
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 08:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83B914E91EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E832D97AA;
	Sat, 25 Oct 2025 06:33:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9127A122;
	Sat, 25 Oct 2025 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761374000; cv=none; b=LeIQD4SNKGKbwp225IGklV6EeVadOjUphBb3Cu8+7UiEE4RDf9C7jj4WvvKIkYIs+Ugmby7nzdSUSywrwIL4WXnnnZ4fhgm1ZPt2BDiDlfraX07iEEDKBeC1kpfA9XoWYQ1WvIhzKzmd1wfw2+Xl9mBpMSSmsdNMjEoMLSji+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761374000; c=relaxed/simple;
	bh=ctSRq6I+opkla8CezO86rPe++ILpgc2HAX6UyIl5NQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FG5MEW9yAC9RowmdQgALHylYP2J3Me/cXl0n6JTDHGzifsSI2X5yaQLiSUetB9511Xju+sf4z07WFxiveuA9nO6I9fyrJVJWqx+96P7WcdC6qFO/emj+axmNuqWKcqxbYJcD8Xe+BGfaQ3wO3pjGNc/IhIhtwcv9FgQScJ0uKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctqgh1RjQzKHLvL;
	Sat, 25 Oct 2025 14:32:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1972A1A150E;
	Sat, 25 Oct 2025 14:33:08 +0800 (CST)
Received: from [10.174.178.254] (unknown [10.174.178.254])
	by APP2 (Coremail) with SMTP id Syh0CgBnvUUWb_xojropBg--.48200S3;
	Sat, 25 Oct 2025 14:33:07 +0800 (CST)
Message-ID: <adccaa99-ffbc-4fbf-9210-47932724c184@huaweicloud.com>
Date: Sat, 25 Oct 2025 14:32:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
 mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
 libaokun1@huawei.com
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-23-libaokun@huaweicloud.com>
 <aPxV6QnXu-OufSDH@casper.infradead.org>
From: Baokun Li <libaokun@huaweicloud.com>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id2
Fcc: imap://libaokun%40huaweicloud.com@cnp3.mail02.huawei.com/Sent
In-Reply-To: <aPxV6QnXu-OufSDH@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnvUUWb_xojropBg--.48200S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4ktw47Kw13CF47Zr43Wrg_yoW8Jw4xpF
	WvkF1IqFykJr1kZF1kZw13JFyak3y8JF4UCay7t3sxuFn8Ja4agrsFk3WFkFySkryUAw10
	qFWxtrZ7u3ZxA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UG-eOUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWj7UbRPggABsy

On 2025-10-25 12:45, Matthew Wilcox wrote:
> On Sat, Oct 25, 2025 at 11:22:18AM +0800, libaokun@huaweicloud.com wrote:
>> +	while (1) {
>> +		folio = __filemap_get_folio(mapping, index, fgp_flags,
>> +					    gfp & ~__GFP_NOFAIL);
>> +		if (!IS_ERR(folio) || !(gfp & __GFP_NOFAIL))
>> +			return folio;
>> +
>> +		if (PTR_ERR(folio) != -ENOMEM && PTR_ERR(folio) != -EAGAIN)
>> +			return folio;
>> +
>> +		memalloc_retry_wait(gfp);
>> +	}
> No, absolutely not.  We're not having open-coded GFP_NOFAIL semantics.
> The right way forward is for ext4 to use iomap, not for buffer heads
> to support large block sizes.

ext4 only calls getblk_unmovable or __getblk when reading critical
metadata. Both of these functions set __GFP_NOFAIL to ensure that
metadata reads do not fail due to memory pressure.

Both functions eventually call grow_dev_folio(), which is why we
handle the __GFP_NOFAIL logic there. xfs_buf_alloc_backing_mem()
has similar logic, but XFS manages its own metadata, allowing it
to use vmalloc for memory allocation.

ext4 Direct I/O has already switched to iomap, and patches to
support iomap for Buffered I/O are currently under iteration.

But as far as I know, iomap does not support metadata, and XFS does not
use iomap to read metadata either.

Am I missing something here?


-- 
With Best Regards,
Baokun Li


