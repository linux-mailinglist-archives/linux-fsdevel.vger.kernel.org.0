Return-Path: <linux-fsdevel+bounces-70205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 491DCC93833
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 05:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 370904E0264
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 04:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7CF23A9BD;
	Sat, 29 Nov 2025 04:44:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D4224AF1;
	Sat, 29 Nov 2025 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764391473; cv=none; b=g5nr3Tc/ueI1SMMjF0nYv88DQOl8pGaL6PwwWf5fOwwl56vfwDLMK97NfKccajirfy+4h0Szz7+GQV9yINEwtxVrUC4WsF7909ICE6GV6H9JZIGTJtY7IW76UOkW+U0lXFNU3DEyw+GVjYM0rvubfJLhayh5SjNSR0EWd1pxF2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764391473; c=relaxed/simple;
	bh=W8LbG6q/KwkBXbh7jO8qD93PYsCDQq5eZ5gwqrxk/W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaXknqbxnWflii21FJODc+0norLK7+6FWeaSPfChCtvdvKIf2eNtGjl/X+SscmM9WRuYRdD9C33qStTDcVzWpq49ZQHOEelz/1sQNS3XBMh7aG/chZ6B9mdKrQN2hdlox3y+aVU8KNc54lXfDHTrjED6NvxmcLTT3mGDgOv+nTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dJHc22qXSzYQtpp;
	Sat, 29 Nov 2025 12:43:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BB9091A07C0;
	Sat, 29 Nov 2025 12:44:26 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgB31Hooeipp_TOOCQ--.57179S3;
	Sat, 29 Nov 2025 12:44:26 +0800 (CST)
Message-ID: <940f2001-ded4-4ecf-b1f0-a424b2983167@huaweicloud.com>
Date: Sat, 29 Nov 2025 12:44:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
To: Theodore Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
 yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com,
 yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251128164959.GC4102@macsyma-3.local>
 <58148859-dad6-4a1a-82ef-2a6099e2464d@huaweicloud.com>
 <20251129035200.GA64725@macsyma.local>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251129035200.GA64725@macsyma.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB31Hooeipp_TOOCQ--.57179S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr48KF4rZFW5ury8CFW7Arb_yoW8Cw18pa
	yagFyY9ws8JrWkAr4xZr18GF4Sy3Wftr98uw1xWr1kA3W5uryxKr4Igw4j93W7Gw4fur4a
	9F4Yyryvk3WDC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/29/2025 11:52 AM, Theodore Tso wrote:
> On Sat, Nov 29, 2025 at 09:32:25AM +0800, Zhang Yi wrote:
>>
>> The ext4.git tree[1] shows that only the first three patches from this
>> v2 version have been merged, possibly because the fourth patch conflicted
>> with ErKun's patch[2].
> 
> Yeah, oops.  Sorry about that.  I think I had checked some other
> branch via a git reset --hard, and forgot that I had accidentally
> aborted the git am after the patch conflict.
> 
> I've rearranged the dev brach so that those first three patches are
> not at the tip of the dev branch.  So if you want to grab the dev
> branch, and then rebase your new series on top of commit 91ef18b567da,
> you can do that.
> 
> * 1e366d088866 - (HEAD -> dev, ext4/dev) ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1 (10 minutes ago)
> * 6afae3414127 - ext4: subdivide EXT4_EXT_DATA_VALID1 (10 minutes ago)
> * a4e2cc74a11b - ext4: cleanup zeroout in ext4_split_extent_at() (10 minutes ago)
> * 91ef18b567da - ext4: mark inodes without acls in __ext4_iget() (10 minutes ago)
> 
> Note that the merge window opens on this coming Sunday, but a good
> number of these patches are bug fixes (and not in the sense of adding
> a new feature :-), so I'd prefer to land them this cycle if possible.
> 
>> I've written a new version locally, adding two fix
>> patches for the three merged patches, and then rebase the subsequent
>> patches and modify them directly. I can send them out after texting.
>> Is this okay?
> 
> Why don't you modify your series so it applies on top of 91ef18b567da,
> so we don't hace to have the fixup patches, and I may just simply push
> everything up to 91ef18b567da to Linus, and we can then just apply the
> next version of your series on top of that commit, and I'll push it to
> Linus right after -rc1.
> 
> Does that seem workable to you?
> 
> 							- Ted

Sure, I will rebase my series on top of 91ef18b567da and send out today.

Cheers,
Yi.


