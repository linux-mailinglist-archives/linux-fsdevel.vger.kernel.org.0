Return-Path: <linux-fsdevel+bounces-65622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA845C08C3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 08:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895C33BFB93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 06:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3932D9EC8;
	Sat, 25 Oct 2025 06:34:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC82D592C;
	Sat, 25 Oct 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761374051; cv=none; b=enLCgQymgG731yNMiBA2VqyA6cnaxYSCWcYZ6nvCyV1cXrt/XBIW5ltp/Q+hzstXI9ZAwQt/NtkZbmGKFUAtIfKKk9hnxoa+F8gnpmOytKQ15m01F3OHF68VoLnnL/PXPXh2bJzGdchuFxxXtDY/ijot15x9En3BsJ3p/ZOj+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761374051; c=relaxed/simple;
	bh=ctSRq6I+opkla8CezO86rPe++ILpgc2HAX6UyIl5NQI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LJNCXh4qrzyJAwCu04xooWj83392cdMF61mxXoawENhbXqGZBM+AWHcqQ1CCy1WK3IheFlvoT+6lmjLPIEP+yiaYrge9CV07GDy3wb3yEdU8NGL3QC3najJ4xc3KfjOKLdXwwdxE1qpQbFQf1Q22WD+9A/1Xl20jexr9Sxlz8Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctqhg4lk9zYQtmK;
	Sat, 25 Oct 2025 14:33:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 800D61A0902;
	Sat, 25 Oct 2025 14:34:06 +0800 (CST)
Received: from [10.174.178.254] (unknown [10.174.178.254])
	by APP2 (Coremail) with SMTP id Syh0CgBXrUVdb_xoutIpBg--.48673S3;
	Sat, 25 Oct 2025 14:34:06 +0800 (CST)
Message-ID: <26839410-f131-4a7b-857e-c0c159981a83@huaweicloud.com>
Date: Sat, 25 Oct 2025 14:34:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
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
Content-Language: en-GB
In-Reply-To: <aPxV6QnXu-OufSDH@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXrUVdb_xoutIpBg--.48673S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4ktw47Kw13CF47Zr43Wrg_yoW8Jw4xpF
	WvkF1IqFykJr1kZF1kZw13JFyak3y8JF4UCay7t3sxuFn8Ja4agrsFk3WFkFySkryUAw10
	qFWxtrZ7u3ZxA37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j4eHgUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAMBWj7Ua9PfQABsV

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


