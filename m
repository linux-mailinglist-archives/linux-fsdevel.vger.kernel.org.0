Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B975FF44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjGXSsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXSsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7B10D8;
        Mon, 24 Jul 2023 11:48:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C5261351;
        Mon, 24 Jul 2023 18:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4ACC433C8;
        Mon, 24 Jul 2023 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690224528;
        bh=Qxe+0ETwxQWdTQEpO1yRVBgMBFqnkztn/GbWhWGGA/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YW3CUuL0abrttvR1K0iBuEF5JhiwpQ2d4i8SxV04HpBsiTNmgJK1WppPuosxQ/m6l
         B7cl+FqImBhESx19hkraQm0/gCa3n8rbimRseC8Uj1ksW5/DxUdNtfhnrmDEM+SNxU
         WNLV4pzKGicx95X5AiTQ0tvuDW7Sd7j8dtXiOPk+42luIYOsaHVqm2DaxqdBW58kMQ
         Bw0eOHUxsOyO5aLHHcCsdE0nSFcpapa+az9l9/soTwRIFlwUiQDjoYmkM+RwIpYM3y
         9eA8Kq2uvKGLYUjvHZlFx5HNokbOlRt9O/5i45SIPIFGrFC+5goWjB8OeuBiCqlZ7e
         bZHALog+y0XeQ==
Date:   Mon, 24 Jul 2023 20:48:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner>
 <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner>
 <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
 <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
 <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:27:29AM -0700, Linus Torvalds wrote:
> On Mon, 24 Jul 2023 at 11:05, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > io_uring never does that isn't the original user space creator task, or
> > from the io-wq workers that it may create. Those are _always_ normal
> > threads. There's no workqueue/kthread usage for IO or file
> > getting/putting/installing/removing etc.
> 
> That's what I thought. But Christian's comments about the io_uring
> getdents work made me worry.

Sorry, my point was that an earlier version of the patchset _would_ have
introduced a locking scheme that would've violated locking assumptions
because it didn't get the subtle refcount difference right. But that was
caught during review.

It's really just keeping in mind that refcount rules change depending on
whether fds or fixed files are used.

> 
> If io_uring does everything right, then the old "file_count(file) > 1"
> test in __fdget_pos() - now sadly removed - should work just fine for
> any io_uring directory handling.

Yes, but only if you disallow getdents with fixed files when the
reference count rules are different.

> 
> It may not be obvious when you look at just that test in a vacuum, but
> it happens after __fdget_pos() has done the
> 
>         unsigned long v = __fdget(fd);
>         struct file *file = (struct file *)(v & ~3);
> 
> and if it's a threaded app - where io_uring threads count the same -
> then the __fdget() in that sequence will have incremented the file
> count.
> 
> So when it then used to do that
> 
>                 if (file_count(file) > 1) {
> 
> that "> 1" included not just all the references from dup() etc,  but
> for any threaded use where we have multiple references to the file
> table it also that reference we get from __fdget() -> __fget() ->
> __fget_files() -> __fget_files_rcu() -> get_file_rcu() ->
> atomic_long_inc_not_zero(&(x)->f_count)).

Yes, for the regular system call path it's all well and dandy and I said
as much on the getdents thread as well.
