Return-Path: <linux-fsdevel+bounces-5301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0A809E2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 09:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B61C209D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FDE111A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 08:33:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DCD1722;
	Thu,  7 Dec 2023 23:34:02 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SmjYv0DVqz4f3lD7;
	Fri,  8 Dec 2023 15:33:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C775E1A09F4;
	Fri,  8 Dec 2023 15:33:59 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhDlxnJlkc9ADA--.40165S3;
	Fri, 08 Dec 2023 15:33:59 +0800 (CST)
Subject: Re: [PATCH 13/14] iomap: map multiple blocks at a time
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Chandan Babu R <chandan.babu@oracle.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 gfs2@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
References: <20231207072710.176093-1-hch@lst.de>
 <20231207072710.176093-14-hch@lst.de>
 <4e4a86a0-5681-210f-0c94-263126967082@huaweicloud.com>
 <20231207150311.GA18830@lst.de>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <d5f3979b-344a-bf01-8a45-49ae02b0bed0@huaweicloud.com>
Date: Fri, 8 Dec 2023 15:33:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231207150311.GA18830@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHyhDlxnJlkc9ADA--.40165S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8tFW7JF1Dtw1DCrWxJFb_yoW8try8pF
	WIganYkF1DJ34avrn7Za1UZr10yasxGF48t343tFy3Aa98Kr1S9F1xK3WjvFWY9rZrWr1S
	vFW8t3s3XFnIyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2023/12/7 23:03, Christoph Hellwig wrote:
> On Thu, Dec 07, 2023 at 09:39:44PM +0800, Zhang Yi wrote:
>>> +	do {
>>> +		unsigned map_len;
>>> +
>>> +		error = wpc->ops->map_blocks(wpc, inode, pos);
>>> +		if (error)
>>> +			break;
>>> +		trace_iomap_writepage_map(inode, &wpc->iomap);
>>> +
>>> +		map_len = min_t(u64, dirty_len,
>>> +			wpc->iomap.offset + wpc->iomap.length - pos);
>>> +		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
>>
>> While I was debugging this series on ext4, I would suggest try to add map_len
>> or dirty_len into this trace point could be more convenient.
> 
> That does seem useful, but it means we need to have an entirely new
> even class.  Can I offload this to you for inclusion in your ext4
> series? :)
> 

Sure, I'm glad to do it.

>>> +		case IOMAP_HOLE:
>>> +			break;
>>
>> BTW, I want to ask an unrelated question of this patch series. Do you
>> agree with me to add a IOMAP_DELAYED case and re-dirty folio here? The
>> background is that on ext4, jbd2 thread call ext4_normal_submit_inode_data_buffers()
>> submit data blocks in data=ordered mode, but it can only submit mapped
>> blocks, now we skip unmapped blocks and re-dirty folios in
>> ext4_do_writepages()->mpage_prepare_extent_to_map()->..->ext4_bio_write_folio().
>> So we have to inherit this logic when convert to iomap, I suppose ext4's
>> ->map_blocks() return IOMAP_DELALLOC for this case, and iomap do something
>> like:
>>
>> +               case IOMAP_DELALLOC:
>> +                       iomap_set_range_dirty(folio, offset_in_folio(folio, pos),
>> +                                             map_len);
>> +                       folio_redirty_for_writepage(wbc, folio);
>> +                       break;
> 
> I guess we could add it, but it feels pretty quirky to me, so it would at
> least need a very big comment.
> 
> But I think Ted mentioned a while ago that dropping the classic
> data=ordered mode for ext4 might be a good idea eventually no that ext4
> can update the inode size at I/O completion time (Ted, correct me if
> I'm wrong).  If that's the case it might make sense to just drop the
> ordered mode instead of adding these quirks to iomap.
> 

Yeah, make sense, we could remove these quirks after ext4 drop
data=ordered mode. For now, let me implement it according to this
temporary method.

Thanks,
Yi.


