Return-Path: <linux-fsdevel+bounces-25892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35889515D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8297E28AB50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E448C13D518;
	Wed, 14 Aug 2024 07:49:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335813CFAD;
	Wed, 14 Aug 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621789; cv=none; b=DjJijwmUmnUKr9VE8un0iSYk3bSWZtT7GhhJZeE+gEvYIUzJzTyg17LWNV784u5qi4oZxoLi6K+Mk5HfM96nSJGoQh6WgZMRDPYJw1eSGnYHRKeH8J8rCoVKWy2TwipN8p8utywmS56D6ix3649UpLEim2/0nNfxxHFOd85PPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621789; c=relaxed/simple;
	bh=X0BPic8eQPasyPeyCHg42srZGxwKg9hcdcACQW/ypxw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rn/l/dyObdYr9eXpUtXS3ABNdd/K+zyxMqEx726gZ30EgChYUROfdb7ENJZxuZZKXJSnpgjkBjL8XTc/n5Ouc8rnbL0nDyDNlxn7XDzSn/qYgSnqjSNrE1mNd0RbQsACcK4lA6b1HOWsZHpD5ocYC8HzZTBUw3GfVkY1xgB6d5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WkL4Z0lQZz4f3jjn;
	Wed, 14 Aug 2024 15:49:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6AB071A07B6;
	Wed, 14 Aug 2024 15:49:43 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4WVYbxm4kqdBg--.48851S3;
	Wed, 14 Aug 2024 15:49:43 +0800 (CST)
Subject: Re: [PATCH v2 4/6] iomap: correct the dirty length in page mkwrite
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
 <ZrxCYbqSHbpKpZjH@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <7824fcb7-1de9-7435-e9f7-03dd7da6ec0a@huaweicloud.com>
Date: Wed, 14 Aug 2024 15:49:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZrxCYbqSHbpKpZjH@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnj4WVYbxm4kqdBg--.48851S3
X-Coremail-Antispam: 1UD129KBjvJXoWrZF45Gw15ZrW3JF4fuFW7Jwb_yoW8JryrpF
	ZxK3WkGr1kK397u3s3C34fJr1F9342vr4YkF1UGr15CF93Wr1IgF47Ka1vv3W5Kw1ftw4S
	qay0gryUW3WUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/8/14 13:36, Christoph Hellwig wrote:
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
> What about moving the folio_mark_dirty out of the loop and directly
> into iomap_page_mkwrite so that it is exactly called once?  The
> iterator then does nothing for the !buffer_head case (but we still
> need to call it to allocate the blocks).
> 

Sorry, this makes me confused. How does this could prevent setting
redundant dirty bits?

Suppose we have a 3K regular file on a filesystem with 1K block size.
In iomap_page_mkwrite(), the iter.len is 3K, if the folio size is 4K,
folio_mark_dirty() will also mark all 4 bits of ifs dirty. And then,
if we expand this file size to 4K, and this will still lead to a hole
with dirty bit set but without any block allocated/reserved. Am I
missing something?

Thanks,
Yi.


