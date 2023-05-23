Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1889170DDCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjEWNok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 09:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbjEWNoj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 09:44:39 -0400
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C83E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y2wJywGMXAg5Rl4zmKdJvnE9yWsAlKB6eSvxlDxCSBo=; b=IxctZ5iTliTKUn52gnBzfNMZRZ
        +qy6wO6boaePW4GOeZ1YyLHlH+4zFx+t1fHBvVrq1oTBMdBwSW7vdczXMaq2Ngiq9pr4qQIUYbCfv
        1qKND1pQDz9xGUfTAF0VGa321Ochw8r45iBUVHIFuPCPLksIsqxHVVjYPgXtNhbCAz+C3/vEGE74w
        KoPr2OVptIkezVncRKsSUGSW3Cb8AFfJQjIlg1KeYWwRYFH6PiGcFwRhhbM3XB7CRqDGqx7AQkS2E
        rbTSQ0JVXqHoNbhl0ymljVXal7v44hcOSJtWNEGnhDP3Fy1rKUheEp8pN7fTqORnzKqtJ0rQYZAWc
        lngK3EXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1S7K-00AFpO-ND; Tue, 23 May 2023 13:31:58 +0000
Date:   Tue, 23 May 2023 14:31:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     aloktiagi <aloktiagi@gmail.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, tycho@tycho.pizza
Subject: Re: [RFC v6 1/2] epoll: Implement eventpoll_replace_file()
Message-ID: <ZGzATlGu7mh6EFUi@casper.infradead.org>
References: <20230523065802.2253926-1-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523065802.2253926-1-aloktiagi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 06:58:01AM +0000, aloktiagi wrote:
> +/*
> + * This is called from eventpoll_replace() to replace a linked file in the epoll
> + * interface with a new file received from another process. This is useful in
> + * cases where a process is trying to install a new file for an existing one
> + * that is linked in the epoll interface
> + */
> +int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd)

Functions do not control where they are called from.  Just take that
clause out:

/*
 * Replace a linked file in the epoll interface with a new file received
 * from another process. This allows a process to
 * install a new file for an existing one that is linked in the epoll
 * interface
 */

But, erm, aren't those two sentences basically saying the same thing?
So simplify again:

/*
 * Replace a linked file in the epoll interface with a new file
 */

> diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
> index 3337745d81bd..2a6c8f52f272 100644
> --- a/include/linux/eventpoll.h
> +++ b/include/linux/eventpoll.h
> @@ -25,6 +25,14 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
>  /* Used to release the epoll bits inside the "struct file" */
>  void eventpoll_release_file(struct file *file);
>  
> +/*
> + * This is called from fs/file.c:do_replace() to replace a linked file in the
> + * epoll interface with a new file received from another process. This is useful
> + * in cases where a process is trying to install a new file for an existing one
> + * that is linked in the epoll interface
> + */
> +int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd);

No need to repeat the comment again.  Just delete it here.
