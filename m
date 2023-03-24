Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26B6C774A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjCXF0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjCXFZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:25:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5342B2A1;
        Thu, 23 Mar 2023 22:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lWW9PVqLe3/9juBXgwjKTyYaGeIui89h/DnPHia9ygk=; b=BxO6iQ99W+zTHMj2QHBCJhGl15
        q2lXUF+oqg6ib8AW/SChw/d0ZLzn9mqj7zeWtH0gc4MM7QQAoCoCwUqrs8CdCsr27PoAGg3v1GeuB
        KcE1XYPW+8FsVeyMjCd80rsK54rorbS+xJHi4oeVf1HTk7/bMW86B0lzUQvvgTu1W2k9srGTITdZJ
        yt2ZKy09k5+Q4TGwJ5kg+CtzH9LREQI7oBpV8UOhXJ1/EbPKUy+xK8gV3w0xffrrD/kM6KL8bz+lq
        WbrAU8ndKYKWnuT+ypDt5ImkJn7Zds3deyagHbLOjySro1phDTGHS26b0yG8JmnR+d9yr6593h8va
        vOAuQEaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfZuc-004bi4-ET; Fri, 24 Mar 2023 05:24:26 +0000
Date:   Fri, 24 Mar 2023 05:24:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     aloktiagi <aloktiagi@gmail.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC v3 3/3] file, epoll: Implement do_replace() and
 eventpoll_replace()
Message-ID: <ZB00Cvib+jyqCR5C@casper.infradead.org>
References: <20230324051526.963702-1-aloktiagi@gmail.com>
 <20230324051526.963702-3-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324051526.963702-3-aloktiagi@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:15:26AM +0000, aloktiagi wrote:
> diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
> index 3337745d81bd..38904fce3840 100644
> --- a/include/linux/eventpoll.h
> +++ b/include/linux/eventpoll.h
> @@ -25,6 +25,8 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
>  /* Used to release the epoll bits inside the "struct file" */
>  void eventpoll_release_file(struct file *file);
>  
> +void eventpoll_replace_file(struct file *toreplace, struct file *file);
> +
>  /*
>   * This is called from inside fs/file_table.c:__fput() to unlink files
>   * from the eventpoll interface. We need to have this facility to cleanup
> @@ -53,6 +55,22 @@ static inline void eventpoll_release(struct file *file)
>  	eventpoll_release_file(file);
>  }
>  
> +
> +/*
> + * This is called from fs/file.c:do_replace() to replace a linked file in the
> + * epoll interface with a new file received from another process. This is useful
> + * in cases where a process is trying to install a new file for an existing one
> + * that is linked in the epoll interface
> + */
> +static inline void eventpoll_replace(struct file *toreplace, struct file *file)
> +{
> +	/*
> +	 * toreplace is the file being replaced. Install the new file for the
> +	 * existing one that is linked in the epoll interface
> +	 */
> +	eventpoll_replace_file(toreplace, file);
> +}

Why do we have both eventpoll_replace() and eventpoll_replace_file()?
They seem identical?

> diff --git a/include/linux/file.h b/include/linux/file.h
> index 39704eae83e2..80e56b2b44fb 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -36,6 +36,7 @@ struct fd {
>  	struct file *file;
>  	unsigned int flags;
>  };
> +
>  #define FDPUT_FPUT       1
>  #define FDPUT_POS_UNLOCK 2
>  

You should drop this hunk of the patch.
