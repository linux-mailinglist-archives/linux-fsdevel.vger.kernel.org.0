Return-Path: <linux-fsdevel+bounces-14040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638FC876F22
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 05:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480CB1C20CCA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 04:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F4364B1;
	Sat,  9 Mar 2024 04:27:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E93612D;
	Sat,  9 Mar 2024 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709958427; cv=none; b=VU5WHD5sy6UJwzZ2wiy+sg45EVgdYsmMvLK6W0w4rg9eYWxrnigNUwrGsmNc8EGwpXtv8I+O0Vy+kpq9RyhiTtWQlZdCcdcbMbTFvSncjZ+zxun4L/jHp8aB0wPelN2a+srLESivaeGXNJAAswUOusNSHmEBZ5MAU4tm2qcpnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709958427; c=relaxed/simple;
	bh=N+KnjBwKqaHY3vVj7jATXyz/61YdvrbVC+n/8jaT0Tw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aNNhSXWSYRcumr+WTmLNnsnznjyS4ZwWkWhdB6M5u1pWJhpSObhvJKZVOb5C0FVAito+wvg8TwyJG4Vw9o/Ls2VMUM5dZ0+wkgaG5jvCQ22jJ/HFA3n4yzcdLART8agBPhor6MQwbl6m1bRrL0KK4gO1Vt/TzFqptD/423VCcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ts93Z3DtDz4f3jsY;
	Sat,  9 Mar 2024 12:26:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 066EC1A0D46;
	Sat,  9 Mar 2024 12:26:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgA3Q5sM5etlZO4kGQ--.6539S2;
	Sat, 09 Mar 2024 12:26:55 +0800 (CST)
Subject: Re: [PATCH v2 1/6] fuse: limit the length of ITER_KVEC dio by
 max_pages
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
 <20240228144126.2864064-2-houtao@huaweicloud.com>
 <CAJfpegtMhkKG-Hk5vQ5gi6bSqwb=eMG9_TzcW7b08AtXBmnQXQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <8f21c92f-5456-7a2e-59af-1a02d8a10c24@huaweicloud.com>
Date: Sat, 9 Mar 2024 12:26:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJfpegtMhkKG-Hk5vQ5gi6bSqwb=eMG9_TzcW7b08AtXBmnQXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgA3Q5sM5etlZO4kGQ--.6539S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW8XrWUWr1fCw4UtrWxXrb_yoW8JF4xpF
	4fta1xWwnIqFy7Aw1xGw4xuF92kan3G3WrJ34kZr9xCr15Zr9a9ryrGa90qrZ7Xrn3Aw10
	qF4qvF9Ivw4Yv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbPEf5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/1/2024 9:42 PM, Miklos Szeredi wrote:
> On Wed, 28 Feb 2024 at 15:40, Hou Tao <houtao@huaweicloud.com> wrote:
>
>> So instead of limiting both the values of max_read and max_write in
>> kernel, capping the maximal length of kvec iter IO by using max_pages in
>> fuse_direct_io() just like it does for ubuf/iovec iter IO. Now the max
>> value for max_pages is 256, so on host with 4KB page size, the maximal
>> size passed to kmalloc() in copy_args_to_argbuf() is about 1MB+40B. The
>> allocation of 2MB of physically contiguous memory will still incur
>> significant stress on the memory subsystem, but the warning is fixed.
>> Additionally, the requirement for huge physically contiguous memory will
>> be removed in the following patch.
> So the issue will be fixed properly by following patches?
>
> In that case this patch could be omitted, right?

Sorry for the late reply. Being busy with off-site workshop these days.

No, this patch is still necessary and it is used to limit the number of
scatterlist used for fuse request and reply in virtio-fs. If the length
of out_args[0].size is not limited, the number of scatterlist used to
map the fuse request may be greater than the queue size of virtio-queue
and the fuse request may hang forever.

>
> Thanks,
> Miklos


