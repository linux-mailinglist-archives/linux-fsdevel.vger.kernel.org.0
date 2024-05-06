Return-Path: <linux-fsdevel+bounces-18815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215D98BC909
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 10:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F391C216B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E1E142642;
	Mon,  6 May 2024 08:01:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CB1411D5;
	Mon,  6 May 2024 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982493; cv=none; b=AkiVJ576svv+O9H8E4QHfxwldDU8T2W1Tdj1muSa2L9J47aFWJ/NjeBEWcW0zqXZ0LEYnIXIrItdveq/7BzHr2jpQMulrCUYy4dpXUBxgbOBOMhJH6yyRt+DKSvr+vvr7xOgwBBUEut9bN9MPMF2PO5fEKnbL3OoAl+mAr9xWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982493; c=relaxed/simple;
	bh=WclK4qSz8idAIWuKOLddP7u/eA0r9enZg5tmD+3x53M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Wwx0DwAAAnzP4CM7JWpbYPYmOgzcQGGtO0VoIvc2A2ro/VXnITH/EH30bQmRW7i7I0etVFfGM4onIe+VrUKdyV6i+iWapIAfqlWvmgNlaDQPAedFsIQDJ5uvbi//LLVNe9C/qyFA6CxvlJJEiuGFZtiMRcG9PHASj2fxy8ElGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXv48276bz4f3p0n;
	Mon,  6 May 2024 16:01:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0E0EE1A017D;
	Mon,  6 May 2024 16:01:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAXGZFOjjhmhA_kLg--.35499S2;
	Mon, 06 May 2024 16:01:21 +0800 (CST)
Subject: Re: [PATCH v3 1/2] virtiofs: use pages instead of pointer for kernel
 direct IO
To: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20240426143903.1305919-1-houtao@huaweicloud.com>
 <20240426143903.1305919-2-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <0a15f973-950d-c957-5aea-b96129b5c0fd@huaweicloud.com>
Date: Mon, 6 May 2024 16:01:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240426143903.1305919-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAXGZFOjjhmhA_kLg--.35499S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1xZFW5GrWxJFWDtw1rtFb_yoW5Wr47pr
	WfJ3ZxCrWxJrWUuan3GFyj9ryfZw1rCayIgr95X3WfXr1xZr9FkFyjva40grW7ZrZ7Jrs7
	JF4Utw42q3yDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 4/26/2024 10:39 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> When trying to insert a 10MB kernel module kept in a virtio-fs with cache
> disabled, the following warning was reported:
>
>   ------------[ cut here ]------------
>   WARNING: CPU: 1 PID: 404 at mm/page_alloc.c:4551 ......
>   Modules linked in:
>   CPU: 1 PID: 404 Comm: insmod Not tainted 6.9.0-rc5+ #123
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
>   RIP: 0010:__alloc_pages+0x2bf/0x380
>   ......
>   Call Trace:
>    <TASK>
>    ? __warn+0x8e/0x150
>    ? __alloc_pages+0x2bf/0x380
>    __kmalloc_large_node+0x86/0x160
>    __kmalloc+0x33c/0x480
>    virtio_fs_enqueue_req+0x240/0x6d0
>    virtio_fs_wake_pending_and_unlock+0x7f/0x190
>    queue_request_and_unlock+0x55/0x60
>    fuse_simple_request+0x152/0x2b0
>    fuse_direct_io+0x5d2/0x8c0
>    fuse_file_read_iter+0x121/0x160
>    __kernel_read+0x151/0x2d0
>    kernel_read+0x45/0x50
>    kernel_read_file+0x1a9/0x2a0
>    init_module_from_file+0x6a/0xe0
>    idempotent_init_module+0x175/0x230
>    __x64_sys_finit_module+0x5d/0xb0
>    x64_sys_call+0x1c3/0x9e0
>    do_syscall_64+0x3d/0xc0
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    ......
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>
> The warning is triggered as follows:
>

SNIP
> @@ -1585,7 +1589,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  		size_t nbytes = min(count, nmax);
>  
>  		err = fuse_get_user_pages(&ia->ap, iter, &nbytes, write,
> -					  max_pages);
> +					  max_pages, fc->use_pages_for_kvec_io);
>  		if (err && !nbytes)
>  			break;

Just find out that flush_kernel_vmap_range() and
invalidate_kernel_vmap_range() should be used before DMA rw operation
and after DMA read operation if the kvec IO is backed by vmalloc() area.
Will update it in v4.
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f239196103137..d4f04e19058c1 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -860,6 +860,9 @@ struct fuse_conn {
>  	/** Passthrough support for read/write IO */
>  	unsigned int passthrough:1;
>  
> +	/* Use pages instead of pointer for kernel I/O */
> +	unsigned int use_pages_for_kvec_io:1;
> +
>  	/** Maximum stack depth for passthrough backing files */
>  	int max_stack_depth;
>  
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 322af827a2329..36984c0e23d14 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1512,6 +1512,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	fc->delete_stale = true;
>  	fc->auto_submounts = true;
>  	fc->sync_fs = true;
> +	fc->use_pages_for_kvec_io = true;
>  
>  	/* Tell FUSE to split requests that exceed the virtqueue's size */
>  	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,


