Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D251550BD6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiFSPRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiFSPRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:17:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A654DF11
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2x/zSDPmY8eu/0JXJSbRzotLa/HtxeAbFm0NQLhOEiI=; b=URwVEv1m47uCJ+BCp+pcQu+Ha9
        lYj3M999sozCxG1jzUDwF9kvqa3T1MAd4ti1+v9ZUkgTQI7z+dOVXX2ncRuCG3LUG5a5w+FnZxzJG
        t8jnGBekLNTBJ1KdzGNxa1LzvEolZQ2X167A8QYJqA6PKBU9rd4ARAuX+xJS8N4PgwD57vZgAZXwo
        /m3XdhpojrCJ+BSbDI/jjCJl1PFWzTHq7+6C92ZEP9HbxwHb3XB5/mCRkUtfJS6zPs0HHpjoqfimP
        9jxZl9NP/bZaA+0MTYiMQkaH1z6VxTx/EfX8HTMbRei13jnj4Z4OA16SKuX1OVAmZ4zyjAhdqPJLe
        G2rQj8bg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2wg3-004Qdu-2d; Sun, 19 Jun 2022 15:17:27 +0000
Date:   Sun, 19 Jun 2022 16:17:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Li Chen <me@linux.beauty>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] fs: use call_read_iter(file, &kiocb, &iter); for
 __kernel_{read|write}
Message-ID: <Yq8+Bya1HMJ+KtNC@casper.infradead.org>
References: <18179f8b59d.b7fe20f5281387.193977444358758943@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18179f8b59d.b7fe20f5281387.193977444358758943@linux.beauty>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 18, 2022 at 08:19:11PM -0700, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> Just use these helper functions to replace f_op->{read,write}_iter()

... why?  You've saved a massive two bytes of kernel source.
What is the point of these functions?  I'd rather just get rid of them.

> Signed-off-by: Li Chen <lchen@ambarella.com>
> ---
>  fs/read_write.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b1b1cdfee9d3..9518aeca0273 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -437,7 +437,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos = pos ? *pos : 0;
>  	iov_iter_kvec(&iter, READ, &iov, 1, iov.iov_len);
> -	ret = file->f_op->read_iter(&kiocb, &iter);
> +	ret = call_read_iter(file, &kiocb, &iter);
>  	if (ret > 0) {
>  		if (pos)
>  			*pos = kiocb.ki_pos;
> @@ -533,7 +533,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos = pos ? *pos : 0;
>  	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
> -	ret = file->f_op->write_iter(&kiocb, &iter);
> +	ret = call_write_iter(file, &kiocb, &iter);
>  	if (ret > 0) {
>  		if (pos)
>  			*pos = kiocb.ki_pos;
> -- 
> 2.36.1
> 
> 
