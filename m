Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB1770BECE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 14:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjEVMxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 08:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjEVMxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 08:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5070AC;
        Mon, 22 May 2023 05:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 521B76182C;
        Mon, 22 May 2023 12:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452FFC433EF;
        Mon, 22 May 2023 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684760023;
        bh=ImInocG/5tz/0H3zPAKjnZJKUJJ7f7gU8sP1cCYTc4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoCejcijL504amG1JWhHwZTY9ANeFzKIntYQLP07J5uj6is7A9fQS3E45NEVz8wk6
         ijfRl5PO3lTu/TTTIv32g7R7yLRypfiWOTi3Uj/0KvpuFrOTVcMel9+d2wSGIkyYdu
         vUWYxwspLqeF3kuLLovyI+OOPx0h36hOwidawlUZUg9fAT5m8b6iSCy+1CpVnsDVp7
         WsqlRyT5zrYfRVFyupWZadvSK20ofoJ9ED4LN+qqMECRszCrYQYsWxjuqjJ6xikft9
         Dj+RJ+BTQGXrekuYCaTiR3iKGCv67tOqqWySpi7M8dOONCCzlP1x8letugsbywO8H1
         ygjRrnqit//Zw==
Date:   Mon, 22 May 2023 14:53:31 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v21 03/30] splice: Rename direct_splice_read() to
 copy_splice_read()
Message-ID: <20230522-pfund-ferngeblieben-53fad9c0e527@brauner>
References: <20230520-sekunde-vorteil-f2d588e40b68@brauner>
 <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-4-dhowells@redhat.com>
 <2468127.1684742114@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2468127.1684742114@warthog.procyon.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 08:55:14AM +0100, David Howells wrote:
> > For the future it'd be nice if exported functions would always get
> > proper kernel doc,
> 
> Something like the attached?
> 
> David
> ---
> commit 0362042ba0751fc5457b0548fb9006f9d7dfbeca
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon May 22 08:34:24 2023 +0100
> 
>     splice: kdoc for filemap_splice_read() and copy_splice_read()
>     
>     Provide kerneldoc comments for filemap_splice_read() and
>     copy_splice_read().
>     
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     cc: Christian Brauner <brauner@kernel.org>
>     cc: Christoph Hellwig <hch@lst.de>
>     cc: Jens Axboe <axboe@kernel.dk>
>     cc: Steve French <smfrench@gmail.com>
>     cc: Al Viro <viro@zeniv.linux.org.uk>
>     cc: linux-mm@kvack.org
>     cc: linux-block@vger.kernel.org
>     cc: linux-cifs@vger.kernel.org
>     cc: linux-fsdevel@vger.kernel.org
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 9be4cb3b9879..5292a8fa929d 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -299,8 +299,25 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
>  	kfree(spd->partial);
>  }
>  
> -/*
> - * Copy data from a file into pages and then splice those into the output pipe.
> +/**
> + * copy_splice_read -  Copy data from a file and splice the copy into a pipe
> + * @in: The file to read from
> + * @ppos: Pointer to the file position to read from
> + * @pipe: The pipe to splice into
> + * @len: The amount to splice
> + * @flags: The SPLICE_F_* flags
> + *
> + * This function allocates a bunch of pages sufficient to hold the requested
> + * amount of data (but limited by the remaining pipe capacity), passes it to
> + * the file's ->read_iter() to read into and then splices the used pages into
> + * the pipe.
> + *
> + * On success, the number of bytes read will be returned and *@ppos will be
> + * updated if appropriate; 0 will be returned if there is no more data to be
> + * read; -EAGAIN will be returned if the pipe had no space, and some other
> + * negative error code will be returned on error.  A short read may occur if
> + * the pipe has insufficient space, we reach the end of the data or we hit a
> + * hole.
>   */

I think kdoc expects:

* Return: On success, the number of bytes read will be returned and *@ppos will be
* updated if appropriate; 0 will be returned if there is no more data to be
* read; -EAGAIN will be returned if the pipe had no space, and some other
* negative error code will be returned on error.  A short read may occur if
* the pipe has insufficient space, we reach the end of the data or we hit a
* hole.

and similar for filemap_splice_read() other than that this looks good!

>  ssize_t copy_splice_read(struct file *in, loff_t *ppos,
>  			 struct pipe_inode_info *pipe,
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 603b562d69b1..1f235a6430fd 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2871,9 +2871,24 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
>  	return spliced;
>  }
>  
> -/*
> - * Splice folios from the pagecache of a buffered (ie. non-O_DIRECT) file into
> - * a pipe.
> +/**
> + * filemap_splice_read -  Splice data from a file's pagecache into a pipe
> + * @in: The file to read from
> + * @ppos: Pointer to the file position to read from
> + * @pipe: The pipe to splice into
> + * @len: The amount to splice
> + * @flags: The SPLICE_F_* flags
> + *
> + * This function gets folios from a file's pagecache and splices them into the
> + * pipe.  Readahead will be called as necessary to fill more folios.  This may
> + * be used for blockdevs also.
> + *
> + * On success, the number of bytes read will be returned and *@ppos will be
> + * updated if appropriate; 0 will be returned if there is no more data to be
> + * read; -EAGAIN will be returned if the pipe had no space, and some other
> + * negative error code will be returned on error.  A short read may occur if
> + * the pipe has insufficient space, we reach the end of the data or we hit a
> + * hole.
>   */
>  ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>  			    struct pipe_inode_info *pipe,
> 
