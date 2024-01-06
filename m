Return-Path: <linux-fsdevel+bounces-7499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE48D825DF6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 03:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A74B1F24279
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981B3C3B;
	Sat,  6 Jan 2024 02:48:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9C2FB6;
	Sat,  6 Jan 2024 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T6PsH5nN9z4f3lfV;
	Sat,  6 Jan 2024 10:48:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8DE5F1A0273;
	Sat,  6 Jan 2024 10:48:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC3BAuFv5hlkomfFg--.12268S2;
	Sat, 06 Jan 2024 10:48:41 +0800 (CST)
Subject: Re: [PATCH v2] virtiofs: use GFP_NOFS when enqueuing request through
 kworker
To: Matthew Wilcox <willy@infradead.org>, Vivek Goyal <vgoyal@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, houtao1@huawei.com
References: <20240105105305.4052672-1-houtao@huaweicloud.com>
 <ZZhjzwnQUEJhNJiq@redhat.com> <ZZhkrOdbau2O/B59@casper.infradead.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1e4b0ed0-8879-9044-75b6-d8371ddc50fc@huaweicloud.com>
Date: Sat, 6 Jan 2024 10:48:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZZhkrOdbau2O/B59@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC3BAuFv5hlkomfFg--.12268S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWkZw47Cw43WrW3uF1fCrg_yoWfZwb_Wr
	4q9F17Cw18JF1UW3Z7Jr4F9FZFya18Wr4jqFZ8XrW7Z3WYqa93GrnY9r4Sv347G3ySyrWr
	uFWSvasIv3WSkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/6/2024 4:21 AM, Matthew Wilcox wrote:
> On Fri, Jan 05, 2024 at 03:17:19PM -0500, Vivek Goyal wrote:
>> On Fri, Jan 05, 2024 at 06:53:05PM +0800, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> When invoking virtio_fs_enqueue_req() through kworker, both the
>>> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
>>> Considering the size of both the sg array and the bounce buffer may be
>>> greater than PAGE_SIZE, use GFP_NOFS instead of GFP_ATOMIC to lower the
>>> possibility of memory allocation failure.
>>>
>> What's the practical benefit of this patch. Looks like if memory
>> allocation fails, we keep retrying at interval of 1ms and don't
>> return error to user space.
> You don't deplete the atomic reserves unnecessarily?
Beside that, I think the proposed GFP_NOFS may reduce unnecessary
retries. I Should mention that in the commit message. Should I post a v3
to do that ?


