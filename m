Return-Path: <linux-fsdevel+bounces-24964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE29472FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 03:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691BB1F21132
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 01:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173613CA8D;
	Mon,  5 Aug 2024 01:29:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49617C;
	Mon,  5 Aug 2024 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821363; cv=none; b=hojmDxbVJQf4ysg6rvkyu6eKhhk1t4wiktv2g3z4H/ODS3gSgVK/dqqdi3tWq8VYrkEDLQeqqZDUY6Ea1BErma1cRISRnqpObMRL79V74GsFOlmkwwZjf3pZmSusWAyM66g+IlKhqbUM1y2Asb5OSGUpCyLnJUPRGs47yFavUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821363; c=relaxed/simple;
	bh=lM/yVMu9rMlqDSqyQjPI4c4gWzBgVS4mS0sGFDbiR1c=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ndojRO1O2Lgq5crTgHi7bUmhIPNoDR8r2FeSSR9JHZv+KpChFt8HiEJA2QGqyY380SMy0IIe6rCxzHL137lTmWeN4JnNhN/BTAbMmcwtclr186Fj4LWTaErEm7yJbQISWe7Df0PpYQwvIhLHZ3bJiTqLPXyefpM99WMtEd+z+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wcf3f6D1dz4f3kvh;
	Mon,  5 Aug 2024 09:29:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 14F9C1A018D;
	Mon,  5 Aug 2024 09:29:17 +0800 (CST)
Received: from [10.174.178.46] (unknown [10.174.178.46])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTqKrBmwDwxAw--.57715S3;
	Mon, 05 Aug 2024 09:29:16 +0800 (CST)
Subject: Re: [BUG REPORT] potential deadlock in inode evicting under the inode
 lru traversing context on ext4 and ubifs
From: Zhihao Cheng <chengzhihao@huaweicloud.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Richard Weinberger <richard@nod.at>, "zhangyi (F)" <yi.zhang@huawei.com>,
 yangerkun <yangerkun@huawei.com>, "wangzhaolong (A)"
 <wangzhaolong1@huawei.com>, mjguzik@gmail.com,
 "rydercoding@hotmail.com >> Ryder Wang" <rydercoding@hotmail.com>
References: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>
Message-ID: <e67d289d-fd5e-cb38-4e2f-a2bbb8419a97@huaweicloud.com>
Date: Mon, 5 Aug 2024 09:29:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoTqKrBmwDwxAw--.57715S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GFW3Ar18KF15KF4rWw45ZFb_yoWDXrcE93
	WruFZrJw4Yqr4Iqa1DCF4rJrs7Cr1UCry5Xrs5X3sIyw1fAFs7Xa97Jry5Zw1Iyw1Iqwn0
	yr95Jwn3twnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xfkh0wx2klxt3r6k3tpzhluzxrxghudrp/

Hi, based on the ideas from Jan and Mateusz, I sent a fix patch, see 
https://lore.kernel.org/linux-fsdevel/20240805013446.814357-1-chengzhihao@huaweicloud.com/T/#u

ÔÚ 2024/7/12 14:27, Zhihao Cheng Ð´µÀ:
> Hi. Recently, we found a deadlock in inode recliaiming process caused by 
> circular dependence between file inode and file's xattr inode.
> 
> Problem description
> ===================
> 
> The inode reclaiming process(See function prune_icache_sb) collects all 
> reclaimable inodes and mark them with I_FREEING flag at first, at that 
> time, other processes will be stuck if they try getting these inodes(See 
> function find_inode_fast), then the reclaiming process destroy the 
> inodes by function dispose_list().
> Some filesystems(eg. ext4 with ea_inode feature, ubifs with xattr) may 
> do inode lookup in the inode evicting callback function, if the inode 
> lookup is operated under the inode lru traversing context, deadlock 
> problems may happen.
> 


