Return-Path: <linux-fsdevel+bounces-63501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2039ABBE5E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 16:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96324EF53B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 14:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4143D2D63FF;
	Mon,  6 Oct 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RerWQn8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B40286890;
	Mon,  6 Oct 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761447; cv=none; b=L3qgBt+afWD168TagYJHzrYnPXlIsUFsmEZj/HMhEvXySz7B6w0RjRpdRll2TgP+8FA41kpLPit3pq9PbUputhFj+9X5e5J4eTLL9sO1uF0tC+zCasALy1s2EM8uCtYgFMU5mIro5PmrmSQYIJNKZFC4c34S78hnYgMmJyZmbvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761447; c=relaxed/simple;
	bh=jGMLnJv9dXRh8RhNuUQfVvRt25nKmaUQw9AMgdQGEFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWMBDEWGIIRuY1e+NWv5xKQATvJzQakj2Hi9hS0U9iYu7n43Kl74VGGbI4NZcGrx37BbajlF0sKq1sf50wgGD2CPTQB/0G/UVuCxjsEVUfcKhcyU0j+Hn8Xm2SiyZwnjXTwDTh0BqhJz4UxnDG8NdTRBe/ljlwJl9OKbC39HRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RerWQn8w; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759761434; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MRd7MjBmC/eEJdzsD2vXfxk4wEMOk8EoYAwSAk67oLo=;
	b=RerWQn8wGPehTSnKlHMekX+1T4pJ+p8FobtcRqEuBybHmSdnXWebFgx1+CFWPZMq2w+Ej09lFr0hP1nDZdvHZSBTfOyqCrH1axojqfLqsAqsU+MLCJAuhs+EFYeoAwB2ForvB8XiC+T4iACGysleot/bcm26VNTQ3i57x7k7jN4=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpXtsPz_1759761433 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Oct 2025 22:37:14 +0800
Message-ID: <7b05f88d-2e8f-4fbb-aecb-14b37b7bc99e@linux.alibaba.com>
Date: Mon, 6 Oct 2025 22:37:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ext4: fix an data corruption issue in nojournal mode
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
 <4a152e1b-c468-4fbf-ac0b-dbb76fa1e2ac@linux.alibaba.com>
 <5vukrmwjsvvucw7ugpirmetr2inzgimkap4fhevb77dxqa7uff@yutnpju2e472>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5vukrmwjsvvucw7ugpirmetr2inzgimkap4fhevb77dxqa7uff@yutnpju2e472>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

On 2025/10/6 21:52, Jan Kara wrote:
> Hi Ted!
> 
> I think this patch series has fallen through the cracks. Can you please
> push it to Linus? Given there are real users hitting the data corruption,
> we should do it soon (although it isn't a new issue so it isn't
> supercritical).

Thanks for the ping.

> 

..

> 
>> Some of our internal businesses actually rely on EXT4
>> no_journal mode and when they upgrade the kernel from
>> 4.19 to 5.10, they actually read corrupted data after
>> page cache memory is reclaimed (actually the on-disk
>> data was corrupted even earlier).
>>
>> So personally I wonder what's the current status of
>> EXT4 no_journal mode since this issue has been existing
>> for more than 5 years but some people may need
>> an extent-enabled ext2 so they selected this mode.
> 
> The nojournal mode is fully supported. There are many enterprise customers
> (mostly cloud vendors) that depend on it. Including Ted's employer ;)

.. yet honestly, this issue can be easily observed in
no_journal + memory pressure, and our new 5.10 kernel
setup (previous 4.19) can catch this issue very easily.

Unless the memory is sufficient, the valid page cache can
cover up this issue, but the on-disk data could be still
corrupted.

So we wonder how large scale no_journal mode is used for
now, and if they have  memory pressure workload.

> 
>> We already released an announcement to advise customers
>> not using no_journal mode because it seems lack of
>> enough maintainence (yet many end users are interested
>> in this mode):
>> https://www.alibabacloud.com/help/en/alinux/support/data-corruption-risk-and-solution-in-ext4-nojounral-mode
> 
> Well, it's good to be cautious but the reality is that data corruption
> issues do happen from time to time. Both in nojournal mode and in normal
> journalled mode. And this one exists since the beginning when nojournal
> mode was implemented. So it apparently requires rather specific conditions
> to hit.

The original issue (the one fixed by Yi in 2019) existed
for a quite long time and I think it was hard to reproduce
(compared to this one), but the regression out of lack of
clean_bdev_aliases() and clean_bdev_bh_alias() makes another
serious regression (which exists since 2019 until now) which
can be easily reproduced on some specific VM setup (our
workload is also create and delete some small and big files,
and data corruption can be observed since some data is filled
with extent layout, much like the previous AWS one).

Thanks,
Gao Xiang

> 
> 								Honza
> 


