Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6E7A6D05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjISVlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISVlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:41:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467F3BD;
        Tue, 19 Sep 2023 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+OICXMqXKe+Hn7aCZpgT9ykVO8ucUUmG7sDoNC+T+iA=; b=W6tIaulLcdYUah2+pjrzozhkSc
        jWuuYdOLPUMmNzFfXBT+I7hkZPOyY6rf6at9ebH0zLZduinD2UKKJ7r8LJMvdz5h2oN47y1cYgADR
        Cy5omls3ZxcV42lz/HRa4coysfY48S3yN/96V01XioMLxEaQUG3c618Uepud7y8n7uyjRYrukzvCw
        zzLGh+EJPwxeJXnhKkF5GA39kFKRuUXeGJ8+CUEPNmtEBz53n7jBhv8FpKZjpxgMtWROsoo/I0oRt
        rLC9AjEsXKTvGD2HSbsREsC/21FmAqCcodKXL3Rt/HIlQaoYcbJ/Gui64ZedAJIS+NFSQzYRp7o8o
        b+/pnXkQ==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiiSo-001IkI-1I;
        Tue, 19 Sep 2023 21:40:58 +0000
Message-ID: <f185463b-4781-4e63-894b-c3592e3c0852@infradead.org>
Date:   Tue, 19 Sep 2023 14:40:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_fs_i.h: add pipe_buf_init()
Content-Language: en-US
To:     Max Kellermann <max.kellermann@ionos.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230919080707.1077426-1-max.kellermann@ionos.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230919080707.1077426-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 9/19/23 01:07, Max Kellermann wrote:
> Adds one central function which shall be used to initialize a newly
> allocated struct pipe_buffer.  This shall make the pipe code more
> robust for the next time the pipe_buffer struct gets modified, to
> avoid leaving new members uninitialized.  Instead, adding new members
> should also add a new pipe_buf_init() parameter, which causes
> compile-time errors in call sites that were not adapted.
> 
> This commit doesn't refactor fs/fuse/dev.c because this code looks
> obscure to me; it initializes pipe_buffers incrementally through a
> variety of functions, too complicated for me to understand.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/pipe.c                 |  9 +++------
>  fs/splice.c               |  9 ++++-----
>  include/linux/pipe_fs_i.h | 20 ++++++++++++++++++++
>  kernel/watch_queue.c      |  8 +++-----
>  mm/filemap.c              |  8 ++------
>  mm/shmem.c                |  9 +++------
>  6 files changed, 35 insertions(+), 28 deletions(-)
> 

> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 608a9eb86bff..2ef2bb218641 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -176,6 +176,26 @@ static inline struct pipe_buffer *pipe_head_buf(const struct pipe_inode_info *pi
>  	return pipe_buf(pipe, pipe->head);
>  }
>  
> +/**
> + * Initialize a struct pipe_buffer.
> + */

That's not a kernel-doc comment so don't begin it with /**.
Just use /* instead.
Thanks.

> +static inline void pipe_buf_init(struct pipe_buffer *buf,
> +				 struct page *page,
> +				 unsigned int offset, unsigned int len,
> +				 const struct pipe_buf_operations *ops,
> +				 unsigned int flags)
> +{
> +	buf->page = page;
> +	buf->offset = offset;
> +	buf->len = len;
> +	buf->ops = ops;
> +	buf->flags = flags;
> +
> +	/* not initializing the "private" member because it is only
> +	   used by pipe_buf_operations which inject it via struct
> +	   partial_page / struct splice_pipe_desc */
> +}
> +
>  /**
>   * pipe_buf_get - get a reference to a pipe_buffer
>   * @pipe:	the pipe that the buffer belongs to


-- 
~Randy
