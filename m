Return-Path: <linux-fsdevel+bounces-12525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E119B8607ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 01:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CF21F23690
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E956947B;
	Fri, 23 Feb 2024 00:58:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFBE57B;
	Fri, 23 Feb 2024 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708649922; cv=none; b=rw5/sx7bQCfqZYuR9PJCj3ItJ9gXcbsFF8tfHvqTm4rYM1aM8he9ZdBctq9WV8BM8wGnLGuKs8ZGKrexcYlzrkco90jTOw1nvCpiaANMrDjpUSIjwwfrltAAJl0dhHfG+TUZi2M3UmTez8o7JR6W83hX43HQ9dZ0RwYztC9A97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708649922; c=relaxed/simple;
	bh=NgbZ0ZCYtqtUCmcF+ysC/YN7+ja6KIyXTxwEmVEIUc4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AaSdfqBdyVkDn74WkTU6RfEC4Xh1CbH65xTD2ViTfUgc70ghYGyUC0hm4jMnKIovwLBIhtZkuTXQMbO+pg8oO75AVKEriN2zZ2JXRy4OxOuurtBz57eePhhUr/nqIAVE7lAljWr4WVnsV96ZJ6HlhPQnMMeOAxE8GPle8yCBVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tgs872WGvz4f3kKN;
	Fri, 23 Feb 2024 08:58:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 911FA1A0C11;
	Fri, 23 Feb 2024 08:58:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgB3mQy27ddl69zGEw--.6075S2;
	Fri, 23 Feb 2024 08:58:34 +0800 (CST)
Subject: Re: [PATCH] virtiofs: limit the length of ITER_KVEC dio by
 max_nopage_rw
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com, Bernd Schubert <bernd.schubert@fastmail.fm>
References: <20240103105929.1902658-1-houtao@huaweicloud.com>
 <20240222144828-mutt-send-email-mst@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2fe9376d-27a6-d502-9acb-3890b3d3946f@huaweicloud.com>
Date: Fri, 23 Feb 2024 08:58:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240222144828-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgB3mQy27ddl69zGEw--.6075S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8Gw1fGF4furW7CFW3ZFb_yoW8JFy5pF
	WaqayqgFn2qF47Aw12ya1UZry0vws5Gr13tr18Wr1UZ3sFk3s2k3ZIq3yUXF17ZrWfKw4I
	qr4qv34jqw4qvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/23/2024 3:49 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 03, 2024 at 06:59:29PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When trying to insert a 10MB kernel module kept in a virtiofs with cache
>> disabled, the following warning was reported:
>>

SNIP

>>
>> A feasible solution is to limit the value of max_read for virtiofs, so
>> the length passed to kmalloc() will be limited. However it will affects
>> the max read size for ITER_IOVEC io and the value of max_write also needs
>> limitation. So instead of limiting the values of max_read and max_write,
>> introducing max_nopage_rw to cap both the values of max_read and
>> max_write when the fuse dio read/write request is initiated from kernel.
>>
>> Considering that fuse read/write request from kernel is uncommon and to
>> decrease the demand for large contiguous pages, set max_nopage_rw as
>> 256KB instead of KMALLOC_MAX_SIZE - 4096 or similar.
>>
>> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> So what should I do with this patch? It includes fuse changes
> but of course I can merge too if no one wants to bother either way...

The patch had got some feedback from Bernd Schubert . And I will post v2
before next Thursday.


