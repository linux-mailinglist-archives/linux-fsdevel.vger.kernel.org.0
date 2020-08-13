Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBC5243DB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMQtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 12:49:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43066 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHMQtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:49:41 -0400
Received: by mail-io1-f65.google.com with SMTP id k23so7946750iom.10;
        Thu, 13 Aug 2020 09:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oZ19wRQzUr4AIajJEmDg571mMOTdhTENNwtyK08+5cg=;
        b=FK9VIY0Ayv6PUizRaDPyZVx4KLucmfY0aIt4WppXirWNvcNKkdO7qGdhE119vme7T0
         XSsyB6wsUTbpz7qgkg+pnspxqOnM5titEpG7+vIIh9mz3+5YOHNsMeHiJ7bm28Pn3C8H
         qlwHvEP4S2Xt1GpO6eOPDs2HZjHW8VvssZrfB7a9tRsykFmONvL7pc/CAgmOujSt+Xvj
         PRAfdfiGBPfaMZQxuMo7kVZfDI79T5HiXtlG36G8MdICf+KgpSLtWmnG53AX3t1wLIkC
         NqvgkaoHvfK3+GLUtndnLTNonP19w+CMHs3/zSxqHBvZB3ERg4KguVy/FCQFfvtCtB2p
         H3pg==
X-Gm-Message-State: AOAM530YchXWVPQLWzw1hupyE0OwB8l0octfhMLIjQVjhpP3AegFRdVY
        XeloTJrmJO0b8y2KRXmns9k=
X-Google-Smtp-Source: ABdhPJyK6lV5GsIYKeXz7YeFZNYInTHphj60xDI7tJFaCtsyu1+NskpY4ZE+xYBdPC2MbeoNR4o9bQ==
X-Received: by 2002:a6b:b513:: with SMTP id e19mr5672184iof.167.1597337380470;
        Thu, 13 Aug 2020 09:49:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m13sm2899141iov.35.2020.08.13.09.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 09:49:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E29C7403DC; Thu, 13 Aug 2020 16:49:31 +0000 (UTC)
Date:   Thu, 13 Aug 2020 16:49:31 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com, willy@infradead.org,
        hch@lst.de
Subject: Re: [PATCH -next] sysctl: fix memleak in proc_sys_call_handler()
Message-ID: <20200813164931.GW4332@42.do-not-panic.com>
References: <20200804154503.3863200-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804154503.3863200-1-yangyingliang@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 03:45:03PM +0000, Yang Yingliang wrote:
> I got a memleak report when doing some fuzz test:
> 
> BUG: memory leak
> unreferenced object 0xffff888103f3da00 (size 64):
> comm "syz-executor.0", pid 2270, jiffies 4295404698 (age 46.593s)
> hex dump (first 32 bytes):
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> backtrace:
> [<000000004f2c0607>] kmalloc include/linux/slab.h:559 [inline]
> [<000000004f2c0607>] kzalloc include/linux/slab.h:666 [inline]
> [<000000004f2c0607>] proc_sys_call_handler+0x1d4/0x480 fs/proc/proc_sysctl.c:574
> [<000000005ec6a16b>] call_write_iter include/linux/fs.h:1876 [inline]
> [<000000005ec6a16b>] new_sync_write+0x3c5/0x5b0 fs/read_write.c:515
> [<00000000bbeebb83>] vfs_write+0x4e8/0x670 fs/read_write.c:595
> [<000000009d967c93>] ksys_write+0x10c/0x220 fs/read_write.c:648
> [<00000000139f6002>] do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
> [<00000000b7d61f44>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Go to free buff when copy_from_iter_full() is failed.
> 
> Fixes: 1dea05cbc0d7 ("sysctl: Convert to iter interfaces")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Good catch.

  Luis
> ---
>  fs/proc/proc_sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 9f6b9c3e3fda..a4a3122f8a58 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -578,7 +578,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
>  	if (write) {
>  		error = -EFAULT;
>  		if (!copy_from_iter_full(kbuf, count, iter))
> -			goto out;
> +			goto out_free_buf;
>  		kbuf[count] = '\0';
>  	}
>  
> -- 
> 2.25.1
> 
