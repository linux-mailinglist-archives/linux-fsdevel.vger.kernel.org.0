Return-Path: <linux-fsdevel+bounces-12020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D24A85A506
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D900E1C2249B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2166B364B8;
	Mon, 19 Feb 2024 13:42:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD61EB36;
	Mon, 19 Feb 2024 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350142; cv=none; b=kXz7JAli3MSWbE0Hxm0tnFiMEytUd+ElKS7jvkMhesUvN9CYhMCHKJevw/vULr6JyrmyVUEZEArlQPTG34Go0/8rluZnteYF28/DeSd7GpHDMlAtAeAqDBUE21MhewXIVQZLHFP9R19ODpJXYiCnSL11i9HhnYyjh/4K085tkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350142; c=relaxed/simple;
	bh=7UHKGTFembcYfzT1g6HvIUZ6F83fKO2bcSbIWJaQxSc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FbJcHOXQGZ/CGBacFVlAadTUXo2X8prA4X9IEcgTRFkWfjvH1Ym9GrgR7ktiBd8yPlV0fCsWppEE9wiossTULM2+Nv0ODpzdLNKYV+pGylLw2wtTid60+FUDniTKXlyapbGqHGyeKCTXvdKV12WMJGvM1uSFFiG/yYVexmqU9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TdkH763gsz4f3l8p;
	Mon, 19 Feb 2024 21:42:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F07601A0C89;
	Mon, 19 Feb 2024 21:42:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g6xWtNl9jwEEg--.8361S3;
	Mon, 19 Feb 2024 21:42:11 +0800 (CST)
Subject: Re: [PATCH RFC 2/2] fs,drivers: remove bdev_inode() usage outside of
 block layer and drivers
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org>
 <20240129-vfs-bdev-file-bd_inode-v1-2-42eb9eea96cf@kernel.org>
 <20240129143709.GA568@lst.de>
 <20240129-lobpreisen-arterien-e300ee15dba8@brauner>
 <20240129153637.GA2280@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <40b06159-8b83-8b0d-32ba-ce50d14787ad@huaweicloud.com>
Date: Mon, 19 Feb 2024 21:42:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240129153637.GA2280@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g6xWtNl9jwEEg--.8361S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKr43JFy8Zry7Aw1xWFWUtwb_yoW8Jr1Dpa
	yfJF45Cw4qkr43Kr92yr4SqF10vanxCFZ0gr4UZryrA390gF1Igrsaga15CFyDAryxAwsI
	vr4ay34DXr1v937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/01/29 23:36, Christoph Hellwig Ð´µÀ:
> On Mon, Jan 29, 2024 at 04:29:32PM +0100, Christian Brauner wrote:
>> On Mon, Jan 29, 2024 at 03:37:09PM +0100, Christoph Hellwig wrote:
>>> Most of these really should be using proper high level APIs.  The
>>> last round of work on this is here:
>>>
>>> https://lore.kernel.org/linux-nilfs/4b11a311-c121-1f44-0ccf-a3966a396994@huaweicloud.com/
>>
>> Are you saying that I should just drop this patch here?
> 
> I think we need to order the work:
> 
>   - get your use struct file as bdev handle series in
>   - rebase the above series on top of that, including some bigger changes
>     like block2mtd which can then use normal file read/write APIs

I'm working on that now, mostly convert to use bdev_file, and file_inode
to get 'bd_inode' or f_mapping to get 'bd_inode->f_mapping', and now
that all fs and all drivers can avoid to access 'bd_inode' now.

>   - rebase what is left of this series on top of that, and hopefully not
>     much of this patch and a lot less of patch 1 will be left at that
>     point.

This is done by a huge patch for now, and there really is nothing left
of this set. I'm still testing and spliting into a patchset. I'll post a
RFC version soon.

Thanks,
Kuai

> 
> .
> 


