Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E40975FF07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGXS16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGXS1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:27:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F407AA6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:27:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso813775166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690223268; x=1690828068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hFsFnyl7tT3CvQE6TFTWwPvkx99KpTgqJ+hpUJ1OTjY=;
        b=YDEMgSzb9abFx8/eHJUihXwF+FMZV7mcJSJm7wlzZOsZttCR363cG7hHA1YW106/UT
         Nr07LqVy7KcKImwr0uzsIL4rc9w5x+54dxUbq+IXNMhX4k42OhH80oeBijTdKrJmzIeC
         oFZcQ2QwVWRH5DNvkho3nigJurAOXGE021em4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690223268; x=1690828068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFsFnyl7tT3CvQE6TFTWwPvkx99KpTgqJ+hpUJ1OTjY=;
        b=LEeR4l2Mke7vtTvJVCKdg1UgLw3qd7ClLhwABWjMcIIm/7OH+QlywH5Bm8cj2rNfMU
         PN/wpRlQDwD7TkyGZ580NRkp0RsYenKL3+OCSFy/gcYJslj4dtjCyLwicEx/FNUDVObp
         RLTQSX9KPCgjQwy1qm60VSYNh2U+1S9Baw3LDQE79Ij0ZJ9axtAga9dOpPqdVcAhSiL3
         JjpTGFje3K/t920i+gCsMr6EiylPT4SmsH8QpBnTaBvR5nEPfLx1a5BmydLd8iHpKGiX
         sB1oenI2qqQWmFq/e4VuYH+PZiNBslVLvujDfGVdWq+wwLZ7mQXfdLlVEpgASGy98g+C
         b6AA==
X-Gm-Message-State: ABy/qLadO0ZKnJdEhE5zZj84AhyFn3f/3KBv+a6r8sWQge4jVXYZju7P
        eWyzbMgKZy+aeqKDUxZzET9sMzAePbuL7eMUIcBRiMTN
X-Google-Smtp-Source: APBJJlG8skl5GvANmruxmAIpE7UTU3j8jtwjVOZ6zAGPGhyf50l4DhpihQKl6Bc4IlNgjRua4j4H+w==
X-Received: by 2002:a17:906:314c:b0:994:55ce:1630 with SMTP id e12-20020a170906314c00b0099455ce1630mr8864981eje.42.1690223268254;
        Mon, 24 Jul 2023 11:27:48 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id si1-20020a170906cec100b00992d70f8078sm7109357ejb.106.2023.07.24.11.27.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 11:27:47 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso6943372a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:27:46 -0700 (PDT)
X-Received: by 2002:a50:ef0b:0:b0:51d:d4c0:eea5 with SMTP id
 m11-20020a50ef0b000000b0051dd4c0eea5mr7690205eds.40.1690223266649; Mon, 24
 Jul 2023 11:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner> <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner> <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
In-Reply-To: <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 11:27:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
Message-ID: <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jul 2023 at 11:05, Jens Axboe <axboe@kernel.dk> wrote:
>
> io_uring never does that isn't the original user space creator task, or
> from the io-wq workers that it may create. Those are _always_ normal
> threads. There's no workqueue/kthread usage for IO or file
> getting/putting/installing/removing etc.

That's what I thought. But Christian's comments about the io_uring
getdents work made me worry.

If io_uring does everything right, then the old "file_count(file) > 1"
test in __fdget_pos() - now sadly removed - should work just fine for
any io_uring directory handling.

It may not be obvious when you look at just that test in a vacuum, but
it happens after __fdget_pos() has done the

        unsigned long v = __fdget(fd);
        struct file *file = (struct file *)(v & ~3);

and if it's a threaded app - where io_uring threads count the same -
then the __fdget() in that sequence will have incremented the file
count.

So when it then used to do that

                if (file_count(file) > 1) {

that "> 1" included not just all the references from dup() etc,  but
for any threaded use where we have multiple references to the file
table it also that reference we get from __fdget() -> __fget() ->
__fget_files() -> __fget_files_rcu() -> get_file_rcu() ->
atomic_long_inc_not_zero(&(x)->f_count)).

And yes, that's a fairly long chain, through some subtle code. Doing
"fdget()" (and variations) is not trivial.

Of course, with directory handling, one of the things people have
wanted is to have a "pread()" like model, where you have a position
that is given externally and not tied to the 'struct file'.

We don't have such a thing, and I don't think we can have one, because
I think filesystems also end up having possibly other private data in
the 'struct file' (trivially: the directory cursor for
dcache_dir_open()).

And other filesystems have it per-inode, which is why we have that
"iterate_shared" vs "iterate" horror.

So any dentry thing that wants to do things in parallel needs to open
their own private 'file' just for *that* reason. And even then they
will fail if the filesystem doesn't have that shared directory entry
iterator.

           Linus
