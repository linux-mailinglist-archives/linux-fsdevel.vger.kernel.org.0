Return-Path: <linux-fsdevel+bounces-19292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF18C2E56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 03:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9666D1C216CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB08E576;
	Sat, 11 May 2024 01:10:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A52F2A;
	Sat, 11 May 2024 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715389804; cv=none; b=hy7PxAlhD/U9xOnpXH3RxL0X6gBbhwuoQKYgXTjeF07kZKIXlCF1BKk4DCgEwm372seIg1yxdj/0BNxxIB2l1+fNnjEP0EjsPa/b2eTWsVulHG5Xi95b7LXy28sFbIgroBGEs72DjibJlwghtxGob5Nh3Z/z92r2sfTj9PLNvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715389804; c=relaxed/simple;
	bh=5TYQTd6aAlK7/TTPjE5ssHGLKrWjWPqvXI5Ji3P08UY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FNc5mKOEQvvil5WbxulqBvAD0O3i1SmDqfuZzw/Uh0GTJG+x2/8c784aOd9KH5wArfS5+ZXpwaFJdWDNRwAlaBureTYd5arH0ZDHkhXncexxV0m8FHY4jjI7Aqc0IwxysMCDH0uhHzXID6e5h4TLZ/Pm62Ts+qycZtDGxK/BtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vbnj73JpKz4f3jHw;
	Sat, 11 May 2024 09:09:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6B3FA1A0572;
	Sat, 11 May 2024 09:09:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCnBflhxT5mAWF_Mg--.54233S2;
	Sat, 11 May 2024 09:09:57 +0800 (CST)
Subject: Re: [PATCH v3 2/2] virtiofs: use GFP_NOFS when enqueuing request
 through kworker
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240426143903.1305919-1-houtao@huaweicloud.com>
 <20240426143903.1305919-3-houtao@huaweicloud.com>
 <CAJfpegv5GCiF6PDguR7FyCJ_9osytFuy1UDtJnqwu6WDUCU+jg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5253544f-9855-af61-1d67-69b599ddefb9@huaweicloud.com>
Date: Sat, 11 May 2024 09:09:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJfpegv5GCiF6PDguR7FyCJ_9osytFuy1UDtJnqwu6WDUCU+jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCnBflhxT5mAWF_Mg--.54233S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18WFy5CF1kur17CFyxuFg_yoWkKwc_Wa
	1jkrnrWa1jgF47XF4qyF4FqFWDKFW8CF1UXFWDZF17ury5Ja93Ar1YvryrJayUGayIyrsx
	XrZ5uw13JFyaqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 5/10/2024 7:19 PM, Miklos Szeredi wrote:
> On Fri, 26 Apr 2024 at 16:38, Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When invoking virtio_fs_enqueue_req() through kworker, both the
>> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
>> Considering the size of the sg array may be greater than PAGE_SIZE, use
>> GFP_NOFS instead of GFP_ATOMIC to lower the possibility of memory
>> allocation failure and to avoid unnecessarily depleting the atomic
>> reserves. GFP_NOFS is not passed to virtio_fs_enqueue_req() directly,
>> GFP_KERNEL and memalloc_nofs_{save|restore} helpers are used instead.
> Makes sense.
>
> However, I don't understand why the GFP_NOFS behavior is optional. It
> should work when queuing the request for the first time as well, no?

No. fuse_request_queue_background() may call queue_request_and_unlock()
with fc->bg_lock being held and bg_lock is a spin-lock, so as for now it
is bad to call kmalloc(GFP_NOFS) with a spin-lock being held. The
acquisition of fc->bg_lock in  fuse_request_queue_background() may could
be optimized, but I will leave it for future work.
> Thanks,
> Miklos
> .


