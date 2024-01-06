Return-Path: <linux-fsdevel+bounces-7500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2A9825E82
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 07:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C9D1C23C19
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 06:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B63FDD;
	Sat,  6 Jan 2024 06:26:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183FC1FB9;
	Sat,  6 Jan 2024 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T6VhH1pt4z4f3l2g;
	Sat,  6 Jan 2024 14:26:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9B5101A0979;
	Sat,  6 Jan 2024 14:26:10 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDHlg978phlm+ILAA--.18165S2;
	Sat, 06 Jan 2024 14:26:07 +0800 (CST)
Subject: Re: [PATCH v2] virtiofs: use GFP_NOFS when enqueuing request through
 kworker
To: Vivek Goyal <vgoyal@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, houtao1@huawei.com
References: <20240105105305.4052672-1-houtao@huaweicloud.com>
 <ZZhjzwnQUEJhNJiq@redhat.com> <ZZhkrOdbau2O/B59@casper.infradead.org>
 <ZZhpjEwDwMS_mq-u@redhat.com> <ZZhtU0IxUycpLGJe@casper.infradead.org>
 <ZZh0LKpkrVdoU0tH@redhat.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <9c193ad9-801d-a3d3-faf6-3a655a6fa209@huaweicloud.com>
Date: Sat, 6 Jan 2024 14:26:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZZh0LKpkrVdoU0tH@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDHlg978phlm+ILAA--.18165S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWxXrW5Ww1xXFyDCw4UJwb_yoW5CF48pr
	W2ya48ZF1kJrW7AFZ2yw1UGFyFya1kWrWUX3sYvr9YkFZFqr1I9ryIkF409asrArykCw10
	qFWrXa92qFyDZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Vivek,

On 1/6/2024 5:27 AM, Vivek Goyal wrote:
> On Fri, Jan 05, 2024 at 08:57:55PM +0000, Matthew Wilcox wrote:
>> On Fri, Jan 05, 2024 at 03:41:48PM -0500, Vivek Goyal wrote:
>>> On Fri, Jan 05, 2024 at 08:21:00PM +0000, Matthew Wilcox wrote:
>>>> On Fri, Jan 05, 2024 at 03:17:19PM -0500, Vivek Goyal wrote:
>>>>> On Fri, Jan 05, 2024 at 06:53:05PM +0800, Hou Tao wrote:
>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>
>>>>>> When invoking virtio_fs_enqueue_req() through kworker, both the
>>>>>> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
>>>>>> Considering the size of both the sg array and the bounce buffer may be
>>>>>> greater than PAGE_SIZE, use GFP_NOFS instead of GFP_ATOMIC to lower the
>>>>>> possibility of memory allocation failure.
>>>>>>
>>>>> What's the practical benefit of this patch. Looks like if memory
>>>>> allocation fails, we keep retrying at interval of 1ms and don't
>>>>> return error to user space.

Motivation for GFP_NOFS comes another fix proposed for virtiofs [1] in
which when trying to insert a big kernel module kept in a cache-disabled
virtiofs, the length of fuse args will be large (e.g., 10MB), and the
memory allocation in copy_args_to_argbuf() will fail forever. The
proposed fix tries to fix the problem by limit the length of data kept
in fuse arg, but because the limitation is still large (256KB in that
patch), so I think using GFP_NOFS will also be helpful for such memory
allocation.

[1]:
https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/
>>>> You don't deplete the atomic reserves unnecessarily?
>>> Sounds reasonable. 
>>>
>>> With GFP_NOFS specificed, can we still get -ENOMEM? Or this will block
>>> indefinitely till memory can be allocated. 
>> If you need the "loop indefinitely" behaviour, that's
>> GFP_NOFS | __GFP_NOFAIL.  If you're actually doing something yourself
>> which can free up memory, this is a bad choice.  If you're just sleeping
>> and retrying, you might as well have the MM do that for you.

Even with GFP_NOFS, I think -ENOMEM is still possible, so the retry
logic is still necessary.
> I probably don't want to wait indefinitely. There might be some cases
> where I might want to return error to user space. For example, if
> virtiofs device has been hot-unplugged, then there is no point in
> waiting indefinitely for memory allocation. Even if memory was allocated,
> soon we will return error to user space with -ENOTCONN. 
>
> We are currently not doing that check after memory allocation failure but
> we probably could as an optimization.

Yes. It seems virtio_fs_enqueue_req() only checks fsvq->connected before
writing sg list to virtual queue, so if the virtio device is
hot-unplugged and the free memory is low, it may do unnecessary retry.
Even worse, it may hang. I volunteer to post a patch to check the
connected status after memory allocation failed if you are OK with that.

>
> So this patch looks good to me as it is. Thanks Hou Tao.
>
> Reviewed-by: Vivek Goyal <vgoyal@redhat.com>
>
> Thanks
> Vivek


