Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183F0316E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 19:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhBJSTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 13:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhBJSQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:16:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B804C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NbjvXyplCPwQIiH1Ea28bHugHnsmh7DhfNYPdCm6dl0=; b=b3L+1CbyXvg2gacInZPvHtTCyC
        v+o+FeI5BACbIT1uUF/q1ltp0Lbgg/r8SoI61w6f97i0MzD1NLWXl+IAch752K2hvB4YNUCWycZWs
        tHpZEnR/6Vpw/CtRCEeqvQ7xyMp2P5lQWm4c6cLL/wFwcplMdCOZKHsfwNGb83br7hmm4j53oeHXw
        D8hlJQ797T33CBAmzddI+osPDycQcQAkMr7tm8M7CAMeeV0vbOUxPlhjqrO12+2Y3q919YmgO+cW+
        TQmq2o8WhlmYSU76m2Q/H4oPzxpau876NoyEDwG8TtpoGeFEEPjLB8aHGKwFMEni2iYMqu/CASAQ/
        yKqpXA+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9u1P-009D5L-BG; Wed, 10 Feb 2021 18:15:27 +0000
Date:   Wed, 10 Feb 2021 18:15:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, vbabka@suse.cz,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] proc: use vmalloc for our kernel buffer
Message-ID: <20210210181527.GD308988@casper.infradead.org>
References: <6345270a2c1160b89dd5e6715461f388176899d1.1612972413.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6345270a2c1160b89dd5e6715461f388176899d1.1612972413.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

s/vmalloc/kvmalloc/g

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

On Wed, Feb 10, 2021 at 10:54:24AM -0500, Josef Bacik wrote:
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
> -- 
> 2.26.2
> 
