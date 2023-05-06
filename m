Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280DF6F92B4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjEFP2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjEFP2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 11:28:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890151AED6
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 08:27:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so35885480a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683386876; x=1685978876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ+BiRzn20Hnf7yT5l2P5uHgKRHU8zL2d2lFy4380qU=;
        b=aHqoWbUrjdhO0y/0ZVV6cUmC8R1pIO7r71UXID9+vQeDSxTdrDC3KQ+EcXpCHXDyBZ
         qiElfPFZwsHVPOkGUc7Dj0sXovdAn01QXiFo0mx4ABcsGaGtbG0HQ6h7qx1JvnW0secw
         2ZfJLKaiNfrOZNnxGZ27wHwsuafQFTFhSGnEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683386876; x=1685978876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ+BiRzn20Hnf7yT5l2P5uHgKRHU8zL2d2lFy4380qU=;
        b=Q0VeyM4JG2fE3HKqBzhkueFWQ2C9SPDShuvtGam/sO+Ddx1xbA7Q1+9QJJ5M9qysxe
         MyiWfjrtwBPLqJGpDxErtmid2v78hQ+zfExV8vb4wKL86gMnme7vkR0xIqAVOXvqcMu7
         SDsepypZIqNktGGrfqaJSzaAXeGlZWZtnAVIRkY3WiQQmwW2gUjRpucqsxtpSvSyjYHr
         a3s8v7b952m0PM9vVY/icaYqgLOpsloBxWe+fvQo9GllPz0X0EMPHUdS6h8mitVeyjn2
         GcwtB1zCr0py6nok53ekb+fh3DQ4Ma9uYLxoVLPD+rAIIOc8gg8kGRyE/taWHNUx4KEY
         vRYw==
X-Gm-Message-State: AC+VfDzik9HWM7SelEOO2ro6z1znvqotiP+FVrzeiY+tDHmNIBkTwC4T
        F2GpiTAWH1hO0xN/kun1ANolvxI9Pm5HywU7iGEQOg==
X-Google-Smtp-Source: ACHHUZ6mPKOeYh9JdKz3HSVVvVw3j/0QGxgrtNec2IUc3fWta0T2ytbDLO7NvKKouyQmnslLSDxd5Q==
X-Received: by 2002:a17:907:1622:b0:965:aa65:233f with SMTP id hb34-20020a170907162200b00965aa65233fmr4755285ejc.2.1683386876649;
        Sat, 06 May 2023 08:27:56 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id jl3-20020a17090775c300b009655eb8be26sm2476276ejc.73.2023.05.06.08.27.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 08:27:56 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so35885353a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 08:27:56 -0700 (PDT)
X-Received: by 2002:a17:907:9306:b0:932:f88c:c2ff with SMTP id
 bu6-20020a170907930600b00932f88cc2ffmr4529244ejc.34.1683386875820; Sat, 06
 May 2023 08:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
In-Reply-To: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 08:27:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=LwLDYrjHpMM+QnE2T+u4P9-UXhXGkAMXiyfGjGnNEA@mail.gmail.com>
Message-ID: <CAHk-=wj=LwLDYrjHpMM+QnE2T+u4P9-UXhXGkAMXiyfGjGnNEA@mail.gmail.com>
Subject: Re: [GIT PULL] Pipe FMODE_NOWAIT support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 6, 2023 at 3:33=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> Here's the revised edition of the FMODE_NOWAIT support for pipes, in
> which we just flag it as such supporting FMODE_NOWAIT unconditionally,
> but clear it if we ever end up using splice/vmsplice on the pipe. The
> pipe read/write side is perfectly fine for nonblocking IO, however
> splice and vmsplice can potentially wait for IO with the pipe lock held.

Ok, pulled.

It does strike me that one of the (few) users is the io_uring
__io_file_supports_nowait() thing, and that thing is *disgusting*.

Wouldn't it be much nicer if FMODE_NOWAIT ended up working
automatically on a block file descriptor too? You did all this "make
pipes set FMODE_NOWAIT", but then that io_uring code does

        if (S_ISBLK(mode)) {
                if (IS_ENABLED(CONFIG_BLOCK) &&
                    io_bdev_nowait(I_BDEV(file->f_mapping->host)))
                        return true;
                return false;
        }

rather than just rely on FMODE_NOWAIT for block devices too...

And it's a bit odd in other ways, because the kiocb code for
RWF_NOWAIT - which is the other user of FMODE_NOWAIT - does *not* seem
to do any of those bdev games. So that other user does seem to just
rely on the file mode bit having been set up by open.

In fact, I see 'blkdev_open()' doing

        filp->f_mode |=3D FMODE_NOWAIT | FMODE_BUF_RASYNC;

so I really don't see why __io_file_supports_nowait() then does that
special check for S_ISBLK().

Something is very rotten in the state of Denmark.

But that's all independent of this pipe side, which now looks fine to me.

              Linus
