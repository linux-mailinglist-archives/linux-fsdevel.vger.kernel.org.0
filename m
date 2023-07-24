Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CFD75FDD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGXRex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGXRew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:34:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99F188
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:34:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so7042243e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690220089; x=1690824889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vSeNUZn0VMlhUmialM4MIBW/h43PVFZlS7oEOOQOqx4=;
        b=XdSr9LGZClbxPbKTuwSdpoboFjVlRwf0hQP/j7hsngd6GHcpynZA09vYpe+GwoRW1J
         DOuBTg3YM/58HBfrRhe8gFIcwMy0fymqJK8F0SE8nAKnXerXusm2uTvehqllGzMx26Kf
         BYD4IYFMcweltf8p7MoTlrWKxQlqTXOsGefTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690220089; x=1690824889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSeNUZn0VMlhUmialM4MIBW/h43PVFZlS7oEOOQOqx4=;
        b=bpmc1HvG8+IaOfTYnAW2BMhFhPitdcyURTBCOivjqhWf0+1aknfdEdOz4fG26eSHbK
         77BUaUxk7s00p1gcGxo0yLBAuXJ6YPdSahocq8xVAXJkETgONXG3p6bigTiyOco45MAL
         X1rQsN7XawV9U4MOYHzS320zn9Q6+i/WNDm94H0MSOJmbAI4XcLfUIR1p8qHZpKdpP30
         R8Vg6N2UWJqrX86IuHT7gIoFd5vE4/uOPCAmVS7NlTUOyJSlf9hNc55wCimoIpt4MBUy
         chWW5vWOnJP0vVri3i4aMLlEW/JdmCEScsidQrN4h16HA8IDnGLmsT0PojzoCthYMh+3
         r+DQ==
X-Gm-Message-State: ABy/qLbIjs9TwkOHBwzekV7Nd3ZkfxQKkZmZGGD8omssYgAXqPvLHZB1
        SwH/Y1qSzpxd9GNESYrpr+pxZ3RUB4Z0yrJGihXnMkGW
X-Google-Smtp-Source: APBJJlFOAN119EaL9q+Cu7fBIruUr5dSR5AtZZ3ky1CgQ8COW/CRG6VYRKCEZ0bJeBG0QQa5hdaW1w==
X-Received: by 2002:ac2:5bc7:0:b0:4fb:7392:c72c with SMTP id u7-20020ac25bc7000000b004fb7392c72cmr5081703lfn.57.1690220089342;
        Mon, 24 Jul 2023 10:34:49 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v9-20020ac25929000000b004fb326d4ff0sm2289814lfi.77.2023.07.24.10.34.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 10:34:48 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so7045250e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:34:48 -0700 (PDT)
X-Received: by 2002:a05:6512:b96:b0:4fd:c23b:959d with SMTP id
 b22-20020a0565120b9600b004fdc23b959dmr8461441lfv.34.1690220088417; Mon, 24
 Jul 2023 10:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner>
In-Reply-To: <20230724-gebessert-wortwahl-195daecce8f0@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 10:34:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
Message-ID: <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jul 2023 at 10:23, Christian Brauner <brauner@kernel.org> wrote:
>
> This means pidfd_getfd() needs the same treatment as MSG_PEEK for sockets.

So the reason I think pidfd_getfd() is ok is that it has serialized
with the source of the file descriptor and uses fget_task() ->
__fget_files.

And that code is nasty and complicated, but it does get_file_rcu() to
increment the file count, and then *after* that it still checks that
yes, the file pointer is still there.

And that means that anybody who uses fget_task() will only ever get a
ref to a file if that file still existed in the source, and you can
never have a situation where a file comes back to life.

The reason MSG_PEEK is special is exactly because it can "resurrect" a
file that was closed, and added to the unix SCM garbage collection
list as "only has a ref in the SCM thing", so when we then make it
live again, it needs that very very subtle thing.

So pidfd_getfd() is ok in this regard.

But it *is* an example of how subtle it is to just get a new ref to an
existing file.

That whole

         if (atomic_read_acquire(&files->count) == 1) {

in __fget_light() is also worth being aware of. It isn't about the
file count, but it is about "I have exclusive access to the file
table". So you can *not* close a file, or open a file, for another
process from outside. The only thread that is allowed to access or
change the file table (including resizing it), is the thread itself.

I really hope we don't have cases of that.

             Linus
