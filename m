Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07647623F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjGYUwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 16:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjGYUv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:51:59 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C50019A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 13:51:58 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6fdaf6eefso89521961fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690318316; x=1690923116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QLXs0GiWB5cOwyLmz4tntcCZDTMfvaNYieMiKwunvTQ=;
        b=DculfxQKCv4Nytw8FLwFiH6T9fxfPtXjWYJSt3cX0t3WP6EF7emTIFIMe9rZynjym4
         T0/OIQulCNy8OxWiT5SNPtODHN6OwrifJSIInxPt/JweWCCRPLFhKubIsNJa1P8NLKTg
         qOI7KhRhHLNrzUpRARVDhM70N5zNiXzkx1KBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318316; x=1690923116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLXs0GiWB5cOwyLmz4tntcCZDTMfvaNYieMiKwunvTQ=;
        b=MT6kFmKrJupwDKZlUKF65+IG0Cn1ZljDZl503P8FJfs+6ZsII5mZvJr072CD6hdUYg
         89Q8WnUE741xUbWzmWcyIyB7CPlKrUzIxj3LThCtlLKkzXaHabPl6eQ3gL7paHMNy112
         3JP6XUq92BJIn4Kp5/Dpn8VCWd2QJ/TNDH87elhGJkdDjXmnbAFCzM2IfVEg0xlD6qHI
         e7TwJCKF1CSwFMDJXsbiPUrltGZnOIdRkX00yLEnBuxMg6ELCOKOxelsMy/Vmx0PgeCe
         U/4k+DR1rYdTh6rIg726BfESia+tt20xVD3ryqTkwPqRvfJJrI17NJ3iaIOoaYBQHhZr
         JrwQ==
X-Gm-Message-State: ABy/qLZQYyORy7f9e9a47aBFU/KGt4NfHfEjsrwKlH3zJyq3rajzASvq
        vSedcEWCow8u5NnweH1d0Bh1R+bP4Qie/TgNrbGMqLza
X-Google-Smtp-Source: APBJJlGZxqhn5CMvw+26b+2fp1sUve/tlwZ9OphkHeCtY9Kx5uwPe6BG5dX4brRXvrP6lD5NsE1maQ==
X-Received: by 2002:a2e:99d9:0:b0:2b6:a7dd:e22 with SMTP id l25-20020a2e99d9000000b002b6a7dd0e22mr9206341ljj.48.1690318316393;
        Tue, 25 Jul 2023 13:51:56 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y23-20020a2e9797000000b002b6a930b8b0sm3719735lji.73.2023.07.25.13.51.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:51:55 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fde022de07so8237274e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 13:51:55 -0700 (PDT)
X-Received: by 2002:a05:6512:2522:b0:4f8:7803:64e6 with SMTP id
 be34-20020a056512252200b004f8780364e6mr16940lfb.41.1690318314788; Tue, 25 Jul
 2023 13:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner> <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner> <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk> <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner> <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
 <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk> <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
 <8d1069bf-4c0b-22be-e4c4-5f2b1eb1f7e8@kernel.dk>
In-Reply-To: <8d1069bf-4c0b-22be-e4c4-5f2b1eb1f7e8@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jul 2023 13:51:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMEd2J5otKf76zuO831sXi4OtgyBTozq_wE43q92=EiQ@mail.gmail.com>
Message-ID: <CAHk-=whMEd2J5otKf76zuO831sXi4OtgyBTozq_wE43q92=EiQ@mail.gmail.com>
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

On Tue, 25 Jul 2023 at 13:41, Jens Axboe <axboe@kernel.dk> wrote:
>
> Right, but what if the original app closes the file descriptor? Now you
> have the io_uring file table still holding a reference to it, but it'd
> just be 1. Which is enough to keep it alive, but you can still have
> multiple IOs inflight against this file.

Note that fdget_pos() fundamentally only works on file descriptors
that are there - it's literally looking them up in the file table as
it goes along. And it looks at the count of the file description as it
is looked up. So that refcount is guaranteed to exist.

If the file has been closed, fdget_pos() will just fail because it
doesn't find it.

And if it's then closed *afterwards*, that's fine and doesn't affect
anything, because the locking has been done and we saved away the
status bit as FDPUT_POS_UNLOCK, so the code knows to unlock even if
the file descriptor in the meantime has turned back to having just a
single refcount.

     Linus
