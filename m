Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491A570A841
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 15:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjETND5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETND4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 09:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D846121;
        Sat, 20 May 2023 06:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B46A460ADB;
        Sat, 20 May 2023 13:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C2FC433EF;
        Sat, 20 May 2023 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684587834;
        bh=CaFXi9q+WoKBuXyVVgMPIOn5XN/0+5juvLuIbWmVSoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKc/ct2EQTcT/ZO3UbqtuskstgvAcAToW8AISP+bpuL8miQVPYP0bxL/OBEAT1PbI
         pvfTSIw+srkc8bXbFoQ2mSEv4X8b5bP1QULXTnptXFIe3sb1RWLOjbcl9Geb1eKrdH
         kq0yA2aDgaOSaxbbRwq1/zCyN1PrK1/GagA40/knD39uFEBv0cqTyXE2J5YZQ/w8zo
         K6qRlyfKGu1vwHa2MxOJH7T/62mbDYEqIlqQPLvyf8En/g84PI4IsQ7KJ86B5F3WU8
         9ewL4G6p1NuuAm8eqxdPNXOWWuXx+6qy4rgMgC20rPuYxL9G1qcg1phigW5tlGxAlk
         zxqVA0+L9MFxw==
Date:   Sat, 20 May 2023 15:03:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     aloktiagi <aloktiagi@gmail.com>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, tycho@tycho.pizza
Subject: Re: [RFC v5 1/2] epoll: Implement eventpoll_replace_file()
Message-ID: <20230520-pseudologie-beharren-5c5c440c204e@brauner>
References: <20230429054955.1957024-1-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230429054955.1957024-1-aloktiagi@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 29, 2023 at 05:49:54AM +0000, aloktiagi wrote:
> Introduce a mechanism to replace a file linked in the epoll interface with a new
> file.
> 
> eventpoll_replace() finds all instances of the file to be replaced and replaces
> them with the new file and the interested events.
> 
> Signed-off-by: aloktiagi <aloktiagi@gmail.com>
> ---
> Changes in v5:
>   - address review comments and move the call to replace old file in each
>     subsystem (epoll, io_uring, etc.) outside the fdtable helpers like
>     replace_fd().
> 
> Changes in v4:
>   - address review comment to remove the redundant eventpoll_replace() function.
>   - removed an extra empty line introduced in include/linux/file.h
> 
> Changes in v3:
>   - address review comment and iterate over the file table while holding the
>     spin_lock(&files->file_lock).
>   - address review comment and call filp_close() outside the
>     spin_lock(&files->file_lock).
> ---
>  fs/eventpoll.c            | 65 +++++++++++++++++++++++++++++++++++++++
>  include/linux/eventpoll.h |  8 +++++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 64659b110973..be9d192b223d 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -935,6 +935,71 @@ void eventpoll_release_file(struct file *file)
>  	mutex_unlock(&epmutex);
>  }
>  
> +static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
> +			struct file *tfile, int fd, int full_check);
> +
> +/*
> + * This is called from eventpoll_replace() to replace a linked file in the epoll
> + * interface with a new file received from another process. This is useful in
> + * cases where a process is trying to install a new file for an existing one
> + * that is linked in the epoll interface
> + */
> +int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd)
> +{
> +	int fd;
> +	int error = 0;
> +	struct eventpoll *ep;
> +	struct epitem *epi;
> +	struct hlist_node *next;
> +	struct epoll_event event;
> +	struct hlist_head *to_remove = toreplace->f_ep;
> +
> +	if (!file_can_poll(file))
> +		return 0;
> +
> +	mutex_lock(&epmutex);

Sorry, I missed that you send a new version somehow.

So, I think I mentioned this last time: The locking has changed to
reduce contention on the global mutex. Both epmutex and ep_remove() are
gone. So this doesn't even compile anymore...

  CC      fs/eventpoll.o
../fs/eventpoll.c: In function ‘eventpoll_replace_file’:
../fs/eventpoll.c:998:21: error: ‘epmutex’ undeclared (first use in this function); did you mean ‘mutex’?
  998 |         mutex_lock(&epmutex);
      |                     ^~~~~~~
      |                     mutex
../fs/eventpoll.c:998:21: note: each undeclared identifier is reported only once for each function it appears in
../fs/eventpoll.c:1034:17: error: implicit declaration of function ‘ep_remove’; did you mean ‘idr_remove’? [-Werror=implicit-function-declaration]
 1034 |                 ep_remove(ep, epi);
      |                 ^~~~~~~~~
      |                 idr_remove

on current mainline. So please send a new version for this.
