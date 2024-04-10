Return-Path: <linux-fsdevel+bounces-16519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597FE89E89E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 05:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FB71C21D6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 03:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CB5C144;
	Wed, 10 Apr 2024 03:59:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF0BA50;
	Wed, 10 Apr 2024 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721582; cv=none; b=sWiOMMy4h0dorXN04ilMPwbtl0dS8kiWSM4xz4+PslsTB6uDfDWnVPw/ZDIqc/U1wWm7eGwJJkD6UiAiXXIerHZOhMBA0M1AntfP+xqL1CnFZregHR79OI8vxRPNt/tWD+f+2uvkniISLKrV/4JKc4X1IxumeeUVLIF1PpxO+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721582; c=relaxed/simple;
	bh=9rHGw5V0Ol3Lhkbimgh3tQnQF9hRbuE4XOHEAH47S2g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TUfKhhRrL3bjicoptO+AQkmkk0mJ4BYk95ynWvwD+aftaf9LkmBALSoKAS2bFUImW95MUglbV5RkXgHQCgYv0hSy3e6T8H4KnwuOaYr2Kp3J5Y+rMvQ4/ik6S4+YVwuedASep+WFWVIsKUnrtW6LSxxGWBiqm439OaS80RdlTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VDpxF6q15z4f3jR9;
	Wed, 10 Apr 2024 11:59:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C010D1A0175;
	Wed, 10 Apr 2024 11:59:36 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGmDhZmfidUJg--.28978S3;
	Wed, 10 Apr 2024 11:59:35 +0800 (CST)
Subject: Re: [PATCH 0/7] ext4: support adding multi-delalloc blocks
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240330120236.3789589-1-yi.zhang@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <ccf1b9d9-1126-963e-f6eb-becdbafb81f0@huaweicloud.com>
Date: Wed, 10 Apr 2024 11:59:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240330120236.3789589-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXKBGmDhZmfidUJg--.28978S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1rKF18Aw4xCrykZryDGFg_yoW8WF4UpF
	WS9FWftr48Ww1S9Fs3Ar4DGr15Zw4xCr15Ga4aq348ZrWUAFyfXrnrKFyF9as7JrZ7AF1U
	XF17K34Uu3Wqk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/3/30 20:02, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Hello!
> 
> This patch series is the part 2 prepartory changes of the buffered IO
> iomap conversion, I picked them out from my buffered IO iomap conversion
> RFC series v3[1], and add bigalloc feature support.
> 
> The first 6 patches make ext4_insert_delayed_block() call path support
> inserting multi-delalloc blocks once a time, and the last patch makes
> ext4_da_map_blocks() buffer_head unaware.
> 
> This patch set has been passed 'kvm-xfstests -g auto' tests, I hope it
> could be reviewed and merged first.
> 

I've found an incorrect delalloc reserve space count and incorrect extent
type issue in the current ext4 code while improving my iomap conversion.
I'd suggest to fix this issue first, so please drop this series and look
at my v2 series for details.

Thanks,
Yi.

> [1] https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
> 
> Thanks,
> Yi.
> 
> Zhang Yi (7):
>   ext4: trim delalloc extent
>   ext4: drop iblock parameter
>   ext4: make ext4_es_insert_delayed_block() insert multi-blocks
>   ext4: make ext4_da_reserve_space() reserve multi-clusters
>   ext4: factor out check for whether a cluster is allocated
>   ext4: make ext4_insert_delayed_block() insert multi-blocks
>   ext4: make ext4_da_map_blocks() buffer_head unaware
> 
>  fs/ext4/extents_status.c    |  63 +++++++++-----
>  fs/ext4/extents_status.h    |   5 +-
>  fs/ext4/inode.c             | 165 ++++++++++++++++++++++--------------
>  include/trace/events/ext4.h |  26 +++---
>  4 files changed, 162 insertions(+), 97 deletions(-)
> 


