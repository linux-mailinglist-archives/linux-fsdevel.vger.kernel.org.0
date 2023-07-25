Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A22762155
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 20:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjGYSa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjGYSax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:30:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979E2126
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 11:30:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5221cf2bb8cso5306639a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690309850; x=1690914650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aHGpPoXTTKU95qTHzCpP6PWMEtmaqjLvANNO2417VQI=;
        b=I6HhDY/XSRKwTwElLogUEtVdnjY/ZjoJ3buHC+3GLvd03gIcEkv28rV0A/gISJtAZ1
         kSdpoIsigUE1zdN9mDmc3V1LX42U9AK9PDWGZ7OLQQyCiK6GERjm1bR5kfvVpUt4h78N
         Va3lq+HSztVwG63OdQZTYPpWdG6CXANqjqZd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690309850; x=1690914650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHGpPoXTTKU95qTHzCpP6PWMEtmaqjLvANNO2417VQI=;
        b=daS6OWc2Y8+OPRJWpEadbgK7ltLIWTcr9GcMfgcLw7bQtAK5TP+NWxNHVDkzpiih3c
         FSZGZeilWWnuoOx1hbsQji6eIsWO12VPvtl2FnRaCYU+tl3JwZpVaNG19rmPQcxDVb31
         vew7sd5eKK2dM16N2+XaYO9IpJQCTKFkmehKyhJgsoCKsTEhpywjMer8b20yhA37peZf
         SbajUgYyZS2KRS9klSJRwTCNlDo5De7IUoT0E7rWJ0OyJ6cBg6oS/ywczGxHHB3LxCA4
         agYNOsTJ/YrrbOuEXZyJL5tk7Rvm0HAFI/VUPI1Bakf5mw8ZG+O29WFKEV7KIVoXzEK3
         o/1g==
X-Gm-Message-State: ABy/qLYBY2f9mzdlMA6gNXWsr/oRsto2uhhcXOQWZxeLXnSa0z6YIEKb
        rxNGGYpadj4ktQSfpQh8jmKm5stNxFSOCscSN6KxterS
X-Google-Smtp-Source: APBJJlFfwhcELH4h66I446zfZy81Uq2pPvUXDISBLFuRdlL+wkFP/ZMQ9KN6so4pkLf0QrkGt/WKvQ==
X-Received: by 2002:aa7:c707:0:b0:50b:c630:a956 with SMTP id i7-20020aa7c707000000b0050bc630a956mr11758409edq.17.1690309850595;
        Tue, 25 Jul 2023 11:30:50 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id l1-20020a056402028100b0052229882fb0sm3924470edv.71.2023.07.25.11.30.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 11:30:50 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5222b917e0cso3772873a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 11:30:49 -0700 (PDT)
X-Received: by 2002:aa7:c390:0:b0:51b:e4b4:8bb0 with SMTP id
 k16-20020aa7c390000000b0051be4b48bb0mr11654096edq.2.1690309849617; Tue, 25
 Jul 2023 11:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner> <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner> <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk> <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner> <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
 <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk>
In-Reply-To: <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jul 2023 11:30:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
Message-ID: <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jul 2023 at 15:57, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/24/23 4:25?PM, Linus Torvalds wrote:
> > This sentence still worries me.
> >
> > Those fixed files had better have their own refcounts from being
> > fixed. So the rules really shouldn't change in any way what-so-ever.
> > So what exactly are you alluding to?
>
> They do, but they only have a single reference, which is what fixes them
> into the io_uring file table for fixed files. With the patch from the
> top of this thread, that should then be fine as we don't need to
> artificially elevator the ref count more than that.

No.

The patch from the top of this thread cannot *possibly* matter for a
io_uring fixed file.

The fdget_pos() always gets the file pointer from the file table. But
that means that it is guaranteed to have a refcount of at least one.

If io_uring fixed file holds a reference (and not holding a reference
would be a huge bug), that in turn means that the minimum refcount is
now two.

So the code in fdget_pos() is correct, with or without the patch.

The *only* problem is when something actually violates the refcounting
rules. Sadly, that's exactly what pidfd_getfd() does, and can
basically make a private file pointer be non-private without
synchronizing with the original owner of the fd.

Now, io_uring may have had its own problems, if it tried to
re-implement some io_uring-specific version of fdget_pos() for the
fixed file case, and thought that it could use the file_count() == 1
trick when it *wasn't* also a file table entry.

But that would be an independent bug from copy-and-pasting code
without taking the surrounding rules into account.

              Linus
