Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68534A547
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 11:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCZKHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 06:07:09 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55873 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229779AbhCZKGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:06:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UTMkjSm_1616753202;
Received: from 30.21.164.88(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UTMkjSm_1616753202)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Mar 2021 18:06:42 +0800
Subject: Re: [PATCH] fuse: Fix possible deadlock when writing back dirty pages
To:     miklos@szeredi.hu
Cc:     tao.peng@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <646dfa21bf75729f0c81597122cdec60a80b2035.1616742789.git.baolin.wang@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <34c124be-fd95-a1c6-4e67-7719081fe854@linux.alibaba.com>
Date:   Fri, 26 Mar 2021 18:06:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <646dfa21bf75729f0c81597122cdec60a80b2035.1616742789.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> We can meet below deadlock scenario when writing back dirty pages, and
> writing files at the same time. The deadlock scenario can be reproduced
> by:
> 
> - A writeback worker thread A is trying to write a bunch of dirty pages by
> fuse_writepages(), and the fuse_writepages() will lock one page (named page 1),
> add it into rb_tree with setting writeback flag, and unlock this page 1,
> then try to lock next page (named page 2).
> 
> - But at the same time a file writing can be triggered by another process B,
> to write several pages by fuse_perform_write(), the fuse_perform_write()
> will lock all required pages firstly, then wait for all writeback pages
> are completed by fuse_wait_on_page_writeback().
> 
> - Now the process B can already lock page 1 and page 2, and wait for page 1
> waritehack is completed (page 1 is under writeback set by process A). But
> process A can not complete the writeback of page 1, since it is still
> waiting for locking page 2, which was locked by process B already.
> 
> A deadlock is occurred.
> 
> To fix this issue, we should make sure each page writeback is completed after
> lock the page in fuse_fill_write_pages(), and then write them together when
> all pages are stable.
> 
> [1450578.772896] INFO: task kworker/u259:6:119885 blocked for more than 120 seconds.
> [1450578.796179] kworker/u259:6  D    0 119885      2 0x00000028
> [1450578.796185] Workqueue: writeback wb_workfn (flush-0:78)
> [1450578.796188] Call trace:
> [1450578.798804]  __switch_to+0xd8/0x148
> [1450578.802458]  __schedule+0x280/0x6a0
> [1450578.806112]  schedule+0x34/0xe8
> [1450578.809413]  io_schedule+0x20/0x40
> [1450578.812977]  __lock_page+0x164/0x278
> [1450578.816718]  write_cache_pages+0x2b0/0x4a8
> [1450578.820986]  fuse_writepages+0x84/0x100 [fuse]
> [1450578.825592]  do_writepages+0x58/0x108
> [1450578.829412]  __writeback_single_inode+0x48/0x448
> [1450578.834217]  writeback_sb_inodes+0x220/0x520
> [1450578.838647]  __writeback_inodes_wb+0x50/0xe8
> [1450578.843080]  wb_writeback+0x294/0x3b8
> [1450578.846906]  wb_do_writeback+0x2ec/0x388
> [1450578.850992]  wb_workfn+0x80/0x1e0
> [1450578.854472]  process_one_work+0x1bc/0x3f0
> [1450578.858645]  worker_thread+0x164/0x468
> [1450578.862559]  kthread+0x108/0x138
> [1450578.865960] INFO: task doio:207752 blocked for more than 120 seconds.
> [1450578.888321] doio            D    0 207752 207740 0x00000000
> [1450578.888329] Call trace:
> [1450578.890945]  __switch_to+0xd8/0x148
> [1450578.894599]  __schedule+0x280/0x6a0
> [1450578.898255]  schedule+0x34/0xe8
> [1450578.901568]  fuse_wait_on_page_writeback+0x8c/0xc8 [fuse]
> [1450578.907128]  fuse_perform_write+0x240/0x4e0 [fuse]
> [1450578.912082]  fuse_file_write_iter+0x1dc/0x290 [fuse]
> [1450578.917207]  do_iter_readv_writev+0x110/0x188
> [1450578.921724]  do_iter_write+0x90/0x1c8
> [1450578.925598]  vfs_writev+0x84/0xf8
> [1450578.929071]  do_writev+0x70/0x110
> [1450578.932552]  __arm64_sys_writev+0x24/0x30
> [1450578.936727]  el0_svc_common.constprop.0+0x80/0x1f8
> [1450578.941694]  el0_svc_handler+0x30/0x80
> [1450578.945606]  el0_svc+0x10/0x14
> 
> Suggested-by: Peng Tao <tao.peng@linux.alibaba.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   fs/fuse/file.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8cccecb..af082b6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1166,6 +1166,8 @@ static ssize_t fuse_fill_write_pages(struct fuse_args_pages *ap,
>   		if (!page)
>   			break;
>   
> +		wait_on_page_writeback(page);

After talked with Tao, I should use fuse_wait_on_page_writeback() 
instead to wait for each page stable in fuse, and also will remove
the fuse_wait_on_page_writeback() in fuse_send_write_pages().

I will send a V2, please ignore this patch. Thanks.
