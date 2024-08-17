Return-Path: <linux-fsdevel+bounces-26175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220279555CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 08:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2EB1C21BA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B913B78F;
	Sat, 17 Aug 2024 06:43:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B5BA2D;
	Sat, 17 Aug 2024 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877001; cv=none; b=fL8UeP6FZN8wY5MgDHoVDumUH6pc+7WzfjZQCp7mGBhgzk4ozJeqCRjQS1slLCuuV38CAzXDNS7+62W6cUPOLH311GUXhQ09LaqS1XgZ+Sz+NfEb4a8CMOdLvRUmgx5fLjehEC+A9daq2FisEtlnrxwKp8aAYG+6t2imtHgAx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877001; c=relaxed/simple;
	bh=f1W0HHHrGQ+9M+f+peZJqHg5y6H7TaYQhI0iN8WAeVw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IiTi4j9RVuXj8eE6N6gNa3zpJCUYZgRLrIwJT8na5PfyJxgiUm3A4SO3n4qVSp73TOltv+qDq59dQUh7Dv7MFWh0NGwmEdDbAzfOwayojGv23U/r8InBs1cICHDmOqYfNN4DNR7yuP6R8mQBRr62zLNrGaNfrPjkE/Ht1GFLBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wm8SN1VCcz4f3jdF;
	Sat, 17 Aug 2024 14:43:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 22AE61A0568;
	Sat, 17 Aug 2024 14:43:14 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4V+RsBmEPKxBw--.36495S3;
	Sat, 17 Aug 2024 14:43:11 +0800 (CST)
Subject: Re: [PATCH v2 4/6] iomap: correct the dirty length in page mkwrite
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
 <ZsAq11RKg-dRfPv2@casper.infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <53da5ebf-3d91-7c70-1be9-4c8a5485cd17@huaweicloud.com>
Date: Sat, 17 Aug 2024 14:43:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsAq11RKg-dRfPv2@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnj4V+RsBmEPKxBw--.36495S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW8JF18Jr4DKrWDXF4fKrg_yoW8Xr13pa
	yfK3Wqkrn5t3Z7Cwn7uw10qw1Fy3y5KF45ZF1qgr15ArZ8WF1agryxKa1qvay7Kw1ft3WI
	vFWUZ34xCF15ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/17 12:45, Matthew Wilcox wrote:
> On Mon, Aug 12, 2024 at 08:11:57PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When doing page mkwrite, iomap_folio_mkwrite_iter() dirty the entire
>> folio by folio_mark_dirty() even the map length is shorter than one
>> folio. However, on the filesystem with more than one blocks per folio,
>> we'd better to only set counterpart block's dirty bit according to
>> iomap_length(), so open code folio_mark_dirty() and pass the correct
>> length.
> 
> We shouldn't waste any time trying to optimise writing to files through
> mmap().  People have written papers about what a terrible programming
> model this is.  eg https://db.cs.cmu.edu/mmap-cidr2022/
> 
> There are some programs that do it, but they are few and far between.
> 

I don't think it's an optimization, this is a fix, the issue is the same
to the one that previous 2 patches want to fix: there left a hole with
ifs dirty bit set but without any valid data and without any block
allocated/reserved. This mmap() path is just once case that could lead
to this issue (The case if as I said in my reply to Christoph, suppose
we have a 3K regular file on a filesystem with 1K block size. If the
folio size is 4K, In iomap_page_mkwrite(), it will mark all 4 bits of ifs
dirty, the last one will become redundant if we expand the file to 4K
later).

Hence in my opinion, we need to fix this, or it's gonna be a potential
problem one day.

Thanks,
Yi.


