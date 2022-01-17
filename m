Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA148490324
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 08:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiAQHsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 02:48:21 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30284 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiAQHsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:48:21 -0500
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JckX76vvlzbk0g;
        Mon, 17 Jan 2022 15:47:35 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 15:48:19 +0800
Subject: Re: [PATCH] pipe: Fix endless sleep problem due to the out-of-order
To:     "miaoxie (A)" <miaoxie@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <31566e37493540ada2dda862fe8fb32b@huawei.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <61E51F42.8030202@huawei.com>
Date:   Mon, 17 Jan 2022 15:48:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <31566e37493540ada2dda862fe8fb32b@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gentel ping....


On 2021/12/12 0:51, miaoxie (A) wrote:
> Thers is a out-of-order access problem which would cause endless sleep
> when we use pipe with epoll.
>
> The story is following, we assume the ring size is 2, the ring head
> is 1, the ring tail is 0, task0 is write task, task1 is read task,
> task2 is write task.
> Task0					Task1		Task2
> epoll_ctl(fd, EPOLL_CTL_ADD, ...)
>    pipe_poll()
>      poll_wait()
>      tail = READ_ONCE(pipe->tail);
>      	// Re-order and get tail=0
> 				  	pipe_read
> 					tail++ //tail=1
> 							pipe_write
> 							head++ //head=2
>      head = READ_ONCE(pipe->head);
>      	// head = 2
>      check ring is full by head - tail
> Task0 get head = 2 and tail = 0, so it mistake that the pipe ring is
> full, then task0 is not add into ready list. If the ring is not full
> anymore, task0 would not be woken up forever
>
> The reason of this problem is that we got inconsistent head/tail value
> of the pipe ring, so we fix the problem by getting them by atomic.
>
> It seems that pipe_readable and pipe_writable is safe, so we don't
> change them.
>
> Signed-off-by: Miao Xie <miaoxie@huawei.com>
> ---
>   fs/pipe.c                 |  6 ++++--
>   include/linux/pipe_fs_i.h | 32 ++++++++++++++++++++++++++++++--
>   2 files changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 6d4342bad9f1..454056b1eaad 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -649,6 +649,7 @@ pipe_poll(struct file *filp, poll_table *wait)
>   	__poll_t mask;
>   	struct pipe_inode_info *pipe = filp->private_data;
>   	unsigned int head, tail;
> +	u64 ring_idxs;
>   
>   	/* Epoll has some historical nasty semantics, this enables them */
>   	pipe->poll_usage = 1;
> @@ -669,8 +670,9 @@ pipe_poll(struct file *filp, poll_table *wait)
>   	 * if something changes and you got it wrong, the poll
>   	 * table entry will wake you up and fix it.
>   	 */
> -	head = READ_ONCE(pipe->head);
> -	tail = READ_ONCE(pipe->tail);
> +	ring_idxs = (u64)atomic64_read(&pipe->ring_idxs);
> +	head = pipe_get_ring_head(ring_idxs);
> +	tail = pipe_get_ring_tail(ring_idxs);
>   
>   	mask = 0;
>   	if (filp->f_mode & FMODE_READ) {
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index fc5642431b92..9a7cb8077dc8 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -58,8 +58,18 @@ struct pipe_buffer {
>   struct pipe_inode_info {
>   	struct mutex mutex;
>   	wait_queue_head_t rd_wait, wr_wait;
> -	unsigned int head;
> -	unsigned int tail;
> +	union {
> +		/*
> +		 * If someone want to change this structure, you should also
> +		 * change the macro *PIPE_GET_DOORBELL* that is used to
> +		 * generate the ring head/tail access function.
> +		 */
> +		struct {
> +			unsigned int head;
> +			unsigned int tail;
> +		};
> +		atomic64_t ring_idxs;
> +	};
>   	unsigned int max_usage;
>   	unsigned int ring_size;
>   #ifdef CONFIG_WATCH_QUEUE
> @@ -82,6 +92,24 @@ struct pipe_inode_info {
>   #endif
>   };
>   
> +#define PIPE_GET_DOORBELL(bellname)					\
> +static inline unsigned int pipe_get_ring_##bellname(u64 ring_idxs)	\
> +{									\
> +	unsigned int doorbell;						\
> +	unsigned char *ptr = ((char *)&ring_idxs);			\
> +	int offset;							\
> +									\
> +	offset = (int)offsetof(struct pipe_inode_info, bellname);	\
> +	offset -= (int)offsetof(struct pipe_inode_info, ring_idxs);	\
> +	ptr += offset;							\
> +	doorbell = *((unsigned int *)ptr);				\
> +									\
> +	return doorbell;						\
> +}
> +
> +PIPE_GET_DOORBELL(head)
> +PIPE_GET_DOORBELL(tail)
> +
>   /*
>    * Note on the nesting of these functions:
>    *

