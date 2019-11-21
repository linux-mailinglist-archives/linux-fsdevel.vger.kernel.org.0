Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75878104A60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfKUFue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:50:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47939 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbfKUFue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:50:34 -0500
X-IronPort-AV: E=Sophos;i="5.69,224,1571673600"; 
   d="scan'208";a="78831327"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Nov 2019 13:50:32 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 6F4CC4CE1BED;
        Thu, 21 Nov 2019 13:42:11 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 21 Nov 2019 13:50:26 +0800
Subject: Re: [PATCH] fuse: Fix the return code of fuse_direct_IO() to deal
 with the error for aio
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>
CC:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <virtio-fs@redhat.com>
References: <20191118022410.21023-1-msys.mizuma@gmail.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <c80528c2-31ee-ccfc-127b-66bc7f93b669@cn.fujitsu.com>
Date:   Thu, 21 Nov 2019 13:51:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191118022410.21023-1-msys.mizuma@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 6F4CC4CE1BED.AB5CD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/19 10:24 AM, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> exit_aio() is sometimes stuck in wait_for_completion() after aio is issued
> with direct IO and the task receives a signal.
> 
> That is because kioctx in mm->ioctx_table is in use by aio_kiocb.
> aio_kiocb->ki_refcnt is 1 at that time. That means iocb_put() isn't
> called correctly.
> 
> fuse_get_req() returns as -EINTR when it's blocked and receives a signal.
> fuse_direct_IO() deals with the -EINTER as -EIOCBQUEUED and returns as
> -EIOCBQUEUED even though the aio isn't queued.
> As the result, aio_rw_done() doesn't handle the error, so iocb_put() isn't
> called via aio_complete_rw(), which is the callback.
> 
> The flow is something like as:
> 
>   io_submit
>     aio_get_req
>       refcount_set(&req->ki_refcnt, 2)
>     __io_submit_one
>       aio_read
>       ...
>         fuse_direct_IO # return as -EIOCBQUEUED
>           __fuse_direct_read
>           ...
>             fuse_get_req # return as -EINTR
>         aio_rw_done
>           # Nothing to do because ret is -EIOCBQUEUED...
>     iocb_put
>       refcount_dec_and_test(&iocb->ki_refcnt) # 2->1
> 
> Return as the error code of fuse_direct_io() or __fuse_direct_read() in
> fuse_direct_IO() so that aio_rw_done() can handle the error and call
> iocb_put().
> 
> This issue is trucked as a virtio-fs issue:
> https://gitlab.com/virtio-fs/qemu/issues/14
> 

I didn't reproduce this issue on kernel v5.4-rc7, but did on 5.4-rc8.
And verified this patch fixed the case in issue 14 on v5.4-rc8 and
virtiofsd (virtio-fs-dev 5f068fa9).

Tested-by: Cao jin <caoj.fnst@cn.fujitsu.com>
-- 
Sincerely,
Cao jin


