Return-Path: <linux-fsdevel+bounces-25763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E83894FF71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4AB282464
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 08:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C113A409;
	Tue, 13 Aug 2024 08:15:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89015A8;
	Tue, 13 Aug 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536945; cv=none; b=dyiC2YVIaAtdeh31HXu8jPNmRcVL5Sd0/3+ZV+3oawiDJ9Xu+6Tm+0qavYFU9WKChx7CFYURHBg/5hV6loXBrM2QgLjM/wknda8J19X0AxeUkrrVpRwpLKc2nJe8em8jVtRi1EtEAlkLJs4PLQpSUIaCEwcdE8pLM9iK3LXiEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536945; c=relaxed/simple;
	bh=WlatNkw018HnQm9HKSQXQoBGB4Ekp8dvxocMvEtgYJY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H4byky2B3RJ+jdukqgJ5kP3zNt7I7exrHNJOoKUER2qXb3ASP1XoDIon8/A6r7pvFYtTxi2AeOj+4DHSdT7I5cE2MQbzfIpvIEkOpcDFHRFtjW6SldmG3ZQ4YxIfd7AAW0tJ39Vv0hQ/5bzJ1rgzDOtBYy9ydqpmdKUMxH9BdsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wjkhq1bNMz4f3lDV;
	Tue, 13 Aug 2024 16:15:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D700A1A07B6;
	Tue, 13 Aug 2024 16:15:37 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4UoFrtmT_FABg--.12400S3;
	Tue, 13 Aug 2024 16:15:37 +0800 (CST)
Subject: Re: [PATCH v2 6/6] iomap: reduce unnecessary state_lock when setting
 ifs uptodate and dirty bits
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-7-yi.zhang@huaweicloud.com>
 <Zro_yj3agfdhM16Q@casper.infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <9c581bc1-fbaf-86cf-4312-9dc87884a884@huaweicloud.com>
Date: Tue, 13 Aug 2024 16:15:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zro_yj3agfdhM16Q@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXv4UoFrtmT_FABg--.12400S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF45trWDJF13XF1UGw45Jrb_yoW8AFW7pF
	WDKFZ8tF98AFnFkr1xXrn7Ar1Fq34fWFy8Aa4xGanIyF4rCFsrKFWIg34qkFWxtrn3Ar4Y
	qF10qFyfWF4DtrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/13 1:00, Matthew Wilcox wrote:
> On Mon, Aug 12, 2024 at 08:11:59PM +0800, Zhang Yi wrote:
>> @@ -866,9 +899,8 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>>  	 */
>>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>>  		return false;
>> -	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
>> -	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
>> -	filemap_dirty_folio(inode->i_mapping, folio);
>> +
>> +	iomap_set_range_dirty_uptodate(folio, from, copied);
>>  	return true;
> 
> I wonder how often we overwrite a completely uptodate folio rather than
> writing new data to a fresh folio?  iow, would this be a measurable
> optimisation?
> 
> 	if (folio_test_uptodate(folio))
> 		iomap_set_range_dirty(folio, from, copied);
> 	else
> 		iomap_set_range_dirty_uptodate(folio, from, copied);
> 

Thanks for the suggestion, I'm not sure how often as well, but I suppose
we could do this optimisation since I've tested it and found this is
harmless for the case of writing new data to a fresh folio. However, this
can further improves the overwrite performance, the UnixBench tests result
shows the performance gain can be increased to about ~15% on my machine
with 50GB ramdisk and xfs filesystem.

UnixBench test cmd:
 ./Run -i 1 -c 1 fstime-w

Base:
x86    File Write 1024 bufsize 2000 maxblocks       524708.0 KBps
arm64  File Write 1024 bufsize 2000 maxblocks       801965.0 KBps

After this series:
x86    File Write 1024 bufsize 2000 maxblocks       569218.0 KBps
arm64  File Write 1024 bufsize 2000 maxblocks       871605.0 KBps

After this measurable optimisation:
x86    File Write 1024 bufsize 2000 maxblocks       609620.0 KBps
arm64  File Write 1024 bufsize 2000 maxblocks       910534.0 KBps

Thanks,
Yi.


