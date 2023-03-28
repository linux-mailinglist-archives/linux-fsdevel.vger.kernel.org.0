Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA84F6CCA7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjC1TRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 15:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjC1TRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:17:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA030FF
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:17:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so53890336edb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680031024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vm1VqZUWtkJ38uebeausfTvsxID+l11PQ35yQ5LqQq0=;
        b=KZXYrMniq9cU/mZMnPE/ulQ8B/yPayVVxHQxyZMwEiXJhBCPY77FqstOunUeYNNmms
         QFxq4zfMPoyXLB+xXMNnH0OkqdwRNGBFE4NBMMfpftd92krETEdeslENJFszdrOUGK8a
         X15OaBPNPyOWI8GEUGVFruAfs1jDitF8ExSmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vm1VqZUWtkJ38uebeausfTvsxID+l11PQ35yQ5LqQq0=;
        b=rWt2sJXJQ4YUjwgn6lyRFNG6wvZrPIVqf3gxJLPlF+DF13BmvbXjud0w3NJMwdj4Hu
         KAhqrPh6OKEyiKxk8nmp2bZvTYs0A21k5gDidjHF85YXanQaXCy8mZb5A2g6sS6QhhFS
         PadbZ/nrXMJjXu3x09EvWxvYjuAWt24zoJnx0vrrahLa8zgxOF9DPhRt4Yq2rmyW1YB5
         QzsHtWvZTXG9vUlwh+jMHwtCDK9EWwl35EQIJzWEYcnycEvl1exYq8PSS/HIjvRsAjdp
         Ksfbm6Hn0ntU1WLmiTBgEvfE47wEqv0Cp9y/etqZCFhDGIYSyo/SdrlycYZ0xQnqkSTm
         GYnA==
X-Gm-Message-State: AAQBX9d3RYrZ8q6B097S1fTCvuSlfuHswAdurafY684O8R8f9u1xk7b8
        9TgzXvbWekPjv9y3J+TLJGS1m/lIodMKKXm59gsaAg==
X-Google-Smtp-Source: AKy350ZhyRhahWeEjdRXlcENPgrLKGwgQjKl9vVlqy709F/Oc8x3Nechpg6JkrTlom1SvSyFBHzr+g==
X-Received: by 2002:a17:906:385b:b0:930:d552:5c23 with SMTP id w27-20020a170906385b00b00930d5525c23mr15261412ejc.56.1680031024168;
        Tue, 28 Mar 2023 12:17:04 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id kg2-20020a17090776e200b009334219656dsm13829549ejc.56.2023.03.28.12.17.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 12:17:03 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id r11so53988493edd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:17:03 -0700 (PDT)
X-Received: by 2002:a17:907:2c66:b0:931:faf0:3db1 with SMTP id
 ib6-20020a1709072c6600b00931faf03db1mr12358943ejc.4.1680031023202; Tue, 28
 Mar 2023 12:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173613.555192-1-axboe@kernel.dk> <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
 <ZCM4KsKa3xQR2IOv@casper.infradead.org> <CAHk-=wgxYOFJ-95gPk9uo1B6mTd0hx1oyybCuQKnfWD1yP=kjw@mail.gmail.com>
In-Reply-To: <CAHk-=wgxYOFJ-95gPk9uo1B6mTd0hx1oyybCuQKnfWD1yP=kjw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Mar 2023 12:16:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggKW9VQSUzGGpC9Rq3HYiEEsFM3cn2cvAJsUBbU=zEzA@mail.gmail.com>
Message-ID: <CAHk-=wggKW9VQSUzGGpC9Rq3HYiEEsFM3cn2cvAJsUBbU=zEzA@mail.gmail.com>
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF iov_iter
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:05=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But it's not like adding a 'struct iovec' explicitly to the members
> just as extra "code documentation" would be wrong.
>
> I don't think it really helps, though, since you have to have that
> other explicit structure there anyway to get the member names right.

Actually, thinking a bit more about it, adding a

    const struct iovec xyzzy;

member might be a good idea just to avoid a cast. Then that
iter_ubuf_to_iov() macro becomes just

   #define iter_ubuf_to_iov(iter) (&(iter)->xyzzy)

and that looks much nicer (plus still acts kind of as a "code comment"
to clarify things).

                Linus
