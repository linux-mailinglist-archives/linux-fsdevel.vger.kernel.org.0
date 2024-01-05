Return-Path: <linux-fsdevel+bounces-7437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01953824DB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 05:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF1286430
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 04:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE6053B5;
	Fri,  5 Jan 2024 04:44:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CAE5228;
	Fri,  5 Jan 2024 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=49;SR=0;TI=SMTPD_---0VzzUQHt_1704429833;
Received: from 30.222.33.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzzUQHt_1704429833)
          by smtp.aliyun-inc.com;
          Fri, 05 Jan 2024 12:43:56 +0800
Message-ID: <a2c7910c-4c2f-4290-a895-1c4255b2ee62@linux.alibaba.com>
Date: Fri, 5 Jan 2024 12:43:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 for-6.8/block 11/17] erofs: use bdev api
To: Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
 kent.overstreet@gmail.com, joern@lazybastard.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org, chao@kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
 konishi.ryusuke@gmail.com, willy@infradead.org, akpm@linux-foundation.org,
 hare@suse.de, p.raghav@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085826.1768395-1-yukuai1@huaweicloud.com>
 <20240104120207.ig7tfc3mgckwkp2n@quack3>
 <7f868579-f993-aaa1-b7d7-eccbe0b0173c@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7f868579-f993-aaa1-b7d7-eccbe0b0173c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/1/4 20:32, Yu Kuai wrote:
> Hi, Jan!
> 
> 在 2024/01/04 20:02, Jan Kara 写道:
>> On Thu 21-12-23 16:58:26, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Avoid to access bd_inode directly, prepare to remove bd_inode from
>>> block_device.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>
>> I'm not erofs maintainer but IMO this is quite ugly and grows erofs_buf
>> unnecessarily. I'd rather store 'sb' pointer in erofs_buf and then do the
>> right thing in erofs_bread() which is the only place that seems to care
>> about the erofs_is_fscache_mode() distinction... Also blkszbits is then
>> trivially sb->s_blocksize_bits so it would all seem much more
>> straightforward.
> 
> Thanks for your suggestion, I'll follow this unless Gao Xiang has other
> suggestions.

Yes, that would be better, I'm fine with that.  Yet in the future we
may support a seperate large dirblocksize more than block size, but
we could revisit later.

Thanks,
Gao Xiang

> 
> Kuai
>>
>>                                 Honza
>>

