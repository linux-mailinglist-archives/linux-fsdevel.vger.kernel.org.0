Return-Path: <linux-fsdevel+bounces-19756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814018C99A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D2A1C20FA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 08:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76FC1BF38;
	Mon, 20 May 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s4VExou/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D41BC53;
	Mon, 20 May 2024 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716192423; cv=none; b=ZMv6QNBMz6moe4KRNEethPqeWDBzGn2X0PTqIdjBtlwfBIKkC9mfN6H6vu2B9ZNVIeNQVWgzMyPBaEFPaa+FMLSCIZL2OCkGDmjsCde14haLL7Zcan++3Cpv/7kd3LSWlv8iS0/kRVTOm4YMqR6vfAPZ2SflvSk3Tw5MGvuOGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716192423; c=relaxed/simple;
	bh=b4C4O9Sx6rLzrq3V07lotgbm2SPx0hwCrywEBbtjYuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJqv01xmeA9p0VFlgi74WUbqILMyiLsiw+8XBgVqH2TiZewsaIOoBCEw1kLxGb8eu6qei9FgXCP/9VmPN4hQ3v34Yg0VbLcj1ce+wjuwKW3X/2oyoKxzCTQUvokG5mB86mzDrqo/WTh2aFIkg4akrWyQWjUw7TLiBHYHrNdwUnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s4VExou/; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716192417; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=++1scIVTlEAtpTbSLtxFRxMTuuF+8J16P1HVrklJiZw=;
	b=s4VExou/wWQvw5OgikwDPXh6jLADB/seZoAbf4LK4hFmfAgSnNTrB61y4RkWqxDrjw5eqGGavFgTlGGRinHd+k3xh0+5NxWI0XdLqeITdNCNp6lc+HSLTqgpftzrBXTq9z4Hdw291gxV4piMYSDaBCz3u3U1iw5s7PIdOdjttPE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6oJVPe_1716192415;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6oJVPe_1716192415)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 16:06:57 +0800
Message-ID: <7d24fa89-0995-4104-84f1-dac6c8bf4477@linux.alibaba.com>
Date: Mon, 20 May 2024 16:06:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_get_fd()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-4-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-4-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We got the following issue in a fuzz test of randomly issuing the restore
> command:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0x609/0xab0
> Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962
> 
> CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
> Call Trace:
>  kasan_report+0x94/0xc0
>  cachefiles_ondemand_daemon_read+0x609/0xab0
>  vfs_read+0x169/0xb50
>  ksys_read+0xf5/0x1e0
> 
> Allocated by task 626:
>  __kmalloc+0x1df/0x4b0
>  cachefiles_ondemand_send_req+0x24d/0x690
>  cachefiles_create_tmpfile+0x249/0xb30
>  cachefiles_create_file+0x6f/0x140
>  cachefiles_look_up_object+0x29c/0xa60
>  cachefiles_lookup_cookie+0x37d/0xca0
>  fscache_cookie_state_machine+0x43c/0x1230
>  [...]
> 
> Freed by task 626:
>  kfree+0xf1/0x2c0
>  cachefiles_ondemand_send_req+0x568/0x690
>  cachefiles_create_tmpfile+0x249/0xb30
>  cachefiles_create_file+0x6f/0x140
>  cachefiles_look_up_object+0x29c/0xa60
>  cachefiles_lookup_cookie+0x37d/0xca0
>  fscache_cookie_state_machine+0x43c/0x1230
>  [...]
> ==================================================================
> 
> Following is the process that triggers the issue:
> 
>      mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
>  cachefiles_ondemand_init_object
>   cachefiles_ondemand_send_req
>    REQ_A = kzalloc(sizeof(*req) + data_len)
>    wait_for_completion(&REQ_A->done)
> 
>             cachefiles_daemon_read
>              cachefiles_ondemand_daemon_read
>               REQ_A = cachefiles_ondemand_select_req
>               cachefiles_ondemand_get_fd
>               copy_to_user(_buffer, msg, n)
>             process_open_req(REQ_A)
>                                   ------ restore ------
>                                   cachefiles_ondemand_restore
>                                   xas_for_each(&xas, req, ULONG_MAX)
>                                    xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> 
>                                   cachefiles_daemon_read
>                                    cachefiles_ondemand_daemon_read
>                                     REQ_A = cachefiles_ondemand_select_req
> 
>              write(devfd, ("copen %u,%llu", msg->msg_id, size));
>              cachefiles_ondemand_copen
>               xa_erase(&cache->reqs, id)
>               complete(&REQ_A->done)
>    kfree(REQ_A)
>                                     cachefiles_ondemand_get_fd(REQ_A)
>                                      fd = get_unused_fd_flags
>                                      file = anon_inode_getfile
>                                      fd_install(fd, file)
>                                      load = (void *)REQ_A->msg.data;
>                                      load->fd = fd;
>                                      // load UAF !!!
> 
> This issue is caused by issuing a restore command when the daemon is still
> alive, which results in a request being processed multiple times thus
> triggering a UAF. So to avoid this problem, add an additional reference
> count to cachefiles_req, which is held while waiting and reading, and then
> released when the waiting and reading is over.
> 
> Note that since there is only one reference count for waiting, we need to
> avoid the same request being completed multiple times, so we can only
> complete the request if it is successfully removed from the xarray.
> 
> Fixes: e73fa11a356c ("cachefiles: add restore command to recover inflight ondemand read requests")
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

How could we protect it from being erased from the xarray with the same
message id in this case?


-- 
Thanks,
Jingbo

