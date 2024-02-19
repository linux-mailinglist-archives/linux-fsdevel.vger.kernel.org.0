Return-Path: <linux-fsdevel+bounces-11966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87465859A58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 02:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279351F21265
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F11FC4;
	Mon, 19 Feb 2024 01:14:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E8653;
	Mon, 19 Feb 2024 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708305289; cv=none; b=oCoaj/QM4bQgLgby+E7c1TOCS1xPWQ85pHdrLkV/ddh7heAtWcowTd1oIb8NQKTuDWTe470RD11RReQNmBY1e+BctOUs6jBACgzFXVu4Gz9FSwUdOXZsA3mFtWWDBKfx+geupTbucjl8WFlg2UfyXXW8ZNRghAxdzlyZZ6h4Obk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708305289; c=relaxed/simple;
	bh=ITsvUtLFTp1JieH+22e8FWpa1zzr2LROlPgee2QxikY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I7qlAL/VUCxWeEXr9ByiXRLyR1xDKMLWxSbv+1vleMWqQCknwWpWgHfB6+wcpdpmhHsQwzoDvcti18vIyGzpHoAYzGIOLgFGHRNhrhhPcdm14jDNyyemiULtUVcyPKC7g9o13HvagDaZRDKTkHg4tcrudMgNoneVpdZAB9cv9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TdPhY1MDMz4f3jdF;
	Mon, 19 Feb 2024 09:14:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 158FF1A0172;
	Mon, 19 Feb 2024 09:14:42 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxB_q9JlUdbNEQ--.27706S3;
	Mon, 19 Feb 2024 09:14:41 +0800 (CST)
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, djwong@kernel.org, willy@infradead.org,
 zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
 <74ab3c3e-3daf-5374-75e5-bcb25ffdb527@huaweicloud.com>
 <ZdKTFp4v1kQuLg9e@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <fce8b7e1-281a-6756-edbc-ca993dd03ebc@huaweicloud.com>
Date: Mon, 19 Feb 2024 09:14:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZdKTFp4v1kQuLg9e@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHlxB_q9JlUdbNEQ--.27706S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw17Ww48ZFWxWr48ur1xZrb_yoW8Gry5pr
	9093ZYkr1ktF1SyrZ7Aay7Xa4rK34xKFy7JF9rWw15JrZ8Zw1Skr48Xa45ua4DA397Xr4F
	v3yvy34rCa15ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/2/19 7:30, Dave Chinner wrote:
> On Sat, Feb 17, 2024 at 04:55:51PM +0800, Zhang Yi wrote:
>> On 2024/2/13 13:46, Christoph Hellwig wrote:
>>> Wouldn't it make more sense to just move the size manipulation to the
>>> write-only code?  An untested version of that is below.  With this
>>
>> Sorry for the late reply and thanks for your suggestion, The reason why
>> I introduced this new helper iomap_write_end_simple() is I don't want to
>> open code __iomap_put_folio() in each caller since corresponding to
>> iomap_write_begin(), it's the responsibility for iomap_write_end_*() to
>> put and unlock folio, so I'd like to keep it in iomap_write_end_*().
> 
> Just because we currently put the folio in iomap_write_end_*(), it
> doesn't mean we must always do it that way.
> 
>> But I don't feel strongly about it, it's also fine by me to just move
>> the size manipulation to the write-only code if you think it's better.
> 
> I agree with Christoph that it's better to move the i_size update
> into iomap_write_iter() than it is to implement a separate write_end
> function that does not update the i_size. The iter functions already
> do work directly on the folio that iomap_write_begin() returns, so
> having them drop the folio when everything is done isn't a huge
> deal...
> 

Sure, I will revise it as you suggested in my next iteration.

Thanks,
Yi.


