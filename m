Return-Path: <linux-fsdevel+bounces-23631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF93930359
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 04:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00AA1C2140F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 02:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0117C98;
	Sat, 13 Jul 2024 02:30:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F012B82;
	Sat, 13 Jul 2024 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837811; cv=none; b=H+LYXor3FBuys9jyhN8j8S8Vm5v9+7JFzi/vp1caA2SUySM4QN7MastjOfWiFlrNEH6mS8mORPq/PVeLD+o2x6Hi6gOsm2mPpObekXdvc+uCmU6beOuzOy4bnd3Aj2kC2ZJpfW7uuifetvKgmXB6u9jXy9VWwbZ6jnMYKSexhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837811; c=relaxed/simple;
	bh=4SEn5gOJYqHujwPybOnm3QwtxxQfOvIoDLWQOkqT3wA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SpBf6KZQC97AIU/S5FL5pQpmZfUMmnLd8+C6yBgBwsmkhA+MW3T3UA8mjySOHS0FJSgoQI72Hk7C1PWNwHSqNJvhrgkDcELrJw/Vi8qtW39+QYbrYZNnV/27Ohz3vW9XZKfsBCqh1p+e5VrT8JrXuXsYhVNTFSVdbesmjgTfLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WLXVL0fSvz4f3kvR;
	Sat, 13 Jul 2024 10:29:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 15FEF1A0185;
	Sat, 13 Jul 2024 10:29:59 +0800 (CST)
Received: from [10.174.178.46] (unknown [10.174.178.46])
	by APP2 (Coremail) with SMTP id Syh0CgBn0Yaj5pFmb6LPBw--.58645S3;
	Sat, 13 Jul 2024 10:29:57 +0800 (CST)
Subject: Re: [BUG REPORT] potential deadlock in inode evicting under the inode
 lru traversing context on ext4 and ubifs
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Richard Weinberger <richard@nod.at>, "zhangyi (F)" <yi.zhang@huawei.com>,
 yangerkun <yangerkun@huawei.com>, "wangzhaolong (A)"
 <wangzhaolong1@huawei.com>
References: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>
 <20240712143708.GA151742@mit.edu>
From: Zhihao Cheng <chengzhihao@huaweicloud.com>
Message-ID: <346993f2-87f6-e20f-8f5a-d19f84c1604c@huaweicloud.com>
Date: Sat, 13 Jul 2024 10:29:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240712143708.GA151742@mit.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBn0Yaj5pFmb6LPBw--.58645S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxZF1ktr1UAw47KFyxuFg_yoW5JFy5pa
	9rXa4Syrn5JFyYk34ktr4v9w10ka1rCr4UJrykWr1xA3WkXrySvF1xtr45JFWUur4kuw1v
	qa1UCrn8urn0y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xfkh0wx2klxt3r6k3tpzhluzxrxghudrp/



ÔÚ 2024/7/12 22:37, Theodore Ts'o Ð´µÀ:
>> Problem description
>> ===================
>>
>> The inode reclaiming process(See function prune_icache_sb) collects all
>> reclaimable inodes and mark them with I_FREEING flag at first, at that
>> time, other processes will be stuck if they try getting these inodes(See
>> function find_inode_fast), then the reclaiming process destroy the
>> inodes by function dispose_list().
>> Some filesystems(eg. ext4 with ea_inode feature, ubifs with xattr) may
>> do inode lookup in the inode evicting callback function, if the inode
>> lookup is operated under the inode lru traversing context, deadlock
>> problems may happen.
>>
>> Case 1: In function ext4_evict_inode(), the ea inode lookup could happen
>> if ea_inode feature is enabled, the lookup process will be stuck under
>> the evicting context like this:
>>
>>   1. File A has inode i_reg and an ea inode i_ea
>>   2. getfattr(A, xattr_buf) // i_ea is added into lru // lru->i_ea
>>   3. Then, following three processes running like this:
>>
>>      PA                              PB
>>   echo 2 > /proc/sys/vm/drop_caches
>>    shrink_slab
>>     prune_dcache_sb
>>     // i_reg is added into lru, lru->i_ea->i_reg
>>     prune_icache_sb
>>      list_lru_walk_one
>>       inode_lru_isolate
>>        i_ea->i_state |= I_FREEING // set inode state
>>        i_ea->i_state |= I_FREEING // set inode state
> Um, I don't see how this can happen.  If the ea_inode is in use,
> i_count will be greater than zero, and hence the inode will never be
> go down the rest of the path in inode_lru_inode():

The counter of ea_inode could become zero before the file inode, 
according to the following process:
path_getxattr
  user_path_at(&path) // get file dentry and file inode
  getxattr
   ext4_xattr_get
    ext4_xattr_ibody_get
     ext4_xattr_inode_get
      ext4_xattr_inode_iget(&ea_inode)  // ea_inode->i_count = 1
      iput(ea_inode) // ea_inode->i_count = 0, put it into lru
  path_put(&path); // put file dentry and file inode

> 
> 	if (atomic_read(&inode->i_count) ||
> 	    ...) {
> 		list_lru_isolate(lru, &inode->i_lru);
> 		spin_unlock(&inode->i_lock);
> 		this_cpu_dec(nr_unused);
> 		return LRU_REMOVED;
> 	}
> 
> Do you have an actual reproduer which triggers this?  Or would this
> happen be any chance something that was dreamed up with DEPT?

The reproducer is in the second half of the ariticle, along with some of 
the solutions we tried.

Reproducer:
===========

https://bugzilla.kernel.org/show_bug.cgi?id=219022

About solutions
===============

[...]


