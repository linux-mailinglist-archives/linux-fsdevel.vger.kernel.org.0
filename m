Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6085E316C5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 18:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhBJRRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 12:17:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:35314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232418AbhBJRQx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:16:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41F08AE2D;
        Wed, 10 Feb 2021 17:16:09 +0000 (UTC)
Subject: Re: [PATCH] proc: use vmalloc for our kernel buffer
To:     Josef Bacik <josef@toxicpanda.com>, viro@ZenIV.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        willy@infradead.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Steven Noonan <steven@uplinklabs.net>
References: <6345270a2c1160b89dd5e6715461f388176899d1.1612972413.git.josef@toxicpanda.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4d4257c0-37ff-4602-a540-1607a8b42525@suse.cz>
Date:   Wed, 10 Feb 2021 18:16:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6345270a2c1160b89dd5e6715461f388176899d1.1612972413.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/21 4:54 PM, Josef Bacik wrote:
> Since
> 
>   sysctl: pass kernel pointers to ->proc_handler
> 
> we have been pre-allocating a buffer to copy the data from the proc
> handlers into, and then copying that to userspace.  The problem is this
> just blind kmalloc()'s the buffer size passed in from the read, which in
> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
> awesome, and since we can potentially allocate up to our maximum order,
> use vmalloc for these buffers.
> 
> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  fs/proc/proc_sysctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index d2018f70d1fa..070d2df8ab9c 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -571,7 +571,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
>  	error = -ENOMEM;
>  	if (count >= KMALLOC_MAX_SIZE)
>  		goto out;
> -	kbuf = kzalloc(count + 1, GFP_KERNEL);
> +	kbuf = kvzalloc(count + 1, GFP_KERNEL);
>  	if (!kbuf)
>  		goto out;
>  
> @@ -600,7 +600,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	error = count;
>  out_free_buf:
> -	kfree(kbuf);
> +	kvfree(kbuf);
>  out:
>  	sysctl_head_finish(head);
>  
> 

