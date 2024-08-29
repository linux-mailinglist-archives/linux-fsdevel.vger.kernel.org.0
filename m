Return-Path: <linux-fsdevel+bounces-27743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE5A9637EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0841F22D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7633C210EE;
	Thu, 29 Aug 2024 01:43:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758E1BC41;
	Thu, 29 Aug 2024 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895813; cv=none; b=RNPEq60+fzBwKfCkdEz2/VfmcAbRhfMwhu0ezsGnjs2YlXAIwGVRmvou7sHp8md/ug9vXlRASXavqjWU5gqXAk2pAUhXxm8X3FsO4l9aDaoUa3dJW95OBLOx++V1cDdAXFQCtCNsjc0r1NGzQw7xp5D6hQX4fjtzukUv6KglX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895813; c=relaxed/simple;
	bh=13FW3FFsyZcmYCaM9j3DtMhT0e5P6uK0Ttk2a2OjxDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h16O8Nt1U7TbnAIdlGPJk6JsAhY0DWL4l1DO/RlRnOMgMdVhpT7OdcEuh4ISeomdNBrQl+5BuiUvR6lPOHzRIgKop0Xw1oyuo7bCjL/FCNzJwGzBxr/j/fryb0dTSZxMmhkbwBxH/P188V+IcVYx7DCiKkH1QDSO6vhZadNSQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WvPDw4bK5z4f3jdf;
	Thu, 29 Aug 2024 09:43:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 43D871A07B6;
	Thu, 29 Aug 2024 09:43:27 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4U70s9mWOUIDA--.61429S3;
	Thu, 29 Aug 2024 09:43:27 +0800 (CST)
Message-ID: <491c1962-1f9e-4aca-b263-eb6eb88140e0@huaweicloud.com>
Date: Thu, 29 Aug 2024 09:43:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
To: David Howells <dhowells@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Jeff Layton <jlayton@kernel.org>, stable@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Hou Tao <houtao1@huawei.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Yang Erkun <yangerkun@huawei.com>,
 Yu Kuai <yukuai3@huawei.com>, Zizhi Wo <wozizhi@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <11c591fd-221b-4eeb-a0bd-e9e303d391a6@huaweicloud.com>
 <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
 <20240826040018.2990763-1-libaokun@huaweicloud.com>
 <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
 <988772.1724850113@warthog.procyon.org.uk>
 <1043618.1724861676@warthog.procyon.org.uk>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <1043618.1724861676@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHL4U70s9mWOUIDA--.61429S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYv7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r
	1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAKBWbO339AKwAAst

Hi David,

On 2024/8/29 0:14, David Howells wrote:
> Baokun Li <libaokun@huaweicloud.com> wrote:
>
>>> You couldn't do that anyway, since kernel_file_open() steals the caller's ref
>>> if successful.
>> Ignoring kernel_file_open(), we now put a reference count of the dentry
>> whether cachefiles_open_file() returns true or false.
> Actually, I'm wrong kernel_file_open() doesn't steal a ref.
>
> David
>
>
Thanks for confirming this.
I will send a new version using the new solution.


Cheers,
Baokun


